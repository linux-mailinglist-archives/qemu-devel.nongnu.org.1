Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254AE758419
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLp4O-0002UZ-C1; Tue, 18 Jul 2023 14:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp4L-0002U7-V9
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:05:05 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qLp4E-0003dT-9W
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 14:05:05 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso55504565e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689703496; x=1692295496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zx8uq49oHkgSI/UJwFTbSARepMINV4QEHH/jTkJg610=;
 b=DI6S8ftNMAn8U/wtVPWdWJ1kPJdoA+BIX5VrpptIKbjxYSr0+BhmEpJHngGoCv3Ede
 MO/+FYPGdfEunZ3jOZ20RJGDJglo8CDW3IG9SiMwwu9Y7LEnITqQnPlHEkh8ap7IjzQD
 /M+WMUWoCVYK1C5LWBcg5FSsUaa+a+fZ5OHaV9iSIt4omnRs7HKbxyZ7lcjtG64cewSw
 uvb5a8+3canbOpIuDvluiDPyvBygi4Ut3rwDAMVea5psJv69Oj2KiMExd96aKewh2RbY
 f5Q00faDSAXrMQYnt2wd640hGBwpljyFUk3Z1QTJuzPnkUV/OHuLXtDsBpat2yG65isX
 dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689703496; x=1692295496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zx8uq49oHkgSI/UJwFTbSARepMINV4QEHH/jTkJg610=;
 b=F/zFL0UBSKFRzRKIJfue5bymQt8BHgc7qSi5gGmXw6uq6RxuZBjTVGuS0r3DGPpQOU
 eBWiUWvJyEdUYeTYr5Uw7ECxplBZtYoqPo9DMMI2KcWs/rkRZu9a/5E6xNuj1ZaXK0kD
 F6ct/oAz1ixovYpVTWhdMZVIImj1C15Ujkzzuq3ezkMhe4/0u1L75ud3x0ppJiBB16CZ
 +c1fsy/ZyR9ug8Awyf4UGqs4jNmEYjfVwNKHjWia/VL+rXpIrfx9cyhx6kPzJBZA8HUk
 q8uwaOdwLxgaPOBfJ0QZcGuwsHIXuGd37TDYI+BQANBscyLpCcFFES7XL6jdF8K4aB0l
 P1qw==
X-Gm-Message-State: ABy/qLaC0OZW8iCPZgtQaPMR/zuccyQHfmjZcBCUasgh7LZA/faBY2AY
 aPByENI3mLQVzyNnq87k9lEuPo5plFDAw3G1qTtSyOyC
X-Google-Smtp-Source: APBJJlESafjdvcmP9WiAPerJZu6562Qgfota32RjZUD7mp+csrSJjX/GlkOI5ZF/a0h3l8nEVL6Gzw==
X-Received: by 2002:a05:600c:259:b0:3f8:facf:7626 with SMTP id
 25-20020a05600c025900b003f8facf7626mr2623430wmj.20.1689703496204; 
 Tue, 18 Jul 2023 11:04:56 -0700 (PDT)
Received: from localhost.localdomain (adsl-17.37.6.3.tellas.gr. [37.6.3.17])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bca49000000b003fc17e8a1efsm10764311wml.45.2023.07.18.11.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 11:04:55 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
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
 "Alex Bennee" <alex.bennee@linaro.org>
Subject: [PATCH v3 3/3] Implement audio capture in virtio-snd device
Date: Tue, 18 Jul 2023 21:04:16 +0300
Message-Id: <8d432c85a2f04e5c30ede937626d5605ccc42892.1689692765.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689692765.git.manos.pitsidianakis@linaro.org>
References: <cover.1689692765.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 238 +++++++++++++++++++++++++++++++++++------
 2 files changed, 205 insertions(+), 36 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 8f3953dc28..3e7b259aef 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -165,7 +165,8 @@ virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS called f
 virtio_snd_handle_pcm_start_stop(const char *code, int stream) "%s called for stream %d"
 virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called for stream %d"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
-virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_tx_xfer(void) "tx queue callback called"
+virtio_snd_handle_rx_xfer(void) "rx queue callback called"
 virtio_snd_handle_event(void) "event queue callback called"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index dbf8d8162f..a6ac9d8ce0 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -27,7 +27,7 @@
 #define VIRTIO_SOUND_VM_VERSION 1
 
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 
 #define VIRTIO_SOUND_HDA_FN_NID 0
@@ -114,12 +114,16 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 }
 
 static void virtio_snd_process_cmdq(VirtIOSound *s);
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_out_cb(void *data, int available);
-static uint32_t virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+static void virtio_snd_pcm_in_cb(void *data, int available);
+static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
                                           VirtQueue *vq,
-                                          VirtQueueElement *element,
-                                          bool read);
+                                          VirtQueueElement *element);
+static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
+                                          VirtQueue *vq,
+                                          VirtQueueElement *element);
 
 /*
  * Get a specific stream from the virtio sound card device.
@@ -421,15 +425,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
                                          &as);
 
     } else {
-        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
-        /*
-         * stream->voice.in = AUD_open_in(&s->card,
-         *                                stream->voice.in,
-         *                                "virtio_snd_card",
-         *                                stream,
-         *                                virtio_snd_input_cb,
-         *                                &as);
-         */
+        stream->voice.in = AUD_open_in(&s->card,
+                                        stream->voice.in,
+                                        "virtio_snd_card",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &as);
     }
 
     stream->as = as;
@@ -502,6 +503,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %d", req.stream_id);
@@ -552,7 +555,11 @@ static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
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
 
     return VIRTIO_SND_S_OK;
@@ -738,7 +745,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -747,7 +754,7 @@ static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp = { 0 };
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -771,11 +778,11 @@ static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
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
@@ -804,6 +811,57 @@ tx_err:
     virtio_notify(VIRTIO_DEVICE(s), vq);
 }
 
+/*
+ * The rx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: tx virtqueue
+ */
+static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream = NULL;
+    VirtQueueElement *elem;
+    size_t sz;
+    virtio_snd_pcm_xfer hdr;
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
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+            continue;
+        }
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            virtio_snd_pcm_read(stream, vq, elem);
+        }
+    }
+
+    /*
+     * Notify vq about virtio_snd_pcm_status responses.
+     * Buffer responses must be notified separately later.
+     */
+    virtio_notify(VIRTIO_DEVICE(s), vq);
+}
+
+
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
 {
@@ -929,8 +987,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_xfer,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx_xfer,
+                              virtio_snd_handle_rx_xfer,
                               &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -985,26 +1043,119 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
+    int size;
 
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
+                if (size == 0 || block->size == stream->period_bytes) {
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
+                                     &block->data,
+                                     block->size);
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
 /*
  * Close the sound card.
  *
@@ -1047,10 +1198,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 
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
@@ -1072,6 +1222,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
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


