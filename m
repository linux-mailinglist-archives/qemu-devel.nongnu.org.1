Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B7D7415F3
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXWq-0002xi-Pt; Wed, 28 Jun 2023 11:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVu-0002iN-De
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:29 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVr-0001jq-F1
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbb40ce844so769595e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967721; x=1690559721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ecemqV7ze+r2DrMxkx1H+BbOd9SrDRrytB3Or+dM4o=;
 b=cg0sdiwbPBVtyg59pjQHsb6gnWNTLqRmuulECBvQZcCuVRO+kc53flXydo5uHzqK4N
 2JW7ZEe1lfhWR2iQ1ntorSzF8Y+ebx5u541DBZfaB20arewKhQr+WVJ4vn1zVYTHAKfN
 IndNqx2Iu4gaWRDM/4Ou0Ur8zCPWQxAiGyHqxcB03UhjKWXS7TUgKxREr7FxKjkeTs2h
 goothHDNMN8/pskmWQoVdhu4IHIWHzZQgw8bjdAC14rjPxtKuE9zuwLdl6YzBsZ7ZRDg
 oUIOsVkBHplPeoe9kBMQjuqbKAr8eFGarX47jsrMOMItvGdXUtRBDMds9ZoPhIirwO/M
 YjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967721; x=1690559721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ecemqV7ze+r2DrMxkx1H+BbOd9SrDRrytB3Or+dM4o=;
 b=LNnT1bWzA75war3MCMvZDkq9KjK5bv00WdR/oicEo/nIrsOlI+9Nf6x8nT5Rs9Rev9
 otA79TMvWlVC6j0ey3cO0s92UtfQuigsrVmvx4uXVRU4+v0GWkp1PXszdrTakBXCxU+O
 Eje+HZiLVeWHi5Its0XdIUZGXYCfMk7PWvS/oDqRZly6hh7xNwaSsOrKmU3ahzcsM7Ij
 7p1645a2gxACYMw9Zks/h6HK8kT6Doelkawzfye9mW9OZgPiLbcP0ec087T5Qo7qI1xt
 Uxo0zARlFur2qptKLRKQRyCII9dzQJhxUbBGm+J4Xogs7Jl/J5boPPOGQ+q2AQxulivN
 PvIw==
X-Gm-Message-State: AC+VfDxQCXCydo0K1NCFn0DPsqDdsUmhDEYy0qI1go6x1vj/cqqFt5Eg
 83uCvIOAjnZLGC7EqCfzKKMLEDodTYoX6hc5RZ4=
X-Google-Smtp-Source: ACHHUZ5guB4QCCqL9uGDtrsHHy1rpYH0Uabg7BP4tff7oioEBkK7YrvB7FAS+YNQsYpze4wzBS9QsQ==
X-Received: by 2002:a05:600c:2054:b0:3fb:973:fdba with SMTP id
 p20-20020a05600c205400b003fb0973fdbamr6332256wmg.31.1687967721062; 
 Wed, 28 Jun 2023 08:55:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 n9-20020a1c7209000000b003fbacc853ccsm2955494wmc.18.2023.06.28.08.55.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:55:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/30] hw/intc/arm_gic: Un-inline GIC*/ITS class_name() helpers
Date: Wed, 28 Jun 2023 17:53:04 +0200
Message-Id: <20230628155313.71594-22-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

"kvm_arm.h" contains external and internal prototype declarations.
Files under the hw/ directory should only access the KVM external
API.

In order to avoid machine / device models to include "kvm_arm.h"
simply to get the QOM GIC/ITS class name, un-inline each class
name getter to the proper device model file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230405160454.97436-4-philmd@linaro.org>
---
 include/hw/intc/arm_gic.h              |  2 ++
 include/hw/intc/arm_gicv3_common.h     | 10 ++++++
 include/hw/intc/arm_gicv3_its_common.h |  9 ++++++
 target/arm/kvm_arm.h                   | 45 --------------------------
 hw/arm/sbsa-ref.c                      |  1 +
 hw/arm/virt-acpi-build.c               |  2 +-
 hw/arm/virt.c                          |  1 +
 hw/intc/arm_gic_common.c               |  7 ++++
 hw/intc/arm_gicv3_common.c             | 14 ++++++++
 hw/intc/arm_gicv3_its_common.c         | 12 +++++++
 10 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/include/hw/intc/arm_gic.h b/include/hw/intc/arm_gic.h
index 116ccbb5a9..48f6a51a70 100644
--- a/include/hw/intc/arm_gic.h
+++ b/include/hw/intc/arm_gic.h
@@ -86,4 +86,6 @@ struct ARMGICClass {
     DeviceRealize parent_realize;
 };
 
+const char *gic_class_name(void);
+
 #endif
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index ab5182a28a..4e2fb518e7 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -329,4 +329,14 @@ struct ARMGICv3CommonClass {
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
                               const MemoryRegionOps *ops);
 
+/**
+ * gicv3_class_name
+ *
+ * Return name of GICv3 class to use depending on whether KVM acceleration is
+ * in use. May throw an error if the chosen implementation is not available.
+ *
+ * Returns: class name to use
+ */
+const char *gicv3_class_name(void);
+
 #endif
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index a11a0f6654..7dc712b38d 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -122,5 +122,14 @@ struct GICv3ITSCommonClass {
     void (*post_load)(GICv3ITSState *s);
 };
 
+/**
+ * its_class_name:
+ *
+ * Return the ITS class name to use depending on whether KVM acceleration
+ * and KVM CAP_SIGNAL_MSI are supported
+ *
+ * Returns: class name to use or NULL
+ */
+const char *its_class_name(void);
 
 #endif
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 330fbe5c72..051a0da41c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -453,32 +453,6 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
 
 #endif
 
-static inline const char *gic_class_name(void)
-{
-    return kvm_irqchip_in_kernel() ? "kvm-arm-gic" : "arm_gic";
-}
-
-/**
- * gicv3_class_name
- *
- * Return name of GICv3 class to use depending on whether KVM acceleration is
- * in use. May throw an error if the chosen implementation is not available.
- *
- * Returns: class name to use
- */
-static inline const char *gicv3_class_name(void)
-{
-    if (kvm_irqchip_in_kernel()) {
-        return "kvm-arm-gicv3";
-    } else {
-        if (kvm_enabled()) {
-            error_report("Userspace GICv3 is not supported with KVM");
-            exit(1);
-        }
-        return "arm-gicv3";
-    }
-}
-
 /**
  * kvm_arm_handle_debug:
  * @cs: CPUState
@@ -516,23 +490,4 @@ void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr);
  */
 bool kvm_arm_verify_ext_dabt_pending(CPUState *cs);
 
-/**
- * its_class_name:
- *
- * Return the ITS class name to use depending on whether KVM acceleration
- * and KVM CAP_SIGNAL_MSI are supported
- *
- * Returns: class name to use or NULL
- */
-static inline const char *its_class_name(void)
-{
-    if (kvm_irqchip_in_kernel()) {
-        /* KVM implementation requires this capability */
-        return kvm_direct_msi_enabled() ? "arm-its-kvm" : NULL;
-    } else {
-        /* Software emulation based model */
-        return "arm-gicv3-its";
-    }
-}
-
 #endif
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index b774d80291..66500a5b08 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -36,6 +36,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/ahci_internal.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/loader.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4af0de8b24..55f2706bc9 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -48,12 +48,12 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/platform-bus.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 #include "sysemu/tpm.h"
-#include "kvm_arm.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3937e30477..3196db556e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -63,6 +63,7 @@
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/irq.h"
 #include "kvm_arm.h"
 #include "hw/firmware/smbios.h"
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index a379cea395..9702197856 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -21,10 +21,12 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "gic_internal.h"
 #include "hw/arm/linux-boot-if.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "sysemu/kvm.h"
 
 static int gic_pre_save(void *opaque)
 {
@@ -393,3 +395,8 @@ static void register_types(void)
 }
 
 type_init(register_types)
+
+const char *gic_class_name(void)
+{
+    return kvm_irqchip_in_kernel() ? "kvm-arm-gic" : "arm_gic";
+}
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 642a8243ed..2ebf880ead 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "hw/core/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/qdev-properties.h"
@@ -608,3 +609,16 @@ static void register_types(void)
 }
 
 type_init(register_types)
+
+const char *gicv3_class_name(void)
+{
+    if (kvm_irqchip_in_kernel()) {
+        return "kvm-arm-gicv3";
+    } else {
+        if (kvm_enabled()) {
+            error_report("Userspace GICv3 is not supported with KVM");
+            exit(1);
+        }
+        return "arm-gicv3";
+    }
+}
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index d7532a7a89..abaf77057e 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -24,6 +24,7 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "sysemu/kvm.h"
 
 static int gicv3_its_pre_save(void *opaque)
 {
@@ -158,3 +159,14 @@ static void gicv3_its_common_register_types(void)
 }
 
 type_init(gicv3_its_common_register_types)
+
+const char *its_class_name(void)
+{
+    if (kvm_irqchip_in_kernel()) {
+        /* KVM implementation requires this capability */
+        return kvm_direct_msi_enabled() ? "arm-its-kvm" : NULL;
+    } else {
+        /* Software emulation based model */
+        return "arm-gicv3-its";
+    }
+}
-- 
2.38.1


