Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3468F83204B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYg6-0004DZ-Iv; Thu, 18 Jan 2024 15:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfz-0003qX-MY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYfw-0006z8-Tl
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:07:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e90163be1so336095e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608463; x=1706213263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6w1iFT2RaAu4CDh7Rs92padfv2CQrVGTqWTSowRX6NU=;
 b=ynXEujcMlogdBay1SNflb5sul/3AL9/a2GRlG7VuPlYaYtPNug8sd3Nfk/ZBaeRdAG
 2RS8Zc3U0Z5HdicamtJH/WHMh+Kgrij28Py8dysnETcjYm01T/4toJ/rVgI0OYJrb6T7
 oPF29zMxwCDd/rfMzoUHXwm0EUF1oCUEp5f9Zzelig3KUkE+mfdsceEdSoZCil5TF9AQ
 drc2giwsJIzdhiw744kliT/ENV+JXlu4yvR4Cs6woV8bWk1OHH6D0LPhg0wAm2tzzKT3
 4UmePOOw/5/UDzy1EvZdw/mMLmm9P7pfP7VDT1F2FC+dtdA6oWmWpdJW4KTh6pmeECf5
 JXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608463; x=1706213263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6w1iFT2RaAu4CDh7Rs92padfv2CQrVGTqWTSowRX6NU=;
 b=aeVdAwJZEg4gCQhJiH+mp0zKhWWUTAaIreR4+r9U3OPslxt2NxyWorCA5+VStP1BgD
 91iTnEOv18g75qJQIa9lrItCXJ/Q77Gc4GvqHI/sX+58ex68gzz8TB75g3gSJl7B/R1M
 l4B5wYYe8Fo8rYwGhKBlYeW5JvnEN8vIo0i0s/M8iBgfBuGAtCwQABY87sOw+OLjiY5l
 T6YrZEXpl38W4Wbtu6ujEovYkdcVNAfPJntCC4Zp3UrOmQ6BGqqOm2rye1w/93cFlFRF
 qjYjgrFHV1Ur8awa+ibccvMfHs5HKXB/VWZ2hcjQ/iPY1rGsV5ILQBy7UtgSUU/2I6Re
 aqZg==
X-Gm-Message-State: AOJu0Yx0o/tsFYjrgYGalEd8WSr0iYU3/Sl2+FSO8xWkA8XEVyTfl7pf
 GhX1obgwSCCAItqceqaYQ8jupV2bELnoB6b5V0puPjnJUXWFaAe+l9YgumMTBtVdtbYsH/goK6a
 6aHbMxNId
X-Google-Smtp-Source: AGHT+IGQufmtnUbC5TaYe/skrc2byrkECD8RNfnBzhK5eV/iYB6W5CLJ7ZFQRf8tXYUyzihV/oaQjw==
X-Received: by 2002:a05:600c:331b:b0:40e:5f01:6209 with SMTP id
 q27-20020a05600c331b00b0040e5f016209mr464662wmp.37.1705608463223; 
 Thu, 18 Jan 2024 12:07:43 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 je14-20020a05600c1f8e00b0040e3635ca65sm30698740wmb.2.2024.01.18.12.07.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:07:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 10/20] target/arm: Expose arm_cpu_mp_affinity() in
 'multiprocessing.h' header
Date: Thu, 18 Jan 2024 21:06:31 +0100
Message-ID: <20240118200643.29037-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Declare arm_cpu_mp_affinity() prototype in the new
 "target/arm/multiprocessing.h" header so units in
hw/arm/ can use it without having to include the huge
target-specific "cpu.h".

File list to include the new header generated using:

  $ git grep -lw arm_cpu_mp_affinity

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h             |  6 +-----
 target/arm/multiprocessing.h | 16 ++++++++++++++++
 hw/arm/virt-acpi-build.c     |  1 +
 hw/arm/virt.c                |  1 +
 hw/arm/xlnx-versal-virt.c    |  1 +
 hw/misc/xlnx-versal-crl.c    |  1 +
 target/arm/arm-powerctl.c    |  1 +
 target/arm/cpu.c             |  5 +++++
 target/arm/hvf/hvf.c         |  1 +
 target/arm/tcg/psci.c        |  1 +
 10 files changed, 29 insertions(+), 5 deletions(-)
 create mode 100644 target/arm/multiprocessing.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d1584bdb3b..cecac4c0a1 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -26,6 +26,7 @@
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
 #include "qapi/qapi-types-common.h"
+#include "target/arm/multiprocessing.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -1173,11 +1174,6 @@ void arm_cpu_post_init(Object *obj);
 
 uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz);
 
-static inline uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
-{
-    return cpu->mp_affinity;
-}
-
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_arm_cpu;
 
diff --git a/target/arm/multiprocessing.h b/target/arm/multiprocessing.h
new file mode 100644
index 0000000000..81715d345c
--- /dev/null
+++ b/target/arm/multiprocessing.h
@@ -0,0 +1,16 @@
+/*
+ * ARM multiprocessor CPU helpers
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_MULTIPROCESSING_H
+#define TARGET_ARM_MULTIPROCESSING_H
+
+#include "target/arm/cpu-qom.h"
+
+uint64_t arm_cpu_mp_affinity(ARMCPU *cpu);
+
+#endif
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 2127778c1e..43ccc60f43 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -59,6 +59,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/multiprocessing.h"
 
 #define ARM_SPI_BASE 32
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 34cba9ebd8..beba151620 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -74,6 +74,7 @@
 #include "hw/arm/smmuv3.h"
 #include "hw/acpi/acpi.h"
 #include "target/arm/internals.h"
+#include "target/arm/multiprocessing.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 841ef69df6..29f4d2c2dc 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
+#include "target/arm/multiprocessing.h"
 #include "qom/object.h"
 
 #define TYPE_XLNX_VERSAL_VIRT_MACHINE MACHINE_TYPE_NAME("xlnx-versal-virt")
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index 9bfa9baa15..1f1762ef16 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -19,6 +19,7 @@
 #include "hw/resettable.h"
 
 #include "target/arm/arm-powerctl.h"
+#include "target/arm/multiprocessing.h"
 #include "hw/misc/xlnx-versal-crl.h"
 
 #ifndef XLNX_VERSAL_CRL_ERR_DEBUG
diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 6c86e90102..2b2055c6ac 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "sysemu/tcg.h"
+#include "target/arm/multiprocessing.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0bbba48faa..89e44a31fd 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1314,6 +1314,11 @@ uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
 }
 
+uint64_t arm_cpu_mp_affinity(ARMCPU *cpu)
+{
+    return cpu->mp_affinity;
+}
+
 static void arm_cpu_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 659401e12c..71a26db188 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -28,6 +28,7 @@
 #include "arm-powerctl.h"
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
+#include "target/arm/multiprocessing.h"
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
index 50d4b23d26..51d2ca3d30 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/tcg/psci.c
@@ -24,6 +24,7 @@
 #include "sysemu/runstate.h"
 #include "internals.h"
 #include "arm-powerctl.h"
+#include "target/arm/multiprocessing.h"
 
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
 {
-- 
2.41.0


