Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1EE7BB620
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoioF-0000ZH-SP; Fri, 06 Oct 2023 07:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinU-0000AN-2D
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinP-0000RY-Ni
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wuy5B84uv5TljCLYEICtx4w/cjiaLI/Y3wriDjVZTyc=;
 b=hRmp458GeMDlpvKDXgOGz73r92l/UJ6hBlZLRt7caESlDHe8I189cks8bJ/ln1ozFRFRxv
 kiL4HgIOO0s/m3abt7PYy94eJEJkBs2wIK8MV6eZX+tbufPG9zRctRNUj7Z/f6shs1RHQH
 mL0X2bkr1AybpisQmtIeFMwq4CFhbbY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-G6SA5oqcOqWeK_ddxF9vjA-1; Fri, 06 Oct 2023 07:15:01 -0400
X-MC-Unique: G6SA5oqcOqWeK_ddxF9vjA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b65d7079faso154494666b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590900; x=1697195700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wuy5B84uv5TljCLYEICtx4w/cjiaLI/Y3wriDjVZTyc=;
 b=J74a6GYHNalXBsdkvCkJ/o5be3qlRtctmdSDHuK/aV7pA/uavwcwABU0vLzyka616j
 efjYMXVi68hMFpk1VyKraUbcVQqPuC1Li/Nfx0Xre+xsMem6hD87VZtiQGqzqzdGjEgW
 akoP1ZtzxBxTk7cucH4x2lubn/dfMnHavXMznZRlokJG9xAcU6UsHiQ6MtGOSVhq2YBV
 z6dWB4XoF+NJ6GT5IidFAqcvv9eXTutYugyEdWN9qcDAqtZg22r0pSCPTlKcCuzArQDb
 Ra7X7he6OwPA9+dCpjxWi7Pf9vRCHbtlSWTJyx2gH2T8xBoaNPLDTfzZSaocUzPaDaG2
 Zd6g==
X-Gm-Message-State: AOJu0YyMEM+RUat+xHgzWCPyFz91B4BeZukKw1wu7sAv5BF2yckQP4pV
 Gr70iwfpmmS0zSLdmdi2wEVwUDH5rPCKZFXF5JF1d/zTc6B7rHvnpWnqiv/37WlhBgrHRP8z0CU
 0UMp5e2sygibxrwxlKbmWBCahcm7ev+7xo09K2d1xmdYpp58quISQ1dPH6kHrScgh7ym24ftZpq
 E=
X-Received: by 2002:a17:906:31cc:b0:9b2:b2f8:85dc with SMTP id
 f12-20020a17090631cc00b009b2b2f885dcmr6615832ejf.34.1696590899899; 
 Fri, 06 Oct 2023 04:14:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvEckLnEDx1PBv/nj/kV7rHr2MdZEGRd6szcn4O65UxY8CIlHqCt1npwRhds9xIgYTnPM9mw==
X-Received: by 2002:a17:906:31cc:b0:9b2:b2f8:85dc with SMTP id
 f12-20020a17090631cc00b009b2b2f885dcmr6615815ejf.34.1696590899509; 
 Fri, 06 Oct 2023 04:14:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 ci24-20020a170906c35800b00992ea405a79sm2702776ejb.166.2023.10.06.04.14.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/26] audio: reintroduce default audio backend for VNC
Date: Fri,  6 Oct 2023 13:14:11 +0200
Message-ID: <20231006111412.13130-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
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
 docs/about/removed-features.rst |  6 ------
 ui/vnc.c                        |  2 ++
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index bd4bcabccaf..73b65dc3b9b 100644
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
+                error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
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
-                    error_append_hint(errp, "Perhaps you wanted to use -audio or set audiodev=%s?\n",
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
index ed94b4cd0c8..f04036987b1 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -460,12 +460,6 @@ in this case.
 Note that the default audio backend must be configured on the command
 line if the ``-nodefaults`` options is used.
 
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


