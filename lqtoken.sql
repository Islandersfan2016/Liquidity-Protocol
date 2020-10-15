function tick(bool sync) public {
  uint _current = block.number;
  uint _diff = _current.sub(lastTick;

  if (_diff >0) {
    lastTic = _current;

    _diff = balance[address(pool)].mul(_diff).div(700000); // 1% every 7000 blocks
    uint _minting =_diff.div(2);
    if (_minting > 0) {
        _transferTokens(address(pool), address(this), _minting);

        // Can't call sync while in addLiquidity or removeLiquidity
        if(sync) {
          pool.sync();
        }
        _mint(address (this), _minting, false);
        // % of tokens that go to LPs
        Uint _lp = _diff.mul(7500).div(10000);
        allowances[address (this)][address(rewardDistribution)] = _lp;
        rewardDistribution.notifyRewardAmount(_lp);

        emit Tick(_current, _diff);
    }
  }
}
