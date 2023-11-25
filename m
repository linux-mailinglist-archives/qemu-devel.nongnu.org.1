Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C207A7F8B2E
	for <lists+qemu-devel@lfdr.de>; Sat, 25 Nov 2023 15:03:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6tEC-0004JC-1V; Sat, 25 Nov 2023 09:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r6tE7-0004Ia-QE; Sat, 25 Nov 2023 09:01:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r6tE6-00081y-2K; Sat, 25 Nov 2023 09:01:43 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BACAB75A4C4;
 Sat, 25 Nov 2023 15:01:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AF6A075A4C3; Sat, 25 Nov 2023 15:01:35 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH for-8.2] ide/via: Fix BAR4 value in legacy mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 philmd@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231125140135.AF6A075A4C3@zero.eik.bme.hu>
Date: Sat, 25 Nov 2023 15:01:35 +0100 (CET)
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Return default value in legacy mode for BAR4 when unset. This can't be
set in reset method because BARs are cleared on reset so we return it
instead when BARs are read in legacy mode.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This fixes UDMA on amigaone with AmigaOS and I'd like to include for
8.2 release.

 hw/ide/via.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index 2d3124ebd7..3f3c484253 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -163,14 +163,19 @@ static uint32_t via_ide_cfg_read(PCIDevice *pd, uint32_t addr, int len)
     uint32_t val = pci_default_read_config(pd, addr, len);
     uint8_t mode = pd->config[PCI_CLASS_PROG];
 
-    if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
-                                              PCI_BASE_ADDRESS_0, 16)) {
-        /* BARs always read back zero in legacy mode */
-        for (int i = addr; i < addr + len; i++) {
-            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
-                val &= ~(0xffULL << ((i - addr) << 3));
+    if ((mode & 0xf) == 0xa) {
+        if (ranges_overlap(addr, len, PCI_BASE_ADDRESS_0, 16)) {
+            /* BARs 0-3 always read back zero in legacy mode */
+            for (int i = addr; i < addr + len; i++) {
+                if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
+                    val &= ~(0xffULL << ((i - addr) << 3));
+                }
             }
         }
+        if (addr == PCI_BASE_ADDRESS_4 && val == PCI_BASE_ADDRESS_SPACE_IO) {
+            /* BAR4 default value if unset */
+            val = 0xcc00 | PCI_BASE_ADDRESS_SPACE_IO;
+        }
     }
 
     return val;
-- 
2.30.9


