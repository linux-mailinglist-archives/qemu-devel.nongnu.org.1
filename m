Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0325E79A58A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbtI-0001ys-IY; Mon, 11 Sep 2023 04:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbtF-0001t8-Gb; Mon, 11 Sep 2023 04:03:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbtD-0002Dn-0r; Mon, 11 Sep 2023 04:03:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 445E920AFB;
 Mon, 11 Sep 2023 11:02:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7C14F27250;
 Mon, 11 Sep 2023 11:02:29 +0300 (MSK)
Received: (nullmailer pid 3680161 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 14/51] pnv_lpc: disable reentrancy detection for lpc-hc
Date: Mon, 11 Sep 2023 11:02:05 +0300
Message-Id: <20230911080225.3680068-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230526073850.2772197-1-clg@kaod.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 76f9ebffcd41b62ae9ec26a1c25676f2ae1d9cc3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index ee890e7ab4..ef29314891 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -733,10 +733,13 @@ static void pnv_lpc_realize(DeviceState *dev, Error **errp)
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
2.39.2


