Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EBDB04CA1
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 02:02:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6P-0001zW-Td; Mon, 14 Jul 2025 20:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6L-0001ig-IO
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:53 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6I-00083l-KP
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:53 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7d45f5fde50so465429485a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537649; x=1753142449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yd7LTn2YUlDT9S5rPLAcwZ///WOqOGbERBjMl7uiB8Y=;
 b=QPiNyiSw6Y/NosDIOsrLJLhHi8ZX96SwJXkQolnqR9Kp0NcCXgsBndXXvr8ppNiT3y
 fyasfU0lQW8btAZsErdxllxGEUmyk1eNCM5TnIIco4ADXUKz6MWP8asU7i5LEu2HP/5n
 TYFURLjsywEEbNaxLx4sBNvwGgMawa80bQlt149Hv7I5AKut7VDZlqsiYCh4vnUjvHNG
 vA6X1YlwcDhbSuepAq5tO6aY0wL6guclhq7quPu5xo0GsFHsLzAkWbbO6WJWf1sQ1nRY
 1yjrIK0F78XKiSfa9c5FquKtLkZ5/ohXxOWZbKylJ8Vl7siiv1uP1balFfe+f7D9wzA+
 +RRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537649; x=1753142449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yd7LTn2YUlDT9S5rPLAcwZ///WOqOGbERBjMl7uiB8Y=;
 b=BcsmxJqCKCbbxw6lCIEO7PnpyakZfGEAsPnXJ73/NI/Am9M23nWmwLjo3Phy4AZeGQ
 V+5oe3YxMNAGLT9Xh3MJkxUkS7xm1AqVX3lViixX2ay9KsI4+L91lcWGIyQKffka34Bv
 wwWgVCCLQXv0xc+0VMOL++d0IGuRXCGnZ0cmjXqMDcFZ5XcXlHuBc9yiPJSJ37ytrZQG
 C6lQ2aBrgGO7vM3z4OMFlupdX+Cut9WDQyRUAr/GpRDLTJLreTNO7eeNuu79r24yAR4S
 IANMkKTUSS+Zfb8j9Endv17uqebITe8eEyunkC64Uf/zFn4MkheSHc9q/b+bbwEvzq+x
 57wg==
X-Gm-Message-State: AOJu0Ywlb49g3jlQLSAPCudZzGvWA6hvezy3oDNKWBg7zjHMAVedJL0S
 X03QPhS+HKfVoZtnhD1Ur2Fd5EG1Sgk4Ih8M0Eio2sJ42mUFZMUQMyVfl1s8AQ==
X-Gm-Gg: ASbGnctwi8ZzO64qj5MVN3xsuZ5lex6PVLHVgKXMEImMLkHe0PR/fF+umNkLyj0JOpT
 iehHBRPcRLF1NenSpQsrRdfBzof+u4HT6gQwd1oFvog6SQWGL0vadpK3VqFmKhITS36ejth1UwJ
 kVwDKJQkB42HcpuH3jzr/3IfYnu64F3cH0ek1tzIgsgdl4jg/Xx/bs74nSr5wg105Dss4nW/ucl
 ++darWxbe/gTq4PxJmvzCXcBf9a+Iifizxobu99mZ5H81FgYCs1SBOUlK7zS+h3Ey83GaRFL6j9
 P3cgFjj8jlqvrMnipIa5OC9+S2lJhwq7obuCKCYZ787HXU6opp/TiNf2npdDJPSOXrIfEDxibyI
 qoPHDUHW76Rl++QBn7EdczyWXvjS8VUtAidUm1w1PvUwN77Q=
X-Google-Smtp-Source: AGHT+IEM3NiZk7sLzKjqt0FqVyivaIUIhts0jgwcRZ6UoEc/+ezYadYvpu1DEhvoGvI5hbxzGKbkjA==
X-Received: by 2002:a05:620a:170b:b0:7e2:e209:ffda with SMTP id
 af79cd13be357-7e338bc431fmr171674985a.6.1752537648966; 
 Mon, 14 Jul 2025 17:00:48 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:48 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 02/11] MAX78000: ICC Implementation
Date: Mon, 14 Jul 2025 20:00:36 -0400
Message-Id: <20250715000045.57332-3-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=jackson88044@gmail.com; helo=mail-qk1-x72a.google.com
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

This commit implements the Instruction Cache Controller
for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                 |   1 +
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_icc.c         | 120 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 include/hw/misc/max78000_icc.h |  33 +++++++++
 5 files changed, 158 insertions(+)
 create mode 100644 hw/misc/max78000_icc.c
 create mode 100644 include/hw/misc/max78000_icc.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ddaafa8faa..e3b419b468 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -366,6 +366,7 @@ config ALLWINNER_R40
 config MAX78000_SOC
     bool
     select ARM_V7M
+    select MAX78000_ICC
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index ec0fa5aa9f..781bcf74cc 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_ICC
+    bool
+
 config MOS6522
     bool
 
diff --git a/hw/misc/max78000_icc.c b/hw/misc/max78000_icc.c
new file mode 100644
index 0000000000..6f7d2b20bf
--- /dev/null
+++ b/hw/misc/max78000_icc.c
@@ -0,0 +1,120 @@
+/*
+ * MAX78000 Instruction Cache
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_icc.h"
+
+
+static uint64_t max78000_icc_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Max78000IccState *s = opaque;
+    switch (addr) {
+    case ICC_INFO:
+        return s->info;
+
+    case ICC_SZ:
+        return s->sz;
+
+    case ICC_CTRL:
+        return s->ctrl;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+
+    }
+}
+
+static void max78000_icc_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000IccState *s = opaque;
+
+    switch (addr) {
+    case ICC_CTRL:
+        s->ctrl = 0x10000 | (val64 & 1);
+        break;
+
+    case ICC_INVALIDATE:
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps max78000_icc_ops = {
+    .read = max78000_icc_read,
+    .write = max78000_icc_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription max78000_icc_vmstate = {
+    .name = TYPE_MAX78000_ICC,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(info, Max78000IccState),
+        VMSTATE_UINT32(sz, Max78000IccState),
+        VMSTATE_UINT32(ctrl, Max78000IccState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_icc_reset_hold(Object *obj, ResetType type)
+{
+    Max78000IccState *s = MAX78000_ICC(obj);
+    s->info = 0;
+    s->sz = 0x10000010;
+    s->ctrl = 0x10000;
+}
+
+static void max78000_icc_init(Object *obj)
+{
+    Max78000IccState *s = MAX78000_ICC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_icc_ops, s,
+                        TYPE_MAX78000_ICC, 0x800);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void max78000_icc_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.hold = max78000_icc_reset_hold;
+    dc->vmsd = &max78000_icc_vmstate;
+}
+
+static const TypeInfo max78000_icc_info = {
+    .name          = TYPE_MAX78000_ICC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000IccState),
+    .instance_init = max78000_icc_init,
+    .class_init    = max78000_icc_class_init,
+};
+
+static void max78000_icc_register_types(void)
+{
+    type_register_static(&max78000_icc_info);
+}
+
+type_init(max78000_icc_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d47de482c..a21a994ff8 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
   'npcm_gcr.c',
diff --git a/include/hw/misc/max78000_icc.h b/include/hw/misc/max78000_icc.h
new file mode 100644
index 0000000000..6fe2bb7a15
--- /dev/null
+++ b/include/hw/misc/max78000_icc.h
@@ -0,0 +1,33 @@
+/*
+ * MAX78000 Instruction Cache
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MAX78000_ICC_H
+#define HW_MAX78000_ICC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_ICC "max78000-icc"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000IccState, MAX78000_ICC)
+
+#define ICC_INFO       0x0
+#define ICC_SZ         0x4
+#define ICC_CTRL       0x100
+#define ICC_INVALIDATE 0x700
+
+struct Max78000IccState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t info;
+    uint32_t sz;
+    uint32_t ctrl;
+};
+
+#endif
-- 
2.34.1


