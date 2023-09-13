Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD2979E0E8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOl-000705-2S; Wed, 13 Sep 2023 03:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOi-0006tD-DZ
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:52 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOe-0001t3-HR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:52 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-307d20548adso6571626f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590487; x=1695195287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7zLmlve1kiymTOj6p0U8jLLUq+x6nD+9txmyGE9+1TA=;
 b=J0AI5QmlQfHTze5MGZculy6n5zCcT38c0gqq0iaeV+7YvL33me+Yx/UEOixLiABvMz
 AbBAmqliIPRW2iCTsMZU9GZatlVfpYy/X2KIiJtuQ54BS6jUabbGDTfyz8ynWzBeazax
 iS1c5ggNQ12x3tyoUzaizMOmtv9zmpcWZpciys2zcYJ79DGH1pLkAmnFcwFDRvWteppb
 heRygq79+fJelkX1Vj6ilReQWQ+z+Y+0bokD3doXIc4n/g6b48BHX7ld952XyDFg35GC
 H/V0S8/DRd1MM0Rw0dC1j7OC3tRcNGELa4WI4L/J2RNYFpsYxqYbEfZ4l0EBrE+WD4Ea
 ndag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590487; x=1695195287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7zLmlve1kiymTOj6p0U8jLLUq+x6nD+9txmyGE9+1TA=;
 b=q+SgIH8+Ge7TGZMOouDOQ/DeYEscJQXh55wYs1W1x1G3kM6cV9cGMuheUHq7DTnfER
 MDL4ytmBDVDuXcrJhVufI2OFsuR6VVY7IoVOm0x9pdITTgJfHYITdXjhrTvirX4xYw4u
 q+xxK0D/T7N/hHoH16CMX9ucyEjFLnx0d61h8GmBt0jIhX0JqmUnKUuws8cThj1Og0b0
 UpEfJRGZjhGqnYHmLn3PNPasyW9qPgIZHy9qwHnrSavUOIyJIbBn2UnKpAGTYyihIZOe
 bmHw63bHcv2NZSWktgA2X8ZYPyMQ9yIzWhwqMzA9EwTfcQzJjN+k4My6uBili2j6JDFk
 UUvw==
X-Gm-Message-State: AOJu0YyAYkebxMt+0+pcGRgeh6jymZwP86Y2jiKgjrFA9kr3KoGE+x19
 2ayOaEZUPGi+l7Ha99cwOOqZwJw3cqqRWMhRVFU=
X-Google-Smtp-Source: AGHT+IEYNwPnxGnycqoXVu6FRnojF0+cLtgENSWUQOVecjsc5HnpHYSjXF2XGMs02d9VMkzOKP+8wA==
X-Received: by 2002:adf:f185:0:b0:319:74d5:a2d7 with SMTP id
 h5-20020adff185000000b0031974d5a2d7mr1407795wro.32.1694590486939; 
 Wed, 13 Sep 2023 00:34:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:46 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Gerd Hoffmann" <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v9 11/12] virtio-sound: implement audio capture (RX)
Date: Wed, 13 Sep 2023 10:33:18 +0300
Message-Id: <9dd07311d79840ffcfaede03b425ba0b096f3961.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

To perform audio capture we duplicate the TX logic of the previous
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU's audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 213 insertions(+), 23 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3b95e745c2..9b7fbffedc 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
 virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
-virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_tx_xfer(void) "tx queue callback called"
+virtio_snd_handle_rx_xfer(void) "rx queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 6fe03f9790..1d3a001371 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -28,7 +28,7 @@
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
@@ -49,7 +49,9 @@ static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
 
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -398,6 +400,9 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
     }
 }
@@ -465,7 +470,12 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
                                          &as);
         AUD_set_volume_out(stream->voice.out, 0, 255, 255);
     } else {
-        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+        stream->voice.in = AUD_open_in(&s->card,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &as);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
@@ -551,6 +561,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
         /* remove previous buffers. */
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
@@ -634,7 +646,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
          */
         virtio_snd_process_cmdq(stream->s);
         trace_virtio_snd_pcm_stream_flush(stream_id);
-        virtio_snd_pcm_flush(stream);
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            virtio_snd_pcm_out_flush(stream);
+        } else {
+            virtio_snd_pcm_in_flush(stream);
+        }
     }
 
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
@@ -795,7 +811,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -806,7 +822,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_status resp = { 0 };
     uint32_t stream_id;
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -874,12 +890,79 @@ tx_err:
 }
 
 /*
- * Stub buffer virtqueue handler.
+ * The rx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
  *
  * @vdev: VirtIOSound device
- * @vq: virtqueue
+ * @vq: tx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSoundPCMBlock *block;
+    VirtQueueElement *elem;
+    size_t msg_sz, size;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
+    uint32_t stream_id;
+
+    trace_virtio_snd_handle_rx_xfer();
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        /* get the message hdr object */
+        msg_sz = iov_to_buf(elem->out_sg,
+                            elem->out_num,
+                            0,
+                            &hdr,
+                            sizeof(hdr));
+        if (msg_sz != sizeof(hdr)) {
+            goto rx_err;
+        }
+        stream_id = le32_to_cpu(hdr.stream_id);
+
+        if (stream_id >= s->snd_conf.streams
+            || !s->pcm->streams[stream_id]) {
+            goto rx_err;
+        }
+
+        stream = s->pcm->streams[stream_id];
+        if (!stream || stream->info.direction != VIRTIO_SND_D_INPUT) {
+            goto rx_err;
+        }
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            size = iov_size(elem->in_sg, elem->in_num) -
+                sizeof(virtio_snd_pcm_status);
+            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
+            block->elem = elem;
+            block->vq = vq;
+            block->size = 0;
+            block->offset = 0;
+            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
+        }
+        continue;
+
+rx_err:
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+            iov_from_buf(elem->in_sg,
+                         elem->in_num,
+                         0,
+                         &resp,
+                         sizeof(resp));
+        }
+    }
+
+    /*
+     * Notify vq about virtio_snd_pcm_status responses.
+     * Buffer responses must be notified separately later.
+     */
+    virtio_notify(VIRTIO_DEVICE(s), vq);
+}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -965,9 +1048,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
 
@@ -1048,26 +1131,133 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
 }
 
 /*
- * Flush all buffer data from this stream's queue into the driver's virtual
- * queue.
+ * AUD_* input callback.
  *
- * @stream: VirtIOSoundPCMStream *stream
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be read with AUD_read()
  */
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+static void virtio_snd_pcm_in_cb(void *data, int available)
 {
+    VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBlock *block;
-    VirtIOSoundPCMBlock *next;
+    virtio_snd_pcm_status resp = { 0 };
+    size_t size;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
-            AUD_write(stream->voice.out, block->data + block->offset, block->size);
-            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
-            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
-            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            block = QSIMPLEQ_FIRST(&stream->queue);
+
+            for (;;) {
+                size = AUD_read(stream->voice.in,
+                        block->data + block->size,
+                        MIN(available, (stream->params.period_bytes - block->size)));
+                if (!size) {
+                    available = 0;
+                    break;
+                }
+                block->size += size;
+                available -= size;
+                if (block->size >= stream->params.period_bytes) {
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+                    resp.latency_bytes = 0;
+                    /* Copy data -if any- to guest */
+                    iov_from_buf(block->elem->in_sg,
+                                 block->elem->in_num,
+                                 0,
+                                 block->data,
+                                 stream->params.period_bytes);
+                    iov_from_buf(block->elem->in_sg,
+                                 block->elem->in_num,
+                                 block->size,
+                                 &resp,
+                                 sizeof(resp));
+                    virtqueue_push(block->vq,
+                                   block->elem,
+                                   sizeof(block->elem));
+                    virtio_notify(VIRTIO_DEVICE(stream->s),
+                                  block->vq);
+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                    virtio_snd_pcm_block_free(block);
+                    break;
+                }
+                if (!available) {
+                    break;
+                }
+            }
+            if (!available) {
+                break;
+            }
         }
     }
 }
 
+#define virtio_snd_pcm_flush(AUD_CB)                                    \
+    VirtIOSoundPCMBlock *block;                                         \
+    VirtIOSoundPCMBlock *next;                                          \
+    virtio_snd_pcm_status resp = { 0 };                                 \
+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                         \
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                        \
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {     \
+            do {                                                        \
+                AUD_CB;                                                 \
+            } while (0)                                                 \
+            ;                                                           \
+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));\
+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);         \
+            QSIMPLEQ_REMOVE(&stream->queue,                             \
+                            block,                                      \
+                            VirtIOSoundPCMBlock,                        \
+                            entry);                                     \
+            virtio_snd_pcm_block_free(block);                           \
+        }                                                               \
+    }                                                                   \
+
+
+/*
+ * Flush all buffer data from this output stream's queue into the driver's
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
+{
+    /* We should flush the buffers as soon as possible, because it is a
+     * time-sensitive operation.
+     *
+     * TODO: find out if copying leftover flushed data to an intermediate
+     * buffer is a good approach.
+     */
+    virtio_snd_pcm_flush(
+            iov_from_buf(block->elem->in_sg,
+                         block->elem->in_num,
+                         0,
+                         &resp,
+                         sizeof(resp));
+            );
+}
+
+/*
+ * Flush all buffer data from this input stream's queue into the driver's
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_pcm_flush(
+            iov_from_buf(block->elem->in_sg,
+                         block->elem->in_num,
+                         0,
+                         block->data,
+                         block->size);
+            iov_from_buf(block->elem->in_sg,
+                         block->elem->in_num,
+                         block->size,
+                         &resp,
+                         sizeof(resp));
+            );
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1103,7 +1293,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
     virtio_cleanup(vdev);
 }
 
-
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
-- 
2.39.2


