Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2327F7B3461
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmECL-000166-Gi; Fri, 29 Sep 2023 10:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmECI-0000tV-M5
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:26 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEC4-0004YT-SX
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:10:25 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40528376459so145392375e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996609; x=1696601409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiEW46RnF6PNdyPAfmbzlAvFmakYh7tgcxi5EJPZUcg=;
 b=lLwjsvR1gn1XL0m1UFEKiAaksjLtP9RwDfghMrOX8RHsd72UKvOuIN6lAbtf8RTmFI
 Dobra1hDMdTFJN4iNUOSnYEzD0h55Be/xykteqx9Lmi6cflN0KKfmVatlZA8n933LosI
 xTEUS1LwNt9sFrU7n7Wy3Sc/8AIJwZp5uz56pkfTET0CwP133ZmfkPyeRPggoz3iil7Z
 NN34gLzwuLb5brN04E4rLhgATIEEY2JI/J4vY/ZXtVDwELYHqaKyVpTUuqBncrwhpl3g
 bWwOvk4qwP/8sh4fksnSliqyE5ahBMhvJ5bOnkQEn6g8rn455c5/CQp7YUHfnZhvyH6S
 jiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996609; x=1696601409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiEW46RnF6PNdyPAfmbzlAvFmakYh7tgcxi5EJPZUcg=;
 b=XYGMOyqj+A2UwCRfYZUh+U31FZagqmELEYvN35LMUZkosAkQylDq+G/Buptkb7Is7I
 NRw84Crj1ju5wLerilM2GIkzRsrHIzDE9pZK8Q6W41FrVTiOAUKBRWKCBYv0JBPuOi7G
 EFzQu4OpWQMv77bX6PZnOYng8StwW+OYaQ1FEwoAfrDeiVVl4iis6/u2MBkJ8ms5paoU
 +BlyPzz9a+AI7mzOvcE8/BJ0RmxIVzvqtf0Z05etO9v+MHs+QrdYWEQqoAHpjQtYRvEI
 Aqr9TFCG76OosvJDP97hdQgIp+5JD2S4yAPdNa5j8vqxcbDadH2oc4kiFoXm35zt0Yh4
 N+/w==
X-Gm-Message-State: AOJu0YxvZ1MRiB0a1k6VaH8DwUPjBSTZrBPC4qkBBcGbjdh5GqdNC4FO
 18DgQQINd9LUmBnAvS3JoMFbNM6+tZQNDZMHXJo=
X-Google-Smtp-Source: AGHT+IGcVBTrtr4zXGn6qyXuBCndZCVWVPG/kaA595NMnSi2Kx11OBsAtzkmNwpxzUqB9vgyc3K3uA==
X-Received: by 2002:a05:600c:22d1:b0:405:3251:47a1 with SMTP id
 17-20020a05600c22d100b00405325147a1mr3989521wmg.40.1695996609297; 
 Fri, 29 Sep 2023 07:10:09 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:10:08 -0700 (PDT)
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
Subject: [PATCH v10 10/11] virtio-sound: implement audio capture (RX)
Date: Fri, 29 Sep 2023 17:08:30 +0300
Message-Id: <992b0d5ff47656ef86e9c68aa41388a51c326da7.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
References: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 297 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 270 insertions(+), 30 deletions(-)

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
index d9114930d6..b857b69f00 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -28,13 +28,15 @@
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -409,9 +411,13 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
     if (stream) {
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            virtio_snd_pcm_flush(stream);
+            virtio_snd_pcm_out_flush(stream);
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
+            virtio_snd_pcm_in_flush(stream);
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
     }
 }
@@ -482,7 +488,13 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
@@ -573,6 +585,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
         }
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, stream_id);
@@ -657,7 +671,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
          *   are pending I/O messages for the specified stream ID.
          */
         trace_virtio_snd_pcm_stream_flush(stream_id);
-        virtio_snd_pcm_flush(stream);
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            virtio_snd_pcm_out_flush(stream);
+        } else {
+            virtio_snd_pcm_in_flush(stream);
+        }
     }
 
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
@@ -821,7 +839,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -917,12 +935,103 @@ tx_err:
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
+    VirtIOSoundPCMBuffer *buffer;
+    VirtQueueElement *elem;
+    size_t msg_sz, size;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
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
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
+                buffer = QSIMPLEQ_FIRST(&stream->invalid);
+
+                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+                iov_from_buf(buffer->elem->in_sg,
+                             buffer->elem->in_num,
+                             0,
+                             &resp,
+                             sizeof(virtio_snd_pcm_status));
+                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
+                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
+                virtio_snd_pcm_buffer_free(buffer);
+            }
+            /*
+             * Notify vq about virtio_snd_pcm_status responses.
+             * Buffer responses must be notified separately later.
+             */
+            virtio_notify(vdev, vq);
+        }
+    }
+}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -1010,9 +1119,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
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
 
@@ -1107,33 +1216,163 @@ return_tx_buffer:
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
-    VirtIOSoundPCMBuffer *buffer, *next;
+    VirtIOSoundPCMStream *stream = data;
+    VirtIOSoundPCMBuffer *buffer;
+    virtio_snd_pcm_status resp = { 0 };
+    size_t size;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
-            AUD_write(stream->voice.out,
-                      buffer->data + buffer->offset,
-                      buffer->size);
-            virtqueue_push(buffer->vq,
-                           buffer->elem,
-                           sizeof(VirtQueueElement));
-            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
-            QSIMPLEQ_REMOVE(&stream->queue,
-                            buffer,
-                            VirtIOSoundPCMBuffer,
-                            entry);
-            virtio_snd_pcm_buffer_free(buffer);
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            buffer = QSIMPLEQ_FIRST(&stream->queue);
+            if (!virtio_queue_ready(buffer->vq)) {
+                return;
+            }
+            if (!stream->active) {
+                /* Stream has stopped, so do not perform AUD_read. */
+                goto return_rx_buffer;
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
+return_rx_buffer:
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+                    resp.latency_bytes = 0;
+                    /* Copy data -if any- to guest */
+                    iov_from_buf(buffer->elem->in_sg,
+                                 buffer->elem->in_num,
+                                 0,
+                                 buffer->data,
+                                 buffer->size);
+                    iov_from_buf(buffer->elem->in_sg,
+                                 buffer->elem->in_num,
+                                 buffer->size,
+                                 &resp,
+                                 sizeof(resp));
+                    virtqueue_push(buffer->vq,
+                                   buffer->elem,
+                                   sizeof(virtio_snd_pcm_status) +
+                                    buffer->size);
+                    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                    virtio_snd_pcm_buffer_free(buffer);
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
 
+#define virtio_snd_pcm_flush(AUD_CB)                                         \
+    VirtIOSoundPCMBuffer *buffer;                                            \
+    virtio_snd_pcm_status resp = { 0 };                                      \
+    unsigned int len = 0;                                                    \
+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                              \
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                             \
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {                            \
+            buffer = QSIMPLEQ_FIRST(&stream->queue);                         \
+            do {                                                             \
+                AUD_CB;                                                      \
+            } while (0)                                                      \
+            ;                                                                \
+            virtqueue_push(buffer->vq, buffer->elem, len);                   \
+            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);             \
+            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);                     \
+            virtio_snd_pcm_buffer_free(buffer);                              \
+        }                                                                    \
+    }
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
+    /*
+     * We should flush the buffers as soon as possible, because it is a
+     * time-sensitive operation.
+     *
+     * TODO: find out if copying leftover flushed data to an intermediate
+     * buffer is a good approach.
+     */
+    size_t written;
+    virtio_snd_pcm_flush(
+            if (stream->active && buffer->stale) {
+                iov_to_buf(buffer->elem->out_sg,
+                           buffer->elem->out_num,
+                           buffer->offset,
+                           buffer->data,
+                           buffer->size);
+                buffer->stale = false;
+            }
+            if (stream->active)
+                while (buffer->size > 0) {
+                    written = AUD_write(stream->voice.out,
+                                        buffer->data + buffer->offset,
+                                        buffer->size);
+                    if (written < 1) {
+                        break;
+                    }
+                    buffer->size -= written;
+                    buffer->offset += written;
+                }
+            len = sizeof(virtio_snd_pcm_status);
+            iov_from_buf(buffer->elem->in_sg,
+                         buffer->elem->in_num,
+                         0,
+                         &resp,
+                         sizeof(virtio_snd_pcm_status));
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
+            len = sizeof(virtio_snd_pcm_status) + buffer->size;
+            iov_from_buf(buffer->elem->in_sg,
+                         buffer->elem->in_num,
+                         0,
+                         buffer->data,
+                         buffer->size);
+            iov_from_buf(buffer->elem->in_sg,
+                         buffer->elem->in_num,
+                         buffer->size,
+                         &resp,
+                         sizeof(virtio_snd_pcm_status));
+            );
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-- 
2.39.2


