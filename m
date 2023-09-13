Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110E79E0EB
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOh-0006iw-54; Wed, 13 Sep 2023 03:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOf-0006iV-Qg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:49 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOa-0001sG-EX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:49 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31f853f2f3aso370657f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590482; x=1695195282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sodW5fl8SJJElaJhBZlr6sQlCCQfVh5fdgOPeC7rrTc=;
 b=D+w6IRzxUqI/HxSGGJBZWw2xgcCVvHwd2pPfbVYer4/HhPuBQIczuho+QqVeOIrXLN
 R4SqtD1QgckEGHmkQDsxpOpJNk9x+izM2qbld6ZbyptczbcOYor+rdJbBx+F9AC0ixbf
 M7PYAr15ipv0pkoTy5H518FkT8X4NDZMS/s5vqU2bZVSoiSjfYfVu5eowXEfr8p8Wp5k
 TNWEIOECi0CEaziVqmvsTTp7r0RAdX71Nygjnu/Q5ek5qmXaRgsyB2oYpB64LJvsrT0a
 jD2J+/bnrvNfSthD3NYE56Q6cTYUcgVNwSxYxeO8To9FVMUBkLD4xa5t22H+O6w8BQ/D
 3keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590482; x=1695195282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sodW5fl8SJJElaJhBZlr6sQlCCQfVh5fdgOPeC7rrTc=;
 b=MgbEh3nYaIKg7CEuagvQJH6DlWEm97BkS32EYoQ26vQ+zHSEhgWGNEJ9s2rcgfC3R9
 fZvTIkheryO0UTzWAcBZz2i1o16GxBycFV07FyJsm/wcVyR8veybqMfia9fruG7rQxri
 kI3aqqgRFQWilWWfpm8+WG4ZdospBaccog5LdXnTs9eIgvl+tYjjep9DPNviSXKYRIh8
 Q5dFb14i+GKOZ8vA/P0ELkbBPPg0lrVVKUpAZjSSUmxvvute02fq4FRJs8EWk0j4OpHB
 3DsijV+0gU1P4FyvoR4JfL3+xiHvbq9KRiZAk3kteG4eGq1VLuivS3ZuSQozCS1cYq7/
 VFEw==
X-Gm-Message-State: AOJu0YxwmHbu4zhMlrJsGm9QeggKV/Q3kgoYeVZ4LZEMPvMPvbcLdFl4
 2Vws+7WZ2iytGR+fCp0SZwbuKvaturfjx1wUqOU=
X-Google-Smtp-Source: AGHT+IEb5eJJuWOihX125cILtuL5tQ8cAGXf0/HIJVOeHVoNIqkumEd6sqd1QRcK1ckpzfxnKtBHgg==
X-Received: by 2002:a05:6000:11c9:b0:31f:afeb:4e7d with SMTP id
 i9-20020a05600011c900b0031fafeb4e7dmr1255271wrx.18.1694590482352; 
 Wed, 13 Sep 2023 00:34:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:41 -0700 (PDT)
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
Subject: [PATCH v9 10/12] virtio-sound: implement audio output (TX)
Date: Wed, 13 Sep 2023 10:33:17 +0300
Message-Id: <d17866a331b096f26a046e6be70201f31887a8a1.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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

Handle output IO messages in the transmit (TX) virtqueue.

It allocates a VirtIOSoundPCMBlock for each IO message and copies the
data buffer to it. When the IO buffer is written to the host's sound
card, the guest will be notified that it has been consumed.

The lifetime of an IO message is:

1. Guest sends IO message to TX virtqueue.
2. QEMU adds it to the appropriate stream's IO buffer queue.
3. Sometime later, the host audio backend calls the output callback,
   virtio_snd_pcm_out_cb(), which is defined with an AUD_open_out()
   call. The callback gets an available number of bytes the backend can
   receive. Then it writes data from the IO buffer queue to the backend.
   If at any time a buffer is exhausted, it is returned to the guest as
   completed.
4. If the guest releases the stream, its buffer queue is flushed by
   attempting to write any leftover data to the audio backend and
   releasing all IO messages back to the guest. This is how according to
   the spec the guest knows the release was successful.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events         |   2 +
 hw/virtio/virtio-snd.c         | 267 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h |  11 ++
 3 files changed, 275 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 60ab62a80d..3b95e745c2 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -171,3 +171,5 @@ virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called fo
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
+virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
+virtio_snd_handle_xfer(void) "tx/rx queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index ba554bc62c..6fe03f9790 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -47,6 +47,10 @@ static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
     return val;
 }
 
+static void virtio_snd_pcm_out_cb(void *data, int available);
+static void virtio_snd_process_cmdq(VirtIOSound *s);
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
                                   | BIT(VIRTIO_SND_PCM_FMT_S16)
@@ -128,6 +132,13 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
 }
 
+static void
+virtio_snd_pcm_block_free(VirtIOSoundPCMBlock *block)
+{
+    g_free(block->elem);
+    g_free(block);
+}
+
 static void
 virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
 {
@@ -370,6 +381,25 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
+    VirtIOSoundPCMBlock *block, *next;
+
+    if (stream) {
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+                virtqueue_push(block->vq,
+                        block->elem,
+                        sizeof(block->elem));
+                virtio_notify(VIRTIO_DEVICE(stream->s),
+                        block->vq);
+                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                virtio_snd_pcm_block_free(block);
+            }
+        }
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+            stream->voice.out = NULL;
+        }
+    }
 }
 
 /*
@@ -426,6 +456,18 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
     stream->as = as;
 
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = AUD_open_out(&s->card,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &as);
+        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+    }
+
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -486,6 +528,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              bool start)
 {
     VirtIOSoundPCMStream *stream;
+    VirtIOSoundPCMBlock *block, *next;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
@@ -503,16 +546,50 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
             "VIRTIO_SND_R_PCM_STOP", stream_id);
+
     stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (!stream) {
-        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+    if (stream) {
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_set_active_out(stream->voice.out, start);
+        }
+        /* remove previous buffers. */
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+                virtqueue_push(block->vq,
+                               block->elem,
+                               sizeof(block->elem));
+                virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
+                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                virtio_snd_pcm_block_free(block);
+            }
+        }
+    } else {
+        error_report("Invalid stream id: %"PRIu32, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 }
 
 /*
- * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
- * a stream.
+ * Returns the number of I/O messages that are being processed.
+ *
+ * @stream: VirtIOSoundPCMStream
+ */
+static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+    size_t count = 0;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            count += 1;
+        }
+    }
+    return count;
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
@@ -544,6 +621,22 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
+
+    if (virtio_snd_pcm_get_io_msgs_count(stream)) {
+        /*
+         * virtio-v1.2-csd01, 5.14.6.6.5.1,
+         * Device Requirements: Stream Release
+         *
+         * - The device MUST complete all pending I/O messages for the
+         *   specified stream ID.
+         * - The device MUST NOT complete the control request while there
+         *   are pending I/O messages for the specified stream ID.
+         */
+        virtio_snd_process_cmdq(stream->s);
+        trace_virtio_snd_pcm_stream_flush(stream_id);
+        virtio_snd_pcm_flush(stream);
+    }
+
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -695,6 +788,91 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
     trace_virtio_snd_handle_event();
 }
 
+/*
+ * The tx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: tx virtqueue
+ */
+static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
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
+    trace_virtio_snd_handle_xfer();
+
+    for (;;) {
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        /* get the message hdr object */
+        msg_sz = iov_to_buf(elem->out_sg,
+                        elem->out_num,
+                        0,
+                        &hdr,
+                        sizeof(hdr));
+        if (msg_sz != sizeof(hdr)) {
+            goto tx_err;
+        }
+        stream_id = le32_to_cpu(hdr.stream_id);
+
+        if (stream_id >= s->snd_conf.streams
+            || !s->pcm->streams[stream_id]) {
+            goto tx_err;
+        }
+
+        stream = s->pcm->streams[stream_id];
+        if (!stream || stream->info.direction != VIRTIO_SND_D_OUTPUT) {
+            goto tx_err;
+        }
+
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            size = iov_size(elem->out_sg, elem->out_num) -
+                sizeof(virtio_snd_pcm_xfer);
+            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
+            block->elem = elem;
+            block->vq = vq;
+            block->size = size;
+            block->offset = 0;
+
+            iov_to_buf(elem->out_sg,
+                    elem->out_num,
+                    sizeof(virtio_snd_pcm_xfer),
+                    block->data,
+                    size);
+
+            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
+        }
+        continue;
+
+tx_err:
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+            iov_from_buf(elem->in_sg,
+                         elem->in_num,
+                         0,
+                         &resp,
+                         sizeof(resp));
+            virtqueue_push(vq, elem, sizeof(elem));
+            break;
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
 /*
  * Stub buffer virtqueue handler.
  *
@@ -787,7 +965,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
@@ -811,6 +989,85 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     }
 }
 
+/*
+ * AUD_* output callback.
+ *
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be written with AUD_write()
+ */
+static void virtio_snd_pcm_out_cb(void *data, int available)
+{
+    VirtIOSoundPCMStream *stream = data;
+    VirtIOSoundPCMBlock *block;
+    size_t size;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            block = QSIMPLEQ_FIRST(&stream->queue);
+
+            for (;;) {
+                size = AUD_write(stream->voice.out,
+                                 block->data + block->offset,
+                                 MIN(block->size, available));
+                assert(size <= MIN(block->size, available));
+                if (size == 0) {
+                    /* break out of both loops */
+                    available = 0;
+                    break;
+                }
+                block->size -= size;
+                block->offset += size;
+                available -= size;
+                if (!block->size) {
+                    virtio_snd_pcm_status resp = { 0 };
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+                    resp.latency_bytes = 0;
+                    iov_from_buf(block->elem->in_sg,
+                                 block->elem->in_num,
+                                 0,
+                                 &resp,
+                                 sizeof(resp));
+                    virtqueue_push(block->vq,
+                                   block->elem,
+                                   sizeof(block->elem));
+                    virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
+                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                    virtio_snd_pcm_block_free(block);
+                    break;
+                }
+
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
+ * Flush all buffer data from this stream's queue into the driver's virtual
+ * queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            AUD_write(stream->voice.out, block->data + block->offset, block->size);
+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
+            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
+        }
+    }
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index 6642abb4e9..f60689009c 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -77,6 +77,17 @@ typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
 
 typedef struct VirtIOSoundPCM VirtIOSoundPCM;
 
+typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
+
+struct VirtIOSoundPCMBlock {
+    QSIMPLEQ_ENTRY(VirtIOSoundPCMBlock) entry;
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    size_t size;
+    uint64_t offset;
+    uint8_t data[];
+};
+
 struct VirtIOSoundPCM {
     VirtIOSound *snd;
     virtio_snd_pcm_set_params *pcm_params;
-- 
2.39.2


