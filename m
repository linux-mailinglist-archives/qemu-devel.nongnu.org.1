Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BA7FF958
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 19:29:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8llr-0007Z7-Ic; Thu, 30 Nov 2023 13:28:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8lli-0007Xs-BC
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:28:10 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r8llg-00022c-Lq
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 13:28:10 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6cbe716b511so1257115b3a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701368887; x=1701973687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34Xpt4JtgZm+A2kDvOT6tk9K/WJ3wSZMAoupfQaoGuQ=;
 b=CGM6pU4IJ963G8pKuP8HJj89djfrE+bFPEUSBC4AgjoQSu4zfJak/vB+UOIuKrEWdT
 khElQ4+Wp/Mx6vt2EK4aQs7wzM6G76oZdlcF5TUNNUMGbWgViNPUnaXJjS+YV8oBViF6
 SsOg1k821WMhqFwVYDW01pbLvg6s1rjnSTDMuP8dMQmzkJogZkcP0k5L1VANHcQqM9CQ
 NoJ2v39pUp+jIwXK1wWJS16SSlE2TVJZgEseSxDoKHf3VRfD14EgTLf0Eqih9Uz4sWUw
 vEbXHMcV8xvyO1urX6P/Hnb3hdu4VxZq4+R7JfOeEYPqV3UafujWa/hO6zJVI0gO+SyR
 aolw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701368887; x=1701973687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34Xpt4JtgZm+A2kDvOT6tk9K/WJ3wSZMAoupfQaoGuQ=;
 b=ptlaNIUjBFv5fqLNMgLQFmvV75GtF4fIJ3UIORvbuLyeq2qev/N16I/TOtpRujixEh
 tw+HsP3c9IBNAylkL1fja+CxNgO6KNS/H9mtS8cwXqmgGzVIpefgOoSiONBtDQtwdjAN
 eWU9TJnopXnThD/GgjLjgHN2QCN4ZAadejPsFdWNac2xDDt9yusfj17heSPdeF1+ym30
 VjyF77Sdv1Sbi3wvFHjJTkGJKeppgMOPm6XgkzVQPzXuzFfgmUMtxl8sQVBExTqbAc/r
 bZH6O9leDd2pTeBp4pIVnlO7PDURPbwWeQi/OpmHbN1nMSPsoAKibq4PEjhIpdZ9qrvi
 vSFA==
X-Gm-Message-State: AOJu0YzAtDrUa0H/IbdZ7ozv9rscLnPFQvpXlMYxGYvGiwioECM0lsZb
 kR1gyBg9i3o9QVZCtRDVHzPqW1eYN8/odpDtWm0=
X-Google-Smtp-Source: AGHT+IGRVI/rmGCqeV/A+j6kefzOI/mrKfFJkfe0YJ9OicRBE7ANJiHHcHHmQa5WaOZul6CPE6QZOQ==
X-Received: by 2002:a05:6a20:9712:b0:187:9f15:bfc7 with SMTP id
 hr18-20020a056a20971200b001879f15bfc7mr20226100pzc.27.1701368886814; 
 Thu, 30 Nov 2023 10:28:06 -0800 (PST)
Received: from grind.. (200-206-229-234.dsl.telesp.net.br. [200.206.229.234])
 by smtp.gmail.com with ESMTPSA id
 b24-20020aa78718000000b0068fece22469sm1517451pfo.4.2023.11.30.10.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 10:28:06 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 4/4] target/riscv/kvm: add RVV and Vector CSR regs
Date: Thu, 30 Nov 2023 15:27:48 -0300
Message-ID: <20231130182748.1894790-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231130182748.1894790-1-dbarboza@ventanamicro.com>
References: <20231130182748.1894790-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42f.google.com
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

Add support for RVV and Vector CSR KVM regs vstart, vl and vtype.

Support for vregs[] requires KVM side changes and an extra reg (vlenb)
and will be added later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 273c71baea..5408ead81c 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -89,6 +89,10 @@ static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
 
 #define RISCV_FP_D_REG(env, idx)  kvm_riscv_reg_id(env, KVM_REG_RISCV_FP_D, idx)
 
+#define RISCV_VECTOR_CSR_REG(env, name) \
+    kvm_riscv_reg_id(env, KVM_REG_RISCV_VECTOR, \
+                     KVM_REG_RISCV_VECTOR_CSR_REG(name))
+
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
         int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
@@ -142,6 +146,7 @@ static KVMCPUConfig kvm_misa_ext_cfgs[] = {
     KVM_MISA_CFG(RVH, KVM_RISCV_ISA_EXT_H),
     KVM_MISA_CFG(RVI, KVM_RISCV_ISA_EXT_I),
     KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
+    KVM_MISA_CFG(RVV, KVM_RISCV_ISA_EXT_V),
 };
 
 static void kvm_cpu_get_misa_ext_cfg(Object *obj, Visitor *v,
@@ -688,6 +693,65 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
     env->kvm_timer_dirty = false;
 }
 
+static int kvm_riscv_get_regs_vector(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    target_ulong reg;
+    int ret = 0;
+
+    if (!riscv_has_ext(env, RVV)) {
+        return 0;
+    }
+
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vstart = reg;
+
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vl = reg;
+
+    ret = kvm_get_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+    if (ret) {
+        return ret;
+    }
+    env->vtype = reg;
+
+    return 0;
+}
+
+static int kvm_riscv_put_regs_vector(CPUState *cs)
+{
+    CPURISCVState *env = &RISCV_CPU(cs)->env;
+    target_ulong reg;
+    int ret = 0;
+
+    if (!riscv_has_ext(env, RVV)) {
+        return 0;
+    }
+
+    reg = env->vstart;
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vstart), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg = env->vl;
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vl), &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg = env->vtype;
+    ret = kvm_set_one_reg(cs, RISCV_VECTOR_CSR_REG(env, vtype), &reg);
+
+    return ret;
+}
+
 typedef struct KVMScratchCPU {
     int kvmfd;
     int vmfd;
@@ -989,6 +1053,11 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_riscv_get_regs_vector(cs);
+    if (ret) {
+        return ret;
+    }
+
     return ret;
 }
 
@@ -1029,6 +1098,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    ret = kvm_riscv_put_regs_vector(cs);
+    if (ret) {
+        return ret;
+    }
+
     if (KVM_PUT_RESET_STATE == level) {
         RISCVCPU *cpu = RISCV_CPU(cs);
         if (cs->cpu_index == 0) {
-- 
2.41.0


