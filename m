Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7137CCBCE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:09:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspQJ-0001fz-Ak; Tue, 17 Oct 2023 15:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qspQE-0001dg-Um; Tue, 17 Oct 2023 15:08:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qspQD-0001NW-2a; Tue, 17 Oct 2023 15:08:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7FEC7756201;
 Tue, 17 Oct 2023 21:06:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 43EB97456A7; Tue, 17 Oct 2023 21:06:53 +0200 (CEST)
Message-Id: <dea7938f15c3231984546b12ccc8e3b8ba42a203.1697568616.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1697568616.git.balaton@eik.bme.hu>
References: <cover.1697568616.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [RFC PATCH v4 4/4] tests/avocado: Add test for amigaone board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Tue, 17 Oct 2023 21:06:53 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
I have no idea if this works so testing and corrections are welcome
but this could be a basic test. Booting further is a bit more involved
as we'd need alternative VGA BIOS and selecting menu items in the
firmware to allow CD boot so I did not try to automate that.

This could be simpler if the u-boot-amigaone.bin could be added to
pc-bios. It's GPL so should be OK to include and distribute but irs
sources seem to be lost and could not be recovered or reconstructed so
we only have this binary. Who should be able to decide about that?

 tests/avocado/ppc_amiga.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tests/avocado/ppc_amiga.py

diff --git a/tests/avocado/ppc_amiga.py b/tests/avocado/ppc_amiga.py
new file mode 100644
index 0000000000..e3cc2632e9
--- /dev/null
+++ b/tests/avocado/ppc_amiga.py
@@ -0,0 +1,37 @@
+# Test AmigaNG boards
+#
+# Copyright (c) 2023 BALATON Zoltan
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado.utils import archive
+from avocado.utils import process
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class AmigaOneMachine(QemuSystemTest):
+
+    timeout = 90
+
+    def test_ppc_amigaone(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:amigaone
+        :avocado: tags=cpu:7457
+        :avocado: tags=device:articia
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        tar_url = ('https://www.hyperion-entertainment.com/index.php/'
+                   'downloads?view=download&format=raw&file=25')
+        tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
+        process.run(cmd)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'FLASH:')
-- 
2.30.9


