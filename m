Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0308DBFB800
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Oct 2025 12:59:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBWXk-0000gR-24; Wed, 22 Oct 2025 06:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBWXh-0000g5-7j
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vBWXd-00052p-P1
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 06:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761130682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kBfjwrWaeU08zARbDtJ5eMY4XK1z9CrhTFoPTZP0e+A=;
 b=YROCHPNLfn7QM2ZMjoHZqc4odk8dMz0brwDDLQ+cIxLfCvKdRci+PP6w4EL/xHYc6fdpd1
 zGu82lcu2PyDfbbxzSBTC3wh9MHUVppuvi6k3tVx2jC0f1XOh4Intp1m+SQqzZ1lhbkthD
 rZeehL5+LYlGBAeRVc+eVfoHqBkxQVE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-m7t13Q9kNMaupEBR_bL13Q-1; Wed,
 22 Oct 2025 06:58:00 -0400
X-MC-Unique: m7t13Q9kNMaupEBR_bL13Q-1
X-Mimecast-MFC-AGG-ID: m7t13Q9kNMaupEBR_bL13Q_1761130679
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56A3F1956050; Wed, 22 Oct 2025 10:57:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 12BF918003FC; Wed, 22 Oct 2025 10:57:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 devel@lists.libvirt.org (reviewer:Incompatible changes),
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3] audio: deprecate HMP audio commands
Date: Wed, 22 Oct 2025 14:57:53 +0400
Message-ID: <20251022105753.1474739-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The command is niche and better served by the host audio system.
There is no QMP equivalent, fortunately. You can capture the audio
stream via remote desktop protocols too (dbus, vnc, spice).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 docs/about/deprecated.rst | 20 ++++++++++++++++++++
 audio/audio-hmp-cmds.c    |  7 +++++++
 audio/meson.build         |  5 +++--
 hmp-commands-info.hx      |  6 ++++--
 hmp-commands.hx           |  9 +++++++--
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dacf2882e4..31445dfc61 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -169,6 +169,26 @@ Use ``job-finalize`` instead.
 
 This argument has always been ignored.
 
+Human Machine Protocol (HMP) commands
+-------------------------------------
+
+``wavcapture`` (since 10.2)
+''''''''''''''''''''''''''''
+
+The ``wavcapture`` command is deprecated and will be removed in a future release.
+
+Use ``-audiodev wav`` or your host audio system to capture audio.
+
+``stopcapture`` (since 10.2)
+''''''''''''''''''''''''''''
+
+The ``stopcapture`` command is deprecated and will be removed in a future release.
+
+``info`` argument ``capture`` (since 10.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+The ``info capture`` command is deprecated and will be removed in a future release.
+
 Host Architectures
 ------------------
 
diff --git a/audio/audio-hmp-cmds.c b/audio/audio-hmp-cmds.c
index 8774c09f18..9129a02331 100644
--- a/audio/audio-hmp-cmds.c
+++ b/audio/audio-hmp-cmds.c
@@ -28,6 +28,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qobject/qdict.h"
+#include "qemu/error-report.h"
 
 static QLIST_HEAD (capture_list_head, CaptureState) capture_head;
 
@@ -36,6 +37,8 @@ void hmp_info_capture(Monitor *mon, const QDict *qdict)
     int i;
     CaptureState *s;
 
+    warn_report_once("'info capture' is deprecated since v10.2, to be removed");
+
     for (s = capture_head.lh_first, i = 0; s; s = s->entries.le_next, ++i) {
         monitor_printf(mon, "[%d]: ", i);
         s->ops.info (s->opaque);
@@ -48,6 +51,8 @@ void hmp_stopcapture(Monitor *mon, const QDict *qdict)
     int n = qdict_get_int(qdict, "n");
     CaptureState *s;
 
+    warn_report_once("'stopcapture' is deprecated since v10.2, to be removed");
+
     for (s = capture_head.lh_first, i = 0; s; s = s->entries.le_next, ++i) {
         if (i == n) {
             s->ops.destroy (s->opaque);
@@ -69,6 +74,8 @@ void hmp_wavcapture(Monitor *mon, const QDict *qdict)
     Error *local_err = NULL;
     AudioState *as = audio_state_by_name(audiodev, &local_err);
 
+    warn_report_once("'wavcapture' is deprecated since v10.2, to be removed");
+
     if (!as) {
         error_report_err(local_err);
         return;
diff --git a/audio/meson.build b/audio/meson.build
index 59f0a431d5..f0c97e5223 100644
--- a/audio/meson.build
+++ b/audio/meson.build
@@ -1,12 +1,13 @@
 system_ss.add([spice_headers, files('audio.c')])
 system_ss.add(files(
-  'audio-hmp-cmds.c',
   'mixeng.c',
   'noaudio.c',
   'wavaudio.c',
-  'wavcapture.c',
 ))
 
+# deprecated since v10.2, to be removed
+system_ss.add(files('audio-hmp-cmds.c', 'wavcapture.c'))
+
 system_ss.add(when: coreaudio, if_true: files('coreaudio.m'))
 system_ss.add(when: dsound, if_true: files('dsoundaudio.c', 'audio_win_int.c'))
 
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 25b4aed51f..8d3d180637 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -363,18 +363,20 @@ SRST
     Show host USB devices.
 ERST
 
+/* BEGIN deprecated */
     {
         .name       = "capture",
         .args_type  = "",
         .params     = "",
-        .help       = "show capture information",
+        .help       = "show capture information (deprecated)",
         .cmd        = hmp_info_capture,
     },
 
 SRST
   ``info capture``
-    Show capture information.
+    Show capture information (deprecated).
 ERST
+/* END deprecated */
 
     {
         .name       = "snapshots",
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 15f6082596..5cc4788f12 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -764,11 +764,12 @@ SRST
 
 ERST
 
+/* BEGIN deprecated */
     {
         .name       = "wavcapture",
         .args_type  = "path:F,audiodev:s,freq:i?,bits:i?,nchannels:i?",
         .params     = "path audiodev [frequency [bits [channels]]]",
-        .help       = "capture audio to a wave file (default frequency=44100 bits=16 channels=2)",
+        .help       = "capture audio to a wave file (deprecated, default frequency=44100 bits=16 channels=2)",
         .cmd        = hmp_wavcapture,
     },
 SRST
@@ -782,13 +783,15 @@ SRST
   - Sample rate = 44100 Hz - CD quality
   - Bits = 16
   - Number of channels = 2 - Stereo
+
+  Deprecated.
 ERST
 
     {
         .name       = "stopcapture",
         .args_type  = "n:i",
         .params     = "capture index",
-        .help       = "stop capture",
+        .help       = "stop capture (deprecated)",
         .cmd        = hmp_stopcapture,
     },
 SRST
@@ -797,7 +800,9 @@ SRST
 
     info capture
 
+  Deprecated.
 ERST
+/* END deprecated */
 
     {
         .name       = "memsave",
-- 
2.51.0


