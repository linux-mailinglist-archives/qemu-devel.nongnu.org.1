Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F15F7E3890
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:13:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J37-0003SO-33; Tue, 07 Nov 2023 05:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2u-0002Zj-SE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J2q-0002Tp-MU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7k04BtIMbJcMeHwiSPKgGrolXanjKZR9xU+A1o+1Wc=;
 b=aIxQVVWnWCcbN+IvKTrPsrIYpHekwVg7JFHuBaRgXRgZspF1vczyGLJKCLqIpi5dtmS9pW
 NbNc/s1bm/T0AzrWplE7FFDOl5Wuxxd+S9plqbtcYsP/sOEQ28aidFvCNcQp0X451Qv2jK
 GuTgdZ0ZLqbFLqFbTgHKLzHcDRfy7So=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Rc9jXf0iPhaW1aFZOEOV7w-1; Tue, 07 Nov 2023 05:10:50 -0500
X-MC-Unique: Rc9jXf0iPhaW1aFZOEOV7w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9d25d0788b8so375472266b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351849; x=1699956649;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x7k04BtIMbJcMeHwiSPKgGrolXanjKZR9xU+A1o+1Wc=;
 b=PB0H2pp1hDrJGWCUc1lPDlXWltbStOEIEYZTIq22GFob6krAlbMrkTa9zGtd5RC78F
 ixKt14liPh7s/aXPhGDPYPAAofNO/hZ4wu9l+BiGvzo96+aUGMqk+mjfvVp6C8LNSY3W
 OWv1ZVnvd0dt1DxxLd5/UeBH2ngqXhbVU3E6QkDBAVlxQlfXcD2oDhQsbNuX79W5BwwT
 7zEW/8c51Y6KafVOQ54JdN7zX/FCVaqsaeN5oFOnt60btvCtOYtjFxaIJGN93B0FsNp6
 y2jwlbFIIO4syGIPWymburDThnvRZJpNDifSWn4iP4h0MXZ/zgoMrV0VlBADt732czR6
 6gwQ==
X-Gm-Message-State: AOJu0YwuQhXMBFzk71zjZ2npZrRaelqk6Vhfk8Pu6k2QrNacI+4kNtj5
 MMmj/aH1LfpXSchZrlwbIfo8+UYIyVRi7eSXsEXtiUFFKYWZ9hJk+7Ul3/0FjsY3hg7deOjhVAA
 vBGUV1+56CqGVs5ayEL6geJPsy+yJsAXjUTCBKoQ++EDmVXPJPBWIUu3Sgd8TETR8UgeM
X-Received: by 2002:a17:906:c7d8:b0:9da:f85a:233f with SMTP id
 dc24-20020a170906c7d800b009daf85a233fmr10951956ejb.28.1699351849107; 
 Tue, 07 Nov 2023 02:10:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFraU5mPUAEBw0M1zbMP5GtrTI+OPHh6L/aDH1tkNT0Ml2efn66JzrE9c2yQ1Aczjm0Z/0PSA==
X-Received: by 2002:a17:906:c7d8:b0:9da:f85a:233f with SMTP id
 dc24-20020a170906c7d800b009daf85a233fmr10951931ejb.28.1699351848661; 
 Tue, 07 Nov 2023 02:10:48 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 h22-20020a05600c351600b004094c5d929asm15082065wmq.10.2023.11.07.02.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:10:48 -0800 (PST)
Date: Tue, 7 Nov 2023 05:10:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 17/63] virtio-sound: implement audio capture (RX)
Message-ID: <d8d64acbecfa131153e5b96fb24b4f95f55be881.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

To perform audio capture we duplicate the TX logic of the previous
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU's audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <e56a17741a24ccadfbbea19d3c60c9406b795b23.1698062525.git.manos.pitsidianakis@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/audio/virtio-snd.c | 262 ++++++++++++++++++++++++++++++++++++------
 hw/audio/trace-events |   3 +-
 2 files changed, 230 insertions(+), 35 deletions(-)

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
-- 
MST


