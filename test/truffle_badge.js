const TruffleBadge = artifacts.require("TruffleBadge");
const { reverts } = require("truffle-assertions");

contract("TruffleBadge", function(accounts) {
    
  let badge;
  beforeEach(async () => {
    badge = await TruffleBadge.new();
  });

  describe("Creation", () => {
    it("should award badge", async () => {
      const meta = "META";
      await badge.awardBadge(accounts[1], meta);
      assert.equal(
        await badge.balanceOf(accounts[1]),
        1
      );

      await badge.awardBadge(accounts[2], meta);
    });

    it("should only allow 1 badge to be awarded", async () => {
      const meta = "META";
      const account = accounts[1];

      await badge.awardBadge(account, meta);

      await reverts(
        badge.awardBadge(account, meta),
        "Only one badge can be awarded per account."
      );
    });
  });

  describe("Removal", () => {
    it("should remove badge", async () => {
      const meta = "META";
      const account = accounts[1];
      await badge.awardBadge(account, meta);
      await badge.removeBadge(account);
      assert.equal(await badge.balanceOf(account), 0);
    });
  });
});