Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB797ABEFB
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQC-0002qI-Ov; Sat, 23 Sep 2023 04:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQA-0002pG-Ro
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ9-0000XM-At
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWIeU7p98wAMa3PMyhfRoRZrGE23S1UxRVxrrNKKEQA=;
 b=KzpBcr+r9N1O1U0V3UT3fKCdB1zwO6Jqz8SciqsnNd4r4S2o7DxJFvl+1lh8NXQbn8XPAf
 X66b+XBcsFSQeNxZw4mjJh8yVLgamL8H9dgxLsGM45NTXDQPzamhJh1eYZl9Sbc5J/NIX2
 58TNOgoOBErfauPYHnXaFAG0FU+QXK0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-k324dMgcOZ-OCeh78uuMJQ-1; Sat, 23 Sep 2023 04:55:23 -0400
X-MC-Unique: k324dMgcOZ-OCeh78uuMJQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40526a782f7so28701155e9.2
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459321; x=1696064121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AWIeU7p98wAMa3PMyhfRoRZrGE23S1UxRVxrrNKKEQA=;
 b=YVxbWwY8ZhpA6SLXRmwJo1CxfhAMvHWdEeQCBfB5lvpWC0UAQpmnimRLPkJEe9Do8B
 OJMDD9gpuoiDmvNZ4VdK02n0f/k54e3xoNWEoW5G9DciXLHLccuWia6Qg0rP0fAPue81
 y4xsfuTjXZxZM3oRqF8PHq4gsRC7MntTRYftnVo57il7lULJR6npC/SqKaKU0Hkc6rCO
 Fpp4yldMAF/1Q4rB5XfecZHgTqdFCDQqd7K/Ix+GpdqyPGKen1vrTBuJPBxhXoC/s3Z1
 UnEyBxPVjzrfyf0la4IZwrwak1M1CiEUBlEH6oRFWN7c46zC4nHkgjSeAhgzVd5GsDJf
 xbsw==
X-Gm-Message-State: AOJu0YxpsnLG4oacWbFKaHn87EyT/D6kterWeX0j4C+G5DNPEJMI/1Q6
 /GOdvKy7FXun1W5TFPHXulawdDkQaLx2F83sTkSkfV46Eooxc5gCGPgL8637aJxEsVhjYPTN47q
 kg2dqKYICXTlwK2ssL7LgfT3jII1wdBFsiLO8JR8bQ2OreR2KdNULwjgT5p+ULknJHNgrumNfLz
 w=
X-Received: by 2002:a7b:c84e:0:b0:3fe:2b60:b24e with SMTP id
 c14-20020a7bc84e000000b003fe2b60b24emr1355369wml.29.1695459321218; 
 Sat, 23 Sep 2023 01:55:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9QazCSNaDrRreEa6fEqMXj98SVd6HcJteQRwM5hOqtBqogMasOBibyKsLdP+tb8XUmvmLMw==
X-Received: by 2002:a7b:c84e:0:b0:3fe:2b60:b24e with SMTP id
 c14-20020a7bc84e000000b003fe2b60b24emr1355354wml.29.1695459320948; 
 Sat, 23 Sep 2023 01:55:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a05600c2d5500b004053e9276easm3643235wmg.32.2023.09.23.01.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 06/13] audio: simplify flow in audio_init
Date: Sat, 23 Sep 2023 10:54:59 +0200
Message-ID: <20230923085507.399260-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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

Merge two ifs into one.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 76 +++++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 70835a9ef28..a2397e08cbe 100644
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
     VMChangeStateEntry *e;
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
@@ -2173,6 +2172,7 @@ void audio_define(Audiodev *dev)
     e = g_new0(AudiodevListEntry, 1);
     e->dev = dev;
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
+    legacy_config = false;
 }
 
 bool audio_init_audiodevs(void)
@@ -2180,7 +2180,7 @@ bool audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev, NULL)) {
+        if (!audio_init(e->dev)) {
             return false;
         }
     }
-- 
2.41.0


