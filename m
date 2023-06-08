Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8A472845B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7I0O-0005bk-SW; Thu, 08 Jun 2023 11:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0L-0005a0-1q
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q7I0I-0000Wm-0O
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:56:52 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f7f6341bf9so7269785e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686239808; x=1688831808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+St/cNjhfZOYAVPddWdTAJq1qrsE4cJ+BFd3Ppf/lg=;
 b=elbwwQ2f3lf+gNIDfwt3iSe1c5TXFIAXi66Oxqry9mmAautH4PyuS4mNbC9QwYPxbq
 g5Nxxz6SpHx+aDRp5yz3MYTH2vlGk8cWji2El1arDsGdnGepfd3WQNLxmNylMAv1Ps81
 PmA1mS79ohFAEwq4v1B9BainJ+MuGpQGeW6ITl16XPCqV6mK55tOLL+7wFzfcwyxV7yN
 79QCy9fO3T7uUTQfUmSL0hvM1InB7q2PA/4B62wr+lmH8C5mzRy6Op/NugvPR0fRN7Ll
 95gJfzljAQX3uC6TuQ95iuFwN5cJtbAhSx5Sk+W+gA3RPUj8a8AGT64nnhutOykiI61f
 62Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686239808; x=1688831808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+St/cNjhfZOYAVPddWdTAJq1qrsE4cJ+BFd3Ppf/lg=;
 b=BEK7VpYtChObopOTbYDh8rLxU48k9P349aa8FHQSZ3l/EFQzSkrTWHz9eqlthkXdYV
 8r3z6VjjGYD8mPixc5bwQh+MG5yu01KDp6NIZnuABZADSO0HNbTQWV73j2MFMdeeE7ew
 uR2PpYG2L/P3y8ITVyDzX3UaLIiT1q41YfjeeHFx5X8PirVdrohn3IWo4tOy3GL+XdDX
 n7Ja9kobID/jQwRSxXg3+IpjwJzynfYlKvAOr5AMTqyBtXMNkx2okSIKL8eljsDmSOwv
 0hFJOqmYjep6pl5jGMCcXnxQUVoA56NA0AY1ItgbnWjEtdSAA41mVlahqKFsdr8YsFWA
 /DrQ==
X-Gm-Message-State: AC+VfDz3nLd45Dz+/hZBwq+/BPXuj84uhM1ezVfRMT9UzO/st4CBFwFT
 WQ1a8akL3crhT8c9vxKElRvVv/PeJJ6Ypcjquqc=
X-Google-Smtp-Source: ACHHUZ4PZDkAAKmAizdC2u7bMzYBAaacmmkl2Q5dZe03Q19K2cYQ1fVW4JM5nPZjcfWmEp7VLiw9pw==
X-Received: by 2002:a05:600c:364b:b0:3f1:93c2:4df7 with SMTP id
 y11-20020a05600c364b00b003f193c24df7mr1656483wmq.5.1686239808244; 
 Thu, 08 Jun 2023 08:56:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-175.37.6.3.tellas.gr. [37.6.3.175])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb51000000b00307bc4e39e5sm1927105wrs.117.2023.06.08.08.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:56:48 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Subject: [PATCH v2 3/3] Implement audio capture in virtio-snd device
Date: Thu,  8 Jun 2023 18:56:19 +0300
Message-Id: <4c130f066d87fd9dce82dfdae7c4bb3b2fbc5ffd.1686238728.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
 hw/virtio/virtio-snd.c | 239 +++++++++++++++++++++++++++++++++++------
 2 files changed, 206 insertions(+), 36 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b77d78abdc..b58c007297 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -162,7 +162,8 @@ virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS called f
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
index e3b6c353ad..fe7d70ff06 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -25,7 +25,7 @@
 #define VIRTIO_SOUND_VM_VERSION 1
 
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 
 #define VIRTIO_SOUND_HDA_FN_NID 0
@@ -89,12 +89,16 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
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
@@ -450,15 +454,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -522,6 +523,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
@@ -573,7 +576,11 @@ static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
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
@@ -754,7 +761,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -763,7 +770,7 @@ static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp = { 0 };
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -780,11 +787,11 @@ static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
         stream = s->pcm->streams[hdr.stream_id];
         assert(stream);
 
+        assert(hdr.stream_id != VIRTIO_SND_D_INPUT);
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            virtio_snd_pcm_read_write(stream,
+            virtio_snd_pcm_write(stream,
                     vq,
-                    elem,
-                    hdr.stream_id == VIRTIO_SND_D_INPUT);
+                    elem);
 
             resp.status = VIRTIO_SND_S_OK;
             sz = iov_from_buf(elem->in_sg,
@@ -803,6 +810,53 @@ static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
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
+        assert(sz == sizeof(hdr));
+        stream = s->pcm->streams[hdr.stream_id];
+        assert(stream);
+
+        assert(hdr.stream_id == VIRTIO_SND_D_INPUT);
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            virtio_snd_pcm_read(stream, vq, elem);
+
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
@@ -928,8 +982,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
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
@@ -984,26 +1038,124 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
+            assert(block != NULL);
+
+            for (;;) {
+                size = AUD_read(stream->voice.in,
+                        block->data + block->offset,
+                        MIN(stream->period_bytes - block->offset, available));
+                block->offset += size;
+                block->size += size;
+                if (size == 0 || block->size == stream->period_bytes) {
+                    resp.status = VIRTIO_SND_S_OK;
+                    sz = iov_from_buf(block->elem->in_sg,
+                            block->elem->in_num,
+                            0,
+                            &resp,
+                            sizeof(resp));
+                    assert(sz == sizeof(virtio_snd_pcm_status));
+
+                    /* Copy data -if any- to guest */
+                    if (block->size) {
+                        sz = iov_from_buf(block->elem->in_sg,
+                                block->elem->in_num,
+                                sz,
+                                &block->data,
+                                block->size);
+                        assert(sz <= stream->period_bytes);
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
+    uint32_t sz;
+    virtio_snd_pcm_flush(
+            sz = iov_from_buf(block->elem->in_sg,
+                block->elem->in_num,
+                sizeof(virtio_snd_pcm_info),
+                block->data,
+                block->offset);
+            assert(sz <= block->size);
+            );
+}
+
 /*
  * Close the sound card.
  *
@@ -1046,10 +1198,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 
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
@@ -1072,6 +1223,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
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


