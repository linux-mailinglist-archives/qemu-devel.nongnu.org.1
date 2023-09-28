Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F227B1519
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaR-0004l0-9q; Thu, 28 Sep 2023 03:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaP-0004j5-IG
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaN-00065v-Sx
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TYbZMVfd11QXyaqPAT/XUzIzPD4Nh+3HidIhcOWyIAE=;
 b=J9QD7WVBTqxm+Vn+l01rXhd7sGuPkRHg4OSf1htj/ODJe6GFHUENAgCl4FeeNxH67v8jvU
 bENlUtpVJaKfSrnkycSvQNk1KoM1HYWA+tDeg+HmcD7UQQB/B8imWVWpggnmQ6D6Fz1CSh
 2EVDk/RlnFYUHIsZCBAUaS+eUy8cXiE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-42YRagoxOWqAalZcEGgUMQ-1; Thu, 28 Sep 2023 03:37:21 -0400
X-MC-Unique: 42YRagoxOWqAalZcEGgUMQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-536294c9526so269190a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886640; x=1696491440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYbZMVfd11QXyaqPAT/XUzIzPD4Nh+3HidIhcOWyIAE=;
 b=vbK8wQfQaCZD2Mjnoa9Tjq7dXXgA3ZWqsKZQZXcgySDWAxs3Do2YapCy6UsJ9+b1EW
 KwADQZZ8kJc00czvTlxthv217LpKt2kJAiZuoAjTWQGpXy6ju3riTDxcS2HDFSUvQtqj
 RfHp8eQQp060ZNSyUxAjp27Uz/icnmtzedocMqHQxeL/8CXFqt+15egrCjgneuB3r4sO
 Zo3TsfIouiAl2JWyd0LJyLvjCXHA5IqiFNpM32vFKqUdtQozX5MCKF0FbG51eln4yimX
 eeMg4/kInyqOGRk2sL9AS+CZZksXPywHw2ZqPv3KiisSuD0oRkvtGA2OP3AvPv8lpHqZ
 4Xug==
X-Gm-Message-State: AOJu0YyxX2fG6AmeAAOYC4NLt1+AYeP3OCBOYfdND6/1nmLmfeAulYcq
 FZrf8bi+TnEma4blvHCeA0QAW5gDx1XsZICCFhn1Nqqil9dISSXsKPIHV21f4TAc7/nTxyLG8fK
 7ckDIxFf0TW1bI891hxIS+7soQifQXefyvcmqbN6Q2dVjPAgiS408DGzII/x9CiK8rby4hFGA3f
 s=
X-Received: by 2002:aa7:d807:0:b0:530:52d2:f656 with SMTP id
 v7-20020aa7d807000000b0053052d2f656mr465919edq.21.1695886639807; 
 Thu, 28 Sep 2023 00:37:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/9B0JGxaBgoODPMJs3lgBzYNRnyUDsy/efpE6BBMfzwlBhXNN+oiSVHYAw89xJBXufK6PUQ==
X-Received: by 2002:aa7:d807:0:b0:530:52d2:f656 with SMTP id
 v7-20020aa7d807000000b0053052d2f656mr465895edq.21.1695886639326; 
 Thu, 28 Sep 2023 00:37:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 w25-20020aa7d299000000b005329f1aa071sm9202198edq.10.2023.09.28.00.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH 06/13] audio: simplify flow in audio_init
Date: Thu, 28 Sep 2023 09:36:50 +0200
Message-ID: <20230928073705.871327-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928073705.871327-1-pbonzini@redhat.com>
References: <20230928073705.871327-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Merge two ifs into one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 76 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index e1456ad55d2..2e2e7fa72f7 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1707,12 +1707,12 @@ static AudiodevListEntry *audiodev_find(
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev, const char *name)
+static AudioState *audio_init(Audiodev *dev)
 {
     static bool atexit_registered;
     size_t i;
     int done = 0;
-    const char *drvname = NULL;
+    const char *drvname;
     VMChangeStateEntry *vmse;
     AudioState *s;
     struct audio_driver *driver;
@@ -1736,17 +1736,32 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
         }
     }
 
+    s = g_new0(AudioState, 1);
+
+    QLIST_INIT (&s->hw_head_out);
+    QLIST_INIT (&s->hw_head_in);
+    QLIST_INIT (&s->cap_head);
+    if (!atexit_registered) {
+        atexit(audio_cleanup);
+        atexit_registered = true;
+    }
+
+    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
+
     if (dev) {
         /* -audiodev option */
-        legacy_config = false;
+        s->dev = dev;
         drvname = AudiodevDriver_str(dev->driver);
-    } else if (!QTAILQ_EMPTY(&audio_states)) {
-        if (!legacy_config) {
-            dolog("Device %s: audiodev default parameter is deprecated, please "
-                  "specify audiodev=%s\n", name,
-                  QTAILQ_FIRST(&audio_states)->dev->id);
+        driver = audio_driver_lookup(drvname);
+        if (driver) {
+            done = !audio_driver_init(s, driver, true, dev);
+        } else {
+            dolog ("Unknown audio driver `%s'\n", drvname);
+        }
+        if (!done) {
+            free_audio_state(s);
+            return NULL;
         }
-        return QTAILQ_FIRST(&audio_states);
     } else {
         /* legacy implicit initialization */
         head = audio_handle_legacy_opts();
@@ -1759,33 +1774,7 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
          */
         dev = QSIMPLEQ_FIRST(&head)->dev;
         audio_validate_opts(dev, &error_abort);
-    }
 
-    s = g_new0(AudioState, 1);
-    s->dev = dev;
-
-    QLIST_INIT (&s->hw_head_out);
-    QLIST_INIT (&s->hw_head_in);
-    QLIST_INIT (&s->cap_head);
-    if (!atexit_registered) {
-        atexit(audio_cleanup);
-        atexit_registered = true;
-    }
-
-    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
-
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
         for (i = 0; audio_prio_list[i]; i++) {
             AudiodevListEntry *e = audiodev_find(&head, audio_prio_list[i]);
             driver = audio_driver_lookup(audio_prio_list[i]);
@@ -1800,8 +1789,9 @@ static AudioState *audio_init(Audiodev *dev, const char *name)
                 }
             }
         }
+
+        audio_free_audiodev_list(&head);
     }
-    audio_free_audiodev_list(&head);
 
     if (!done) {
         driver = audio_driver_lookup("none");
@@ -1841,7 +1831,16 @@ void audio_free_audiodev_list(AudiodevListHead *head)
 void AUD_register_card (const char *name, QEMUSoundCard *card)
 {
     if (!card->state) {
-        card->state = audio_init(NULL, name);
+        if (!QTAILQ_EMPTY(&audio_states)) {
+            if (!legacy_config) {
+                dolog("Device %s: audiodev default parameter is deprecated, please "
+                      "specify audiodev=%s\n", name,
+                      QTAILQ_FIRST(&audio_states)->dev->id);
+            }
+            card->state = QTAILQ_FIRST(&audio_states);
+        } else {
+            card->state = audio_init(NULL);
+        }
     }
 
     card->name = g_strdup (name);
@@ -2172,6 +2171,7 @@ void audio_define(Audiodev *dev)
     e = g_new0(AudiodevListEntry, 1);
     e->dev = dev;
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
+    legacy_config = false;
 }
 
 bool audio_init_audiodevs(void)
@@ -2179,7 +2179,7 @@ bool audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev, NULL)) {
+        if (!audio_init(e->dev)) {
             return false;
         }
     }
-- 
2.41.0


