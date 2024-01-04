Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B88249A1
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:35:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQU-0003Rv-2I; Thu, 04 Jan 2024 15:34:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQO-0003F9-Jt
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:45 -0500
Received: from mailout03.t-online.de ([194.25.134.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQM-0004L4-Hz
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:44 -0500
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout03.t-online.de (Postfix) with SMTP id 69077401B2;
 Thu,  4 Jan 2024 21:34:40 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQJ-1C4Ckj0; Thu, 4 Jan 2024 21:34:39 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 595B52001D0; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 08/10] hw/audio/virtio-sound: fix segmentation fault in tx/rx
 xfer handler
Date: Thu,  4 Jan 2024 21:34:20 +0100
Message-Id: <20240104203422.12308-8-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400479-C1AEC9F9-713543D7/0/0 CLEAN NORMAL
X-TOI-MSGID: 495cb1ee-0d85-4428-b627-cbdef59e1bf2
Received-SPF: pass client-ip=194.25.134.81;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout03.t-online.de
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

With the involvement of a malicious guest, it's possible to reach
the error paths in the virtio_snd_handle_tx/rx_xfer handlers with
stream == NULL. This triggers a segmentation fault.

Move the queues for invalid messages from the stream structs to
the device struct and initialize the queues quite early so they
are always available to avoid this kind of issue.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 84 ++++++++++++++++-------------------
 include/hw/audio/virtio-snd.h |  8 +++-
 2 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 16e8c49655..92b10287ad 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -531,7 +531,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 
     if (!(stream->state & VSND_PCMSTREAM_STATE_F_PREPARED)) {
         QSIMPLEQ_INIT(&stream->queue);
-        QSIMPLEQ_INIT(&stream->invalid);
     }
 
     virtio_snd_pcm_open(stream);
@@ -677,9 +676,6 @@ static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
     QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
         count += 1;
     }
-    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
-        count += 1;
-    }
     return count;
 }
 
@@ -895,44 +891,38 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
-static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
+static void empty_invalid_queue(VirtIODevice *vdev, uint32_t queue_index)
 {
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtQueue *vq;
     VirtIOSoundPCMBuffer *buffer = NULL;
-    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSoundPCMBufferSimpleQueue *invalidq;
     virtio_snd_pcm_status resp = { 0 };
-    VirtIOSound *vsnd = VIRTIO_SND(vdev);
     bool any = false;
 
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        stream = &vsnd->streams[i];
-        if (stream) {
-            any = false;
-            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
-                buffer = QSIMPLEQ_FIRST(&stream->invalid);
-                if (buffer->vq != vq) {
-                    break;
-                }
-                any = true;
-                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-                iov_from_buf(buffer->elem->in_sg,
-                             buffer->elem->in_num,
-                             0,
-                             &resp,
-                             sizeof(virtio_snd_pcm_status));
-                virtqueue_push(vq,
-                               buffer->elem,
-                               sizeof(virtio_snd_pcm_status));
-                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
-                virtio_snd_pcm_buffer_free(buffer);
-            }
-            if (any) {
-                /*
-                 * Notify vq about virtio_snd_pcm_status responses.
-                 * Buffer responses must be notified separately later.
-                 */
-                virtio_notify(vdev, vq);
-            }
-        }
+    vq = s->queues[queue_index];
+    invalidq = s->invalidq[queue_index];
+    while (!QSIMPLEQ_EMPTY(invalidq)) {
+        any = true;
+        buffer = QSIMPLEQ_FIRST(invalidq);
+        resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        iov_from_buf(buffer->elem->in_sg,
+                     buffer->elem->in_num,
+                     0,
+                     &resp,
+                     sizeof(virtio_snd_pcm_status));
+        virtqueue_push(vq,
+                       buffer->elem,
+                       sizeof(virtio_snd_pcm_status));
+        QSIMPLEQ_REMOVE_HEAD(invalidq, entry);
+        virtio_snd_pcm_buffer_free(buffer);
+    }
+    if (any) {
+        /*
+         * Notify vq about virtio_snd_pcm_status responses.
+         * Buffer responses must be notified separately later.
+         */
+        virtio_notify(vdev, vq);
     }
 }
 
@@ -953,8 +943,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * If any of the I/O messages are invalid, put them in stream->invalid and
-     * return them after the for loop.
+     * If any of the I/O messages are invalid, put them in
+     * s->invalidq[VIRTIO_SND_VQ_TX] and return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
 
@@ -1005,11 +995,11 @@ tx_err:
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
         buffer->elem = elem;
         buffer->vq = vq;
-        QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
+        QSIMPLEQ_INSERT_TAIL(s->invalidq[VIRTIO_SND_VQ_TX], buffer, entry);
     }
 
     if (must_empty_invalid_queue) {
-        empty_invalid_queue(vdev, vq);
+        empty_invalid_queue(vdev, VIRTIO_SND_VQ_TX);
     }
 }
 
@@ -1030,8 +1020,8 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     uint32_t stream_id;
     /*
-     * if any of the I/O messages are invalid, put them in stream->invalid and
-     * return them after the for loop.
+     * if any of the I/O messages are invalid, put them in
+     * s->invalidq[VIRTIO_SND_VQ_RX] and return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
 
@@ -1079,12 +1069,12 @@ rx_err:
         buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
         buffer->elem = elem;
         buffer->vq = vq;
-        QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
+        QSIMPLEQ_INSERT_TAIL(s->invalidq[VIRTIO_SND_VQ_RX], buffer, entry);
 
     }
 
     if (must_empty_invalid_queue) {
-        empty_invalid_queue(vdev, vq);
+        empty_invalid_queue(vdev, VIRTIO_SND_VQ_RX);
     }
 }
 
@@ -1182,6 +1172,10 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     QTAILQ_INIT(&vsnd->cmdq);
+    QSIMPLEQ_INIT(&vsnd->invalidq_tx);
+    vsnd->invalidq[VIRTIO_SND_VQ_TX] = &vsnd->invalidq_tx;
+    QSIMPLEQ_INIT(&vsnd->invalidq_rx);
+    vsnd->invalidq[VIRTIO_SND_VQ_RX] = &vsnd->invalidq_rx;
 }
 
 static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index d6e08bd30d..9b81f66b05 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -77,6 +77,9 @@ typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
 
 typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
 
+typedef QSIMPLEQ_HEAD(VirtIOSoundPCMBufferSimpleQueue, VirtIOSoundPCMBuffer)
+    VirtIOSoundPCMBufferSimpleQueue;
+
 /*
  * The VirtIO sound spec reuses layouts and values from the High Definition
  * Audio spec (virtio/v1.2: 5.14 Sound Device). This struct handles each I/O
@@ -132,8 +135,7 @@ struct VirtIOSoundPCMStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
-    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
+    VirtIOSoundPCMBufferSimpleQueue queue;
 };
 
 /*
@@ -197,12 +199,14 @@ struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
+    VirtIOSoundPCMBufferSimpleQueue *invalidq[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCMStream *streams;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
     QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
+    VirtIOSoundPCMBufferSimpleQueue invalidq_tx, invalidq_rx;
 };
 
 struct virtio_snd_ctrl_command {
-- 
2.35.3


