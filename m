Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF6F7AAE25
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVx-0004mX-3X; Fri, 22 Sep 2023 05:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVj-0004j0-N2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVg-0003N1-F7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZYaAXgCjWKIKQP2k6e7i1ysxrJ0oruwWu2CjsZL3JOA=;
 b=cZ1aaZLMBeeSMtZyPa3rgF5OMWlTvqHE8+iTA9fyFVwd8AB7japgJn5sPVE5PGnMziV8LR
 qEw1ZjRP/uQq6JMocR7pH5b2G+7lCRST2/GQ8VClzrTfRXdXNWgt9vWQXABCSVNz8QNVr/
 KfFaVaTakk/rLR8X6JQi6uSBwbFDl/U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-kLjDhNkgMO6Hfaj__cJjMg-1; Fri, 22 Sep 2023 05:31:37 -0400
X-MC-Unique: kLjDhNkgMO6Hfaj__cJjMg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so7993095e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375095; x=1695979895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYaAXgCjWKIKQP2k6e7i1ysxrJ0oruwWu2CjsZL3JOA=;
 b=gBmb3E6PhkEhKhiBlYQS2NDB2b/voiqRXLwN1yumquCFi8QFjxkMjZpwY5zcP0rnkN
 TuNM2SAOMsccHvOucUz2oNxJFajYfIpfbRQ+2PJgP/rMJJnHEmzaGz//Qi9+RITchEVU
 VXgV6Wxmv/d3ouYH50hqdn/ED/fSMuU3BkoUOI87LzKJIYwjgnTYtN3Coo34919q47TL
 w7FmCqGc7Wzb0O3LsBP8xQdEO/avbkXDUxy7HL47i6YvJWkfsKyuwdz4jRWXnABXgboG
 LxqZUe3i7D/4RcKf7d7ZnLdOAgopt6vYMPmElOu/tBVQSZZQUOHipfvXbYmRr53YAaKK
 6v+g==
X-Gm-Message-State: AOJu0YwfGj2agV5IfxWJCC/xClT73J/qdReFOX1FGVas3RDVLRqD4Qux
 n/K+M7CMc8fBBNmanEs1KyyrDkRpoIKt30opL63lTskQBGGXWEo5MpptRl3+HaO2ZnUNJuoXroM
 dRd65k0fKG5kImGQRyeI5dMBwnYogbptJMe1zwh+rLNRVuZv1p6gghZvw+ZcXZtvMllR9Tw0+kf
 A=
X-Received: by 2002:a7b:c3cf:0:b0:402:f8ea:be3e with SMTP id
 t15-20020a7bc3cf000000b00402f8eabe3emr6792768wmj.7.1695375095194; 
 Fri, 22 Sep 2023 02:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT0V5EjPj6nuCptt/KS4RkNXeGkjfYR/fHPdu/DSQt56tDnXW6rBgEBKMR6YzYqNV/V8L4uw==
X-Received: by 2002:a7b:c3cf:0:b0:402:f8ea:be3e with SMTP id
 t15-20020a7bc3cf000000b00402f8eabe3emr6792727wmj.7.1695375094087; 
 Fri, 22 Sep 2023 02:31:34 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a7bc7cb000000b00402fa98abe3sm7000996wmk.46.2023.09.22.02.31.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] audio: remove QEMU_AUDIO_* and -audio-help support
Date: Fri, 22 Sep 2023 11:31:17 +0200
Message-ID: <20230922093126.264016-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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

These have been deprecated for a long time, and the introduction
of -audio in 7.1.0 has cemented the new way of specifying an
audio backend.  Remove all the associated baggage, including the
concept of "can_be_default" audio drivers.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/alsaaudio.c               |   1 -
 audio/audio.c                   |  60 +---
 audio/audio.h                   |   1 -
 audio/audio_int.h               |   3 -
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
 21 files changed, 24 insertions(+), 672 deletions(-)
 delete mode 100644 audio/audio_legacy.c

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 057571dd1e0..5ffb39c4182 100644
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
index 90c7c49d116..666ef4237dd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -73,7 +73,7 @@ void audio_driver_register(audio_driver *drv)
     QLIST_INSERT_HEAD(&audio_drivers, drv, next);
 }
 
-audio_driver *audio_driver_lookup(const char *name)
+static audio_driver *audio_driver_lookup(const char *name)
 {
     struct audio_driver *d;
     Error *local_err = NULL;
@@ -111,8 +111,6 @@ const struct mixeng_volume nominal_volume = {
 #endif
 };
 
-static bool legacy_config = true;
-
 int audio_bug (const char *funcname, int cond)
 {
     if (cond) {
@@ -1712,46 +1710,26 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
     /* silence gcc warning about uninitialized variable */
     AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
 
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
-
     if (dev) {
         /* -audiodev option */
-        legacy_config = false;
         drvname = AudiodevDriver_str(dev->driver);
-    } else if (!QTAILQ_EMPTY(&audio_states)) {
-        if (!legacy_config) {
-            dolog("Device %s: audiodev default parameter is deprecated, please "
-                  "specify audiodev=%s\n", name,
-                  QTAILQ_FIRST(&audio_states)->dev->id);
-        }
-        return QTAILQ_FIRST(&audio_states);
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
+        if (!QTAILQ_EMPTY(&audio_states)) {
+            dev = QTAILQ_FIRST(&audio_states)->dev;
+            if (!g_str_equal(dev->id, "#none")) {
+                dolog("Device %s: audiodev default parameter is deprecated, please "
+                      "specify audiodev=%s\n", name,
+                      dev->id);
+            }
+            return QTAILQ_FIRST(&audio_states);
+        }
+
+        dolog("No audio device specified\n");
+        dev = g_new0(Audiodev, 1);
+        dev->id = g_strdup("#none");
+        dev->driver = AUDIODEV_DRIVER_NONE;
+        dev->u.none.in = g_new0(AudiodevPerDirectionOptions, 1);
+        dev->u.none.out = g_new0(AudiodevPerDirectionOptions, 1);
     }
 
     s = g_new0(AudioState, 1);
@@ -1876,9 +1854,7 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        if (!legacy_config) {
-            dolog("Capturing without setting an audiodev is deprecated\n");
-        }
+        dolog("Capturing without setting an audiodev is deprecated\n");
         s = audio_init(NULL, NULL);
     }
 
diff --git a/audio/audio.h b/audio/audio.h
index 01bdc567fb1..a276ec13eba 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -172,7 +172,6 @@ void audio_define(Audiodev *audio);
 void audio_parse_option(const char *opt);
 bool audio_init_audiodevs(void);
 void audio_help(void);
-void audio_legacy_help(void);
 
 AudioState *audio_state_by_name(const char *name);
 const char *audio_get_id(QEMUSoundCard *card);
diff --git a/audio/audio_int.h b/audio/audio_int.h
index e57ff50155a..381c31ee0df 100644
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
@@ -297,7 +295,6 @@ typedef struct AudiodevListEntry {
 } AudiodevListEntry;
 
 typedef QSIMPLEQ_HEAD(, AudiodevListEntry) AudiodevListHead;
-AudiodevListHead audio_handle_legacy_opts(void);
 
 void audio_free_audiodev_list(AudiodevListHead *head);
 
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
index 4695291621a..e5612138a74 100644
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
index 7a11fbfb420..df81e6d9f0b 100644
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
index 3fb67ec3eed..311e3421846 100644
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
index 5bdf3d7a78d..fd2d2fd5acb 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -669,7 +669,6 @@ static struct audio_driver jack_driver = {
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
index 4fdee5adecf..81570bfa962 100644
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
index e8d732b612c..5a4094af707 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -779,7 +779,6 @@ static struct audio_driver oss_audio_driver = {
     .init           = oss_audio_init,
     .fini           = oss_audio_fini,
     .pcm_ops        = &oss_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (OSSVoiceOut),
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 529b39daacc..02d18eabf50 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -928,7 +928,6 @@ static struct audio_driver pa_audio_driver = {
     .init           = qpa_audio_init,
     .fini           = qpa_audio_fini,
     .pcm_ops        = &qpa_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof (PAVoiceOut),
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index b6a38738ee9..6044c9ebe50 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -841,7 +841,6 @@ static struct audio_driver pw_audio_driver = {
     .init = qpw_audio_init,
     .fini = qpw_audio_fini,
     .pcm_ops = &qpw_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in = INT_MAX,
     .voice_size_out = sizeof(PWVoiceOut),
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 68a237b76b4..5177e31d9b4 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -493,7 +493,6 @@ static struct audio_driver sdl_audio_driver = {
     .init           = sdl_audio_init,
     .fini           = sdl_audio_fini,
     .pcm_ops        = &sdl_pcm_ops,
-    .can_be_default = 1,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
     .voice_size_out = sizeof(SDLVoiceOut),
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 3fde01fdbd5..61260361ad6 100644
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
index 6445a2cb90c..57435c23e58 100644
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
index dc4da95329e..b9cdd2dd03b 100644
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
 Creating sound card devices and vnc without ``audiodev=`` property (since 4.2)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index c2043fd415d..63458736ee1 100644
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
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 6be621c2324..c0c5304474c 100644
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
index 3db4fd26808..5a1413da2aa 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2916,10 +2916,6 @@ void qemu_init(int argc, char **argv)
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


