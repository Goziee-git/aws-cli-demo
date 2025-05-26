import time

def cpu_spike(duration=5):
    print("Spiking CPU...")
    end = time.time() + duration
    while time.time() < end:
        [x**2 for x in range(10_000)]  # heavy computation
    print("CPU spike ended.")

if __name__ == "__main__":
    cpu_spike()
