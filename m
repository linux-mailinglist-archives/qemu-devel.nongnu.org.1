Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD0C0EE1B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 16:17:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOt5-0001bw-3Q; Mon, 27 Oct 2025 11:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOsv-0001Ub-9m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOsf-0003Xz-5I
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzfYqy7pT6JSh7R8VigHurPFSvYSuhqMGSyp2fsHB9M=;
 b=ZzWblg7SoDaJFd7DQ6Q8poq6w8cj8+jDD5uQw8jlppjqdtuyP9bjx2yST0F6T1LP/h6Fli
 DdLZjXegnzSRpWDjv2KDGz0Ov8txztqAosalR6iGBvJGFj+4FXUWqEIYXGMzBWLTiMx+SF
 o+uIP2ozgqPvQjxhorJhvr8H1W0ZCvw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-P-d05SHaP1KwRHvEgaxZCQ-1; Mon,
 27 Oct 2025 11:11:24 -0400
X-MC-Unique: P-d05SHaP1KwRHvEgaxZCQ-1
X-Mimecast-MFC-AGG-ID: P-d05SHaP1KwRHvEgaxZCQ_1761577881
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A18619541BB; Mon, 27 Oct 2025 15:11:20 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 579E0180057C; Mon, 27 Oct 2025 15:11:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 04/35] hw/audio: use better naming for -audio model
 handling code
Date: Mon, 27 Oct 2025 19:10:11 +0400
Message-ID: <20251027151045.2863176-5-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

All the functions are about "-audio model=" handling, a simpler
way to setup audio. Rename functions/variables to reflect this better.

audio_register_model_with_cb() dropped "pci" from the name, since it
will be generalized next.

deprecated_register_soundhw() was actually not a function to be
removed since it's used for "-audio model=" aliasing.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/audio/model.h                      | 14 +++++
 include/hw/audio/soundhw.h                    | 13 -----
 hw/audio/ac97.c                               |  5 +-
 hw/audio/adlib.c                              |  4 +-
 hw/audio/cs4231a.c                            |  4 +-
 hw/audio/es1370.c                             |  5 +-
 hw/audio/gus.c                                |  4 +-
 hw/audio/intel-hda.c                          |  4 +-
 hw/audio/{soundhw.c => model.c}               | 58 +++++++++----------
 hw/audio/pcspk.c                              |  2 +-
 hw/audio/sb16.c                               |  5 +-
 hw/audio/virtio-snd-pci.c                     |  4 +-
 system/vl.c                                   |  6 +-
 hw/audio/meson.build                          |  2 +-
 .../codeconverter/test_regexps.py             |  2 +-
 15 files changed, 65 insertions(+), 67 deletions(-)
 create mode 100644 include/hw/audio/model.h
 delete mode 100644 include/hw/audio/soundhw.h
 rename hw/audio/{soundhw.c => model.c} (68%)

diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
new file mode 100644
index 0000000000..aa237e9eb6
--- /dev/null
+++ b/include/hw/audio/model.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef HW_AUDIO_MODEL_H
+#define HW_AUDIO_MODEL_H
+
+void audio_register_model_with_cb(const char *name, const char *descr,
+                                  int (*init_pci)(PCIBus *bus, const char *audiodev));
+void audio_register_model(const char *name, const char *descr,
+                          int isa, const char *typename);
+
+void audio_model_init(void);
+void audio_print_available_models(void);
+void audio_set_model(const char *name, const char *audiodev);
+
+#endif
diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
deleted file mode 100644
index 83b3011083..0000000000
--- a/include/hw/audio/soundhw.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef HW_SOUNDHW_H
-#define HW_SOUNDHW_H
-
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus, const char *audiodev));
-void deprecated_register_soundhw(const char *name, const char *descr,
-                                 int isa, const char *typename);
-
-void soundhw_init(void);
-void audio_print_available_models(void);
-void select_soundhw(const char *name, const char *audiodev);
-
-#endif
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 828333b66a..9dee5bb143 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -18,7 +18,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
@@ -1362,8 +1362,7 @@ static const TypeInfo ac97_info = {
 static void ac97_register_types(void)
 {
     type_register_static(&ac97_info);
-    deprecated_register_soundhw("ac97", "Intel 82801AA AC97 Audio",
-                                0, TYPE_AC97);
+    audio_register_model("ac97", "Intel 82801AA AC97 Audio", 0, TYPE_AC97);
 }
 
 type_init(ac97_register_types)
diff --git a/hw/audio/adlib.c b/hw/audio/adlib.c
index 772435f04c..d0b2817843 100644
--- a/hw/audio/adlib.c
+++ b/hw/audio/adlib.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
@@ -323,7 +323,7 @@ static const TypeInfo adlib_info = {
 static void adlib_register_types (void)
 {
     type_register_static (&adlib_info);
-    deprecated_register_soundhw("adlib", ADLIB_DESC, 1, TYPE_ADLIB);
+    audio_register_model("adlib", ADLIB_DESC, 1, TYPE_ADLIB);
 }
 
 type_init (adlib_register_types)
diff --git a/hw/audio/cs4231a.c b/hw/audio/cs4231a.c
index 7931fcfec8..0979cf5f16 100644
--- a/hw/audio/cs4231a.c
+++ b/hw/audio/cs4231a.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -723,7 +723,7 @@ static const TypeInfo cs4231a_info = {
 static void cs4231a_register_types (void)
 {
     type_register_static (&cs4231a_info);
-    deprecated_register_soundhw("cs4231a", "CS4231A", 1, TYPE_CS4231A);
+    audio_register_model("cs4231a", "CS4231A", 1, TYPE_CS4231A);
 }
 
 type_init (cs4231a_register_types)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index 6b0da0746e..066b9906fa 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -26,7 +26,7 @@
 #define VERBOSE_ES1370 0
 
 #include "qemu/osdep.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
@@ -905,8 +905,7 @@ static const TypeInfo es1370_info = {
 static void es1370_register_types (void)
 {
     type_register_static (&es1370_info);
-    deprecated_register_soundhw("es1370", "ENSONIQ AudioPCI ES1370",
-                                0, TYPE_ES1370);
+    audio_register_model("es1370", "ENSONIQ AudioPCI ES1370", 0, TYPE_ES1370);
 }
 
 type_init (es1370_register_types)
diff --git a/hw/audio/gus.c b/hw/audio/gus.c
index 91d07e0f81..d5b1e62135 100644
--- a/hw/audio/gus.c
+++ b/hw/audio/gus.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -320,7 +320,7 @@ static const TypeInfo gus_info = {
 static void gus_register_types (void)
 {
     type_register_static (&gus_info);
-    deprecated_register_soundhw("gus", "Gravis Ultrasound GF1", 1, TYPE_GUS);
+    audio_register_model("gus", "Gravis Ultrasound GF1", 1, TYPE_GUS);
 }
 
 type_init (gus_register_types)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index b256c8ccea..6a0db0dd9e 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -26,7 +26,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/error-report.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "intel-hda-defs.h"
@@ -1324,7 +1324,7 @@ static void intel_hda_register_types(void)
     type_register_static(&intel_hda_info_ich6);
     type_register_static(&intel_hda_info_ich9);
     type_register_static(&hda_codec_device_type_info);
-    pci_register_soundhw("hda", "Intel HD Audio", intel_hda_and_codec_init);
+    audio_register_model_with_cb("hda", "Intel HD Audio", intel_hda_and_codec_init);
 }
 
 type_init(intel_hda_register_types)
diff --git a/hw/audio/soundhw.c b/hw/audio/model.c
similarity index 68%
rename from hw/audio/soundhw.c
rename to hw/audio/model.c
index 29158c115c..ddfefea706 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/model.c
@@ -32,9 +32,9 @@
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/pci/pci.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 
-struct soundhw {
+struct audio_model {
     const char *name;
     const char *descr;
     const char *typename;
@@ -42,38 +42,38 @@ struct soundhw {
     int (*init_pci) (PCIBus *bus, const char *audiodev);
 };
 
-static struct soundhw soundhw[9];
-static int soundhw_count;
+static struct audio_model audio_models[9];
+static int audio_models_count;
 
-void pci_register_soundhw(const char *name, const char *descr,
-                          int (*init_pci)(PCIBus *bus, const char *audiodev))
+void audio_register_model_with_cb(const char *name, const char *descr,
+                                  int (*init_pci)(PCIBus *bus, const char *audiodev))
 {
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name = name;
-    soundhw[soundhw_count].descr = descr;
-    soundhw[soundhw_count].isa = 0;
-    soundhw[soundhw_count].init_pci = init_pci;
-    soundhw_count++;
+    assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
+    audio_models[audio_models_count].name = name;
+    audio_models[audio_models_count].descr = descr;
+    audio_models[audio_models_count].isa = 0;
+    audio_models[audio_models_count].init_pci = init_pci;
+    audio_models_count++;
 }
 
-void deprecated_register_soundhw(const char *name, const char *descr,
-                                 int isa, const char *typename)
+void audio_register_model(const char *name, const char *descr,
+                          int isa, const char *typename)
 {
-    assert(soundhw_count < ARRAY_SIZE(soundhw) - 1);
-    soundhw[soundhw_count].name = name;
-    soundhw[soundhw_count].descr = descr;
-    soundhw[soundhw_count].isa = isa;
-    soundhw[soundhw_count].typename = typename;
-    soundhw_count++;
+    assert(audio_models_count < ARRAY_SIZE(audio_models) - 1);
+    audio_models[audio_models_count].name = name;
+    audio_models[audio_models_count].descr = descr;
+    audio_models[audio_models_count].isa = isa;
+    audio_models[audio_models_count].typename = typename;
+    audio_models_count++;
 }
 
 void audio_print_available_models(void)
 {
-    struct soundhw *c;
+    struct audio_model *c;
 
-    if (soundhw_count) {
+    if (audio_models_count) {
         printf("Valid audio device model names:\n");
-        for (c = soundhw; c->name; ++c) {
+        for (c = audio_models; c->name; ++c) {
             printf("%-11s %s\n", c->name, c->descr);
         }
     } else {
@@ -82,19 +82,19 @@ void audio_print_available_models(void)
     }
 }
 
-static struct soundhw *selected = NULL;
+static struct audio_model *selected;
 static const char *audiodev_id;
 
-void select_soundhw(const char *name, const char *audiodev)
+void audio_set_model(const char *name, const char *audiodev)
 {
-    struct soundhw *c;
+    struct audio_model *c;
 
     if (selected) {
         error_report("only one -audio option is allowed");
         exit(1);
     }
 
-    for (c = soundhw; c->name; ++c) {
+    for (c = audio_models; c->name; ++c) {
         if (g_str_equal(c->name, name)) {
             selected = c;
             audiodev_id = audiodev;
@@ -109,9 +109,9 @@ void select_soundhw(const char *name, const char *audiodev)
     }
 }
 
-void soundhw_init(void)
+void audio_model_init(void)
 {
-    struct soundhw *c = selected;
+    struct audio_model *c = selected;
 
     if (!c) {
         return;
diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
index a719912872..48ef830292 100644
--- a/hw/audio/pcspk.c
+++ b/hw/audio/pcspk.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 03c82f2777..5faa3f5fe3 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/irq.h"
 #include "hw/isa/isa.h"
@@ -1470,8 +1470,7 @@ static const TypeInfo sb16_info = {
 static void sb16_register_types (void)
 {
     type_register_static (&sb16_info);
-    deprecated_register_soundhw("sb16", "Creative Sound Blaster 16",
-                                1, TYPE_SB16);
+    audio_register_model("sb16", "Creative Sound Blaster 16", 1, TYPE_SB16);
 }
 
 type_init (sb16_register_types)
diff --git a/hw/audio/virtio-snd-pci.c b/hw/audio/virtio-snd-pci.c
index 9eb0007392..613538e46f 100644
--- a/hw/audio/virtio-snd-pci.c
+++ b/hw/audio/virtio-snd-pci.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/audio/virtio-snd.h"
 
@@ -88,7 +88,7 @@ static int virtio_snd_pci_init(PCIBus *bus, const char *audiodev)
 static void virtio_snd_pci_register(void)
 {
     virtio_pci_types_register(&virtio_snd_pci_info);
-    pci_register_soundhw("virtio", "Virtio Sound", virtio_snd_pci_init);
+    audio_register_model_with_cb("virtio", "Virtio Sound", virtio_snd_pci_init);
 }
 
 type_init(virtio_snd_pci_register);
diff --git a/system/vl.c b/system/vl.c
index 4814ef11da..dc2ea4c298 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -86,7 +86,7 @@
 #include "migration/snapshot.h"
 #include "system/tpm.h"
 #include "system/dma.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "system/cpus.h"
 #include "system/cpu-timers.h"
@@ -2732,7 +2732,7 @@ static void qemu_create_cli_devices(void)
 {
     DeviceOption *opt;
 
-    soundhw_init();
+    audio_model_init();
 
     qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                       parse_fw_cfg, fw_cfg_find(), &error_fatal);
@@ -3088,7 +3088,7 @@ void qemu_init(int argc, char **argv)
                 visit_free(v);
                 if (model) {
                     audio_add_audiodev(dev);
-                    select_soundhw(model, dev->id);
+                    audio_set_model(model, dev->id);
                     g_free(model);
                 } else {
                     audio_add_default_audiodev(dev, &error_fatal);
diff --git a/hw/audio/meson.build b/hw/audio/meson.build
index 2990974449..2154cbdb57 100644
--- a/hw/audio/meson.build
+++ b/hw/audio/meson.build
@@ -1,4 +1,4 @@
-system_ss.add(files('soundhw.c'))
+system_ss.add(files('model.c'))
 system_ss.add(when: 'CONFIG_AC97', if_true: files('ac97.c'))
 system_ss.add(when: 'CONFIG_ADLIB', if_true: files('fmopl.c', 'adlib.c'))
 system_ss.add(when: 'CONFIG_ASC', if_true: files('asc.c'))
diff --git a/scripts/codeconverter/codeconverter/test_regexps.py b/scripts/codeconverter/codeconverter/test_regexps.py
index 4526268ae8..fe7354b473 100644
--- a/scripts/codeconverter/codeconverter/test_regexps.py
+++ b/scripts/codeconverter/codeconverter/test_regexps.py
@@ -264,7 +264,7 @@ def test_initial_includes():
 #define SILENT_ES1370
 
 #include "qemu/osdep.h"
-#include "hw/audio/soundhw.h"
+#include "hw/audio/model.h"
 #include "audio/audio.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
-- 
2.51.0


