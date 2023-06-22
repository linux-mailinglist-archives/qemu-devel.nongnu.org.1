Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AB73A269
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKox-0007pw-Jw; Thu, 22 Jun 2023 09:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoj-0007bB-EN
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:49 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoe-0001Q6-QE
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:57:45 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-560a7ce5823so1530492eaf.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442259; x=1690034259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvD2DfqdT0yLrhg4B8fLoR2B1muCOTUleRsfoLErt80=;
 b=fEJpwXYYCH9NIfblDdcZj9jK8nsXrgxTMRNZTv2yHbdhuti+ALDwXMrhtDypU8BTVC
 nQK1IpiVpnZRxa/HVvTXE79vrCijBaZRztooQRY838C+a1/mD8bj9lDTnmGmEhZiMPQQ
 hOy4xlFf2KdeSFLvU0mq5V/H7DPOxhfJGkpuqr48dDR1qCrX+o1MfVNvGQaoCgATBn9N
 KGjU0YDgBCv0D+HcQKCwZjURXk/6AFPN0c54563DFmxzvNpCvEsJpPLXC0SL7uIA9D5v
 07BoHcxy2FKzxrS1ii6RCssAizNE9wE3JZQJNxn9PoF+jqYZKuXGFwW5HhzuRM4h+05p
 2xyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442259; x=1690034259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvD2DfqdT0yLrhg4B8fLoR2B1muCOTUleRsfoLErt80=;
 b=ZKOh8uRRBeIUN5YMbHlU+nojKpG4COPAFNZwyhkowET8tq8AthNBelrBvjC0Qp2+yo
 jQR8j5NV/OV9VLv8p/Rt5+eWspqVuBDSlr20RKEMdc36xd/hT33wqJj1SIhfjT8lYWZ8
 HeB5awL3L+cICbpIot/83pKQuxeusoEGKqRA3YwWyVjCMEBZP11IbZMvwz1vRvgKGmbr
 aB7clwsA0dkwbe4jHunlirWr74M+GS3EU4Qgb5bNfzerkClApCQfJKPTKHojWV8wxmr3
 mB7x/BPtj0tHvWe/0IaXt8Q6bFHvjguEJGb6z4qd9SOSGZ1lHu+O/FlFdDRxIhpvwJ+j
 CKgA==
X-Gm-Message-State: AC+VfDw9oGtnVjDIVBYZDfILdNoDwEYjJgTBxBEUw/wTiw4yt+EuPqw2
 K6VlKCaQDVzTmYy0n9m7MT1dIZz17PTgUbDBnro=
X-Google-Smtp-Source: ACHHUZ53/xg5lUlkPz46bY0r22QUeeqrAWHzG/c2ehiU1Doy1Q+uidMikqhrXUQvy91li37VX6d2Ug==
X-Received: by 2002:a4a:a592:0:b0:558:b703:b9f with SMTP id
 d18-20020a4aa592000000b00558b7030b9fmr13095375oom.8.1687442259537; 
 Thu, 22 Jun 2023 06:57:39 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:57:39 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 10/19] target/riscv/kvm.c: init 'misa_ext_mask' with
 scratch CPU
Date: Thu, 22 Jun 2023 10:56:51 -0300
Message-ID: <20230622135700.105383-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc35.google.com
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

At this moment we're retrieving env->misa_ext during
kvm_arch_init_cpu(), leaving env->misa_ext_mask behind.

We want to set env->misa_ext_mask, and we want to set it as early as
possible. The reason is that we're going to use it in the validation
process of the KVM MISA properties we're going to add next. Setting it
during arch_init_cpu() is too late for user validation.

Move the code to a new helper that is going to be called during init()
time, via kvm_riscv_init_user_properties(), like we're already doing for
the machine ID properties. Set both misa_ext and misa_ext_mask to the
same value retrieved by the 'isa' config reg.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 602727cdfd..4d0808cb9a 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -396,6 +396,28 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     }
 }
 
+static void kvm_riscv_init_misa_ext_mask(RISCVCPU *cpu,
+                                         KVMScratchCPU *kvmcpu)
+{
+    CPURISCVState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    int ret;
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(isa));
+    reg.addr = (uint64_t)&env->misa_ext_mask;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+
+    if (ret) {
+        error_report("Unable to fetch ISA register from KVM, "
+                     "error %d", ret);
+        kvm_riscv_destroy_scratch_vcpu(kvmcpu);
+        exit(EXIT_FAILURE);
+    }
+
+    env->misa_ext = env->misa_ext_mask;
+}
+
 void kvm_riscv_init_user_properties(Object *cpu_obj)
 {
     RISCVCPU *cpu = RISCV_CPU(cpu_obj);
@@ -406,6 +428,7 @@ void kvm_riscv_init_user_properties(Object *cpu_obj)
     }
 
     kvm_riscv_init_machine_ids(cpu, &kvmcpu);
+    kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
 
     kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
 }
@@ -525,21 +548,10 @@ static int kvm_vcpu_set_machine_ids(RISCVCPU *cpu, CPUState *cs)
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
-    target_ulong isa;
     RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-    uint64_t id;
 
     qemu_add_vm_change_state_handler(kvm_riscv_vm_state_change, cs);
 
-    id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
-                          KVM_REG_RISCV_CONFIG_REG(isa));
-    ret = kvm_get_one_reg(cs, id, &isa);
-    if (ret) {
-        return ret;
-    }
-    env->misa_ext = isa;
-
     if (!object_dynamic_cast(OBJECT(cpu), TYPE_RISCV_CPU_HOST)) {
         ret = kvm_vcpu_set_machine_ids(cpu, cs);
     }
-- 
2.41.0


