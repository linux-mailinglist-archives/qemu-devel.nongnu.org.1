Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF9374D587
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4k-0000y8-Hs; Mon, 10 Jul 2023 08:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4h-0000wL-MR
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:07 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4f-0003ip-RC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:07 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a3a8d21208so3948553b6e.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992384; x=1691584384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q02apAqlmOQugFoaiIWP++2Y9Op4N1E0jUWJOT5Xf8k=;
 b=Yr7Nf5CKbW1Dv15egdG8knfiIFT+GxGxaISmUW7TCDxsCYqlXdP+CjcfyzjT24tTFn
 i7wKFLFMzjIjZkuIDugj3Wt5LiET79Roc6k4pyYEa+n19Yjmrl9kPqOiUUqLCylJjqc7
 sYwHPPF6nqmCBHNknx+1tstFZuuJnYAjenEEzKZsioikJTfbDvKthcMngLrrDucKWwMq
 w+zz6IjpJigQZGg9t+pItbQKBtuNsk9kruNdp8/x8EPEByEvlVFgd4jmnLq7sdzq00ub
 dD08QsBfyTqk0wIJ8qcc9bPRcFFbRV8jVUWcyskxKahROy+JW9ZyXvnxXoZanhGhgAE5
 /L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992384; x=1691584384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q02apAqlmOQugFoaiIWP++2Y9Op4N1E0jUWJOT5Xf8k=;
 b=bEV5A5PQ7QA8arKuUkP013R/v6HyrZkIkh7ljlA09NUjnJrW4wayrDQh6Ol5L+Z2m9
 rkuQ3UrJVySmbwJ046uwtrYAXl9Ouq//6iUf4oD9OaY41BCNv2/MfHl3yUZhdLztSefB
 5FWRDyLAHq03NPBraHtVoW603XapX09mL7xTzJSoWJbW3OahFdVn9wzuwqoSYteVMsav
 h97LdVLr4z5TN9pZLn680nBYlx9eczfWjd+bQ64HveaFuYKAlPKvnf3BcHLzG9NhW3lI
 0zrO5ksse3Xf9lQpAqaSnxZ1KXYgjCoVpFqsinn0q8qKdBYWmtuwcYNRfXnkfeYt7myU
 gTUQ==
X-Gm-Message-State: ABy/qLbRhlLQclR+tQgJcile3kY/ZGvL6nOYnwpkRpSCdBrvOBaBlBre
 pjrJ+cPxiDeYc3Wf9iF7fACjjTMroImOSw==
X-Google-Smtp-Source: APBJJlExMD2PjQsfAmc3eqWP9BFLI/hXRg0PDAUsma9ou7MMGqJDyNyP2zp5/JNxkxWIDmOnkoSlFw==
X-Received: by 2002:a05:6808:1a21:b0:3a0:58f6:c424 with SMTP id
 bk33-20020a0568081a2100b003a058f6c424mr15423896oib.26.1688992384531; 
 Mon, 10 Jul 2023 05:33:04 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/54] target/riscv: Add additional xlen for address when MPRV=1
Date: Mon, 10 Jul 2023 22:31:24 +1000
Message-Id: <20230710123205.2441106-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x233.google.com
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

As specified in privilege spec:"When MPRV=1, load and store memory
addresses are treated as though the current XLEN were set to MPP’s
XLEN". So the xlen for address may be different from current xlen.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230614032547.35895-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        | 49 +++++++++++++++++++++++++++++++++------
 target/riscv/cpu_helper.c |  1 +
 target/riscv/translate.c  | 13 ++++++++++-
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7adb8706ac..3081603464 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -500,6 +500,7 @@ FIELD(TB_FLAGS, ITRIGGER, 22, 1)
 /* Virtual mode enabled */
 FIELD(TB_FLAGS, VIRT_ENABLED, 23, 1)
 FIELD(TB_FLAGS, PRIV, 24, 2)
+FIELD(TB_FLAGS, AXL, 26, 2)
 
 #ifdef TARGET_RISCV32
 #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
@@ -516,13 +517,20 @@ static inline const RISCVCPUConfig *riscv_cpu_cfg(CPURISCVState *env)
     return &env_archcpu(env)->cfg;
 }
 
-#if defined(TARGET_RISCV32)
-#define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
-#else
-static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
+#if !defined(CONFIG_USER_ONLY)
+static inline int cpu_address_mode(CPURISCVState *env)
+{
+    int mode = env->priv;
+
+    if (mode == PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
+        mode = get_field(env->mstatus, MSTATUS_MPP);
+    }
+    return mode;
+}
+
+static inline RISCVMXL cpu_get_xl(CPURISCVState *env, target_ulong mode)
 {
     RISCVMXL xl = env->misa_mxl;
-#if !defined(CONFIG_USER_ONLY)
     /*
      * When emulating a 32-bit-only cpu, use RV32.
      * When emulating a 64-bit cpu, and MXL has been reduced to RV32,
@@ -530,7 +538,7 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
      * back to RV64 for lower privs.
      */
     if (xl != MXL_RV32) {
-        switch (env->priv) {
+        switch (mode) {
         case PRV_M:
             break;
         case PRV_U:
@@ -541,11 +549,38 @@ static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
             break;
         }
     }
-#endif
     return xl;
 }
 #endif
 
+#if defined(TARGET_RISCV32)
+#define cpu_recompute_xl(env)  ((void)(env), MXL_RV32)
+#else
+static inline RISCVMXL cpu_recompute_xl(CPURISCVState *env)
+{
+#if !defined(CONFIG_USER_ONLY)
+    return cpu_get_xl(env, env->priv);
+#else
+    return env->misa_mxl;
+#endif
+}
+#endif
+
+#if defined(TARGET_RISCV32)
+#define cpu_address_xl(env)  ((void)(env), MXL_RV32)
+#else
+static inline RISCVMXL cpu_address_xl(CPURISCVState *env)
+{
+#ifdef CONFIG_USER_ONLY
+    return env->xl;
+#else
+    int mode = cpu_address_mode(env);
+
+    return cpu_get_xl(env, mode);
+#endif
+}
+#endif
+
 static inline int riscv_cpu_xlen(CPURISCVState *env)
 {
     return 16 << env->xl;
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8e3c73da52..2e771ddfc9 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -135,6 +135,7 @@ void cpu_get_tb_cpu_state(CPURISCVState *env, vaddr *pc,
     flags = FIELD_DP32(flags, TB_FLAGS, FS, fs);
     flags = FIELD_DP32(flags, TB_FLAGS, VS, vs);
     flags = FIELD_DP32(flags, TB_FLAGS, XL, env->xl);
+    flags = FIELD_DP32(flags, TB_FLAGS, AXL, cpu_address_xl(env));
     if (env->cur_pmmask != 0) {
         flags = FIELD_DP32(flags, TB_FLAGS, PM_MASK_ENABLED, 1);
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 0a5ab89c43..98d54c5617 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -64,6 +64,7 @@ typedef struct DisasContext {
     target_ulong priv_ver;
     RISCVMXL misa_mxl_max;
     RISCVMXL xl;
+    RISCVMXL address_xl;
     uint32_t misa_ext;
     uint32_t opcode;
     RISCVExtStatus mstatus_fs;
@@ -129,6 +130,14 @@ static inline bool has_ext(DisasContext *ctx, uint32_t ext)
 #define get_xl(ctx)    ((ctx)->xl)
 #endif
 
+#ifdef TARGET_RISCV32
+#define get_address_xl(ctx)    MXL_RV32
+#elif defined(CONFIG_USER_ONLY)
+#define get_address_xl(ctx)    MXL_RV64
+#else
+#define get_address_xl(ctx)    ((ctx)->address_xl)
+#endif
+
 /* The word size for this machine mode. */
 static inline int __attribute__((unused)) get_xlen(DisasContext *ctx)
 {
@@ -575,12 +584,13 @@ static TCGv get_address(DisasContext *ctx, int rs1, int imm)
     tcg_gen_addi_tl(addr, src1, imm);
     if (ctx->pm_mask_enabled) {
         tcg_gen_andc_tl(addr, addr, pm_mask);
-    } else if (get_xl(ctx) == MXL_RV32) {
+    } else if (get_address_xl(ctx) == MXL_RV32) {
         tcg_gen_ext32u_tl(addr, addr);
     }
     if (ctx->pm_base_enabled) {
         tcg_gen_or_tl(addr, addr, pm_base);
     }
+
     return addr;
 }
 
@@ -1177,6 +1187,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
     ctx->misa_mxl_max = env->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
+    ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
     ctx->cs = cs;
     ctx->pm_mask_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_MASK_ENABLED);
     ctx->pm_base_enabled = FIELD_EX32(tb_flags, TB_FLAGS, PM_BASE_ENABLED);
-- 
2.40.1


