Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0EC817A18
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIiw-0006UI-3n; Mon, 18 Dec 2023 13:52:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIim-0006Lq-1F; Mon, 18 Dec 2023 13:52:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiW-0008R4-4q; Mon, 18 Dec 2023 13:52:04 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so39681285e9.0; 
 Mon, 18 Dec 2023 10:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925506; x=1703530306; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d5kwvs9T12xN8vScAfTbA/o6dxLL3a/WbRQdEN799g=;
 b=Xy8auPibR3fSu806iIXUGi2Ecy0RqCUCMgsbWdYOmagBn/OnQd6SKTq+7Fd8Vm7211
 T/0LGJ1r4snTVX556IjSNjibjKDWqAjTdfPx3hLvzYS5RClSmPK17Tgg87kBpdegjPQz
 IO9Gj8CnTU/wUuM/TxRuuM88BifPIyLIpXtHw12O6LVkBKPB64A7zHWaHdm1U+WUaqgy
 Vc+cme0C+Q90gLl7l0RXJHOCQRuZ8bxQYt/ed1YmGJ6vmIg/N0IxMD1fLa66jWh4TiHw
 NvTtKR8nGYORx2/EVZHGgfA3loQjqEb4EGNsR2PCNAXX/dyAzYo2PYP6zs3XnY1kXawn
 DjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925506; x=1703530306;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+d5kwvs9T12xN8vScAfTbA/o6dxLL3a/WbRQdEN799g=;
 b=CrdSzHJDN0xHAXTWOlCbe7yHpz0DNabPoJphXhfmkd7UJomloCroa80gqM+27tz6hA
 nt0n2gEodBG03U8aEGebpVFo1C8gNcDzsJswQB8GPG342dQIGhan0Iz6Gm1JjVFPtki+
 lt7PzuKN+nRc0YyaTk7KSDj+5Eiyu92Qsn6NRa60goo2nLHUOpKjkyFM/19vEbGeyseW
 PV21EFOsLczYbxYr1D2K5v6DPSiB/rPa539rXR+HRlUWqXMH+OIIM4K/6qxsEViXCVtV
 ReKFT5Z4VbD7/gemIjXTEtL4abzgRnSC0k4Nv+jIMDU/83x+0gmlviv2v0ZKhAvqbNLE
 rTNA==
X-Gm-Message-State: AOJu0Yyux9ryKSwAJyemWrID9vlNV2N31kKyaVdqTp0tMpBJ3kdjWKZD
 a67tsi4HxPx+NVqal37va1NIfQgu86s=
X-Google-Smtp-Source: AGHT+IFlyMU6cCN4Nx1XUiclJWuCbsFDv/Veku0P8VSQCpfYPtzrIsu/jX60RtLALDNgF5XXgHX4FQ==
X-Received: by 2002:a05:600c:3011:b0:40b:5e59:b7d2 with SMTP id
 j17-20020a05600c301100b0040b5e59b7d2mr8434333wmh.175.1702925506062; 
 Mon, 18 Dec 2023 10:51:46 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:45 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 12/12] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Mon, 18 Dec 2023 19:51:14 +0100
Message-ID: <20231218185114.119736-13-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
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
and issue an error in case of a conflict. Since the functions are enabled on
reset, conflicts are always detected. Prevent that by implementing relocation
and toggling of the SuperI/O functions.

Note that all SuperI/O functions are now deactivated upon reset (except for
VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
enabled by default). Rely on firmware -- or in case of pegasos2 on board code if
no -bios is given -- to configure the functions accordingly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 121 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 31 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 9c2333a277..be202d23cf 100644
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
@@ -343,6 +346,35 @@ static const TypeInfo via_superio_info = {
 
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
+    ViaSuperIOState *s = opaque;
+
+    vt82c686b_superio_update(s);
+
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
@@ -368,7 +400,11 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
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
@@ -393,25 +429,24 @@ static void vt82c686b_superio_reset(DeviceState *dev)
 
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
@@ -429,6 +464,7 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
+    dc->vmsd = &vmstate_vt82c686b_superio;
 }
 
 static const TypeInfo vt82c686b_superio_info = {
@@ -443,6 +479,33 @@ static const TypeInfo vt82c686b_superio_info = {
 
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
+    ViaSuperIOState *s = opaque;
+
+    vt8231_superio_update(s);
+
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
@@ -465,6 +528,12 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
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
@@ -493,19 +562,15 @@ static void vt8231_superio_reset(DeviceState *dev)
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
@@ -513,12 +578,6 @@ static void vt8231_superio_init(Object *obj)
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
@@ -526,10 +585,10 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 
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


