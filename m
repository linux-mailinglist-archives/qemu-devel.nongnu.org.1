Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D9CBB3BEC
	for <lists+qemu-devel@lfdr.de>; Thu, 02 Oct 2025 13:29:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4HR0-00061N-5q; Thu, 02 Oct 2025 07:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQu-0005uP-FS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:13 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v4HQ3-0005tl-QO
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 07:25:08 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-72ce9790ab3so10900227b3.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1759404254; x=1760009054; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nHrWZYl+y6lWE3fT7HTNz+U0gLHc/EmcRIxzANLsLK0=;
 b=EKkiKC+7Vt3jf33A3Yls19fcI8txryrda8fIEzx1XBf0NMa5zblguNP+fHkrD+vj1j
 WKGdH23n6QBq8yQS75DQM7Gmqu/7wj/bsZ3M0npyB2qcu72matESbB6SCNYt0mtUw1SA
 EpNev8kc5se1dqXG4wBNodMQdNFtu2lpO/wzkXpebTr6v4KP/Ih9lsMH7+gvEaP9CQju
 1L3OT8JcDLgziuJ7bHWrT8+ZmbciDLDVahXploM0wQXnn7mp4QZUTO3RtrJDK4Ua/kx0
 K2NMvm1wX//DKCqwGlMiGbv4i0NOZmcPJzUltOYJGy9BsfrFds1wqNIzRQ0Abxiers4Z
 QKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759404254; x=1760009054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nHrWZYl+y6lWE3fT7HTNz+U0gLHc/EmcRIxzANLsLK0=;
 b=NWecBhRUinsjbzT/cNOAcCIKrp6VRuGxmrSlf3QEurR8GiWJQUxbjFS9SIKVi784+7
 Pu1ddoNBu8d+8TGcf/ptyCVLn2ngjBXq9LZP7OqGAG5SecZCgkCWepfrMWZ4bRw4LKij
 liHLWKP5F7sKbf+46GvopWkvd2uZa++hfoW2ultiNw+UYSyFFOwAUyc3bRUnpeUqG+o2
 QmgByerTjcwrfrCeFg7fahUeq8QnIlXaC/1wzVIQknGaUa/XIQFlWuVmzUIAVtuNMhC3
 5Ks1PDgtTiIgOnfCJx7MFi0xnd9wDqZo3zajrmdH5JraSUT+kKr4iPZxj5E+8Kn0tZpG
 22hA==
X-Gm-Message-State: AOJu0YwtR5nbEoLIkWOEvdb+jvtIVqK4jTJZCMsWNBd7NUExrF9cY/KQ
 68E0QvfamkQpQkeviu/wnRKRT71BxnlQSE6fQvwesN9IaNtvrY1ivOoi38rnehV95D6d5RDp6ls
 SYqxG5F8=
X-Gm-Gg: ASbGncu1nFawqgFMehEYM6HI3JibhAYXPuRCpI//63XODpNv9ai3SrEO1Kt81fOuoMq
 1SPWwCd0eQBetwWj9qiDBXN40TvDlxElBhrENfpqYIcjkRLIwa2NLvsSimtmVMml2ThOXxux4UA
 fwod6pX4442vY1YD3R9MSO4xzapR1t8zuq9KAi/QDrnV/8Su1oe8DNm86cRLxCki/ZASyFhz1hq
 f8gBLVy1pD/FvDfMoy9PUgBMwcS0uasrHSU/gUNsn3I0tj2ZYxJEqPaWXBSCh94N0T4EdkKfCOb
 WwF6HI6CIcm+2wM3uYOQMgI1Zd2vOLot0C+Ve/Xq0uRtkM7Snmbj1sovCHFuJUxUVZkILfMwjx3
 i2C7ZtRl6/+oRskqHcsBcM2H8v3USE9z36SilmiZUCoCJNeGjexOHN56Ida39e3wCsGSeSKU7fe
 U=
X-Google-Smtp-Source: AGHT+IHPNJZrmEuyfBj2S1MI3Cle2ffvXd6RVoXWwZ8Pw2ayM9GXswYjdKeP4IF+TZQdxMXmTzt0ow==
X-Received: by 2002:a05:690c:6083:b0:77f:75c1:5902 with SMTP id
 00721157ae682-77f75c16fcdmr66817207b3.54.1759404254041; 
 Thu, 02 Oct 2025 04:24:14 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 ([2804:7f0:bcc0:b174:a9af:8146:7deb:fbf3])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-77f81c068f6sm7331627b3.5.2025.10.02.04.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 04:24:13 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 14/17] hw/riscv,
 target/riscv: send resync updiscon trace packets
Date: Thu,  2 Oct 2025 08:23:32 -0300
Message-ID: <20251002112335.2374517-15-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
References: <20251002112335.2374517-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x112a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Send updiscon packets based on the constraints already discussed in the
previous patch:

- We do not implement any form of call/return prediction in the encoder,
  and TCG will always retire a single insn per cycle, e.g. irreport will
  always be equal to updiscon;

- irdepth is not implemented since we'll always return a  package where
  irreport == updiscon.

Note that we're sending an updiscon packet if the 'updiscon_pending'
flag is set when we're about the send a resync or a trap packet. The TCG
helper in this case is just setting the trace encoder flags instead of
actually triggering a RAM sink SMEM write.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/trace-encoder.c                      | 37 +++++++++++++++++++
 hw/riscv/trace-encoder.h                      |  3 ++
 target/riscv/helper.h                         |  1 +
 .../riscv/insn_trans/trans_privileged.c.inc   | 11 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc       |  2 +
 target/riscv/trace_helper.c                   | 14 +++++++
 target/riscv/translate.c                      | 11 ++++++
 7 files changed, 79 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 9a4530bbea..5572483d26 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -402,6 +402,22 @@ static void trencoder_send_sync_msg(Object *trencoder_obj, uint64_t pc)
     trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
+static void trencoder_send_updiscon(TraceEncoder *trencoder, uint64_t pc)
+{
+    g_autofree uint8_t *format2_msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t addr_msb = extract64(pc, 31, 1);
+    bool notify = addr_msb;
+    bool updiscon = !notify;
+    uint8_t msg_size;
+
+    msg_size = rv_etrace_gen_encoded_format2_msg(format2_msg, pc,
+                                                 notify,
+                                                 updiscon);
+    trencoder_send_message_smem(trencoder, format2_msg, msg_size);
+
+    trencoder->updiscon_pending = false;
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
@@ -409,6 +425,10 @@ void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
     msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
@@ -426,6 +446,10 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
     g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
     uint8_t msg_size;
 
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     msg_size = rv_etrace_gen_encoded_trap_msg(msg, pc, priv,
                                               ecause, is_interrupt,
                                               tval);
@@ -435,9 +459,22 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
 
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc)
 {
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    if (trencoder->updiscon_pending) {
+        trencoder_send_updiscon(trencoder, pc);
+    }
+
     trencoder_send_sync_msg(trencoder_obj, pc);
 }
 
+void trencoder_report_updiscon(Object *trencoder_obj)
+{
+    TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+
+    trencoder->updiscon_pending = true;
+}
+
 static const Property trencoder_props[] = {
     /*
      * We need a link to the associated CPU to
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index 2bf07c01f6..0c44092ccb 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -36,6 +36,8 @@ struct TraceEncoder {
     uint32_t regs[TRACE_R_MAX];
     RegisterInfo regs_info[TRACE_R_MAX];
 
+    bool updiscon_pending;
+
     bool enabled;
     bool trace_running;
     bool trace_next_insn;
@@ -51,5 +53,6 @@ void trencoder_trace_trap_insn(Object *trencoder_obj,
                                bool is_interrupt,
                                uint64_t tval);
 void trencoder_trace_ppccd(Object *trencoder_obj, uint64_t pc);
+void trencoder_report_updiscon(Object *trencoder_obj);
 
 #endif
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index e80320ad16..f27ff319e9 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -131,6 +131,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 
 /* Trace helpers (should be put inside ifdef) */
 DEF_HELPER_2(trace_insn, void, env, i64)
+DEF_HELPER_1(trace_updiscon, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 8a62b4cfcd..28089539d5 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -26,6 +26,8 @@
 
 static bool trans_ecall(DisasContext *ctx, arg_ecall *a)
 {
+    gen_trace_updiscon();
+
     /* always generates U-level ECALL, fixed in do_interrupt handler */
     generate_exception(ctx, RISCV_EXCP_U_ECALL);
     return true;
@@ -40,6 +42,8 @@ static bool trans_ebreak(DisasContext *ctx, arg_ebreak *a)
     uint32_t ebreak = 0;
     uint32_t post   = 0;
 
+    gen_trace_updiscon();
+
     /*
      * The RISC-V semihosting spec specifies the following
      * three-instruction sequence to flag a semihosting call:
@@ -95,6 +99,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 {
 #ifndef CONFIG_USER_ONLY
     if (has_ext(ctx, RVS)) {
+        gen_trace_updiscon();
+
         decode_save_opc(ctx, 0);
         translator_io_start(&ctx->base);
         gen_update_pc(ctx, 0);
@@ -113,6 +119,8 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     translator_io_start(&ctx->base);
     gen_update_pc(ctx, 0);
@@ -129,6 +137,9 @@ static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
 {
 #ifndef CONFIG_USER_ONLY
     REQUIRE_SMRNMI(ctx);
+
+    gen_trace_updiscon();
+
     decode_save_opc(ctx, 0);
     gen_helper_mnret(cpu_pc, tcg_env);
     tcg_gen_exit_tb(NULL, 0); /* no chaining */
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index b9c7160468..adda6b5bd8 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -183,6 +183,8 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         }
     }
 
+    gen_trace_updiscon();
+
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
diff --git a/target/riscv/trace_helper.c b/target/riscv/trace_helper.c
index ed84e6f79a..4b2b645f04 100644
--- a/target/riscv/trace_helper.c
+++ b/target/riscv/trace_helper.c
@@ -28,9 +28,23 @@ void helper_trace_insn(CPURISCVState *env, uint64_t pc)
         te->trace_next_insn = false;
     }
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+    TraceEncoder *te = TRACE_ENCODER(cpu->trencoder);
+
+    te->updiscon_pending = true;
+    te->trace_next_insn = true;
+}
 #else /* #ifndef CONFIG_USER_ONLY */
 void helper_trace_insn(CPURISCVState *env, uint64_t pc)
 {
     return;
 }
+
+void helper_trace_updiscon(CPURISCVState *env)
+{
+    return;
+}
 #endif /* #ifndef CONFIG_USER_ONLY*/
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 75348480e6..17a6174899 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -604,6 +604,15 @@ static void gen_ctr_jal(DisasContext *ctx, int rd, target_ulong imm)
 }
 #endif
 
+static void gen_trace_updiscon(void)
+{
+    TCGLabel *skip = gen_new_label();
+
+    tcg_gen_brcondi_tl(TCG_COND_EQ, cpu_trace_running, 0, skip);
+    gen_helper_trace_updiscon(tcg_env);
+    gen_set_label(skip);
+}
+
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
     TCGv succ_pc = dest_gpr(ctx, rd);
@@ -629,6 +638,8 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
     gen_set_gpr(ctx, rd, succ_pc);
 
+    gen_trace_updiscon();
+
     gen_goto_tb(ctx, 0, imm); /* must use this for safety */
     ctx->base.is_jmp = DISAS_NORETURN;
 }
-- 
2.51.0


