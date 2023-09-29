Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D77B2E80
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EF-00061j-OU; Fri, 29 Sep 2023 04:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Dw-0005VI-SF
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9DZ-0005kD-Bc
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42BKwR9boJnqSTyQtjOimETiRg2ddeniC2cVZYNUqso=;
 b=CrczEUFvdaEIoVGn+s6dly6XCiZMgOP7t3oAo3sW4r+VqWcaByLs901DaBw2xcfeZOiFyH
 ZCUApQIPYT8sRC1/emT/Gr46A590uCd1ASEFRF6jVYa8x1FQLawOMlPsaMDDuzAfqQ+hDZ
 egezIPEOxE2nCiRgn3s3XyvWnBC9usE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5--d44L_klPKu-HRuVHR0oBw-1; Fri, 29 Sep 2023 04:51:23 -0400
X-MC-Unique: -d44L_klPKu-HRuVHR0oBw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-533d8a785a5so8815382a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977481; x=1696582281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42BKwR9boJnqSTyQtjOimETiRg2ddeniC2cVZYNUqso=;
 b=jIOoTvoxIwp1lypHkuj/Ugcpw71T+i73m1zHa05XKI/VSUsxaebpZ9dnkLg8Ppp5SC
 MQGTGmsi9SRuk6TMFsJb/3Ryw3WffubzS926Rqo0sgol7W+V3EyWvG74D2qqeJvJc6gG
 fnSzNO2JH1vv5UyazqmdfNBQ8omtnz224CeMgRRJxnGRcgOTDUe/piF0kQmGi9TgihJI
 kDj8f3tkLaRC4ZvXR4cxC2gPlN1xwDYpwl4kjqmIbDUteS80szfNO/Kz5S4ZSnhxWhxK
 6M+G5svzmKcrFOg0h21Mq8GfAYqkARi8S5INim40FD2bGUZ2lLRDklH5luSCiNMrpHCK
 JOcA==
X-Gm-Message-State: AOJu0YwptpHsljFk7t3oCkyWsGjSaACPDos/grM/ltGcsAShV9JBI/Pm
 ct7Z3oDw5q8sRN/HtWrFtcuP1b5SSJ6QxLJ6LxjKXkmLCt2XRWm6a+sj5VEm9YnPF0yUVyXeIG0
 1qOJtcppk1LTp6xTW98s6hSaDjchd86pN1o7W5DzLTbtRx6zwBbmEIYzk5p6FyhSZWQ1AzvizUw
 0=
X-Received: by 2002:aa7:d793:0:b0:523:3754:a4e1 with SMTP id
 s19-20020aa7d793000000b005233754a4e1mr3180054edq.22.1695977480825; 
 Fri, 29 Sep 2023 01:51:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGow9uzLVHOqKDS/LxyEPFTFgvhUq4YvNs+Jo9TR+L7ijg0dwZn9RuYp3X1jCVdpA88b2i6BA==
X-Received: by 2002:aa7:d793:0:b0:523:3754:a4e1 with SMTP id
 s19-20020aa7d793000000b005233754a4e1mr3180033edq.22.1695977480328; 
 Fri, 29 Sep 2023 01:51:20 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05640207c700b005311e934765sm10896353edy.27.2023.09.29.01.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 03/14] audio: allow returning an error from the driver init
Date: Fri, 29 Sep 2023 10:50:56 +0200
Message-ID: <20230929085112.983957-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

An error is already printed by audio_driver_init, but we can make
it more precise if the driver can return an Error *.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/alsaaudio.c   |  2 +-
 audio/audio.c       | 13 ++++++++++---
 audio/audio_int.h   |  2 +-
 audio/coreaudio.m   |  2 +-
 audio/dbusaudio.c   |  2 +-
 audio/dsoundaudio.c |  2 +-
 audio/jackaudio.c   |  2 +-
 audio/noaudio.c     |  2 +-
 audio/ossaudio.c    | 11 ++++++++---
 audio/paaudio.c     |  7 +++++--
 audio/pwaudio.c     | 16 +++++++++-------
 audio/sdlaudio.c    |  5 +++--
 audio/sndioaudio.c  |  2 +-
 audio/spiceaudio.c  |  5 ++++-
 audio/wavaudio.c    |  2 +-
 15 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index 057571dd1e0..6fb78e5b972 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -904,7 +904,7 @@ static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
     }
 }
 
-static void *alsa_audio_init(Audiodev *dev)
+static void *alsa_audio_init(Audiodev *dev, Error **errp)
 {
     AudiodevAlsaOptions *aopts;
     assert(dev->driver == AUDIODEV_DRIVER_ALSA);
diff --git a/audio/audio.c b/audio/audio.c
index 4332c4c6ce8..3d664503521 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -33,6 +33,7 @@
 #include "qapi/qapi-visit-audio.h"
 #include "qapi/qapi-commands-audio.h"
 #include "qemu/cutils.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/help_option.h"
@@ -1555,7 +1556,9 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
                              bool msg, Audiodev *dev)
 {
-    s->drv_opaque = drv->init(dev);
+    Error *local_err = NULL;
+
+    s->drv_opaque = drv->init(dev, &local_err);
 
     if (s->drv_opaque) {
         if (!drv->pcm_ops->get_buffer_in) {
@@ -1572,8 +1575,12 @@ static int audio_driver_init(AudioState *s, struct audio_driver *drv,
         s->drv = drv;
         return 0;
     } else {
-        if (msg) {
-            dolog("Could not init `%s' audio driver\n", drv->name);
+        if (!msg) {
+            error_free(local_err);
+        } else if (local_err) {
+            error_report_err(local_err);
+        } else {
+            error_report("Could not init `%s' audio driver", drv->name);
         }
         return -1;
     }
diff --git a/audio/audio_int.h b/audio/audio_int.h
index e57ff50155a..06e815de9f6 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -140,7 +140,7 @@ typedef struct audio_driver audio_driver;
 struct audio_driver {
     const char *name;
     const char *descr;
-    void *(*init) (Audiodev *);
+    void *(*init) (Audiodev *, Error **);
     void (*fini) (void *);
 #ifdef CONFIG_GIO
     void (*set_dbus_server) (AudioState *s, GDBusObjectManagerServer *manager, bool p2p);
diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 4695291621a..7cfb38fb6ae 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -644,7 +644,7 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
     update_device_playback_state(core);
 }
 
-static void *coreaudio_audio_init(Audiodev *dev)
+static void *coreaudio_audio_init(Audiodev *dev, Error **errp)
 {
     return dev;
 }
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index 7a11fbfb420..310ca997ff4 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -395,7 +395,7 @@ dbus_enable_in(HWVoiceIn *hw, bool enable)
 }
 
 static void *
-dbus_audio_init(Audiodev *dev)
+dbus_audio_init(Audiodev *dev, Error **errp)
 {
     DBusAudio *da = g_new0(DBusAudio, 1);
 
diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
index 3fb67ec3eed..eefde88edcb 100644
--- a/audio/dsoundaudio.c
+++ b/audio/dsoundaudio.c
@@ -619,7 +619,7 @@ static void dsound_audio_fini (void *opaque)
     g_free(s);
 }
 
-static void *dsound_audio_init(Audiodev *dev)
+static void *dsound_audio_init(Audiodev *dev, Error **errp)
 {
     int err;
     HRESULT hr;
diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index e1eaa3477dc..823e7d96bae 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -645,7 +645,7 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
 }
 #endif
 
-static void *qjack_init(Audiodev *dev)
+static void *qjack_init(Audiodev *dev, Error **errp)
 {
     assert(dev->driver == AUDIODEV_DRIVER_JACK);
     return dev;
diff --git a/audio/noaudio.c b/audio/noaudio.c
index 4fdee5adecf..a36bfeffd14 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -104,7 +104,7 @@ static void no_enable_in(HWVoiceIn *hw, bool enable)
     }
 }
 
-static void *no_audio_init(Audiodev *dev)
+static void *no_audio_init(Audiodev *dev, Error **errp)
 {
     return &no_audio_init;
 }
diff --git a/audio/ossaudio.c b/audio/ossaudio.c
index e8d732b612c..ec4448d573d 100644
--- a/audio/ossaudio.c
+++ b/audio/ossaudio.c
@@ -28,6 +28,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/host-utils.h"
+#include "qapi/error.h"
 #include "audio.h"
 #include "trace.h"
 
@@ -736,7 +737,7 @@ static void oss_init_per_direction(AudiodevOssPerDirectionOptions *opdo)
     }
 }
 
-static void *oss_audio_init(Audiodev *dev)
+static void *oss_audio_init(Audiodev *dev, Error **errp)
 {
     AudiodevOssOptions *oopts;
     assert(dev->driver == AUDIODEV_DRIVER_OSS);
@@ -745,8 +746,12 @@ static void *oss_audio_init(Audiodev *dev)
     oss_init_per_direction(oopts->in);
     oss_init_per_direction(oopts->out);
 
-    if (access(oopts->in->dev ?: "/dev/dsp", R_OK | W_OK) < 0 ||
-        access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
+    if (access(oopts->in->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
+        error_setg_errno(errp, errno, "%s not accessible", oopts->in->dev ?: "/dev/dsp");
+        return NULL;
+    }
+    if (access(oopts->out->dev ?: "/dev/dsp", R_OK | W_OK) < 0) {
+        error_setg_errno(errp, errno, "%s not accessible", oopts->out->dev ?: "/dev/dsp");
         return NULL;
     }
     return dev;
diff --git a/audio/paaudio.c b/audio/paaudio.c
index 529b39daacc..39bd6cfa38a 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -3,7 +3,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "audio.h"
-#include "qapi/opts-visitor.h"
+#include "qapi/error.h"
 
 #include <pulse/pulseaudio.h>
 
@@ -818,7 +818,7 @@ fail:
     return NULL;
 }
 
-static void *qpa_audio_init(Audiodev *dev)
+static void *qpa_audio_init(Audiodev *dev, Error **errp)
 {
     paaudio *g;
     AudiodevPaOptions *popts = &dev->u.pa;
@@ -834,10 +834,12 @@ static void *qpa_audio_init(Audiodev *dev)
 
         runtime = getenv("XDG_RUNTIME_DIR");
         if (!runtime) {
+            error_setg(errp, "XDG_RUNTIME_DIR not set");
             return NULL;
         }
         snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
         if (stat(pidfile, &st) != 0) {
+            error_setg_errno(errp, errno, "could not stat pidfile %s", pidfile);
             return NULL;
         }
     }
@@ -867,6 +869,7 @@ static void *qpa_audio_init(Audiodev *dev)
     }
     if (!g->conn) {
         g_free(g);
+        error_setg(errp, "could not connect to PulseAudio server");
         return NULL;
     }
 
diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index b6a38738ee9..1020cb11df1 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -13,6 +13,7 @@
 #include "audio.h"
 #include <errno.h>
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include <spa/param/audio/format-utils.h>
 #include <spa/utils/ringbuffer.h>
 #include <spa/utils/result.h>
@@ -736,7 +737,7 @@ static const struct pw_core_events core_events = {
 };
 
 static void *
-qpw_audio_init(Audiodev *dev)
+qpw_audio_init(Audiodev *dev, Error **errp)
 {
     g_autofree pwaudio *pw = g_new0(pwaudio, 1);
 
@@ -748,19 +749,19 @@ qpw_audio_init(Audiodev *dev)
     pw->dev = dev;
     pw->thread_loop = pw_thread_loop_new("PipeWire thread loop", NULL);
     if (pw->thread_loop == NULL) {
-        error_report("Could not create PipeWire loop: %s", g_strerror(errno));
+        error_setg_errno(errp, errno, "Could not create PipeWire loop");
         goto fail;
     }
 
     pw->context =
         pw_context_new(pw_thread_loop_get_loop(pw->thread_loop), NULL, 0);
     if (pw->context == NULL) {
-        error_report("Could not create PipeWire context: %s", g_strerror(errno));
+        error_setg_errno(errp, errno, "Could not create PipeWire context");
         goto fail;
     }
 
     if (pw_thread_loop_start(pw->thread_loop) < 0) {
-        error_report("Could not start PipeWire loop: %s", g_strerror(errno));
+        error_setg_errno(errp, errno, "Could not start PipeWire loop");
         goto fail;
     }
 
@@ -769,13 +770,13 @@ qpw_audio_init(Audiodev *dev)
     pw->core = pw_context_connect(pw->context, NULL, 0);
     if (pw->core == NULL) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail;
+        goto fail_error;
     }
 
     if (pw_core_add_listener(pw->core, &pw->core_listener,
                              &core_events, pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail;
+        goto fail_error;
     }
     if (wait_resync(pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
@@ -785,8 +786,9 @@ qpw_audio_init(Audiodev *dev)
 
     return g_steal_pointer(&pw);
 
+fail_error:
+    error_setg(errp, "Failed to initialize PW context");
 fail:
-    AUD_log(AUDIO_CAP, "Failed to initialize PW context");
     if (pw->thread_loop) {
         pw_thread_loop_stop(pw->thread_loop);
     }
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
index 68a237b76b4..4d8473d9ece 100644
--- a/audio/sdlaudio.c
+++ b/audio/sdlaudio.c
@@ -26,6 +26,7 @@
 #include <SDL.h>
 #include <SDL_thread.h>
 #include "qemu/module.h"
+#include "qapi/error.h"
 #include "audio.h"
 
 #ifndef _WIN32
@@ -449,10 +450,10 @@ static void sdl_enable_in(HWVoiceIn *hw, bool enable)
     SDL_PauseAudioDevice(sdl->devid, !enable);
 }
 
-static void *sdl_audio_init(Audiodev *dev)
+static void *sdl_audio_init(Audiodev *dev, Error **errp)
 {
     if (SDL_InitSubSystem (SDL_INIT_AUDIO)) {
-        sdl_logerr ("SDL failed to initialize audio subsystem\n");
+        error_setg(errp, "SDL failed to initialize audio subsystem");
         return NULL;
     }
 
diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 3fde01fdbd5..1e35925a497 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -518,7 +518,7 @@ static void sndio_fini_in(HWVoiceIn *hw)
     sndio_fini(self);
 }
 
-static void *sndio_audio_init(Audiodev *dev)
+static void *sndio_audio_init(Audiodev *dev, Error **errp)
 {
     assert(dev->driver == AUDIODEV_DRIVER_SNDIO);
     return dev;
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index d17ef1a25ef..7f02f7285cf 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -22,6 +22,7 @@
 #include "qemu/module.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
+#include "qapi/error.h"
 #include "ui/qemu-spice.h"
 
 #define AUDIO_CAP "spice"
@@ -71,11 +72,13 @@ static const SpiceRecordInterface record_sif = {
     .base.minor_version = SPICE_INTERFACE_RECORD_MINOR,
 };
 
-static void *spice_audio_init(Audiodev *dev)
+static void *spice_audio_init(Audiodev *dev, Error **errp)
 {
     if (!using_spice) {
+        error_setg(errp, "Cannot use spice audio without -spice");
         return NULL;
     }
+
     return &spice_audio_init;
 }
 
diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index 6445a2cb90c..26b03906d59 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -182,7 +182,7 @@ static void wav_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
-static void *wav_audio_init(Audiodev *dev)
+static void *wav_audio_init(Audiodev *dev, Error **errp)
 {
     assert(dev->driver == AUDIODEV_DRIVER_WAV);
     return dev;
-- 
2.41.0


