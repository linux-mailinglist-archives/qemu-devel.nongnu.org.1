Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8337B2E81
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EP-0006NR-3h; Fri, 29 Sep 2023 04:52:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9EG-0006BI-13
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9E6-0005pv-MU
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+4EgO9bvE1CYPSJHgSwK6cuXzMcRh2RzpgVET0+boo=;
 b=AwOwsXfrPxSClRmfhuPsfv0ETD6emGNuiDnvOW2fwOGMcUnY4CZAhGI1QJ2SzHM03mIYtY
 yAKMfH8B/t/fx20amX8UxCoCiYMDN+S7jPKSEN6pm6VYj1PqM9l/HQnTEAdWbpLs5N+uNp
 whwM9mgXQLyWv1LBoRKx3ujPWN9COFw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-Gkmzx0TEP0-VK8_mbOLRsA-1; Fri, 29 Sep 2023 04:51:46 -0400
X-MC-Unique: Gkmzx0TEP0-VK8_mbOLRsA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-536294c9526so1364420a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977504; x=1696582304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+4EgO9bvE1CYPSJHgSwK6cuXzMcRh2RzpgVET0+boo=;
 b=uLJx8BeSnjAKCeBMg70veQU8OV/dEzh94n7+9U3LoZlUI6VApvTPXur5ScRRFFIeKY
 TOXhRzJXdQyeQQlm5GVVjmS+UfwWvddv7mrkyznpgnMXa34LqmSj5oKsbX+laLuJPTNa
 g4ncOikJ/k9K/U+i5KcUHIx1MV3we4ns6Mv19HZI6I2LXNSkNA5+iOtf/QiUsVGQkM82
 g/5k/i1w+B9zUbpL5QWtI9G9n2ZXhVGRQdw3mFByT/YsDalT7fbNVZEqPw7YFCwgzPBA
 1A4wy/w76i4+gll3KymBb/5CRwu2Kij66ObhPygpQuybRGXSZekaLA6oAG6KHyYb7aaw
 szKw==
X-Gm-Message-State: AOJu0YwiydysCg0MVYXUruwN2xSoOORqmbhyxkiShG8C+1fUXQvCd4JP
 X9xhtjEmYNeJThNRHDEkunqKjvzHVBBIB1Y1JjUi3mA7Ua1y2dhMZHODqyFTznMKWng1ClBoDWE
 f8XlProsakiXgD1Vov5rqPnBfL6H8o/IuiR4CuMMrUo0gK0KZdtpRZaUdrRr7dH/In48/8JFA7y
 A=
X-Received: by 2002:a05:6402:d59:b0:537:821e:b8fd with SMTP id
 ec25-20020a0564020d5900b00537821eb8fdmr728979edb.27.1695977504577; 
 Fri, 29 Sep 2023 01:51:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHanz6Q7xqVsktn7FtMktoPZhuZzTXtshU2u2La9ZpAFFOr6wO1dDHv/LzcvjPwmdcc9ByeRg==
X-Received: by 2002:a05:6402:d59:b0:537:821e:b8fd with SMTP id
 ec25-20020a0564020d5900b00537821eb8fdmr728963edb.27.1695977504182; 
 Fri, 29 Sep 2023 01:51:44 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 fd18-20020a056402389200b005331f6d4a30sm5250038edb.56.2023.09.29.01.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 14/14] audio: propagate Error out of audio_driver_init
Date: Fri, 29 Sep 2023 10:51:07 +0200
Message-ID: <20230929085112.983957-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929085112.983957-1-pbonzini@redhat.com>
References: <20230929085112.983957-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now that all the callers of audio_init can report failure, pass the Error
from audio_driver_init to audio_init instead of reporting it directly
in audio_driver_init.  This eliminates more complex logic that calls
error_report_err and error_init, replacing it with just &error_fatal
(when creating command line audiodevs) and error propagation
(when creating default audiodevs from AUD_register_card).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 31 ++++++++++++++-----------------
 audio/audio.h |  2 +-
 softmmu/vl.c  |  4 +---
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 7cfcbfb6ef1..380da72a7b0 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1556,7 +1556,7 @@ size_t audio_generic_read(HWVoiceIn *hw, void *buf, size_t size)
 }
 
 static int audio_driver_init(AudioState *s, struct audio_driver *drv,
-                             bool msg, Audiodev *dev)
+                             Audiodev *dev, Error **errp)
 {
     Error *local_err = NULL;
 
@@ -1577,12 +1577,10 @@ static int audio_driver_init(AudioState *s, struct audio_driver *drv,
         s->drv = drv;
         return 0;
     } else {
-        if (!msg) {
-            error_free(local_err);
-        } else if (local_err) {
-            error_report_err(local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
         } else {
-            error_report("Could not init `%s' audio driver", drv->name);
+            error_setg(errp, "Could not init `%s' audio driver", drv->name);
         }
         return -1;
     }
@@ -1733,7 +1731,7 @@ static void audio_create_default_audiodevs(void)
  * if dev == NULL => legacy implicit initialization, return the already created
  *   state or create a new one
  */
-static AudioState *audio_init(Audiodev *dev)
+static AudioState *audio_init(Audiodev *dev, Error **errp)
 {
     static bool atexit_registered;
     int done = 0;
@@ -1760,9 +1758,9 @@ static AudioState *audio_init(Audiodev *dev)
         drvname = AudiodevDriver_str(dev->driver);
         driver = audio_driver_lookup(drvname);
         if (driver) {
-            done = !audio_driver_init(s, driver, true, dev);
+            done = !audio_driver_init(s, driver, dev, errp);
         } else {
-            dolog ("Unknown audio driver `%s'\n", drvname);
+            error_setg(errp, "Unknown audio driver `%s'\n", drvname);
         }
         if (!done) {
             free_audio_state(s);
@@ -1778,7 +1776,7 @@ static AudioState *audio_init(Audiodev *dev)
             s->dev = dev = e->dev;
             drvname = AudiodevDriver_str(dev->driver);
             driver = audio_driver_lookup(drvname);
-            if (!audio_driver_init(s, driver, false, dev)) {
+            if (!audio_driver_init(s, driver, dev, NULL)) {
                 break;
             }
             QSIMPLEQ_REMOVE_HEAD(&default_audiodevs, next);
@@ -1821,7 +1819,10 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
                 audio_create_default_audiodevs();
             }
-            card->state = audio_init(NULL);
+            card->state = audio_init(NULL, errp);
+            if (!card->state) {
+                return false;
+            }
         }
     }
 
@@ -2157,17 +2158,13 @@ void audio_define(Audiodev *dev)
     QSIMPLEQ_INSERT_TAIL(&audiodevs, e, next);
 }
 
-bool audio_init_audiodevs(void)
+void audio_init_audiodevs(void)
 {
     AudiodevListEntry *e;
 
     QSIMPLEQ_FOREACH(e, &audiodevs, next) {
-        if (!audio_init(e->dev)) {
-            return false;
-        }
+        audio_init(e->dev, &error_fatal);
     }
-
-    return true;
 }
 
 audsettings audiodev_to_audsettings(AudiodevPerDirectionOptions *pdo)
diff --git a/audio/audio.h b/audio/audio.h
index 70b264d897d..80f3f92124d 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -170,7 +170,7 @@ void audio_sample_from_uint64(void *samples, int pos,
 
 void audio_define(Audiodev *audio);
 void audio_parse_option(const char *opt);
-bool audio_init_audiodevs(void);
+void audio_init_audiodevs(void);
 void audio_help(void);
 
 AudioState *audio_state_by_name(const char *name, Error **errp);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index cafb1a98427..98e071e63bb 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1962,9 +1962,7 @@ static void qemu_create_early_backends(void)
      * setting machine properties, so they can be referred to.
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
-    if (!audio_init_audiodevs()) {
-        exit(1);
-    }
+    audio_init_audiodevs();
 }
 
 
-- 
2.41.0


