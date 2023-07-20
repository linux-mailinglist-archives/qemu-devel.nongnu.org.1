Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681775AEEC
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTEe-0005S8-RR; Thu, 20 Jul 2023 08:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEa-0005IV-7p
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEX-0004Mv-SP
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3172144c084so664318f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857896; x=1690462696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZuVw3BQUrnbNc2JtnQAnYlXBBxw+U/MPRXh9Zf7n8E=;
 b=e3IATNBd18tyw1lEYqOE/CStucugW8RsYOjuj6wzHfH/w4YvHge9OCsC7Dtv1/MPD0
 ZufphZPIva79bVxvg0ajuCZY6R51c3TiEo6XX45nvM1wrkHs9wufZXLpqYz3QOnjBtCU
 XAJY+RKhrw8zibyAPfTJgdl+V58VVmcdsqhkSIYjgqD0gk1uJlCwmkTiUn6DlU6i77ML
 Cj6smM1koKcksE7RLrt8l+YyfBi9yUpkdFWwTKdIY1md8iI+3iQ17bqJH68b94vs5PnQ
 Q21QVyQFZaIshOxN2Jv4QgB9neBbNL9FNwBKw0bJVWj4dwA56lw4wzpswUYrn1eh9AzD
 yTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857896; x=1690462696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZuVw3BQUrnbNc2JtnQAnYlXBBxw+U/MPRXh9Zf7n8E=;
 b=YE7JGUt2Ata7HK4maYfGOBxgJ4quM98jsKMVogmcaDoBKbUkuO68h2yhfloLKZBP0v
 iswiJO3YnSmMDyMdZsFtDg8gtH7VBOUyhrwRb4c88/SneGJhgsRy185GjinKXHCL18oV
 i2F1n3RZ8m0yDfzyYI246gTmz6Fu8I/I2IkgvdB1BSpMy6Q4AQu5Et8Z+9q2b13AkoZF
 j3nyb2PYvGO8shd54KHoKlrPqnzbJcmi1zEAe5Dz7Z5lE7ipSKtJgHcCuVMMQX21dHeO
 IcvdFYDgb2JaudogokaNhPdgdXU/yYkANc6En4AU7A7nuKJaXk8o2H8Zx9BuqtwgFX9H
 st5Q==
X-Gm-Message-State: ABy/qLb3RaD1JWaTj/uc0ZtYrN7IvGbNC0nIT7g3FOQ6L3Z3mr2OuE1K
 gF2MAKSOvVpXB45/TdRoiGcAPhCQ/JPefJIE0tSehLM5
X-Google-Smtp-Source: APBJJlGfaIa1syxQPhKZwGDPmtoozGkpdXB4IRCbAQe0E7BScGXEhLZbSRhunOqtmZ3DGQ+MjBcr1w==
X-Received: by 2002:adf:f004:0:b0:314:41e8:107d with SMTP id
 j4-20020adff004000000b0031441e8107dmr2385099wro.47.1689857895817; 
 Thu, 20 Jul 2023 05:58:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.58.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:58:15 -0700 (PDT)
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
Subject: [PATCH v4 05/12] virtio-sound: prepare PCM streams
Date: Thu, 20 Jul 2023 15:57:06 +0300
Message-Id: <68a13c43854d00efd62e43f3525a555ff83794bf.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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

After setting PCM parameters, instantiate ("prepare") each stream in
virtio_snd_pcm_prepare_impl().

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-snd.c | 133 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 62d9bf557c..ca09c937c7 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -200,6 +200,132 @@ uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
     return VIRTIO_SND_S_OK;
 }
 
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
+        !s->pcm->pcm_params[stream_id]) {
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
@@ -432,6 +558,13 @@ static void virtio_snd_common_realize(DeviceState *dev,
                        print_code(status));
             return;
         }
+        status = virtio_snd_pcm_prepare_impl(vsnd, i);
+        if (status != VIRTIO_SND_S_OK) {
+            error_setg(errp,
+                       "Can't prepare streams, device responded with %s.",
+                       print_code(status));
+            return;
+        }
     }
 }
 
-- 
2.39.2


