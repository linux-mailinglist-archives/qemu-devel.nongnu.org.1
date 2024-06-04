Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349578FA95F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 06:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sELzg-00088d-B3; Tue, 04 Jun 2024 00:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sELzY-000843-Jh
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:41:52 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sELzW-0000K2-PB
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 00:41:48 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 4544FE3U080406
 for <qemu-devel@nongnu.org>; Tue, 4 Jun 2024 12:15:14 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4544F4o1080350;
 Tue, 4 Jun 2024 12:15:04 +0800 (+08)
 (envelope-from alvinga@andestech.com)
Received: from alvinga-VirtualBox.andestech.com (10.0.13.68) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Tue, 4 Jun 2024 12:15:04 +0800
To: <qemu-riscv@nongnu.org>, <qemu-devel@nongnu.org>
CC: <alistair.francis@wdc.com>, <bin.meng@windriver.com>,
 <liwei1518@gmail.com>, <dbarboza@ventanamicro.com>,
 <zhiwei_liu@linux.alibaba.com>, Alvin Chang <alvinga@andestech.com>
Subject: [PATCH v5 2/4] target/riscv: Apply modularized matching conditions
 for breakpoint
Date: Tue, 4 Jun 2024 12:14:43 +0800
Message-ID: <20240604041445.244768-3-alvinga@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604041445.244768-1-alvinga@andestech.com>
References: <20240604041445.244768-1-alvinga@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.13.68]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 4544FE3U080406
Received-SPF: pass client-ip=60.248.80.70; envelope-from=alvinga@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
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
Reply-to:  Alvin Chang <alvinga@andestech.com>
From:  Alvin Chang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

We have implemented trigger_common_match(), which checks if the enabled
privilege levels of the trigger match CPU's current privilege level.
Remove the related code in riscv_cpu_debug_check_breakpoint() and invoke
trigger_common_match() to check the privilege levels of the type 2 and
type 6 triggers for the breakpoints.

This commit also changes the behavior of looping the triggers. In
previous implementation, if we have a type 2 trigger and
env->virt_enabled is true, we directly return false to stop the loop.
Now we keep looping all the triggers until we find a matched trigger.

Only the execution bit and the executed PC should be futher checked in
riscv_cpu_debug_check_breakpoint().

Signed-off-by: Alvin Chang <alvinga@andestech.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/debug.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 05e001d041..11125f333b 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -855,22 +855,18 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
         for (i = 0; i < RV_MAX_TRIGGERS; i++) {
             trigger_type = get_trigger_type(env, i);
 
+            if (!trigger_common_match(env, trigger_type, i)) {
+                continue;
+            }
+
             switch (trigger_type) {
             case TRIGGER_TYPE_AD_MATCH:
-                /* type 2 trigger cannot be fired in VU/VS mode */
-                if (env->virt_enabled) {
-                    return false;
-                }
-
                 ctrl = env->tdata1[i];
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE2_EXEC) && (bp->pc == pc)) {
-                    /* check U/S/M bit against current privilege level */
-                    if ((ctrl >> 3) & BIT(env->priv)) {
-                        env->badaddr = pc;
-                        return true;
-                    }
+                    env->badaddr = pc;
+                    return true;
                 }
                 break;
             case TRIGGER_TYPE_AD_MATCH6:
@@ -878,19 +874,8 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
                 pc = env->tdata2[i];
 
                 if ((ctrl & TYPE6_EXEC) && (bp->pc == pc)) {
-                    if (env->virt_enabled) {
-                        /* check VU/VS bit against current privilege level */
-                        if ((ctrl >> 23) & BIT(env->priv)) {
-                            env->badaddr = pc;
-                            return true;
-                        }
-                    } else {
-                        /* check U/S/M bit against current privilege level */
-                        if ((ctrl >> 3) & BIT(env->priv)) {
-                            env->badaddr = pc;
-                            return true;
-                        }
-                    }
+                    env->badaddr = pc;
+                    return true;
                 }
                 break;
             default:
-- 
2.34.1


