Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF128295BA
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:07:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUL-0005iX-HX; Wed, 10 Jan 2024 04:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSq-0003Ic-4y
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:34 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSo-0005cu-0h
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:31 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ddeec84e35so480330a34.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877288; x=1705482088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/1I0SyhcsXN3UdWgUzk4g0SlxxbZqG+MteFeWCN3sU4=;
 b=C0ihVK3M2ySj0LAs0IN97wipDIH62z1IUwz+ys8UIJ+4YkyFhnvGxGdJ2osuEX+uF4
 VuBGHEO4eCcGXB0y0RO+dkR+2hCjgiFczSz//SO/oIyTSe+Fy8Bm2NGJ6tbi6QDThVFB
 NrM7t6QcZSCw1Uu6fYsDUZP5IRSqCWnah0ej54cNOF933fe2GvspNxK8+1yZHjtRWSxO
 v/qV+pgML5crj2Br1uHAYhgcRzeGcuOw7t72yEdVhJl4gdTHfcXRbRyszKkKILBgcQ4E
 65bV/kqHjZ0yMqyjTcZZPiFrYUPEv3E4l07HCnmUTbtYahl+w69Eg0/jlyfpd8/lkU2l
 fSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877288; x=1705482088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/1I0SyhcsXN3UdWgUzk4g0SlxxbZqG+MteFeWCN3sU4=;
 b=e2JVN9AoFRfVSmA2oMiWIPe2ERw2XuwSDPY61ArMINid4LRoHS6x18Zn1YuxtIbHSV
 CRcoE3JBnk3TqSJIPUNQ15OS576Nj85sdfRxs+HG9ZBjomah4/uctadM2wnfls9okT9z
 xTVInAu8PycuPAQXOAQ46Zg4Bu1TjoHOefWukZV34O4CpJmbLYRTpy4aMyplN2NR9eRJ
 MVaM7/Lt/UXbv8mII3k37mOCFltbWGXBjR6UZc/Jj3iNnCSVaM7+6CvyBZutjt/xoBD7
 +V4J+flvXKgNvDj3x/94f5ElxlwldZok9Sid+BltPCpFee1fydwRs6ZugJTgmWu8zoMK
 8iTQ==
X-Gm-Message-State: AOJu0YzWRnsRTnUMAUgg1C5RqtHftjuOgvt3JI6RZcUek/dlGJNUtR9O
 7ayy3SYiTqVK5D3kSBtiNr/Ey2ab484mUI9Q
X-Google-Smtp-Source: AGHT+IH6CifiNdLxleROCebTwcDVcPlExJWH88TimN+kUPY5gvqlaM+WU5qnm06AFI2FC/Y67AFHCQ==
X-Received: by 2002:a9d:7a4d:0:b0:6dd:e215:4605 with SMTP id
 z13-20020a9d7a4d000000b006dde2154605mr267560otm.6.1704877288428; 
 Wed, 10 Jan 2024 01:01:28 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 59/65] target/riscv/kvm: add RVV and Vector CSR regs
Date: Wed, 10 Jan 2024 18:57:27 +1000
Message-ID: <20240110085733.1607526-60-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
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

Add support for RVV and Vector CSR KVM regs vstart, vl and vtype.

Support for vregs[] requires KVM side changes and an extra reg (vlenb)
and will be added later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231218204321.75757-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 74 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index d7d6fb1af0..680a729cd8 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -105,6 +105,10 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
 
 #define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, idx)
 
+#define RISCV_VECTOR_CSR_REG(env, name) \
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
+                           KVM_REG_RISCV_VECTOR_CSR_REG(name))
+
 #define KVM_RISCV_GET_CSR(cs, env, csr, reg) \
     do { \
         int _ret = kvm_get_one_reg(cs, RISCV_CSR_REG(env, csr), &reg); \
@@ -158,6 +162,7 @@ static KVMCPUConfig kvm_misa_ext_cfgs[] = {
     KVM_MISA_CFG(RVH, KVM_RISCV_ISA_EXT_H),
     KVM_MISA_CFG(RVI, KVM_RISCV_ISA_EXT_I),
     KVM_MISA_CFG(RVM, KVM_RISCV_ISA_EXT_M),
+    KVM_MISA_CFG(RVV, KVM_RISCV_ISA_EXT_V),
 };
 
 static void kvm_cpu_get_misa_ext_cfg(Object *obj, Visitor *v,
@@ -709,6 +714,65 @@ static void kvm_riscv_put_regs_timer(CPUState *cs)
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
@@ -1004,6 +1068,11 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
+    ret = kvm_riscv_get_regs_vector(cs);
+    if (ret) {
+        return ret;
+    }
+
     return ret;
 }
 
@@ -1044,6 +1113,11 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
2.43.0


