Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8481BA37
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf9-0008WV-4r; Thu, 21 Dec 2023 10:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKeu-0008IY-MC; Thu, 21 Dec 2023 10:08:26 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKes-0004Qv-Lz; Thu, 21 Dec 2023 10:08:24 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5532b45c286so1020320a12.0; 
 Thu, 21 Dec 2023 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171299; x=1703776099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc21D1GGvynIIeBFBQCCZYU8WGyS+4JieBQBphT8ERs=;
 b=bXpbKr6fXQBNIpHhMvxk/zCPZTM4e2tMm3TKGnwG6HuECKkAqBVnVrCmuQ07EykKL0
 cb7IIBLGWK4TC48jafHFxRT87H3UDZvAq7ZlSU6spIKIaJqpdYdxJMWWjEm79v2p9/Ur
 9R/y1IBQE7cE60OZzHl/AlRfrYWev8THrtDqiVzuqHa48LCOL0d8eUjG+A0PD2+3byLR
 /wZ7auUggGd2PqIcl1qzvbj2H+e3zpP54wYHVZPEq+0X8lOgf+4Tj/gc1nTfiFbglHLy
 Nxr1qIIhg70z0XiqDQU28xiZcxHmDi8wUuuv4N+2h6HyKvaAlgxWC4JVNo9ZeVPdmVZQ
 9urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171299; x=1703776099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc21D1GGvynIIeBFBQCCZYU8WGyS+4JieBQBphT8ERs=;
 b=VA0yqJLar0uruy61yM10qfeH8mYnYCo9qslL8Yb93c9hPlWfk3Qysz0xcQssgvAWqr
 PJGe/6hHOQ7TJvu8x0o+Ephw1rCpH0XV/IeXgbuB0fQS8PjNJ0rNlIyOSI4JKRnqEuMz
 WNBieb0ZHnlNBnv9bryoEy5xt9zMryJrwftq2xqkpcND1KqmltsIJTvR86fNbQNCq2ja
 C75ojzW6aq9Q8yy05Uzuc8KrjD+Gk4bjasKZgJjCs0gvMiDl1fZ/IHaulr6UU7H6ptp1
 rNWRLAVINF8XChhD82t2IBfLFlYJkp3vxWmBN0kgvj3U37NMaCe3YLG5VJ8fgBLCmnVN
 ZFWQ==
X-Gm-Message-State: AOJu0YzBf+3rvsJ9oROJDBrljMjpSqodHPJ5Y/IipOO7oLcpuq5CN5rm
 zgUsFQwWWtOcrI/S2win9KXg3pMQvKy2Mw==
X-Google-Smtp-Source: AGHT+IGwn2DltZlhBGwngmAj0rGqWWT/qPbvmce/2Pkk1i9yes56Wg8yvZhUJfKhCXOwrHXr4RiGzg==
X-Received: by 2002:a50:c014:0:b0:554:1b95:2634 with SMTP id
 r20-20020a50c014000000b005541b952634mr403969edb.20.1703171299360; 
 Thu, 21 Dec 2023 07:08:19 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:18 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 11/11] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Thu, 21 Dec 2023 16:07:50 +0100
Message-ID: <20231221150750.5435-12-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

The VIA south bridges are able to relocate and toggle (enable or disable) their
SuperI/O functions. So far this is hardcoded such that all functions are always
enabled and are located at fixed addresses.

Some PC BIOSes seem to probe for I/O occupancy before activating such a function
and issue an error in case of a conflict. Since the functions are currently
enabled on reset, conflicts are always detected. Prevent that by implementing
relocation and toggling of the SuperI/O functions.

Note that all SuperI/O functions are now deactivated upon reset (except for
VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
enabled by default). Rely on firmware to configure the functions accordingly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 115 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 84 insertions(+), 31 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 9c2333a277..983cb321b9 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -15,6 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/vt82c686.h"
+#include "hw/block/fdc.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/char/serial.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
@@ -343,6 +346,32 @@ static const TypeInfo via_superio_info = {
 
 #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
 
+static void vt82c686b_superio_update(ViaSuperIOState *s)
+{
+    isa_parallel_set_enabled(s->superio.parallel[0],
+                             (s->regs[0xe2] & 0x3) != 3);
+    isa_serial_set_enabled(s->superio.serial[0], s->regs[0xe2] & BIT(2));
+    isa_serial_set_enabled(s->superio.serial[1], s->regs[0xe2] & BIT(3));
+    isa_fdc_set_enabled(s->superio.floppy, s->regs[0xe2] & BIT(4));
+
+    isa_fdc_set_iobase(s->superio.floppy, (s->regs[0xe3] & 0xfc) << 2);
+    isa_parallel_set_iobase(s->superio.parallel[0], s->regs[0xe6] << 2);
+    isa_serial_set_iobase(s->superio.serial[0], (s->regs[0xe7] & 0xfe) << 2);
+    isa_serial_set_iobase(s->superio.serial[1], (s->regs[0xe8] & 0xfe) << 2);
+}
+
+static int vmstate_vt82c686b_superio_post_load(void *opaque, int version_id)
+{
+    vt82c686b_superio_update(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_vt82c686b_superio = {
+    .name = "vt82c686b_superio",
+    .version_id = 1,
+    .post_load = vmstate_vt82c686b_superio_post_load,
+};
+
 static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
                                         uint64_t data, unsigned size)
 {
@@ -368,7 +397,11 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd ... 0xff:
         /* ignore write to read only registers */
         return;
-    /* case 0xe6 ... 0xe8: Should set base port of parallel and serial */
+    case 0xe2 ... 0xe3:
+    case 0xe6 ... 0xe8:
+        sc->regs[idx] = data;
+        vt82c686b_superio_update(sc);
+        return;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -393,25 +426,24 @@ static void vt82c686b_superio_reset(DeviceState *dev)
 
     memset(s->regs, 0, sizeof(s->regs));
     /* Device ID */
-    vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
-    /* Function select - all disabled */
-    vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
+    s->regs[0xe0] = 0x3c;
+    /*
+     * Function select - only serial enabled
+     * Fuloong 2e's rescue-yl prints to the serial console w/o enabling it. This
+     * suggests that the serial ports are enabled by default, so override the
+     * datasheet.
+     */
+    s->regs[0xe2] = 0x0f;
     /* Floppy ctrl base addr 0x3f0-7 */
-    vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
+    s->regs[0xe3] = 0xfc;
     /* Parallel port base addr 0x378-f */
-    vt82c686b_superio_cfg_write(s, 0, 0xe6, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0xde, 1);
+    s->regs[0xe6] = 0xde;
     /* Serial port 1 base addr 0x3f8-f */
-    vt82c686b_superio_cfg_write(s, 0, 0xe7, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0xfe, 1);
+    s->regs[0xe7] = 0xfe;
     /* Serial port 2 base addr 0x2f8-f */
-    vt82c686b_superio_cfg_write(s, 0, 0xe8, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0xbe, 1);
+    s->regs[0xe8] = 0xbe;
 
-    vt82c686b_superio_cfg_write(s, 0, 0, 1);
+    vt82c686b_superio_update(s);
 }
 
 static void vt82c686b_superio_init(Object *obj)
@@ -429,6 +461,7 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
+    dc->vmsd = &vmstate_vt82c686b_superio;
 }
 
 static const TypeInfo vt82c686b_superio_info = {
@@ -443,6 +476,30 @@ static const TypeInfo vt82c686b_superio_info = {
 
 #define TYPE_VT8231_SUPERIO "vt8231-superio"
 
+static void vt8231_superio_update(ViaSuperIOState *s)
+{
+    isa_parallel_set_enabled(s->superio.parallel[0],
+                             (s->regs[0xf2] & 0x3) != 3);
+    isa_serial_set_enabled(s->superio.serial[0], s->regs[0xf2] & BIT(2));
+    isa_fdc_set_enabled(s->superio.floppy, s->regs[0xf2] & BIT(4));
+
+    isa_serial_set_iobase(s->superio.serial[0], (s->regs[0xf4] & 0xfe) << 2);
+    isa_parallel_set_iobase(s->superio.parallel[0], s->regs[0xf6] << 2);
+    isa_fdc_set_iobase(s->superio.floppy, (s->regs[0xf7] & 0xfc) << 2);
+}
+
+static int vmstate_vt8231_superio_post_load(void *opaque, int version_id)
+{
+    vt8231_superio_update(opaque);
+    return 0;
+}
+
+static const VMStateDescription vmstate_vt8231_superio = {
+    .name = "vt8231_superio",
+    .version_id = 1,
+    .post_load = vmstate_vt8231_superio_post_load,
+};
+
 static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
                                      uint64_t data, unsigned size)
 {
@@ -465,6 +522,12 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd:
         /* ignore write to read only registers */
         return;
+    case 0xf2:
+    case 0xf4:
+    case 0xf6 ... 0xf7:
+        sc->regs[idx] = data;
+        vt8231_superio_update(sc);
+        return;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -493,19 +556,15 @@ static void vt8231_superio_reset(DeviceState *dev)
     /* Device revision */
     s->regs[0xf1] = 0x01;
     /* Function select - all disabled */
-    vt8231_superio_cfg_write(s, 0, 0xf2, 1);
-    vt8231_superio_cfg_write(s, 1, 0x03, 1);
+    s->regs[0xf2] = 0x03;
     /* Serial port base addr */
-    vt8231_superio_cfg_write(s, 0, 0xf4, 1);
-    vt8231_superio_cfg_write(s, 1, 0xfe, 1);
+    s->regs[0xf4] = 0xfe;
     /* Parallel port base addr */
-    vt8231_superio_cfg_write(s, 0, 0xf6, 1);
-    vt8231_superio_cfg_write(s, 1, 0xde, 1);
+    s->regs[0xf6] = 0xde;
     /* Floppy ctrl base addr */
-    vt8231_superio_cfg_write(s, 0, 0xf7, 1);
-    vt8231_superio_cfg_write(s, 1, 0xfc, 1);
+    s->regs[0xf7] = 0xfc;
 
-    vt8231_superio_cfg_write(s, 0, 0, 1);
+    vt8231_superio_update(s);
 }
 
 static void vt8231_superio_init(Object *obj)
@@ -513,12 +572,6 @@ static void vt8231_superio_init(Object *obj)
     VIA_SUPERIO(obj)->io_ops = &vt8231_superio_cfg_ops;
 }
 
-static uint16_t vt8231_superio_serial_iobase(ISASuperIODevice *sio,
-                                             uint8_t index)
-{
-        return 0x2f8; /* FIXME: This should be settable via registers f2-f4 */
-}
-
 static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -526,10 +579,10 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vt8231_superio_reset;
     sc->serial.count = 1;
-    sc->serial.get_iobase = vt8231_superio_serial_iobase;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
+    dc->vmsd = &vmstate_vt8231_superio;
 }
 
 static const TypeInfo vt8231_superio_info = {
-- 
2.43.0


