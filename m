Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 827F4C0EE4B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 16:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOwl-0005gv-GP; Mon, 27 Oct 2025 11:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOvo-0004wu-RO
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOva-00043O-HS
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761578071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEEwWgvOu65dENT6bp88csqVY6xRkGlfxpSMElzIXjk=;
 b=OSXs/8fYbVvbsj6Y0yEmF1+NrEZ+dRSByt7DuGm6sv8w6CFoivplzdB3Lh0LrB4EsNKtlz
 IQ4Yv5fjO9XuAqGdw+Yj+iUaLbBZlQjiuc2ggLvNXqjaKwgLSmEHl1a0TFurHcq7/yUQLD
 cBEkDN1Yp5P/2E2r4qtD4V7XmzPJeoA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-pz2ra32mNMiFOzKSyPKEzA-1; Mon,
 27 Oct 2025 11:14:27 -0400
X-MC-Unique: pz2ra32mNMiFOzKSyPKEzA-1
X-Mimecast-MFC-AGG-ID: pz2ra32mNMiFOzKSyPKEzA_1761578062
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84B4719540E4; Mon, 27 Oct 2025 15:14:22 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99FA4195398C; Mon, 27 Oct 2025 15:14:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 32/35] audio: move capture API to own header
Date: Mon, 27 Oct 2025 19:10:39 +0400
Message-ID: <20251027151045.2863176-33-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

For modularity/clarity reasons, move the capture API in a specific
header.

The current audio/ header license is MIT.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS                  |  2 +-
 audio/audio_int.h            |  1 +
 include/qemu/audio-capture.h | 43 ++++++++++++++++++++++++++++++++++++
 include/qemu/audio.h         | 30 -------------------------
 ui/vnc.h                     |  2 +-
 5 files changed, 46 insertions(+), 32 deletions(-)
 create mode 100644 include/qemu/audio-capture.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a4f650a88f..355302cac4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2975,7 +2975,7 @@ X: audio/paaudio.c
 X: audio/sdlaudio.c
 X: audio/sndioaudio.c
 X: audio/spiceaudio.c
-F: include/qemu/audio.h
+F: include/qemu/audio*.h
 F: qapi/audio.json
 
 ALSA Audio backend
diff --git a/audio/audio_int.h b/audio/audio_int.h
index df13a466e4..5834ebea5e 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -30,6 +30,7 @@
 /* #define RECIPROCAL */
 #endif
 #include "qemu/audio.h"
+#include "qemu/audio-capture.h"
 #include "mixeng.h"
 
 #ifdef CONFIG_GIO
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
new file mode 100644
index 0000000000..a07412db85
--- /dev/null
+++ b/include/qemu/audio-capture.h
@@ -0,0 +1,43 @@
+/*
+ * QEMU Audio subsystem
+ *
+ * SPDX-License-Identifier: MIT
+ */
+#ifndef QEMU_AUDIO_CAPTURE_H
+#define QEMU_AUDIO_CAPTURE_H
+
+#include "audio.h"
+
+typedef struct CaptureVoiceOut CaptureVoiceOut;
+
+typedef enum {
+    AUD_CNOTIFY_ENABLE,
+    AUD_CNOTIFY_DISABLE
+} audcnotification_e;
+
+struct audio_capture_ops {
+    void (*notify) (void *opaque, audcnotification_e cmd);
+    void (*capture) (void *opaque, const void *buf, int size);
+    void (*destroy) (void *opaque);
+};
+
+struct capture_ops {
+    void (*info) (void *opaque);
+    void (*destroy) (void *opaque);
+};
+
+typedef struct CaptureState {
+    void *opaque;
+    struct capture_ops ops;
+    QLIST_ENTRY(CaptureState) entries;
+} CaptureState;
+
+CaptureVoiceOut *AUD_add_capture(
+    AudioBackend *be,
+    struct audsettings *as,
+    struct audio_capture_ops *ops,
+    void *opaque
+    );
+void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
+
+#endif /* QEMU_AUDIO_CAPTURE_H */
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index a857955f51..0ed606c9fb 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -41,30 +41,7 @@ typedef struct audsettings {
     int endianness;
 } audsettings;
 
-typedef enum {
-    AUD_CNOTIFY_ENABLE,
-    AUD_CNOTIFY_DISABLE
-} audcnotification_e;
-
-struct audio_capture_ops {
-    void (*notify) (void *opaque, audcnotification_e cmd);
-    void (*capture) (void *opaque, const void *buf, int size);
-    void (*destroy) (void *opaque);
-};
-
-struct capture_ops {
-    void (*info) (void *opaque);
-    void (*destroy) (void *opaque);
-};
-
-typedef struct CaptureState {
-    void *opaque;
-    struct capture_ops ops;
-    QLIST_ENTRY (CaptureState) entries;
-} CaptureState;
-
 typedef struct SWVoiceOut SWVoiceOut;
-typedef struct CaptureVoiceOut CaptureVoiceOut;
 typedef struct SWVoiceIn SWVoiceIn;
 
 struct AudioBackendClass {
@@ -78,13 +55,6 @@ typedef struct QEMUAudioTimeStamp {
 } QEMUAudioTimeStamp;
 
 bool AUD_backend_check (AudioBackend **be, Error **errp);
-CaptureVoiceOut *AUD_add_capture(
-    AudioBackend *s,
-    struct audsettings *as,
-    struct audio_capture_ops *ops,
-    void *opaque
-    );
-void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
 
 SWVoiceOut *AUD_open_out (
     AudioBackend *be,
diff --git a/ui/vnc.h b/ui/vnc.h
index 4d8363ebf3..ec8d0c91b5 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -31,7 +31,7 @@
 #include "qemu/thread.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
-#include "qemu/audio.h"
+#include "qemu/audio-capture.h"
 #include "qemu/bitmap.h"
 #include "crypto/tlssession.h"
 #include "qemu/buffer.h"
-- 
2.51.0


