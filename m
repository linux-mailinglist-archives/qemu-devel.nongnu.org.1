Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E393815FEE
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:44:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLq-0005gL-E5; Sun, 17 Dec 2023 09:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLi-0005dr-6K; Sun, 17 Dec 2023 09:42:35 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLf-0003PM-MU; Sun, 17 Dec 2023 09:42:33 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54bf9a54fe3so2648271a12.3; 
 Sun, 17 Dec 2023 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824148; x=1703428948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7GVPhWXMW8MR93OghNnij2RsOVoa+Oia2EB8rT0v4yc=;
 b=gGvpumVkeb/1LbbN07Fztf8hSDpV93LeiEaWcITTt9VpAhp2OW5qZ6dChKUZb3F28j
 W2P8C7d7ghCsGj8yjiIzStL+kn0FK7Xd/SofBwIo1sDzBS5H36XHGHYXAWzwfPT73cOH
 EwSABAo0tICyVr7YKj+KFeNtXGOCq6QOGzRWLqMeF5glxriMvkXu5gp3gb9HszR0Ig86
 vfxXJpHRPxTduKghYfZxPUB20fZTon16DcbmcheYLtxYX66s4GSGmBKL9wjEOlsYgxJ8
 h+BiTpnuL2DwIk5FVL5SfQikzbwcgPdqyyddLxGY1j4eSLfNwNRBVKei9EiX67vBiTQe
 YlEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824148; x=1703428948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7GVPhWXMW8MR93OghNnij2RsOVoa+Oia2EB8rT0v4yc=;
 b=b0jY1QW8LcHDB+Ly66ScGrGOQTl8Js3dUICwp41oXYgIfTfAfCIJWwpb67ehW7c/hn
 Cq+dkcB/gY6bAwRSg58Pg/8lnDFE1qgO2oBIwCfOwn61kTLybZ/KaDU7fB+GyOK2OABJ
 Nnqi+Qe53oI0HuEVStr8bGm85sGHEh9PislvGCsKUMnihsSK2S3m08WkM93i4Umm4s0x
 fRpsOdTdLTGJG6C0WMA6VVoYReZgD9RWf9KGSGWMsLqRXZ7B+3Y8SFHtKgHwrmWDsG35
 4fUG3E5jEyXb60PKueF7IRPw9po3ifIdiT2bINnEM/G2Dm1Ol7Y+PafgvHoDNBg6IGHk
 jnqA==
X-Gm-Message-State: AOJu0YyXkKBnQIxxjX3VPW5bsrOtOzY5JS/wVXMuqT1yscxXOZ9NbAL8
 9jj1aCsYTLZx78+y1uYP3tOw8iGPkUY=
X-Google-Smtp-Source: AGHT+IFRAgNlWKtd865+MVAmfj3sUYDVHoP7HEFdoI3M411Vob8r2ts+n73iAOpnY3fyAWlfGt/W8w==
X-Received: by 2002:a17:906:5345:b0:a23:4f2e:f7b with SMTP id
 j5-20020a170906534500b00a234f2e0f7bmr222521ejo.56.1702824148559; 
 Sun, 17 Dec 2023 06:42:28 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:27 -0800 (PST)
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
Subject: [PATCH 12/12] hw/isa/vt82c686: Implement relocation of SuperI/O
 functions
Date: Sun, 17 Dec 2023 15:41:48 +0100
Message-ID: <20231217144148.15511-13-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
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

The VIA south bridges are able to relocate and enable or disable their SuperI/O
functions. So far this is hardcoded such that all functions are always enabled
and are located at fixed addresses.

Some PC BIOSes seem to probe for I/O occupancy before activating such a function
and issue an error in case of a conflict. Since the functions are enabled on
reset, conflicts are always detected. Prevent that by implementing relocation of
the SuperI/O functions.

Note that the reset I/O region of VT8231's serial port changes from
0x2f8/enabled to 0x3f8/disabled. The ROM of the Pegasos II machine can handle it
since it enables and relocates the I/O region accordingly.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 140 ++++++++++++++++++++++++++++++++++++----------
 hw/ppc/pegasos2.c |  15 +++++
 2 files changed, 124 insertions(+), 31 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 9c2333a277..8fbc016755 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -15,6 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/vt82c686.h"
+#include "hw/block/fdc-isa.h"
+#include "hw/char/parallel-isa.h"
+#include "hw/char/serial-isa.h"
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/pci.h"
@@ -343,6 +346,46 @@ static const TypeInfo via_superio_info = {
 
 #define TYPE_VT82C686B_SUPERIO "vt82c686b-superio"
 
+static void vt82c686b_superio_update(ViaSuperIOState *s)
+{
+    FDCtrlISABus *fd = ISA_FDC(s->superio.floppy);
+    ISASerialState *ss1 = ISA_SERIAL(s->superio.serial[0]);
+    ISASerialState *ss2 = ISA_SERIAL(s->superio.serial[1]);
+    ISAParallelState *ps = ISA_PARALLEL(s->superio.parallel[0]);
+
+    portio_list_set_enabled(&ps->state.portio_list, (s->regs[0xe2] & 0x3) != 3);
+    memory_region_set_enabled(&ss1->state.io, s->regs[0xe2] & BIT(2));
+    memory_region_set_enabled(&ss2->state.io, s->regs[0xe2] & BIT(3));
+    portio_list_set_enabled(&fd->state.portio_list, s->regs[0xe2] & BIT(4));
+
+    fd->iobase = (s->regs[0xe3] & 0xfc) << 2;
+    portio_list_set_address(&fd->state.portio_list, fd->iobase);
+
+    ps->iobase = s->regs[0xe6] << 2;
+    portio_list_set_address(&ps->state.portio_list, ps->iobase);
+
+    ss1->iobase = (s->regs[0xe7] & 0xfe) << 2;
+    memory_region_set_address(&ss1->state.io, ss1->iobase);
+
+    ss2->iobase = (s->regs[0xe8] & 0xfe) << 2;
+    memory_region_set_address(&ss2->state.io, ss2->iobase);
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
@@ -368,7 +411,11 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
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
@@ -393,25 +440,24 @@ static void vt82c686b_superio_reset(DeviceState *dev)
 
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
@@ -429,6 +475,7 @@ static void vt82c686b_superio_class_init(ObjectClass *klass, void *data)
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
+    dc->vmsd = &vmstate_vt82c686b_superio;
 }
 
 static const TypeInfo vt82c686b_superio_info = {
@@ -443,6 +490,41 @@ static const TypeInfo vt82c686b_superio_info = {
 
 #define TYPE_VT8231_SUPERIO "vt8231-superio"
 
+static void vt8231_superio_update(ViaSuperIOState *s)
+{
+    FDCtrlISABus *fd = ISA_FDC(s->superio.floppy);
+    ISASerialState *ss = ISA_SERIAL(s->superio.serial[0]);
+    ISAParallelState *ps = ISA_PARALLEL(s->superio.parallel[0]);
+
+    portio_list_set_enabled(&ps->state.portio_list, (s->regs[0xf2] & 0x3) != 3);
+    memory_region_set_enabled(&ss->state.io, s->regs[0xf2] & BIT(2));
+    portio_list_set_enabled(&fd->state.portio_list, s->regs[0xf2] & BIT(4));
+
+    ss->iobase = (s->regs[0xf4] & 0xfe) << 2;
+    memory_region_set_address(&ss->state.io, ss->iobase);
+
+    ps->iobase = s->regs[0xf6] << 2;
+    portio_list_set_address(&ps->state.portio_list, ps->iobase);
+
+    fd->iobase = (s->regs[0xf7] & 0xfc) << 2;
+    portio_list_set_address(&fd->state.portio_list, fd->iobase);
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
@@ -465,6 +547,12 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
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
@@ -493,19 +581,15 @@ static void vt8231_superio_reset(DeviceState *dev)
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
@@ -513,12 +597,6 @@ static void vt8231_superio_init(Object *obj)
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
@@ -526,10 +604,10 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vt8231_superio_reset;
     sc->serial.count = 1;
-    sc->serial.get_iobase = vt8231_superio_serial_iobase;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
+    dc->vmsd = &vmstate_vt8231_superio;
 }
 
 static const TypeInfo vt8231_superio_info = {
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 3203a4a728..0a40ebd542 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -285,6 +285,15 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
     pegasos2_mv_reg_write(pm, pcicfg + 4, len, val);
 }
 
+static void pegasos2_superio_write(Pegasos2MachineState *pm, uint32_t addr,
+                                   uint32_t val)
+{
+    AddressSpace *as = CPU(pm->cpu)->as;
+
+    stb_phys(as, PCI1_IO_BASE + 0x3f0, addr);
+    stb_phys(as, PCI1_IO_BASE + 0x3f1, val);
+}
+
 static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 {
     Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
@@ -310,6 +319,12 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x9);
+    pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
+                              0x50, 1, 0x6);
+    pegasos2_superio_write(pm, 0xf4, 0xbe);
+    pegasos2_superio_write(pm, 0xf6, 0xef);
+    pegasos2_superio_write(pm, 0xf7, 0xfc);
+    pegasos2_superio_write(pm, 0xf2, 0x14);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
                               0x50, 1, 0x2);
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 0) << 8) |
-- 
2.43.0


