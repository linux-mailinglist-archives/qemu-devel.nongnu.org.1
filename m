Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36001BF569D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:06:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Im-0002Am-ON; Tue, 21 Oct 2025 05:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Id-00022W-FB
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ib-0003zC-C8
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONL0APN3lxSe1Dm84qOKL5byWQonsh+vmwtQz2dCb00=;
 b=W/faQ7di5mfvPVakKdnFw0Z8/zy1ytNVkSUvR5aiTZTYS+MLW2Vnu70dvE4dA/hWcGkCMZ
 JS5f7mblYEr8/kBFW2oLITdi/2byO0a46tF9Soe63sPCV29kBOw1iNgUqY7ElzKK+B11+Y
 9G5h3/aayx/uGHaRXf+vz5+3JG/qv78=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-irEOgllXOiWjYIT4QJkDkA-1; Tue,
 21 Oct 2025 05:04:53 -0400
X-MC-Unique: irEOgllXOiWjYIT4QJkDkA-1
X-Mimecast-MFC-AGG-ID: irEOgllXOiWjYIT4QJkDkA_1761037492
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03646195422B; Tue, 21 Oct 2025 09:04:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B48819560A2; Tue, 21 Oct 2025 09:04:50 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 16/43] audio: start making AudioState a QOM Object
Date: Tue, 21 Oct 2025 13:02:47 +0400
Message-ID: <20251021090317.425409-17-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

QOM brings some conveniences for introspection, type checking, reference
counting, interfaces etc. This is only the first step to introduce QOM
in audio/ (I have more in the pipeline)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio.h     |  8 ++++++++
 audio/audio_int.h |  2 ++
 audio/audio.c     | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/audio/audio.h b/audio/audio.h
index eb5b5d662d..f56a8c8baf 100644
--- a/audio/audio.h
+++ b/audio/audio.h
@@ -80,6 +80,11 @@ typedef struct SWVoiceOut SWVoiceOut;
 typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
+typedef struct AudioStateClass AudioStateClass;
+struct AudioStateClass {
+    ObjectClass parent_class;
+};
+
 typedef struct AudioState AudioState;
 typedef struct QEMUSoundCard {
     char *name;
@@ -182,4 +187,7 @@ const char *audio_get_id(QEMUSoundCard *card);
 #define DEFINE_AUDIO_PROPERTIES(_s, _f)         \
     DEFINE_PROP_AUDIODEV("audiodev", _s, _f)
 
+#define TYPE_AUDIO_STATE "audio-state"
+OBJECT_DECLARE_TYPE(AudioState, AudioStateClass, AUDIO_STATE)
+
 #endif /* QEMU_AUDIO_H */
diff --git a/audio/audio_int.h b/audio/audio_int.h
index f78ca05f92..b2b4d2d10e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -217,6 +217,8 @@ struct SWVoiceCap {
 };
 
 typedef struct AudioState {
+    Object parent;
+
     struct audio_driver *drv;
     Audiodev *dev;
     void *drv_opaque;
diff --git a/audio/audio.c b/audio/audio.c
index 6197fa1788..754952ce58 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1617,8 +1617,19 @@ static void audio_vm_change_state_handler (void *opaque, bool running,
     audio_reset_timer (s);
 }
 
-static void free_audio_state(AudioState *s)
+static void audio_state_init(Object *obj)
 {
+    AudioState *s = AUDIO_STATE(obj);
+
+    QLIST_INIT (&s->hw_head_out);
+    QLIST_INIT (&s->hw_head_in);
+    QLIST_INIT (&s->cap_head);
+    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
+}
+
+static void audio_state_finalize(Object *obj)
+{
+    AudioState *s = AUDIO_STATE(obj);
     HWVoiceOut *hwo, *hwon;
     HWVoiceIn *hwi, *hwin;
 
@@ -1663,8 +1674,6 @@ static void free_audio_state(AudioState *s)
         timer_free(s->ts);
         s->ts = NULL;
     }
-
-    g_free(s);
 }
 
 void audio_cleanup(void)
@@ -1673,7 +1682,7 @@ void audio_cleanup(void)
     while (!QTAILQ_EMPTY(&audio_states)) {
         AudioState *s = QTAILQ_FIRST(&audio_states);
         QTAILQ_REMOVE(&audio_states, s, list);
-        free_audio_state(s);
+        object_unref(s);
     }
 }
 
@@ -1732,18 +1741,13 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     AudioState *s;
     struct audio_driver *driver;
 
-    s = g_new0(AudioState, 1);
+    s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
 
-    QLIST_INIT (&s->hw_head_out);
-    QLIST_INIT (&s->hw_head_in);
-    QLIST_INIT (&s->cap_head);
     if (!atexit_registered) {
         atexit(audio_cleanup);
         atexit_registered = true;
     }
 
-    s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
-
     if (dev) {
         /* -audiodev option */
         s->dev = dev;
@@ -1796,7 +1800,7 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     return s;
 
 out:
-    free_audio_state(s);
+    object_unref(s);
     return NULL;
 }
 
@@ -2320,3 +2324,20 @@ AudiodevList *qmp_query_audiodevs(Error **errp)
     }
     return ret;
 }
+
+static const TypeInfo audio_state_info = {
+    .name = TYPE_AUDIO_STATE,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(AudioState),
+    .instance_init = audio_state_init,
+    .instance_finalize = audio_state_finalize,
+    .abstract = false, // todo, subclass and make it abstract
+    .class_size = sizeof(AudioStateClass),
+};
+
+static void register_types(void)
+{
+    type_register_static(&audio_state_info);
+}
+
+type_init(register_types);
-- 
2.51.0


