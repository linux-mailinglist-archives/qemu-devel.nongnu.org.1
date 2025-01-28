Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE05A2061B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:23:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgcB-0004J2-5Q; Tue, 28 Jan 2025 03:06:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcga2-0000gn-2Q; Tue, 28 Jan 2025 03:04:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcga0-0002ft-Ib; Tue, 28 Jan 2025 03:04:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 16594E1B6A;
 Tue, 28 Jan 2025 10:57:09 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8402F1A631D;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 236AB520CB; Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 35/58] hw/intc/riscv_aplic: Fix APLIC in_clrip and
 clripnum write emulation
Date: Mon, 27 Jan 2025 23:25:21 +0300
Message-Id: <20250127202547.3723716-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In the section "4.7 Precise effects on interrupt-pending bits"
of the RISC-V AIA specification defines that:

"If the source mode is Level1 or Level0 and the interrupt domain
is configured in MSI delivery mode (domaincfg.DM = 1):
The pending bit is cleared whenever the rectified input value is
low, when the interrupt is forwarded by MSI, or by a relevant
write to an in_clrip register or to clripnum."

Update the riscv_aplic_set_pending() to match the spec.

Fixes: bf31cf06eb ("hw/intc/riscv_aplic: Fix setipnum_le write emulation for APLIC MSI-mode")
Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241029085349.30412-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 0d0141fadc9063e527865ee420b2baf34e306093)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 4a262c82f0..74c82a8411 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -248,9 +248,12 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
 
     if ((sm == APLIC_SOURCECFG_SM_LEVEL_HIGH) ||
         (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
-        if (!aplic->msimode || (aplic->msimode && !pending)) {
+        if (!aplic->msimode) {
             return;
         }
+        if (aplic->msimode && !pending) {
+            goto noskip_write_pending;
+        }
         if ((aplic->state[irq] & APLIC_ISTATE_INPUT) &&
             (sm == APLIC_SOURCECFG_SM_LEVEL_LOW)) {
             return;
@@ -261,6 +264,7 @@ static void riscv_aplic_set_pending(RISCVAPLICState *aplic,
         }
     }
 
+noskip_write_pending:
     riscv_aplic_set_pending_raw(aplic, irq, pending);
 }
 
-- 
2.39.5


