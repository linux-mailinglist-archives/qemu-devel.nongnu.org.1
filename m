Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587EB7CE942
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:43:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDNs-0005qK-CI; Wed, 18 Oct 2023 16:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNP-0004fs-5G; Wed, 18 Oct 2023 16:42:50 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNN-0001CT-45; Wed, 18 Oct 2023 16:42:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 06ADD756088;
 Wed, 18 Oct 2023 22:42:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C0FDF756078; Wed, 18 Oct 2023 22:42:42 +0200 (CEST)
Message-Id: <69a7dd152308067fb55b66ea45eb2c328640fc67.1697661160.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1697661160.git.balaton@eik.bme.hu>
References: <cover.1697661160.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 4/4] tests/avocado: Add test for amigaone board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Wed, 18 Oct 2023 22:42:42 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

Add an avocado test for the amigaone board that tests it with the
firmware.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 tests/avocado/ppc_amiga.py | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 tests/avocado/ppc_amiga.py

diff --git a/tests/avocado/ppc_amiga.py b/tests/avocado/ppc_amiga.py
new file mode 100644
index 0000000000..b6f866f91d
--- /dev/null
+++ b/tests/avocado/ppc_amiga.py
@@ -0,0 +1,38 @@
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
+        :avocado: tags=device:articia
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        tar_name = 'A1Firmware_Floppy_05-Mar-2005.zip'
+        tar_url = ('https://www.hyperion-entertainment.com/index.php/'
+                   'downloads?view=download&format=raw&file=25')
+        tar_hash = 'c52e59bc73e31d8bcc3cc2106778f7ac84f6c755'
+        zip_file = self.fetch_asset(tar_name, locations=tar_url,
+                                    asset_hash=tar_hash)
+        archive.extract(zip_file, self.workdir)
+        cmd = f"tail -c 524288 {self.workdir}/floppy_edition/updater.image >{self.workdir}/u-boot-amigaone.bin"
+        process.run(cmd, shell=True)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', self.workdir + '/u-boot-amigaone.bin')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'FLASH:')
-- 
2.30.9


