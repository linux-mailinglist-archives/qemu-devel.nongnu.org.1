Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E594D72F1BE
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCX-0005Gw-PP; Tue, 13 Jun 2023 21:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCV-0005FL-KT
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:31 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCT-0004YQ-RS
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-654f8b56807so6195855b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705688; x=1689297688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b0EXgDmqcBV8rtk3cXeTfBlBIuAfsXQkOoovA80cZaY=;
 b=PiqSLL0VKIU6GViy17oei9v/bZVmv5KRcFjITRTQSk8TvZaugC6hl67RDRZjFUa8zn
 nc2iM2+PXbyaitU2ZVoQfNLH76eB/nvXvLygT2JAyTLNzWSF5W1N9YngPjaLCTBZuLQJ
 bKOpMz+sxSggnrP5Njmlh9KajiKxhoE4pArqAbgKMT0wxXox3iHsq0vTcwmJoY0H0vTS
 RA+hOZmpWH2/a7ccBm+5u4U3trNq1RT0GVeAxH/ZfKIGwoLureuKdeqH8VK/wwWnaEXS
 rAmOGzJnEDl0nLQw9b4NvihJwMafZjY+8d4bjedQCf42J/Y1n1fIozpBN67tT37V2v5F
 Si2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705688; x=1689297688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0EXgDmqcBV8rtk3cXeTfBlBIuAfsXQkOoovA80cZaY=;
 b=ebYVFPv1pVRc3JBy+l2eCsbQDmsS+1lRIZ7XJ+1LxVj00xygQTkb0wKb/p/4Qf9LZ4
 PrWAH+7dVspFRdZ4FiCoRxyaWn2haOuFiynzKRPc33eYlUtbBdlNhJaqPofNchZvDOx4
 Ffb+Jp60VFxWE7TN9tvIU+BN2SXhvwdOT19DclQGwJ1Q5SM/cycs7RjK5NiNzB6rnyEm
 Yxv4JDwsF5Op1smFlutNGWn8byrl+GB/INNrjHa8a1gYPEk9WgGE0rtZ9TDMzrxbIFyi
 xH/iaZj+OUCFUmloZsisQwmMQN8HIO5P1RPwB2EtfGMX/v2xZ8LyDbiMNDcnv7+PAv7M
 vaYA==
X-Gm-Message-State: AC+VfDw0VDShJjJtRsdMNrYlkig9DhtSo0bOkwjs0bRWbsuG9nQw3lOf
 xvSygoLETrTQrCbV6b8ul81jtMgn/XLBXg==
X-Google-Smtp-Source: ACHHUZ4LYg5TJhJ5XwLMM99BboYIKsqQFV6tqFgUwlHo+jSPvrBM92Er63Bbkdk4OcjrdDPo/CKipQ==
X-Received: by 2002:a05:6a00:b45:b0:656:e7a2:5322 with SMTP id
 p5-20020a056a000b4500b00656e7a25322mr608165pfo.26.1686705688384; 
 Tue, 13 Jun 2023 18:21:28 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:27 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/60] target/riscv: rework write_misa()
Date: Wed, 14 Jun 2023 11:19:30 +1000
Message-Id: <20230614012017.3100663-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

write_misa() must use as much common logic as possible. We want to open
code just the bits that are exclusive to the CSR write operation and TCG
internals.

Our validation is done with riscv_cpu_validate_set_extensions(), but we
need a small tweak first. When enabling RVG we're doing:

        env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
        env->misa_ext_mask = env->misa_ext;

This works fine for realize() time but this can potentially overwrite
env->misa_ext_mask if we reutilize the function for write_misa().

Instead of doing misa_ext_mask = misa_ext, sum up the RVG extensions in
misa_ext_mask as well. This won't change realize() time behavior
(misa_ext_mask will be == misa_ext) and will ensure that write_misa()
won't change misa_ext_mask by accident.

After that, rewrite write_misa() to work as follows:

- mask the write using misa_ext_mask to avoid enabling unsupported
  extensions;

- suppress RVC if the next insn isn't aligned;

- disable RVG if any of RVG dependencies are being disabled by the user;

- assign env->misa_ext and run riscv_cpu_validate_set_extensions(). On
  error, rollback env->misa_ext to its original value, logging a
  GUEST_ERROR to inform the user about the failed write;

- handle RVF and MSTATUS_FS and continue as usual.

Let's keep write_misa() as experimental for now until this logic gains
enough mileage.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230517135714.211809-12-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h |  1 +
 target/riscv/cpu.c |  4 ++--
 target/riscv/csr.c | 51 ++++++++++++++++++++++------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 15423585d0..1f39edc687 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -548,6 +548,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         bool probe, uintptr_t retaddr);
 char *riscv_isa_string(RISCVCPU *cpu);
 void riscv_cpu_list(void);
+void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp);
 
 #define cpu_list riscv_cpu_list
 #define cpu_mmu_index riscv_cpu_mmu_index
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 778801dffc..e67c78f860 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -981,7 +981,7 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPU *cpu, Error **errp)
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
  */
-static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
+void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
 {
     CPURISCVState *env = &cpu->env;
     Error *local_err = NULL;
@@ -997,7 +997,7 @@ static void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         cpu->cfg.ext_ifencei = true;
 
         env->misa_ext |= RVI | RVM | RVA | RVF | RVD;
-        env->misa_ext_mask = env->misa_ext;
+        env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
     }
 
     if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 4451bd1263..cf7da4f87f 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1387,39 +1387,18 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
 static RISCVException write_misa(CPURISCVState *env, int csrno,
                                  target_ulong val)
 {
+    RISCVCPU *cpu = env_archcpu(env);
+    uint32_t orig_misa_ext = env->misa_ext;
+    Error *local_err = NULL;
+
     if (!riscv_cpu_cfg(env)->misa_w) {
         /* drop write to misa */
         return RISCV_EXCP_NONE;
     }
 
-    /* 'I' or 'E' must be present */
-    if (!(val & (RVI | RVE))) {
-        /* It is not, drop write to misa */
-        return RISCV_EXCP_NONE;
-    }
-
-    /* 'E' excludes all other extensions */
-    if (val & RVE) {
-        /*
-         * when we support 'E' we can do "val = RVE;" however
-         * for now we just drop writes if 'E' is present.
-         */
-        return RISCV_EXCP_NONE;
-    }
-
-    /*
-     * misa.MXL writes are not supported by QEMU.
-     * Drop writes to those bits.
-     */
-
     /* Mask extensions that are not supported by this hart */
     val &= env->misa_ext_mask;
 
-    /* 'D' depends on 'F', so clear 'D' if 'F' is not present */
-    if ((val & RVD) && !(val & RVF)) {
-        val &= ~RVD;
-    }
-
     /*
      * Suppress 'C' if next instruction is not aligned
      * TODO: this should check next_pc
@@ -1428,18 +1407,36 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
         val &= ~RVC;
     }
 
+    /* Disable RVG if any of its dependencies are disabled */
+    if (!(val & RVI && val & RVM && val & RVA &&
+          val & RVF && val & RVD)) {
+        val &= ~RVG;
+    }
+
     /* If nothing changed, do nothing. */
     if (val == env->misa_ext) {
         return RISCV_EXCP_NONE;
     }
 
-    if (!(val & RVF)) {
+    env->misa_ext = val;
+    riscv_cpu_validate_set_extensions(cpu, &local_err);
+    if (local_err != NULL) {
+        /* Rollback on validation error */
+        qemu_log_mask(LOG_GUEST_ERROR, "Unable to write MISA ext value "
+                      "0x%x, keeping existing MISA ext 0x%x\n",
+                      env->misa_ext, orig_misa_ext);
+
+        env->misa_ext = orig_misa_ext;
+
+        return RISCV_EXCP_NONE;
+    }
+
+    if (!(env->misa_ext & RVF)) {
         env->mstatus &= ~MSTATUS_FS;
     }
 
     /* flush translation cache */
     tb_flush(env_cpu(env));
-    env->misa_ext = val;
     env->xl = riscv_cpu_mxl(env);
     return RISCV_EXCP_NONE;
 }
-- 
2.40.1


