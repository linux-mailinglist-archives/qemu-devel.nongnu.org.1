Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D58295A2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:04:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUPx-0001a9-LQ; Wed, 10 Jan 2024 03:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPt-0001Xp-9W
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:29 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPn-0003XX-Lj
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:29 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso1941957b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877102; x=1705481902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YnygtuOVVAel1xr119O8NkNpBtIcFloyfEh3cCV0pSs=;
 b=YMfLH7ZleELJBpsge7oi1Um51MKGOIPKGfa7zCnLP1C1vspTnSKnISG3TfCOLUHWnV
 OWAr8CE8ILF9Li8cmGKt0/GgMyx0G1yE9q0znOD1dDfScs4fXzVbkNNQS9m7T3tcgSsy
 7J1cm8EYu6Uok9YUZwywVmqGrqKwtXsgs+64G+ZXPQJjbwGnQurzFSkxW9lYNX9kmrMj
 9be5Wvk+9h4gjjx3FuP7gNCwJWHXWBw252a1rr2o9QAhyBS012ySjTIvsy5juy93j+Zs
 Q6gV9/zoowcWVH9PN8Ej7Hts5WKmJADHjwlXGMQ1HC7uE7FDNYmN6mk8mOWJmGRSXPhQ
 EO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877102; x=1705481902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YnygtuOVVAel1xr119O8NkNpBtIcFloyfEh3cCV0pSs=;
 b=Y0kvLWG07bDPg69L/yxH70yA2RZ5OMLzTqbe6oCxsKvFVfrrGvvbfe9kgu6aoKuDmz
 T0wZ39t849SS6cUDoLarU9B+MSHCASV/FNKWeiVe66RuEMxflQk4shN67cGuNORdkaQa
 sYZkxo/Cw2M50r+ibTp0E0kKoKcdVfiic+R43hBRJMU+6saMAWffvjaGjEEc3wBDrw9x
 ETHNUTRiAKWrQrYaHeP8eOwMyFp2yj+KxkVnc8cwpFguGI85Y1CrXI3fRmziGuWuqjqV
 QxQmZCDraXzu+mYclCmy47oXou4XMZaQdPH5xSbvWO25HCRV7DssWMIjPOnZWrAgfXcK
 tM3w==
X-Gm-Message-State: AOJu0YwEvz+8toj+GKz41Mq1Lg/p2KumF34LzQZuL8Zd4wU5uSIUKEKo
 15NIg2yoU6qxd9FoRwEMUuTiirbYEMA1b7/R
X-Google-Smtp-Source: AGHT+IGiM5z1IVVaa3tahJi55O5iRK4P8C2Yac3OB52CUH1YTuTPeiVyfRy+w76nuL/8jYZcixsqbA==
X-Received: by 2002:a05:6a00:1401:b0:6da:2f8f:5678 with SMTP id
 l1-20020a056a00140100b006da2f8f5678mr625975pfu.19.1704877102006; 
 Wed, 10 Jan 2024 00:58:22 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/65] target/riscv/kvm: rename riscv_reg_id() to
 riscv_reg_id_ulong()
Date: Wed, 10 Jan 2024 18:56:39 +1000
Message-ID: <20240110085733.1607526-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
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

kvm_riscv_reg_id() returns an id encoded with an ulong size, i.e. an u32
size when running TARGET_RISCV32 and u64 when running TARGET_RISCV64.

Rename it to kvm_riscv_reg_id_ulong() to enhance code readability. It'll
be in line with the existing kvm_riscv_reg_id_<size>() helpers.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-6-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 40 ++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 15573402be..a31df6e273 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -54,7 +54,7 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
 
 static bool cap_has_mp_state;
 
-static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
+static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
     uint64_t id = KVM_REG_RISCV | type | idx;
@@ -82,15 +82,17 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
     return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
 }
 
-#define RISCV_CORE_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, \
-                 KVM_REG_RISCV_CORE_REG(name))
+#define RISCV_CORE_REG(env, name) \
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, \
+                           KVM_REG_RISCV_CORE_REG(name))
 
-#define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
-                 KVM_REG_RISCV_CSR_REG(name))
+#define RISCV_CSR_REG(env, name) \
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CSR, \
+                           KVM_REG_RISCV_CSR_REG(name))
 
 #define RISCV_CONFIG_REG(env, name) \
-    kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG, \
-                     KVM_REG_RISCV_CONFIG_REG(name))
+    kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
+                           KVM_REG_RISCV_CONFIG_REG(name))
 
 #define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
@@ -216,8 +218,8 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 
         /* If we're here we're going to disable the MISA bit */
         reg = 0;
-        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
-                              misa_cfg->kvm_reg_id);
+        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+                                    misa_cfg->kvm_reg_id);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
             /*
@@ -378,8 +380,8 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
             continue;
         }
 
-        id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
-                              multi_ext_cfg->kvm_reg_id);
+        id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+                                    multi_ext_cfg->kvm_reg_id);
         reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret != 0) {
@@ -509,7 +511,7 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
     env->pc = reg;
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
         ret = kvm_get_one_reg(cs, id, &reg);
         if (ret) {
             return ret;
@@ -534,7 +536,7 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
     }
 
     for (i = 1; i < 32; i++) {
-        uint64_t id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CORE, i);
+        uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
         reg = env->gpr[i];
         ret = kvm_set_one_reg(cs, id, &reg);
         if (ret) {
@@ -810,8 +812,8 @@ static void kvm_riscv_read_cbomz_blksize(RISCVCPU *cpu, KVMScratchCPU *kvmcpu,
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              cbomz_cfg->kvm_reg_id);
+    reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG,
+                                    cbomz_cfg->kvm_reg_id);
     reg.addr = (uint64_t)kvmconfig_get_cfg_addr(cpu, cbomz_cfg);
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
@@ -832,8 +834,8 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
         KVMCPUConfig *multi_ext_cfg = &kvm_multi_ext_cfgs[i];
         struct kvm_one_reg reg;
 
-        reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_ISA_EXT,
-                                  multi_ext_cfg->kvm_reg_id);
+        reg.id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_ISA_EXT,
+                                        multi_ext_cfg->kvm_reg_id);
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
@@ -924,8 +926,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
 
     for (i = 0; i < ARRAY_SIZE(kvm_multi_ext_cfgs); i++) {
         multi_ext_cfg = &kvm_multi_ext_cfgs[i];
-        reg_id = kvm_riscv_reg_id(&cpu->env, KVM_REG_RISCV_ISA_EXT,
-                                  multi_ext_cfg->kvm_reg_id);
+        reg_id = kvm_riscv_reg_id_ulong(&cpu->env, KVM_REG_RISCV_ISA_EXT,
+                                        multi_ext_cfg->kvm_reg_id);
         reg_search = bsearch(&reg_id, reglist->reg, reglist->n,
                              sizeof(uint64_t), uint64_cmp);
         if (!reg_search) {
-- 
2.43.0


