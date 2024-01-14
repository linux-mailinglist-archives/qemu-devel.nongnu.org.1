Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8454682D094
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:41:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmS-0003m1-8C; Sun, 14 Jan 2024 07:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmP-0003kA-7B; Sun, 14 Jan 2024 07:39:57 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmN-0001s5-C0; Sun, 14 Jan 2024 07:39:56 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e68d0dbf9so19635355e9.2; 
 Sun, 14 Jan 2024 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235992; x=1705840792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfI6LM71rZVhWLOGIPzk+FrbCZHFu6H7pIfxJhGta/0=;
 b=mFEGnk4SMKraZbrhVq5l1DEqWw2xUjFmSEn4ApsXqCOHXzgxoxXlf3nuyZ4K6Tzvpa
 pnjOzFtuXKcfu+OfUXoHSBPw9KoMY4daTJk9BKnwT5gAaXZ4+6fl90x1kidabVwImnSU
 rnH9tUZBGibigK8FACJ9IT0ar4AzpNh2gFpRTFYM4+8fpdiZaxAtl8adTkhohMX8w8/F
 8DpTY8F6GYzpoDsBuYZM53m5ICVYGQxMhYtwMj6U7uqhv9/LyTA5YNtA9sGwLgS7UX40
 4O18zeKE/pF5kp64zk9f0E+YQq15N34NuPPBlErJIxuIu7X9+9Ul06+hYan+KT4/bCEH
 arfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235992; x=1705840792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfI6LM71rZVhWLOGIPzk+FrbCZHFu6H7pIfxJhGta/0=;
 b=qj/zdP+jU37l8JrXSfIlOR2nmtthyPZswWpt+m/iG754nDgNiLE4HMe47kFpC81FFl
 3fUqCX0SB6M+EQsihXL9VS4hLA90RdheH33MwIdPQ7wzgfwYDmhTW/ezeTW065Mc71qz
 ygCGWZa+BLsM1aWEH13bpCeqFwtZn7PBK4+jPjp0G8WFs63Z7FzT3tmjV9Yyu4fIV8hC
 Y29m92hDy0izDfhsWXi+Sd5nNB+3Rb8uVyOhpJtYAX0z7K2ieTX6TiKnja/vm4po+3Cv
 tP7knfA3ayhFNdECyw8/wvR0tVviFx3Al38yC7tkvQUL0LXuatvl0JcrlWLfPwyNDJI2
 kEJw==
X-Gm-Message-State: AOJu0YyQ1VMkGY7PZzKIa8jSSlJV3GEk8RUp8BwiJ2+uTTZttOzoPuAD
 9ii4ihC84SH1cdNlQEqz6xklVAITWKw=
X-Google-Smtp-Source: AGHT+IEX5gXRrWi7Qmyl7/puukbGi2JFUvxxsdiNrBsL+KX+dck3OJAu0+RZoz2mhtmhYTueaqQGYQ==
X-Received: by 2002:a05:600c:4a9b:b0:40e:5be9:8ed6 with SMTP id
 b27-20020a05600c4a9b00b0040e5be98ed6mr1272030wmp.90.1705235991802; 
 Sun, 14 Jan 2024 04:39:51 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:50 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 11/11] hw/isa/vt82c686: Implement relocation and toggling
 of SuperI/O functions
Date: Sun, 14 Jan 2024 13:39:11 +0100
Message-ID: <20240114123911.4877-12-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c | 65 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index d3e0f6d01f..485bb685b7 100644
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
@@ -323,6 +326,17 @@ static uint64_t via_superio_cfg_read(void *opaque, hwaddr addr, unsigned size)
     return val;
 }
 
+static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
+{
+    ISASuperIOClass *ic = ISA_SUPERIO_GET_CLASS(s);
+
+    isa_parallel_set_enabled(s->superio.parallel[0], (data & 0x3) != 3);
+    for (int i = 0; i < ic->serial.count; i++) {
+        isa_serial_set_enabled(s->superio.serial[i], data & BIT(i + 2));
+    }
+    isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));
+}
+
 static void via_superio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -368,7 +382,25 @@ static void vt82c686b_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd ... 0xff:
         /* ignore write to read only registers */
         return;
-    /* case 0xe6 ... 0xe8: Should set base port of parallel and serial */
+    case 0xe2:
+        data &= 0x1f;
+        via_superio_devices_enable(sc, data);
+        break;
+    case 0xe3:
+        data &= 0xfc;
+        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
+        break;
+    case 0xe6:
+        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
+        break;
+    case 0xe7:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
+        break;
+    case 0xe8:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[1], data << 2);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -395,9 +427,14 @@ static void vt82c686b_superio_reset(DeviceState *dev)
     /* Device ID */
     vt82c686b_superio_cfg_write(s, 0, 0xe0, 1);
     vt82c686b_superio_cfg_write(s, 1, 0x3c, 1);
-    /* Function select - all disabled */
+    /*
+     * Function select - only serial enabled
+     * Fuloong 2e's rescue-yl prints to the serial console w/o enabling it. This
+     * suggests that the serial ports are enabled by default, so override the
+     * datasheet.
+     */
     vt82c686b_superio_cfg_write(s, 0, 0xe2, 1);
-    vt82c686b_superio_cfg_write(s, 1, 0x03, 1);
+    vt82c686b_superio_cfg_write(s, 1, 0x0f, 1);
     /* Floppy ctrl base addr 0x3f0-7 */
     vt82c686b_superio_cfg_write(s, 0, 0xe3, 1);
     vt82c686b_superio_cfg_write(s, 1, 0xfc, 1);
@@ -465,6 +502,21 @@ static void vt8231_superio_cfg_write(void *opaque, hwaddr addr,
     case 0xfd:
         /* ignore write to read only registers */
         return;
+    case 0xf2:
+        data &= 0x17;
+        via_superio_devices_enable(sc, data);
+        break;
+    case 0xf4:
+        data &= 0xfe;
+        isa_serial_set_iobase(sc->superio.serial[0], data << 2);
+        break;
+    case 0xf6:
+        isa_parallel_set_iobase(sc->superio.parallel[0], data << 2);
+        break;
+    case 0xf7:
+        data &= 0xfc;
+        isa_fdc_set_iobase(sc->superio.floppy, data << 2);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP,
                       "via_superio_cfg: unimplemented register 0x%x\n", idx);
@@ -513,12 +565,6 @@ static void vt8231_superio_init(Object *obj)
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
@@ -526,7 +572,6 @@ static void vt8231_superio_class_init(ObjectClass *klass, void *data)
 
     dc->reset = vt8231_superio_reset;
     sc->serial.count = 1;
-    sc->serial.get_iobase = vt8231_superio_serial_iobase;
     sc->parallel.count = 1;
     sc->ide.count = 0; /* emulated by via-ide */
     sc->floppy.count = 1;
-- 
2.43.0


