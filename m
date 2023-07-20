Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A6275AEF2
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTFA-00070o-9j; Thu, 20 Jul 2023 08:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTF8-0006x4-ON
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEw-0004gj-EU
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso5165045e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857920; x=1690462720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rlc4/bZY1atq5k/gBLdHXzivnoy0MLFLopl4wrA30pU=;
 b=pkAebfsTDYVEnRo92puq2TfyAeEBWdt9l01YXv/HqGuKR9ch1E3QBDjZZ64JBJSxn0
 9qhf83YDomxocmiPAwMZrz1ROlTeMZczGUivi8X9aY6EAuiKKJzCcX/ClN74br7mq+qU
 rFUQjjNUY7TweClA3XUjcspPL/aRIroQ2JZwTY79tJThJdOR3PV7+piVkanYHnL34iU7
 cNejotwOqnoeQeg/Mvpx5Bh2YGpqtmkP+4fyaUninpsARUaaR2u44Mxqtb3xkiseA0+j
 c7PpqJgYERHr2dyOmqOYIoZSPgiW73f0pPZc2cwt0Fo1TUiVKNFdgzMlBzF2GeDax1A+
 IpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857920; x=1690462720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rlc4/bZY1atq5k/gBLdHXzivnoy0MLFLopl4wrA30pU=;
 b=kvWSyrKJnqEQZXA7lkicyBOn/3eAFKzcLvuJu+ZrgSY6loAT1Nq4qmKrl3gfFFy30M
 whqTL2asvcYKUBuocfL5DYI3ZZc1VCfQU1PlLnYYHQHefra3d2CIabIMdTh9D3Il7S4z
 hldljh7/WLtiZVu+4yeqQVJVdQvVxoo98/mwlgTVYqN4m8+Sp2yJkdwawMr8fLfDmKix
 ZYgQFFe1OV8Oyz1MWc3niwCNNlu61wWZhSVD4veqec0fEa0ZKeUicUCRYVss6z3Tl+XF
 27NAjYrtez45/FwsyUYdnrtEf7G4w2xXzRmTpxWZSkz9Bxc3ZvYhJmrYseEknYdom0TV
 Cz5g==
X-Gm-Message-State: ABy/qLavh4PWuiPs/qLUMDgmIP8QFKj/GW5nYUpAN2F612J+7etlOFmn
 3S5XioauPMl4kCRbf1PHXPnZJmaMTE1ZGvmY2sk4Gw==
X-Google-Smtp-Source: APBJJlHSRGiDBv3Er7aLY5wBzKCCrXwAhHYfRVkPjoo6FbVNXfEXvrGSwpdLL1diRP87T6jNDvJ12A==
X-Received: by 2002:a05:600c:204:b0:3fc:6e8:d675 with SMTP id
 4-20020a05600c020400b003fc06e8d675mr4533955wmi.13.1689857920113; 
 Thu, 20 Jul 2023 05:58:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:58:39 -0700 (PDT)
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
 "Alex Bennee" <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/12] virtio-sound: implement audio capture (RX)
Date: Thu, 20 Jul 2023 15:57:13 +0300
Message-Id: <1abb69dd05d18f9966bd7a959013dbc1ed07e627.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

To perform audio capture we duplicate the TX logic of the previous
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU's audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 230 +++++++++++++++++++++++++++++++++++------
 2 files changed, 200 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3b95e745c2..a5829b112c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
 virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
-virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_tx_xfer(void) "tx queue callback called"
+virtio_snd_handle_rx_xfer(void) "tx queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 21983d9b8c..0643246434 100644
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
@@ -433,7 +436,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
                                          virtio_snd_pcm_out_cb,
                                          &as);
     } else {
-        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+        stream->voice.in = AUD_open_in(&s->card,
+                                        stream->voice.in,
+                                        "virtio_snd_card",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &as);
     }
 
     stream->as = as;
@@ -498,6 +506,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
@@ -547,7 +557,11 @@ static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
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
@@ -741,7 +755,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -750,7 +764,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp = { 0 };
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -774,11 +788,11 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
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
@@ -808,12 +822,54 @@ tx_err:
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
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -937,8 +993,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_tx,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx_xfer,
+                              virtio_snd_handle_rx_xfer,
                               &err);
     if (err != NULL) {
         error_propagate(errp, err);
@@ -992,26 +1048,119 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
+                                     &block->data,
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
 /*
  * Close the sound card.
  *
@@ -1061,10 +1210,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 
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
@@ -1086,6 +1234,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
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


