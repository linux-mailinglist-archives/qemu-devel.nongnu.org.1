Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049775DA55
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 08:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN61p-0001oW-7q; Sat, 22 Jul 2023 02:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN61b-0001mm-0m
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:23:36 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN61G-0004g7-S3
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:23:26 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7835e2286c4so116575039f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690006988; x=1690611788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxT5Z9g09LiK7OI+CK8NrUdp5j0/hXXiSAmUQPobtDo=;
 b=sKdke8RcDVeBaSs81hmW0NEmhdru6uON/ya8SGO+F8a+Gor52psi3tYSD1B0uTwvFJ
 dl9GnWhYHi9CvJeigR9OegCXYs7ETEY2jB5AZWZodQ06eM9eFArom67EOG0+YugpOMVl
 rD9Ur+iX8ZAbxAQUkUDbxJcbqGw141zzJLeaWj4kpd0wkHpizAkRsbRDIQA4+Rn6zTEq
 5ywojVLLJbGJxL7F9M1+2o78LEYL8gU2eb8mEe806XmWwW9FBngQJY1vAae/IOPFxpJP
 mBsTTuNo9lfPcmA94rqKpQznscwNLCeYEjgfnHzneFqioqKC6vGusOrockkvEXc5bZrm
 Vj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690006988; x=1690611788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxT5Z9g09LiK7OI+CK8NrUdp5j0/hXXiSAmUQPobtDo=;
 b=G4x/tfLWZcdF6fHc5cG3Q+QDZeF7C/UJfpdDL7npctJbi1Ue4ZKR5V+Ti1Rt7TptK9
 Y0fDK2w0Qv25rJIaqGJJqlfKlQPF/3aTKnt8aqH1IjdvBFZoquMpFEqM8sYFfAuE8ftF
 ayGcxrGVrVAWCWzy32m11wXa3qfHxI4MSsvzoKviY0X+P8tlBrPRab2KBlmKX35I+66g
 QYXJSjmW2e51oK+yOoY3KmZTmHYYuaqVC93C1olBPaisCJga9d92RY32ABCNnt582cM6
 BjJYOfbn8V9lMaUo8QVNSBQKa1vkRMRRcPZ+gbfpRIC+UNDm3TMwkl5pFv0W3Rt5vxqU
 oQVg==
X-Gm-Message-State: ABy/qLYkZqZKBGw48XoSGVqWsWI3GZ+KJarsI6r2PkeN2MIIcAtnac2A
 t0lv1ye8M01FEnRjHMibSSs7dz2Iy960tvP/FJs=
X-Google-Smtp-Source: APBJJlGaT2or+I9bFfCLbXa3rk14kNjDBwbkrpA0lYJc5f6+ugye1BldOcZXF80NRhE5eKwBJU8meA==
X-Received: by 2002:a05:6e02:1a64:b0:348:92ef:ac83 with SMTP id
 w4-20020a056e021a6400b0034892efac83mr2738358ilv.29.1690006988277; 
 Fri, 21 Jul 2023 23:23:08 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a170902989000b001b9be3b94e5sm4509198plp.303.2023.07.21.23.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 23:23:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 1/2] kvm: Introduce kvm_arch_get_default_type hook
Date: Sat, 22 Jul 2023 15:22:47 +0900
Message-ID: <20230722062250.18111-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230722062250.18111-1-akihiko.odaki@daynix.com>
References: <20230722062250.18111-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

kvm_arch_get_default_type() returns the default KVM type. This hook is
particularly useful to derive a KVM type that is valid for "none"
machine model, which is used by libvirt to probe the availability of
KVM.

For MIPS, the existing mips_kvm_type() is reused. This function ensures
the availability of VZ which is mandatory to use KVM on the current
QEMU.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/sysemu/kvm.h     | 2 ++
 target/mips/kvm_mips.h   | 9 ---------
 accel/kvm/kvm-all.c      | 4 +++-
 hw/mips/loongson3_virt.c | 1 -
 target/arm/kvm.c         | 5 +++++
 target/i386/kvm/kvm.c    | 5 +++++
 target/mips/kvm.c        | 2 +-
 target/ppc/kvm.c         | 5 +++++
 target/riscv/kvm.c       | 5 +++++
 target/s390x/kvm/kvm.c   | 5 +++++
 10 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79..ccaf55caf7 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -369,6 +369,8 @@ int kvm_arch_get_registers(CPUState *cpu);
 
 int kvm_arch_put_registers(CPUState *cpu, int level);
 
+int kvm_arch_get_default_type(MachineState *ms);
+
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
 int kvm_arch_init_vcpu(CPUState *cpu);
diff --git a/target/mips/kvm_mips.h b/target/mips/kvm_mips.h
index 171d53dbe1..c711269d0a 100644
--- a/target/mips/kvm_mips.h
+++ b/target/mips/kvm_mips.h
@@ -25,13 +25,4 @@ void kvm_mips_reset_vcpu(MIPSCPU *cpu);
 int kvm_mips_set_interrupt(MIPSCPU *cpu, int irq, int level);
 int kvm_mips_set_ipi_interrupt(MIPSCPU *cpu, int irq, int level);
 
-#ifdef CONFIG_KVM
-int mips_kvm_type(MachineState *machine, const char *vm_type);
-#else
-static inline int mips_kvm_type(MachineState *machine, const char *vm_type)
-{
-    return 0;
-}
-#endif
-
 #endif /* KVM_MIPS_H */
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c05..d591b5079c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2458,7 +2458,7 @@ static int kvm_init(MachineState *ms)
     KVMState *s;
     const KVMCapabilityInfo *missing_cap;
     int ret;
-    int type = 0;
+    int type;
     uint64_t dirty_log_manual_caps;
 
     qemu_mutex_init(&kml_slots_lock);
@@ -2523,6 +2523,8 @@ static int kvm_init(MachineState *ms)
         type = mc->kvm_type(ms, kvm_type);
     } else if (mc->kvm_type) {
         type = mc->kvm_type(ms, NULL);
+    } else {
+        type = kvm_arch_get_default_type(ms);
     }
 
     do {
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 4018b8c1d3..bf28f7ec43 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -612,7 +612,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->kvm_type = mips_kvm_type;
     mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
 }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f49..40f577bfd5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -247,6 +247,11 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
     return ret > 0 ? ret : 40;
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c..b45ce20fd8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2556,6 +2556,11 @@ static void register_smram_listener(Notifier *n, void *unused)
                                  &smram_address_space, 1, "kvm-smram");
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     uint64_t identity_base = 0xfffbc000;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index c14e8f550f..e98aad01bd 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1266,7 +1266,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     abort();
 }
 
-int mips_kvm_type(MachineState *machine, const char *vm_type)
+int kvm_arch_get_default_type(MachineState *machine)
 {
 #if defined(KVM_CAP_MIPS_VZ)
     int r;
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index a8a935e267..dc1182cd37 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -108,6 +108,11 @@ static int kvm_ppc_register_host_cpu_type(void);
 static void kvmppc_get_cpu_characteristics(KVMState *s);
 static int kvmppc_get_dec_bits(void);
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 9d8a8982f9..4266dce092 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -907,6 +907,11 @@ int kvm_arch_add_msi_route_post(struct kvm_irq_routing_entry *route,
     return 0;
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     return 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..9117fab6e8 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -340,6 +340,11 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
     mc->default_cpu_type = S390_CPU_TYPE_NAME("host");
 }
 
+int kvm_arch_get_default_type(MachineState *ms)
+{
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
-- 
2.41.0


