Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FA18249A2
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:35:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQc-0003Zd-L8; Thu, 04 Jan 2024 15:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQZ-0003YO-6V
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:55 -0500
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQW-0004N0-Fq
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:54 -0500
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
 by mailout04.t-online.de (Postfix) with SMTP id AF78D3BBF;
 Thu,  4 Jan 2024 21:34:50 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd72.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQL-3uNmmv0; Thu, 4 Jan 2024 21:34:41 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 5C83E2001D1; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 09/10] hw/audio/virtio-sound: add missing vmstate fields
Date: Thu,  4 Jan 2024 21:34:21 +0100
Message-Id: <20240104203422.12308-9-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400481-5181C95D-F891D282/0/0 CLEAN NORMAL
X-TOI-MSGID: 19aac2dd-b5b8-4c83-8744-8f765b1dcaf1
Received-SPF: pass client-ip=194.25.134.18;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout04.t-online.de
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

The virtio-sound device is currently not migratable. Add the
missing VMSTATE fields, enable migration and reconnect the audio
streams after migration.

The queue_inuse[] array variables mimic the inuse variable in
struct VirtQueue which is private. They are needed to restart
the virtio queues after migration.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 81 +++++++++++++++++++++++++++++++----
 include/hw/audio/virtio-snd.h |  1 +
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 92b10287ad..328ee54808 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -25,7 +25,6 @@
 #include "hw/audio/virtio-snd.h"
 #include "hw/core/cpu.h"
 
-#define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
 #define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
@@ -80,17 +79,40 @@ static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
                                 | BIT(VIRTIO_SND_PCM_RATE_192000)
                                 | BIT(VIRTIO_SND_PCM_RATE_384000);
 
+static const VMStateDescription vmstate_virtio_snd_stream = {
+    .name = "virtio-sound-stream",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(state, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(info.hdr.hda_fn_nid, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(info.features, VirtIOSoundPCMStream),
+        VMSTATE_UINT64(info.formats, VirtIOSoundPCMStream),
+        VMSTATE_UINT64(info.rates, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.direction, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.channels_min, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(info.channels_max, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.buffer_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.period_bytes, VirtIOSoundPCMStream),
+        VMSTATE_UINT32(params.features, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.channels, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.format, VirtIOSoundPCMStream),
+        VMSTATE_UINT8(params.rate, VirtIOSoundPCMStream),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_snd_device = {
-    .name = TYPE_VIRTIO_SND,
-    .version_id = VIRTIO_SOUND_VM_VERSION,
-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
+    .name = "virtio-sound-device",
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(queue_inuse, VirtIOSound, VIRTIO_SND_VQ_MAX),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(streams, VirtIOSound,
+            snd_conf.streams,
+            vmstate_virtio_snd_stream, VirtIOSoundPCMStream),
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static const VMStateDescription vmstate_virtio_snd = {
-    .name = TYPE_VIRTIO_SND,
-    .unmigratable = 1,
-    .minimum_version_id = VIRTIO_SOUND_VM_VERSION,
-    .version_id = VIRTIO_SOUND_VM_VERSION,
+    .name = "virtio-sound",
     .fields = (const VMStateField[]) {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
@@ -820,6 +842,7 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
                  sizeof(virtio_snd_hdr));
     virtqueue_push(cmd->vq, cmd->elem,
                    sizeof(virtio_snd_hdr) + cmd->payload_size);
+    s->queue_inuse[VIRTIO_SND_VQ_CONTROL] -= 1;
     virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
 }
 
@@ -866,6 +889,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 
     elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     while (elem) {
+        s->queue_inuse[VIRTIO_SND_VQ_CONTROL] += 1;
         cmd = g_new0(virtio_snd_ctrl_command, 1);
         cmd->elem = elem;
         cmd->vq = vq;
@@ -914,6 +938,7 @@ static void empty_invalid_queue(VirtIODevice *vdev, uint32_t queue_index)
         virtqueue_push(vq,
                        buffer->elem,
                        sizeof(virtio_snd_pcm_status));
+        s->queue_inuse[queue_index] -= 1;
         QSIMPLEQ_REMOVE_HEAD(invalidq, entry);
         virtio_snd_pcm_buffer_free(buffer);
     }
@@ -958,6 +983,7 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (!elem) {
             break;
         }
+        s->queue_inuse[VIRTIO_SND_VQ_TX] += 1;
         /* get the message hdr object */
         msg_sz = iov_to_buf(elem->out_sg,
                             elem->out_num,
@@ -1035,6 +1061,7 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         if (!elem) {
             break;
         }
+        s->queue_inuse[VIRTIO_SND_VQ_RX] += 1;
         /* get the message hdr object */
         msg_sz = iov_to_buf(elem->out_sg,
                             elem->out_num,
@@ -1192,6 +1219,7 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status));
+    stream->s->queue_inuse[VIRTIO_SND_VQ_TX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1283,6 +1311,7 @@ static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
     virtqueue_push(buffer->vq,
                    buffer->elem,
                    sizeof(virtio_snd_pcm_status) + buffer->size);
+    stream->s->queue_inuse[VIRTIO_SND_VQ_RX] -= 1;
     virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     QSIMPLEQ_REMOVE(&stream->queue,
                     buffer,
@@ -1388,6 +1417,41 @@ static void virtio_snd_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
+static int virtio_snd_post_load(VirtIODevice *vdev)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    uint32_t i;
+
+    for (i = 0; i < s->snd_conf.streams; i++) {
+        struct VirtIOSoundPCMStream *stream;
+
+        stream = virtio_snd_pcm_get_stream(s, i);
+        if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+            QSIMPLEQ_INIT(&stream->queue);
+            virtio_snd_pcm_open(stream);
+
+            if (stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE) {
+                virtio_snd_pcm_set_active(stream, true);
+            }
+        }
+    }
+
+    for (i = 0; i < VIRTIO_SND_VQ_MAX; i++) {
+        if (s->queue_inuse[i]) {
+            bool rc;
+
+            rc = virtqueue_rewind(s->queues[i], s->queue_inuse[i]);
+            if (!rc) {
+                error_report(
+                    "virtio-sound: could not rewind %u elements in queue %u",
+                    s->queue_inuse[i], i);
+            }
+            s->queue_inuse[i] = 0;
+        }
+    }
+
+    return 0;
+}
 
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
@@ -1412,6 +1476,7 @@ static void virtio_snd_class_init(ObjectClass *klass, void *data)
 
     dc->vmsd = &vmstate_virtio_snd;
     vdc->vmsd = &vmstate_virtio_snd_device;
+    vdc->post_load = virtio_snd_post_load;
     vdc->realize = virtio_snd_realize;
     vdc->unrealize = virtio_snd_unrealize;
     vdc->get_config = virtio_snd_get_config;
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 9b81f66b05..141e60e23c 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -200,6 +200,7 @@ struct VirtIOSound {
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     VirtIOSoundPCMBufferSimpleQueue *invalidq[VIRTIO_SND_VQ_MAX];
+    uint32_t queue_inuse[VIRTIO_SND_VQ_MAX];
     uint64_t features;
     VirtIOSoundPCMStream *streams;
     QEMUSoundCard card;
-- 
2.35.3


