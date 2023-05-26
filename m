Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589EB71214B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:39:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2S2c-0007Nw-S4; Fri, 26 May 2023 03:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jr09=BP=kaod.org=clg@ozlabs.org>)
 id 1q2S2b-0007NC-09; Fri, 26 May 2023 03:39:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Jr09=BP=kaod.org=clg@ozlabs.org>)
 id 1q2S2X-0005nj-FO; Fri, 26 May 2023 03:39:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QSGyB3rsbz4x4J;
 Fri, 26 May 2023 17:38:58 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QSGy74MNRz4wgv;
 Fri, 26 May 2023 17:38:55 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, Frederic Barrat <fbarrat@linux.ibm.com>,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] pnv_lpc: disable reentrancy detection for lpc-hc
Date: Fri, 26 May 2023 09:38:50 +0200
Message-Id: <20230526073850.2772197-1-clg@kaod.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Jr09=BP=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

From: Alexander Bulekov <alxndr@bu.edu>

As lpc-hc is designed for re-entrant calls from xscom, mark it
re-entrancy safe.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
[clg: mark opb_master_regs as re-entrancy safe also ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_lpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 01f44c19ebba..605d3908617a 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -734,10 +734,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
     /* Create MMIO regions for LPC HC and OPB registers */
     memory_region_init_io(&lpc->opb_master_regs, OBJECT(dev), &opb_master_ops,
                           lpc, "lpc-opb-master", LPC_OPB_REGS_OPB_SIZE);
+    lpc->opb_master_regs.disable_reentrancy_guard = true;
     memory_region_add_subregion(&lpc->opb_mr, LPC_OPB_REGS_OPB_ADDR,
                                 &lpc->opb_master_regs);
     memory_region_init_io(&lpc->lpc_hc_regs, OBJECT(dev), &lpc_hc_ops, lpc,
                           "lpc-hc", LPC_HC_REGS_OPB_SIZE);
+    /* xscom writes to lpc-hc. As such mark lpc-hc re-entrancy safe */
+    lpc->lpc_hc_regs.disable_reentrancy_guard = true;
     memory_region_add_subregion(&lpc->opb_mr, LPC_HC_REGS_OPB_ADDR,
                                 &lpc->lpc_hc_regs);
 
-- 
2.40.1


