#![no_std]
#![no_main]

use embassy_executor::Spawner;
use embedded_hal::delay::DelayNs;
use esp_backtrace as _;
use esp_hal::clock::CpuClock;
use esp_hal::delay::Delay;
use esp_hal::time::Instant;
use esp_hal::timer::systimer::SystemTimer;
use esp_println::println;

// Add app descriptor, needed for newer (v5.4+) IDF bootloaders provided by espflash
// https://github.com/esp-rs/espflash/issues/870#issuecomment-2917074263
esp_bootloader_esp_idf::esp_app_desc!();

#[esp_hal_embassy::main]
async fn main(_spawner: Spawner) {
    let config = esp_hal::Config::default().with_cpu_clock(CpuClock::max());
    let peripherals = esp_hal::init(config);

    let timer0 = SystemTimer::new(peripherals.SYSTIMER);
    esp_hal_embassy::init(timer0.alarm0);

    println!("Hello QEMU from embassy!");

    let t0 = Instant::now();
    let mut c = 0;

    loop {
        let t1 = Instant::now();
        println!("loop: {}, time: {}, (+{}s)", c, t1, (t1 - t0).as_secs());
        c += 1;

        // This will correctly result in PRINTED 1 second delays,
        // which will have a different 'wall clock' delay depending on the QEMU speed.
        let mut delay = Delay::new();
        delay.delay_ms(1000 as u32);
    }
}
