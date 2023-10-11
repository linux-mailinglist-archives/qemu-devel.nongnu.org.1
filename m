Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FA37C56F9
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaK0-00017o-6t; Wed, 11 Oct 2023 10:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJx-00015m-1C
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJu-0005ny-1s
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso64213955e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034976; x=1697639776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loCeEjYyI3MRpfj/jU2k9YVJvBGocqpOc4S1cbP0uGc=;
 b=EYtFoV9RWhIVW2/1OkyYnyGzOdwXggVzNwv9r9Qi4vEdlCn3mHYckW4i24ZgWFK9Yr
 A4QTUoxo47pwd1mJnfFIlsePbO7o5nVP2eW8NkzacGNySTgU+1S71BZtshb3yz/R6/l+
 Dv6hQvHQ6puV3AGpXiVOp9DwROPTnnYYLQ0wgqBbiQsZ9K37o/criH+tB0dE5kR7Q1mS
 5D7Fj+quixezffEuufxWJtG3/LQPvcJoWT0OGIYRam+cd1T371QHa+WbJMAAXbnd1AVz
 9tc9LwbHzv7j3noQvp0F0UavfoaOz7lRMadENunZOjA7wcLFPyzyd741OnZOK2JSUTbF
 YAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034976; x=1697639776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=loCeEjYyI3MRpfj/jU2k9YVJvBGocqpOc4S1cbP0uGc=;
 b=vAwBQ3dCtY4WTVKKpsALL+lr60oSLf39EFLiPrQWUFHzjSuKIhTvhBtp9W9+Gflt8r
 Wj/nNdwp24/IGErAmuwDzvMxVVOticM1dYiXvlvwK+X3+jp51DvDpeZoxRnnlDxzWsVF
 B9UOU6xxbPBcpEWJhbz5vYFKz14HzLe3Opw6XMxiCiyAveBx871esMlFrHSROQuRxfXQ
 gkOVCuuzpo0mnzMDSnpDrBOYD8zWhrMeK7xTjEYAKWQy+5oZ4WWG4iMhW5XVpCm6rggq
 FOEK1LXnlOKgVddfITerF0fBM6BZf3p7tp00uAH4dierjWlwuH20GweL2622iU1pYiSI
 HU0g==
X-Gm-Message-State: AOJu0YxAgjyqdjEXqAayBCiPBEebRdFGUYFQ6ZuLlyjD3n31WBPP5Zpx
 Suf5d89cIpcBJaHB1S92+qcpg23TTxbrAkD/Wqo=
X-Google-Smtp-Source: AGHT+IFzH44rQ8k/GhUWbCzS5ndlO/yQoSEatB6qxCfou6RIqXP8A0h+fLG7PvR05kIP669+dKFa4A==
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id
 x23-20020a1c7c17000000b003fe0ba7f200mr19236371wmc.20.1697034975866; 
 Wed, 11 Oct 2023 07:36:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:36:15 -0700 (PDT)
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
Subject: [PATCH v11 10/11] virtio-sound: implement audio capture (RX)
Date: Wed, 11 Oct 2023 17:34:55 +0300
Message-Id: <68f9e0f298b82c8447200814698593a7304d16d1.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32b.google.com
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

To perform audio capture we duplicate the TX logic of the previous
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU's audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 262 +++++++++++++++++++++++++++++++++++------
 2 files changed, 230 insertions(+), 35 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index a31531970d..56a2f44981 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
 virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
 virtio_snd_handle_event(void) "event queue callback called"
 virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
-virtio_snd_handle_xfer(void) "tx/rx queue callback called"
+virtio_snd_handle_tx_xfer(void) "tx queue callback called"
+virtio_snd_handle_rx_xfer(void) "rx queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 5e9513fb26..636ea08c1a 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -1,40 +1,41 @@
 /*
  * VIRTIO Sound Device conforming to
  *
  * "Virtual I/O Device (VIRTIO) Version 1.2
  * Committee Specification Draft 01
  * 09 May 2022"
  *
  * <https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-52900014>
  *
  * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
  * Copyright (C) 2019 OpenSynergy GmbH
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * (at your option) any later version.  See the COPYING file in the
  * top-level directory.
  */
 
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "include/qemu/lockable.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 #include "qapi/error.h"
 #include "hw/virtio/virtio-snd.h"
 #include "hw/core/cpu.h"
 
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
 static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
 
 static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -403,87 +404,96 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
 /*
  * Close a stream and free all its resources.
  *
  * @stream: VirtIOSoundPCMStream *stream
  */
 static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
 {
     if (stream) {
+        virtio_snd_pcm_flush(stream);
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
-            virtio_snd_pcm_flush(stream);
             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
             stream->voice.out = NULL;
+        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
+            stream->voice.in = NULL;
         }
     }
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
         qemu_mutex_init(&stream->queue_mutex);
         QSIMPLEQ_INIT(&stream->queue);
         QSIMPLEQ_INIT(&stream->invalid);
 
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
 
     if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
         stream->voice.out = AUD_open_out(&s->card,
                                          stream->voice.out,
                                          "virtio-sound.out",
                                          stream,
                                          virtio_snd_pcm_out_cb,
                                          &as);
         AUD_set_volume_out(stream->voice.out, 0, 255, 255);
     } else {
-        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimplemented.");
+        stream->voice.in = AUD_open_in(&s->card,
+                                        stream->voice.in,
+                                        "virtio-sound.in",
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &as);
+        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
     }
 
     return cpu_to_le32(VIRTIO_SND_S_OK);
 }
@@ -536,54 +546,56 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
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
 
     stream = virtio_snd_pcm_get_stream(s, stream_id);
     if (stream) {
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             stream->active = start;
         }
         if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream->voice.out, start);
+        } else {
+            AUD_set_active_in(stream->voice.in, start);
         }
     } else {
         error_report("Invalid stream id: %"PRIu32, stream_id);
         cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
         return;
     }
     stream->active = start;
 }
 
 /*
  * Returns the number of I/O messages that are being processed.
  *
  * @stream: VirtIOSoundPCMStream
  */
@@ -804,80 +816,122 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
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
 
+static inline void empty_invalid_queue(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSoundPCMBuffer *buffer = NULL;
+    VirtIOSoundPCMStream *stream = NULL;
+    virtio_snd_pcm_status resp = { 0 };
+    VirtIOSound *vsnd = VIRTIO_SND(vdev);
+    bool any = false;
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        stream = vsnd->pcm->streams[i];
+        if (stream) {
+            any = false;
+            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
+                    buffer = QSIMPLEQ_FIRST(&stream->invalid);
+                    if (buffer->vq != vq) {
+                        break;
+                    }
+                    any = true;
+                    resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+                    iov_from_buf(buffer->elem->in_sg,
+                                 buffer->elem->in_num,
+                                 0,
+                                 &resp,
+                                 sizeof(virtio_snd_pcm_status));
+                    virtqueue_push(vq,
+                                   buffer->elem,
+                                   sizeof(virtio_snd_pcm_status));
+                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
+                    virtio_snd_pcm_buffer_free(buffer);
+                }
+                if (any) {
+                    /*
+                     * Notify vq about virtio_snd_pcm_status responses.
+                     * Buffer responses must be notified separately later.
+                     */
+                    virtio_notify(vdev, vq);
+                }
+            }
+        }
+    }
+}
+
 /*
  * The tx virtqueue handler. Makes the buffers available to their respective
  * streams for consumption.
  *
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream = NULL;
     VirtIOSoundPCMBuffer *buffer;
     VirtQueueElement *elem;
     size_t msg_sz, size;
     virtio_snd_pcm_xfer hdr;
-    virtio_snd_pcm_status resp = { 0 };
     uint32_t stream_id;
     /*
      * If any of the I/O messages are invalid, put them in stream->invalid and
      * return them after the for loop.
      */
     bool must_empty_invalid_queue = false;
 
     if (!virtio_queue_ready(vq)) {
         return;
     }
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
 
     for (;;) {
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             break;
         }
         /* get the message hdr object */
         msg_sz = iov_to_buf(elem->out_sg,
                             elem->out_num,
                             0,
                             &hdr,
                             sizeof(virtio_snd_pcm_xfer));
         if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
             goto tx_err;
         }
         stream_id = le32_to_cpu(hdr.stream_id);
 
         if (stream_id >= s->snd_conf.streams
             || s->pcm->streams[stream_id] == NULL) {
             goto tx_err;
         }
 
         stream = s->pcm->streams[stream_id];
         if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
             goto tx_err;
         }
 
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             size = iov_size(elem->out_sg, elem->out_num) - msg_sz;
 
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
             buffer->elem = elem;
             buffer->populated = false;
             buffer->vq = vq;
             buffer->size = size;
             buffer->offset = 0;
 
             QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
         }
         continue;
@@ -885,44 +939,96 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
 tx_err:
         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
             must_empty_invalid_queue = true;
             buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
             buffer->elem = elem;
             buffer->vq = vq;
             QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
         }
     }
 
     if (must_empty_invalid_queue) {
-        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
-            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
-                buffer = QSIMPLEQ_FIRST(&stream->invalid);
-
-                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
-                iov_from_buf(buffer->elem->in_sg,
-                             buffer->elem->in_num,
-                             0,
-                             &resp,
-                             sizeof(virtio_snd_pcm_status));
-                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
-                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
-                virtio_snd_pcm_buffer_free(buffer);
-            }
-            /*
-             * Notify vq about virtio_snd_pcm_status responses.
-             * Buffer responses must be notified separately later.
-             */
-            virtio_notify(vdev, vq);
-        }
+        empty_invalid_queue(vdev, vq);
     }
 }
 
 /*
- * Stub buffer virtqueue handler.
+ * The rx virtqueue handler. Makes the buffers available to their respective
+ * streams for consumption.
  *
  * @vdev: VirtIOSound device
- * @vq: virtqueue
+ * @vq: rx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream = NULL;
+    VirtIOSoundPCMBuffer *buffer;
+    VirtQueueElement *elem;
+    size_t msg_sz, size;
+    virtio_snd_pcm_xfer hdr;
+    uint32_t stream_id;
+    /*
+     * if any of the I/O messages are invalid, put them in stream->invalid and
+     * return them after the for loop.
+     */
+    bool must_empty_invalid_queue = false;
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
+    trace_virtio_snd_handle_rx_xfer();
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
+            goto rx_err;
+        }
+        stream_id = le32_to_cpu(hdr.stream_id);
+
+        if (stream_id >= s->snd_conf.streams
+            || !s->pcm->streams[stream_id]) {
+            goto rx_err;
+        }
+
+        stream = s->pcm->streams[stream_id];
+        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
+            goto rx_err;
+        }
+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
+            size = iov_size(elem->in_sg, elem->in_num) -
+                sizeof(virtio_snd_pcm_status);
+            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
+            buffer->elem = elem;
+            buffer->vq = vq;
+            buffer->size = 0;
+            buffer->offset = 0;
+            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
+        }
+        continue;
+
+rx_err:
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
+        empty_invalid_queue(vdev, vq);
+    }
+}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -954,82 +1060,82 @@ virtio_snd_vm_state_change(void *opaque, bool running,
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
-        virtio_add_queue(vdev, 64, virtio_snd_handle_tx);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
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
@@ -1059,76 +1165,164 @@ static inline void return_tx_buffer(VirtIOSoundPCMStream *stream,
 /*
  * AUD_* output callback.
  *
  * @data: VirtIOSoundPCMStream stream
  * @available: number of bytes that can be written with AUD_write()
  */
 static void virtio_snd_pcm_out_cb(void *data, int available)
 {
     VirtIOSoundPCMStream *stream = data;
     VirtIOSoundPCMBuffer *buffer;
     size_t size;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
             buffer = QSIMPLEQ_FIRST(&stream->queue);
             if (!virtio_queue_ready(buffer->vq)) {
                 return;
             }
             if (!stream->active) {
                 /* Stream has stopped, so do not perform AUD_write. */
                 return_tx_buffer(stream, buffer);
                 continue;
             }
             if (!buffer->populated) {
                 iov_to_buf(buffer->elem->out_sg,
                            buffer->elem->out_num,
                            sizeof(virtio_snd_pcm_xfer),
                            buffer->data,
                            buffer->size);
                 buffer->populated = true;
             }
             for (;;) {
                 size = AUD_write(stream->voice.out,
                                  buffer->data + buffer->offset,
                                  MIN(buffer->size, available));
                 assert(size <= MIN(buffer->size, available));
                 if (size == 0) {
                     /* break out of both loops */
                     available = 0;
                     break;
                 }
                 buffer->size -= size;
                 buffer->offset += size;
                 available -= size;
                 if (buffer->size < 1) {
                     return_tx_buffer(stream, buffer);
                     break;
                 }
                 if (!available) {
                     break;
                 }
             }
             if (!available) {
                 break;
             }
         }
     }
 }
 
 /*
- * Flush all buffer data from this stream's queue into the driver's virtual
- * queue.
+ * Flush all buffer data from this input stream's queue into the driver's
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static inline void return_rx_buffer(VirtIOSoundPCMStream *stream,
+                                    VirtIOSoundPCMBuffer *buffer)
+{
+    virtio_snd_pcm_status resp = { 0 };
+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
+    resp.latency_bytes = 0;
+    /* Copy data -if any- to guest */
+    iov_from_buf(buffer->elem->in_sg,
+                 buffer->elem->in_num,
+                 0,
+                 buffer->data,
+                 buffer->size);
+    iov_from_buf(buffer->elem->in_sg,
+                 buffer->elem->in_num,
+                 buffer->size,
+                 &resp,
+                 sizeof(virtio_snd_pcm_status));
+    virtqueue_push(buffer->vq,
+                   buffer->elem,
+                   sizeof(virtio_snd_pcm_status) + buffer->size);
+    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
+    QSIMPLEQ_REMOVE(&stream->queue,
+                    buffer,
+                    VirtIOSoundPCMBuffer,
+                    entry);
+    virtio_snd_pcm_buffer_free(buffer);
+}
+
+
+/*
+ * AUD_* input callback.
+ *
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be read with AUD_read()
+ */
+static void virtio_snd_pcm_in_cb(void *data, int available)
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
+                /* Stream has stopped, so do not perform AUD_read. */
+                return_rx_buffer(stream, buffer);
+                continue;
+            }
+
+            for (;;) {
+                size = AUD_read(stream->voice.in,
+                        buffer->data + buffer->size,
+                        MIN(available, (stream->params.period_bytes -
+                                        buffer->size)));
+                if (!size) {
+                    available = 0;
+                    break;
+                }
+                buffer->size += size;
+                available -= size;
+                if (buffer->size >= stream->params.period_bytes) {
+                    return_rx_buffer(stream, buffer);
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
+ * Flush all buffer data from this output stream's queue into the driver's
+ * virtual queue.
  *
  * @stream: VirtIOSoundPCMStream *stream
  */
 static inline void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
 {
     VirtIOSoundPCMBuffer *buffer;
+    void (*cb)(VirtIOSoundPCMStream *, VirtIOSoundPCMBuffer *) =
+        (stream->info.direction == VIRTIO_SND_D_OUTPUT) ? return_tx_buffer :
+        return_rx_buffer;
 
     WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
         while (!QSIMPLEQ_EMPTY(&stream->queue)) {
             buffer = QSIMPLEQ_FIRST(&stream->queue);
-            return_tx_buffer(stream, buffer);
+            cb(stream, buffer);
         }
     }
 }
-- 
2.39.2


