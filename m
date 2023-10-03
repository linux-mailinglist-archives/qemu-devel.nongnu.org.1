Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD627B645B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoa-0002x0-HH; Tue, 03 Oct 2023 04:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoR-0002PN-8m
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoN-0000L0-Iq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R35GuaxbPqLX8vLeX4uWYvTxQwHT9t6PuBxHCoBtF3I=;
 b=ZdC5ffjfmynxMGVpkRuYjdWmp9BNVcu56Eq/ZcZVa/mlKVaJ6IS0flU9hc+ktbiaJZaum/
 psQ9dpumIVwCHsDnqWCkL83cBxP9rVfkIKwITORdwnpqGyrFe2OSwuLgGuEPlHXPixGALm
 c1GbjUti64KaZB+jfoYocvu9Ttq2HUU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-3Kc9CkoSOgmtfwTzZFdz5w-1; Tue, 03 Oct 2023 04:31:20 -0400
X-MC-Unique: 3Kc9CkoSOgmtfwTzZFdz5w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9e12a3093so73767866b.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321878; x=1696926678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R35GuaxbPqLX8vLeX4uWYvTxQwHT9t6PuBxHCoBtF3I=;
 b=UyPnpz0ndzhpXLxGUAa6LY+Zk0RcKB+9XI0+mizYrCSLIzYSCVpbJijDfS/pxBWY7v
 TZsj0esnf1DZ03MG9NFevjf/kZACjigzJfhzrQ0ynwinb/zHSmqzCUko9GoaXFMispiP
 mR6gxSIhFKo9/YiIxcFprJdEC30ggJEuiyM3AeObQqKB0/tr/86NmkjnTOfmRe5ggpHc
 iXlot50neYvD4P1ehHPFSVYUZz3vUE1TvXB0KbfHQjMsYNN7riVD/n4Ix6bZ5Qf/Dmq5
 UWDF2eHXDigFqezMVucGh91/T/TuGU0btXvqVtrl+32w9UQ/eYY/o01j5XlFAG0VzjkB
 dRQQ==
X-Gm-Message-State: AOJu0Yzgvq3wwzvJkezWEAJk1lI3E3P6/Z5ZMoHz4bSodeiklYYj4msB
 NXwalrzuzdPj5N4qR31EzwJL0WHbXTvBz26nhyKytCKjytaLPo2676qvBUWKy8JIxMTCRWkHPjJ
 9ItDvWXzE6nnIOX5cM/A/iFfrHafIKWKosH2hoy6w6eM8fUQpVeUOzWj9yy/nrkhRg28olOwYPj
 M=
X-Received: by 2002:a17:906:794a:b0:9ae:50ec:bd81 with SMTP id
 l10-20020a170906794a00b009ae50ecbd81mr1781977ejo.21.1696321878563; 
 Tue, 03 Oct 2023 01:31:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbGQ+l0Lx37QHRXHC5guISB8gItnYnnryXWdXnuV6tXhOvL8ffxI7f1V/nrIIqIgbY3Bu5wQ==
X-Received: by 2002:a17:906:794a:b0:9ae:50ec:bd81 with SMTP id
 l10-20020a170906794a00b009ae50ecbd81mr1781960ejo.21.1696321878103; 
 Tue, 03 Oct 2023 01:31:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a170906474c00b00993a37aebc5sm643226ejs.50.2023.10.03.01.31.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/24] audio: simplify flow in audio_init
Date: Tue,  3 Oct 2023 10:30:34 +0200
Message-ID: <20231003083042.110065-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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


