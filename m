Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A887D767EC9
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhLk-00005i-Cw; Sat, 29 Jul 2023 06:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLh-0008Pe-QI
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qPhLg-000166-7B
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 06:39:01 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-316feb137a7so3086333f8f.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 03:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690627138; x=1691231938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qMqK+wZaQpSLsT7aCCcs1/xfHis4zgE5fANu8jf6wDQ=;
 b=lhgKhwYEcr2s1Y9NfLf/QeAczCAFuuLIEKuW58Xx5ELEW1J6niwPpIHuY7gEAp+MMt
 CJHcVq47mjkAKHWRplpnHv8BfWor32Tme0Mra81GaPioXbE8AeGamYCw1T1V6xyoxDNn
 hezs2KPLvmvGotkEm+p2NzyZkyq/iMHCub9tNZBHOGAsaZPoAztV4UPQRSpe7/OVvKnh
 i0WBg2KrjiWt8xG0/yoicpcDkwKT2UinY74sEULNlkdNVYlXCv0fXD26d5SSde9ddpGZ
 nO1iD1UWrYuOIWnuPbVB4x9GjLF7GssKAN4lSahzczhC9pXeEB7klu4xqOWT1+Gg/iUO
 +U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690627138; x=1691231938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMqK+wZaQpSLsT7aCCcs1/xfHis4zgE5fANu8jf6wDQ=;
 b=jaJ5sM9WjPvb2o627SRi+wkdmMYQ8EfxAnChC9kmlP17acgUvXoZiesgBswE45xtVE
 YHhmBWtW0fJRrxk3skM4P0DxPYh5r1ZKYengsejUuMNUV3ez3F7ZjJwsjz+giQFFBBA+
 J5pdtgfS4F60/lTtXZD197IyDHZfSGbMFWsN3jc7XlUZZzr6xXIgxL45X6l+0w8PaEdv
 Spu/lJ6TdOWFSlKeDolVV47nLKN+ulAf+zioz85k6kOyfzBTmQET5CfvZgliVa4p74Kp
 rp80lbOJFcK78lD0nn7SK9qQaSNKnSmuWPaK6ggGnRSerhZUiOO217SyHzYFt/t1YOHZ
 ST3w==
X-Gm-Message-State: ABy/qLaTTvYO1xoRjaKixS6hE42ZWIJdX3ZV+Z1KT9qzubZVBGmkmfKK
 TazDYi7iDPao0CjCDLto4moRmV2VvYgWjkhU/OnUng==
X-Google-Smtp-Source: APBJJlGVRYqvDT/2CfDYFAHalTQooP2iB3N4PD57GHqRwPGvVuD400clXVx+CYWVsSvIaESTTptmhg==
X-Received: by 2002:adf:ec8f:0:b0:313:e741:1caa with SMTP id
 z15-20020adfec8f000000b00313e7411caamr4029668wrn.25.1690627138696; 
 Sat, 29 Jul 2023 03:38:58 -0700 (PDT)
Received: from localhost.localdomain (adsl-200.37.6.161.tellas.gr.
 [37.6.161.200]) by smtp.gmail.com with ESMTPSA id
 x20-20020a1c7c14000000b003fc01f7b415sm8984777wmc.39.2023.07.29.03.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jul 2023 03:38:58 -0700 (PDT)
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
Subject: [PATCH v5 05/12] virtio-sound: prepare PCM streams
Date: Sat, 29 Jul 2023 13:36:57 +0300
Message-Id: <19d95e841157a6a6d88e60e749025f487f010d22.1690626150.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
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
index dda724f3ce..4d69f2003a 100644
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
@@ -437,6 +563,13 @@ static void virtio_snd_common_realize(DeviceState *dev,
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


