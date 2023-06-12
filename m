Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4E772B9FB
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 10:14:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8cfh-0001BY-QK; Mon, 12 Jun 2023 04:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfX-00016i-E2; Mon, 12 Jun 2023 04:12:55 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q8cfT-0002QK-OI; Mon, 12 Jun 2023 04:12:54 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-516a008e495so8322843a12.1; 
 Mon, 12 Jun 2023 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686557569; x=1689149569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZrRaLbKyB3JjbrsjDHlQ0IQMqKU63jRIBeKnYT/ejY=;
 b=eeXYKa9JJrW/raQgEaGU1fCpwqJaVIAJjt9+fAQpsHnGnkiAdS2J6eVgD5DJQl7R0d
 73j4T16SY7QH4AuY8kKu5AAF/vUyrnqYMQlNrctlPBiPaKrirX0X4oASsX3SKnEdDkOT
 I3WXrVzBZ+pnJWQSVk5MujZArwZNoBqtcrmVb/w/yPHMD9LxqGlSGcV3OMJNmRRT41Or
 ccXbSUI1SSFMKNo2709rE5eTWK31rCZdEDrD1a/ooqIf//KuS2Ae3x+pfHZlSKuim0NI
 YlLAx1V7/VCKKihTrEYHfUVl9Te4mgy+u5y2eCyeQJechCSTgks4ZcBSp3C+rsZ+VuVK
 sUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686557569; x=1689149569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZrRaLbKyB3JjbrsjDHlQ0IQMqKU63jRIBeKnYT/ejY=;
 b=ia+TIIUwXANxU8hDf4x7GXI+lBpvPzAq5/s8OIjoL5jFHmzqtK1WT7GYlBKh2dkb6G
 Wvhkbox3W7TcRu3eoFIQut5sGkVsmIw7mziLBEFMs2KnVIAZ0cBLBSbhut03gp+N+BKD
 GpWyYSc6k4r/yQBjOKX+W83STVNXO1fl3WQnCN9/ZWyL7h3yH3cR76EfNvqjbrAWRulx
 CdhZlq3RHC5Ytn+AW0yMKm6GgCmge3QunMxc6DvfgWdHYrudKkOPnMDQh8+gb6v6wDC8
 TJQ8qfTzsYJBLgN9vyMAMBezaMfpecYTwOJnvWJn9gUXKSC2Evk9L7AAILra7QYqSYCb
 DuKQ==
X-Gm-Message-State: AC+VfDxz2mo5uy66vruv7kZHj7Uo8ne16I1xuFeG1GAYtfrLQcwSNfW4
 iJHzHUVFSgPY9AiePMpcr9JP5SKKskE=
X-Google-Smtp-Source: ACHHUZ7M5olBo56WghgfqTBtI4+vV5G5xVteX0jp5hcZydBBRuOnBowP6qwx+FoFM6mbPyiFz/1p7Q==
X-Received: by 2002:a05:6402:35d1:b0:514:94be:323c with SMTP id
 z17-20020a05640235d100b0051494be323cmr5321579edc.10.1686557569388; 
 Mon, 12 Jun 2023 01:12:49 -0700 (PDT)
Received: from archlinux.. (ip5f5bd7f9.dynamic.kabel-deutschland.de.
 [95.91.215.249]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa7d617000000b005148e981bd3sm4678514edr.12.2023.06.12.01.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 01:12:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-trivial@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 2/2] hw/char/parallel-isa: Export struct ISAParallelState
Date: Mon, 12 Jun 2023 10:12:38 +0200
Message-ID: <20230612081238.1742-3-shentey@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612081238.1742-1-shentey@gmail.com>
References: <20230612081238.1742-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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


