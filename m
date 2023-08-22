Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD846784A3A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:20:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuu-0006E8-Mh; Tue, 22 Aug 2023 15:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWus-00068O-LF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:50 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWup-0000tl-Kw
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:50 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so45712665e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731986; x=1693336786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmwfxU5ZQhjeW0W0x+3TgUSDoyEQ69d8vLDs9qWiP5c=;
 b=S8brLmDbr4ehdyzW42/9Jv5a7eZwPIZtzMLme1w5tRXCm/iUf2z5uLpohi0ZvT4COg
 UPY1KX0+mj2tmLS07jBEnSBQ0ai3onEmMtnOrzQLzgkkU9TutJ+pzJjcswtJFfcO0KB7
 RM69Bg4wMvjf0N2SSjNjRL3QcTDQVblRM+oHd8H6kwhDzxmJ9o35eLTJSB9fI2RpxoyB
 U6LDpxwFBSTayrYZykOOCqYJ+RkDtI0TmF44fzpjtkZYBBLvRAkLFj4XkGWknKg3n4ct
 MlV30uOmQSwbZ3ImvQ/dAyXSm8Nlq99U5GgEq61Mop7/eFq/5EPFGBg7MKemQUIYjLu+
 EErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731986; x=1693336786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmwfxU5ZQhjeW0W0x+3TgUSDoyEQ69d8vLDs9qWiP5c=;
 b=RQEfMoX1c5Bmzc/n5W3SJWlfzYxRHsHMmP/H900l2mpmZcT5ppxpq/ut5uWWVdNurp
 /J5YsLlPUDNBkDTPlvLJLyu2qF7kHLzrb2HTL65gfBe3K1lPrR8yiUVdJjp/AnXFRbTW
 XHTFV4/QLvoogGsb2J478T+E9qm4vD3KkL2kD9/WqI4tJlejU/nyqNpNNUyuAQRAALvx
 TPsjw5BLtpXNsVvcQv7RosrLkpuhQXtKNPSPjDIfJFOvdIFfUFEtNSwbEWBhwrLP5OTT
 2wxVGPEdRj1mC+zT5fFQM6HgDDlDiZYl70ptXJCtLd4+9mjocrKQTpwqcyskkLVAf+u0
 NrSw==
X-Gm-Message-State: AOJu0Yy/rniN/YD75RsN8B5duhiyz03fmM806IDYQyW347XvLwikUSTB
 1Lu8AypIagphYkTA4L16MsqH2uGuRSWj+f/oMAQ=
X-Google-Smtp-Source: AGHT+IHdGhblnSGzfQ3JPLKKzKPlx/kxBcIgIp3Fe2NeNarOPKufo7GfiGNmYvNgW0x4dOEC4jwjZg==
X-Received: by 2002:a7b:c7d8:0:b0:3fe:f667:4e4c with SMTP id
 z24-20020a7bc7d8000000b003fef6674e4cmr2902361wmk.12.1692731985912; 
 Tue, 22 Aug 2023 12:19:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:45 -0700 (PDT)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 11/12] virtio-sound: implement audio capture (RX)
Date: Tue, 22 Aug 2023 22:18:34 +0300
Message-Id: <770e8b2fe7ff93bb6b94e5f782cf1f0b4e032f74.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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
 hw/virtio/virtio-snd.c | 245 +++++++++++++++++++++++++++++++++++------
 2 files changed, 215 insertions(+), 33 deletions(-)

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
index 394005e23e..0ac636eee9 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -26,18 +26,21 @@
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
-static uint32_t
-virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
-                          VirtQueue *vq,
-                          VirtQueueElement *element,
-                          bool read);
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
+static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
+                                     VirtQueue *vq,
+                                     VirtQueueElement *element);
+static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
+                                    VirtQueue *vq,
+                                    VirtQueueElement *element);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -393,6 +396,9 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->direction == VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
         qemu_mutex_destroy(&stream->queue_mutex);
         g_free(stream);
@@ -455,7 +461,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
                                          virtio_snd_pcm_out_cb,
                                          &as);
     } else {
-        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+        stream->voice.in = AUD_open_in(&s->card,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &as);
     }
 
     stream->as = as;
@@ -520,6 +531,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
@@ -591,7 +604,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
          */
         virtio_snd_process_cmdq(stream->s);
         trace_virtio_snd_pcm_stream_flush(stream_id);
-        virtio_snd_pcm_flush(stream);
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+            virtio_snd_pcm_out_flush(stream);
+        } else {
+            virtio_snd_pcm_in_flush(stream);
+        }
     }
 
     cmd->resp.code = VIRTIO_SND_S_OK;
@@ -750,7 +767,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -759,7 +776,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp = { 0 };
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -783,11 +800,11 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
             goto tx_err;
         }
 
+        assert(hdr.stream_id != VIRTIO_SND_D_INPUT);
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            virtio_snd_pcm_read_write(stream,
+            virtio_snd_pcm_write(stream,
                     vq,
-                    elem,
-                    hdr.stream_id == VIRTIO_SND_D_INPUT);
+                    elem);
 
             resp.status = VIRTIO_SND_S_OK;
             iov_from_buf(elem->in_sg,
@@ -817,12 +834,66 @@ tx_err:
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
+    VirtQueueElement *elem;
+    size_t sz;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
+
+    trace_virtio_snd_handle_rx_xfer();
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        /* get the message hdr object */
+        sz = iov_to_buf(elem->out_sg,
+                        elem->out_num,
+                        0,
+                        &hdr,
+                        sizeof(hdr));
+        if (sz != sizeof(hdr)
+            || hdr.stream_id >= s->snd_conf.streams
+            || !s->pcm->streams[hdr.stream_id]) {
+            continue;
+        }
+
+        stream = s->pcm->streams[hdr.stream_id];
+        if (stream->direction != VIRTIO_SND_D_INPUT) {
+            goto rx_err;
+        }
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            virtio_snd_pcm_read(stream, vq, elem);
+        }
+        continue;
+
+rx_err:
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            resp.status = VIRTIO_SND_S_BAD_MSG;
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
@@ -949,8 +1020,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_tx,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx_xfer,
+                              virtio_snd_handle_rx_xfer,
                               errp);
 }
 
@@ -1001,26 +1072,119 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
+    uint32_t sz;
+    virtio_snd_pcm_status resp = { 0 };
+    size_t size;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
-            AUD_write(stream->voice.out, block->data, block->size);
-            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
-            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
-            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            block = QSIMPLEQ_FIRST(&stream->queue);
+
+            for (;;) {
+                size = AUD_read(stream->voice.in,
+                        block->data + block->offset,
+                        MIN(stream->period_bytes - block->offset, available));
+                block->offset += size;
+                block->size += size;
+                if (size == 0 || block->size >= stream->period_bytes) {
+                    resp.status = VIRTIO_SND_S_OK;
+                     sz = iov_from_buf(block->elem->in_sg,
+                                  block->elem->in_num,
+                                  0,
+                                  &resp,
+                                  sizeof(resp));
+
+                    /* Copy data -if any- to guest */
+                    if (block->size) {
+                        iov_from_buf(block->elem->in_sg,
+                                     block->elem->in_num,
+                                     sz,
+                                     block->data,
+                                     MIN(stream->period_bytes, block->size));
+                    }
+                    virtqueue_push(block->vq,
+                            block->elem,
+                            sizeof(block->elem));
+                    virtio_notify(VIRTIO_DEVICE(stream->s),
+                            block->vq);
+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                    g_free(block);
+                    available -= size;
+                    break;
+                }
+
+                available -= size;
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
+    virtio_snd_pcm_flush(
+            AUD_write(stream->voice.out,
+                              block->data,
+                              block->size);
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
+                         sizeof(virtio_snd_pcm_info),
+                         block->data,
+                         block->offset);
+            );
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1055,10 +1219,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 
 static uint32_t
-virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
                           VirtQueue *vq,
-                          VirtQueueElement *element,
-                          bool read)
+                          VirtQueueElement *element)
 {
     VirtIOSoundPCMBlock *fragment;
     size_t size = iov_size(element->out_sg, element->out_num) -
@@ -1080,6 +1243,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
     return fragment->size;
 }
 
+static uint32_t
+virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
+                          VirtQueue *vq,
+                          VirtQueueElement *element)
+{
+    VirtIOSoundPCMBlock *fragment;
+
+    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + stream->period_bytes);
+    fragment->elem = element;
+    fragment->vq = vq;
+    fragment->size = 0;
+    fragment->offset = 0;
+
+    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
+
+    return fragment->size;
+}
+
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
-- 
2.39.2


