Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB87B2E71
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9EJ-0006Gk-Ce; Fri, 29 Sep 2023 04:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9E9-0005fR-Bi
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9Db-0005kd-Cm
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lfSsdCVQj7Q5V/xwxYYL14JcsNV1/hYptBm9881blPI=;
 b=HEGfDvQUxjjYWNKRiNiBF4spcd75+f7o6c/+1P8WTyzQ9xPKlLO0E51cSKyKwuJxy6sFC9
 f7HIg2AjgL/ujzZ/Zm7kR01Js5abph7WEq5Ix7QmNDPnmXmmEG7gjJOPnrDd222vkJiEXV
 jL3SlG3013NCPQe8pJr7ovFWVB5ep5c=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-aGZQmDgWMAKEUdIiEV_ccA-1; Fri, 29 Sep 2023 04:51:25 -0400
X-MC-Unique: aGZQmDgWMAKEUdIiEV_ccA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso1177835466b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977483; x=1696582283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lfSsdCVQj7Q5V/xwxYYL14JcsNV1/hYptBm9881blPI=;
 b=ulqiNRc9ESJBN3PdESAOpFJ0ls7PLUGeXHxhCUmTBMEk4Zuld5LhffQ+S22+3YlLcv
 wF6fTKqND0EwlPoXNspArRp6r8ckW2D8ioRqhSlYkQ667kRw7mRbNEVRvcH8n9Wm2lXA
 BEJLkXnSFjo9XU2yu+g7nt5oxDQ51onQY66KckMSxuFimLHrThMfPN8AnDgpVZwXUNvX
 87e2dkhd5mjUQThOOWEXMAjF7S705FEna2FvBQVwrxejVLHG8P3UNPaaCTBHYlwu3IQQ
 NzUYFznD8eB8pziKoeh0ZhQpOPZ+vOEdbKenXO7Cc3mqRX1zxEWPoo5HAnAXnGdlC9yZ
 hNVw==
X-Gm-Message-State: AOJu0Yw+9p0LzARD9z+UHY5rflQwe2GQI/dfPkYm8NI2gNL3gVJUBG+4
 78d5Ffcre7hFu+eazz5McsSwqb+z2SB6oSI83bkp3GV051R137s1yS9oBTmrf4AFplEHzmllmsE
 G0lUSvRpGLtPDhtq6gnkQyvar6vlsUM1WTkZLNXdxPPxvmxeAuabTgMwKj/lAbYjWkPbFvP0vpe
 o=
X-Received: by 2002:a17:906:3041:b0:9a5:b1cd:bdf2 with SMTP id
 d1-20020a170906304100b009a5b1cdbdf2mr3282705ejd.51.1695977483315; 
 Fri, 29 Sep 2023 01:51:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEpTbxOzebwEoYDdPK9xFJYm8LLViEOv0X8t4nj8QPg6/qSO5ov0uZNfbRuY0TlBEelkcPRg==
X-Received: by 2002:a17:906:3041:b0:9a5:b1cd:bdf2 with SMTP id
 d1-20020a170906304100b009a5b1cdbdf2mr3282687ejd.51.1695977482836; 
 Fri, 29 Sep 2023 01:51:22 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 hs35-20020a1709073ea300b009b28ad521f4sm6692848ejc.4.2023.09.29.01.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 04/14] audio: return Error ** from audio_state_by_name
Date: Fri, 29 Sep 2023 10:50:57 +0200
Message-ID: <20230929085112.983957-5-pbonzini@redhat.com>
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

Remove duplicate error formatting code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio-hmp-cmds.c           |  6 ++++--
 audio/audio.c                    |  3 ++-
 audio/audio.h                    |  2 +-
 hw/core/qdev-properties-system.c | 16 ++++------------
 ui/dbus.c                        |  3 +--
 ui/vnc.c                         |  3 +--
 6 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index 1237ce9e750..c9608b715b8 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -26,6 +26,7 @@
 #include "audio/audio.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
+#include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
@@ -65,10 +66,11 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     int nchannels = qdict_get_try_int(qdict, "nchannels", 2);
     const char *audiodev = qdict_get_str(qdict, "audiodev");
     CaptureState *s;
-    AudioState *as = audio_state_by_name(audiodev);
+    Error *local_err = NULL;
+    AudioState *as = audio_state_by_name(audiodev, &local_err);
 
     if (!as) {
-        monitor_printf(mon, "Audiodev '%s' not found\n", audiodev);
+        error_report_err(local_err);
         return;
     }
 
diff --git a/audio/audio.c b/audio/audio.c
index 3d664503521..d4263976a5b 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2261,7 +2261,7 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
         audioformat_bytes_per_sample(as->fmt);
 }
 
-AudioState *audio_state_by_name(const char *name)
+AudioState *audio_state_by_name(const char *name, Error **errp)
 {
     AudioState *s;
     QTAILQ_FOREACH(s, &audio_states, list) {
@@ -2270,6 +2270,7 @@ AudioState *audio_state_by_name(const char *name)
             return s;
         }
     }
+    error_setg(errp, "audiodev '%s' not found", name);
     return NULL;
 }
 
diff --git a/audio/audio.h b/audio/audio.h
index 01bdc567fb1..e0c13b5dcdf 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -174,7 +174,7 @@ bool audio_init_audiodevs(void);
 void audio_help(void);
 void audio_legacy_help(void);
 
-AudioState *audio_state_by_name(const char *name);
+AudioState *audio_state_by_name(const char *name, Error **errp);
 const char *audio_get_id(QEMUSoundCard *card);
 
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 41b7e682c78..688340610ec 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -480,24 +480,16 @@ static void set_audiodev(Object *obj, Visitor *v, const char* name,
     Property *prop = opaque;
     QEMUSoundCard *card = object_field_prop_ptr(obj, prop);
     AudioState *state;
-    int err = 0;
-    char *str;
+    g_autofree char *str = NULL;
 
     if (!visit_type_str(v, name, &str, errp)) {
         return;
     }
 
-    state = audio_state_by_name(str);
-
-    if (!state) {
-        err = -ENOENT;
-        goto out;
+    state = audio_state_by_name(str, errp);
+    if (state) {
+        card->state = state;
     }
-    card->state = state;
-
-out:
-    error_set_from_qdev_prop_error(errp, err, obj, name, str);
-    g_free(str);
 }
 
 const PropertyInfo qdev_prop_audiodev = {
diff --git a/ui/dbus.c b/ui/dbus.c
index 32f1bbe81ae..866467ad2e3 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -220,9 +220,8 @@ dbus_display_complete(UserCreatable *uc, Error **errp)
     }
 
     if (dd->audiodev && *dd->audiodev) {
-        AudioState *audio_state = audio_state_by_name(dd->audiodev);
+        AudioState *audio_state = audio_state_by_name(dd->audiodev, errp);
         if (!audio_state) {
-            error_setg(errp, "Audiodev '%s' not found", dd->audiodev);
             return;
         }
         if (!g_str_equal(audio_state->drv->name, "dbus")) {
diff --git a/ui/vnc.c b/ui/vnc.c
index acb56461b2d..82929469130 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4181,9 +4181,8 @@ void vnc_display_open(const char *id, Error **errp)
 
     audiodev = qemu_opt_get(opts, "audiodev");
     if (audiodev) {
-        vd->audio_state = audio_state_by_name(audiodev);
+        vd->audio_state = audio_state_by_name(audiodev, errp);
         if (!vd->audio_state) {
-            error_setg(errp, "Audiodev '%s' not found", audiodev);
             goto fail;
         }
     }
-- 
2.41.0


