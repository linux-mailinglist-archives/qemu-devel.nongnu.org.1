Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E84677278B0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 09:24:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q79zY-0002HO-CE; Thu, 08 Jun 2023 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q79zW-0002H7-Ux
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:23:30 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q79zV-0006fI-Bz
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 03:23:30 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55b00ad09feso198959eaf.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 00:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1686209008; x=1688801008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBp5P34pomIf/TRV0HfYpflM8Flhf0grZdqWN9dKPh0=;
 b=jcxde9qPNrfNLIOo+NX7t4h8IA4Ei+JWWsmqB+P5OzueESgCLuHDNIMrdbH3YQAK76
 r3vSdfs1dI94yhLhfLJNIxZKW8RHy7KJnMrMy6yBYBhPfNsdsxKpm35e+N8z0+H8xIXi
 kPVsNkqXWOHKUML3KlMi2pHFJbujkbc7/26TpsxGEcYihJX5glOmzhIbwTX6wvKtID2D
 psJNricnNTHs/yELjrsqWVgnj9c+lSeGUbV1+fT+llJlAm1vQ0dHlTLDdH1d2hfZ6AOu
 EZ9DTidqPZnL4UTdHnXABfIcKasySNPyyN9oJuIH63UwbFYkwci3ECPBTKIDgVXR6pio
 9iiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686209008; x=1688801008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBp5P34pomIf/TRV0HfYpflM8Flhf0grZdqWN9dKPh0=;
 b=DHLInp4ASSoeBcbHXdep4XrTcq2DxzVHw3SU5NjD+axPszTYB4HsvDisv0zJ5ToWw4
 RXJ/HnBwqcvkA1ZpjFtHVm4U5ulY+usmjfodMTY8NZHnGbHQ0JKZ+Sug9JIp/QZJrE2q
 ayGJP5AQCTXFdbUGoPNfBuxZ+gUsXiCyf7DGpQY9JUh2ddyx2LleU3UP6aF28IhrKZbJ
 vIxF3AHMoarCKrtjnnY65/kAAQvZrpf+NykBdqoYW0loG1ZUa+ckbAiOKdz9vEon8Qtc
 bkCIN2z6SSjmjJ86ED4L0d5dAOAf+OgaUxCaDPcIJ/cCMWNrKzcEuVHySMRPqS+q6vP+
 EREQ==
X-Gm-Message-State: AC+VfDxmP5a5N05UhoY4uvYVqbVKMUZcxe5vl2Z/WCIoX5NySh1LzqOK
 oPOEXIGcnPJ0FsFctpxoI/eB/IJSBUKgeOr15FfeGUcNQVvX69NZ/2SmclySbCMSNzIHOhszLxp
 bP/TuAgEVrG4KtINPFOpFiS6Y/L337A+CNYM0tzaZx8DoNLJBR9WINTWUekadf2a62W8MJ98n3v
 aT
X-Google-Smtp-Source: ACHHUZ5y77BAl2HVL2EpguyRmXdU8MayXA9SXKTbFUbIRppFIzPi1FqYtZTKWl8N43HZjj1AkxORsQ==
X-Received: by 2002:a4a:b384:0:b0:558:b224:ce9f with SMTP id
 p4-20020a4ab384000000b00558b224ce9fmr5878171ooo.7.1686209007656; 
 Thu, 08 Jun 2023 00:23:27 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 x144-20020a4a4196000000b0051134f333d3sm274293ooa.16.2023.06.08.00.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 00:23:27 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH v4 4/4] target/riscv: Add Smrnmi mnret instruction.
Date: Thu,  8 Jun 2023 00:23:14 -0700
Message-Id: <20230608072314.3561109-5-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230608072314.3561109-1-tommy.wu@sifive.com>
References: <20230608072314.3561109-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=tommy.wu@sifive.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
 target/riscv/op_helper.c                      | 49 +++++++++++++++++++
 4 files changed, 65 insertions(+)

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
index 528baa1652..ef7f102069 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -104,6 +104,18 @@ static bool trans_mret(DisasContext *ctx, arg_mret *a)
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
index f563dc3981..b27beec871 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -359,6 +359,55 @@ target_ulong helper_mret(CPURISCVState *env)
     return retpc;
 }
 
+target_ulong helper_mnret(CPURISCVState *env)
+{
+    if (!riscv_cpu_cfg(env)->ext_smrnmi) {
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
+    if (riscv_cpu_cfg(env)->pmp &&
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


