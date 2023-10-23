Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F57A7D361E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutfx-0005Rk-B3; Mon, 23 Oct 2023 08:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfp-0005Kp-SC
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:46 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qutfn-00021g-8a
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:04:45 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507c8316abcso4291983e87.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 05:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698062681; x=1698667481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFMzH2ukaH5DgW91S3uYSkF7zisQ9D9LJwyv5VFmicI=;
 b=du0fqkCrXym3NoQKbF7vL299TITnoCuOYrI/H/CR38W0bMh1+XdBff0j0lIKkP79W5
 wFDIEuQzGlaoWDrhSarrxtea1B5EcRG18i4uOg21TeZoDdAaEeE4bbiBhMtsIJHsvhsc
 A+f/YbKHGFi92yaMigroj+1yD0D0rKJmo2LHKQuI8YUzwDtKSLivRWNEH218LYH84fOJ
 x4ndemaiKjNHPV2+Qbqf9vMu74qjVm/Jg1Atm66wJWeSYkoJf9kC71WIVycHZPpVfibp
 kdMzw9zeBbtSJzsHRK6On7ghMqN/l4UF1ggwb6JxFO2mfR/3Fy0bPXPXpRhKRE1zW7Ow
 tZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698062681; x=1698667481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFMzH2ukaH5DgW91S3uYSkF7zisQ9D9LJwyv5VFmicI=;
 b=q5pEK8Zi7QDTNEsnxRkxbZ4UtDuaTl/hjM3vvxKC+nf9Tw4DYktKndlld8y3G114UI
 wDiJ/FKSu2XXTw0w9QuF56YhRlSfiTTOhvVQ6ySiZ0mD5HaS3RRdJCAzgFRfp1g9635P
 sn0JtgFQYj859NOSKT5uFQEknh6gE7WRCxzSjsbtCcSFnCAiS0JUau01iNFonBerhzqR
 CLih3vLGth4xJPREDqh6vnOQl3DvKhn1n2fERpUmF2dc51Ju1xYZOoF3qBXTiIDIQkx3
 y3kQ/VUwJAwVTHHq6j5+X3dqwcfUdJAZ2dQQtX5JNrcNKT7ptBTxq4JFvheXPFpfFXjG
 OuSw==
X-Gm-Message-State: AOJu0YwG7BTirCxZ2RJ0QLeVCtRWV0m9S43yLHKhAXle5Q/l4x6yunbw
 ZGk47nBnB4tsvixPkTLYar0Ce8F/R9ZuGgEuzpI=
X-Google-Smtp-Source: AGHT+IE2h4HkxbaBIbp4bn/vRvp2l9FeIsgHKgD8AkUJrzKbZjFGHh1ekEag8qlaVljXtAg4dVDJEA==
X-Received: by 2002:a2e:be1a:0:b0:2c5:13b1:b450 with SMTP id
 z26-20020a2ebe1a000000b002c513b1b450mr5839161ljq.26.1698062680703; 
 Mon, 23 Oct 2023 05:04:40 -0700 (PDT)
Received: from localhost.localdomain (adsl-69.109.242.226.tellas.gr.
 [109.242.226.69]) by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c418c00b0040773c69fc0sm13819506wmh.11.2023.10.23.05.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 05:04:39 -0700 (PDT)
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
Subject: [PATCH v13 09/11] virtio-sound: implement audio output (TX)
Date: Mon, 23 Oct 2023 15:03:26 +0300
Message-Id: <b7c6fc458c763d09a4abbcb620ae9b220afa5b8f.1698062525.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
References: <cover.1698062525.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
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

It allocates a VirtIOSoundPCMBuffer for each IO message and copies the
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
Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/audio/trace-events         |   2 +
 hw/audio/virtio-snd.c         | 288 +++++++++++++++++++++++++++++++++-
 include/hw/audio/virtio-snd.h |  47 ++++++
 3 files changed, 332 insertions(+), 5 deletions(-)

diff --git a/hw/audio/trace-events b/hw/audio/trace-events
index 33e24d0011..884108129b 100644
--- a/hw/audio/trace-events
+++ b/hw/audio/trace-events
@@ -55,3 +55,5 @@ virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called fo
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
+virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
+virtio_snd_handle_xfer(void) "tx/rx queue callback called"
diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 9cff724f62..6c91d0a740 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -32,6 +32,10 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+static void virtio_snd_pcm_out_cb(void *data, int available);
+static void virtio_snd_process_cmdq(VirtIOSound *s);
+static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
                                   | BIT(VIRTIO_SND_PCM_FMT_S16)
@@ -123,6 +127,13 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 
 }
 
+static void
+virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
+{
+    g_free(buffer->elem);
+    g_free(buffer);
+}
+
 static void
 virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
 {
@@ -396,6 +407,13 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
+    if (stream) {
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            virtio_snd_pcm_flush(stream);
+            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
+            stream->voice.out = NULL;
+        }
+    }
 }
 
 /*
@@ -429,6 +447,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         stream->id = stream_id;
         stream->pcm = s->pcm;
         stream->s = s;
+        qemu_mutex_init(&stream->queue_mutex);
+        QSIMPLEQ_INIT(&stream->queue);
+        QSIMPLEQ_INIT(&stream->invalid);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
@@ -452,6 +473,18 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
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
 
@@ -532,9 +565,17 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
     trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
             "VIRTIO_SND_R_PCM_STOP", stream_id);
+
     stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream == NULL) {
-        error_report("Invalid stream id: %"PRIu32, req.stream_id);
+    if (stream) {
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            stream->active = start;
+        }
+        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+            AUD_set_active_out(stream->voice.out, start);
+        }
+    } else {
+        error_report("Invalid stream id: %"PRIu32, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
@@ -542,8 +583,28 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
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
+    VirtIOSoundPCMBuffer *buffer, *next;
+    size_t count = 0;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
+            count += 1;
+        }
+        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
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
@@ -584,6 +645,21 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
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
+        trace_virtio_snd_pcm_stream_flush(stream_id);
+        virtio_snd_pcm_flush(stream);
+    }
+
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -738,6 +814,108 @@ static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
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
+    VirtIOSoundPCMBuffer *buffer;
+    VirtQueueElement *elem;
+    size_t msg_sz, size;
+    virtio_snd_pcm_xfer hdr;
+    virtio_snd_pcm_status resp = { 0 };
+    uint32_t stream_id;
+    /*
+     * If any of the I/O messages are invalid, put them in stream->invalid and
+     * return them after the for loop.
+     */
+    bool must_empty_invalid_queue = false;
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
+    trace_virtio_snd_handle_xfer();
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
+            goto tx_err;
+        }
+        stream_id = le32_to_cpu(hdr.stream_id);
+
+        if (stream_id >= s->snd_conf.streams
+            || s->pcm->streams[stream_id] == NULL) {
+            goto tx_err;
+        }
+
+        stream = s->pcm->streams[stream_id];
+        if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
+            goto tx_err;
+        }
+
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
+
+            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+            buffer->elem = elem;
+            buffer->populated = false;
+            buffer->vq = vq;
+            buffer->size = size;
+            buffer->offset = 0;
+
+            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
+        }
+        continue;
+
+tx_err:
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
+
 /*
  * Stub buffer virtqueue handler.
  *
@@ -832,7 +1010,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
@@ -856,6 +1034,105 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
+                                    VirtIOSoundPCMBuffer *buffer)
+{
+    virtio_snd_pcm_status resp = { 0 };
+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+    resp.latency_bytes = cpu_to_le32((uint32_t)buffer->size);
+    iov_from_buf(buffer->elem->in_sg,
+                 buffer->elem->in_num,
+                 0,
+                 &resp,
+                 sizeof(virtio_snd_pcm_status));
+    virtqueue_push(buffer->vq,
+                   buffer->elem,
+                   sizeof(virtio_snd_pcm_status));
+    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
+    QSIMPLEQ_REMOVE(&stream->queue,
+                    buffer,
+                    VirtIOSoundPCMBuffer,
+                    entry);
+    virtio_snd_pcm_buffer_free(buffer);
+}
+
+/*
+ * AUD_* output callback.
+ *
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be written with AUD_write()
+ */
+static void virtio_snd_pcm_out_cb(void *data, int available)
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
+                /* Stream has stopped, so do not perform AUD_write. */
+                return_tx_buffer(stream, buffer);
+                continue;
+            }
+            if (!buffer->populated) {
+                iov_to_buf(buffer->elem->out_sg,
+                           buffer->elem->out_num,
+                           sizeof(virtio_snd_pcm_xfer),
+                           buffer->data,
+                           buffer->size);
+                buffer->populated = true;
+            }
+            for (;;) {
+                size = AUD_write(stream->voice.out,
+                                 buffer->data + buffer->offset,
+                                 MIN(buffer->size, available));
+                assert(size <= MIN(buffer->size, available));
+                if (size == 0) {
+                    /* break out of both loops */
+                    available = 0;
+                    break;
+                }
+                buffer->size -= size;
+                buffer->offset += size;
+                available -= size;
+                if (buffer->size < 1) {
+                    return_tx_buffer(stream, buffer);
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
+ * Flush all buffer data from this stream's queue into the driver's virtual
+ * queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+{
+    VirtIOSoundPCMBuffer *buffer;
+
+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
+            buffer = QSIMPLEQ_FIRST(&stream->queue);
+            return_tx_buffer(stream, buffer);
+        }
+    }
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -872,6 +1149,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
+                    qemu_mutex_destroy(&stream->queue_mutex);
                     g_free(stream);
                 }
             }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index cc14c875ed..c3767f442b 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -77,6 +77,50 @@ typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
 
 typedef struct VirtIOSoundPCM VirtIOSoundPCM;
 
+typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
+
+/*
+ * The VirtIO sound spec reuses layouts and values from the High Definition
+ * Audio spec (virtio/v1.2: 5.14 Sound Device). This struct handles each I/O
+ * message's buffer (virtio/v1.2: 5.14.6.8 PCM I/O Messages).
+ *
+ * In the case of TX (i.e. playback) buffers, we defer reading the raw PCM data
+ * from the virtqueue until QEMU's sound backsystem calls the output callback.
+ * This is tracked by the `bool populated;` field, which is set to true when
+ * data has been read into our own buffer for consumption.
+ *
+ * VirtIOSoundPCMBuffer has a dynamic size since it includes the raw PCM data
+ * in its allocation. It must be initialized and destroyed as follows:
+ *
+ *   size_t size = [[derived from owned VQ element descriptor sizes]];
+ *   buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+ *   buffer->elem = [[owned VQ element]];
+ *
+ *   [..]
+ *
+ *   g_free(buffer->elem);
+ *   g_free(buffer);
+ */
+struct VirtIOSoundPCMBuffer {
+    QSIMPLEQ_ENTRY(VirtIOSoundPCMBuffer) entry;
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    size_t size;
+    /*
+     * In TX / Plaback, `offset` represents the first unused position inside
+     * `data`. If `offset == size` then there are no unused data left.
+     */
+    uint64_t offset;
+    /* Used for the TX queue for lazy I/O copy from `elem` */
+    bool populated;
+    /*
+     * VirtIOSoundPCMBuffer is an unsized type because it ends with an array of
+     * bytes. The size of `data` is determined from the I/O message's read-only
+     * or write-only size when allocating VirtIOSoundPCMBuffer.
+     */
+    uint8_t data[];
+};
+
 struct VirtIOSoundPCM {
     VirtIOSound *snd;
     /*
@@ -104,7 +148,10 @@ struct VirtIOSoundPCMStream {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
+    QemuMutex queue_mutex;
     bool active;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 /*
-- 
2.39.2


