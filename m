Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C458DB52DD5
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Sep 2025 11:59:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwe33-0001ha-Bs; Thu, 11 Sep 2025 05:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2y-0001fZ-8I; Thu, 11 Sep 2025 05:56:56 -0400
Received: from [115.124.30.113] (helo=out30-113.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1uwe2l-0005Oz-4Q; Thu, 11 Sep 2025 05:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1757584579; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To;
 bh=CgPzvRW3PYzQdn11ycTE+/tC0brKHXf/hxY7dZiqdA0=;
 b=XGBEyuwff66vK3txMViFTYpzQguPI0OHyxy8eslHSbATRiM9flvdU15v47mtkxzFEQtiKrQJForWVh3BqkH6Jf4TdgLk7o8shK/ceTgwmO1TSns21GANtq8G0Rfe5AHQlBaHb34Ui6gDOHXJxgAofBqO7Ntosud5YrHxeauldS4=
Received: from ea134-sw06.eng.xrvm.cn(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0Wnlj.Kl_1757584578 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 11 Sep 2025 17:56:18 +0800
From: TANG Tiancheng <lyndra@linux.alibaba.com>
Date: Thu, 11 Sep 2025 17:56:15 +0800
Subject: [PATCH v3 3/4] hw/intc: Save timers array in RISC-V mtimer VMState
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-timers-v3-3-60508f640050@linux.alibaba.com>
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757584576; l=2900;
 i=lyndra@linux.alibaba.com; s=20250909; h=from:subject:message-id;
 bh=YkJJfhz9vbR/O68Q0eP/tZoK/MlSnuQnZJEPg8ettsM=;
 b=zX8pSu4q98Mxg1Cx/NhE9Xy5ssHS2EgrSBbWvAsguzNZFRtKURz6cnysq8xsiUApmSzJ6uz61
 7zPl1UxfB97B8WZir890h1DqTa5eTfph8AnTXz6r8UviLLHhiV3oAXx
X-Developer-Key: i=lyndra@linux.alibaba.com; a=ed25519;
 pk=GQh4uOSLVucXGkaZfEuQ956CrYS14cn1TA3N8AiIjBw=
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.113 (deferred)
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=no autolearn_force=no
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

The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to keep
timers functional after migration.

If an mtimer's entry in 'mtimer->timers' is active at the time the snapshot
is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.

During snapshot save, these active timers must also be migrated; otherwise,
after snapshot load there is no mechanism to restore 'mtimer->timers' back
into the 'timer_list', and any pending timer events would be lost.

QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
with variable length, and vmstate.h did not previously provide a helper
macro for such type.

This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle saving
and restoring a variable-length array of 'QEMUTimer *'. We then use this
macro to migrate the 'mtimer->timers' array, ensuring that timer events
remain scheduled correctly after snapshot load.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
---
 hw/intc/riscv_aclint.c         | 6 ++++--
 include/hw/intc/riscv_aclint.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f656177f0dd82a45 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object *obj, ResetType type)
 
 static const VMStateDescription vmstate_riscv_mtimer = {
     .name = "riscv_mtimer",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
             VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
             VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
                                   num_harts, 0,
                                   vmstate_info_uint64, uint64_t),
+            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
+                                     num_harts),
             VMSTATE_END_OF_LIST()
         }
 };
diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclint.h
index 693415eb6defe4454e5731a681e025f3bac3ad2e..4b7406eec005a06b7c040d8483a8790866a39297 100644
--- a/include/hw/intc/riscv_aclint.h
+++ b/include/hw/intc/riscv_aclint.h
@@ -80,4 +80,8 @@ enum {
     RISCV_ACLINT_SWI_SIZE              = 0x4000
 };
 
+#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
+VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
+                                                        QEMUTimer *)
+
 #endif

-- 
2.43.0


