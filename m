Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB077CA07
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq2o-0005Xf-En; Tue, 15 Aug 2023 05:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2m-0005XO-I9
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:52 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq2j-0005Er-Mq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:08:52 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b9ab1725bbso77672161fa.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090527; x=1692695327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofM2odEIxyRL00ytFovoy0wmuXXILP1hZG+q9jKhe/8=;
 b=ZilTF7/uetsSmMrFc/kmqDn7c3+iyWBHWoR5c3qBmUFm1U+irCthQVnrrLzCs4aUVa
 2Ujs44QMQwiTQr1VI64EolXNSHHvxtVt2meMIMyiBjGzRn966efIwHxEyBIwPYQWrcAq
 z+XzLOIEE0KN5f+bPe8drO+9rURFn3IrDbYfNVnwjrS836so3Sa68x+GAU6xrmVlma/v
 bxprLdYVafmdja1iJ2MtffdRer2+7H5iiiDIEUMb7/mjIRf3wIYnCDpA+TWvzxON2uQP
 YoOky0BeDRVGY8llVo6ncT3zRhP/ug+4vKzsBXAsiWvSoqiTletqovBYL+HpUfvm20Ku
 j+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090527; x=1692695327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ofM2odEIxyRL00ytFovoy0wmuXXILP1hZG+q9jKhe/8=;
 b=aA+qjwmLDamgST5b17ACNnrQjnfJfHn85YDdqz6WLOiVYb46QbH1DKJYnvqAhQF+iA
 Kr8XKSqPIktqKa7Yc20o4jfHvcqeymQrJjopNTOC2wGVqdTUHeWVOw1fI/wtWzgEqOZ2
 xHpuzStZakHlqfngoH8QZT9GvwTWo0sypYYQUBEOfDmeMr8W9sXJ7E3/EvI/diqWSk0d
 Z8S1DJxq5lLNSG5ljYjGu5OkxaEEGiCH0qr010KODBsSyvRZfAbjn8FFLBcxC8jcfEoZ
 LXP63P8hMsb388pDr2YuxGlM4j5ntg6QO/BmqO0IaNtfSxntvAVkosh3NeP30Ia+72uh
 l5Lw==
X-Gm-Message-State: AOJu0YypPF+HxQ4DXAOkD1KudJPPaKUsUEbs9+g2zRHK7gkNwRxI4NYr
 5FH6JEy6UKstRDrpI7kp8zbb3vxMRcz3MIdPRBw=
X-Google-Smtp-Source: AGHT+IE/33xLbEo5YqUcX07VlbJQio8ZMH112BiCF7wkMCHVwRamaKOxS+uXwiVdLftDwPZzCiec8A==
X-Received: by 2002:a2e:7d15:0:b0:2b6:e2c1:6cdb with SMTP id
 y21-20020a2e7d15000000b002b6e2c16cdbmr8755676ljc.51.1692090527635; 
 Tue, 15 Aug 2023 02:08:47 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:08:47 -0700 (PDT)
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
Subject: [PATCH v6 11/12] virtio-sound: implement audio capture (RX)
Date: Tue, 15 Aug 2023 12:07:16 +0300
Message-Id: <5e8f4234992411e49af618d1500581713f6d1621.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22d.google.com
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
 hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++------
 2 files changed, 203 insertions(+), 33 deletions(-)

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
index 926f6bbf62..b3e175a03c 100644
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
@@ -403,6 +406,9 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->direction == VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
         qemu_mutex_destroy(&stream->queue_mutex);
         g_free(stream);
@@ -465,7 +471,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -530,6 +541,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     if (stream) {
         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
@@ -601,7 +614,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
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
@@ -760,7 +777,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
@@ -769,7 +786,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp = { 0 };
 
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -793,11 +810,11 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
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
@@ -827,12 +844,54 @@ tx_err:
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
@@ -961,8 +1020,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_tx,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx_xfer,
+                              virtio_snd_handle_rx_xfer,
                               errp);
 }
 
@@ -1013,26 +1072,119 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
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
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1068,10 +1220,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
 
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
@@ -1093,6 +1244,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
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


