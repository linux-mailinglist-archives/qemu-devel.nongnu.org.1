Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2EF7C63BF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3f-0001xw-1e; Thu, 12 Oct 2023 00:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3c-0001wt-Ji
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn3a-0002Py-UN
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:12:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9d922c039so4597345ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083937; x=1697688737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uaz6kE7HcEYlJYnxILnPAa7QFnCLIbyAtvlPqF2wjd8=;
 b=KNPq2Pm1d9X0ZqP3hhPIJdEh/tBm6uI+WiyYBh7ODEErKEznDJGyjLSClOcnKDjzzj
 /JnQKu2Stqtyuv6M82gH8VujIEfjOwdie0WYdcHf99hmvoRpFIML9eGVLuHEd7PrgcAO
 i1Keodp77a05nmSYu1eGyH7aZHmygRDTvQSYGzIXWHoguOBY2TPvhET7s/pMpR/wTkl6
 /qWMWW/IthGwLEIUjlJo1iPvZ9Is/dxA3P6yxHzr3qW4hmLM/2CMPahvAA9M9LCBo83G
 LwpgOHQ31UnvZzO8uwuqLzptattKgwTZ4TFVHSL4mRmBnXah1ok9529cPWXkKOlOCnEY
 49dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083937; x=1697688737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uaz6kE7HcEYlJYnxILnPAa7QFnCLIbyAtvlPqF2wjd8=;
 b=IvbEro+iqiG/2qc3iczjUECbxCcD2qvv4zksqim0E5DfjcY9p0L7TalR+VvUw4A6Xe
 YS2Mebz2UPWBz0e3g+9f/Q7x5zw3DIqV0VjL+RFJG0DJfu25Z/Tiaxiu0oD3Q/WcHWHF
 78UFAOxDekp4PG3MnCiCuQ/cBhWzWPDZIwaZvIWOfqNVFb+SN304SAlpBvTFfACwPF7+
 y9YyeRP0p9H3/YXwSr4+clXbHigxzzA0iDGVAPCJo/YYFXvei9aJz4scrRiZAkGMrAyM
 fqNlLwqkKkZOqyDf5tDG4wnbfXWx7yVtOkXoyW+9uOmLlidjn1jaLKXmoxupltxfDqK3
 G4KQ==
X-Gm-Message-State: AOJu0Yywm9wJOPhjt7CzWK72C7PYvKx6JTxxvrT7Qu2N02gnIYCyLW18
 CZQzYwuVNANIZsNjT17zHqc9YrixlsLkmQ==
X-Google-Smtp-Source: AGHT+IGYjMxTSe3zNWGzYhUPCYasW/XvJBqaB5pmp+1t6U4w+mp8nr+azkw1I8ORrJTjCzai445vrg==
X-Received: by 2002:a17:902:c40c:b0:1c8:90bf:4234 with SMTP id
 k12-20020a170902c40c00b001c890bf4234mr21832825plk.61.1697083937326; 
 Wed, 11 Oct 2023 21:12:17 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:12:16 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, "liguang.zhang" <liguang.zhang@hexintek.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 21/54] target/riscv: Clear CSR values at reset and sync MPSTATE
 with host
Date: Thu, 12 Oct 2023 14:10:18 +1000
Message-ID: <20231012041051.2572507-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "liguang.zhang" <liguang.zhang@hexintek.com>

This patch fixes guest reboot errors when using KVM.

There are two issues when rebooting a guest using KVM
1. When the guest initiates a reboot the host is unable to stop the vcpu
2. When running a SMP guest the qemu monitor system_reset causes a vcpu crash

This can be fixed by clearing the CSR values at reset and syncing the
MPSTATE with the host.

Signed-off-by: liguang.zhang <liguang.zhang@hexintek.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230913091332.17355-1-18622748025@163.com>
[ Changes by AF
 - Fixup commit message
 - Fixup patch style
]
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm_riscv.h |  1 +
 target/riscv/kvm.c       | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index 69e807fbfb..44b850a046 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -30,5 +30,6 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
                           uint64_t aplic_base, uint64_t imsic_base,
                           uint64_t guest_num);
 void riscv_kvm_aplic_request(void *opaque, int irq, int level);
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
 
 #endif
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 14763ec0cd..1e4e4456b3 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -51,6 +51,8 @@ void riscv_kvm_aplic_request(void *opaque, int irq, int level)
     kvm_set_irq(kvm_state, irq, !!level);
 }
 
+static bool cap_has_mp_state;
+
 static uint64_t kvm_riscv_reg_id(CPURISCVState *env, uint64_t type,
                                  uint64_t idx)
 {
@@ -795,6 +797,24 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
+{
+    if (cap_has_mp_state) {
+        struct kvm_mp_state mp_state = {
+            .mp_state = state
+        };
+
+        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+        if (ret) {
+            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
+                    __func__, ret, strerror(-ret));
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     int ret = 0;
@@ -814,6 +834,18 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    if (KVM_PUT_RESET_STATE == level) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        if (cs->cpu_index == 0) {
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
+        } else {
+            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
+        }
+        if (ret) {
+            return ret;
+        }
+    }
+
     return ret;
 }
 
@@ -926,6 +958,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
     return 0;
 }
 
@@ -1008,14 +1041,25 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
+    int i;
 
     if (!kvm_enabled()) {
         return;
     }
+    for (i = 0; i < 32; i++) {
+        env->gpr[i] = 0;
+    }
     env->pc = cpu->env.kernel_addr;
     env->gpr[10] = kvm_arch_vcpu_id(CPU(cpu)); /* a0 */
     env->gpr[11] = cpu->env.fdt_addr;          /* a1 */
     env->satp = 0;
+    env->mie = 0;
+    env->stvec = 0;
+    env->sscratch = 0;
+    env->sepc = 0;
+    env->scause = 0;
+    env->stval = 0;
+    env->mip = 0;
 }
 
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level)
-- 
2.41.0


