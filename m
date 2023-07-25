Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83476184F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOH7J-0001QO-2p; Tue, 25 Jul 2023 08:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOH79-0001Mm-Lh
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:26:08 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qOH77-00013N-Jp
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:26:07 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98e011f45ffso804986266b.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690287963; x=1690892763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S9g/QXvNb+Lw5hryvZ+h5Q3ejbTwi1aaqLCSFFIeoFk=;
 b=B1pG80vbUbbmEYYjsv8ikBP+qr22ahaM2RuukWwfy0lTFnOS31O76cRS2eZ1GVIHnW
 37Zz0ZJ+cQMLLXui9SV7ArPor3JxyhgO1L+TXcHIXviqznohkcmDq4WggcWD1U5S/Gbx
 wofvGXykFdIYav9v8DDONmziDdYPj59/JhmXgJrFfxN8msdSAgktB+Y0Pie/zhOgMRWQ
 Ac4Hch1I5G2aXVnUTO1rc63DKjQES3zEpBS9O8/fZkvQhI5eWobqBA2gjYZ4mUHtTDQ6
 31M4Zqzli1QqAaaJCPPQ0pq1u2b2dpg2oNN9jZ0i+OoWbYAQPF+KwXbrMMR40vhl1rbv
 Wr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690287963; x=1690892763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9g/QXvNb+Lw5hryvZ+h5Q3ejbTwi1aaqLCSFFIeoFk=;
 b=I5sF+V7MhqlnadQrDL8BOCD3qCYZs2HQmKLjaLRv7ftZkF3NH4J/X/ZSZJOOVUdV8G
 /9oyu2z/45/ECa8qyr+dUZb9w/cptVwc5b8FXLnQNWrVCZ6wSMUefpGI0GGscyO7FuaG
 qBiqDEgwjW8A6GIPHZ/A3KDQ1COi8Z8M/vQDQ66W5OREXyiBPLCDQsK+oGDnQahGPBKR
 L2tQFk6YEoh4nP+jHyH6zsh9DB/5hfAk2WtoQm9NY8sj3yMrF7YA1s5Xy6i2tIbrgjHU
 ucIGaknBBI48GuAGe84GsLB6M1Um6Z+il27yhn2F369JJFLlMiPFLafrFQZmRJmWSZ+0
 E80w==
X-Gm-Message-State: ABy/qLbV0OU33Dl3sFzLw5Kv6iTCZatULjHVKUFhIkS1ZA/pL9Y4WkHw
 Twfb672R/XTb2je5RrR7cGTilhAtwaJSnYShvxY=
X-Google-Smtp-Source: APBJJlGByS2FBy6hlFISQqdKBfSpm9tqzfHPMfoM9ZaEhm5fqOmk8jqIGO0W3SmqS03wfQeNYeaCrw==
X-Received: by 2002:a17:906:31d8:b0:994:2fa9:7446 with SMTP id
 f24-20020a17090631d800b009942fa97446mr11292939ejf.46.1690287963359; 
 Tue, 25 Jul 2023 05:26:03 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 b19-20020a170906039300b0099364d9f0e2sm8180676eja.98.2023.07.25.05.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 05:26:02 -0700 (PDT)
From: Andrew Jones <ajones@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 dbarboza@ventanamicro.com, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH v2] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Date: Tue, 25 Jul 2023 14:26:02 +0200
Message-ID: <20230725122601.424738-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x636.google.com
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

Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
RISC-V platform has AIA. The cap indicates KVM supports at least one
of the following ioctls:

  KVM_CREATE_IRQCHIP
  KVM_IRQ_LINE
  KVM_GET_IRQCHIP
  KVM_SET_IRQCHIP
  KVM_GET_LAPIC
  KVM_SET_LAPIC

but the cap doesn't imply that KVM must support any of those ioctls
in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
ioctl was supported. Stop making that assumption by introducing a
KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
sets. Adding parameters isn't awesome, but given how the
KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
options.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
---

While this fixes booting guests on riscv KVM with AIA it's unlikely
to get merged before the QEMU support for KVM AIA[1] lands, which
would also fix the issue. I think this patch is still worth considering
though since QEMU's assumption is wrong.

[1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/

v2:
  - Move the s390x code to an s390x file. [Thomas]
  - Drop the KVM_CAP_IRQCHIP check from the top of kvm_irqchip_create(),
    as it's no longer necessary.

 accel/kvm/kvm-all.c    | 16 ++++------------
 include/sysemu/kvm.h   |  1 +
 target/arm/kvm.c       |  3 +++
 target/i386/kvm/kvm.c  |  2 ++
 target/s390x/kvm/kvm.c | 11 +++++++++++
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 373d876c0580..cddcb6eca641 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -86,6 +86,7 @@ struct KVMParkedVcpu {
 };
 
 KVMState *kvm_state;
+bool kvm_has_create_irqchip;
 bool kvm_kernel_irqchip;
 bool kvm_split_irqchip;
 bool kvm_async_interrupts_allowed;
@@ -2358,17 +2359,6 @@ static void kvm_irqchip_create(KVMState *s)
     int ret;
 
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
-    if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
-        ;
-    } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
-        ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
-        if (ret < 0) {
-            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
-            exit(1);
-        }
-    } else {
-        return;
-    }
 
     /* First probe and see if there's a arch-specific hook to create the
      * in-kernel irqchip for us */
@@ -2377,8 +2367,10 @@ static void kvm_irqchip_create(KVMState *s)
         if (s->kernel_irqchip_split == ON_OFF_AUTO_ON) {
             error_report("Split IRQ chip mode not supported.");
             exit(1);
-        } else {
+        } else if (kvm_has_create_irqchip) {
             ret = kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
+        } else {
+            return;
         }
     }
     if (ret < 0) {
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 115f0cca79d1..84b1bb3dc91e 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -32,6 +32,7 @@
 #ifdef CONFIG_KVM_IS_POSSIBLE
 
 extern bool kvm_allowed;
+extern bool kvm_has_create_irqchip;
 extern bool kvm_kernel_irqchip;
 extern bool kvm_split_irqchip;
 extern bool kvm_async_interrupts_allowed;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f4980..2fa87b495d68 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -250,6 +250,9 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
+
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
+
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ebfaf3d24c79..6363e67f092d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2771,6 +2771,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_IRQCHIP);
+
     return 0;
 }
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349d9..bcc735227f7d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -391,6 +391,17 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
+
+    kvm_has_create_irqchip = kvm_check_extension(s, KVM_CAP_S390_IRQCHIP);
+    if (kvm_has_create_irqchip) {
+        int ret = kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
+
+        if (ret < 0) {
+            fprintf(stderr, "Enable kernel irqchip failed: %s\n", strerror(-ret));
+            exit(1);
+        }
+    }
+
     return 0;
 }
 
-- 
2.41.0


