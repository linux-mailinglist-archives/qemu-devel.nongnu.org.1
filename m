Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E37AAE8D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:46:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcj1-00023c-Ax; Fri, 22 Sep 2023 05:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjciy-00022z-R5
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjciw-00068O-K8
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qpWC6/0Jm78+OaEnMqFuG7DdN+EaDH9nTsStIrhmEEs=;
 b=FpUMDfAIx3l3z9wluePSH4nScsCsdiLRQDA+nnlbjd32GlXdEX8e9g3pzJ1QBF9yfvZWHm
 IhxVa9xa7YPTz8yiYriy+Xb4XrL0sxypUq8LfaCvS/ui4pCxS++pWSLrJBbUcFPjlyiE0I
 FU0SbdQ/BFmRHz9B41sLLaLk0vP3flA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Tnnh9tEJOi--66Y2NJoiuA-1; Fri, 22 Sep 2023 05:45:20 -0400
X-MC-Unique: Tnnh9tEJOi--66Y2NJoiuA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so1209403f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375918; x=1695980718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qpWC6/0Jm78+OaEnMqFuG7DdN+EaDH9nTsStIrhmEEs=;
 b=SVK8QblRndWX28Hm5XYMNy6zSZRmoLxlvNpzyTOZSAzK93il2/8ffGxLJXhvqwoot1
 i8cl7UsnotVuSzuyk7O1vDI0zyktRCNZ2Q/QWtpHWADspowfuV+wYRY7+X0l0zsplJN/
 6BxGfiGXuB8shrSo6KohEp8L7di0Mr90S1TqfpD+ArvH7UIvxWwsYACvyTnrHJmhJfji
 yKySeSsI2iCH5M5RjsJws3n3L0Oi9el1KdTzibE8Qf1oYj67EEuMwpET+NX5M1Mf2sTy
 x3/vymZWkIwyYw17y0aV8/OqxM/HjZGhKxwJm6nkK8BfHQdzABBTmn7JphlLNBQE6Iok
 8HGg==
X-Gm-Message-State: AOJu0Yxw6eOVp42d6LarpIzq9xf0kNBkkDvvxSavWHfXXcUkp423NhHN
 KL4QYoNBYSbo9YrPEy0ax0rIyN/CfFRKOLu7mbTx9gGrPZFW9jhd63uuHLzR9DGRdCsFpg2O+ao
 eC5hG+MYw4EpvM/rxJn8eIU3k3okYsKGzvkE9SGr2Dwc/FTuJ3t/0p8B5ofY3Bdcw1mvuRa49ZV
 4=
X-Received: by 2002:a5d:6911:0:b0:319:7abf:d8e2 with SMTP id
 t17-20020a5d6911000000b003197abfd8e2mr6885715wru.24.1695375918561; 
 Fri, 22 Sep 2023 02:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqCKYNRP53no26kwXEPATnedlITWq/wQI2QpWaAm+mG/TwrOVjXOyT48FvvLanFGtrXqLUBQ==
X-Received: by 2002:a5d:6911:0:b0:319:7abf:d8e2 with SMTP id
 t17-20020a5d6911000000b003197abfd8e2mr6885697wru.24.1695375918138; 
 Fri, 22 Sep 2023 02:45:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6511000000b0031fd849e797sm4003863wru.105.2023.09.22.02.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 9/9] audio: Be more strict during audio backend initialisation
Date: Fri, 22 Sep 2023 11:44:59 +0200
Message-ID: <20230922094459.265509-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
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

From: Martin Kletzander <mkletzan@redhat.com>

Now that audiodev= is required and audio_init() will not be called
without and AudioDev we can remove the fallback functionality and error
out in case audio drivers fail initialisation or when the driver does
not exist.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c                   | 138 ++++++++------------------------
 docs/about/deprecated.rst       |   6 --
 docs/about/removed-features.rst |  11 ++-
 3 files changed, 42 insertions(+), 113 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 4fd27309cf8..31e3195c8d7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -74,10 +74,9 @@ void audio_driver_register(audio_driver *drv)
     QLIST_INSERT_HEAD(&audio_drivers, drv, next);
 }
 
-static audio_driver *audio_driver_lookup(const char *name)
+static audio_driver *audio_driver_lookup(const char *name, Error **errp)
 {
     struct audio_driver *d;
-    Error *local_err = NULL;
     int rv;
 
     QLIST_FOREACH(d, &audio_drivers, next) {
@@ -85,15 +84,19 @@ static audio_driver *audio_driver_lookup(const char *name)
             return d;
         }
     }
-    rv = audio_module_load(name, &local_err);
+    rv = audio_module_load(name, errp);
     if (rv > 0) {
         QLIST_FOREACH(d, &audio_drivers, next) {
             if (strcmp(name, d->name) == 0) {
                 return d;
             }
         }
-    } else if (rv < 0) {
-        error_report_err(local_err);
+    }
+
+    if (rv < 0) {
+        error_prepend(errp, "Cannot load audio driver `%s': ", name);
+    } else {
+        error_setg(errp, "Unknown audio driver `%s'", name);
     }
     return NULL;
 }
@@ -1551,31 +1554,27 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
     return total;
 }
 
-static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-                             bool msg, Audiodev *dev)
+static void audio_driver_init(AudioState *s, struct audio_driver *drv,
+                              Audiodev *dev)
 {
     s->drv_opaque = drv->init(dev);
 
-    if (s->drv_opaque) {
-        if (!drv->pcm_ops->get_buffer_in) {
-            drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
-            drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
-        }
-        if (!drv->pcm_ops->get_buffer_out) {
-            drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
-            drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
-        }
-
-        audio_init_nb_voices_out(s, drv);
-        audio_init_nb_voices_in(s, drv);
-        s->drv = drv;
-        return 0;
-    } else {
-        if (msg) {
-            dolog("Could not init `%s' audio driver\n", drv->name);
-        }
-        return -1;
+    if (!s->drv_opaque) {
+        error_setg(&error_fatal, "Could not init `%s' audio driver", drv->name);
     }
+
+    if (!drv->pcm_ops->get_buffer_in) {
+        drv->pcm_ops->get_buffer_in = audio_generic_get_buffer_in;
+        drv->pcm_ops->put_buffer_in = audio_generic_put_buffer_in;
+    }
+    if (!drv->pcm_ops->get_buffer_out) {
+        drv->pcm_ops->get_buffer_out = audio_generic_get_buffer_out;
+        drv->pcm_ops->put_buffer_out = audio_generic_put_buffer_out;
+    }
+
+    audio_init_nb_voices_out(s, drv);
+    audio_init_nb_voices_in(s, drv);
+    s->drv = drv;
 }
 
 static void audio_vm_change_state_handler (void *opaque, bool running,
@@ -1680,59 +1679,26 @@ static const VMStateDescription vmstate_audio = {
 
 static void audio_validate_opts(Audiodev *dev, Error **errp);
 
-static AudiodevListEntry *audiodev_find(
-    AudiodevListHead *head, const char *drvname)
-{
-    AudiodevListEntry *e;
-    QSIMPLEQ_FOREACH(e, head, next) {
-        if (strcmp(AudiodevDriver_str(e->dev->driver), drvname) == 0) {
-            return e;
-        }
-    }
-
-    return NULL;
-}
-
 /*
  * if we have dev, this function was called because of an -audiodev argument =>
  *   initialize a new state with it
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev, const char *name)
+static AudioState *audio_init(Audiodev *dev)
 {
     static bool atexit_registered;
-    size_t i;
-    int done = 0;
     const char *drvname = NULL;
     VMChangeStateEntry *e;
     AudioState *s;
-    struct audio_driver *driver;
-    /* silence gcc warning about uninitialized variable */
-    AudiodevListHead head = QSIMPLEQ_HEAD_INITIALIZER(head);
 
-    if (dev) {
-        /* -audiodev option */
-        drvname = AudiodevDriver_str(dev->driver);
-    } else {
-        if (!QTAILQ_EMPTY(&audio_states)) {
-            dev = QTAILQ_FIRST(&audio_states)->dev;
-            if (!g_str_equal(dev->id, "#none")) {
-                dolog("Device %s: audiodev default parameter is deprecated, please "
-                      "specify audiodev=%s\n", name,
-                      dev->id);
-            }
-            return QTAILQ_FIRST(&audio_states);
-        }
-
-        dolog("No audio device specified\n");
-        dev = g_new0(Audiodev, 1);
-        dev->id = g_strdup("#none");
-        dev->driver = AUDIODEV_DRIVER_NONE;
-        dev->u.none.in = g_new0(AudiodevPerDirectionOptions, 1);
-        dev->u.none.out = g_new0(AudiodevPerDirectionOptions, 1);
+    if (!dev) {
+        error_setg(&error_abort, "Mandatory audiodev parameter required");
     }
 
+    /* -audiodev option */
+    drvname = AudiodevDriver_str(dev->driver);
+
     s = g_new0(AudioState, 1);
     s->dev = dev;
 
@@ -1761,41 +1727,7 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
         s->nb_hw_voices_in = 0;
     }
 
-    if (drvname) {
-        driver = audio_driver_lookup(drvname);
-        if (driver) {
-            done = !audio_driver_init(s, driver, true, dev);
-        } else {
-            dolog ("Unknown audio driver `%s'\n", drvname);
-        }
-        if (!done) {
-            free_audio_state(s);
-            return NULL;
-        }
-    } else {
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
-            }
-        }
-    }
-    audio_free_audiodev_list(&head);
-
-    if (!done) {
-        driver = audio_driver_lookup("none");
-        done = !audio_driver_init(s, driver, false, dev);
-        assert(done);
-        dolog("warning: Using timer based audio emulation\n");
-    }
+    audio_driver_init(s, audio_driver_lookup(drvname, &error_fatal), dev);
 
     if (dev->timer_period <= 0) {
         s->period_ticks = 1;
@@ -2132,7 +2064,7 @@ void audio_help(void)
     printf("Available audio drivers:\n");
 
     for (i = 0; i < AUDIODEV_DRIVER__MAX; i++) {
-        audio_driver *driver = audio_driver_lookup(AudiodevDriver_str(i));
+        audio_driver *driver = audio_driver_lookup(AudiodevDriver_str(i), NULL);
         if (driver) {
             printf("%s\n", driver->name);
         }
@@ -2170,7 +2102,7 @@ bool audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev, NULL)) {
+        if (!audio_init(e->dev)) {
             return false;
         }
     }
@@ -2187,7 +2119,7 @@ static void audio_init_dummy(const char *id)
     dev->id = g_strdup(id);
 
     audio_validate_opts(dev, &error_abort);
-    audio_init(dev, NULL);
+    audio_init(dev);
 
     e->dev = dev;
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2f51cf770ae..d59bcf36230 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -37,12 +37,6 @@ coverage.
 System emulator command line arguments
 --------------------------------------
 
-Creating sound card devices without ``audiodev=`` property (since 4.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-When not using the deprecated legacy audio config, each sound card
-should specify an ``audiodev=`` property.
-
 Short-form boolean options (since 6.0)
 ''''''''''''''''''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e75e1b9ac31..56e078ad126 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -442,11 +442,13 @@ line using a ``secret`` object instance.
 The ``-audiodev`` and ``-audio`` command line options are now the only
 way to specify audio backend settings.
 
-Creating vnc without ``audiodev=`` property (removed in 8.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+Creating sound card devices and vnc without ``audiodev=`` property (removed in 8.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-When using vnc, you should specify an ``audiodev=`` property if
-you plan to transmit audio through the VNC protocol.
+Each sound card has to specify an ``audiodev=`` property, unless the
+machine defines an ``audiodev=`` property.  Additionally, when using vnc,
+you should specify an ``audiodev=`` property if you plan to transmit audio
+through the VNC protocol.
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
-- 
2.41.0


