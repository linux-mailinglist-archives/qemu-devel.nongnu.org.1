Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864F7ABEFE
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQ9-0002nW-II; Sat, 23 Sep 2023 04:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ8-0002mg-0B
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ6-0000Wb-C2
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CzfMT4s+Dn3jAVDKcdnixW6BOF9MbE6OBWN8bbT52vU=;
 b=RSgyOwgYx5lt023U4PEUmgBmc9TgRybYrTJiD8n8B/nUJ264yEo/VA1mC6nnoQZ/FwLIZH
 SFcXfNpG24W82Bsb9PRZdpkqE0sRlx6rQHN/gkkp0hI5VVS3rehiKWZAeG6lHpNRGrtDPQ
 4a7rUs1oU+JGCVmKyR6RwfnLxiS0Gc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-WjCMJ4BOOCuqpGC6-5V0NA-1; Sat, 23 Sep 2023 04:55:19 -0400
X-MC-Unique: WjCMJ4BOOCuqpGC6-5V0NA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32009388bb6so2283334f8f.1
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459318; x=1696064118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzfMT4s+Dn3jAVDKcdnixW6BOF9MbE6OBWN8bbT52vU=;
 b=P9j/YNLS+/JeyINZb2bLNx+tTIrL+V6sJWI6I+rb3hb5WrSSyATCGmSfxHK6RuUTh0
 RSfmoDhbrOhqhfx9Hp5SsJU3DU4Qmc9QMhrAdnLViWlDy/OpmT8ORJTcxuniIIrEcLgG
 6hMrG/zqVVaD7okR6pVkaKR58yZmJhtJMMq9qVLz1yqZcK5zOaAgyHszpsqhHl2rQdnq
 w4afMFd6i5yVhh7SnzkxubK9NZF4s0Unc9qof656nho/EFZJSBMAx1TmHyMLrzHj2qVh
 eOzIUJDCK6Oo4XbiEhL7ePISRLckAsPxQfaxGwRe8ukUDrvY+x/1bSUrp4irJUXJoxzn
 ZIXQ==
X-Gm-Message-State: AOJu0YxKXU4dUum01YP+jVWVV7Vg9b1bwUfFQtbSIaz6hwby4UEauxMT
 L8zJbFMNyjrlzSxZ9jO0W3kMaNfKyJUmq51y4USEvR/ywN6rcvv8h7xUuPm3WxYowyNz/+OmPqR
 OaAP5WWFiLZvzklbTAxzvofcxqsUC5ciMgJ1RA7hsMVoo40mYnDjKaF4/bjEBfvMOP8IqN4s23Y
 k=
X-Received: by 2002:adf:dec7:0:b0:31c:804b:5ec3 with SMTP id
 i7-20020adfdec7000000b0031c804b5ec3mr1498305wrn.67.1695459317908; 
 Sat, 23 Sep 2023 01:55:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf4LIAWY4DJoGXE4kmptqRIQoJD+wbCHToo10HhRHk5OQ8tRknkLH9Km+B2wJb2i2M4X9Wow==
X-Received: by 2002:adf:dec7:0:b0:31c:804b:5ec3 with SMTP id
 i7-20020adfdec7000000b0031c804b5ec3mr1498294wrn.67.1695459317606; 
 Sat, 23 Sep 2023 01:55:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020a5d4f0a000000b0031f3ad17b2csm6440716wru.52.2023.09.23.01.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 04/13] audio: return Error ** from audio_state_by_name
Date: Sat, 23 Sep 2023 10:54:57 +0200
Message-ID: <20230923085507.399260-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230923085507.399260-1-pbonzini@redhat.com>
References: <20230923085507.399260-1-pbonzini@redhat.com>
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
index a8e6634dcb7..d0444babeb4 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2262,7 +2262,7 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
         audioformat_bytes_per_sample(as->fmt);
 }
 
-AudioState *audio_state_by_name(const char *name)
+AudioState *audio_state_by_name(const char *name, Error **errp)
 {
     AudioState *s;
     QTAILQ_FOREACH(s, &audio_states, list) {
@@ -2271,6 +2271,7 @@ AudioState *audio_state_by_name(const char *name)
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
index 6d5d43eda22..451755b41db 100644
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
index cfa18bbd3e1..f745a15ddd9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4178,9 +4178,8 @@ void vnc_display_open(const char *id, Error **errp)
 
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


