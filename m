Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B8D74391C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:13:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB3z-0005S8-7H; Fri, 30 Jun 2023 06:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3i-0005In-7p
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:58 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB3e-0000od-Mx
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:08:57 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b012c3ce43so1457885fac.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119733; x=1690711733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nvD2DfqdT0yLrhg4B8fLoR2B1muCOTUleRsfoLErt80=;
 b=ht5gFAvSPjJ7q8MV3hhYK7FtJZvuF7d+fBecqTKFYgXvKdU2h9vFt+aWTtFyBuLm96
 4bRnAU9wODvWY3nPGtI6X3fY2ZDSZihAIotTPnlLyPNiDNR7sMJ5T0W7+Sn1XpFi2iwu
 MVrrR68eMOZ6IzOyHR5xBjeA4oJ69N9HPb6JTdOJl1w+KXRXB+o667GWQT8+4bYxzKQf
 praW/GVcd1cXp/L9rTGHVh1ChUYg4NVEPR64lMZjbAGNmM5SiioGy8lOb5OPPtCP3TyB
 kh9HllAxLbc2iaKhIP8VKnyRDZklXILWayzTquQLXeJGEvV1dygtAWdDV4Frd3s/0PfX
 EIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119733; x=1690711733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nvD2DfqdT0yLrhg4B8fLoR2B1muCOTUleRsfoLErt80=;
 b=LtvqZRnSgsDvY1/YjhjzIq+3SJGT2909fsR+amOO9BcMeAXdLQxhQDsbLvwYpYLA57
 /4lp3yi9rEyvk8c7lCuDuVoVuruX7i01heH8XBqJIGIoBhrTBh7A1BXfHo/D4lUGxajw
 53koKhqo0dVsax6718X1W9wiTXE9AV8BU1TY2l2FInfNQIfd6Wt/dkVXRu+tqoP7aJMM
 6PGm5VI6LRL/xBW/CXfQ2QElZSjzjz3mMdh+DwpLGmzdS1R00QWu0gWsjumb0dz1QGMS
 Q8fUWP7i66+7HJ0qqFbcP1gqD158XSXI60/79422gHz5osh3Htd3eT+bX9SlJQ0jIITA
 xbSg==
X-Gm-Message-State: AC+VfDwElZ/XEvHm/9O9tG6kipUO7yaImtF+Lc+7kpW6yGqrBf+7vllX
 FUXE7La7TDJVnqq7pyKlprKBDZc3FHwq26QSgIY=
X-Google-Smtp-Source: ACHHUZ5UtsSa59GpDv7tR09qiQC+Z28Gb3xzrzY9Ky2up7jPYN6RseDU+mTXscCMRqR2sNE1nL722w==
X-Received: by 2002:a05:6871:e89:b0:1a9:8484:40d with SMTP id
 vl9-20020a0568710e8900b001a98484040dmr2066361oab.23.1688119733191; 
 Fri, 30 Jun 2023 03:08:53 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:08:52 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 10/20] target/riscv/kvm.c: init 'misa_ext_mask' with
 scratch CPU
Date: Fri, 30 Jun 2023 07:08:01 -0300
Message-ID: <20230630100811.287315-11-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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


