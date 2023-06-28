Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2007E741049
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETbq-0002By-OF; Wed, 28 Jun 2023 07:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbo-0002BV-J1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:16 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbm-00050v-R8
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iJ0TupqAyekoEn7Y3+GxgLMIkvwoFdKjSq8h4jFbw2w=; b=g7PtQtia7DAgquwgbB5vQrzlNq
 dQf9c0Q6s5mvIHVIMD1xTcPwuyFDHezEYAi92Dn5XOvvNep2Oysk/dXGI0PXBdi1i0xO7pEZR5oxl
 97rbNsNXB666bIgLJ4Ju/zzufgVdvynHuY/x2MOj0dY8H80iQxbP3LaGIhJFT6UWTZGrW6jgAUzvr
 n5/kPNQKKfF3cLKCPycZ/EDoPUUxnbKNAglOcjRiiLy+M+t4tftQhaqlCFqllZ2tHyzjDGDutzKi2
 OwMiecD/fHhnnuxYg1LnIlz70CUI+m9JY1gPllhBlPsU8ehFS8ztltNQTUzjRWJdWJu9u2y5bbE0o
 6zrF8+RAwezt97bPHPZPHn9U0mfl2hZLzn3G0FV8uFqski/AppXn3LEpLrzSTFeEMLM7fuPzNlZ3N
 gKp2SJhhQWSd3T80AkNorCrIJXS7RRCZXs/8vG+jgujprjJLLJ2BZfSV5W3wUS1OdsxJISSdMmH3l
 8RHE81+WjkukqWt5ULRv3p+LMfvvJFkQOqiBB3BX4YSi6hIe6S1SBzuyARDKri6uhP9OIy99oVKrz
 GQPDrNU4Wg2J4Yfxu/rgAWQLckMd0XUSWxak1Ju/BREsREXRO7joeMoitUVuBCDQ64tSM8LSLo4gd
 h2m/RPWUIkp2cjTp8w1Dz2nFz0rB4ujYeFoA6oWmw=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbW-00007c-UJ; Wed, 28 Jun 2023 12:45:02 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:44:54 +0100
Message-Id: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 00/10] qemu-sparc queue 20230628
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following changes since commit b111569da9f82fdf05df03184836a4564adef599:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-06-28 08:42:32 +0200)

are available in the Git repository at:

  https://github.com/mcayland/qemu.git tags/qemu-sparc-20230628

for you to fetch changes up to 6b90a4cdc04ec7ca94c3f664d63ee43c2046a875:

  escc: emulate dip switch language layout settings on SUN keyboard (2023-06-28 10:54:25 +0100)

----------------------------------------------------------------
qemu-sparc queue

- This contains the target/sparc updates to use tcg_gen_lookup_and_goto_ptr
  along with a fix for the sun4v niagara machine, and a patch to allow
  the keyboard language layout to be set on a SUN keyboard

Please pull, many thanks!

----------------------------------------------------------------
Henrik Carlqvist (1):
      escc: emulate dip switch language layout settings on SUN keyboard

Markus Armbruster (1):
      Revert "hw/sparc64/niagara: Use blk_name() instead of open-coding it"

Richard Henderson (8):
      target/sparc: Use tcg_gen_lookup_and_goto_ptr in gen_goto_tb
      target/sparc: Fix npc comparison in sparc_tr_insn_start
      target/sparc: Drop inline markers from translate.c
      target/sparc: Introduce DYNAMIC_PC_LOOKUP
      target/sparc: Use DYNAMIC_PC_LOOKUP for conditional branches
      target/sparc: Use DYNAMIC_PC_LOOKUP for JMPL
      target/sparc: Use DYNAMIC_PC_LOOKUP for v9 RETURN
      target/sparc: Use tcg_gen_lookup_and_goto_ptr for v9 WRASI

 docs/system/device-emulation.rst |   1 +
 docs/system/devices/keyboard.rst | 129 +++++++++++++
 docs/system/target-sparc.rst     |   2 +-
 hw/char/escc.c                   |  79 +++++++-
 hw/sparc64/niagara.c             |   6 +-
 include/hw/char/escc.h           |   1 +
 target/sparc/translate.c         | 402 ++++++++++++++++++++++-----------------
 7 files changed, 439 insertions(+), 181 deletions(-)
 create mode 100644 docs/system/devices/keyboard.rst

