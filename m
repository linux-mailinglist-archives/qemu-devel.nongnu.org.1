Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE5078B8C6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLg-0002vt-5v; Mon, 28 Aug 2023 15:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLW-0002sm-Jv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:24 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiLT-0005KK-Dn
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:56:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31c8321c48fso1833100f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252577; x=1693857377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDRiNSMVjJ6yGS6A9FZItA4JGsX7SO8ahZ1HTIb5ALM=;
 b=f2GoXc+TxikavIByckc3LQGkFx2R7dVcBe3MsneyiNyBAF5BvxlnYY4g9W0r3Xv4pW
 xyRbAqbpZVmqYjAQYXT3i0I8iduCgpJiZW6rAfI4cjfk68spGVPfX5POaZzIrh4eDYhe
 Xk2qt/z5kNHT6z4+BGbvLefb73+dLR5lU/ankelKjDrgK7JKXrIyfqwA70oD/ccaq6eo
 DKcPAU/6ylCpGnr06ung9vDwkLt05uQ905yPQgPTiN8fK/WEHlAkZOOQEO3rS4EC1rXF
 GZo3CIdhHqVZo9Wrmr51HEoU8d04RKH4//MGhduplSTcs31ghTP2zAewj51J/jPM7WP4
 crfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252577; x=1693857377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDRiNSMVjJ6yGS6A9FZItA4JGsX7SO8ahZ1HTIb5ALM=;
 b=JuSvbhj+rFsc1qRFUByRhmAAAA3fRPMauBvq0dAIa7QALPHjYBE0YoQ2m0Td8LdS2b
 mPpd/PcbSAlE1TSYUyDFQgd8yhvFiy7Zq9V95afOEvpNXdi+V8IFfrOYAZdGMdXEf4y7
 vtKCSESO2hOchsF/pQlK6rKMJaDXK2xmSC49RSZxOiJSrke9eujyK3ce5NV2MZVSU+Y4
 Ktvky5HPf4clLB1M0xsJ10/0uF8qRfpM5CvC00OCb02tAr1c++y7jXwKR707Sg0gFfCV
 v/UkRqpAFnwwEnDRRHZEhGJDrZlovYdYEevZktMkFaEXXbCyilzh2LK8AvLnCn+5n3s1
 tLSg==
X-Gm-Message-State: AOJu0YzKL0550CqadfYeoqVwEgU1IpV+ePg/SMjZvph50xH+8B637TJL
 9zY5PswipCgw2lxQnZbzvzY7mPLCYw5KR6vA56g=
X-Google-Smtp-Source: AGHT+IHb3cm79Y86GwiunXNFlt1BynrJ2QVJfpopupRku5FyhuXWbm/cM5Tm3aghrmBh3n1G/E80Xw==
X-Received: by 2002:a5d:4a89:0:b0:31d:cb4b:ccd3 with SMTP id
 o9-20020a5d4a89000000b0031dcb4bccd3mr363421wrq.21.1693252577184; 
 Mon, 28 Aug 2023 12:56:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:56:16 -0700 (PDT)
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
Subject: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
Date: Mon, 28 Aug 2023 22:55:07 +0300
Message-Id: <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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
 hw/virtio/virtio-snd.c         | 262 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h |  11 ++
 3 files changed, 271 insertions(+), 4 deletions(-)

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
index e4fc832c39..4859ce4bf6 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -31,6 +31,15 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+static void virtio_snd_pcm_out_cb(void *data, int available);
+static void virtio_snd_process_cmdq(VirtIOSound *s);
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static uint32_t
+virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+                          VirtQueue *vq,
+                          VirtQueueElement *element,
+                          bool read);
+
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
                                   | BIT(VIRTIO_SND_PCM_FMT_S16)
@@ -368,7 +377,24 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
+    VirtIOSoundPCMBlock *block, *next;
+
     if (stream) {
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+                virtqueue_push(block->vq,
+                        block->elem,
+                        sizeof(block->elem));
+                virtio_notify(VIRTIO_DEVICE(stream->s),
+                        block->vq);
+                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
+                g_free(block);
+            }
+        }
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+            stream->voice.out = NULL;
+        }
         qemu_mutex_destroy(&stream->queue_mutex);
         g_free(stream);
     }
@@ -422,6 +448,17 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
 
+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = AUD_open_out(&s->card,
+                                         stream->voice.out,
+                                         "virtio-sound.out",
+                                         stream,
+                                         virtio_snd_pcm_out_cb,
+                                         &as);
+    } else {
+        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+    }
+
     stream->as = as;
     stream->desired_as = stream->as;
     qemu_mutex_init(&stream->queue_mutex);
@@ -465,6 +502,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              bool start)
 {
     VirtIOSoundPCMStream *stream;
+    VirtIOSoundPCMBlock *block, *next;
     virtio_snd_pcm_hdr req;
     size_t sz = iov_to_buf(cmd->elem->out_sg,
                            cmd->elem->out_num,
@@ -481,15 +519,48 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
             "VIRTIO_SND_R_PCM_STOP", req.stream_id);
 
     stream = virtio_snd_pcm_get_stream(s, req.stream_id);
-    if (!stream) {
+    if (stream) {
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
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
+                g_free(block);
+            }
+        }
+    } else {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
     }
 }
 
 /*
- * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
- * a stream.
+ * Returns the number of I/O messages that are being processed.
+ *
+ * @stream: VirtIOSoundPCMStream
+ */
+static size_t virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+    size_t size = 0;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            size += 1;
+        }
+    }
+    return size;
+}
+
+/*
+ * Handles VIRTIO_SND_R_PCM_RELEASE.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
@@ -520,6 +591,22 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
         return;
     }
+
+    if (virtio_snd_pcm_get_pending_io_msgs(stream)) {
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
     cmd->resp.code = VIRTIO_SND_S_OK;
 }
 
@@ -669,6 +756,79 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
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
+    VirtQueueElement *elem;
+    size_t sz;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
+
+    trace_virtio_snd_handle_xfer();
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
+            goto tx_err;
+        }
+
+        stream = s->pcm->streams[hdr.stream_id];
+        if (stream->direction != VIRTIO_SND_D_OUTPUT) {
+            goto tx_err;
+        }
+
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            virtio_snd_pcm_read_write(stream,
+                    vq,
+                    elem,
+                    hdr.stream_id == VIRTIO_SND_D_INPUT);
+
+            resp.status = VIRTIO_SND_S_OK;
+            iov_from_buf(elem->in_sg,
+                         elem->in_num,
+                         0,
+                         &resp,
+                         sizeof(resp));
+        }
+        continue;
+
+tx_err:
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
+
 /*
  * Stub buffer virtqueue handler.
  *
@@ -770,7 +930,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
@@ -795,6 +955,73 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
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
+    VirtIOSoundPCMBlock *next;
+    size_t size;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            for (;;) {
+                size = MIN(block->size, available);
+                size = AUD_write(stream->voice.out,
+                        block->data + block->offset,
+                        size);
+                block->size -= size;
+                block->offset += size;
+                if (!block->size) {
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
@@ -818,6 +1045,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
             }
             g_free(vsnd->pcm->streams);
         }
+        g_free(vsnd->pcm->pcm_params);
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
     }
@@ -827,6 +1055,32 @@ static void virtio_snd_unrealize(DeviceState *dev)
 }
 
 
+static uint32_t
+virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+                          VirtQueue *vq,
+                          VirtQueueElement *element,
+                          bool read)
+{
+    VirtIOSoundPCMBlock *fragment;
+    size_t size = iov_size(element->out_sg, element->out_num) -
+        sizeof(virtio_snd_pcm_xfer);
+
+    fragment = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
+    fragment->elem = element;
+    fragment->vq = vq;
+    fragment->size = size;
+    fragment->offset = 0;
+
+    iov_to_buf(element->out_sg, element->out_num,
+               sizeof(virtio_snd_pcm_xfer),
+               fragment->data,
+               size);
+
+    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
+
+    return fragment->size;
+}
+
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index b7046418cf..0350df9ab7 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -79,6 +79,8 @@ typedef struct VirtIOSoundPCMParams VirtIOSoundPCMParams;
 
 typedef struct VirtIOSoundPCM VirtIOSoundPCM;
 
+typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
+
 /* Stream params */
 struct VirtIOSoundPCMParams {
     uint32_t features;
@@ -89,6 +91,15 @@ struct VirtIOSoundPCMParams {
     uint8_t rate;
 };
 
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
     VirtIOSoundPCMParams *pcm_params;
-- 
2.39.2


