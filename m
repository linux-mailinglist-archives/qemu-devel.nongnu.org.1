Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB1E73D77A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfED-0003Jx-9h; Mon, 26 Jun 2023 01:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDp-0003H2-Ol; Mon, 26 Jun 2023 01:57:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfDn-0007Ck-6z; Mon, 26 Jun 2023 01:57:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHDF2sxxz4wb5;
 Mon, 26 Jun 2023 15:57:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHDB66wJz4wZy;
 Mon, 26 Jun 2023 15:56:58 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/30] ppc/pnv/pci: Clean up error messages
Date: Mon, 26 Jun 2023 07:56:19 +0200
Message-ID: <20230626055647.1147743-3-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

The phb error macros add a newline for you, so remove the second one to
avoid double whitespace.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/pci-host/pnv_phb4.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 542f9e293221..6232cbeee161 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -133,13 +133,13 @@ static void pnv_phb4_rc_config_write(PnvPHB4 *phb, unsigned off,
     PCIDevice *pdev;
 
     if (size != 4) {
-        phb_error(phb, "rc_config_write invalid size %d\n", size);
+        phb_error(phb, "rc_config_write invalid size %d", size);
         return;
     }
 
     pdev = pci_find_device(pci->bus, 0, 0);
     if (!pdev) {
-        phb_error(phb, "rc_config_write device not found\n");
+        phb_error(phb, "rc_config_write device not found");
         return;
     }
 
@@ -155,13 +155,13 @@ static uint64_t pnv_phb4_rc_config_read(PnvPHB4 *phb, unsigned off,
     uint64_t val;
 
     if (size != 4) {
-        phb_error(phb, "rc_config_read invalid size %d\n", size);
+        phb_error(phb, "rc_config_read invalid size %d", size);
         return ~0ull;
     }
 
     pdev = pci_find_device(pci->bus, 0, 0);
     if (!pdev) {
-        phb_error(phb, "rc_config_read device not found\n");
+        phb_error(phb, "rc_config_read device not found");
         return ~0ull;
     }
 
@@ -1039,19 +1039,19 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] &
             (PEC_NEST_STK_BAR_EN_MMIO0 |
              PEC_NEST_STK_BAR_EN_MMIO1)) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xffffffffff000000ull;
         break;
     case PEC_NEST_STK_PHB_REGS_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_PHB) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xffffffffffc00000ull;
         break;
     case PEC_NEST_STK_INT_BAR:
         if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_INT) {
-            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+            phb_pec_error(pec, "Changing enabled BAR unsupported");
         }
         phb->nest_regs[reg] = val & 0xfffffff000000000ull;
         break;
-- 
2.41.0


