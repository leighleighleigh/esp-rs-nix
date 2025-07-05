#![no_std]
#![no_main]

use embassy_executor::Spawner;
use embassy_time::{Duration, Timer};
use esp_backtrace as _;
use esp_hal::clock::CpuClock;
use esp_hal::time::Instant;
use esp_hal::timer::systimer::SystemTimer;
use esp_println::println;

// Add app descriptor, needed for newer (v5.4+) IDF bootloaders provided by espflash
// https://github.com/esp-rs/espflash/issues/870#issuecomment-2917074263
esp_bootloader_esp_idf::esp_app_desc!();

#[esp_hal_embassy::main]
async fn main(spawner: Spawner) {
    let config = esp_hal::Config::default().with_cpu_clock(CpuClock::max());
    let peripherals = esp_hal::init(config);

    println!("Hello QEMU from embassy!");

    let timer0 = SystemTimer::new(peripherals.SYSTIMER);
    esp_hal_embassy::init(timer0.alarm0);

    //// TODO: Spawn some tasks
    //let _ = spawner;

    //loop {
    //    Timer::after(Duration::from_secs(1)).await;
    //    println!("Loop time: {}", Instant::now());
    //}
}
