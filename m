Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936582957F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 09:59:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQ4-0001rN-WD; Wed, 10 Jan 2024 03:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPz-0001cg-3P
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:36 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUPk-0003VN-3G
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:34 -0500
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3bc4f49a3b6so4326910b6e.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877098; x=1705481898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g2b79fjezI+w7ia0ZXSXAOjdvnoCztfU/i3RsPXm/NE=;
 b=IM8htAruo60QUP6/Xis+QqwdAxhR02RX8vYnz9M/lW3RqC6awa/6wNFWBqHFEMnF9L
 gfDJhEh4bgfFSWer3qhVA523u2J4COQRAmSjQv38RPfuIdIlvT53HS6s0u7zF1As17aO
 HI2G6F4tO1oqjyzyaZcMP+CnDWq8GxboI8jcn2MyNuaSIRu2RWAsX+082fiSs2xbRoGB
 IyLI/iJjg3WjVghTrwokNyu/+cuRrlcPwcDZfY3CiLOLexOQlDn7+6MUoI3QdOJRZOAb
 4BV9plC0rF6R6K036kKXant1c8/go9MNNR3uj5LPTJjJnN+g41NKvxruwMCMKkxPaGgY
 +TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877098; x=1705481898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2b79fjezI+w7ia0ZXSXAOjdvnoCztfU/i3RsPXm/NE=;
 b=uYNGeSkCOW+FSAr9J27dGXlTKlO1rt4WcyJqx70O0hhjCxAI2Ql5z6nGvbgp5612Y1
 uX8MWUz3J1KRNhfwoIxeMf7DAr2k4t6uwWq5gy7sPb6p3EytCw+n3w0ODSbwVPemruFM
 STrIyJrToEW9MBed++TUGpUu6EGu06W8loTX7AOgQCcf9fpxHySXFCGmX5Y4NJq+uHHs
 SH7KkoYs+IcaWQfEamCTWvq0biAd13H1dkGhgDCwLpJZbgvAyJsrwcxQQnsM6oZviuY/
 4ZIOVn8VP+X+8HHsnli8AF5Dm6WYB8FT5yXngD5G/dl+HyUIMVtp8dVLW2ake8T4YZX+
 1/bw==
X-Gm-Message-State: AOJu0Yy7yDRo5bTs06gGDd9DK84d1hpvOxQ5IfXwuyeUhn/anQL8DUXo
 oTjPMUkThj1BG3/pC9aU8OKjdoz7KCDUH7lf
X-Google-Smtp-Source: AGHT+IH8pULSFJT8Id5HmHP/rKv9ozFwYw167iws8K+3hS2KREEWfGyvEhU3VD2IL7LoNCmSlxo5Dw==
X-Received: by 2002:a05:6808:1489:b0:3bc:641f:c7f7 with SMTP id
 e9-20020a056808148900b003bc641fc7f7mr1022236oiw.8.1704877098657; 
 Wed, 10 Jan 2024 00:58:18 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:18 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 10/65] target/riscv/kvm: add RISCV_CONFIG_REG()
Date: Wed, 10 Jan 2024 18:56:38 +1000
Message-ID: <20240110085733.1607526-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x229.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Create a RISCV_CONFIG_REG() macro, similar to what other regs use, to
hide away some of the boilerplate.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20231208183835.2411523-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index b7871b2f8f..15573402be 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -88,6 +88,10 @@ static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
 #define RISCV_CSR_REG(env, name)  kvm_riscv_reg_id(env, KVM_REG_RISCV_CSR, \
                  KVM_REG_RISCV_CSR_REG(name))
 
+#define RISCV_CONFIG_REG(env, name) \
+    kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG, \
+                     KVM_REG_RISCV_CONFIG_REG(name))
+
 #define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER, \
                  KVM_REG_RISCV_TIMER_REG(name))
 
@@ -756,24 +760,21 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    reg.id = RISCV_CONFIG_REG(env, mvendorid);
     reg.addr = (uint64_t)&cpu->cfg.mvendorid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.id = RISCV_CONFIG_REG(env, marchid);
     reg.addr = (uint64_t)&cpu->cfg.marchid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
         error_report("Unable to retrieve marchid from host, error %d", ret);
     }
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.id = RISCV_CONFIG_REG(env, mimpid);
     reg.addr = (uint64_t)&cpu->cfg.mimpid;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
     if (ret != 0) {
@@ -788,8 +789,7 @@ static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
     struct kvm_one_reg reg;
     int ret;
 
-    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                              KVM_REG_RISCV_CONFIG_REG(isa));
+    reg.id = RISCV_CONFIG_REG(env, isa);
     reg.addr = (uint64_t)&env->misa_ext_mask;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
 
@@ -1092,8 +1092,7 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
     uint64_t id;
     int ret;
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(mvendorid));
+    id = RISCV_CONFIG_REG(env, mvendorid);
     /*
      * cfg.mvendorid is an uint32 but a target_ulong will
      * be written. Assign it to a target_ulong var to avoid
@@ -1105,15 +1104,13 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
         return ret;
     }
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(marchid));
+    id = RISCV_CONFIG_REG(env, marchid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.marchid);
     if (ret != 0) {
         return ret;
     }
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(mimpid));
+    id = RISCV_CONFIG_REG(env, mimpid);
     ret = kvm_set_one_reg(cs, id, &cpu->cfg.mimpid);
 
     return ret;
-- 
2.43.0


