#![no_std]
#![no_main]

use embassy_executor::Spawner;
use embassy_time::{Duration, Timer};
use esp_backtrace as _;
use esp_hal::clock::CpuClock;
use esp_hal::time::Instant;
use esp_hal::timer::systimer::SystemTimer;
use embedded_hal::delay::DelayNs;
use esp_hal::delay::Delay;
use esp_println::println;

// Add app descriptor, needed for newer (v5.4+) IDF bootloaders provided by espflash
// https://github.com/esp-rs/espflash/issues/870#issuecomment-2917074263
esp_bootloader_esp_idf::esp_app_desc!();

#[esp_hal_embassy::main]
async fn main(spawner: Spawner) {
    let config = esp_hal::Config::default().with_cpu_clock(CpuClock::max());
    let peripherals = esp_hal::init(config);

    let timer0 = SystemTimer::new(peripherals.SYSTIMER);
    esp_hal_embassy::init(timer0.alarm0);

    println!("Hello QEMU from embassy!");

    let mut t0 = Instant::now();
    let mut t1 = Instant::now();

    loop {
        t1 = Instant::now();
        println!("time: {}, (+{}s)",t1,(t1-t0).as_secs());
        
        // This will correctly result in PRINTED 1 second delays,
        // which will have a different 'wall clock' delay depending on the QEMU speed.
        let mut delay = Delay::new();
        delay.delay_ms(1000 as u32);
        
        // Async embassy delays use RTC peripheral which I don't think is implimented yet! 
        // So this just hangs!
        //Timer::after(Duration::from_millis(1000)).await;
        
        // This strangely seems to operate at about 10x the speed of a regular delay???
        // What??? Where does Instant::now() come from? What is the deal here.
        //loop {
        //  t1 = Instant::now();
        //  if (t1 - t0).as_millis() >= 1000 {
        //    t0 = t1;
        //    break;
        //  }
        //}
    }
}
