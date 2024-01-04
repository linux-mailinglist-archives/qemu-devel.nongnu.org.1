Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6821A8249A8
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:36:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQO-0003Eu-Bc; Thu, 04 Jan 2024 15:34:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQM-0003Em-Mp
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:42 -0500
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQL-0004Ki-4A
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:42 -0500
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout08.t-online.de (Postfix) with SMTP id 60FDE2EA6;
 Thu,  4 Jan 2024 21:34:39 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd78.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQG-2osYPx0; Thu, 4 Jan 2024 21:34:37 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 566632001CF; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 07/10] hw/audio/virtio-sound: introduce virtio_snd_set_active()
Date: Thu,  4 Jan 2024 21:34:19 +0100
Message-Id: <20240104203422.12308-7-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400477-5E75E979-9B3EEB01/0/0 CLEAN NORMAL
X-TOI-MSGID: f90e3ea0-3577-4449-b562-9993c9f8cdba
Received-SPF: pass client-ip=194.25.134.20;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout08.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Split out the function virtio_snd_pcm_set_active() from
virtio_snd_pcm_start_stop(). A later patch also needs this
new funcion. There is no functional change.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index a1d2b3367e..16e8c49655 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -473,6 +473,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
     }
 }
 
+/*
+ * Activate/deactivate a stream.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ * @active: whether to activate or deactivate the stream
+ */
+static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool active)
+{
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_set_active_out(stream->voice.out, active);
+    } else {
+        AUD_set_active_in(stream->voice.in, active);
+    }
+}
+
 /*
  * Close a stream and free all its resources.
  *
@@ -613,11 +628,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
         stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-        AUD_set_active_out(stream->voice.out, start);
-    } else {
-        AUD_set_active_in(stream->voice.in, start);
-    }
+    virtio_snd_pcm_set_active(stream, start);
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
-- 
2.35.3


