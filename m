Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0392270BF5F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15KP-0006ET-7g; Mon, 22 May 2023 09:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15K7-0005ja-Si
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:40 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q15K6-0007b1-8a
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:11:39 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6af86627460so265242a34.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684761095; x=1687353095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+CCxzE2Hp2j2K4/Ie21oKT8rsWCgeG/4fMxwk+2hnw=;
 b=TZTFjf+uZ6B5DASeGJNZh7kQZgzBgVQAK0GQcpBeRgC0E2fccOJp8ZFG5a0fxXkAyP
 5+0EUY03UbL3kzN73Q6tIw9U8ChkuFc5hLpmrDKf2daDYYFHZ2vHa/19mV4GDGKasK5P
 UmNgYd4kuejVEM3rd620GCKw2mfJ1PItJjb56xpQ9xzvWmHfnogX1GxyRr2Oq3iqn8ku
 bAmsWYGVc1x4wuAkG6rqoSW7dOd47gC7hm6EybKA+AQeX/zzWRgtd4wojcySaLceKRfG
 vnH9/lnfYrRNxFNnfyDBT0M+GkMID9BQGFTi6KMWCEUzsx1Uc7EvC7I/BXNFhf0I9Ah5
 1qJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761095; x=1687353095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R+CCxzE2Hp2j2K4/Ie21oKT8rsWCgeG/4fMxwk+2hnw=;
 b=ZsrLn4rrwzL7FgP+/ZY0/H17qDEcO0EaBuWkguX6mXAeHX4MSNocwQ7r2bTSPG6/Oj
 FlxjazcgVChsimK+t9Vkvmgx2YdI4akWxpijNJ8QEZJMSin61DXgOzyDrL9fKP1xXtcG
 9VcFvij8faskmimTihDG1RaQwslngg172OJfnmuZ9O1fHYVr9i3G/+/+hr+jjSU6twGq
 Ohwxi05BuMBJUzK1RlyiSToQhm0BXs9pNckPPgiL5PyQATksKoJ+qZntcvvMf3nKM7+O
 YCLYGJJPbwK7Arp4eDbuiNz6QqnvDZ189l2g+i2fQzoDkc4VQlleb3/KKOvQGggJeTeY
 1FWw==
X-Gm-Message-State: AC+VfDz4tLPv9VdhPfVgWll/SHBuPjdJeO9XnqmEkX88ZHb+0sbpvb+P
 hBcJ51rJnuqYsuXn9AlV1f2V25SFu/vqT4vUy/hM6ZtUoty0Z6lOZcrZf8gA8wM8zCd26Bl/ScT
 4gCWDbfM8U05xDcITQuzri4NE7SEtr1MWqbTb25u+/e75wKdrneQ9VObPaxv48c6kGBhBG7c/yw
 7F
X-Google-Smtp-Source: ACHHUZ6v+R1NGXlVHKRnxs8bBXPoe7emH8cYq4EgeDkkzxXwZWqPutOXDSUbkaqG3lb1O+FNXLxBBw==
X-Received: by 2002:a05:6830:144:b0:6ad:de28:f3f1 with SMTP id
 j4-20020a056830014400b006adde28f3f1mr5843915otp.13.1684761095584; 
 Mon, 22 May 2023 06:11:35 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a9d6c83000000b006af731d100fsm1369182otr.75.2023.05.22.06.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 06:11:35 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v3 4/4] target/riscv: Add Smrnmi mnret instruction.
Date: Mon, 22 May 2023 06:11:23 -0700
Message-Id: <20230522131123.3498539-5-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230522131123.3498539-1-tommy.wu@sifive.com>
References: <20230522131123.3498539-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
---
 target/riscv/helper.h                         |  1 +
 target/riscv/insn32.decode                    |  3 ++
 .../riscv/insn_trans/trans_privileged.c.inc   | 12 +++++
 target/riscv/op_helper.c                      | 51 +++++++++++++++++++
 4 files changed, 67 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 98e97810fd..00f1032086 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -112,6 +112,7 @@ DEF_HELPER_6(csrrw_i128, tl, env, int, tl, tl, tl, tl)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(sret, tl, env)
 DEF_HELPER_1(mret, tl, env)
+DEF_HELPER_1(mnret, tl, env)
 DEF_HELPER_1(wfi, void, env)
 DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(tlb_flush_all, void, env)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 73d5d1b045..e0698f9dfb 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -111,6 +111,9 @@ wfi         0001000    00101 00000 000 00000 1110011
 sfence_vma  0001001    ..... ..... 000 00000 1110011 @sfence_vma
 sfence_vm   0001000    00100 ..... 000 00000 1110011 @sfence_vm
 
+# *** NMI ***
+mnret       0111000    00010 00000 000 00000 1110011
+
 # *** RV32I Base Instruction Set ***
 lui      ....................       ..... 0110111 @u
 auipc    ....................       ..... 0010111 @u
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 7c2837194c..0c1c2db5c6 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -108,6 +108,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
 #endif
 }
 
+static bool trans_mnret(DisasContext *ctx, arg_mnret *a)
+{
+#ifndef CONFIG_USER_ONLY
+    gen_helper_mnret(cpu_pc, cpu_env);
+    tcg_gen_exit_tb(NULL, 0); /* no chaining */
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+#else
+    return false;
+#endif
+}
+
 static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f563dc3981..2de3f102b5 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -359,6 +359,57 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    RISCVCPU *cpu = env_archcpu(env);
+
+    if (!cpu->cfg.ext_smrnmi) {
+        /* RNMI feature is not presented. */
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    if (!(env->priv >= PRV_M)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    /* Get return PC from mnepc CSR. */
+    target_ulong retpc = env->mnepc;
+    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
+        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
+    }
+
+    /* Get previous privilege level from mnstatus CSR. */
+    target_ulong prev_priv = get_field(env->mnstatus, MNSTATUS_MNPP);
+
+    if (cpu->cfg.pmp &&
+        !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+
+    riscv_cpu_set_mode(env, prev_priv);
+    env->mnstatus = set_field(env->mnstatus, MNSTATUS_NMIE, true);
+
+    target_ulong prev_virt = get_field(env->mnstatus, MNSTATUS_MNPV);
+
+    /*
+     * If MNRET changes the privilege mode to a mode
+     * less privileged than M, it also sets mstatus.MPRV to 0.
+     */
+    if (prev_priv < PRV_M) {
+        env->mstatus = set_field(env->mstatus, MSTATUS_MPRV, false);
+    }
+
+    if (riscv_has_ext(env, RVH)) {
+        if (prev_virt) {
+            riscv_cpu_swap_hypervisor_regs(env);
+        }
+
+        riscv_cpu_set_virt_enabled(env, prev_virt);
+    }
+
+    return retpc;
+}
+
 void helper_wfi(CPURISCVState *env)
 {
     CPUState *cs = env_cpu(env);
-- 
2.31.1


