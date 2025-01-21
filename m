Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48520A1784A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Jan 2025 08:07:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8JW-0006eC-N5; Tue, 21 Jan 2025 02:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8JT-0006dP-5C; Tue, 21 Jan 2025 02:04:39 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8JQ-0001Q8-GJ; Tue, 21 Jan 2025 02:04:38 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:24 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:24 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 00/18] Support AST2700 A1
Date: Tue, 21 Jan 2025 15:04:06 +0800
Message-ID: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

v1:
 1. Refactor INTC model to support both INTC0 and INTC1.
 2. Support AST2700 A1.
 3. Create ast2700a0-evb machine.
 
With the patch applied, QEMU now supports two machines for running AST2700 SoCs:
ast2700a0-evb: Designed for AST2700 A0
ast2700-evb: Designed for AST2700 A1

Test information
1. QEMU version: https://github.com/qemu/qemu/commit/d6430c17d7113d3c38480dc34e59d00b0504e2f7
2. This patch series depends on the following patch series
   https://patchwork.kernel.org/project/qemu-devel/cover/20250113064455.1660564-1-jamin_lin@aspeedtech.com/
   https://patchwork.kernel.org/project/qemu-devel/cover/20241114094839.4128404-1-jamin_lin@aspeedtech.com/
3. ASPEED SDK v09.05 pre-built image
   https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.05
   ast2700-default-obmc.tar.gz (A1)
   https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz

Known Issue:
The HACE crypto and hash engine is enable by default since AST2700 A1.
However, aspeed_hace.c(HACE model) currently does not support the CRYPTO command.
To boot AST2700 A1, I have created a Patch 18 which temporarily resolves the
issue by sending an interrupt to notify the firmware that the cryptographic
command has completed. It is a temporary workaround to resolve the boot issue
in the Crypto Manager SelfTest.

As a result, you will encounter the following kernel warning due to the
Crypto Manager test failure. If you don't want to see these kernel warning,
please add the following settings in your kernel config.

```
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
```

```
alg: skcipher: aspeed-ctr-tdes encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
[    5.035966] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
[    5.036139] ------------[ cut here ]------------
[    5.037188] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
[    5.037312] WARNING: CPU: 2 PID: 109 at /crypto/testmgr.c:5936 alg_test+0x42c/0x548
[    5.038049] Modules linked in:
[    5.038302] CPU: 2 PID: 109 Comm: cryptomgr_test Tainted: G        W          6.6.52-v00.06.04-gf52a0cf7c475 #1
[    5.038787] Hardware name: AST2700-EVB (DT)
[    5.038988] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.039315] pc : alg_test+0x42c/0x548
[    5.039505] lr : alg_test+0x42c/0x548
[    5.039697] sp : ffffffc0825e3d50
[    5.039862] x29: ffffffc0825e3df0 x28: 0000000000000004 x27: 0000000000000000
[    5.040226] x26: ffffffc080bcada0 x25: ffffffc081dac9d0 x24: 0000000000000004
[    5.040700] x23: 0000000000001285 x22: ffffff8003ded280 x21: ffffff8003ded200
[    5.041458] x20: 00000000ffffffff x19: 00000000ffffffea x18: ffffffffffffffff
[    5.041915] x17: 282064656c696166 x16: 20736564742d7274 x15: 00000000fffffffe
[    5.042287] x14: 0000000000000000 x13: ffffffc081ba555c x12: 65742d666c657320
[    5.042684] x11: 00000000fffeffff x10: ffffffc0818ff048 x9 : ffffffc0800a36e4
[    5.043077] x8 : 000000000017ffe8 x7 : c0000000fffeffff x6 : 000000000057ffa8
[    5.043461] x5 : 000000000000ffff x4 : 0000000000000000 x3 : 0000000000000000
[    5.043751] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff800415e740
[    5.045544] Call trace:
[    5.045693]  alg_test+0x42c/0x548
[    5.045878]  cryptomgr_test+0x28/0x48
[    5.046052]  kthread+0x114/0x120
[    5.046226]  ret_from_fork+0x10/0x20
[    5.046413] ---[ end trace 0000000000000000 ]---
[    5.071510] alg: skcipher: aspeed-ctr-des encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
[    5.072145] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
```


Jamin Lin (18):
  hw/intc/aspeed: Rename INTC to INTC0
  hw/intc/aspeed: Support different memory region ops
  hw/intc/aspeed: Introduce a new aspeed_2700_intc0_ops for INTC0
  hw/intc/aspeed: Support setting different memory and register size
  hw/intc/aspeed: Introduce helper functions for enable and status
    registers
  hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq
    index and register address
  hw/intc/aspeed: Introduce IRQ handler function to reduce code
    duplication
  hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
  hw/intc/aspeed: Add ID to trace events for better debugging
  hw/intc/aspeed: Add Support for AST2700 INTC1 Controller
  hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon
    Revisions
  hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for
    AST2700 A1
  hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0
  hw/arm/aspeed: Add SoC and Machine Support for AST2700 A1
  hw/misc/aspeed_hace: Fix coding style
  hw/misc/aspeed_hace: Add AST2700 support
  hw/arm/aspeed_ast27x0: Add HACE support for AST2700
  hw/misc/aspeed_hace: (DROP) Fix boot issue in the Crypto Manager Self
    Test(WORKAROUND)

 hw/arm/aspeed.c               |  26 +-
 hw/arm/aspeed_ast27x0.c       | 229 +++++++++--
 hw/intc/aspeed_intc.c         | 689 +++++++++++++++++++++++++---------
 hw/intc/trace-events          |  25 +-
 hw/misc/aspeed_hace.c         |  44 ++-
 hw/misc/aspeed_scu.c          |   3 +
 include/hw/arm/aspeed_soc.h   |   5 +-
 include/hw/intc/aspeed_intc.h |  35 +-
 include/hw/misc/aspeed_hace.h |   1 +
 include/hw/misc/aspeed_scu.h  |   2 +
 10 files changed, 817 insertions(+), 242 deletions(-)

-- 
2.34.1


