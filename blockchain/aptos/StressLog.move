module 0xDEADBEEF::stress_log {
    use std::signer;
    use std::vector;

    struct StressData has key { values: vector<u64> }

    public entry fun init(account: &signer) {
        let v = vector::empty<u64>();
        move_to(account, StressData { values: v });
    }

    public entry fun add(account: &signer, value: u64) {
        let addr = signer::address_of(account);
        let data = borrow_global_mut<StressData>(addr);
        vector::push_back(&mut data.values, value);
    }
}