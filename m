Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4757C570B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaJn-0000Ob-2t; Wed, 11 Oct 2023 10:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJZ-0000Kn-TI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:36:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qqaJS-0005Pm-PE
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:35:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so6214016f8f.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697034948; x=1697639748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N/3oZ15ILVF3SPyjOF6gh96qOEmYU2+9Pq0/zh/3Pk=;
 b=cG83EycUdRUqrDIfj/JPa470nbwZrOKOTJQ5ZrwO8aqVSCItJ4mvs6yDB0pSPHez3x
 kEdYa5eUbrvPg4N1ThAEFOpBLOWJTInsVmgNHlqQVHCgGXm9sLKpe3PTwvDnclOj9NRg
 fSfpA6YuAejXrJKvdepPFhInSKaF15FGYCfMZEtDa8zUaVCazVmfknF6iwu4YtXD4VP9
 jObAlpSki8ycMKGEYhW15ZxIZEDXGi0tz2hSttRiTg7LAS2c3p+/u8kP1tfmb5osilqZ
 ZD0pY1CiOLv/effw09VuB8xLJLcCKfrpg3F5fENXNNMnEJxSfyjx1FTqVyRrHc3GjJET
 9Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697034948; x=1697639748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N/3oZ15ILVF3SPyjOF6gh96qOEmYU2+9Pq0/zh/3Pk=;
 b=YJ7KEqgZL7BENfnZaoYH7rypRAN1dG+zb0S3t0NaAKE9LhRFXgDYi011+qeYPKVPjn
 lDn2XwSDzCSti7ZjR5eGz9uiQ2Bm537yZ8nH2sa2UZ92ZY6oWschPZ8TaKgJxIvKO9jG
 gbjyOH9C+Gu9qqA3NoSmsY+KMqfnRQ1tBdFC1gHaBzKMPLQ71dbNfnEe4XjfmPl8X3qJ
 4dhpBJtgj3958Q5BOwzUSsiZEjYTN4CGH5uCHLSaKgpKvHzgzRASHo+JXMCtL80hkbW0
 YXT/XSGa2Y3sK1Htmu/R1fVqyV1MlMWrRnN5Um0O094V50KmJ7Zf5qAecPuhQcVpLdIx
 sUfQ==
X-Gm-Message-State: AOJu0Yxz1KYYX2tdAA7bYwdKkT3DBwjccyYkshV1ToZMqrXIybib0X55
 TgZOfswJ/xso+6fJR9oLxtDD1RqUJFfwkxS9fAo=
X-Google-Smtp-Source: AGHT+IExm/padWvMVOO0Tk+15nG4Dnd6GskS2TWs7OoSWghSm17yheyLzu9ONi6HNfJStDYG8a8lvQ==
X-Received: by 2002:a05:6000:1703:b0:32d:8958:d36b with SMTP id
 n3-20020a056000170300b0032d8958d36bmr1392122wrc.3.1697034948084; 
 Wed, 11 Oct 2023 07:35:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a5d4208000000b003253523d767sm15599869wrq.109.2023.10.11.07.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 07:35:47 -0700 (PDT)
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
Subject: [PATCH v11 03/11] virtio-sound: handle control messages and streams
Date: Wed, 11 Oct 2023 17:34:48 +0300
Message-Id: <5831b5cfa5666b040e8466c0e4cbb0b08c4fd4ec.1696935992.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
References: <cover.1696935992.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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

Receive guest requests in the control (CTRL) queue of the virtio sound
device and reply with a NOT SUPPORTED error to all control commands.

The receiving handler is virtio_snd_handle_ctrl(). It stores all control
messages in the queue in the device's command queue. Then it calls
virtio_snd_process_cmdq() to handle each message.

The handler is process_cmd() which replies with VIRTIO_SND_S_NOT_SUPP.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/trace-events         |   4 +
 hw/virtio/virtio-snd.c         | 487 ++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-snd.h | 113 +++++++-
 3 files changed, 595 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 96b997f427..48043fed3e 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -163,3 +163,7 @@ virtio_snd_vm_state_running(void) "vm state running"
 virtio_snd_vm_state_stopped(void) "vm state stopped"
 virtio_snd_realize(void *snd) "snd %p: realize"
 virtio_snd_unrealize(void *snd) "snd %p: unrealize"
+virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event for queue %p"
+virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
+virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
+virtio_snd_handle_event(void) "event queue callback called"
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 14bc32f476..705dc07212 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -32,6 +32,29 @@
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
 
+static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
+                                  | BIT(VIRTIO_SND_PCM_FMT_U8)
+                                  | BIT(VIRTIO_SND_PCM_FMT_S16)
+                                  | BIT(VIRTIO_SND_PCM_FMT_U16)
+                                  | BIT(VIRTIO_SND_PCM_FMT_S32)
+                                  | BIT(VIRTIO_SND_PCM_FMT_U32)
+                                  | BIT(VIRTIO_SND_PCM_FMT_FLOAT);
+
+static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
+                                | BIT(VIRTIO_SND_PCM_RATE_8000)
+                                | BIT(VIRTIO_SND_PCM_RATE_11025)
+                                | BIT(VIRTIO_SND_PCM_RATE_16000)
+                                | BIT(VIRTIO_SND_PCM_RATE_22050)
+                                | BIT(VIRTIO_SND_PCM_RATE_32000)
+                                | BIT(VIRTIO_SND_PCM_RATE_44100)
+                                | BIT(VIRTIO_SND_PCM_RATE_48000)
+                                | BIT(VIRTIO_SND_PCM_RATE_64000)
+                                | BIT(VIRTIO_SND_PCM_RATE_88200)
+                                | BIT(VIRTIO_SND_PCM_RATE_96000)
+                                | BIT(VIRTIO_SND_PCM_RATE_176400)
+                                | BIT(VIRTIO_SND_PCM_RATE_192000)
+                                | BIT(VIRTIO_SND_PCM_RATE_384000);
+
 static const VMStateDescription vmstate_virtio_snd_device = {
     .name = TYPE_VIRTIO_SND,
     .version_id = VIRTIO_SOUND_VM_VERSION,
@@ -81,32 +104,416 @@ static void
 virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIOSound *s = VIRTIO_SND(vdev);
     const virtio_snd_config *sndconfig =
         (const virtio_snd_config *)config;
 
 
    trace_virtio_snd_set_config(vdev,
                                s->snd_conf.jacks,
                                sndconfig->jacks,
                                s->snd_conf.streams,
                                sndconfig->streams,
                                s->snd_conf.chmaps,
                                sndconfig->chmaps);
 
     memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
     le32_to_cpus(&s->snd_conf.jacks);
     le32_to_cpus(&s->snd_conf.streams);
     le32_to_cpus(&s->snd_conf.chmaps);
 
 }
 
+static void
+virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
+{
+    g_free(cmd->elem);
+    g_free(cmd);
+}
+
+/*
+ * Get a specific stream from the virtio sound card device.
+ * Returns NULL if @stream_id is invalid or not allocated.
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
+                                                       uint32_t stream_id)
+{
+    return stream_id >= s->snd_conf.streams ? NULL :
+        s->pcm->streams[stream_id];
+}
+
+/*
+ * Get params for a specific stream.
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
+                                                            uint32_t stream_id)
+{
+    return stream_id >= s->snd_conf.streams ? NULL
+        : &s->pcm->pcm_params[stream_id];
+}
+
+/*
+ * Set the given stream params.
+ * Called by both virtio_snd_handle_pcm_set_params and during device
+ * initialization.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @params: The PCM params as defined in the virtio specification
+ */
+static
+uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
+                                   uint32_t stream_id,
+                                   virtio_snd_pcm_set_params *params)
+{
+    virtio_snd_pcm_set_params *st_params;
+
+    if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
+    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
+        error_report("Number of channels is not supported.");
+        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+    }
+    if (!(supported_formats & BIT(params->format))) {
+        error_report("Stream format is not supported.");
+        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+    }
+    if (!(supported_rates & BIT(params->rate))) {
+        error_report("Stream rate is not supported.");
+        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+    }
+
+    st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
+    st_params->period_bytes = le32_to_cpu(params->period_bytes);
+    st_params->features = le32_to_cpu(params->features);
+    /* the following are uint8_t, so there's no need to bswap the values. */
+    st_params->channels = params->channels;
+    st_params->format = params->format;
+    st_params->rate = params->rate;
+
+    return cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
+/*
+ * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
+ */
+static AudioFormat virtio_snd_get_qemu_format(uint32_t format)
+{
+    #define CASE(FMT)               \
+    case VIRTIO_SND_PCM_FMT_##FMT:  \
+        return AUDIO_FORMAT_##FMT;
+
+    switch (format) {
+    CASE(U8)
+    CASE(S8)
+    CASE(U16)
+    CASE(S16)
+    CASE(U32)
+    CASE(S32)
+    case VIRTIO_SND_PCM_FMT_FLOAT:
+        return AUDIO_FORMAT_F32;
+    default:
+        g_assert_not_reached();
+    }
+
+    #undef CASE
+}
+
+/*
+ * Get a QEMU Audiosystem compatible frequency value from a
+ * VIRTIO_SND_PCM_RATE_*
+ */
+static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
+{
+    #define CASE(RATE)               \
+    case VIRTIO_SND_PCM_RATE_##RATE: \
+        return RATE;
+
+    switch (rate) {
+    CASE(5512)
+    CASE(8000)
+    CASE(11025)
+    CASE(16000)
+    CASE(22050)
+    CASE(32000)
+    CASE(44100)
+    CASE(48000)
+    CASE(64000)
+    CASE(88200)
+    CASE(96000)
+    CASE(176400)
+    CASE(192000)
+    CASE(384000)
+    default:
+        g_assert_not_reached();
+    }
+
+    #undef CASE
+}
+
+/*
+ * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
+ * params.
+ */
+static void virtio_snd_get_qemu_audsettings(audsettings *as,
+                                            virtio_snd_pcm_set_params *params)
+{
+    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
+    as->fmt = virtio_snd_get_qemu_format(params->format);
+    as->freq = virtio_snd_get_qemu_freq(params->rate);
+    as->endianness = target_words_bigendian() ? 1 : 0;
+}
+
+/*
+ * Close a stream and free all its resources.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
+{
+}
+
 /*
- * Queue handler stub.
+ * Prepares a VirtIOSound card stream.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
+{
+    audsettings as;
+    virtio_snd_pcm_set_params *params;
+    VirtIOSoundPCMStream *stream;
+
+    if (s->pcm->streams == NULL ||
+        s->pcm->pcm_params == NULL ||
+        stream_id >= s->snd_conf.streams) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    params = virtio_snd_pcm_get_params(s, stream_id);
+    if (params == NULL) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    if (stream == NULL) {
+        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream->active = false;
+        stream->id = stream_id;
+        stream->pcm = s->pcm;
+        stream->s = s;
+
+        /*
+         * stream_id >= s->snd_conf.streams was checked before so this is
+         * in-bounds
+         */
+        s->pcm->streams[stream_id] = stream;
+    }
+
+    virtio_snd_get_qemu_audsettings(&as, params);
+    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
+        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+    stream->info.features = 0;
+    stream->info.channels_min = 1;
+    stream->info.channels_max = as.nchannels;
+    stream->info.formats = supported_formats;
+    stream->info.rates = supported_rates;
+    stream->params = *params;
+
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+    stream->as = as;
+
+    return cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
+static const char *print_code(uint32_t code)
+{
+    #define CASE(CODE)            \
+    case VIRTIO_SND_R_##CODE:     \
+        return "VIRTIO_SND_R_"#CODE
+
+    switch (code) {
+    CASE(JACK_INFO);
+    CASE(JACK_REMAP);
+    CASE(PCM_INFO);
+    CASE(PCM_SET_PARAMS);
+    CASE(PCM_PREPARE);
+    CASE(PCM_RELEASE);
+    CASE(PCM_START);
+    CASE(PCM_STOP);
+    CASE(CHMAP_INFO);
+    default:
+        return "invalid code";
+    }
+
+    #undef CASE
+};
+
+/*
+ * The actual processing done in virtio_snd_process_cmdq().
+ *
+ * @s: VirtIOSound device
+ * @cmd: control command request
+ */
+static inline void
+process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
+{
+    uint32_t code;
+    size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
+                               cmd->elem->out_num,
+                               0,
+                               &cmd->ctrl,
+                               sizeof(virtio_snd_hdr));
+
+    if (msg_sz != sizeof(virtio_snd_hdr)) {
+        /*
+         * TODO: do we need to set DEVICE_NEEDS_RESET?
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                "%s: virtio-snd command size incorrect %zu vs \
+                %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));
+        return;
+    }
+
+    code = le32_to_cpu(cmd->ctrl.code);
+
+    trace_virtio_snd_handle_code(code, print_code(code));
+
+    switch (code) {
+    case VIRTIO_SND_R_JACK_INFO:
+    case VIRTIO_SND_R_JACK_REMAP:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: jack functionality is unimplemented.\n");
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    case VIRTIO_SND_R_PCM_INFO:
+    case VIRTIO_SND_R_PCM_SET_PARAMS:
+    case VIRTIO_SND_R_PCM_PREPARE:
+    case VIRTIO_SND_R_PCM_START:
+    case VIRTIO_SND_R_PCM_STOP:
+    case VIRTIO_SND_R_PCM_RELEASE:
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    case VIRTIO_SND_R_CHMAP_INFO:
+        qemu_log_mask(LOG_UNIMP,
+                     "virtio_snd: chmap info functionality is unimplemented.\n");
+        trace_virtio_snd_handle_chmap_info();
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
+        break;
+    default:
+        /* error */
+        error_report("virtio snd header not recognized: %"PRIu32, code);
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    iov_from_buf(cmd->elem->in_sg,
+                 cmd->elem->in_num,
+                 0,
+                 &cmd->resp,
+                 sizeof(virtio_snd_hdr));
+    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
+    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
+}
+
+/*
+ * Consume all elements in command queue.
+ *
+ * @s: VirtIOSound device
+ */
+static void virtio_snd_process_cmdq(VirtIOSound *s)
+{
+    virtio_snd_ctrl_command *cmd;
+
+    if (unlikely(qatomic_read(&s->processing_cmdq))) {
+        return;
+    }
+
+    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
+        qatomic_set(&s->processing_cmdq, true);
+        while (!QTAILQ_EMPTY(&s->cmdq)) {
+            cmd = QTAILQ_FIRST(&s->cmdq);
+
+            /* process command */
+            process_cmd(s, cmd);
+
+            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+
+            virtio_snd_ctrl_cmd_free(cmd);
+        }
+        qatomic_set(&s->processing_cmdq, false);
+    }
+}
+
+/*
+ * The control message handler. Pops an element from the control virtqueue,
+ * and stores them to VirtIOSound's cmdq queue and finally calls
+ * virtio_snd_process_cmdq() for processing.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: Control virtqueue
+ */
+static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    VirtQueueElement *elem;
+    virtio_snd_ctrl_command *cmd;
+
+    trace_virtio_snd_handle_ctrl(vdev, vq);
+
+    if (!virtio_queue_ready(vq)) {
+        return;
+    }
+
+    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    while (elem) {
+        cmd = g_new0(virtio_snd_ctrl_command, 1);
+        cmd->elem = elem;
+        cmd->vq = vq;
+        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
+        QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
+        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
+    }
+
+    virtio_snd_process_cmdq(s);
+}
+
+/*
+ * The event virtqueue handler.
+ * Not implemented yet.
+ *
+ * @vdev: VirtIOSound device
+ * @vq: event vq
+ */
+static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
+{
+    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented.\n");
+    trace_virtio_snd_handle_event();
+}
+
+/*
+ * Stub buffer virtqueue handler.
  *
  * @vdev: VirtIOSound device
  * @vq: virtqueue
  */
-static void virtio_snd_handle_queue(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -138,68 +545,134 @@ virtio_snd_vm_state_change(void *opaque, bool running,
 static void virtio_snd_realize(DeviceState *dev, Error **errp)
 {
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    virtio_snd_pcm_set_params default_params = { 0 };
+    uint32_t status;
 
+    vsnd->pcm = NULL;
     vsnd->vmstate =
         qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
 
     trace_virtio_snd_realize(vsnd);
 
+    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
+    vsnd->pcm->snd = vsnd;
+    vsnd->pcm->streams =
+        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
+    vsnd->pcm->pcm_params =
+        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
+
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
 
+    /* set default params for all streams */
+    default_params.features = 0;
+    default_params.buffer_bytes = cpu_to_le32(8192);
+    default_params.period_bytes = cpu_to_le32(2048);
+    default_params.channels = 2;
+    default_params.format = VIRTIO_SND_PCM_FMT_S16;
+    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_event);
     vsnd->queues[VIRTIO_SND_VQ_TX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     vsnd->queues[VIRTIO_SND_VQ_RX] =
-        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
+        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
+    qemu_mutex_init(&vsnd->cmdq_mutex);
+    QTAILQ_INIT(&vsnd->cmdq);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
+        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
+            error_setg(errp,
+                       "Can't initalize stream params, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+        status = virtio_snd_pcm_prepare(vsnd, i);
+        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+    }
 }
 
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
+    VirtIOSoundPCMStream *stream;
 
     qemu_del_vm_change_state_handler(vsnd->vmstate);
     trace_virtio_snd_unrealize(vsnd);
 
+    if (vsnd->pcm) {
+        if (vsnd->pcm->streams) {
+            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+                stream = vsnd->pcm->streams[i];
+                if (stream) {
+                    virtio_snd_process_cmdq(stream->s);
+                    virtio_snd_pcm_close(stream);
+                    g_free(stream);
+                }
+            }
+            g_free(vsnd->pcm->streams);
+        }
+        g_free(vsnd->pcm->pcm_params);
+        g_free(vsnd->pcm);
+        vsnd->pcm = NULL;
+    }
     AUD_remove_card(&vsnd->card);
+    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
     virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_RX]);
     virtio_cleanup(vdev);
 }
 
 
-static void virtio_snd_reset(VirtIODevice *vdev) {}
+static void virtio_snd_reset(VirtIODevice *vdev)
+{
+    VirtIOSound *s = VIRTIO_SND(vdev);
+    virtio_snd_ctrl_command *cmd;
+
+    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
+        while (!QTAILQ_EMPTY(&s->cmdq)) {
+            cmd = QTAILQ_FIRST(&s->cmdq);
+            QTAILQ_REMOVE(&s->cmdq, cmd, next);
+            virtio_snd_ctrl_cmd_free(cmd);
+        }
+    }
+}
 
 static void virtio_snd_class_init(ObjectClass *klass, void *data)
 {
diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-snd.h
index 934e854a80..4b4aaffff1 100644
--- a/include/hw/virtio/virtio-snd.h
+++ b/include/hw/virtio/virtio-snd.h
@@ -67,13 +67,122 @@ typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
 /* I/O request status */
 typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
 
-typedef struct VirtIOSound {
+/* device structs */
+
+typedef struct VirtIOSound VirtIOSound;
+
+typedef struct VirtIOSoundPCMStream VirtIOSoundPCMStream;
+
+typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
+
+typedef struct VirtIOSoundPCM VirtIOSoundPCM;
+
+struct VirtIOSoundPCM {
+    VirtIOSound *snd;
+    /*
+     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
+     * field, because the operation of PCM control requests is first
+     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
+     * means that some times we get parameters without having an allocated
+     * stream yet.
+     */
+    virtio_snd_pcm_set_params *pcm_params;
+    VirtIOSoundPCMStream **streams;
+};
+
+struct VirtIOSoundPCMStream {
+    VirtIOSoundPCM *pcm;
+    virtio_snd_pcm_info info;
+    virtio_snd_pcm_set_params params;
+    uint32_t id;
+    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
+    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
+    VirtIOSound *s;
+    bool flushing;
+    audsettings as;
+    union {
+        SWVoiceIn *in;
+        SWVoiceOut *out;
+    } voice;
+    bool active;
+};
+
+/*
+ * PCM stream state machine.
+ * -------------------------
+ *
+ * 5.14.6.6.1 PCM Command Lifecycle
+ * ================================
+ *
+ * A PCM stream has the following command lifecycle:
+ * - `SET PARAMETERS`
+ *   The driver negotiates the stream parameters (format, transport, etc) with
+ *   the device.
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
+ * - `PREPARE`
+ *   The device prepares the stream (allocates resources, etc).
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`, `START`,
+ *   `RELEASE`. Output only: the driver transfers data for pre-buffing.
+ * - `START`
+ *   The device starts the stream (unmute, putting into running state, etc).
+ *   Possible valid transitions: `STOP`.
+ *   The driver transfers data to/from the stream.
+ * - `STOP`
+ *   The device stops the stream (mute, putting into non-running state, etc).
+ *   Possible valid transitions: `START`, `RELEASE`.
+ * - `RELEASE`
+ *   The device releases the stream (frees resources, etc).
+ *   Possible valid transitions: `SET PARAMETERS`, `PREPARE`.
+ *
+ * +---------------+ +---------+ +---------+ +-------+ +-------+
+ * | SetParameters | | Prepare | | Release | | Start | | Stop  |
+ * +---------------+ +---------+ +---------+ +-------+ +-------+
+ *         |-             |           |          |         |
+ *         ||             |           |          |         |
+ *         |<             |           |          |         |
+ *         |------------->|           |          |         |
+ *         |<-------------|           |          |         |
+ *         |              |-          |          |         |
+ *         |              ||          |          |         |
+ *         |              |<          |          |         |
+ *         |              |--------------------->|         |
+ *         |              |---------->|          |         |
+ *         |              |           |          |-------->|
+ *         |              |           |          |<--------|
+ *         |              |           |<-------------------|
+ *         |<-------------------------|          |         |
+ *         |              |<----------|          |         |
+ *
+ * CTRL in the VirtIOSound device
+ * ==============================
+ *
+ * The control messages that affect the state of a stream arrive in the
+ * `virtio_snd_handle_ctrl()` queue callback and are of type `struct
+ * virtio_snd_ctrl_command`. They are stored in a queue field in the device
+ * type, `VirtIOSound`. This allows deferring the CTRL request completion if
+ * it's not immediately possible due to locking/state reasons.
+ *
+ * The CTRL message is finally handled in `process_cmd()`.
+ */
+struct VirtIOSound {
     VirtIODevice parent_obj;
 
     VirtQueue *queues[VIRTIO_SND_VQ_MAX];
     uint64_t features;
+    VirtIOSoundPCM *pcm;
     QEMUSoundCard card;
     VMChangeStateEntry *vmstate;
     virtio_snd_config snd_conf;
-} VirtIOSound;
+    QemuMutex cmdq_mutex;
+    QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
+    bool processing_cmdq;
+};
+
+struct virtio_snd_ctrl_command {
+    VirtQueueElement *elem;
+    VirtQueue *vq;
+    virtio_snd_hdr ctrl;
+    virtio_snd_hdr resp;
+    QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
+};
 #endif
-- 
2.39.2


