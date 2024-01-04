Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AACF8249A7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:36:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLUQM-0003El-Ul; Thu, 04 Jan 2024 15:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQK-0003E1-7d
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:40 -0500
Received: from mailout12.t-online.de ([194.25.134.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1rLUQH-0004KH-Cs
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 15:34:39 -0500
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout12.t-online.de (Postfix) with SMTP id 7D31C2134B;
 Thu,  4 Jan 2024 21:34:34 +0100 (CET)
Received: from linpower.localnet ([93.236.158.98]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rLUQ9-2Rt2sj0; Thu, 4 Jan 2024 21:34:29 +0100
Received: by linpower.localnet (Postfix, from userid 1000)
 id 4D32F2002CF; Thu,  4 Jan 2024 21:34:22 +0100 (CET)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH 04/10] hw/audio/virtio-sound: add stream state variable
Date: Thu,  4 Jan 2024 21:34:16 +0100
Message-Id: <20240104203422.12308-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704400469-E626F957-BE448007/0/0 CLEAN NORMAL
X-TOI-MSGID: 458ec8b6-00f8-4969-9965-edc2282b6491
Received-SPF: pass client-ip=194.25.134.22;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout12.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
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

So far, only rudimentary checks have been made to ensure that
the guest only performs state transitions permitted in
virtio-v1.2-csd01 5.14.6.6.1 PCM Command Lifecycle. Add a state
variable per audio stream and check all state transitions.

Because only permitted state transitions are possible, only one
copy of the audio stream parameters is required and these do not
need to be initialised with default values.

The state variable will also make it easier to restore the audio
stream after migration.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/virtio-snd.c         | 219 ++++++++++++++++++----------------
 include/hw/audio/virtio-snd.h |  20 +---
 2 files changed, 116 insertions(+), 123 deletions(-)

diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
index 040bc32ebe..a2817a64b5 100644
--- a/hw/audio/virtio-snd.c
+++ b/hw/audio/virtio-snd.c
@@ -31,11 +31,31 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+#define VSND_PCMSTREAM_STATE_F_PARAMS_SET  0x10000
+#define VSND_PCMSTREAM_STATE_F_PREPARED    0x20000
+#define VSND_PCMSTREAM_STATE_F_ACTIVE      0x40000
+
+#define VSND_PCMSTREAM_STATE_UNINITIALIZED 0
+#define VSND_PCMSTREAM_STATE_PARAMS_SET    (1 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
+#define VSND_PCMSTREAM_STATE_PREPARED      (2 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
+#define VSND_PCMSTREAM_STATE_STARTED       (4 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED \
+                                           | VSND_PCMSTREAM_STATE_F_ACTIVE)
+#define VSND_PCMSTREAM_STATE_STOPPED       (6 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET \
+                                           | VSND_PCMSTREAM_STATE_F_PREPARED)
+#define VSND_PCMSTREAM_STATE_RELEASED      (7 \
+                                           | VSND_PCMSTREAM_STATE_F_PARAMS_SET)
+
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
 static void virtio_snd_pcm_in_cb(void *data, int available);
-static void virtio_snd_unrealize(DeviceState *dev);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -153,8 +173,8 @@ virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
 static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
                                                        uint32_t stream_id)
 {
-    return stream_id >= s->snd_conf.streams ? NULL :
-        s->pcm->streams[stream_id];
+    return stream_id >= s->snd_conf.streams ? NULL
+        : &s->streams[stream_id];
 }
 
 /*
@@ -167,7 +187,7 @@ static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
                                                             uint32_t stream_id)
 {
     return stream_id >= s->snd_conf.streams ? NULL
-        : &s->pcm->pcm_params[stream_id];
+        : &s->streams[stream_id].params;
 }
 
 /*
@@ -252,11 +272,10 @@ static void virtio_snd_handle_pcm_info(VirtIOSound *s,
 
 /*
  * Set the given stream params.
- * Called by both virtio_snd_handle_pcm_set_params and during device
- * initialization.
  * Returns the response status code. (VIRTIO_SND_S_*).
  *
  * @s: VirtIOSound device
+ * @stream_id: stream id
  * @params: The PCM params as defined in the virtio specification
  */
 static
@@ -264,9 +283,10 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
                                    uint32_t stream_id,
                                    virtio_snd_pcm_set_params *params)
 {
+    VirtIOSoundPCMStream *stream;
     virtio_snd_pcm_set_params *st_params;
 
-    if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
+    if (stream_id >= s->snd_conf.streams) {
         /*
          * TODO: do we need to set DEVICE_NEEDS_RESET?
          */
@@ -274,7 +294,17 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    st_params = virtio_snd_pcm_get_params(s, stream_id);
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_UNINITIALIZED:
+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_RELEASED:
+        break;
+    default:
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
 
     if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
         error_report("Number of channels is not supported.");
@@ -289,6 +319,8 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
         return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
     }
 
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
     st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
     st_params->period_bytes = le32_to_cpu(params->period_bytes);
     st_params->features = le32_to_cpu(params->features);
@@ -297,6 +329,14 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     st_params->format = params->format;
     st_params->rate = params->rate;
 
+    if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+        /* implicit VIRTIO_SND_R_PCM_RELEASE */
+        virtio_snd_pcm_flush(stream);
+        virtio_snd_pcm_close(stream);
+    }
+
+    stream->state = VSND_PCMSTREAM_STATE_PARAMS_SET;
+
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -409,15 +449,12 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
-    if (stream) {
-        virtio_snd_pcm_flush(stream);
-        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
-            stream->voice.out = NULL;
-        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
-            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
-            stream->voice.in = NULL;
-        }
+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
+        AUD_close_out(&stream->s->card, stream->voice.out);
+        stream->voice.out = NULL;
+    } else {
+        AUD_close_in(&stream->s->card, stream->voice.in);
+        stream->voice.in = NULL;
     }
 }
 
@@ -434,35 +471,28 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
     virtio_snd_pcm_set_params *params;
     VirtIOSoundPCMStream *stream;
 
-    if (s->pcm->streams == NULL ||
-        s->pcm->pcm_params == NULL ||
-        stream_id >= s->snd_conf.streams) {
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (!stream) {
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    params = virtio_snd_pcm_get_params(s, stream_id);
-    if (params == NULL) {
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_PARAMS_SET:
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_RELEASED:
+        break;
+    default:
         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     }
 
-    stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream == NULL) {
-        stream = &s->streams[stream_id];
-        stream->active = false;
-        stream->pcm = s->pcm;
+    if (!(stream->state & VSND_PCMSTREAM_STATE_F_PREPARED)) {
         QSIMPLEQ_INIT(&stream->queue);
         QSIMPLEQ_INIT(&stream->invalid);
-
-        /*
-         * stream_id >= s->snd_conf.streams was checked before so this is
-         * in-bounds
-         */
-        s->pcm->streams[stream_id] = stream;
     }
 
-    virtio_snd_get_qemu_audsettings(&as, params);
-    stream->params = *params;
+    params = virtio_snd_pcm_get_params(s, stream_id);
 
+    virtio_snd_get_qemu_audsettings(&as, params);
     stream->positions[0] = VIRTIO_SND_CHMAP_FL;
     stream->positions[1] = VIRTIO_SND_CHMAP_FR;
     stream->as = as;
@@ -485,6 +515,8 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
         AUD_set_volume_in(stream->voice.in, 0, 255, 255);
     }
 
+    stream->state = VSND_PCMSTREAM_STATE_PREPARED;
+
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -553,12 +585,28 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
     }
 
     if (start) {
+        switch (stream->state) {
+        case VSND_PCMSTREAM_STATE_PREPARED:
+        case VSND_PCMSTREAM_STATE_STOPPED:
+            break;
+        default:
+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        }
+
         trace_virtio_snd_handle_pcm_start(stream_id);
+        stream->state = VSND_PCMSTREAM_STATE_STARTED;
     } else {
+        switch (stream->state) {
+        case VSND_PCMSTREAM_STATE_STARTED:
+            break;
+        default:
+            return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        }
+
         trace_virtio_snd_handle_pcm_stop(stream_id);
+        stream->state = VSND_PCMSTREAM_STATE_STOPPED;
     }
 
-    stream->active = start;
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
         AUD_set_active_out(stream->voice.out, start);
     } else {
@@ -647,20 +695,23 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
     }
 
     stream_id = le32_to_cpu(stream_id);
-    trace_virtio_snd_handle_pcm_release(stream_id);
     stream = virtio_snd_pcm_get_stream(s, stream_id);
-    if (stream == NULL) {
-        /*
-         * TODO: do we need to set DEVICE_NEEDS_RESET?
-         */
-        error_report("already released stream %"PRIu32, stream_id);
-        virtio_error(VIRTIO_DEVICE(s),
-                     "already released stream %"PRIu32,
-                     stream_id);
+    if (!stream) {
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
 
+    switch (stream->state) {
+    case VSND_PCMSTREAM_STATE_PREPARED:
+    case VSND_PCMSTREAM_STATE_STOPPED:
+        break;
+    default:
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+        return;
+    }
+
+    trace_virtio_snd_handle_pcm_release(stream_id);
+
     if (virtio_snd_pcm_get_io_msgs_count(stream)) {
         /*
          * virtio-v1.2-csd01, 5.14.6.6.5.1,
@@ -675,6 +726,10 @@ static void virtio_snd_handle_pcm_release(VirtIOSound *s,
         virtio_snd_pcm_flush(stream);
     }
 
+    virtio_snd_pcm_close(stream);
+
+    stream->state = VSND_PCMSTREAM_STATE_RELEASED;
+
     cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
 }
 
@@ -830,7 +885,7 @@ static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
     bool any = false;
 
     for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        stream = vsnd->pcm->streams[i];
+        stream = &vsnd->streams[i];
         if (stream) {
             any = false;
             while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
@@ -905,12 +960,11 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || s->pcm->streams[stream_id] == NULL) {
+        if (stream_id >= s->snd_conf.streams) {
             goto tx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
+        stream = &s->streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
@@ -983,13 +1037,12 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
-        if (stream_id >= s->snd_conf.streams
-            || !s->pcm->streams[stream_id]) {
+        if (stream_id >= s->snd_conf.streams) {
             goto rx_err;
         }
 
-        stream = s->pcm->streams[stream_id];
-        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+        stream = &s->streams[stream_id];
+        if (stream->info.direction != VIRTIO_SND_D_INPUT) {
             goto rx_err;
         }
         size = iov_size(elem->in_sg, elem->in_num) -
@@ -1048,8 +1101,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
-    virtio_snd_pcm_set_params default_params = { 0 };
-    uint32_t status;
 
     trace_virtio_snd_realize(vsnd);
 
@@ -1087,6 +1138,7 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         VirtIOSoundPCMStream *stream = &vsnd->streams[i];
 
         stream->id = i;
+        stream->state = VSND_PCMSTREAM_STATE_UNINITIALIZED;
         stream->s = vsnd;
         stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
         stream->info.features = 0;
@@ -1099,23 +1151,9 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         stream->info.channels_max = 2;
     }
 
-    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
-    vsnd->pcm->snd = vsnd;
-    vsnd->pcm->streams =
-        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
-    vsnd->pcm->pcm_params =
-        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
-
     virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
     virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
 
-    /* set default params for all streams */
-    default_params.features = 0;
-    default_params.buffer_bytes = cpu_to_le32(8192);
-    default_params.period_bytes = cpu_to_le32(2048);
-    default_params.channels = 2;
-    default_params.format = VIRTIO_SND_PCM_FMT_S16;
-    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
@@ -1125,28 +1163,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     vsnd->queues[VIRTIO_SND_VQ_RX] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
     QTAILQ_INIT(&vsnd->cmdq);
-
-    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't initialize stream params, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
-        status = virtio_snd_pcm_prepare(vsnd, i);
-        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
-            error_setg(errp,
-                       "Can't prepare streams, device responded with %s.",
-                       print_code(status));
-            goto error_cleanup;
-        }
-    }
-
-    return;
-
-error_cleanup:
-    virtio_snd_unrealize(dev);
 }
 
 static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
@@ -1188,7 +1204,7 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
         if (!virtio_queue_ready(buffer->vq)) {
             return;
         }
-        if (!stream->active) {
+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
             /* Stream has stopped, so do not perform AUD_write. */
             return_tx_buffer(stream, buffer);
             continue;
@@ -1280,7 +1296,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
         if (!virtio_queue_ready(buffer->vq)) {
             return;
         }
-        if (!stream->active) {
+        if (!(stream->state & VSND_PCMSTREAM_STATE_F_ACTIVE)) {
             /* Stream has stopped, so do not perform AUD_read. */
             return_rx_buffer(stream, buffer);
             continue;
@@ -1340,19 +1356,14 @@ static void virtio_snd_unrealize(DeviceState *dev)
     trace_virtio_snd_unrealize(vsnd);
 
     if (vsnd->streams) {
-        if (vsnd->pcm->streams) {
-            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
-                stream = vsnd->pcm->streams[i];
-                if (stream) {
-                    virtio_snd_process_cmdq(stream->s);
-                    virtio_snd_pcm_close(stream);
-                }
+        virtio_snd_process_cmdq(vsnd);
+        for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+            stream = &vsnd->streams[i];
+            if (stream->state & VSND_PCMSTREAM_STATE_F_PREPARED) {
+                virtio_snd_pcm_flush(stream);
+                virtio_snd_pcm_close(stream);
             }
-            g_free(vsnd->pcm->streams);
         }
-        g_free(vsnd->pcm->pcm_params);
-        g_free(vsnd->pcm);
-        vsnd->pcm = NULL;
         g_free(vsnd->streams);
         vsnd->streams = NULL;
     }
diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
index 05b4490488..d1a68444d0 100644
--- a/include/hw/audio/virtio-snd.h
+++ b/include/hw/audio/virtio-snd.h
@@ -75,8 +75,6 @@ typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
 
 typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
 
-typedef struct VirtIOSoundPCM VirtIOSoundPCM;
-
 typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
 
 /*
@@ -121,34 +119,19 @@ struct VirtIOSoundPCMBuffer {
     uint8_t data[];
 };
 
-struct VirtIOSoundPCM {
-    VirtIOSound *snd;
-    /*
-     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
-     * field, because the operation of PCM control requests is first
-     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
-     * means that some times we get parameters without having an allocated
-     * stream yet.
-     */
-    virtio_snd_pcm_set_params *pcm_params;
-    VirtIOSoundPCMStream **streams;
-};
-
 struct VirtIOSoundPCMStream {
-    VirtIOSoundPCM *pcm;
     virtio_snd_pcm_info info;
     virtio_snd_pcm_set_params params;
     uint32_t id;
+    uint32_t state;
     /* channel position values (VIRTIO_SND_CHMAP_XXX) */
     uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
     VirtIOSound *s;
-    bool flushing;
     audsettings as;
     union {
         SWVoiceIn *in;
         SWVoiceOut *out;
     } voice;
-    bool active;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
     QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
 };
@@ -215,7 +198,6 @@ struct VirtIOSound {
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
-    VirtIOSoundPCM *pcm;
     VirtIOSoundPCMStream *streams;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
-- 
2.35.3


