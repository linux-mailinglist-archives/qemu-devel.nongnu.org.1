Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB05746599
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdI-0003Wz-Jf; Mon, 03 Jul 2023 18:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdG-0003VN-TV; Mon, 03 Jul 2023 18:02:54 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdE-00049f-Vg; Mon, 03 Jul 2023 18:02:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id B9A46748A5E;
 Tue,  4 Jul 2023 00:02:35 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 96E36748A59; Tue,  4 Jul 2023 00:02:35 +0200 (CEST)
Message-Id: <e8ae82b0b6c10e48acbc297fa15d9e5f4befc9d2.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 03/13] ppc440: Add a macro to shorten PCIe controller DCR
 registration
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:35 +0200 (CEST)
X-Spam-Probability: 8%
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

It is more readable to wrap the complex call to ppc_dcr_register in a
macro when needed repeatedly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 76 +++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index b26c0cee1b..db83a0dec8 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1002,56 +1002,36 @@ static void ppc460ex_set_irq(void *opaque, int irq_num, int level)
        qemu_set_irq(s->irq[irq_num], level);
 }
 
+#define PPC440_PCIE_DCR(s, dcrn) \
+    ppc_dcr_register(&(s)->cpu->env, (s)->dcrn_base + (dcrn), s, \
+                     &dcr_read_pcie, &dcr_write_pcie)
+
+
 static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s)
 {
-    CPUPPCState *env = &s->cpu->env;
-
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
+    PPC440_PCIE_DCR(s, PEGPL_CFGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_CFGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_CFGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_MSGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_MSGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_MSGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR1MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR2MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3BAH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3BAL);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3MSKH);
+    PPC440_PCIE_DCR(s, PEGPL_OMR3MSKL);
+    PPC440_PCIE_DCR(s, PEGPL_REGBAH);
+    PPC440_PCIE_DCR(s, PEGPL_REGBAL);
+    PPC440_PCIE_DCR(s, PEGPL_REGMSK);
+    PPC440_PCIE_DCR(s, PEGPL_SPECIAL);
+    PPC440_PCIE_DCR(s, PEGPL_CFG);
 }
 
 static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
-- 
2.30.9


