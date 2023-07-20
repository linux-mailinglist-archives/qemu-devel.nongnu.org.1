Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF26A75AEE7
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTEe-0005PL-Cm; Thu, 20 Jul 2023 08:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEY-0005DX-3D
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:18 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qMTEV-0004Hu-Fb
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:58:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142970df44so626527f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689857892; x=1690462692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjl/1n+mQgCku0rCqPi039Kzl5u/s+/8eKT/XrYc3Zc=;
 b=DxopRcGq9NI30L8l/aUxzYEj38oZEfSWuQwkj3w8hjcubAT+pLJMraNTEhtLTkXGUN
 e60ubIgbDs+C15ekXinWQpiLNt4kMrMlx7vrY1yi/XOaLakgHnlMpdxLyw/hv1+EjyIy
 rj49j6zHnbr0nvWnZymhAp2SD4x6VZIZc+3Iunwm7h+1YHep1hGgW/V8apZlzTWRn8iP
 P7N3/rFzyARPByoM//kK3cNbQsx42FarT+2NKQIFc9ys8FyvveEW+xz/wVtkcAv6xav5
 69QfuGTnVbF+OBJpSxIUqylgm6EhSvluxaH2B2DvoIF5s34CvdIievIzGOY08fkfQ/q2
 U6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689857892; x=1690462692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tjl/1n+mQgCku0rCqPi039Kzl5u/s+/8eKT/XrYc3Zc=;
 b=TGqaJMhOPWx05kBEO4QKU6m1RgTQtYz1K0U6QaeNPdNHDv1BjvCTEep9cMVHizcuaA
 juIbY02SiruGjwxkztoEPh6J4EyYqD3/diPTobNx2QYNbBex+XF4llVIKylSHvSuVdHu
 K6xCafTbcTXb+Qt9FqT3QI21qF7Lf8aNMUIsJTWuTK65Ll38iIa83+oVP2GRQVfF3uJs
 P/Ig+figyOrEivJPcNyA17jGIohm4I8xGe6gjnB8vUZoeplzyelgbKkWXLSTVA5zWZz9
 3jG3w1k0b/KGC5ZMR7BMYryfIQglX7fOH6edFOL4XE5jiOQ+D5X7lwcpE+yUlHkccsfK
 kzZQ==
X-Gm-Message-State: ABy/qLZjABgmZ+DrZUvLac8akk+3rBZ32ow89XNkgzaxadedcG598/mN
 7kswvZfJ781dNYki9OGSpA8kxwjzRyTHS5O2qkDmZAoi
X-Google-Smtp-Source: APBJJlGfy+u22b9q+dVS6bLIsFStdLufMVzZG48oCBlFDQgzDELrhrmOIe3UvYjST8eg9t1AvtRg0g==
X-Received: by 2002:adf:f6c6:0:b0:314:6057:66b8 with SMTP id
 y6-20020adff6c6000000b00314605766b8mr2012977wrp.59.1689857892653; 
 Thu, 20 Jul 2023 05:58:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-41.37.6.162.tellas.gr.
 [37.6.162.41]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b003063a92bbf5sm1294816wrs.70.2023.07.20.05.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 05:58:12 -0700 (PDT)
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
Subject: [PATCH v4 04/12] virtio-sound: set PCM stream parameters
Date: Thu, 20 Jul 2023 15:57:05 +0300
Message-Id: <bbd1799fc9297f5cd63c138fa52c6144b6930c4d.1689857559.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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

This commit sets the virtio-snd device's default PCM parameters in
virtio_snd_pcm_set_params_impl(). The same function will be used to set
parameters from the guest with VIRTIO_SND_R_PCM_SET_PARAMS in a
follow-up commit.

PCM parameters describe the sound card parameters that the guest's
kernel sees as an ALSA device.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-snd.c | 109 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 5a0c2c7594..62d9bf557c 100644
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
@@ -111,6 +134,72 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
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
+        : s->pcm->pcm_params[stream_id];
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
+    if (stream_id > s->snd_conf.streams || !(s->pcm->pcm_params)) {
+        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
+        return VIRTIO_SND_S_BAD_MSG;
+    }
+
+    if (!s->pcm->pcm_params[stream_id]) {
+        s->pcm->pcm_params[stream_id] = g_new0(VirtIOSoundPCMParams, 1);
+    }
+    st_params = virtio_snd_pcm_get_params(s, stream_id);
+
+    st_params->features = params->features;
+    st_params->buffer_bytes = params->buffer_bytes;
+    st_params->period_bytes = params->period_bytes;
+
+    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
+        error_report("Number of channels is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->channels = params->channels;
+
+    if (!(supported_formats & BIT(params->format))) {
+        error_report("Stream format is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->format = params->format;
+
+    if (!(supported_rates & BIT(params->rate))) {
+        error_report("Stream rate is not supported.");
+        return VIRTIO_SND_S_NOT_SUPP;
+    }
+    st_params->rate = params->rate;
+    st_params->period_bytes = params->period_bytes;
+    st_params->buffer_bytes = params->buffer_bytes;
+
+    return VIRTIO_SND_S_OK;
+}
+
 /*
  * The actual processing done in virtio_snd_process_cmdq().
  *
@@ -290,6 +379,8 @@ static void virtio_snd_common_realize(DeviceState *dev,
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIOSound *vsnd = VIRTIO_SND(dev);
+    virtio_snd_pcm_set_params default_params;
+    uint32_t status;
 
     virtio_snd_set_pcm(vsnd);
 
@@ -318,12 +409,30 @@ static void virtio_snd_common_realize(DeviceState *dev,
 
     AUD_register_card("virtio-sound", &vsnd->card);
 
+    /* set default params for all streams */
+    default_params.features = 0;
+    default_params.buffer_bytes = 8192;
+    default_params.period_bytes = 4096;
+    default_params.channels = 2;
+    default_params.format = VIRTIO_SND_PCM_FMT_S16;
+    default_params.rate = VIRTIO_SND_PCM_RATE_44100;
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
+    }
 }
 
 static void
-- 
2.39.2


