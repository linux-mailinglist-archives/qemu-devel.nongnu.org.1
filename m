Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DC37B5583
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMo-0008C5-NB; Mon, 02 Oct 2023 10:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMm-00088j-9z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMk-0003fT-Mw
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R35GuaxbPqLX8vLeX4uWYvTxQwHT9t6PuBxHCoBtF3I=;
 b=XfMpWgDSz+NWcIKrUntpHM0Bc3V5QwqmBgMtkzxDnLKKyDQfp5WN4+Qdb4n1zLGhn63cPb
 lh8DUK4BBwGYkhoSk1r8um5KbSiXJsovHXClbauMpwZ12Zj+Tx497I0SeD+z6C3mESRtsf
 UBIyQ/2qLpX72xKnjj/xKHNqC96L9Ok=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-km9NumhUOKK9jB4qgHL9NA-1; Mon, 02 Oct 2023 10:57:44 -0400
X-MC-Unique: km9NumhUOKK9jB4qgHL9NA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-323334992fbso7483185f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258663; x=1696863463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R35GuaxbPqLX8vLeX4uWYvTxQwHT9t6PuBxHCoBtF3I=;
 b=NP36oLoAsdzddcAImfBkSfsxPOaVaoM0CZ6GhQDZ4PeJTRTT0K2wup9qdfXy1WKcVz
 B1VubOVb+n+gSjK5mlpcrVDdaIKrL2S3aVpM6/mk0p8OFc9o62fUBZ2/1UI9IJhT9drw
 F2wb3evqvpHeOGjKHUzXHb4bNyy/yKZ8uEfgq5PhqZ75HjuNtjtsOFGsHmOlmFTXvzqU
 wli0UXM4UEPThRM6/4hSe0YkQACygICsPTguObSLRn8bja3ckrnROfeBkmVOri/YlUHQ
 VNFeoZ0Iz3ByAPid3jxaCihv/J7nrXW5yk0f6GObHUN3KuwvDMsWk7H/0judQmXkwxwA
 exZg==
X-Gm-Message-State: AOJu0YwznT8UTA4p1XVOM4zBpTQN3ouvIjml2GeVu4+rak/fskzv0V5N
 HIhlT+acOwP0MdtTB4e1tCZBEJYiNfUlHtiNTwSjb4ui+fU+wASn+JdZbEwsqOLnQQuXMK8nmkb
 Oa94WgCUYWkPDdy0o2uBeFg2vp+ZKofZbfAyPTu01b+cZ5YbjYZ/3PsZTMx+0X/agRxlIHWr2BP
 E=
X-Received: by 2002:adf:f08f:0:b0:323:1d06:38e5 with SMTP id
 n15-20020adff08f000000b003231d0638e5mr10853656wro.55.1696258662953; 
 Mon, 02 Oct 2023 07:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsAG1IapMrTe7rnbSjppUZhxieNTCpGDma9ijK9MQo0kyQBwlVhaWf56pHE8BczLGZapTMrQ==
X-Received: by 2002:adf:f08f:0:b0:323:1d06:38e5 with SMTP id
 n15-20020adff08f000000b003231d0638e5mr10853637wro.55.1696258662607; 
 Mon, 02 Oct 2023 07:57:42 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a1709062a4f00b009ad8084e08asm17043806eje.0.2023.10.02.07.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PATCH 06/13] audio: simplify flow in audio_init
Date: Mon,  2 Oct 2023 16:57:20 +0200
Message-ID: <20231002145728.87958-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
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
index bb1734a95d3..2e22664daf9 100644
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
@@ -2171,6 +2170,7 @@ void audio_define(Audiodev *dev)
     e = g_new0(AudiodevListEntry, 1);
     e->dev = dev;
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
+    legacy_config = false;
 }
 
 bool audio_init_audiodevs(void)
@@ -2178,7 +2178,7 @@ bool audio_init_audiodevs(void)
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev, NULL)) {
+        if (!audio_init(e->dev)) {
             return false;
         }
     }
-- 
2.41.0


