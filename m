Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7213875633C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNdx-00080g-Nd; Mon, 17 Jul 2023 08:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcy-0007TY-81
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcw-0008Mp-CE
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689598017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1cllmiSG86Yx960rNzc5saZMsutjJXM/EbUt0OszhmI=;
 b=gGoPZkDZDIJRg1IlkNHn15IPFyCbmQROit35FBgmdRrECB8PXOB8LcITWBObGUy0zkT5bn
 4x93Tspyd+2l4EA5rMlWpXOmeIUxd/mdIUPNn8/+uPkhFf1jIbhlz/EA0oy2Za7KGJZz/y
 WSuWZPuJ8GBrW3Qnj/yaeWx/GoD5VUU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-pv_YPxr-OayajYswIngqRQ-1; Mon, 17 Jul 2023 08:46:54 -0400
X-MC-Unique: pv_YPxr-OayajYswIngqRQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F303D101A528;
 Mon, 17 Jul 2023 12:46:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E43D40C2063;
 Mon, 17 Jul 2023 12:46:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PULL 15/19] audio/pw: factorize some common code
Date: Mon, 17 Jul 2023 16:45:40 +0400
Message-ID: <20230717124545.177236-16-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20230506163735.3481387-9-marcandre.lureau@redhat.com>
---
 audio/pwaudio.c | 85 ++++++++++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index d0bc4680a6..70f0c46240 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -66,6 +66,9 @@ typedef struct PWVoiceIn {
     PWVoice v;
 } PWVoiceIn;
 
+#define PW_VOICE_IN(v) ((PWVoiceIn *)v)
+#define PW_VOICE_OUT(v) ((PWVoiceOut *)v)
+
 static void
 stream_destroy(void *data)
 {
@@ -630,62 +633,55 @@ qpw_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 }
 
 static void
-qpw_fini_out(HWVoiceOut *hw)
+qpw_voice_fini(PWVoice *v)
 {
-    PWVoiceOut *pw = (PWVoiceOut *) hw;
-    PWVoice *v = &pw->v;
+    pwaudio *c = v->g;
 
-    if (v->stream) {
-        pwaudio *c = v->g;
-        pw_thread_loop_lock(c->thread_loop);
-        pw_stream_destroy(v->stream);
-        v->stream = NULL;
-        pw_thread_loop_unlock(c->thread_loop);
+    if (!v->stream) {
+        return;
     }
+    pw_thread_loop_lock(c->thread_loop);
+    pw_stream_destroy(v->stream);
+    v->stream = NULL;
+    pw_thread_loop_unlock(c->thread_loop);
 }
 
 static void
-qpw_fini_in(HWVoiceIn *hw)
+qpw_fini_out(HWVoiceOut *hw)
 {
-    PWVoiceIn *pw = (PWVoiceIn *) hw;
-    PWVoice *v = &pw->v;
+    qpw_voice_fini(&PW_VOICE_OUT(hw)->v);
+}
 
-    if (v->stream) {
-        pwaudio *c = v->g;
-        pw_thread_loop_lock(c->thread_loop);
-        pw_stream_destroy(v->stream);
-        v->stream = NULL;
-        pw_thread_loop_unlock(c->thread_loop);
-    }
+static void
+qpw_fini_in(HWVoiceIn *hw)
+{
+    qpw_voice_fini(&PW_VOICE_IN(hw)->v);
 }
 
 static void
-qpw_enable_out(HWVoiceOut *hw, bool enable)
+qpw_voice_set_enabled(PWVoice *v, bool enable)
 {
-    PWVoiceOut *po = (PWVoiceOut *) hw;
-    PWVoice *v = &po->v;
     pwaudio *c = v->g;
     pw_thread_loop_lock(c->thread_loop);
     pw_stream_set_active(v->stream, enable);
     pw_thread_loop_unlock(c->thread_loop);
 }
 
+static void
+qpw_enable_out(HWVoiceOut *hw, bool enable)
+{
+    qpw_voice_set_enabled(&PW_VOICE_OUT(hw)->v, enable);
+}
+
 static void
 qpw_enable_in(HWVoiceIn *hw, bool enable)
 {
-    PWVoiceIn *pi = (PWVoiceIn *) hw;
-    PWVoice *v = &pi->v;
-    pwaudio *c = v->g;
-    pw_thread_loop_lock(c->thread_loop);
-    pw_stream_set_active(v->stream, enable);
-    pw_thread_loop_unlock(c->thread_loop);
+    qpw_voice_set_enabled(&PW_VOICE_IN(hw)->v, enable);
 }
 
 static void
-qpw_volume_out(HWVoiceOut *hw, Volume *vol)
+qpw_voice_set_volume(PWVoice *v, Volume *vol)
 {
-    PWVoiceOut *pw = (PWVoiceOut *) hw;
-    PWVoice *v = &pw->v;
     pwaudio *c = v->g;
     int i, ret;
 
@@ -707,28 +703,15 @@ qpw_volume_out(HWVoiceOut *hw, Volume *vol)
 }
 
 static void
-qpw_volume_in(HWVoiceIn *hw, Volume *vol)
+qpw_volume_out(HWVoiceOut *hw, Volume *vol)
 {
-    PWVoiceIn *pw = (PWVoiceIn *) hw;
-    PWVoice *v = &pw->v;
-    pwaudio *c = v->g;
-    int i, ret;
-
-    pw_thread_loop_lock(c->thread_loop);
-    v->volume.channels = vol->channels;
-
-    for (i = 0; i < vol->channels; ++i) {
-        v->volume.values[i] = (float)vol->vol[i] / 255;
-    }
-
-    ret = pw_stream_set_control(v->stream,
-        SPA_PROP_channelVolumes, v->volume.channels, v->volume.values, 0);
-    trace_pw_vol(ret == 0 ? "success" : "failed");
+    qpw_voice_set_volume(&PW_VOICE_OUT(hw)->v, vol);
+}
 
-    v->muted = vol->mute;
-    float val = v->muted ? 1.f : 0.f;
-    ret = pw_stream_set_control(v->stream, SPA_PROP_mute, 1, &val, 0);
-    pw_thread_loop_unlock(c->thread_loop);
+static void
+qpw_volume_in(HWVoiceIn *hw, Volume *vol)
+{
+    qpw_voice_set_volume(&PW_VOICE_IN(hw)->v, vol);
 }
 
 static int wait_resync(pwaudio *pw)
-- 
2.41.0


