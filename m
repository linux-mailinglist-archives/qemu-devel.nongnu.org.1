Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A479E0DD
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKOG-0006VN-3V; Wed, 13 Sep 2023 03:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOD-0006UO-SX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qgKOA-0001mm-To
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:34:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso68361085e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 00:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694590457; x=1695195257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bb1NYBdrR/WFMFHzWP4TZT8EFZHgdb0cpC8+z7RKEgU=;
 b=YPsIbUkt11ZHePK3m78P8wE3dY0hTvrUOOzPfq/9uPQODGcl3LOuAV+obD09xC7Pxa
 sellkm7HpjQDE86j/Fkq7ZEOAQs+yNi5fHJkBwovMZr94GKXUWAtZlice7J7krfmgqV2
 KdzFVj/IQzpt1Ta5FkQepquFvIvwdSmP+VQKSFCsiYj2qxpEFPsISWa3mjuUVLDwDZLA
 +VGOQE5nIAUrai/QLBF8rip+TT/gVsUrs4dTfD7YWwSxoqZIH8yHhfBSVedC4uXbWMX9
 xF1vE2abTs8tSpFmua8wfYzf/utg74Yo3qAYuo8MD7YUKYIJfT1y+MrYxmr19vf2FgNk
 kYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694590457; x=1695195257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bb1NYBdrR/WFMFHzWP4TZT8EFZHgdb0cpC8+z7RKEgU=;
 b=cJZz3DUg2Z1wHC4tnPwDhnrllEwV2ytbQg46oTO+yORp49iGGy5DJ47AZZrAbYselZ
 LL0JVZwAEe2FrIFrfiXqiXxMy/OvVEQlD8RMJu1SVGDLGA7BTafxVhop0V+sOjKn47eo
 9EeNEEiiir6LJfekpZa0brr056ff5AJuC7E1Km9D1N/OiHB3l7jzawBAP8cPLtpUxXhc
 6qRjYkG5YnwvIQVhui3js5uiVbXTdJ3TStSfLps/Yn7e7dHco4Niens9EZHQWgBAk/45
 zt9YxkfbmqqQqqgJPhy2LcUeZnzYEm/NKKg2/lMH4lY0t6aXPo4lyWnPRFgIUyjkTIUv
 QLSw==
X-Gm-Message-State: AOJu0YxnoFf/wouZSh9P7qHxv3Oq+zZZdOSoCi4p7ZDEhgB9Io/0IKMA
 w2j2WwgXn9HfuJGLA9rQ77DgD4KCT5A8ItXcwlw=
X-Google-Smtp-Source: AGHT+IFI2aAjSQxwpt/YBmWZUvHs1Nk4SNK/8izILCAAz6H5tXBcPSYYgFbHF2kihvggj1UP5tmKXQ==
X-Received: by 2002:adf:ecc8:0:b0:319:7b66:7800 with SMTP id
 s8-20020adfecc8000000b003197b667800mr1274613wro.55.1694590457061; 
 Wed, 13 Sep 2023 00:34:17 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 l16-20020a5d5270000000b0031c6ae19e27sm14701671wrc.99.2023.09.13.00.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 00:34:16 -0700 (PDT)
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
Subject: [PATCH v9 04/12] virtio-sound: set PCM stream parameters
Date: Wed, 13 Sep 2023 10:33:11 +0300
Message-Id: <7413b85f081df558dfe5c8423f407a5fc7f6a433.1694588927.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
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
 hw/virtio/virtio-snd.c | 266 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 258 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index cb5573935d..dea4ce6305 100644
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
@@ -97,6 +120,215 @@ virtio_snd_ctrl_cmd_free(virtio_snd_ctrl_command *cmd)
     g_free(cmd);
 }
 
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
+    if (stream_id >= s->snd_conf.streams || !(s->pcm->pcm_params)) {
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
+    virtio_snd_pcm_set_params *params;
+    VirtIOSoundPCMStream *stream;
+
+    if (!s->pcm->streams ||
+        !s->pcm->pcm_params ||
+        stream_id >= s->snd_conf.streams) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    params = virtio_snd_pcm_get_params(s, stream_id);
+    if (!params) {
+        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
+    }
+
+    stream = virtio_snd_pcm_get_stream(s, stream_id);
+    virtio_snd_pcm_close(stream);
+    if (!stream) {
+        stream = g_new0(VirtIOSoundPCMStream, 1);
+        stream->id = stream_id;
+        stream->pcm = s->pcm;
+        stream->s = s;
+        qemu_mutex_init(&stream->queue_mutex);
+        QSIMPLEQ_INIT(&stream->queue);
+
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
+
+    stream->params.buffer_bytes = params->buffer_bytes;
+    stream->params.period_bytes = params->period_bytes;
+
+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
+    stream->as = as;
+
+    return cpu_to_le32(VIRTIO_SND_S_OK);
+}
+
 static const char *print_code(uint32_t code)
 {
     #define CASE(CODE)            \
@@ -298,6 +530,8 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
     ERRP_GUARD();
     VirtIOSound *vsnd = VIRTIO_SND(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+    virtio_snd_pcm_set_params default_params = { 0 };
+    uint32_t status;
 
     vsnd->pcm = NULL;
     vsnd->vmstate =
@@ -336,6 +570,13 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
 
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
@@ -346,15 +587,23 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
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
@@ -373,6 +622,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
                 if (stream) {
                     virtio_snd_process_cmdq(stream->s);
                     virtio_snd_pcm_close(stream);
+                    qemu_mutex_destroy(&stream->queue_mutex);
                     g_free(stream);
                 }
             }
-- 
2.39.2


