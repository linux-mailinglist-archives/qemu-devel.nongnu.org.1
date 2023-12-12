Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE480F2CF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5ex-0002VW-PJ; Tue, 12 Dec 2023 11:31:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5es-0001zL-Pn
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:58 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ep-0007Ro-Nq
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:58 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54dca2a3f16so10793274a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398654; x=1703003454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fk9JJHzitncXlk5Oc4PyYe0vp1fu8mtq0o6tXQCqyhw=;
 b=MYba3rtNgyOHnh9KPOmYhlc+JgGrATWUqnW4GgGEznyQembBZ3GwAuF9nzcVVB4oKd
 qt8gGlnJLDcY/8Dtb5+WsCUFEQncZ9qTcoxU4rDopduyeGM3eW00AiqwCm/ktCdBIGdE
 C/C9wxGiq4wQknIIFur0P79jrtX3bV1sxKC+Ah9droWydd+Igj7GkpcKADpVibBi2OUK
 H5IySMAQDpIVdp31YhgPOumgUR+s+Jzpfz1/jWvtWW+2NOOFF74kbtLMRsB8U0FnWDjv
 NODPSwZ/q/UAiiEnoSdOhNZEv2b/niGJCF0PZJFiV94fsQWDtIe5RXkI6zw1Q2lhwkFA
 Oj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398654; x=1703003454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fk9JJHzitncXlk5Oc4PyYe0vp1fu8mtq0o6tXQCqyhw=;
 b=Ni9AVZQUd1o11LOGEFXNCgH99EC9UoNp6UDkJbsTk1/3KTS2t9tTKLrZZ9ORW8GuxN
 kSp7ewta/kBJXNEZMcspL95RiXUun3/l3/BXtI2Jdk3JV+sB5c5aeykzy9mKYBbsRynS
 LwHgeVQ04tzXbuAUq8HVV9FuVQxU2bzdU9I5X558Xzc7uduyfgQxPefHRyToFsYnzdEG
 nQE50xb8scyy0H1nrZOpmF7uup8pDXaGp32ddue5qHWcc16UQ+YnhdqKO/vJLMBkhdix
 WvgsEMkytseNIloAf4D5ZCe8r3zeW5S+AoTAlgBuLkyg/S+HHN8LlOZSqV2Clt3BbISK
 FfLw==
X-Gm-Message-State: AOJu0Yxzv76FqTaf+0XrmpeOXnQjOBxq9vSYhSpTUVuBbvigDAmmEdwU
 rD7Lb7VGwpHiEpKi2bku/ch2CF0wUT/7INowBIA=
X-Google-Smtp-Source: AGHT+IHCfIPfE4fEwDyyFMjmaGejqoIGvfIwWtE/oswuYPmcgEXdfF5BPycsGGn8xaXL3QMiy1vmXQ==
X-Received: by 2002:a17:906:847a:b0:a1b:760c:e4de with SMTP id
 hx26-20020a170906847a00b00a1b760ce4demr7480701ejc.15.1702398654234; 
 Tue, 12 Dec 2023 08:30:54 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 da7-20020a056402176700b0054ca2e83d4bsm4804788edb.17.2023.12.12.08.30.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/33] hw/cpu/arm: Introduce abstract CORTEX_MPCORE_PRIV QOM
 type
Date: Tue, 12 Dec 2023 17:29:10 +0100
Message-ID: <20231212162935.42910-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

This type will be common to A9MPCORE/A15MPCORE devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h | 21 +++++++++++++++++++++
 hw/cpu/cortex_mpcore.c         | 22 ++++++++++++++++++++++
 hw/arm/Kconfig                 |  3 +++
 hw/cpu/meson.build             |  1 +
 4 files changed, 47 insertions(+)
 create mode 100644 hw/cpu/cortex_mpcore.c

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 9147f35c2a..c5dd7200d0 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -17,6 +17,27 @@
 #include "hw/timer/a9gtimer.h"
 #include "hw/timer/arm_mptimer.h"
 
+/*
+ * This is a model of the Arm Cortex-A MPCore family of hardware.
+ *
+ * The A7 and A15 MPCore contain:
+ *  up to 4 Cortex-A cores
+ *  a GIC
+ * The A9 MPCore additionally contains:
+ *  a System Control Unit
+ *  some timers and watchdogs
+ */
+#define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
+OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
+
+struct CortexMPPrivClass {
+    SysBusDeviceClass parent_class;
+};
+
+struct CortexMPPrivState {
+    SysBusDevice parent_obj;
+};
+
 #define TYPE_A9MPCORE_PRIV "a9mpcore_priv"
 OBJECT_DECLARE_SIMPLE_TYPE(A9MPPrivState, A9MPCORE_PRIV)
 
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
new file mode 100644
index 0000000000..7d3796bd69
--- /dev/null
+++ b/hw/cpu/cortex_mpcore.c
@@ -0,0 +1,22 @@
+/*
+ * Cortex-MPCore internal peripheral emulation.
+ *
+ * Copyright (c) 2023 Linaro Limited.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cpu/cortex_mpcore.h"
+
+static const TypeInfo cortex_mpcore_types[] = {
+    {
+        .name           = TYPE_CORTEX_MPCORE_PRIV,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(CortexMPPrivState),
+        .class_size     = sizeof(CortexMPPrivClass),
+        .abstract       = true,
+    },
+};
+
+DEFINE_TYPES(cortex_mpcore_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3ada335a24..3040342fcb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -643,6 +643,9 @@ config ZAURUS
     select NAND
     select ECC
 
+config CORTEX_MPCORE
+    bool
+
 config A9MPCORE
     bool
     select A9_GTIMER
diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
index 6d319947ca..8b376d6e7c 100644
--- a/hw/cpu/meson.build
+++ b/hw/cpu/meson.build
@@ -2,5 +2,6 @@ system_ss.add(files('core.c', 'cluster.c'))
 
 system_ss.add(when: 'CONFIG_ARM11MPCORE', if_true: files('arm11mpcore.c'))
 system_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview_mpcore.c'))
+specific_ss.add(when: 'CONFIG_CORTEX_MPCORE', if_true: files('cortex_mpcore.c'))
 specific_ss.add(when: 'CONFIG_A9MPCORE', if_true: files('a9mpcore.c'))
 specific_ss.add(when: 'CONFIG_A15MPCORE', if_true: files('a15mpcore.c'))
-- 
2.41.0


