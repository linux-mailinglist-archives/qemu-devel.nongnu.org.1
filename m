Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68D78B8C7
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiLO-0002ds-Lx; Mon, 28 Aug 2023 15:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiL4-0002bo-Vd
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qaiL1-0005Fl-W7
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:55:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so2958084f8f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693252550; x=1693857350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiCDIDFSx7D+sLC5aPLD5ps2JmBpb3LK0Z9r5AQxoMc=;
 b=Wjirp41udaI4C+oPyY8/t6wO5hcm9a36MDcFBuaOfMXmJl2L84T8ggOj7Lb6vhR1E1
 MsAm97fGlvgfubj5fDpniRumNVhXfjthl7r8JBA/IS1EaMcJF+fisA/RYjpauAVl9Y86
 T1z1JTJpWJi6JwRs/fanACa6byeAHzrq+yPATN+5Q5RQgh4dKzp5wOpcPMPkYtAUQTSL
 LLQZ+GdXmkVucnl2MRC+jpfKBKK048SPJRwkaaCUTKqha26idSYg+kj5UDa61EvX2fpZ
 Lg6K4UzaDveuBiAIJF85hI+c0Z3NdmqUTx12ScBlbUrwqKN3iRifCnzauAyDXxs3XJ3f
 gviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693252550; x=1693857350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiCDIDFSx7D+sLC5aPLD5ps2JmBpb3LK0Z9r5AQxoMc=;
 b=hE3ttHFR8qmSoZnx+3xNAQIDIWj8XkThtZBbknM+shTuzczcFbgdoxd/5vyZgCxmJY
 /+gY2Qz1e2InJLz7wn1PIO1QOvlTlgyT9iW4/y+eHUeowoiF+KT6zFky+7s69Nm+C8vo
 hxNE5wlo3JcPAaISv1W8ConuXOJGxMaUzGGnHwli1tDbvtDclchTJOOa+Yk8T3tnKVMS
 8N2ZpuOpZ9jMc5LepEvK9dgrWfiiqOmqKDArg+6PTQ9E+6OAUaZc3uUpC5ocd8j8agPF
 JwRHaRr7zYrB59fkZLxcgjwxyw/xRR8zNX4BbdvaPVAVGnAGbmjMclaKjQRwvEOnwbT2
 cWuQ==
X-Gm-Message-State: AOJu0YycqRyt42enIQXmcDKE/rElsWJFcgIVW//lLi8Ss9x/LMKgzACa
 /l7XANGK4z54Mtw1ECdqAzv7NvTmvmth9DK86j0=
X-Google-Smtp-Source: AGHT+IHX9+XsYHI6D5R4OCbIiezlasnpgKYtuWi6lURlYz66Wwj/TS7GVYrNTgoVZGuNe/4mVUi2yA==
X-Received: by 2002:a5d:6d01:0:b0:31d:1833:4130 with SMTP id
 e1-20020a5d6d01000000b0031d18334130mr4095654wrq.71.1693252550336; 
 Mon, 28 Aug 2023 12:55:50 -0700 (PDT)
Received: from localhost.localdomain (adsl-194.37.6.2.tellas.gr. [37.6.2.194])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0031c8a43712asm7529717wrz.69.2023.08.28.12.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:55:49 -0700 (PDT)
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
Subject: [PATCH v8 04/12] virtio-sound: set PCM stream parameters
Date: Mon, 28 Aug 2023 22:55:01 +0300
Message-Id: <6b3f8d8206d4ec73703ce100c0b08002391e0bae.1693252037.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x431.google.com
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

This commit sets the virtio-snd device's default PCM parameters in
virtio_snd_pcm_set_params_impl(). The same function will be used to set
parameters from the guest with VIRTIO_SND_R_PCM_SET_PARAMS in a
follow-up commit.

PCM parameters describe the sound card parameters that the guest's
kernel sees as an ALSA device.

Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-snd.c | 258 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 250 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index b921903905..25c3539509 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -31,6 +31,29 @@
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
 static const char *print_code(uint32_t code)
 {
     #define CASE(CODE)            \
@@ -111,6 +134,206 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
 }
 
+/*
+ * Get params for a specific stream.
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
+                                                       uint32_t stream_id)
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
+                                   virtio_snd_pcm_set_params *params)
+{
+    VirtIOSoundPCMParams *st_params;
+    uint32_t stream_id = params->hdr.stream_id;
+
+    if (stream_id >= s->snd_conf.streams || !(s->pcm->pcm_params)) {
+        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
+    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
+        error_report("Number of channels is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    if (!(supported_formats & BIT(params->format))) {
+        error_report("Stream format is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    if (!(supported_rates & BIT(params->rate))) {
+        error_report("Stream rate is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+
+    st_params->buffer_bytes = params->buffer_bytes;
+    st_params->period_bytes = params->period_bytes;
+    st_params->features = params->features;
+    st_params->channels = params->channels;
+    st_params->format = params->format;
+    st_params->rate = params->rate;
+
+    return VIRTIO_SND_S_OK;
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
+                                            VirtIOSoundPCMParams *params)
+{
+    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
+    as->fmt = virtio_snd_get_qemu_format(params->format);
+    as->freq = virtio_snd_get_qemu_freq(params->rate);
+    as->endianness = AUDIO_HOST_ENDIANNESS;
+}
+
+/*
+ * Close a stream and free all its resources.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
+{
+    if (stream) {
+        qemu_mutex_destroy(&stream->queue_mutex);
+        g_free(stream);
+    }
+}
+
+/*
+ * Prepares a VirtIOSound card stream.
+ * Returns the response status code. (VIRTIO_SND_S_*).
+ *
+ * @s: VirtIOSound device
+ * @stream_id: stream id
+ */
+static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
+{
+    audsettings as;
+    VirtIOSoundPCMParams *params;
+    VirtIOSoundPCMStream *stream;
+
+    if (!s->pcm->streams ||
+        !s->pcm->pcm_params ||
+        stream_id >= s->snd_conf.streams) {
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    params = virtio_snd_pcm_get_params(s, stream_id);
+    if (!params) {
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    virtio_snd_get_qemu_audsettings(&as, params);
+
+    virtio_snd_pcm_close(s->pcm->streams[stream_id]);
+
+    stream = g_new0(VirtIOSoundPCMStream, 1);
+
+    stream->id = stream_id;
+    stream->pcm = s->pcm;
+    stream->direction = stream_id < s->snd_conf.streams / 2 +
+        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
+    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
+    stream->features = 0;
+    stream->channels_min = 1;
+    stream->channels_max = as.nchannels;
+    stream->formats = supported_formats;
+    stream->rates = supported_rates;
+    stream->s = s;
+
+    stream->buffer_bytes = params->buffer_bytes;
+    stream->period_bytes = params->period_bytes;
+
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+
+    stream->as = as;
+    stream->desired_as = stream->as;
+    qemu_mutex_init(&stream->queue_mutex);
+    QSIMPLEQ_INIT(&stream->queue);
+
+    s->pcm->streams[stream_id] = stream;
+
+    return VIRTIO_SND_S_OK;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -299,6 +522,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    virtio_snd_pcm_set_params default_params = { 0 };
+    uint32_t status;
 
     vsnd->pcm = NULL;
     vsnd->vmstate =
@@ -334,6 +559,13 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
 
     AUD_register_card("virtio-sound", &vsnd->card);
 
+    /* set default params for all streams */
+    default_params.features = 0;
+    default_params.buffer_bytes = 8192;
+    default_params.period_bytes = 2048;
+    default_params.channels = 2;
+    default_params.format = VIRTIO_SND_PCM_FMT_S16;
+    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
         virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] =
@@ -344,15 +576,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
         virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
-}
 
-/*
- * Close the stream and free its resources.
- *
- * @stream: VirtIOSoundPCMStream *stream
- */
-static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
-{
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        default_params.hdr.stream_id = i;
+        status = virtio_snd_set_pcm_params(vsnd, &default_params);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't initalize stream params, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+        status = virtio_snd_pcm_prepare(vsnd, i);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+    }
 }
 
 static void virtio_snd_unrealize(DeviceState *dev)
@@ -382,6 +623,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
         vsnd->pcm = NULL;
     }
     AUD_remove_card(&vsnd->card);
+    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_cleanup(vdev);
 }
 
-- 
2.39.2


