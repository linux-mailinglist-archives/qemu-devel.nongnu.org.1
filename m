Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FBF72B17E
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 13:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8IoF-0003Or-Ov; Sun, 11 Jun 2023 07:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Io2-0003NV-Ip; Sun, 11 Jun 2023 07:00:22 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8Io0-0004gk-QE; Sun, 11 Jun 2023 07:00:22 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-977c72b116fso499826866b.3; 
 Sun, 11 Jun 2023 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686481218; x=1689073218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vklZjjPpVfnPY+e4KfzgoQ0TDCdxDXCF36nsWKiPCe8=;
 b=CQhSTaYwr1LYuCSwYeiNWmkcGjC0+Gz1Z2zRnDiuANO/2+r0I9MapSjpzpJk7tqCoL
 BqvySjEzU5zcf6iaqqqzKDXX8QG+WFpqX+xDbQB+XhR27E5BDAIK0aiiREjGUenaFPF5
 FFiLRkMbnUwukYWgPkYa5dHyRyiy+PzGFEQOwwjk1Ghesm9idzgTc757qetpR7ki3xNV
 HaJxTlrH11Jrp2uNqIJuJp+z/6j2uvvGbJFpbl7NSYIkuM7aO0cn/y15X18GnTFnzo1r
 2aLe3IDRIfGbFNHY0YFQDKBaqvBlqlN+olWHsTdbX62nwst370P35MTwqVasbH4o9nnM
 SeMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686481218; x=1689073218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vklZjjPpVfnPY+e4KfzgoQ0TDCdxDXCF36nsWKiPCe8=;
 b=IVLlKuVzTUOEt8d96qWm5K6gZymPLzwi3DJMbNjsZMCrgTb3LGREro2iHHNrX/gxIz
 +YSWVK8vWjr7P/RE/RdtPF1uljv4lq36MlgjBpDkB5ChEfSr/QtNKbyyT/Im8EB9P/Ip
 cdW25Y4GHTrEdXYJI3cT0LCn620r7qUXUMat/0uPxEMeZB7AS9pBogLSxQKdkfJCJ9zm
 F44vDCVpBbbX7uuaqvvBLDJLd8tZlhoHLmYtyuWv6DWgDe6WWJ7wcON316WJdyGclE9U
 biw395rIe7AOeksPuj5+6SyIgpUlNXyABXZS9CurX8NZIJuopzyVAzzTZ41Fu2i5+KSY
 y/tQ==
X-Gm-Message-State: AC+VfDwrVj6L5G9xo13ys/LX/g/Tu7EroxakMLJmdHE8vVSJt3izD9Bt
 NEfzWyte++8/GcWwIiGfmHQpgnxS0hU=
X-Google-Smtp-Source: ACHHUZ4+dzfeAl/MNvOp4EBiW31ae5NyChLh5UvYH/leViHFEI6sWMedOQ17uvd7PRewL2PfAlJDGA==
X-Received: by 2002:a17:906:eec1:b0:977:4b68:bf2 with SMTP id
 wu1-20020a170906eec100b009774b680bf2mr5302777ejb.54.1686481218274; 
 Sun, 11 Jun 2023 04:00:18 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7c0.dynamic.kabel-deutschland.de.
 [95.91.215.192]) by smtp.gmail.com with ESMTPSA id
 n11-20020a1709062bcb00b00977eec7b7e8sm3708411ejg.68.2023.06.11.04.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 04:00:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] hw/char/parallel-isa: Export struct ISAParallelState
Date: Sun, 11 Jun 2023 13:00:08 +0200
Message-ID: <20230611110008.32638-3-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230611110008.32638-1-shentey@gmail.com>
References: <20230611110008.32638-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Allows the struct to be embedded directly into device models without additional
allocation.

Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 include/hw/char/parallel-isa.h | 46 ++++++++++++++++++++++++++++++++++
 include/hw/char/parallel.h     |  2 --
 hw/char/parallel-isa.c         |  1 +
 hw/char/parallel.c             | 12 +--------
 hw/i386/pc_piix.c              |  2 +-
 hw/i386/pc_q35.c               |  2 +-
 hw/isa/isa-superio.c           |  1 +
 hw/sparc64/sun4u.c             |  2 +-
 8 files changed, 52 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/char/parallel-isa.h

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
new file mode 100644
index 0000000000..27bdacf1a3
--- /dev/null
+++ b/include/hw/char/parallel-isa.h
@@ -0,0 +1,46 @@
+/*
+ * QEMU ISA Parallel PORT emulation
+ *
+ * Copyright (c) 2003-2005 Fabrice Bellard
+ * Copyright (c) 2007 Marko Kohtala
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef HW_PARALLEL_ISA_H
+#define HW_PARALLEL_ISA_H
+
+#include "parallel.h"
+
+#include "hw/isa/isa.h"
+#include "qom/object.h"
+
+#define TYPE_ISA_PARALLEL "isa-parallel"
+OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
+
+struct ISAParallelState {
+    ISADevice parent_obj;
+
+    uint32_t index;
+    uint32_t iobase;
+    uint32_t isairq;
+    ParallelState state;
+};
+
+#endif /* HW_PARALLEL_ISA_H */
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 9f76edca81..7b5a309a03 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -25,8 +25,6 @@ typedef struct ParallelState {
     PortioList portio_list;
 } ParallelState;
 
-#define TYPE_ISA_PARALLEL "isa-parallel"
-
 void parallel_hds_isa_init(ISABus *bus, int n);
 
 bool parallel_mm_init(MemoryRegion *address_space,
diff --git a/hw/char/parallel-isa.c b/hw/char/parallel-isa.c
index 547ae69304..ab0f879998 100644
--- a/hw/char/parallel-isa.c
+++ b/hw/char/parallel-isa.c
@@ -13,6 +13,7 @@
 #include "sysemu/sysemu.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "qapi/error.h"
 
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index e75fc5019d..147c900f0d 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -31,6 +31,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
 #include "migration/vmstate.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/parallel.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
@@ -73,17 +74,6 @@
 
 #define PARA_CTR_SIGNAL (PARA_CTR_SELECT|PARA_CTR_INIT|PARA_CTR_AUTOLF|PARA_CTR_STROBE)
 
-OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)
-
-struct ISAParallelState {
-    ISADevice parent_obj;
-
-    uint32_t index;
-    uint32_t iobase;
-    uint32_t isairq;
-    ParallelState state;
-};
-
 static void parallel_update_irq(ParallelState *s)
 {
     if (s->irq_pending)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 42af03dbb4..44146e6ff5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -26,7 +26,7 @@
 #include CONFIG_DEVICES
 
 #include "qemu/units.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/dma/i8257.h"
 #include "hw/loader.h"
 #include "hw/i386/x86.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6155427e48..a9a59ed42b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -30,7 +30,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 9292ec3bcf..7dbfc374da 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -21,6 +21,7 @@
 #include "hw/isa/superio.h"
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/char/serial.h"
 #include "trace.h"
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e2858a0331..29e9b6cc26 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -35,7 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
-#include "hw/char/parallel.h"
+#include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
 #include "hw/input/i8042.h"
-- 
2.41.0


