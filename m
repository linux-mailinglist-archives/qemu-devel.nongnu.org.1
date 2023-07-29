Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815D767EA8
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:28:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhM9-0000mJ-G4; Sat, 29 Jul 2023 06:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhM7-0000m6-CZ
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:27 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhM5-0001BP-CA
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:27 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe110de46dso11350085e9.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627164; x=1691231964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6tnLdt2QM+N2hyryCHvRbS6Fo4+6i2BUhEirVgE1n9o=;
 b=GO80mN7QDwmlpVSKLDDVQERhURI1DvvuTh7lRKPC9xzjqXuue26kTlWEB1lzK+TfFg
 0a5tIWey38L+0Y5FiSA4R1IBuP4+rJcY3soeFmdztilVYYZTG0GbZftCpM/42TuQpJ1X
 8l6p1i+tx9hXoAgzbnjX+CMriQQwwbM1eDWPT+BailWukxxauRSSywMO9ZBXbIrHAwOn
 +U47nw7eN4Ymnn6bkiGqHiNQbUcVMpuEhjKf3+xha9XBMS3lZGEP65zWXmqfQFa5nUim
 OT4dqWjdnRI+/1Tup6CvVWuyG8dZpu6NL4NwzstcpAiDIqzsCATgiDpqHh/24fPkujIp
 kNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627164; x=1691231964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6tnLdt2QM+N2hyryCHvRbS6Fo4+6i2BUhEirVgE1n9o=;
 b=hxplJSjmfa12TvS1/K4x4AVdGihbsfIFVbf+/IEVSOPJdvFiSWZQuG13tRbCGy+++B
 2n6T8mx8Rux1R/uLJOktBoYhOGnoQP1wQTIMDB7CqAw7Pmb3ZkNfe4Ux6nNAyYTEEVBQ
 CN79N1jyfKz4HAiC4Js/mA9RvkarNf+MRpvi9/0+DIBbiJ1ygvntgb/63NC+W6DI/phX
 M+Hm1hY1N42Vt9mqvmRSALmV3dcvi+g0JVRh7MBIePeN/mSPmRz6SNYLsZkg5vzH7q/3
 xx8oK4JlT1jk424um4kGcfr0GoCHcfNlqfOqn5MsP5VtpSUtSIMg91G2WTrkzw6jDTwR
 4pHQ==
X-Gm-Message-State: ABy/qLbmPbjzSzJj1wQrre7rMGosY47kFort+ZNDUXgxCSqnIPUUmBGd
 /8YRkuehDhlfpwYI+2gtDOs0AznnHM/12RHMZXyRFg==
X-Google-Smtp-Source: APBJJlHTxPcLayjkZB7LG7Gr3OhQx9/s6JIsrObVBcbZysli1ZUQeGwPtCPCRhWHRVYhkuQhydlatg==
X-Received: by 2002:a7b:c44b:0:b0:3fb:c9f4:150e with SMTP id
 l11-20020a7bc44b000000b003fbc9f4150emr3256807wmi.14.1690627163870; 
 Sat, 29 Jul 2023 03:39:23 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:39:23 -0700 (PDT)
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
Subject: [PATCH v5 11/12] virtio-sound: implement audio output (TX)
Date: Sat, 29 Jul 2023 13:37:03 +0300
Message-Id: <d5fb4b058c934cfad95ecd04e99d216548820eda.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events         |   2 +
 hw/virtio/virtio-snd.c         | 254 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h |  11 ++
 3 files changed, 260 insertions(+), 7 deletions(-)

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
index 5065d62e40..28cbec47f3 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -30,6 +30,15 @@
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
@@ -416,6 +425,17 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
 
+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+        stream->voice.out = AUD_open_out(&s->card,
+                                         stream->voice.out,
+                                         "virtio_snd_card",
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
@@ -475,12 +495,35 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
             "VIRTIO_SND_R_PCM_STOP", req.stream_id);
 
     stream = virtio_snd_pcm_get_stream(s, req.stream_id);
-    if (!stream) {
+    if (stream) {
+        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_set_active_out(stream->voice.out, start);
+        }
+    } else {
         error_report("Invalid stream id: %"PRIu32, req.stream_id);
         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
     }
 }
 
+/*
+ * Returns the number of bytes that have not been passed to AUD_write yet.
+ *
+ * @stream: VirtIOSoundPCMStream
+ */
+static size_t virtio_snd_pcm_get_pending_bytes(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBlock *block;
+    VirtIOSoundPCMBlock *next;
+    size_t size = 0;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
+            size += block->size;
+        }
+    }
+    return size;
+}
+
 /*
  * Releases the buffer resources allocated to a stream. Seperated from the
  * handler so that the code can be reused in the unrealize function. Returns
@@ -492,6 +535,21 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
 static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
                                             uint32_t stream_id)
 {
+    if (virtio_snd_pcm_get_pending_bytes(stream)) {
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
     return VIRTIO_SND_S_OK;
 }
 
@@ -676,6 +734,79 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
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
+        if (stream->direction == VIRTIO_SND_D_INPUT) {
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
@@ -811,11 +942,78 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx,
                               virtio_snd_handle_xfer,
                               errp);
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
+            AUD_write(stream->voice.out, block->data, block->size);
+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
+            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
+        }
+    }
+}
+
 /*
  * Close the sound card.
  *
@@ -824,6 +1022,10 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
     virtio_snd_process_cmdq(stream->s);
+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+        stream->voice.out = NULL;
+    }
 }
 
 static void virtio_snd_unrealize(DeviceState *dev)
@@ -837,17 +1039,55 @@ static void virtio_snd_unrealize(DeviceState *dev)
 
     trace_virtio_snd_unrealize(vsnd);
 
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        stream = vsnd->pcm->streams[i];
-        virtio_snd_pcm_close(stream);
-        g_free(stream);
+    if (vsnd->pcm) {
+        if (vsnd->pcm->streams) {
+            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+                stream = vsnd->pcm->streams[i];
+                if (stream) {
+                    virtio_snd_pcm_close(stream);
+                    g_free(stream);
+                }
+            }
+            g_free(vsnd->pcm->streams);
+            g_free(vsnd->pcm->pcm_params);
+            g_free(vsnd->pcm->jacks);
+        }
+
+        g_free(vsnd->pcm);
     }
+
+    vsnd->pcm = NULL;
     AUD_remove_card(&vsnd->card);
-    g_free(vsnd->pcm);
     virtio_cleanup(vdev);
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
index 7cc5061fa8..6665c8a703 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -81,6 +81,8 @@ typedef struct VirtIOSoundPCMParams VirtIOSoundPCMParams;
 
 typedef struct VirtIOSoundPCM VirtIOSoundPCM;
 
+typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
+
 /* Stream params */
 struct VirtIOSoundPCMParams {
     uint32_t features;
@@ -91,6 +93,15 @@ struct VirtIOSoundPCMParams {
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
     VirtIOSoundPCMParams **pcm_params;
-- 
2.39.2


