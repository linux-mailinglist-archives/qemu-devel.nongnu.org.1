Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29283204E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgs-0006tj-Kd; Thu, 18 Jan 2024 15:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgp-0006jq-Sc
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:39 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgn-00077y-Ss
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:39 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-337d6d7fbd5so444076f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608516; x=1706213316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MFamDoDB+NPTBY+FXQ/CqwTtVqrO47PjF46IOrgJo58=;
 b=Mz9xioJXiebR/6aF3RgKMqQp7htcThNP7pex93nB2QDgkLWRFSwZFpK3/q1kHubdMF
 Z0X/csoPZGGnXPww8EiWh0BIi37tpgUrQjdiI8Dj2c+c1JrRpQtHk8trmn9L5nMoekuh
 iWCQGBT5NaL3WAq5yO7fJk7UeJPjtGA+nsad3gC80atpLhGICtddvrJbYQ2zsVE7MFn/
 bHHMCLFinrH45Q09jyWd11TAiDhY3XzvIIpCOiXxc+gDTkdsJTldCkziRggaRMjFs9kj
 YPjOXctGclLqCJGc4ybfuIxGDoiR6CxSqSQ6n415G861Vrt1QabW0itCEWS6trvRu6yf
 PmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608516; x=1706213316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MFamDoDB+NPTBY+FXQ/CqwTtVqrO47PjF46IOrgJo58=;
 b=CSk2VlS70kptGIjqI6jA/SqlNkjwSvfhQS5xtnmoXPhl94fDJk2rMyNlzrCUQUtQ76
 M20KwIqGk0kBvBxc2GbkinwYMHfmsP/TXZL4F7PwRJ3ntLudQsVyyrs1jIfeqQLVCsqs
 he9+hI1nBLZmcPYhkOEqwDPvK6http4RzNPaeySqIQ3Xrhs8LHcuYPvzZfNT4Fx7VTYh
 gJ3jxsuXr5hrnrFs5nk/MddHx4WWFMKN1sQh3dH6/l1TYRucw6XeejYpCDx6vjPnie6G
 AyTDnmx4kaCJgTRfYJMAT2SLn0RWixS0394t3WgiixWCltdQAe4majAVIYJTbufP83lf
 18fw==
X-Gm-Message-State: AOJu0YxA79kE9dCtOJz9ialwGG0Oq0do8GFd4xTPv1FtZ8p6BonAFLKG
 jrhgH26ujpeyGQAfl1Us6zSaiDObaLos4xe7+y+BRMDOAJj3fcAtUOg93Y/4ODHJaSQYkolxqdz
 +LcqgMTPz
X-Google-Smtp-Source: AGHT+IHYOiJSym2D2yYrltSEDp/Akd8MvzHd3DpgP3oiybk3/olKKAnKTXjU/wbLiQn1O5KNopUAhQ==
X-Received: by 2002:adf:8b9e:0:b0:337:bea4:49a9 with SMTP id
 o30-20020adf8b9e000000b00337bea449a9mr1473271wra.11.1705608515800; 
 Thu, 18 Jan 2024 12:08:35 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adf9d8d000000b00337bcae5eb1sm4765640wre.72.2024.01.18.12.08.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:35 -0800 (PST)
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
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 19/20] target/arm: Move GTimer definitions to new 'gtimer.h'
 header
Date: Thu, 18 Jan 2024 21:06:40 +0100
Message-ID: <20240118200643.29037-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Move Arm A-class Generic Timer definitions to the new
"target/arm/gtimer.h" header so units in hw/ which don't
need access to ARMCPU internals can use them without
having to include the huge "cpu.h".

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h       |  8 +-------
 target/arm/gtimer.h    | 21 +++++++++++++++++++++
 hw/arm/allwinner-h3.c  |  1 +
 hw/arm/allwinner-r40.c |  1 +
 hw/arm/bcm2836.c       |  1 +
 hw/arm/sbsa-ref.c      |  1 +
 hw/arm/virt.c          |  1 +
 hw/arm/xlnx-versal.c   |  1 +
 hw/arm/xlnx-zynqmp.c   |  1 +
 hw/cpu/a15mpcore.c     |  1 +
 target/arm/cpu.c       |  1 +
 target/arm/helper.c    |  1 +
 target/arm/hvf/hvf.c   |  1 +
 target/arm/kvm.c       |  1 +
 target/arm/machine.c   |  1 +
 15 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 target/arm/gtimer.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e8df41d642..d3477b1601 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -27,6 +27,7 @@
 #include "exec/cpu-defs.h"
 #include "qapi/qapi-types-common.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
@@ -140,13 +141,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-#define GTIMER_PHYS     0
-#define GTIMER_VIRT     1
-#define GTIMER_HYP      2
-#define GTIMER_SEC      3
-#define GTIMER_HYPVIRT  4
-#define NUM_GTIMERS     5
-
 #define VTCR_NSW (1u << 29)
 #define VTCR_NSA (1u << 30)
 #define VSTCR_SW VTCR_NSW
diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
new file mode 100644
index 0000000000..b992941bef
--- /dev/null
+++ b/target/arm/gtimer.h
@@ -0,0 +1,21 @@
+/*
+ * ARM generic timer definitions for Arm A-class CPU
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef TARGET_ARM_GTIMER_H
+#define TARGET_ARM_GTIMER_H
+
+enum {
+    GTIMER_PHYS     = 0,
+    GTIMER_VIRT     = 1,
+    GTIMER_HYP      = 2,
+    GTIMER_SEC      = 3,
+    GTIMER_HYPVIRT  = 4,
+#define NUM_GTIMERS   5
+};
+
+#endif
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 2d684b5287..380e0ec11d 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -31,6 +31,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 /* Memory map */
 const hwaddr allwinner_h3_memmap[] = {
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 65392dbc23..898bef9d93 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -33,6 +33,7 @@
 #include "hw/arm/allwinner-r40.h"
 #include "hw/misc/allwinner-r40-dramc.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 /* Memory map */
 const hwaddr allwinner_r40_memmap[] = {
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 58a78780d2..e3ba18a8ec 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -16,6 +16,7 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 struct BCM283XClass {
     /*< private >*/
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index d6081bfc41..85cb68d546 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -51,6 +51,7 @@
 #include "qapi/qmp/qlist.h"
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0ab5fd9477..bdfcf028a0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -76,6 +76,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/generic_event_device.h"
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 87fdb39d43..2798df3730 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -24,6 +24,7 @@
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 38cb34942f..65901c6e74 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -26,6 +26,7 @@
 #include "sysemu/sysemu.h"
 #include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 #define GIC_NUM_SPI_INTR 160
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index bfd8aa5644..967d8d3dd5 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "target/arm/gtimer.h"
 
 static void a15mp_priv_set_irq(void *opaque, int irq, int level)
 {
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07357daabe..4c57b9c3b8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -49,6 +49,7 @@
 #include "fpu/softfloat.h"
 #include "cpregs.h"
 #include "target/arm/cpu-qom.h"
+#include "target/arm/gtimer.h"
 
 static void arm_cpu_set_pc(CPUState *cs, vaddr value)
 {
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1ef00e50e4..39e2ba25c8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -30,6 +30,7 @@
 #include "semihosting/common-semi.h"
 #endif
 #include "cpregs.h"
+#include "target/arm/gtimer.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 71a26db188..e5f0f60093 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -29,6 +29,7 @@
 #include "target/arm/cpu.h"
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
+#include "target/arm/gtimer.h"
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8f52b211f9..81813030a5 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -38,6 +38,7 @@
 #include "qemu/log.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
+#include "target/arm/gtimer.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 542be14bec..9d7dbaea54 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -7,6 +7,7 @@
 #include "internals.h"
 #include "cpu-features.h"
 #include "migration/cpu.h"
+#include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
 {
-- 
2.41.0


