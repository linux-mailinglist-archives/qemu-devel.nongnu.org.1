Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC91BF5713
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Kv-0007M9-6y; Tue, 21 Oct 2025 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Ko-0006vG-31
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Kl-0004QO-U2
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JWvZX5W+OFdx47fWl9fhvkk5aix5b5zMWoCfctFRYIo=;
 b=Qr5votoIVjGAm7L5K0al3rdc96aeyVbpcg0677TBdMKmaXfZGYx82AbvdF6BUaPw3Wuo1c
 nhOxCOpM/4htccZ/+pPYAFjg0xIk/qsZrBemmQG7NXkiUvnSZpqWRsJ7Jysh6X3U1SWGg8
 W7j7sIvbBQS39Md3c9f56FnqZ8fExTw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-zNdOZj7GN6mGyPJuBrf6Dw-1; Tue,
 21 Oct 2025 05:07:06 -0400
X-MC-Unique: zNdOZj7GN6mGyPJuBrf6Dw-1
X-Mimecast-MFC-AGG-ID: zNdOZj7GN6mGyPJuBrf6Dw_1761037625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDD0E1954190; Tue, 21 Oct 2025 09:07:04 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00E04180035A; Tue, 21 Oct 2025 09:07:03 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 40/43] audio: cleanup, use bool for booleans
Date: Tue, 21 Oct 2025 13:03:11 +0400
Message-ID: <20251021090317.425409-41-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
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

Use slightly better types for the job.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h      | 12 ++++++------
 audio/audio_template.h |  6 +++---
 include/qemu/audio.h   |  8 ++++----
 audio/audio.c          | 30 +++++++++++++++---------------
 4 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index 4207bd0e12..0116ee6707 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -67,9 +67,9 @@ typedef struct STSampleBuffer {
 
 typedef struct HWVoiceOut {
     AudioBE *s;
-    int enabled;
+    bool enabled;
     int poll_mode;
-    int pending_disable;
+    bool pending_disable;
     struct audio_pcm_info info;
 
     f_sample *clip;
@@ -88,7 +88,7 @@ typedef struct HWVoiceOut {
 
 typedef struct HWVoiceIn {
     AudioBE *s;
-    int enabled;
+    bool enabled;
     int poll_mode;
     struct audio_pcm_info info;
 
@@ -115,8 +115,8 @@ struct SWVoiceOut {
     STSampleBuffer resample_buf;
     void *rate;
     size_t total_hw_samples_mixed;
-    int active;
-    int empty;
+    bool active;
+    bool empty;
     HWVoiceOut *hw;
     char *name;
     struct mixeng_volume vol;
@@ -127,7 +127,7 @@ struct SWVoiceOut {
 struct SWVoiceIn {
     AudioFE *card;
     AudioBE *s;
-    int active;
+    bool active;
     struct audio_pcm_info info;
     void *rate;
     size_t total_hw_samples_acquired;
diff --git a/audio/audio_template.h b/audio/audio_template.h
index e52587e02c..0d6450caed 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -166,10 +166,10 @@ static int glue (audio_pcm_sw_init_, TYPE) (
 
     audio_pcm_init_info (&sw->info, as);
     sw->hw = hw;
-    sw->active = 0;
+    sw->active = false;
 #ifdef DAC
     sw->total_hw_samples_mixed = 0;
-    sw->empty = 1;
+    sw->empty = true;
 #endif
 
     if (sw->info.is_float) {
@@ -566,7 +566,7 @@ SW *glue (AUD_open_, TYPE) (
     return NULL;
 }
 
-int glue (AUD_is_active_, TYPE) (SW *sw)
+bool glue (AUD_is_active_, TYPE) (SW *sw)
 {
     return sw ? sw->active : 0;
 }
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index 1f37cc3164..ab5367d28b 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -105,8 +105,8 @@ SWVoiceOut *AUD_open_out (
 void AUD_close_out (AudioFE *fe, SWVoiceOut *sw);
 size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
 int  AUD_get_buffer_size_out (SWVoiceOut *sw);
-void AUD_set_active_out (SWVoiceOut *sw, int on);
-int  AUD_is_active_out (SWVoiceOut *sw);
+void AUD_set_active_out (SWVoiceOut *sw, bool on);
+bool AUD_is_active_out (SWVoiceOut *sw);
 
 void     AUD_init_time_stamp_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_out (SWVoiceOut *sw, QEMUAudioTimeStamp *ts);
@@ -135,8 +135,8 @@ SWVoiceIn *AUD_open_in (
 
 void AUD_close_in (AudioFE *fe, SWVoiceIn *sw);
 size_t AUD_read (SWVoiceIn *sw, void *pcm_buf, size_t size);
-void AUD_set_active_in (SWVoiceIn *sw, int on);
-int  AUD_is_active_in (SWVoiceIn *sw);
+void AUD_set_active_in (SWVoiceIn *sw, bool on);
+bool AUD_is_active_in (SWVoiceIn *sw);
 
 void     AUD_init_time_stamp_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
 uint64_t AUD_get_elapsed_usec_in (SWVoiceIn *sw, QEMUAudioTimeStamp *ts);
diff --git a/audio/audio.c b/audio/audio.c
index 60d4cfa2d2..e03da8c344 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -405,7 +405,7 @@ static void audio_notify_capture (CaptureVoiceOut *cap, audcnotification_e cmd)
     }
 }
 
-static void audio_capture_maybe_changed (CaptureVoiceOut *cap, int enabled)
+static void audio_capture_maybe_changed (CaptureVoiceOut *cap, bool enabled)
 {
     if (cap->hw.enabled != enabled) {
         audcnotification_e cmd;
@@ -419,11 +419,11 @@ static void audio_recalc_and_notify_capture (CaptureVoiceOut *cap)
 {
     HWVoiceOut *hw = &cap->hw;
     SWVoiceOut *sw;
-    int enabled = 0;
+    bool enabled = false;
 
     for (sw = hw->sw_head.lh_first; sw; sw = sw->entries.le_next) {
         if (sw->active) {
-            enabled = 1;
+            enabled = true;
             break;
         }
     }
@@ -475,7 +475,7 @@ static int audio_attach_capture (HWVoiceOut *hw)
         sw = &sc->sw;
         sw->hw = hw_cap;
         sw->info = hw->info;
-        sw->empty = 1;
+        sw->empty = true;
         sw->active = hw->enabled;
         sw->vol = nominal_volume;
         sw->rate = st_rate_start (sw->info.freq, hw_cap->info.freq);
@@ -911,7 +911,7 @@ int AUD_get_buffer_size_out(SWVoiceOut *sw)
     return sw->hw->samples * sw->hw->info.bytes_per_frame;
 }
 
-void AUD_set_active_out (SWVoiceOut *sw, int on)
+void AUD_set_active_out (SWVoiceOut *sw, bool on)
 {
     HWVoiceOut *hw;
 
@@ -928,7 +928,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
         if (on) {
             hw->pending_disable = 0;
             if (!hw->enabled) {
-                hw->enabled = 1;
+                hw->enabled = true;
                 if (s->vm_running) {
                     if (hw->pcm_ops->enable_out) {
                         hw->pcm_ops->enable_out(hw, true);
@@ -959,7 +959,7 @@ void AUD_set_active_out (SWVoiceOut *sw, int on)
     }
 }
 
-void AUD_set_active_in (SWVoiceIn *sw, int on)
+void AUD_set_active_in (SWVoiceIn *sw, bool on)
 {
     HWVoiceIn *hw;
 
@@ -974,7 +974,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
 
         if (on) {
             if (!hw->enabled) {
-                hw->enabled = 1;
+                hw->enabled = true;
                 if (s->vm_running) {
                     if (hw->pcm_ops->enable_in) {
                         hw->pcm_ops->enable_in(hw, true);
@@ -993,7 +993,7 @@ void AUD_set_active_in (SWVoiceIn *sw, int on)
                 }
 
                 if (nb_active == 1) {
-                    hw->enabled = 0;
+                    hw->enabled = false;
                     if (hw->pcm_ops->enable_in) {
                         hw->pcm_ops->enable_in(hw, false);
                     }
@@ -1152,8 +1152,8 @@ static void audio_run_out (AudioBE *s)
             sw = hw->sw_head.lh_first;
 
             if (hw->pending_disable) {
-                hw->enabled = 0;
-                hw->pending_disable = 0;
+                hw->enabled = false;
+                hw->pending_disable = false;
                 if (hw->pcm_ops->enable_out) {
                     hw->pcm_ops->enable_out(hw, false);
                 }
@@ -1206,13 +1206,13 @@ static void audio_run_out (AudioBE *s)
 #ifdef DEBUG_OUT
             dolog ("Disabling voice\n");
 #endif
-            hw->enabled = 0;
-            hw->pending_disable = 0;
+            hw->enabled = false;
+            hw->pending_disable = false;
             if (hw->pcm_ops->enable_out) {
                 hw->pcm_ops->enable_out(hw, false);
             }
             for (sc = hw->cap_head.lh_first; sc; sc = sc->entries.le_next) {
-                sc->sw.active = 0;
+                sc->sw.active = false;
                 audio_recalc_and_notify_capture (sc->cap);
             }
             continue;
@@ -1257,7 +1257,7 @@ static void audio_run_out (AudioBE *s)
             sw->total_hw_samples_mixed -= played;
 
             if (!sw->total_hw_samples_mixed) {
-                sw->empty = 1;
+                sw->empty = true;
             }
         }
     }
-- 
2.51.0


