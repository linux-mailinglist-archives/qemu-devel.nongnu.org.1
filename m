Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B87B9D27
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoNx8-0000bI-22; Thu, 05 Oct 2023 08:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwL-0008KE-Rs
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoNwD-0007mB-4U
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 08:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696510722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Phtq7TMtImPSu63xmUOC4PIyIrn1PhJ4EhvtwiBYBUE=;
 b=BOFwMU0Dwv40jtkdOikbmxsLK6VMj2jPB2LXr3E8cxkQ2tRei8HQXpZ/Cn2p2XUV5+xV71
 CS9en76zYeKENf9AA0Sd/WaQAleJ7QO3jUnM7ptIriN9W6CKqLrt1j/bBCg5AYbQR4KWWh
 mpBwgtwTLEp294pHxkKG5g0IWu2UdpU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-EIjxIdDUPPO9ygbRXkInZA-1; Thu, 05 Oct 2023 08:58:30 -0400
X-MC-Unique: EIjxIdDUPPO9ygbRXkInZA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5378cd83621so795995a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 05:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696510708; x=1697115508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Phtq7TMtImPSu63xmUOC4PIyIrn1PhJ4EhvtwiBYBUE=;
 b=TIXrjI2yTE1vSGuc95ekHRQ5R+z9FHQ/4vro8XYgI8UxGDk+QmQISbkOoXV/U8mzjA
 yt7fnOumlmeysORIV+ZvuywydJePfNFzNGCc2+TCz0f2ZyD5cydCOGsVm+R0lyJ0TJB9
 fgGZsIIKlRbZ9IZSi77innH/ruk1L4GYvl6h7Ad5I5OYgq/qAjQm/LEkVAzJ8qNAuR+t
 KBguiI4XjImbpE1Ezpa++moszi92lnzQj0ZXdR5cxisHtmyU/8ZX5MhB48NufFSv+I/x
 92aK/bTOvlGRZYHKfFOGUeoydFUcL+NEJ1aVI44tABosZ5Up/kInVXMjyojy5DRVNI2t
 3RTQ==
X-Gm-Message-State: AOJu0YyqpIubPnVcGAMU2Luvwhp5qz9pozIFcQQBWM/0RLGe0caQ5d7N
 oOmupvaNE1UD5XE15PnrOG2ouyVMgLAnkSJaUwTxi6GU/G8Qrs2jZqmlhi9B3WE8k1kGBEKhbgg
 O+uk/mqUcnVsYmrXgei/0G7U5X/6fI3oAS/dqG3Ad9zXDWcS7Cyind7t/KGZElvOzrCnCOu902f
 s=
X-Received: by 2002:a17:906:15d:b0:9ae:546b:786b with SMTP id
 29-20020a170906015d00b009ae546b786bmr4070962ejh.33.1696510708357; 
 Thu, 05 Oct 2023 05:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb3S7klpNg2bO+w+Rul8LmnpgkPyeyIIkrAvU4fLAdNyARqSYNPRXUvbX67VsvJJv6Z8mkJA==
X-Received: by 2002:a17:906:15d:b0:9ae:546b:786b with SMTP id
 29-20020a170906015d00b009ae546b786bmr4070950ejh.33.1696510708048; 
 Thu, 05 Oct 2023 05:58:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a1709060dda00b0098921e1b064sm1151061eji.181.2023.10.05.05.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:58:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu,
	berrange@redhat.com
Subject: [PATCH 6/7] audio: reintroduce default audio backend for VNC
Date: Thu,  5 Oct 2023 14:58:14 +0200
Message-ID: <20231005125815.66082-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
References: <20231005125815.66082-1-pbonzini@redhat.com>
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

Make VNC use the default backend again if one is defined.
The recently introduced support for disabling the VNC audio
extension is still used, in case no default backend exists.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c                   | 28 ++++++++++++++++++----------
 audio/audio.h                   |  1 +
 docs/about/removed-features.rst | 10 ++--------
 ui/vnc.c                        |  2 ++
 4 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index de37ad7c074..ca0df29555a 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1801,20 +1801,28 @@ out:
     return NULL;
 }
 
+AudioState *audio_get_default_audio_state(Error **errp)
+{
+    if (!default_audio_state) {
+        default_audio_state = audio_init(NULL, errp);
+        if (!default_audio_state) {
+            if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+                error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?\n",
+                                  QSIMPLEQ_FIRST(&audiodevs)->dev->id);
+            }
+        }
+    }
+
+    return default_audio_state;
+}
+
 bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
-        if (!default_audio_state) {
-            default_audio_state = audio_init(NULL, errp);
-            if (!default_audio_state) {
-                if (!QSIMPLEQ_EMPTY(&audiodevs)) {
-                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?\n",
-                                      QSIMPLEQ_FIRST(&audiodevs)->dev->id);
-                }
-                return false;
-            }
+        card->state = audio_get_default_audio_state(errp);
+        if (!card->state) {
+            return false;
         }
-        card->state = default_audio_state;
     }
 
     card->name = g_strdup (name);
diff --git a/audio/audio.h b/audio/audio.h
index 6da5e8f6f0f..fcc22307bee 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -176,6 +176,7 @@ void audio_init_audiodevs(void);
 void audio_help(void);
 
 AudioState *audio_state_by_name(const char *name, Error **errp);
+AudioState *audio_get_default_audio_state(Error **errp);
 const char *audio_get_id(QEMUSoundCard *card);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 27639370f96..a5e5a1ba1a5 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -449,17 +449,11 @@ QEMU does not create default audio backends anymore if any of the
 ``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
 command line.
 
-If an audio backend is created with ``-audiodev``, each sound card
-that wants to use it should specify an ``audiodev=``
+If an audio backend is created with ``-audiodev``, each audio client
+(a sound card or VNC) that wants to use it should specify an ``audiodev=``
 property.  Previously, the first audiodev command line option would be
 used as a fallback.
 
-Creating vnc without ``audiodev=`` property (removed in 8.2)
-''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-When using vnc, you should specify an ``audiodev=`` property if
-you plan to transmit audio through the VNC protocol.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/ui/vnc.c b/ui/vnc.c
index acbb88c4ca0..7f4c471503a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4185,6 +4185,8 @@ void vnc_display_open(const char *id, Error **errp)
         if (!vd->audio_state) {
             goto fail;
         }
+    } else {
+        vd->audio_state = audio_get_default_audio_state(NULL);
     }
 
     device_id = qemu_opt_get(opts, "display");
-- 
2.41.0


