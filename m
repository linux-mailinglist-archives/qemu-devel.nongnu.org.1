Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958AD7B2E82
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:55:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EI-0006E7-8V; Fri, 29 Sep 2023 04:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EC-0005pN-Gx
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Di-0005m6-K7
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WotoPOUV4DXC4On1WuAyhCRE6nYTRy0oVk8tT33JYIk=;
 b=b6nqEwKJkDwo1oiJkAA9giEFUlpGcOTeLj/7nYVUyG3RNxyJg/OTa2faq27SwiI9Ftr/2L
 Zo6Zd4Y78m6c1vwf8weUvXj5/y2VLAB9z1LiiwXsGffApp+sd/BFzEkMSxASMyDvZrQh5U
 abMqrO1mv7JdVblyURdnqRb9tO27/uM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-xO8DRIdMO4CQCUVwkBtYVw-1; Fri, 29 Sep 2023 04:51:32 -0400
X-MC-Unique: xO8DRIdMO4CQCUVwkBtYVw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a647551b7dso56796266b.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977490; x=1696582290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WotoPOUV4DXC4On1WuAyhCRE6nYTRy0oVk8tT33JYIk=;
 b=hOkEp8pnp7zJQ9etKApDqj6saI0Js+oUalzXIbYoG0oQpWefQVkU8ZRmSxpwjVD/r/
 cJKJN2fhNH5KXDJzsBi1pMZWA6aThqeXeHbTvljXLmHD+9adTI0offaLHSvdkCVIkgTP
 EFk3jnVnCGrmR4T4TtSNCgFghJ6U+WBWtc7VrnO3xDTlZkqr6CtXSq1Wose+5Uf+Kllq
 LQ+/7fKUNMllIHcsN/9jwtBEo3QCuYYvjqUjo42PBfvDQHxvy1buSgagAHEO+8OJ9t1h
 Uuw4s6PQgAgILkGQwjAD+EtRME7r17Vvz5Kj2QhNdaDIjWigfvW2wYFUyl33crn/t/XS
 ZlQA==
X-Gm-Message-State: AOJu0YxzzZWgIbuebT3rlkmFMWW9WFHG4D/8a9r+iOkG1YIcGZNsuUNj
 8JfoBFi7EiAEENYBnJFM+G4sCUei/r4vQcGBkWLEtSfgquvUJOELjlbQffQILSzcJ/0zuH9YN/7
 2JBs0NzhSgYbYfoZai3d6tT33VBcd00URw/5LvnQw89cw2ct625QJikas40z4XzmeHCzTUDt21u
 A=
X-Received: by 2002:a17:907:1c09:b0:9a9:405b:26d1 with SMTP id
 nc9-20020a1709071c0900b009a9405b26d1mr3318457ejc.5.1695977489983; 
 Fri, 29 Sep 2023 01:51:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMgg89eIFEtOkEpMr26oMm4q0/L9K5d2RUDe2nTkJ8UjhI9gHpDaZmJ/su4lHsQVXhJptXmQ==
X-Received: by 2002:a17:907:1c09:b0:9a9:405b:26d1 with SMTP id
 nc9-20020a1709071c0900b009a9405b26d1mr3318419ejc.5.1695977489134; 
 Fri, 29 Sep 2023 01:51:29 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170906591500b0099bd0b5a2bcsm12059776ejq.101.2023.09.29.01.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 07/14] audio: remove QEMU_AUDIO_* and -audio-help support
Date: Fri, 29 Sep 2023 10:51:00 +0200
Message-ID: <20230929085112.983957-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These have been deprecated for a long time, and the introduction of
-audio in 7.1.0 has cemented the new way of specifying an audio backend's
parameters.  However, there is still a need for simple configuration
of the audio backend in the desktop case; therefore, if no audiodev is
passed to audio_init(), go through a bunch of simple Audiodev* structures
and pick the first that can be initialized successfully.

The only QEMU_AUDIO_* option that is left in, waiting for a better idea,
is QEMU_AUDIO_DRV=none which is used by qtest.

Remove all the parsing code, including the concept of "can_be_default"
audio drivers: now that audio_prio_list[] is only used in a single place,
wav can be excluded directly in that function.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/alsaaudio.c               |   1 -
 audio/audio.c                   | 131 +++----
 audio/audio.h                   |   1 -
 audio/audio_int.h               |   5 -
 audio/audio_legacy.c            | 591 --------------------------------
 audio/coreaudio.m               |   1 -
 audio/dbusaudio.c               |   1 -
 audio/dsoundaudio.c             |   1 -
 audio/jackaudio.c               |   1 -
 audio/meson.build               |   1 -
 audio/noaudio.c                 |   1 -
 audio/ossaudio.c                |   1 -
 audio/paaudio.c                 |   1 -
 audio/pwaudio.c                 |   1 -
 audio/sdlaudio.c                |   1 -
 audio/sndioaudio.c              |   1 -
 audio/wavaudio.c                |   1 -
 docs/about/deprecated.rst       |   8 -
 docs/about/removed-features.rst |   6 +
 qemu-options.hx                 |  10 -
 softmmu/vl.c                    |   4 -
 21 files changed, 60 insertions(+), 709 deletions(-)
 delete mode 100644 audio/audio_legacy.c

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 6fb78e5b972..cacae1ea59c 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -960,7 +960,6 @@ static struct audio_driver alsa_audio_driver = {
     .init           = alsa_audio_init,
     .fini           = alsa_audio_fini,
     .pcm_ops        = &alsa_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (ALSAVoiceOut),
diff --git a/audio/audio.c b/audio/audio.c
index e3ca5fe65ec..9da2eaece03 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -32,6 +32,7 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/qapi-commands-audio.h"
+#include "qapi/qmp/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
@@ -62,19 +63,22 @@ const char *audio_prio_list[] = {
     "spice",
     CONFIG_AUDIO_DRIVERS
     "none",
-    "wav",
     NULL
 };
 
 static QLIST_HEAD(, audio_driver) audio_drivers;
-static AudiodevListHead audiodevs = QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
+static AudiodevListHead audiodevs =
+    QSIMPLEQ_HEAD_INITIALIZER(audiodevs);
+static AudiodevListHead default_audiodevs =
+    QSIMPLEQ_HEAD_INITIALIZER(default_audiodevs);
+
 
 void audio_driver_register(audio_driver *drv)
 {
     QLIST_INSERT_HEAD(&audio_drivers, drv, next);
 }
 
-audio_driver *audio_driver_lookup(const char *name)
+static audio_driver *audio_driver_lookup(const char *name)
 {
     struct audio_driver *d;
     Error *local_err = NULL;
@@ -112,8 +116,6 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
-static bool legacy_config = true;
-
 int audio_bug (const char *funcname, int cond)
 {
     if (cond) {
@@ -1688,17 +1690,41 @@ static const VMStateDescription vmstate_audio = {
 
 static void audio_validate_opts(Audiodev *dev, Error **errp);
 
-static AudiodevListEntry *audiodev_find(
-    AudiodevListHead *head, const char *drvname)
+static void audio_create_default_audiodevs(void)
 {
-    AudiodevListEntry *e;
-    QSIMPLEQ_FOREACH(e, head, next) {
-        if (strcmp(AudiodevDriver_str(e->dev->driver), drvname) == 0) {
-            return e;
-        }
+    const char *drvname = getenv("QEMU_AUDIO_DRV");
+
+    /* QEMU_AUDIO_DRV=none is used by libqtest.  */
+    if (drvname && !g_str_equal(drvname, "none")) {
+        error_report("Please use -audiodev instead of QEMU_AUDIO_*");
+        exit(1);
     }
 
-    return NULL;
+    for (int i = 0; audio_prio_list[i]; i++) {
+        if (drvname && !g_str_equal(drvname, audio_prio_list[i])) {
+            continue;
+        }
+
+        if (audio_driver_lookup(audio_prio_list[i])) {
+            QDict *dict = qdict_new();
+            Audiodev *dev = NULL;
+            AudiodevListEntry *e;
+            Visitor *v;
+
+            qdict_put_str(dict, "driver", audio_prio_list[i]);
+            qdict_put_str(dict, "id", "#default");
+
+            v = qobject_input_visitor_new_keyval(QOBJECT(dict));
+            qobject_unref(dict);
+            visit_type_Audiodev(v, NULL, &dev, &error_fatal);
+            visit_free(v);
+
+            audio_validate_opts(dev, &error_abort);
+            e = g_new0(AudiodevListEntry, 1);
+            e->dev = dev;
+            QSIMPLEQ_INSERT_TAIL(&default_audiodevs, e, next);
+        }
+    }
 }
 
 /*
@@ -1710,31 +1736,11 @@ static AudiodevListEntry *audiodev_find(
 static AudioState *audio_init(Audiodev *dev)
 {
     static bool atexit_registered;
-    size_t i;
     int done = 0;
     const char *drvname;
     VMChangeStateEntry *vmse;
     AudioState *s;
     struct audio_driver *driver;
-    /* silence gcc warning about uninitialized variable */
-    AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
-
-    if (using_spice) {
-        /*
-         * When using spice allow the spice audio driver being picked
-         * as default.
-         *
-         * Temporary hack.  Using audio devices without explicit
-         * audiodev= property is already deprecated.  Same goes for
-         * the -soundhw switch.  Once this support gets finally
-         * removed we can also drop the concept of a default audio
-         * backend and this can go away.
-         */
-        driver = audio_driver_lookup("spice");
-        if (driver) {
-            driver->can_be_default = 1;
-        }
-    }
 
     s = g_new0(AudioState, 1);
 
@@ -1763,41 +1769,20 @@ static AudioState *audio_init(Audiodev *dev)
             return NULL;
         }
     } else {
-        /* legacy implicit initialization */
-        head = audio_handle_legacy_opts();
-        /*
-         * In case of legacy initialization, all Audiodevs in the list will have
-         * the same configuration (except the driver), so it doesn't matter which
-         * one we chose.  We need an Audiodev to set up AudioState before we can
-         * init a driver.  Also note that dev at this point is still in the
-         * list.
-         */
-        dev = QSIMPLEQ_FIRST(&head)->dev;
-        audio_validate_opts(dev, &error_abort);
-
-        for (i = 0; audio_prio_list[i]; i++) {
-            AudiodevListEntry *e = audiodev_find(&head, audio_prio_list[i]);
-            driver = audio_driver_lookup(audio_prio_list[i]);
-
-            if (e && driver) {
-                s->dev = dev = e->dev;
-                audio_validate_opts(dev, &error_abort);
-                done = !audio_driver_init(s, driver, false, dev);
-                if (done) {
-                    e->dev = NULL;
-                    break;
-                }
+        for (;;) {
+            AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
+            if (!e) {
+                dolog("Internal error: no default audio driver available\n");
+                exit(1);
             }
+            s->dev = dev = e->dev;
+            drvname = AudiodevDriver_str(dev->driver);
+            driver = audio_driver_lookup(drvname);
+            if (!audio_driver_init(s, driver, false, dev)) {
+                break;
+            }
+            QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
         }
-
-        audio_free_audiodev_list(&head);
-    }
-
-    if (!done) {
-        driver = audio_driver_lookup("none");
-        done = !audio_driver_init(s, driver, false, dev);
-        assert(done);
-        dolog("warning: Using timer based audio emulation\n");
     }
 
     if (dev->timer_period <= 0) {
@@ -1818,16 +1803,6 @@ static AudioState *audio_init(Audiodev *dev)
     return s;
 }
 
-void audio_free_audiodev_list(AudiodevListHead *head)
-{
-    AudiodevListEntry *e;
-    while ((e = QSIMPLEQ_FIRST(head))) {
-        QSIMPLEQ_REMOVE_HEAD(head, next);
-        qapi_free_Audiodev(e->dev);
-        g_free(e);
-    }
-}
-
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
@@ -1839,6 +1814,9 @@ void AUD_register_card (const char *name, QEMUSoundCard *card)
             }
             card->state = QTAILQ_FIRST(&audio_states);
         } else {
+            if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
+                audio_create_default_audiodevs();
+            }
             card->state = audio_init(NULL);
         }
     }
@@ -2171,7 +2149,6 @@ void audio_define(Audiodev *dev)
     e = g_new0(AudiodevListEntry, 1);
     e->dev = dev;
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
-    legacy_config = false;
 }
 
 bool audio_init_audiodevs(void)
diff --git a/audio/audio.h b/audio/audio.h
index e0c13b5dcdf..34df8962a66 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -172,7 +172,6 @@ void audio_define(Audiodev *audio);
 void audio_parse_option(const char *opt);
 bool audio_init_audiodevs(void);
 void audio_help(void);
-void audio_legacy_help(void);
 
 AudioState *audio_state_by_name(const char *name, Error **errp);
 const char *audio_get_id(QEMUSoundCard *card);
diff --git a/audio/audio_int.h b/audio/audio_int.h
index 06e815de9f6..2d079d00a25 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -146,7 +146,6 @@ struct audio_driver {
     void (*set_dbus_server) (AudioState *s, GDBusObjectManagerServer *manager, bool p2p);
 #endif
     struct audio_pcm_ops *pcm_ops;
-    int can_be_default;
     int max_voices_out;
     int max_voices_in;
     size_t voice_size_out;
@@ -243,7 +242,6 @@ extern const struct mixeng_volume nominal_volume;
 extern const char *audio_prio_list[];
 
 void audio_driver_register(audio_driver *drv);
-audio_driver *audio_driver_lookup(const char *name);
 
 void audio_pcm_init_info (struct audio_pcm_info *info, struct audsettings *as);
 void audio_pcm_info_clear_buf (struct audio_pcm_info *info, void *buf, int len);
@@ -297,9 +295,6 @@ typedef struct AudiodevListEntry {
 } AudiodevListEntry;
 
 typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
-AudiodevListHead audio_handle_legacy_opts(void);
-
-void audio_free_audiodev_list(AudiodevListHead *head);
 
 void audio_create_pdos(Audiodev *dev);
 AudiodevPerDirectionOptions *audio_get_pdo_in(Audiodev *dev);
diff --git a/audio/audio_legacy.c b/audio/audio_legacy.c
deleted file mode 100644
index dc72ba55e9a..00000000000
--- a/audio/audio_legacy.c
+++ /dev/null
@@ -1,591 +0,0 @@
-/*
- * QEMU Audio subsystem: legacy configuration handling
- *
- * Copyright (c) 2015-2019 Zoltán Kővágó <DirtY.iCE.hu@gmail.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-#include "qemu/osdep.h"
-#include "audio.h"
-#include "audio_int.h"
-#include "qemu/cutils.h"
-#include "qemu/timer.h"
-#include "qapi/error.h"
-#include "qapi/qapi-visit-audio.h"
-#include "qapi/visitor-impl.h"
-
-#define AUDIO_CAP "audio-legacy"
-#include "audio_int.h"
-
-static uint32_t toui32(const char *str)
-{
-    uint64_t ret;
-    if (parse_uint_full(str, 10, &ret) || ret > UINT32_MAX) {
-        dolog("Invalid integer value `%s'\n", str);
-        exit(1);
-    }
-    return ret;
-}
-
-/* helper functions to convert env variables */
-static void get_bool(const char *env, bool *dst, bool *has_dst)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = toui32(val) != 0;
-        *has_dst = true;
-    }
-}
-
-static void get_int(const char *env, uint32_t *dst, bool *has_dst)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = toui32(val);
-        *has_dst = true;
-    }
-}
-
-static void get_str(const char *env, char **dst)
-{
-    const char *val = getenv(env);
-    if (val) {
-        g_free(*dst);
-        *dst = g_strdup(val);
-    }
-}
-
-static void get_fmt(const char *env, AudioFormat *dst, bool *has_dst)
-{
-    const char *val = getenv(env);
-    if (val) {
-        size_t i;
-        for (i = 0; AudioFormat_lookup.size; ++i) {
-            if (strcasecmp(val, AudioFormat_lookup.array[i]) == 0) {
-                *dst = i;
-                *has_dst = true;
-                return;
-            }
-        }
-
-        dolog("Invalid audio format `%s'\n", val);
-        exit(1);
-    }
-}
-
-
-#if defined(CONFIG_AUDIO_ALSA) || defined(CONFIG_AUDIO_DSOUND)
-static void get_millis_to_usecs(const char *env, uint32_t *dst, bool *has_dst)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = toui32(val) * 1000;
-        *has_dst = true;
-    }
-}
-#endif
-
-#if defined(CONFIG_AUDIO_ALSA) || defined(CONFIG_AUDIO_COREAUDIO) || \
-    defined(CONFIG_AUDIO_PA) || defined(CONFIG_AUDIO_SDL) || \
-    defined(CONFIG_AUDIO_DSOUND) || defined(CONFIG_AUDIO_OSS)
-static uint32_t frames_to_usecs(uint32_t frames,
-                                AudiodevPerDirectionOptions *pdo)
-{
-    uint32_t freq = pdo->has_frequency ? pdo->frequency : 44100;
-    return (frames * 1000000 + freq / 2) / freq;
-}
-#endif
-
-#ifdef CONFIG_AUDIO_COREAUDIO
-static void get_frames_to_usecs(const char *env, uint32_t *dst, bool *has_dst,
-                                AudiodevPerDirectionOptions *pdo)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = frames_to_usecs(toui32(val), pdo);
-        *has_dst = true;
-    }
-}
-#endif
-
-#if defined(CONFIG_AUDIO_PA) || defined(CONFIG_AUDIO_SDL) || \
-    defined(CONFIG_AUDIO_DSOUND) || defined(CONFIG_AUDIO_OSS)
-static uint32_t samples_to_usecs(uint32_t samples,
-                                 AudiodevPerDirectionOptions *pdo)
-{
-    uint32_t channels = pdo->has_channels ? pdo->channels : 2;
-    return frames_to_usecs(samples / channels, pdo);
-}
-#endif
-
-#if defined(CONFIG_AUDIO_PA) || defined(CONFIG_AUDIO_SDL)
-static void get_samples_to_usecs(const char *env, uint32_t *dst, bool *has_dst,
-                                 AudiodevPerDirectionOptions *pdo)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = samples_to_usecs(toui32(val), pdo);
-        *has_dst = true;
-    }
-}
-#endif
-
-#if defined(CONFIG_AUDIO_DSOUND) || defined(CONFIG_AUDIO_OSS)
-static uint32_t bytes_to_usecs(uint32_t bytes, AudiodevPerDirectionOptions *pdo)
-{
-    AudioFormat fmt = pdo->has_format ? pdo->format : AUDIO_FORMAT_S16;
-    uint32_t bytes_per_sample = audioformat_bytes_per_sample(fmt);
-    return samples_to_usecs(bytes / bytes_per_sample, pdo);
-}
-
-static void get_bytes_to_usecs(const char *env, uint32_t *dst, bool *has_dst,
-                               AudiodevPerDirectionOptions *pdo)
-{
-    const char *val = getenv(env);
-    if (val) {
-        *dst = bytes_to_usecs(toui32(val), pdo);
-        *has_dst = true;
-    }
-}
-#endif
-
-/* backend specific functions */
-
-#ifdef CONFIG_AUDIO_ALSA
-/* ALSA */
-static void handle_alsa_per_direction(
-    AudiodevAlsaPerDirectionOptions *apdo, const char *prefix)
-{
-    char buf[64];
-    size_t len = strlen(prefix);
-    bool size_in_usecs = false;
-    bool dummy;
-
-    memcpy(buf, prefix, len);
-    strcpy(buf + len, "TRY_POLL");
-    get_bool(buf, &apdo->try_poll, &apdo->has_try_poll);
-
-    strcpy(buf + len, "DEV");
-    get_str(buf, &apdo->dev);
-
-    strcpy(buf + len, "SIZE_IN_USEC");
-    get_bool(buf, &size_in_usecs, &dummy);
-
-    strcpy(buf + len, "PERIOD_SIZE");
-    get_int(buf, &apdo->period_length, &apdo->has_period_length);
-    if (apdo->has_period_length && !size_in_usecs) {
-        apdo->period_length = frames_to_usecs(
-            apdo->period_length,
-            qapi_AudiodevAlsaPerDirectionOptions_base(apdo));
-    }
-
-    strcpy(buf + len, "BUFFER_SIZE");
-    get_int(buf, &apdo->buffer_length, &apdo->has_buffer_length);
-    if (apdo->has_buffer_length && !size_in_usecs) {
-        apdo->buffer_length = frames_to_usecs(
-            apdo->buffer_length,
-            qapi_AudiodevAlsaPerDirectionOptions_base(apdo));
-    }
-}
-
-static void handle_alsa(Audiodev *dev)
-{
-    AudiodevAlsaOptions *aopt = &dev->u.alsa;
-    handle_alsa_per_direction(aopt->in, "QEMU_ALSA_ADC_");
-    handle_alsa_per_direction(aopt->out, "QEMU_ALSA_DAC_");
-
-    get_millis_to_usecs("QEMU_ALSA_THRESHOLD",
-                        &aopt->threshold, &aopt->has_threshold);
-}
-#endif
-
-#ifdef CONFIG_AUDIO_COREAUDIO
-/* coreaudio */
-static void handle_coreaudio(Audiodev *dev)
-{
-    get_frames_to_usecs(
-        "QEMU_COREAUDIO_BUFFER_SIZE",
-        &dev->u.coreaudio.out->buffer_length,
-        &dev->u.coreaudio.out->has_buffer_length,
-        qapi_AudiodevCoreaudioPerDirectionOptions_base(dev->u.coreaudio.out));
-    get_int("QEMU_COREAUDIO_BUFFER_COUNT",
-            &dev->u.coreaudio.out->buffer_count,
-            &dev->u.coreaudio.out->has_buffer_count);
-}
-#endif
-
-#ifdef CONFIG_AUDIO_DSOUND
-/* dsound */
-static void handle_dsound(Audiodev *dev)
-{
-    get_millis_to_usecs("QEMU_DSOUND_LATENCY_MILLIS",
-                        &dev->u.dsound.latency, &dev->u.dsound.has_latency);
-    get_bytes_to_usecs("QEMU_DSOUND_BUFSIZE_OUT",
-                       &dev->u.dsound.out->buffer_length,
-                       &dev->u.dsound.out->has_buffer_length,
-                       dev->u.dsound.out);
-    get_bytes_to_usecs("QEMU_DSOUND_BUFSIZE_IN",
-                       &dev->u.dsound.in->buffer_length,
-                       &dev->u.dsound.in->has_buffer_length,
-                       dev->u.dsound.in);
-}
-#endif
-
-#ifdef CONFIG_AUDIO_OSS
-/* OSS */
-static void handle_oss_per_direction(
-    AudiodevOssPerDirectionOptions *opdo, const char *try_poll_env,
-    const char *dev_env)
-{
-    get_bool(try_poll_env, &opdo->try_poll, &opdo->has_try_poll);
-    get_str(dev_env, &opdo->dev);
-
-    get_bytes_to_usecs("QEMU_OSS_FRAGSIZE",
-                       &opdo->buffer_length, &opdo->has_buffer_length,
-                       qapi_AudiodevOssPerDirectionOptions_base(opdo));
-    get_int("QEMU_OSS_NFRAGS", &opdo->buffer_count,
-            &opdo->has_buffer_count);
-}
-
-static void handle_oss(Audiodev *dev)
-{
-    AudiodevOssOptions *oopt = &dev->u.oss;
-    handle_oss_per_direction(oopt->in, "QEMU_AUDIO_ADC_TRY_POLL",
-                             "QEMU_OSS_ADC_DEV");
-    handle_oss_per_direction(oopt->out, "QEMU_AUDIO_DAC_TRY_POLL",
-                             "QEMU_OSS_DAC_DEV");
-
-    get_bool("QEMU_OSS_MMAP", &oopt->try_mmap, &oopt->has_try_mmap);
-    get_bool("QEMU_OSS_EXCLUSIVE", &oopt->exclusive, &oopt->has_exclusive);
-    get_int("QEMU_OSS_POLICY", &oopt->dsp_policy, &oopt->has_dsp_policy);
-}
-#endif
-
-#ifdef CONFIG_AUDIO_PA
-/* pulseaudio */
-static void handle_pa_per_direction(
-    AudiodevPaPerDirectionOptions *ppdo, const char *env)
-{
-    get_str(env, &ppdo->name);
-}
-
-static void handle_pa(Audiodev *dev)
-{
-    handle_pa_per_direction(dev->u.pa.in, "QEMU_PA_SOURCE");
-    handle_pa_per_direction(dev->u.pa.out, "QEMU_PA_SINK");
-
-    get_samples_to_usecs(
-        "QEMU_PA_SAMPLES", &dev->u.pa.in->buffer_length,
-        &dev->u.pa.in->has_buffer_length,
-        qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.in));
-    get_samples_to_usecs(
-        "QEMU_PA_SAMPLES", &dev->u.pa.out->buffer_length,
-        &dev->u.pa.out->has_buffer_length,
-        qapi_AudiodevPaPerDirectionOptions_base(dev->u.pa.out));
-
-    get_str("QEMU_PA_SERVER", &dev->u.pa.server);
-}
-#endif
-
-#ifdef CONFIG_AUDIO_SDL
-/* SDL */
-static void handle_sdl(Audiodev *dev)
-{
-    /* SDL is output only */
-    get_samples_to_usecs("QEMU_SDL_SAMPLES", &dev->u.sdl.out->buffer_length,
-        &dev->u.sdl.out->has_buffer_length,
-        qapi_AudiodevSdlPerDirectionOptions_base(dev->u.sdl.out));
-}
-#endif
-
-/* wav */
-static void handle_wav(Audiodev *dev)
-{
-    get_int("QEMU_WAV_FREQUENCY",
-            &dev->u.wav.out->frequency, &dev->u.wav.out->has_frequency);
-    get_fmt("QEMU_WAV_FORMAT", &dev->u.wav.out->format,
-            &dev->u.wav.out->has_format);
-    get_int("QEMU_WAV_DAC_FIXED_CHANNELS",
-            &dev->u.wav.out->channels, &dev->u.wav.out->has_channels);
-    get_str("QEMU_WAV_PATH", &dev->u.wav.path);
-}
-
-/* general */
-static void handle_per_direction(
-    AudiodevPerDirectionOptions *pdo, const char *prefix)
-{
-    char buf[64];
-    size_t len = strlen(prefix);
-
-    memcpy(buf, prefix, len);
-    strcpy(buf + len, "FIXED_SETTINGS");
-    get_bool(buf, &pdo->fixed_settings, &pdo->has_fixed_settings);
-
-    strcpy(buf + len, "FIXED_FREQ");
-    get_int(buf, &pdo->frequency, &pdo->has_frequency);
-
-    strcpy(buf + len, "FIXED_FMT");
-    get_fmt(buf, &pdo->format, &pdo->has_format);
-
-    strcpy(buf + len, "FIXED_CHANNELS");
-    get_int(buf, &pdo->channels, &pdo->has_channels);
-
-    strcpy(buf + len, "VOICES");
-    get_int(buf, &pdo->voices, &pdo->has_voices);
-}
-
-static AudiodevListEntry *legacy_opt(const char *drvname)
-{
-    AudiodevListEntry *e = g_new0(AudiodevListEntry, 1);
-    e->dev = g_new0(Audiodev, 1);
-    e->dev->id = g_strdup(drvname);
-    e->dev->driver = qapi_enum_parse(
-        &AudiodevDriver_lookup, drvname, -1, &error_abort);
-
-    audio_create_pdos(e->dev);
-
-    handle_per_direction(audio_get_pdo_in(e->dev), "QEMU_AUDIO_ADC_");
-    handle_per_direction(audio_get_pdo_out(e->dev), "QEMU_AUDIO_DAC_");
-
-    /* Original description: Timer period in HZ (0 - use lowest possible) */
-    get_int("QEMU_AUDIO_TIMER_PERIOD",
-            &e->dev->timer_period, &e->dev->has_timer_period);
-    if (e->dev->has_timer_period && e->dev->timer_period) {
-        e->dev->timer_period = NANOSECONDS_PER_SECOND / 1000 /
-                               e->dev->timer_period;
-    }
-
-    switch (e->dev->driver) {
-#ifdef CONFIG_AUDIO_ALSA
-    case AUDIODEV_DRIVER_ALSA:
-        handle_alsa(e->dev);
-        break;
-#endif
-
-#ifdef CONFIG_AUDIO_COREAUDIO
-    case AUDIODEV_DRIVER_COREAUDIO:
-        handle_coreaudio(e->dev);
-        break;
-#endif
-
-#ifdef CONFIG_AUDIO_DSOUND
-    case AUDIODEV_DRIVER_DSOUND:
-        handle_dsound(e->dev);
-        break;
-#endif
-
-#ifdef CONFIG_AUDIO_OSS
-    case AUDIODEV_DRIVER_OSS:
-        handle_oss(e->dev);
-        break;
-#endif
-
-#ifdef CONFIG_AUDIO_PA
-    case AUDIODEV_DRIVER_PA:
-        handle_pa(e->dev);
-        break;
-#endif
-
-#ifdef CONFIG_AUDIO_SDL
-    case AUDIODEV_DRIVER_SDL:
-        handle_sdl(e->dev);
-        break;
-#endif
-
-    case AUDIODEV_DRIVER_WAV:
-        handle_wav(e->dev);
-        break;
-
-    default:
-        break;
-    }
-
-    return e;
-}
-
-AudiodevListHead audio_handle_legacy_opts(void)
-{
-    const char *drvname = getenv("QEMU_AUDIO_DRV");
-    AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
-
-    if (drvname) {
-        AudiodevListEntry *e;
-        audio_driver *driver = audio_driver_lookup(drvname);
-        if (!driver) {
-            dolog("Unknown audio driver `%s'\n", drvname);
-            exit(1);
-        }
-        e = legacy_opt(drvname);
-        QSIMPLEQ_INSERT_TAIL(&head, e, next);
-    } else {
-        for (int i = 0; audio_prio_list[i]; i++) {
-            audio_driver *driver = audio_driver_lookup(audio_prio_list[i]);
-            if (driver && driver->can_be_default) {
-                AudiodevListEntry *e = legacy_opt(driver->name);
-                QSIMPLEQ_INSERT_TAIL(&head, e, next);
-            }
-        }
-        if (QSIMPLEQ_EMPTY(&head)) {
-            dolog("Internal error: no default audio driver available\n");
-            exit(1);
-        }
-    }
-
-    return head;
-}
-
-/* visitor to print -audiodev option */
-typedef struct {
-    Visitor visitor;
-
-    bool comma;
-    GList *path;
-} LegacyPrintVisitor;
-
-static bool lv_start_struct(Visitor *v, const char *name, void **obj,
-                            size_t size, Error **errp)
-{
-    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
-    lv->path = g_list_append(lv->path, g_strdup(name));
-    return true;
-}
-
-static void lv_end_struct(Visitor *v, void **obj)
-{
-    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
-    lv->path = g_list_delete_link(lv->path, g_list_last(lv->path));
-}
-
-static void lv_print_key(Visitor *v, const char *name)
-{
-    GList *e;
-    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
-    if (lv->comma) {
-        putchar(',');
-    } else {
-        lv->comma = true;
-    }
-
-    for (e = lv->path; e; e = e->next) {
-        if (e->data) {
-            printf("%s.", (const char *) e->data);
-        }
-    }
-
-    printf("%s=", name);
-}
-
-static bool lv_type_int64(Visitor *v, const char *name, int64_t *obj,
-                          Error **errp)
-{
-    lv_print_key(v, name);
-    printf("%" PRIi64, *obj);
-    return true;
-}
-
-static bool lv_type_uint64(Visitor *v, const char *name, uint64_t *obj,
-                           Error **errp)
-{
-    lv_print_key(v, name);
-    printf("%" PRIu64, *obj);
-    return true;
-}
-
-static bool lv_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
-{
-    lv_print_key(v, name);
-    printf("%s", *obj ? "on" : "off");
-    return true;
-}
-
-static bool lv_type_str(Visitor *v, const char *name, char **obj, Error **errp)
-{
-    const char *str = *obj;
-    lv_print_key(v, name);
-
-    while (*str) {
-        if (*str == ',') {
-            putchar(',');
-        }
-        putchar(*str++);
-    }
-    return true;
-}
-
-static void lv_complete(Visitor *v, void *opaque)
-{
-    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
-    assert(lv->path == NULL);
-}
-
-static void lv_free(Visitor *v)
-{
-    LegacyPrintVisitor *lv = (LegacyPrintVisitor *) v;
-
-    g_list_free_full(lv->path, g_free);
-    g_free(lv);
-}
-
-static Visitor *legacy_visitor_new(void)
-{
-    LegacyPrintVisitor *lv = g_new0(LegacyPrintVisitor, 1);
-
-    lv->visitor.start_struct = lv_start_struct;
-    lv->visitor.end_struct = lv_end_struct;
-    /* lists not supported */
-    lv->visitor.type_int64 = lv_type_int64;
-    lv->visitor.type_uint64 = lv_type_uint64;
-    lv->visitor.type_bool = lv_type_bool;
-    lv->visitor.type_str = lv_type_str;
-
-    lv->visitor.type = VISITOR_OUTPUT;
-    lv->visitor.complete = lv_complete;
-    lv->visitor.free = lv_free;
-
-    return &lv->visitor;
-}
-
-void audio_legacy_help(void)
-{
-    AudiodevListHead head;
-    AudiodevListEntry *e;
-
-    printf("Environment variable based configuration deprecated.\n");
-    printf("Please use the new -audiodev option.\n");
-
-    head = audio_handle_legacy_opts();
-    printf("\nEquivalent -audiodev to your current environment variables:\n");
-    if (!getenv("QEMU_AUDIO_DRV")) {
-        printf("(Since you didn't specify QEMU_AUDIO_DRV, I'll list all "
-               "possibilities)\n");
-    }
-
-    QSIMPLEQ_FOREACH(e, &head, next) {
-        Visitor *v;
-        Audiodev *dev = e->dev;
-        printf("-audiodev ");
-
-        v = legacy_visitor_new();
-        visit_type_Audiodev(v, NULL, &dev, &error_abort);
-        visit_free(v);
-
-        printf("\n");
-    }
-    audio_free_audiodev_list(&head);
-}
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 7cfb38fb6ae..8cd129a27d0 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -673,7 +673,6 @@ static void coreaudio_audio_fini (void *opaque)
     .init           = coreaudio_audio_init,
     .fini           = coreaudio_audio_fini,
     .pcm_ops        = &coreaudio_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = 1,
     .max_voices_in  = 0,
     .voice_size_out = sizeof (coreaudioVoiceOut),
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 310ca997ff4..60fcf643ecf 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -676,7 +676,6 @@ static struct audio_driver dbus_audio_driver = {
     .fini            = dbus_audio_fini,
     .set_dbus_server = dbus_audio_set_server,
     .pcm_ops         = &dbus_pcm_ops,
-    .can_be_default  = 1,
     .max_voices_out  = INT_MAX,
     .max_voices_in   = INT_MAX,
     .voice_size_out  = sizeof(DBusVoiceOut),
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index eefde88edcb..f3bb48d0073 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -721,7 +721,6 @@ static struct audio_driver dsound_audio_driver = {
     .init           = dsound_audio_init,
     .fini           = dsound_audio_fini,
     .pcm_ops        = &dsound_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = 1,
     .voice_size_out = sizeof (DSoundVoiceOut),
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 823e7d96bae..974a3caad34 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -676,7 +676,6 @@ static struct audio_driver jack_driver = {
     .init           = qjack_init,
     .fini           = qjack_fini,
     .pcm_ops        = &jack_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof(QJackOut),
diff --git a/audio/meson.build b/audio/meson.build
index df4d968c0fe..c8f658611f4 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,7 +1,6 @@
 system_ss.add([spice_headers, files('audio.c')])
 system_ss.add(files(
   'audio-hmp-cmds.c',
-  'audio_legacy.c',
   'mixeng.c',
   'noaudio.c',
   'wavaudio.c',
diff --git a/audio/noaudio.c b/audio/noaudio.c
index a36bfeffd14..1b60d8518a4 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -135,7 +135,6 @@ static struct audio_driver no_audio_driver = {
     .init           = no_audio_init,
     .fini           = no_audio_fini,
     .pcm_ops        = &no_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (NoVoiceOut),
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index ec4448d573d..3f31852371d 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -784,7 +784,6 @@ static struct audio_driver oss_audio_driver = {
     .init           = oss_audio_init,
     .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (OSSVoiceOut),
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 39bd6cfa38a..f3193b08c32 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -931,7 +931,6 @@ static struct audio_driver pa_audio_driver = {
     .init           = qpa_audio_init,
     .fini           = qpa_audio_fini,
     .pcm_ops        = &qpa_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (PAVoiceOut),
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 1020cb11df1..3ce5f6507b4 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -843,7 +843,6 @@ static struct audio_driver pw_audio_driver = {
     .init = qpw_audio_init,
     .fini = qpw_audio_fini,
     .pcm_ops = &qpw_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in = INT_MAX,
     .voice_size_out = sizeof(PWVoiceOut),
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 4d8473d9ece..641357e5ee3 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -494,7 +494,6 @@ static struct audio_driver sdl_audio_driver = {
     .init           = sdl_audio_init,
     .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof(SDLVoiceOut),
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 1e35925a497..8eb35e1e538 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -550,7 +550,6 @@ static struct audio_driver sndio_audio_driver = {
     .init           = sndio_audio_init,
     .fini           = sndio_audio_fini,
     .pcm_ops        = &sndio_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof(SndioVoice),
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 26b03906d59..ea20fed0ccb 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -208,7 +208,6 @@ static struct audio_driver wav_audio_driver = {
     .init           = wav_audio_init,
     .fini           = wav_audio_fini,
     .pcm_ops        = &wav_pcm_ops,
-    .can_be_default = 0,
     .max_voices_out = 1,
     .max_voices_in  = 0,
     .voice_size_out = sizeof (WAVVoiceOut),
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c07bf58dde1..2f51cf770ae 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -37,14 +37,6 @@ coverage.
 System emulator command line arguments
 --------------------------------------
 
-``QEMU_AUDIO_`` environment variables and ``-audio-help`` (since 4.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-The ``-audiodev`` argument is now the preferred way to specify audio
-backend settings instead of environment variables.  To ease migration to
-the new format, the ``-audiodev-help`` option can be used to convert
-the current values of the environment variables to ``-audiodev`` options.
-
 Creating sound card devices without ``audiodev=`` property (since 4.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 276060b320c..e83ed087f6b 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -436,6 +436,12 @@ the process listing. This was replaced by the new ``password-secret``
 option which lets the password be securely provided on the command
 line using a ``secret`` object instance.
 
+``QEMU_AUDIO_`` environment variables and ``-audio-help`` (removed in 8.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``-audiodev`` and ``-audio`` command line options are now the only
+way to specify audio backend settings.
+
 Creating vnc without ``audiodev=`` property (removed in 8.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/qemu-options.hx b/qemu-options.hx
index bcd77255cbd..9ce8a5b9578 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -727,16 +727,6 @@ SRST
 ERST
 
 
-HXCOMM Deprecated by -audiodev
-DEF("audio-help", 0, QEMU_OPTION_audio_help,
-    "-audio-help     show -audiodev equivalent of the currently specified audio settings\n",
-    QEMU_ARCH_ALL)
-SRST
-``-audio-help``
-    Will show the -audiodev equivalent of the currently specified
-    (deprecated) environment variables.
-ERST
-
 DEF("audio", HAS_ARG, QEMU_OPTION_audio,
     "-audio [driver=]driver,model=value[,prop[=value][,...]]\n"
     "                specifies the audio backend and device to use;\n"
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 59a472a0b10..cafb1a98427 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2926,10 +2926,6 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
 #endif
-            case QEMU_OPTION_audio_help:
-                audio_legacy_help();
-                exit (0);
-                break;
             case QEMU_OPTION_audiodev:
                 audio_parse_option(optarg);
                 break;
-- 
2.41.0


