	by mail.lfdr.de (Postfix) with ESMTPS id E46689BD099
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 16:36:09 +0100 (CET)
	id 1t8LWK-0005cw-Bg; Tue, 05 Nov 2024 10:31:04 -0500
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LWG-0005Zg-G0
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:31:01 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t8LWD-00043Q-Uq
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 10:31:00 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f72c8fc1so5547597e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 07:30:57 -0800 (PST)
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730820656; x=1731425456;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcuMAuxPQk2Q5bxoaPmhXT9ZvPq6wqNgneX3rODU6Dc=;
 b=mbLqEdECzxhM4RZZuhFFzpfp/36EkuHSiHGEugua3uyFV1CceeqQOlibapvzKHKF/H
 Kt6QWaeOdQxrhWxSnlKXpXfPaIc5tg0aeL9GQb70uhiqOceXGkrleOEunUObT4VTmen+
 i7ylebrSSnQefBXRlCWofW/xgfN6EowFAAUQgwo4NtN5qeqZy7sW17WF/C8yEAAFXhOj
 timlkWE7ISivCQAuCR9k39MYZvv0rYudHVZnJGW1ea9uZpxLPH4r6ZUCau5GjQ0CfJDY
 R6XhmYXcuwn5dhPWbcfXNTEm0zCqgvH6j4P0bWOz0NGewB0ZhlftUbF4efeb9r6kz9uo
 PjOg==
 d=1e100.net; s=20230601; t=1730820656; x=1731425456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcuMAuxPQk2Q5bxoaPmhXT9ZvPq6wqNgneX3rODU6Dc=;
 b=KoeojZxWQP1e2TJlBbGmvNCpL9wa7jETD9xmy5/bor3A2wS+8TMT0d3PzkB6fU4upW
 rSSwINz20lJA6nMxqkTtFzWq+NOJ24Wd+qL++Q9U2fl9LfjqlSfzMss2d71E/9P5AN91
 mo93y/UgzoW8AdrxQbTUQwLj5iJlmgUW39ClP0M5XsXZUmhcCZOte1EP8xUdEDHfQVzW
 DFQCmej1f5VPIBo4A/uDanWpRiS4gszEKXfU2D9ijMAE8FIC9tLRX6vhLJzAIF+JnoFf
 k0hV/0THZO7xWSMdgueSeWsBlY/zPON0HwVe3+qg8CxBXr4+IYWoaYeNW3zeB71iYjy1
 6lnw==
X-Gm-Message-State: AOJu0YyXLZS2y7/r607CwZO2x8TFHa3gaQlm1wZbUSuRZMMJQuRXEdFE
 Q2gac6vtkZaOGju8fpH2Nvib/dTXhmamDKIvGBb42qc9OpExc67JpMqB+D+P1kiYYO6N1lKxgPx
 mFw==
X-Google-Smtp-Source: AGHT+IEjmEolNhrVTELaQZKIAM9LcdJoBwa+cYAw3b7/0vIotak8XF6U32bbjY+pLz3vzzVaHqDN9Q==
X-Received: by 2002:a05:6512:308a:b0:539:8d67:1b1b with SMTP id
 2adb3069b0e04-53b7ecf1ff6mr13196373e87.26.1730820656015; 
 Tue, 05 Nov 2024 07:30:56 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6aae3fcsm1419415a12.21.2024.11.05.07.30.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 07:30:55 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v7 07/15] hw/misc/pvpanic: Add MMIO interface
Date: Tue,  5 Nov 2024 16:30:14 +0100
Message-Id: <20241105153022.91101-8-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241105153022.91101-1-phil@philjordan.eu>
References: <20241105153022.91101-1-phil@philjordan.eu>
Content-Type: text/plain; charset=UTF-8
Received-SPF: neutral client-ip=2a00:1450:4864:20::12d;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
From: Alexander Graf <graf@amazon.com>
In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
platform device that we can use in embedded arm environments.

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v3:
 * Rebased on upstream, updated a header path

 hw/misc/Kconfig           |  4 +++
 hw/misc/meson.build       |  1 +
 hw/misc/pvpanic-mmio.c    | 61 +++++++++++++++++++++++++++++++++++++++
 include/hw/misc/pvpanic.h |  1 +
 4 files changed, 67 insertions(+)
 create mode 100644 hw/misc/pvpanic-mmio.c

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 1f1baa5dde9..5a6c1603b60 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -145,6 +145,10 @@ config PVPANIC_ISA
     depends on ISA_BUS
     select PVPANIC_COMMON
 
+config PVPANIC_MMIO
+    bool
+    select PVPANIC_COMMON
+
 config AUX
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index d02d96e403b..4de4db0a600 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -122,6 +122,7 @@ system_ss.add(when: 'CONFIG_ARMSSE_MHU', if_true: files('armsse-mhu.c'))
 
 system_ss.add(when: 'CONFIG_PVPANIC_ISA', if_true: files('pvpanic-isa.c'))
 system_ss.add(when: 'CONFIG_PVPANIC_PCI', if_true: files('pvpanic-pci.c'))
+system_ss.add(when: 'CONFIG_PVPANIC_MMIO', if_true: files('pvpanic-mmio.c'))
 system_ss.add(when: 'CONFIG_AUX', if_true: files('auxbus.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_hace.c',
diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
new file mode 100644
index 00000000000..56738efee53
--- /dev/null
+++ b/hw/misc/pvpanic-mmio.c
@@ -0,0 +1,61 @@
+/*
+ * QEMU simulated pvpanic device (MMIO frontend)
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/qdev-properties.h"
+#include "hw/misc/pvpanic.h"
+#include "hw/sysbus.h"
+#include "standard-headers/misc/pvpanic.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
+
+#define PVPANIC_MMIO_SIZE 0x2
+
+struct PVPanicMMIOState {
+    SysBusDevice parent_obj;
+
+    PVPanicState pvpanic;
+};
+
+static void pvpanic_mmio_initfn(Object *obj)
+{
+    PVPanicMMIOState *s = PVPANIC_MMIO_DEVICE(obj);
+
+    pvpanic_setup_io(&s->pvpanic, DEVICE(s), PVPANIC_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->pvpanic.mr);
+}
+
+static Property pvpanic_mmio_properties[] = {
+    DEFINE_PROP_UINT8("events", PVPanicMMIOState, pvpanic.events,
+                      PVPANIC_PANICKED | PVPANIC_CRASH_LOADED),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pvpanic_mmio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pvpanic_mmio_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo pvpanic_mmio_info = {
+    .name          = TYPE_PVPANIC_MMIO_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(PVPanicMMIOState),
+    .instance_init = pvpanic_mmio_initfn,
+    .class_init    = pvpanic_mmio_class_init,
+};
+
+static void pvpanic_register_types(void)
+{
+    type_register_static(&pvpanic_mmio_info);
+}
+
+type_init(pvpanic_register_types)
diff --git a/include/hw/misc/pvpanic.h b/include/hw/misc/pvpanic.h
index 9a71a5ad0d7..049a94c1125 100644
--- a/include/hw/misc/pvpanic.h
+++ b/include/hw/misc/pvpanic.h
@@ -26,6 +26,7 @@
 
 #define TYPE_PVPANIC_ISA_DEVICE "pvpanic"
 #define TYPE_PVPANIC_PCI_DEVICE "pvpanic-pci"
+#define TYPE_PVPANIC_MMIO_DEVICE "pvpanic-mmio"
 
 #define PVPANIC_IOPORT_PROP "ioport"
 
-- 
2.39.3 (Apple Git-145)