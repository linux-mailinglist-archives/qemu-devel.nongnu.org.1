Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AD759BBF
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 19:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMAVu-00023U-BK; Wed, 19 Jul 2023 12:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qMAVq-00023F-5i
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 12:58:54 -0400
Received: from bg4.exmail.qq.com ([43.155.67.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng@tinylab.org>) id 1qMAVl-0001Y3-Kh
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 12:58:53 -0400
X-QQ-mid: bizesmtp83t1689785898t3zo7y9k
Received: from ubuntu.. ( [111.196.130.174]) by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 20 Jul 2023 00:58:17 +0800 (CST)
X-QQ-SSF: 01200000000000F0H000000A0000000
X-QQ-FEAT: 7jw2iSiCazpSswdoSjaRl9LYON17boKWDPW2MU6w3bHyaBWQa4tyzGY3XeA6A
 eHKIYWYyLRrNtiL+oEnZJZ/GVYoodYtVjTIBtMc+NMr7ykYk8llq7v95C7OAhntAvmczscp
 CXJlc9kYPjMizA87w/Zl44ZTs6K/5QhRmtK/HFKiNNZeI1KIUdegCjYpnIIFL+4FEnzy1EH
 Apil8lUb3IcmYuzDaaWKPKL0B9/u1/xmy9baABRAyW1ZZHUrUyB7RJfU25KF9TXJCORkrF+
 L4lOAafwZdi++sVqV1v7AjAmeBFj7xhCkRIX3/AbKYYNs2wo77/DM5XKyiyDONj9UUalbxa
 w7DuLyLp/AyQxiUk+0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3018158967273055613
From: Bin Meng <bmeng@tinylab.org>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Subject: [PATCH] roms/opensbi: Upgrade from v1.3 to v1.3.1
Date: Thu, 20 Jul 2023 00:58:17 +0800
Message-Id: <20230719165817.889465-1-bmeng@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz7a-0
Received-SPF: pass client-ip=43.155.67.158; envelope-from=bmeng@tinylab.org;
 helo=bg4.exmail.qq.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Upgrade OpenSBI from v1.3 to v1.3.1 and the pre-built bios images
which fixes the boot failure seen when using QEMU to do a direct
kernel boot with Microchip Icicle Kit board machine.

The v1.3.1 release includes the following commits:

0907de3 lib: sbi: fix comment indent
eb736a5 lib: sbi_pmu: Avoid out of bounds access
7828eeb gpio/desginware: add Synopsys DesignWare APB GPIO support
c6a3573 lib: utils: Fix sbi_hartid_to_scratch() usage in ACLINT drivers
057eb10 lib: utils/gpio: Fix RV32 compile error for designware GPIO driver

Signed-off-by: Bin Meng <bmeng@tinylab.org>

---
Please pull the complete patch from https://github.com/lbmeng/qemu
opensbi branch.

 .../opensbi-riscv32-generic-fw_dynamic.bin    | Bin 135344 -> 135376 bytes
 .../opensbi-riscv64-generic-fw_dynamic.bin    | Bin 138304 -> 138368 bytes
 roms/opensbi                                  |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin
index 7b6c67e0ae..9a2ba3f2a4 100644
Binary files a/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv32-generic-fw_dynamic.bin differ
diff --git a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin
index 1b831b412c..5d4e812819 100644
Binary files a/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin and b/pc-bios/opensbi-riscv64-generic-fw_dynamic.bin differ
diff --git a/roms/opensbi b/roms/opensbi
index 2552799a1d..057eb10b6d 160000
--- a/roms/opensbi
+++ b/roms/opensbi
@@ -1 +1 @@
-Subproject commit 2552799a1df30a3dcd2321a8b75d61d06f5fb9fc
+Subproject commit 057eb10b6d523540012e6947d5c9f63e95244e94
-- 
2.34.1


