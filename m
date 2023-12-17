Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA3A815FF3
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLj-0005bJ-Ad; Sun, 17 Dec 2023 09:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLb-0005W7-7o; Sun, 17 Dec 2023 09:42:27 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLY-0003Nq-Du; Sun, 17 Dec 2023 09:42:26 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a2335397e64so68982066b.2; 
 Sun, 17 Dec 2023 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824141; x=1703428941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmGXhtFJgF9uOUE5MJxQ9FYr9F44cmnBoYR6LGPhAWI=;
 b=Q92GZoC+bns/GZbBI2bTHaAWomADXutncKSpVv9QQk80r0MiD1qK4dGIg4sOhTWHz1
 R6MlzkYnSltTbM0o7RIbH2R6gy+3OSF/0cBrs+f2GKV9cJmgYBpB4TiRTzqWNXplYznX
 Kx3acFQepeLgUURgwpAnrxGOd+PUN+guhp1I/ZsxiD21gtgZHOzKxJMaRQG/UrTmro8u
 CwJfj4kx7/vJPkN8daZLZAtcUkHvjG7bOs07sH30BWilfSObWb1JdHF4W5f0liVd1Qww
 aLKd2a7O+C6FyV50UhJTP8a/L1XyMfc0Dgi2BBHrxBRU8ZlQZcYr11nt8kwHV6FYZ4kR
 xGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824141; x=1703428941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmGXhtFJgF9uOUE5MJxQ9FYr9F44cmnBoYR6LGPhAWI=;
 b=HEuYE3Iy/3WWBC1vDI3BQuNQlSOz1NbqFt1Sq8KRFl3Ry0QIkV9FfrkjswFz2cvUOH
 LPDKNbIqwtlA00s0MdBwhchRRAMepN99SjpzAb9ErsMiC+tgdH0GdxWlAP87nH1AjBns
 1lyJDS5DjDFAdUbz9qqUUApVhPNc+WP6iaMhiSF6qzPN5Gy8DVGDBhBy7QVWJUerp2Tu
 IdphVwH4bTcgUEvhQuTZJXhVjIUVEVv4myasqT1dQp0x79/LGnvFHujX3MkT+MnzcE+e
 t9AUdaCY1FogeS+2AA6zZWY3gWWIhqPVbFfGbCaio7TIuH3aPlTORHwAgWI3BUhdGSMl
 rcWw==
X-Gm-Message-State: AOJu0YxjZmVZl5XT+R2kq2VxKxfkJmXE01QPFFS4Q+LOTTyq8pvbafTa
 HOdwZSF3Va4dxAbz1UxWi6wiAze94Ac=
X-Google-Smtp-Source: AGHT+IFfzh683y4FIdESU20MnUM9VyEDBMXFzVLGD3TDMzF2w8ImWLysYkD35a/8ecpXd6tHgX2lyQ==
X-Received: by 2002:a17:906:5253:b0:a23:44e7:4a7b with SMTP id
 y19-20020a170906525300b00a2344e74a7bmr510829ejm.93.1702824140449; 
 Sun, 17 Dec 2023 06:42:20 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:19 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 08/12] hw/char/serial-isa: Export struct ISASerialState
Date: Sun, 17 Dec 2023 15:41:44 +0100
Message-ID: <20231217144148.15511-9-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

Exposing device structs in headers is encuraged by qdev guidelines.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/char/serial-isa.h | 50 ++++++++++++++++++++++++++++++++++++
 include/hw/char/serial.h     |  7 -----
 hw/char/serial-isa.c         | 14 +---------
 hw/i386/microvm-dt.c         |  2 +-
 hw/i386/microvm.c            |  2 +-
 hw/i386/pc.c                 |  2 +-
 hw/isa/isa-superio.c         |  2 +-
 hw/ppc/pnv.c                 |  2 +-
 hw/sparc64/sun4u.c           |  1 +
 9 files changed, 57 insertions(+), 25 deletions(-)
 create mode 100644 include/hw/char/serial-isa.h

diff --git a/include/hw/char/serial-isa.h b/include/hw/char/serial-isa.h
new file mode 100644
index 0000000000..4bd01ef45b
--- /dev/null
+++ b/include/hw/char/serial-isa.h
@@ -0,0 +1,50 @@
+/*
+ * QEMU 16550A UART emulation
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ * Copyright (c) 2008 Citrix Systems, Inc.
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
+#ifndef HW_SERIAL_ISA_H
+#define HW_SERIAL_ISA_H
+
+#include "serial.h"
+
+#include "hw/isa/isa.h"
+#include "qom/object.h"
+
+#define TYPE_ISA_SERIAL "isa-serial"
+OBJECT_DECLARE_SIMPLE_TYPE(ISASerialState, ISA_SERIAL)
+
+struct ISASerialState {
+    ISADevice parent_obj;
+
+    uint32_t index;
+    uint32_t iobase;
+    uint32_t isairq;
+    SerialState state;
+};
+
+#define MAX_ISA_SERIAL_PORTS 4
+
+void serial_hds_isa_init(ISABus *bus, int from, int to);
+
+#endif /* HW_SERIAL_ISA_H */
diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 8ba7eca3d6..fca32a532b 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -106,11 +106,4 @@ SerialMM *serial_mm_init(MemoryRegion *address_space,
                          qemu_irq irq, int baudbase,
                          Chardev *chr, enum device_endian end);
 
-/* serial-isa.c */
-
-#define MAX_ISA_SERIAL_PORTS 4
-
-#define TYPE_ISA_SERIAL "isa-serial"
-void serial_hds_isa_init(ISABus *bus, int from, int to);
-
 #endif
diff --git a/hw/char/serial-isa.c b/hw/char/serial-isa.c
index 141a6cb168..315982efb5 100644
--- a/hw/char/serial-isa.c
+++ b/hw/char/serial-isa.c
@@ -28,23 +28,11 @@
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi_aml_interface.h"
-#include "hw/char/serial.h"
-#include "hw/isa/isa.h"
+#include "hw/char/serial-isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
-OBJECT_DECLARE_SIMPLE_TYPE(ISASerialState, ISA_SERIAL)
-
-struct ISASerialState {
-    ISADevice parent_obj;
-
-    uint32_t index;
-    uint32_t iobase;
-    uint32_t isairq;
-    SerialState state;
-};
-
 static const int isa_serial_io[MAX_ISA_SERIAL_PORTS] = {
     0x3f8, 0x2f8, 0x3e8, 0x2e8
 };
diff --git a/hw/i386/microvm-dt.c b/hw/i386/microvm-dt.c
index b3049e4f9f..fc5db6ed7f 100644
--- a/hw/i386/microvm-dt.c
+++ b/hw/i386/microvm-dt.c
@@ -34,7 +34,7 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "sysemu/device_tree.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/sysbus.h"
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index ca55aecc3b..a39d382367 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -39,7 +39,7 @@
 #include "hw/intc/i8259.h"
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/display/ramfb.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/e820_memory_layout.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a8051feacd..1ddfcefbe4 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -27,7 +27,7 @@
 #include "hw/i386/pc.h"
 #include "hw/block/fdc.h"
 #include "hw/block/fdc-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel.h"
 #include "hw/hyperv/hv-balloon.h"
 #include "hw/i386/fw_cfg.h"
diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 99d2aa491b..74162f26be 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -23,7 +23,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/input/i8042.h"
 #include "hw/char/parallel-isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "trace.h"
 
 static void isa_superio_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0297871bdd..78a33832d3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -54,7 +54,7 @@
 #include "hw/ppc/pnv_pnor.h"
 
 #include "hw/isa/isa.h"
-#include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/rtc/mc146818rtc.h"
 
 #include <libfdt.h>
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 0d7b539ace..2f0aebfb29 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci-host/sabre.h"
 #include "hw/char/serial.h"
+#include "hw/char/serial-isa.h"
 #include "hw/char/parallel-isa.h"
 #include "hw/rtc/m48t59.h"
 #include "migration/vmstate.h"
-- 
2.43.0


