Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 874337B6437
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaob-0002zT-Ey; Tue, 03 Oct 2023 04:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoL-0002N5-S5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoJ-0000Jv-CR
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6ECQLPbNpe6+9u+YwbeHCePsExVXlSR1Ai6vZUxTVc=;
 b=Gw9ZMdscsaxsxqc1jfTGCSfB5jIld6wJAVn5W73MmIhFE6VCNIcSZcC2/Ip17yvxWms9pz
 nF2SLmwg6F3lmnCnnSyr80luxsQdzTlqXTTQIAB2xqmtE9XU9EcQkSDAEaYZXrsKk79RLp
 XiTbiK8g2aPgrKHMWhh6sY+KqKSK8vY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-mpvE70A9MXCraVynKKsdyQ-1; Tue, 03 Oct 2023 04:31:16 -0400
X-MC-Unique: mpvE70A9MXCraVynKKsdyQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9a681c3470fso54399566b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321875; x=1696926675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6ECQLPbNpe6+9u+YwbeHCePsExVXlSR1Ai6vZUxTVc=;
 b=sqdFIFPb/PIXbYwnwTVLijZzokPBDAADph4n8rKjVRD6uKG3eGZF1LFrWoW0XUDEFb
 Z5RHMVPBXiXdbEWy/OS1LAzyTm20tuxlV6OHhSuty4GNWvmlOkZ3FRlNNe+SmKaq6IBd
 8ZcldGP/BpYGhxUzbXj3h/F6pgjR7FpqP9ZQqtZah2fumSKBOIvonZKFK5cDFAYyBVIK
 GxhGAgv2Xm/mKjiTFIjQ+Thzd37pMXCq676sMEG6yhLMUx7mS0HaHa9+oa9buWk58t6E
 +yTwuc+fK60OoQq0YRj8vQ/suco+OOS+i9hEt+clxo5LG8KoM/tqMswcDUur/h8rA5e5
 uj0A==
X-Gm-Message-State: AOJu0YzzMsWRnnBHZuANVJbh1PR9jNEi0wf3JhivaOnBBHc20sukXdue
 WHTnzy/tiYtcyM95A+1CCFeMIdjgC8hrFNs7dIfO55h3Q/OCUp7WXSUWs6hPvboPig8lFnc3u5u
 HStEBj8USfYaTBioy6KdOmjuIACB4WMnSR6LDOVVeFwKhjxj8vYKHt/U6jpQiB4vi0UDs1uCIAY
 Q=
X-Received: by 2002:a17:906:cc15:b0:9b7:1e26:e2de with SMTP id
 ml21-20020a170906cc1500b009b71e26e2demr255554ejb.21.1696321874853; 
 Tue, 03 Oct 2023 01:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6tc8Df9dT1RqVaUjjEKk1V35ONoWfp4nJuQjMU37Kz1NZSUa/gVFwBZF5ycQ2xKh4JpkEg==
X-Received: by 2002:a17:906:cc15:b0:9b7:1e26:e2de with SMTP id
 ml21-20020a170906cc1500b009b71e26e2demr255542ejb.21.1696321874521; 
 Tue, 03 Oct 2023 01:31:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 h22-20020a17090619d600b009ad8796a6aesm652007ejd.56.2023.10.03.01.31.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] audio: return Error ** from audio_state_by_name
Date: Tue,  3 Oct 2023 10:30:32 +0200
Message-ID: <20231003083042.110065-16-pbonzini@redhat.com>
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
index fdc34a77520..874a4c3c412 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -2260,7 +2260,7 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
         audioformat_bytes_per_sample(as->fmt);
 }
 
-AudioState *audio_state_by_name(const char *name)
+AudioState *audio_state_by_name(const char *name, Error **errp)
 {
     AudioState *s;
     QTAILQ_FOREACH(s, &audio_states, list) {
@@ -2269,6 +2269,7 @@ AudioState *audio_state_by_name(const char *name)
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


