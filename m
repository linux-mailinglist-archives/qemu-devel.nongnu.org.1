Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB33A74D58E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4o-0001GM-Q3; Mon, 10 Jul 2023 08:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4m-000176-5l
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:12 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4j-0003xt-Dp
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:11 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a40b756eb0so299567b6e.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992388; x=1691584388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aJ52thSjK8C5liD9l616p7JJfSdJds9FK0pDVVCVBc0=;
 b=gp8zTn0kQqVoxC8VaT9lE0TK6NX2ns8Fkrn8deEJE2AMH3VpB0tEhrpIt9bdefsmrh
 HT9RgekA0Z5J+EN3/oj+x5uLEuFZzlPb+8gv8UCbPP9jAY/0ZXObefPMaRjoy1j7fESO
 uzlkGx6oLY5EHoJJQjQ3a2o3KEkY2heu0jMv55jjroqJjtbHhNkwPltNjEB2W8D//EHJ
 fRGE7UoIHnAw8rgU67CFxkQNuyHRUNhxs9JRkCNYZVm8BQtuP8/B6co3808f45+xN1cI
 PryKJYuDMRRs7uyK9w/pjXK/pA9I/bGlavckTC8a4MBDq7kKCK+2jkoCuyxCfZb4tqSd
 LyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992388; x=1691584388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJ52thSjK8C5liD9l616p7JJfSdJds9FK0pDVVCVBc0=;
 b=EloekyegsbTlQS23otguvYJzxCFHMI3LJhbmGQ4O4Juz0MnyRRj4tNCkE8JBsrNdzu
 bc69RfnwUDbNblqkqHFiYiF1UZ1eTrFwuTWw/SBBNRvzzKMzE/4Y3vmb9qSL6YScu3Ns
 QunLrsFdfg+g6KSlUpB3PrNDimXuGZUB5kCKGGeQ1i25uLZzXewgF8ZYfmzfwB61GXRO
 YevfuRwOPeel95ZpqksLrgYRDj69R+SZc7Un0Y2OwhKHihyKudHxeSd+z3ycU4ECQMbW
 lYsNEzrBfkEyqtVqKB2DMRdZ4WnM86xhPpoCJPk0e4hxyjJgp+kOv8W7D5picurmW0dX
 WUNQ==
X-Gm-Message-State: ABy/qLY4GicVAn3bWvQDl9Np6yuv5xfauhban0AVmfBsEUVoWcn6sMxP
 cTqn/QEPyzynWB/KpH0/viGKfSYPBzjiRg==
X-Google-Smtp-Source: APBJJlFnw2oLJBdLawV1jUJnxfuh3LpQ/TApma1UdmwtCIGEG9a6PUlyJeUb/St8U6ZMepf6iOZoyQ==
X-Received: by 2002:a05:6808:2381:b0:3a1:df63:60cc with SMTP id
 bp1-20020a056808238100b003a1df6360ccmr9687249oib.59.1688992388122; 
 Mon, 10 Jul 2023 05:33:08 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/54] target/riscv: update cur_pmbase/pmmask based on mode
 affected by MPRV
Date: Mon, 10 Jul 2023 22:31:25 +1000
Message-Id: <20230710123205.2441106-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Pointer mask is also affected by MPRV which means cur_pmbase/pmmask
should also take MPRV into consideration. As pointer mask for instruction
is not supported currently, so we can directly update cur_pmbase/pmmask
based on address related mode and xlen affected by MPRV now.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230614032547.35895-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c |  7 +++++--
 target/riscv/csr.c        | 27 ++++++++++++++++++++-------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 2e771ddfc9..bb9d923818 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -149,13 +149,16 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
 void riscv_cpu_update_mask(CPURISCVState *env)
 {
     target_ulong mask = 0, base = 0;
+    RISCVMXL xl = env->xl;
     /*
      * TODO: Current RVJ spec does not specify
      * how the extension interacts with XLEN.
      */
 #ifndef CONFIG_USER_ONLY
+    int mode = cpu_address_mode(env);
+    xl = cpu_get_xl(env, mode);
     if (riscv_has_ext(env, RVJ)) {
-        switch (env->priv) {
+        switch (mode) {
         case PRV_M:
             if (env->mmte & M_PM_ENABLE) {
                 mask = env->mpmmask;
@@ -179,7 +182,7 @@ void riscv_cpu_update_mask(CPURISCVState *env)
         }
     }
 #endif
-    if (env->xl == MXL_RV32) {
+    if (xl == MXL_RV32) {
         env->cur_pmmask = mask & UINT32_MAX;
         env->cur_pmbase = base & UINT32_MAX;
     } else {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 25345f3153..ea7585329e 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1329,8 +1329,9 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
      */
     if (env->debugger) {
         env->xl = cpu_recompute_xl(env);
-        riscv_cpu_update_mask(env);
     }
+
+    riscv_cpu_update_mask(env);
     return RISCV_EXCP_NONE;
 }
 
@@ -3633,7 +3634,7 @@ static RISCVException write_mpmmask(CPURISCVState *env, int csrno,
     uint64_t mstatus;
 
     env->mpmmask = val;
-    if ((env->priv == PRV_M) && (env->mmte & M_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
         env->cur_pmmask = val;
     }
     env->mmte |= EXT_STATUS_DIRTY;
@@ -3661,8 +3662,11 @@ static RISCVException write_spmmask(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
     env->spmmask = val;
-    if ((env->priv == PRV_S) && (env->mmte & S_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
         env->cur_pmmask = val;
+        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
+            env->cur_pmmask &= UINT32_MAX;
+        }
     }
     env->mmte |= EXT_STATUS_DIRTY;
 
@@ -3689,8 +3693,11 @@ static RISCVException write_upmmask(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
     env->upmmask = val;
-    if ((env->priv == PRV_U) && (env->mmte & U_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
         env->cur_pmmask = val;
+        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
+            env->cur_pmmask &= UINT32_MAX;
+        }
     }
     env->mmte |= EXT_STATUS_DIRTY;
 
@@ -3713,7 +3720,7 @@ static RISCVException write_mpmbase(CPURISCVState *env, int csrno,
     uint64_t mstatus;
 
     env->mpmbase = val;
-    if ((env->priv == PRV_M) && (env->mmte & M_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_M) && (env->mmte & M_PM_ENABLE)) {
         env->cur_pmbase = val;
     }
     env->mmte |= EXT_STATUS_DIRTY;
@@ -3741,8 +3748,11 @@ static RISCVException write_spmbase(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
     env->spmbase = val;
-    if ((env->priv == PRV_S) && (env->mmte & S_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_S) && (env->mmte & S_PM_ENABLE)) {
         env->cur_pmbase = val;
+        if (cpu_get_xl(env, PRV_S) == MXL_RV32) {
+            env->cur_pmbase &= UINT32_MAX;
+        }
     }
     env->mmte |= EXT_STATUS_DIRTY;
 
@@ -3769,8 +3779,11 @@ static RISCVException write_upmbase(CPURISCVState *env, int csrno,
         return RISCV_EXCP_NONE;
     }
     env->upmbase = val;
-    if ((env->priv == PRV_U) && (env->mmte & U_PM_ENABLE)) {
+    if ((cpu_address_mode(env) == PRV_U) && (env->mmte & U_PM_ENABLE)) {
         env->cur_pmbase = val;
+        if (cpu_get_xl(env, PRV_U) == MXL_RV32) {
+            env->cur_pmbase &= UINT32_MAX;
+        }
     }
     env->mmte |= EXT_STATUS_DIRTY;
 
-- 
2.40.1


