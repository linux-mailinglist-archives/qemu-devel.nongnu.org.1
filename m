Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC5784A27
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWuR-0004yJ-TH; Tue, 22 Aug 2023 15:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuP-0004j5-Ft
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qYWuM-0000om-MQ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:19:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3feef504ccbso25489665e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692731956; x=1693336756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=welZIUMZEiDKfmjKyBpIyFq4/JIev+y1raHS+mWXST8=;
 b=DFIQOD27wjxSlpDPc3lOoABYNpThHJCAp55ihFifPWtlLx9FOLyhzgEC1KhegmPR8l
 mVrWGuqPIFup7iXB5C+nA2WcBZ64jwy4P7YijRUePuXAIVCaTP3G/9Go6GXWDLKmnkW9
 CPhuJNBYs1GexIcWkp0qVkDh8CGlyHV0cF7iWePZC8pzXiKCyhH4KTPV4OYV/KAJnfWG
 old8/DlsbaakYcb8OSqjgG2fEUdmLmwCpOVzbN28LB751gqbXdeQCr1gb9/cc4tP8c9B
 9a2z3kMor4O9RqEkBlcT3PnzGdaX0cJmpi3Z4xG7VTMscJ3nZYcRErhDWate3udKMzkZ
 fYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692731956; x=1693336756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=welZIUMZEiDKfmjKyBpIyFq4/JIev+y1raHS+mWXST8=;
 b=TGcp/TS/jNtBM/B0wWDAUB6sEu/xT9I5VbksfXng83EOzcpfo3BQ92qi9AKyLWPsm3
 iyJz8UZ1S5bLy1+wh7Q+vfrXSlHsojSc8pHoudBr/nYJNUwYdn9b1QYVmOe489l/All9
 gUbOg/l1VqVPCPQNhqbfcY4iFR1H0SNQ9vXYM85sYCygWTO5cMoT0vQet3orvb5Z0n+8
 CKQrQ8g6hyT/rVvKQrp3G0bxyEgVbAWG9oGOXmVYZlo75ZkwsMDcRLZO10cjzEzJUsMs
 YkwrOdGjqXVl0NhKwDpx79nuYeIuyHGw21LrP22v+xTnjRpn3nEIzoyLqnEBIpjRf0B4
 /znw==
X-Gm-Message-State: AOJu0YzMfK7BUItwHLJWzzmssKWwL8q8XoXBgol0296sNfF7GP1teJP9
 Gp92m22Lje3D8TvcS1ahpyd5CntDj4+aQeksfsw=
X-Google-Smtp-Source: AGHT+IGAqq00lm0WALz4p7/aUAfovyHg2Vwgh0YUDyWHseWB5o/wt2kueIaZLhNNM1qO2S3gPQY4Ow==
X-Received: by 2002:a05:600c:3655:b0:3fe:43b4:55c with SMTP id
 y21-20020a05600c365500b003fe43b4055cmr8222986wmq.30.1692731955588; 
 Tue, 22 Aug 2023 12:19:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.109.242.225.tellas.gr.
 [109.242.225.200]) by smtp.gmail.com with ESMTPSA id
 n4-20020a05600c294400b003fe2a40d287sm126905wmd.1.2023.08.22.12.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 12:19:15 -0700 (PDT)
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
Subject: [PATCH v7 04/12] virtio-sound: set PCM stream parameters
Date: Tue, 22 Aug 2023 22:18:27 +0300
Message-Id: <34afff149a90bf1f7be183aa3907fbfe3b96daba.1692731646.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32e.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-snd.c | 260 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 251 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index b23f8040e1..dec76ffcb1 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -30,6 +30,29 @@
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
@@ -110,6 +133,206 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
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
+uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
+                                        virtio_snd_pcm_set_params *params)
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
+static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
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
@@ -291,6 +514,8 @@ static void virtio_snd_common_realize(DeviceState *dev,
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
+    virtio_snd_pcm_set_params default_params = { 0 };
+    uint32_t status;
 
     virtio_snd_set_pcm(vsnd);
 
@@ -320,12 +545,37 @@ static void virtio_snd_common_realize(DeviceState *dev,
 
     AUD_register_card("virtio-sound", &vsnd->card);
 
+    /* set default params for all streams */
+    default_params.features = 0;
+    default_params.buffer_bytes = 16384;
+    default_params.period_bytes = 4096;
+    default_params.channels = 2;
+    default_params.format = VIRTIO_SND_PCM_FMT_S16;
+    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
     vsnd->queues[VIRTIO_SND_VQ_CONTROL] = virtio_add_queue(vdev, 64, ctrl);
     vsnd->queues[VIRTIO_SND_VQ_EVENT] = virtio_add_queue(vdev, 64, evt);
     vsnd->queues[VIRTIO_SND_VQ_TX] = virtio_add_queue(vdev, 64, txq);
     vsnd->queues[VIRTIO_SND_VQ_RX] = virtio_add_queue(vdev, 64, rxq);
     qemu_mutex_init(&vsnd->cmdq_mutex);
     QTAILQ_INIT(&vsnd->cmdq);
+
+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
+        default_params.hdr.stream_id = i;
+        status = virtio_snd_pcm_set_params_impl(vsnd, &default_params);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't initalize stream params, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+        status = virtio_snd_pcm_prepare_impl(vsnd, i);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return;
+        }
+    }
 }
 
 static void
@@ -357,15 +607,6 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
                               errp);
 }
 
-/*
- * Close the stream and free its resources.
- *
- * @stream: VirtIOSoundPCMStream *stream
- */
-static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
-{
-}
-
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -393,6 +634,7 @@ static void virtio_snd_unrealize(DeviceState *dev)
         vsnd->pcm = NULL;
     }
     AUD_remove_card(&vsnd->card);
+    qemu_mutex_destroy(&vsnd->cmdq_mutex);
     virtio_cleanup(vdev);
 }
 
-- 
2.39.2


