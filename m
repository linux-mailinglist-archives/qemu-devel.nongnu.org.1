Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB107C5723
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJy-000138-5E; Wed, 11 Oct 2023 10:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJu-000111-E1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJp-0005nM-Ru
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so64889925e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034971; x=1697639771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5MYIcjXsp03D+e3fMwDl/7RfUyaMrEKMyOxa1Vp02k=;
 b=UF53E+jnHfJq4imTD3zE9o/osfv0sECM+4LwBVLaAipK81zbHLInMqgfhue+JoGpLu
 MAlGOF7cQitEbK8rfTU9d2QTCRY8BXaG5uE0oTzN57AMzMbfGu5dSkp5r76QZ9MyBJX6
 Ti9YnB7nlJ9DhKWqyJ3FjfrIGbvcwGgeBRwPoMJg+4Q3Czj8gA2XjPN7AYszyyr3CCqW
 mxgjZtd63S2siv9nU5gN9TFvMwvUhdVgBL62NACgI3oqg9LsQgU+rkDRczHuHal8V08R
 k+ZTJwb6mJehwi1Gg4+E0Me5nOf0NUZK2L/xCa2oWNJ6b/SvPR5Ic31WOPhZWG4dAsGQ
 VLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034971; x=1697639771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5MYIcjXsp03D+e3fMwDl/7RfUyaMrEKMyOxa1Vp02k=;
 b=JW/vsJIP9yP0NfYss0fkjMU3i6hWjzgsLLx69ejAkGr5MOxtywXkUyVswCn88VsgBR
 xGL3LPzXNr0HdOdDmv3O0oCg1t6eJC0ANy8QAWEP4l3xqKX8Th5apaOscw6oDGfoT3Oh
 5WrtTphvAdrA/6mKWEnIABTT0QJmKzhVK0PDE5OMpns+DVpGXTieeU94ETXW1L8Aufzx
 SI9NTC6VqpCafHQ+flfR6ohQHVZhNX5AQle56g2VHGCDp4MB6p0dG1orMxyl1MkVgAx4
 viX1vjbe9Lbzw/vWeSUOgPa3O12U7gAhmER/OI542VMZwZ6Wr/kgAcsSQlinTtcmjNen
 S+UA==
X-Gm-Message-State: AOJu0Yy4FAwm4tVG07JBWKqHQ8A0OWokUJHPKewcWIkLAja2cTisf6Kf
 Vd3aMn+WMI1IbUIKmcTlfkjkJ0g/hNDinxHWJIc=
X-Google-Smtp-Source: AGHT+IE7UsxrldRHVTESNeH/uhZmvzn7X6BlVmiaIewMo12tS181YNnEFHDFKQ15YqJhrYtKLFcMmA==
X-Received: by 2002:a05:6000:1cca:b0:320:8d6:74f5 with SMTP id
 bf10-20020a0560001cca00b0032008d674f5mr17426398wrb.28.1697034971347; 
 Wed, 11 Oct 2023 07:36:11 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:36:10 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Google-Original-From: Manos Pitsidianakis <manos@pitsidianak.is>
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
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Stefano Garzarella" <sgarzare@redhat.com>
Subject: [PATCH v11 09/11] virtio-sound: implement audio output (TX)
Date: Wed, 11 Oct 2023 17:34:54 +0300
Message-Id: <34be52e56ea9ecae9cb3e9efc05688de967af84e.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

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
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events         |   2 +
 hw/virtio/virtio-snd.c         | 288 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h |  47 ++++++
 3 files changed, 332 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b0789a6e7e..a31531970d 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -171,3 +171,5 @@ virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called fo
 virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
+virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
+virtio_snd_handle_xfer(void) "tx/rx queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index ca873fd6d4..5e9513fb26 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
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
@@ -392,66 +403,88 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
 /*
  * Close a stream and free all its resources.
  *
  * @stream: VirtIOSoundPCMStream *stream
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
  * Prepares a VirtIOSound card stream.
  * Returns the response status code. (VIRTIO_SND_S_*).
  *
  * @s: VirtIOSound device
  * @stream_id: stream id
  */
 static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
 {
     audsettings as;
     virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
     if (s->pcm->streams == NULL ||
         s->pcm->pcm_params == NULL ||
         stream_id >= s->snd_conf.streams) {
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
     params = virtio_snd_pcm_get_params(s, stream_id);
     if (params == NULL) {
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
         stream = g_new0(VirtIOSoundPCMStream, 1);
         stream->active = false;
         stream->id = stream_id;
         stream->pcm = s->pcm;
         stream->s = s;
+        qemu_mutex_init(&stream->queue_mutex);
+        QSIMPLEQ_INIT(&stream->queue);
+        QSIMPLEQ_INIT(&stream->invalid);
 
         /*
          * stream_id >= s->snd_conf.streams was checked before so this is
          * in-bounds
          */
         s->pcm->streams[stream_id] = stream;
     }
 
     virtio_snd_get_qemu_audsettings(&as, params);
     stream->info.direction = stream_id < s->snd_conf.streams / 2 +
         (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
     stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
     stream->info.features = 0;
     stream->info.channels_min = 1;
     stream->info.channels_max = as.nchannels;
     stream->info.formats = supported_formats;
     stream->info.rates = supported_rates;
     stream->params = *params;
 
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
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
 
@@ -503,93 +536,136 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
 /*
  * Handles VIRTIO_SND_R_PCM_START.
  *
  * @s: VirtIOSound device
  * @cmd: The request command queue element from VirtIOSound cmdq field
  * @start: whether to start or stop the device
  */
 static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
                                              virtio_snd_ctrl_command *cmd,
                                              bool start)
 {
     VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_hdr req;
     uint32_t stream_id;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
                                cmd->elem->out_num,
                                0,
                                &req,
                                sizeof(virtio_snd_pcm_hdr));
 
     if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_hdr));
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
 
     stream_id = le32_to_cpu(req.stream_id);
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
     stream->active = start;
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
  */
 static void virtio_snd_handle_pcm_release(VirtIOSound *s,
                                           virtio_snd_ctrl_command *cmd)
 {
     uint32_t stream_id;
     VirtIOSoundPCMStream *stream;
     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
                                cmd->elem->out_num,
                                sizeof(virtio_snd_hdr),
                                &stream_id,
                                sizeof(stream_id));
 
     if (msg_sz != sizeof(stream_id)) {
         /*
          * TODO: do we need to set DEVICE_NEEDS_RESET?
          */
         qemu_log_mask(LOG_GUEST_ERROR,
                 "%s: virtio-snd command size incorrect %zu vs \
                 %zu\n", __func__, msg_sz, sizeof(stream_id));
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
 
     stream_id = le32_to_cpu(stream_id);
     trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream == NULL) {
         /*
          * TODO: do we need to set DEVICE_NEEDS_RESET?
          */
         error_report("already released stream %"PRIu32, stream_id);
         virtio_error(VIRTIO_DEVICE(s),
                      "already released stream %"PRIu32,
                      stream_id);
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
 
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
  * @s: VirtIOSound device
  * @cmd: control command request
  */
@@ -728,19 +804,121 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
 /*
  * The event virtqueue handler.
  * Not implemented yet.
  *
  * @vdev: VirtIOSound device
  * @vq: event vq
  */
 static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
 {
     qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.\n");
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
  * @vdev: VirtIOSound device
  * @vq: virtqueue
  */
@@ -776,116 +954,216 @@ virtio_snd_vm_state_change(void *opaque, bool running,
 static void virtio_snd_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     virtio_snd_pcm_set_params default_params = { 0 };
     uint32_t status;
 
     vsnd->pcm = NULL;
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
     trace_virtio_snd_realize(vsnd);
 
     vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
     vsnd->pcm->snd = vsnd;
     vsnd->pcm->streams =
         g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
     vsnd->pcm->pcm_params =
         g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
 
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
 
     /* set number of jacks and streams */
     if (vsnd->snd_conf.jacks > 8) {
         error_setg(errp,
                    "Invalid number of jacks: %"PRIu32,
                    vsnd->snd_conf.jacks);
         return;
     }
     if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
         error_setg(errp,
                    "Invalid number of streams: %"PRIu32,
                     vsnd->snd_conf.streams);
         return;
     }
 
     if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
         error_setg(errp,
                    "Invalid number of channel maps: %"PRIu32,
                    vsnd->snd_conf.chmaps);
         return;
     }
 
     AUD_register_card("virtio-sound", &vsnd->card, errp);
 
     /* set default params for all streams */
     default_params.features = 0;
     default_params.buffer_bytes = cpu_to_le32(8192);
     default_params.period_bytes = cpu_to_le32(2048);
     default_params.channels = 2;
     default_params.format = VIRTIO_SND_PCM_FMT_S16;
     default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
 
     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
         status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
         if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
             error_setg(errp,
                        "Can't initalize stream params, device responded with %s.",
                        print_code(status));
             return;
         }
         status = virtio_snd_pcm_prepare(vsnd, i);
         if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
             error_setg(errp,
                        "Can't prepare streams, device responded with %s.",
                        print_code(status));
             return;
         }
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
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIOSoundPCMStream *stream;
 
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
     if (vsnd->pcm) {
         if (vsnd->pcm->streams) {
             for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
                 stream = vsnd->pcm->streams[i];
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
+                    qemu_mutex_destroy(&stream->queue_mutex);
                     g_free(stream);
                 }
             }
             g_free(vsnd->pcm->streams);
         }
         g_free(vsnd->pcm->pcm_params);
         g_free(vsnd->pcm);
         vsnd->pcm = NULL;
     }
     AUD_remove_card(&vsnd->card);
     qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
     virtio_cleanup(vdev);
 }
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index 4b4aaffff1..ee64f2a537 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
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
@@ -93,74 +137,77 @@ struct VirtIOSoundPCM {
 struct VirtIOSoundPCMStream {
     VirtIOSoundPCM *pcm;
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
     bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
+    QemuMutex queue_mutex;
     bool active;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
 
 /*
  * PCM stream state machine.
  * -------------------------
  *
  * 5.14.6.6.1 PCM Command Lifecycle
  * ================================
  *
  * A PCM stream has the following command lifecycle:
  * - `SET PARAMETERS`
  *   The driver negotiates the stream parameters (format, transport, etc) with
  *   the device.
  *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
  * - `PREPARE`
  *   The device prepares the stream (allocates resources, etc).
  *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`, `START`,
  *   `RELEASE`. Output only: the driver transfers data for pre-buffing.
  * - `START`
  *   The device starts the stream (unmute, putting into running state, etc).
  *   Possible valid transitions: `STOP`.
  *   The driver transfers data to/from the stream.
  * - `STOP`
  *   The device stops the stream (mute, putting into non-running state, etc).
  *   Possible valid transitions: `START`, `RELEASE`.
  * - `RELEASE`
  *   The device releases the stream (frees resources, etc).
  *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
  *
  * +---------------+ +---------+ +---------+ +-------+ +-------+
  * | SetParameters | | Prepare | | Release | | Start | | Stop  |
  * +---------------+ +---------+ +---------+ +-------+ +-------+
  *         |-             |           |          |         |
  *         ||             |           |          |         |
  *         |<             |           |          |         |
  *         |------------->|           |          |         |
  *         |<-------------|           |          |         |
  *         |              |-          |          |         |
  *         |              ||          |          |         |
  *         |              |<          |          |         |
  *         |              |--------------------->|         |
  *         |              |---------->|          |         |
  *         |              |           |          |-------->|
  *         |              |           |          |<--------|
  *         |              |           |<-------------------|
  *         |<-------------------------|          |         |
  *         |              |<----------|          |         |
  *
  * CTRL in the VirtIOSound device
  * ==============================
  *
  * The control messages that affect the state of a stream arrive in the
  * `virtio_snd_handle_ctrl()` queue callback and are of type `struct
  * virtio_snd_ctrl_command`. They are stored in a queue field in the device
  * type, `VirtIOSound`. This allows deferring the CTRL request completion if
  * it's not immediately possible due to locking/state reasons.
  *
  * The CTRL message is finally handled in `process_cmd()`.
  */
-- 
2.39.2


