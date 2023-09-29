Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1807B2E93
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EG-00062Q-06; Fri, 29 Sep 2023 04:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EB-0005jI-NH
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Dg-0005lh-Bm
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGH+M0fuvIFCi6QOwPCOQd0lXkYR3OEDHngCBdZqUDI=;
 b=DEY9IXGhGnX7zOPPXCymf4YinogIuVGlhbHqKWNDTUTKomWhtXqPQdVS5OLEsiGUSp/KUv
 fmbLd4C5fCIgCZ4fKGtJitymNFdTn3e9tzFI2NeiwfCrMXTfA0aUFEy3hdL30Dc+YTTcXk
 GWhoIbcC52rzFj9JPY44fq1tw06x2X0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-abmnIz6UOSikmZJRHpIdXQ-1; Fri, 29 Sep 2023 04:51:29 -0400
X-MC-Unique: abmnIz6UOSikmZJRHpIdXQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b2cf504e3aso60003866b.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977487; x=1696582287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UGH+M0fuvIFCi6QOwPCOQd0lXkYR3OEDHngCBdZqUDI=;
 b=NgWD7ydTpnqxoI43Y/n8aycaKyXWYZdoz4H+rYnWfC0WsrRwD/ZfCnxtXokXCWIdo+
 imMimfCH808kc6/2fyJHk86nbBRVRTM2ILU6jEF9YJVOavjQAY/jGhMTHoDdOQMyyXko
 fCjv0Q3iauY1lb5qdHmi+lyl0DrxNFik8/le1ZS6k1cZG887zLdcZVgH0NS+VHCihIBU
 DOV6KYuiDO/AOmFAYmwP6s5Anwc9nW8xwtzLIZR8rvBwwPFltsjBxzqXSHj4XY2B6toX
 dnyv4jRuVlgqyufnz1zMFCoEhtCR1Tc6Dzx4NlSG5FDO2EgUpRnPkaAEguiWpITO7Nwg
 yfoA==
X-Gm-Message-State: AOJu0YyNKbv+xLIqlk1QNI47OgP4UFAGtDQT2PaBVAvkbNSQl0tWGhh1
 FdGVWcQ4ZIDEKx0lBOtJnZRjLgH26CDCVYw7l+vMRroSbtmSfZMdMDYXYWnPfL9aiPS+IrCvwlF
 vrONFTHVjNefQCJ/nUR1s/GnGtImmPq+TnuQQd8lQ0vZo171Z7pKTn1rBSC8QEJL7pioabVlfW4
 U=
X-Received: by 2002:a17:906:20ce:b0:9b2:b71f:83be with SMTP id
 c14-20020a17090620ce00b009b2b71f83bemr3589431ejc.1.1695977487112; 
 Fri, 29 Sep 2023 01:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCkTBnNTGvBRxr8xZSrMnRzPKnRxsnjl3oOE6NXyy5bbXz3YLZVQX09l0Txl3FTuuttCx6aQ==
X-Received: by 2002:a17:906:20ce:b0:9b2:b71f:83be with SMTP id
 c14-20020a17090620ce00b009b2b71f83bemr3589417ejc.1.1695977486772; 
 Fri, 29 Sep 2023 01:51:26 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 md1-20020a170906ae8100b009a1be9c29d7sm12126529ejb.179.2023.09.29.01.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 06/14] audio: simplify flow in audio_init
Date: Fri, 29 Sep 2023 10:50:59 +0200
Message-ID: <20230929085112.983957-7-pbonzini@redhat.com>
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
index 2014a2904e8..e3ca5fe65ec 100644
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


