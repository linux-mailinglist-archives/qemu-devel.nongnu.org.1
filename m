Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98FE82958D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPX-0001Ml-70; Wed, 10 Jan 2024 03:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPU-0001MQ-0U
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:04 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPS-0003Pr-9y
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:03 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3bbd1fab171so2903474b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877080; x=1705481880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxugpf7Xie8lKKhYnNaPAIvRTF5MjKUdNFHbpIxgsxI=;
 b=U87EGJBVzAFjPGasvPMst985ZemxkqG8weZli0QoabraeyVHN+tDVR0PJPrd4/SHE/
 eOVGlqx3zvQIYrBVZf2GfYiumhM0GjydqUl3HO2c2EDPUhwHoRURRLYn0M2YnFt4YlXS
 NKdmCCYWzV+om9F36uKXCKK5cZOFcVBAnXnOCIl2RyqU2Z/TZmAK1sQ2XK7lrywjnltK
 SmypTHkhDTJJIln5YwYKOdP87fxcb5M7Ts+1FBxa+YFp7yNs2gNDN91CGMXeWkeZQ14f
 Ywmz2wfy/5IOsMaCo9E9BkpPv49+/YTuXkO1w6aYzbC77aMtD9XNg3ckkcGwab9QaL1L
 D9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877080; x=1705481880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sxugpf7Xie8lKKhYnNaPAIvRTF5MjKUdNFHbpIxgsxI=;
 b=S/rxwbKZGkxlfxxMIxt5RceqRxyp4KUCJdLqFSH7LkkDYIsw7OWRf4fz4Tbi4iSYWJ
 H7hdj0WB6kjLaIqiRqK0Q1XTO4Qi+VZSA+61QchhQpDcdl/1VvDCOWumukUJlQHuy2b8
 O0RUkhGVqs4SBdE5/WItbyZvc4RNBmPcp1nAIjdlGP8Ba3RjK8TnNZ+M5NEyBsGX9Kre
 mgw/ba4iaT2NZ2Nm7wCOYfV1m+cz1U/JOCL4OQSdC4+38nHaeOY1srIHQWhz9MKmitws
 246SECu64cKgZCIeSNqoN+h3W/jE7wW0uA05isNlyE2yENyhqkqXacjXJ1gqZ54L3WiZ
 zJtw==
X-Gm-Message-State: AOJu0YzDhMeKqsFzFv5lniCNs5hm90GXdruDp9MVyHUnxC3CLn7YRerQ
 p1pauUEMz21Wpt6sejaipmnhkJ73RJXYz9zv
X-Google-Smtp-Source: AGHT+IFyMuchoL6ywgklQWxJhkmzAkz5eF6zv63SjEiKdqOAQSR0pmdv8bBGnujqBOSefu9iMEy3uQ==
X-Received: by 2002:a05:6808:228a:b0:3bd:46d9:3ac1 with SMTP id
 bo10-20020a056808228a00b003bd46d93ac1mr724520oib.113.1704877080734; 
 Wed, 10 Jan 2024 00:58:00 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/65] target/riscv/pmp: Use hwaddr instead of target_ulong for
 RV32
Date: Wed, 10 Jan 2024 18:56:33 +1000
Message-ID: <20240110085733.1607526-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

The Sv32 page-based virtual-memory scheme described in RISCV privileged
spec Section 5.3 supports 34-bit physical addresses for RV32, so the
PMP scheme must support addresses wider than XLEN for RV32. However,
PMP address register format is still 32 bit wide.

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231123091214.20312-1-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h |  8 ++++----
 target/riscv/pmp.c | 26 ++++++++++++--------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index 9af8614cd4..f5c10ce85c 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -53,8 +53,8 @@ typedef struct {
 } pmp_entry_t;
 
 typedef struct {
-    target_ulong sa;
-    target_ulong ea;
+    hwaddr sa;
+    hwaddr ea;
 } pmp_addr_t;
 
 typedef struct {
@@ -73,11 +73,11 @@ target_ulong mseccfg_csr_read(CPURISCVState *env);
 void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
                        target_ulong val);
 target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
-bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
+bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
                         target_ulong size, pmp_priv_t privs,
                         pmp_priv_t *allowed_privs,
                         target_ulong mode);
-target_ulong pmp_get_tlb_size(CPURISCVState *env, target_ulong addr);
+target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 162e88a90a..dff9512c3f 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -150,8 +150,7 @@ void pmp_unlock_entries(CPURISCVState *env)
     }
 }
 
-static void pmp_decode_napot(target_ulong a, target_ulong *sa,
-                             target_ulong *ea)
+static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
 {
     /*
      * aaaa...aaa0   8-byte NAPOT range
@@ -173,8 +172,8 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
     uint8_t this_cfg = env->pmp_state.pmp[pmp_index].cfg_reg;
     target_ulong this_addr = env->pmp_state.pmp[pmp_index].addr_reg;
     target_ulong prev_addr = 0u;
-    target_ulong sa = 0u;
-    target_ulong ea = 0u;
+    hwaddr sa = 0u;
+    hwaddr ea = 0u;
 
     if (pmp_index >= 1u) {
         prev_addr = env->pmp_state.pmp[pmp_index - 1].addr_reg;
@@ -227,8 +226,7 @@ void pmp_update_rule_nums(CPURISCVState *env)
     }
 }
 
-static int pmp_is_in_range(CPURISCVState *env, int pmp_index,
-                           target_ulong addr)
+static int pmp_is_in_range(CPURISCVState *env, int pmp_index, hwaddr addr)
 {
     int result = 0;
 
@@ -305,14 +303,14 @@ static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t privs,
  * Return true if a pmp rule match or default match
  * Return false if no match
  */
-bool pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
+bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
                         target_ulong size, pmp_priv_t privs,
                         pmp_priv_t *allowed_privs, target_ulong mode)
 {
     int i = 0;
     int pmp_size = 0;
-    target_ulong s = 0;
-    target_ulong e = 0;
+    hwaddr s = 0;
+    hwaddr e = 0;
 
     /* Short cut if no rules */
     if (0 == pmp_get_num_rules(env)) {
@@ -624,12 +622,12 @@ target_ulong mseccfg_csr_read(CPURISCVState *env)
  * To avoid this we return a size of 1 (which means no caching) if the PMP
  * region only covers partial of the TLB page.
  */
-target_ulong pmp_get_tlb_size(CPURISCVState *env, target_ulong addr)
+target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
 {
-    target_ulong pmp_sa;
-    target_ulong pmp_ea;
-    target_ulong tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
-    target_ulong tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
+    hwaddr pmp_sa;
+    hwaddr pmp_ea;
+    hwaddr tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
+    hwaddr tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
     int i;
 
     /*
-- 
2.43.0


