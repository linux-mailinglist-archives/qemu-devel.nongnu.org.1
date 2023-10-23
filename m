Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5AE7D361C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:06:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutgA-0005gG-UR; Mon, 23 Oct 2023 08:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfx-0005Wg-SF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfu-00022G-Qa
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40859c46447so13310945e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062686; x=1698667486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+b+4iA1DfUeGgKKifQtrUjnqov07ApYPhyAo0IFGREc=;
 b=fUbaoFTCpupWeCBxkifsId0V4Wg8f+vZoSPKHKS+4FMK5D6PklLIL5hp2us4y5UJ5A
 FRbTcIWnPRyf8T9CVKQo5IBwvKL/X17hgZq818SytgSsasb0QbqTRgWVN5iKxha1Mkf3
 sEYG4J0X0zKthnRn6zSUY02JYUVuyFTqlr09BP8sPBN5N+UVlEa3TGyH0BhTv/V7BgMe
 CJ7xzAvXcVNBDWnDdqHdl/pHppE6RU9P6swrRhF5zbjkNzyNZSj/8rgauoEc4cC9j4lx
 npQHzC83ePgm9n+6LENdy2A8Oo6u1l0j5dIfLkP2XJsgS0hrEGYjE3YUpNR0t0kbZxiW
 8GYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062686; x=1698667486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b+4iA1DfUeGgKKifQtrUjnqov07ApYPhyAo0IFGREc=;
 b=AJZ9INxVW2JYl9lMJYRXnj/CDf3xiGcZWn6oY7Xv+jdUEsn/1jI8Ejn5PBH/K8FYAR
 kOL3G8IuYxWeHdbmuEKxl+voJkgOfNUHo84AsrmXdcYaAwa+JXUadCP1q7YrwLgfQldB
 NsLUU8nijzkY0XEPeAzUMw+y+h+FpVS2spTPdBySsLdZ8YMujegt5dj4x9PSu3/TVhlK
 wQXTnDdi40weBimcdXsSD0TWtqdpDAtbSzGAlD+gL9S5FpV8I8S/+zamQZtecd+F/IfH
 Vd315lzxkfscM6GxcS4kIIFOckOQO2AGdAHl1KlK9cFHgfetxZWWC7PhCvHwtnRmyQbR
 NAwQ==
X-Gm-Message-State: AOJu0YyvsZVeoLiJ98KjHDrZZo/l2d4Kg4YvxVsS0jpGYX2oiyzlAOMK
 hbDet3G9dfjANJTB1IG4+KlrwtyGt3hd/2zpCLU=
X-Google-Smtp-Source: AGHT+IEYe5jpMQ2ndznqFZLsZcFt+qZ8hxMKKrOwTtksynFxvCkGw4qVlbQOeB+I98osfH8OKPpYgg==
X-Received: by 2002:a05:600c:4ecc:b0:408:37d4:b5ba with SMTP id
 g12-20020a05600c4ecc00b0040837d4b5bamr7797530wmq.12.1698062685188; 
 Mon, 23 Oct 2023 05:04:45 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:44 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	"Gerd Hoffmann" <kraxel@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>,
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Eduardo Habkost" <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?K=C5=91v=C3=A1g=C3=B3=2C=20Zolt=C3=A1n?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v13 10/11] virtio-sound: implement audio capture (RX)
Date: Mon, 23 Oct 2023 15:03:27 +0300
Message-Id: <e56a17741a24ccadfbbea19d3c60c9406b795b23.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events |   3 +-
 hw/audio/virtio-snd.c | 262 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 230 insertions(+), 35 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 884108129b..b1870ff224 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -56,4 +56,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
 virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
-virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_tx_xfer(void) "tx queue callback called"
+virtio_snd_handle_rx_xfer(void) "rx queue callback called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 6c91d0a740..a18a9949a7 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -28,13 +28,14 @@
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -408,10 +409,13 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
     if (stream) {
+        virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            virtio_snd_pcm_flush(stream);
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
     }
 }
@@ -482,7 +486,13 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
+        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
@@ -573,6 +583,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
         }
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, stream_id);
@@ -814,6 +826,49 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
+static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSoundPCMBuffer *buffer = NULL;
+    VirtIOSoundPCMStream *stream = NULL;
+    virtio_snd_pcm_status resp = { 0 };
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
+    bool any = false;
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        stream = vsnd->pcm->streams[i];
+        if (stream) {
+            any = false;
+            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
+                    buffer = QSIMPLEQ_FIRST(&stream->invalid);
+                    if (buffer->vq != vq) {
+                        break;
+                    }
+                    any = true;
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+                    iov_from_buf(buffer->elem->in_sg,
+                                 buffer->elem->in_num,
+                                 0,
+                                 &resp,
+                                 sizeof(virtio_snd_pcm_status));
+                    virtqueue_push(vq,
+                                   buffer->elem,
+                                   sizeof(virtio_snd_pcm_status));
+                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
+                    virtio_snd_pcm_buffer_free(buffer);
+                }
+                if (any) {
+                    /*
+                     * Notify vq about virtio_snd_pcm_status responses.
+                     * Buffer responses must be notified separately later.
+                     */
+                    virtio_notify(vdev, vq);
+                }
+            }
+        }
+    }
+}
+
 /*
  * The tx virtqueue handler. Makes the buffers available to their respective
  * streams for consumption.
@@ -821,7 +876,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -829,7 +884,6 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
-    virtio_snd_pcm_status resp = { 0 };
     uint32_t stream_id;
     /*
      * If any of the I/O messages are invalid, put them in stream->invalid and
@@ -840,7 +894,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     if (!virtio_queue_ready(vq)) {
         return;
     }
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -893,36 +947,88 @@ tx_err:
     }
 
     if (must_empty_invalid_queue) {
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
-                buffer = QSIMPLEQ_FIRST(&stream->invalid);
-
-                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-                iov_from_buf(buffer->elem->in_sg,
-                             buffer->elem->in_num,
-                             0,
-                             &resp,
-                             sizeof(virtio_snd_pcm_status));
-                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
-                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
-                virtio_snd_pcm_buffer_free(buffer);
-            }
-            /*
-             * Notify vq about virtio_snd_pcm_status responses.
-             * Buffer responses must be notified separately later.
-             */
-            virtio_notify(vdev, vq);
-        }
+        empty_invalid_queue(vdev, vq);
     }
 }
 
 /*
- * Stub buffer virtqueue handler.
+ * The rx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
  *
  * @vdev: VirtIOSound device
- * @vq: virtqueue
+ * @vq: rx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSoundPCMBuffer *buffer;
+    VirtQueueElement *elem;
+    size_t msg_sz, size;
+    virtio_snd_pcm_xfer hdr;
+    uint32_t stream_id;
+    /*
+     * if any of the I/O messages are invalid, put them in stream->invalid and
+     * return them after the for loop.
+     */
+    bool must_empty_invalid_queue = false;
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
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
+                            sizeof(virtio_snd_pcm_xfer));
+        if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
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
+        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+            goto rx_err;
+        }
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            size = iov_size(elem->in_sg, elem->in_num) -
+                sizeof(virtio_snd_pcm_status);
+            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+            buffer->elem = elem;
+            buffer->vq = vq;
+            buffer->size = 0;
+            buffer->offset = 0;
+            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
+        }
+        continue;
+
+rx_err:
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            must_empty_invalid_queue = true;
+            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
+            buffer->elem = elem;
+            buffer->vq = vq;
+            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
+        }
+    }
+
+    if (must_empty_invalid_queue) {
+        empty_invalid_queue(vdev, vq);
+    }
+}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -1010,9 +1116,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
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
 
@@ -1116,19 +1222,107 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
 }
 
 /*
- * Flush all buffer data from this stream's queue into the driver's virtual
- * queue.
+ * Flush all buffer data from this input stream's queue into the driver's
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
+                                    VirtIOSoundPCMBuffer *buffer)
+{
+    virtio_snd_pcm_status resp = { 0 };
+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+    resp.latency_bytes = 0;
+    /* Copy data -if any- to guest */
+    iov_from_buf(buffer->elem->in_sg,
+                 buffer->elem->in_num,
+                 0,
+                 buffer->data,
+                 buffer->size);
+    iov_from_buf(buffer->elem->in_sg,
+                 buffer->elem->in_num,
+                 buffer->size,
+                 &resp,
+                 sizeof(virtio_snd_pcm_status));
+    virtqueue_push(buffer->vq,
+                   buffer->elem,
+                   sizeof(virtio_snd_pcm_status) + buffer->size);
+    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
+    QSIMPLEQ_REMOVE(&stream->queue,
+                    buffer,
+                    VirtIOSoundPCMBuffer,
+                    entry);
+    virtio_snd_pcm_buffer_free(buffer);
+}
+
+
+/*
+ * AUD_* input callback.
+ *
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be read with AUD_read()
+ */
+static void virtio_snd_pcm_in_cb(void *data, int available)
+{
+    VirtIOSoundPCMStream *stream = data;
+    VirtIOSoundPCMBuffer *buffer;
+    size_t size;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            buffer = QSIMPLEQ_FIRST(&stream->queue);
+            if (!virtio_queue_ready(buffer->vq)) {
+                return;
+            }
+            if (!stream->active) {
+                /* Stream has stopped, so do not perform AUD_read. */
+                return_rx_buffer(stream, buffer);
+                continue;
+            }
+
+            for (;;) {
+                size = AUD_read(stream->voice.in,
+                        buffer->data + buffer->size,
+                        MIN(available, (stream->params.period_bytes -
+                                        buffer->size)));
+                if (!size) {
+                    available = 0;
+                    break;
+                }
+                buffer->size += size;
+                available -= size;
+                if (buffer->size >= stream->params.period_bytes) {
+                    return_rx_buffer(stream, buffer);
+                    break;
+                }
+                if (!available) {
+                    break;
+                }
+            }
+            if (!available) {
+                break;
+            }
+        }
+    }
+}
+
+/*
+ * Flush all buffer data from this output stream's queue into the driver's
+ * virtual queue.
  *
  * @stream: VirtIOSoundPCMStream *stream
  */
 static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
 {
     VirtIOSoundPCMBuffer *buffer;
+    void (*cb)(VirtIOSoundPCMStream *, VirtIOSoundPCMBuffer *) =
+        (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
+        return_rx_buffer;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
             buffer = QSIMPLEQ_FIRST(&stream->queue);
-            return_tx_buffer(stream, buffer);
+            cb(stream, buffer);
         }
     }
 }
-- 
2.39.2


