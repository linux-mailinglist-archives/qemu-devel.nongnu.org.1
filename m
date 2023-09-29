Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C737B344E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEBN-0007vP-9l; Fri, 29 Sep 2023 10:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBK-0007uv-46
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qmEBG-0004Ed-0e
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:09:25 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4053c6f0db8so136597805e9.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695996557; x=1696601357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q1cKGouGyfEM4tjE+ANqS7hXqt2/HtXplcO47FfuYoc=;
 b=AmzL04PMAdM99NkKGB75IhwzYLJ7PajagkhB+8YG+P5vapPsSSIoRgcm+ASdSYe2+h
 uVNE64I0Dl8Fn1EhlMnwprVDGvCFFXp/UCDBx9PkerNEzovupmn953wKqLbGc4IKmoEV
 gT4co+ir8j/aK6hUMOPXArj4lDIOvuYUVp7CfqxgZHjpsYuXBp5KPJRnTAi3ABe5Lgjj
 3Wy5HkEtQRgkuSueQaHk/CywMqiz+rw++zA4r/Cd/wuz5PRP1Fl2IF3VZL8tvncnMGLy
 tYcmHQ1cJmEHE4Pl3x08dP+am0IMzCZdxUI2Jd3LCTE2UlwTMZJY8g58YP8xtLQHAtmz
 DaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695996557; x=1696601357;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q1cKGouGyfEM4tjE+ANqS7hXqt2/HtXplcO47FfuYoc=;
 b=QvGwi7E2Ofb8mo1P+q/CxAbfnCa2IVqT2/OFuAlgLuEHCAAWwk63ufBfJl9I76AoTL
 Ozp/2jPshjDcuhbLKuy9+4zlLM2fDO3QV36bNVFSgaW5iMN1o6cWUlEku681HM+BuZ8q
 U7C1li0AgZF3NB3j/utHrEVoWk4p5doLNCieW0J9SQ/aTzUzBZ2ftirkzniqjVyv7Kup
 uZcbHJlOn/iG88QYhZKO+RNBd8ePLUeC7ySiPwRQmJpR3u5DI/Sxel08iJlRApJ/SPJT
 ZM3kmFvz1ZDdTigK9x5BNK6gaVDyXRfatKPcyFrnFogO2xm70FVPGkQ9IX0ePdLblYQb
 vqcw==
X-Gm-Message-State: AOJu0Ywf3q3qV494a1hIu//v07NEErcn/o7fLndNjtpZQsaGdOczK5nn
 /cRK3C9fVVgUH1zsQ9i8LFrM70tx06IWOmEQoRo=
X-Google-Smtp-Source: AGHT+IEqsBX0xmS1IgBZeMonqYs1D7jscvirG0+9H5RXsAzprlPcOAIOx9RqmkhZ6l3hd0ti0QYP1g==
X-Received: by 2002:a7b:cb8b:0:b0:401:2ee0:7558 with SMTP id
 m11-20020a7bcb8b000000b004012ee07558mr4060350wmi.32.1695996554713; 
 Fri, 29 Sep 2023 07:09:14 -0700 (PDT)
Received: from localhost.localdomain (adsl-98.37.6.1.tellas.gr. [37.6.1.98])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a7bcd94000000b004030e8ff964sm1505232wmj.34.2023.09.29.07.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:09:14 -0700 (PDT)
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
Subject: [PATCH v10 00/11] Add VIRTIO sound card
Date: Fri, 29 Sep 2023 17:08:20 +0300
Message-Id: <cover.1695996196.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
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

This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

v10 can be found online at:

https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v10

Ref b720e00121878cb91c9690fd1f9ca609b9484346

Main differences with v9 patch series [^v9]
<cover.1694588927.git.manos.pitsidianakis@linaro.org>:

- Addressed [^v9] review comments.
- Copy buffer data just before playing it on the host instead of when 
  the IO message arrives. This in most cases takes care of the buffer 
  not being populated with data from the guest application when it 
  firsts arrives.

Previously:

[^v9]: 
https://lore.kernel.org/qemu-devel/cover.1694588927.git.manos.pitsidianakis@linaro.org/
[^v8]: 
https://lore.kernel.org/qemu-devel/cover.1693252037.git.manos.pitsidianakis@linaro.org/
[^v7]: 
https://lore.kernel.org/qemu-devel/cover.1692731646.git.manos.pitsidianakis@linaro.org/
[^v6]: 
https://lore.kernel.org/qemu-devel/cover.1692089917.git.manos.pitsidianakis@linaro.org/
[^v5]: 
https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
[^v4]: 
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
[^v3]: 
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/


Emmanouil Pitsidianakis (11):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                        |    7 +
 docs/system/device-emulation.rst   |    1 +
 docs/system/devices/virtio-snd.rst |   49 +
 hw/virtio/Kconfig                  |    5 +
 hw/virtio/meson.build              |    2 +
 hw/virtio/trace-events             |   20 +
 hw/virtio/virtio-snd-pci.c         |   93 ++
 hw/virtio/virtio-snd.c             | 1455 ++++++++++++++++++++++++++++
 include/hw/virtio/virtio-snd.h     |  235 +++++
 softmmu/qdev-monitor.c             |    1 +
 10 files changed, 1868 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v9:
 1:  5173e2c243 =  1:  6e7bdf6dda Add virtio-sound device stub
 2:  dd3acea293 !  2:  82138b9c7d Add virtio-sound-pci device
    @@ hw/virtio/virtio-snd-pci.c (new)
     +
     +type_init(virtio_snd_pci_register);
     
    + ## hw/virtio/virtio-snd.c ##
    +@@ hw/virtio/virtio-snd.c: static void
    + virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
    + {
    +     VirtIOSound *s = VIRTIO_SND(vdev);
    ++    virtio_snd_config *sndconfig =
    ++        (virtio_snd_config *)config;
    +     trace_virtio_snd_get_config(vdev,
    +                                 s->snd_conf.jacks,
    +                                 s->snd_conf.streams,
    +                                 s->snd_conf.chmaps);
    + 
    +-    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
    ++    memcpy(sndconfig, &s->snd_conf, sizeof(s->snd_conf));
    ++    cpu_to_le32s(&sndconfig->jacks);
    ++    cpu_to_le32s(&sndconfig->streams);
    ++    cpu_to_le32s(&sndconfig->chmaps);
    ++
    + }
    + 
    + static void
    +@@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    +                                s->snd_conf.chmaps,
    +                                sndconfig->chmaps);
    + 
    +-    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    ++    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
    ++    le32_to_cpus(&s->snd_conf.jacks);
    ++    le32_to_cpus(&s->snd_conf.streams);
    ++    le32_to_cpus(&s->snd_conf.chmaps);
    ++
    + }
    + 
    + /*
    +
      ## softmmu/qdev-monitor.c ##
     @@ softmmu/qdev-monitor.c: static const QDevAlias qdev_alias_table[] = {
          { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
 3:  a75dc75f24 !  3:  c1a2cb0304 virtio-sound: handle control messages and streams
    @@ hw/virtio/trace-events: virtio_snd_vm_state_running(void) "vm state running"
     +virtio_snd_handle_event(void) "event queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    +@@
    + #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    + #define VIRTIO_SOUND_HDA_FN_NID 0
    + 
    ++static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_U8)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_S16)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_U16)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_S32)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_U32)
    ++                                  | BIT(VIRTIO_SND_PCM_FMT_FLOAT);
    ++
    ++static uint32_t supported_rates = BIT(VIRTIO_SND_PCM_RATE_5512)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_8000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_11025)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_16000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_22050)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_32000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_44100)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_48000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_64000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_88200)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_96000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_176400)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_192000)
    ++                                | BIT(VIRTIO_SND_PCM_RATE_384000);
    ++
    + static const VMStateDescription vmstate_virtio_snd_device = {
    +     .name = TYPE_VIRTIO_SND,
    +     .version_id = VIRTIO_SOUND_VM_VERSION,
     @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    -     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    + 
      }
      
     +static void
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +    g_free(cmd);
     +}
     +
    ++/*
    ++ * Get a specific stream from the virtio sound card device.
    ++ * Returns NULL if @stream_id is invalid or not allocated.
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @stream_id: stream id
    ++ */
    ++static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
    ++                                                       uint32_t stream_id)
    ++{
    ++    return stream_id >= s->snd_conf.streams ? NULL :
    ++        s->pcm->streams[stream_id];
    ++}
    ++
    ++/*
    ++ * Get params for a specific stream.
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @stream_id: stream id
    ++ */
    ++static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
    ++                                                            uint32_t stream_id)
    ++{
    ++    return stream_id >= s->snd_conf.streams ? NULL
    ++        : &s->pcm->pcm_params[stream_id];
    ++}
    ++
    ++/*
    ++ * Set the given stream params.
    ++ * Called by both virtio_snd_handle_pcm_set_params and during device
    ++ * initialization.
    ++ * Returns the response status code. (VIRTIO_SND_S_*).
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @params: The PCM params as defined in the virtio specification
    ++ */
    ++static
    ++uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
    ++                                   uint32_t stream_id,
    ++                                   virtio_snd_pcm_set_params *params)
    ++{
    ++    virtio_snd_pcm_set_params *st_params;
    ++
    ++    if (stream_id >= s->snd_conf.streams || s->pcm->pcm_params == NULL) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
    ++        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialized.\n");
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++    }
    ++
    ++    st_params = virtio_snd_pcm_get_params(s, stream_id);
    ++
    ++    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
    ++        error_report("Number of channels is not supported.");
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
    ++    }
    ++    if (!(supported_formats & BIT(params->format))) {
    ++        error_report("Stream format is not supported.");
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
    ++    }
    ++    if (!(supported_rates & BIT(params->rate))) {
    ++        error_report("Stream rate is not supported.");
    ++        return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
    ++    }
    ++
    ++    st_params->buffer_bytes = le32_to_cpu(params->buffer_bytes);
    ++    st_params->period_bytes = le32_to_cpu(params->period_bytes);
    ++    st_params->features = le32_to_cpu(params->features);
    ++    /* the following are uint8_t, so there's no need to bswap the values. */
    ++    st_params->channels = params->channels;
    ++    st_params->format = params->format;
    ++    st_params->rate = params->rate;
    ++
    ++    return cpu_to_le32(VIRTIO_SND_S_OK);
    ++}
    ++
    ++/*
    ++ * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FMT_*
    ++ */
    ++static AudioFormat virtio_snd_get_qemu_format(uint32_t format)
    ++{
    ++    #define CASE(FMT)               \
    ++    case VIRTIO_SND_PCM_FMT_##FMT:  \
    ++        return AUDIO_FORMAT_##FMT;
    ++
    ++    switch (format) {
    ++    CASE(U8)
    ++    CASE(S8)
    ++    CASE(U16)
    ++    CASE(S16)
    ++    CASE(U32)
    ++    CASE(S32)
    ++    case VIRTIO_SND_PCM_FMT_FLOAT:
    ++        return AUDIO_FORMAT_F32;
    ++    default:
    ++        g_assert_not_reached();
    ++    }
    ++
    ++    #undef CASE
    ++}
    ++
    ++/*
    ++ * Get a QEMU Audiosystem compatible frequency value from a
    ++ * VIRTIO_SND_PCM_RATE_*
    ++ */
    ++static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
    ++{
    ++    #define CASE(RATE)               \
    ++    case VIRTIO_SND_PCM_RATE_##RATE: \
    ++        return RATE;
    ++
    ++    switch (rate) {
    ++    CASE(5512)
    ++    CASE(8000)
    ++    CASE(11025)
    ++    CASE(16000)
    ++    CASE(22050)
    ++    CASE(32000)
    ++    CASE(44100)
    ++    CASE(48000)
    ++    CASE(64000)
    ++    CASE(88200)
    ++    CASE(96000)
    ++    CASE(176400)
    ++    CASE(192000)
    ++    CASE(384000)
    ++    default:
    ++        g_assert_not_reached();
    ++    }
    ++
    ++    #undef CASE
    ++}
    ++
    ++/*
    ++ * Get QEMU Audiosystem compatible audsettings from virtio based pcm stream
    ++ * params.
    ++ */
    ++static void virtio_snd_get_qemu_audsettings(audsettings *as,
    ++                                            virtio_snd_pcm_set_params *params)
    ++{
    ++    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
    ++    as->fmt = virtio_snd_get_qemu_format(params->format);
    ++    as->freq = virtio_snd_get_qemu_freq(params->rate);
    ++    as->endianness = target_words_bigendian() ? 1 : 0;
    ++}
    ++
    ++/*
    ++ * Close a stream and free all its resources.
    ++ *
    ++ * @stream: VirtIOSoundPCMStream *stream
    ++ */
    ++static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    ++{
    ++}
    ++
    + /*
    +- * Queue handler stub.
    ++ * Prepares a VirtIOSound card stream.
    ++ * Returns the response status code. (VIRTIO_SND_S_*).
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @stream_id: stream id
    ++ */
    ++static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    ++{
    ++    audsettings as;
    ++    virtio_snd_pcm_set_params *params;
    ++    VirtIOSoundPCMStream *stream;
    ++
    ++    if (s->pcm->streams == NULL ||
    ++        s->pcm->pcm_params == NULL ||
    ++        stream_id >= s->snd_conf.streams) {
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++    }
    ++
    ++    params = virtio_snd_pcm_get_params(s, stream_id);
    ++    if (params == NULL) {
    ++        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++    }
    ++
    ++    stream = virtio_snd_pcm_get_stream(s, stream_id);
    ++    if (stream == NULL) {
    ++        stream = g_new0(VirtIOSoundPCMStream, 1);
    ++        stream->active = false;
    ++        stream->id = stream_id;
    ++        stream->pcm = s->pcm;
    ++        stream->s = s;
    ++
    ++        /*
    ++         * stream_id >= s->snd_conf.streams was checked before so this is
    ++         * in-bounds
    ++         */
    ++        s->pcm->streams[stream_id] = stream;
    ++    }
    ++
    ++    virtio_snd_get_qemu_audsettings(&as, params);
    ++    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
    ++        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
    ++    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
    ++    stream->info.features = 0;
    ++    stream->info.channels_min = 1;
    ++    stream->info.channels_max = as.nchannels;
    ++    stream->info.formats = supported_formats;
    ++    stream->info.rates = supported_rates;
    ++    stream->params = *params;
    ++
    ++    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
    ++    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
    ++    stream->as = as;
    ++
    ++    return cpu_to_le32(VIRTIO_SND_S_OK);
    ++}
    ++
     +static const char *print_code(uint32_t code)
     +{
     +    #define CASE(CODE)            \
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +                               cmd->elem->out_num,
     +                               0,
     +                               &cmd->ctrl,
    -+                               sizeof(cmd->ctrl));
    ++                               sizeof(virtio_snd_hdr));
     +
    -+    if (msg_sz != sizeof(cmd->ctrl)) {
    ++    if (msg_sz != sizeof(virtio_snd_hdr)) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
     +        qemu_log_mask(LOG_GUEST_ERROR,
     +                "%s: virtio-snd command size incorrect %zu vs \
    -+                %zu\n", __func__, msg_sz, sizeof(cmd->ctrl));
    ++                %zu\n", __func__, msg_sz, sizeof(virtio_snd_hdr));
     +        return;
     +    }
     +
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +                 cmd->elem->in_num,
     +                 0,
     +                 &cmd->resp,
    -+                 sizeof(cmd->resp));
    -+    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
    ++                 sizeof(virtio_snd_hdr));
    ++    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
     +    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
     +}
     +
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +    }
     +}
     +
    - /*
    -- * Queue handler stub.
    ++/*
     + * The control message handler. Pops an element from the control virtqueue,
     + * and stores them to VirtIOSound's cmdq queue and finally calls
     + * virtio_snd_process_cmdq() for processing.
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                                   Error **errp)
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +     ERRP_GUARD();
          VirtIOSound *vsnd = VIRTIO_SND(dev);
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    ++    virtio_snd_pcm_set_params default_params = { 0 };
    ++    uint32_t status;
      
     +    vsnd->pcm = NULL;
          vsnd->vmstate =
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      
     +    vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
     +    vsnd->pcm->snd = vsnd;
    -+    vsnd->pcm->streams = g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
    -+    vsnd->pcm->pcm_params = g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
    ++    vsnd->pcm->streams =
    ++        g_new0(VirtIOSoundPCMStream *, vsnd->snd_conf.streams);
    ++    vsnd->pcm->pcm_params =
    ++        g_new0(virtio_snd_pcm_set_params, vsnd->snd_conf.streams);
     +
          virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
          virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
      
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    + 
          AUD_register_card("virtio-sound", &vsnd->card);
      
    ++    /* set default params for all streams */
    ++    default_params.features = 0;
    ++    default_params.buffer_bytes = cpu_to_le32(8192);
    ++    default_params.period_bytes = cpu_to_le32(2048);
    ++    default_params.channels = 2;
    ++    default_params.format = VIRTIO_SND_PCM_FMT_S16;
    ++    default_params.rate = VIRTIO_SND_PCM_RATE_48000;
          vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
     -        virtio_add_queue(vdev, 64, virtio_snd_handle_queue);
     +        virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +        virtio_add_queue(vdev, 64, virtio_snd_handle_xfer);
     +    qemu_mutex_init(&vsnd->cmdq_mutex);
     +    QTAILQ_INIT(&vsnd->cmdq);
    -+}
     +
    -+/*
    -+ * Close the stream and free its resources.
    -+ *
    -+ * @stream: VirtIOSoundPCMStream *stream
    -+ */
    -+static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    -+{
    ++    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    ++        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
    ++        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
    ++            error_setg(errp,
    ++                       "Can't initalize stream params, device responded with %s.",
    ++                       print_code(status));
    ++            return;
    ++        }
    ++        status = virtio_snd_pcm_prepare(vsnd, i);
    ++        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
    ++            error_setg(errp,
    ++                       "Can't prepare streams, device responded with %s.",
    ++                       print_code(status));
    ++            return;
    ++        }
    ++    }
      }
      
      static void virtio_snd_unrealize(DeviceState *dev)
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     +
     +struct VirtIOSoundPCM {
     +    VirtIOSound *snd;
    ++    /*
    ++     * PCM parameters are a separate field instead of a VirtIOSoundPCMStream
    ++     * field, because the operation of PCM control requests is first
    ++     * VIRTIO_SND_R_PCM_SET_PARAMS and then VIRTIO_SND_R_PCM_PREPARE; this
    ++     * means that some times we get parameters without having an allocated
    ++     * stream yet.
    ++     */
     +    virtio_snd_pcm_set_params *pcm_params;
     +    VirtIOSoundPCMStream **streams;
     +};
     +
    ++struct VirtIOSoundPCMStream {
    ++    VirtIOSoundPCM *pcm;
    ++    virtio_snd_pcm_info info;
    ++    virtio_snd_pcm_set_params params;
    ++    uint32_t id;
    ++    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
    ++    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
    ++    VirtIOSound *s;
    ++    bool flushing;
    ++    audsettings as;
    ++    union {
    ++        SWVoiceIn *in;
    ++        SWVoiceOut *out;
    ++    } voice;
    ++    bool active;
    ++};
    ++
     +/*
     + * PCM stream state machine.
     + * -------------------------
    @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_pcm_xfer virtio_snd_pc
     + *
     + * The CTRL message is finally handled in `process_cmd()`.
     + */
    -+struct VirtIOSoundPCMStream {
    -+    VirtIOSoundPCM *pcm;
    -+    virtio_snd_pcm_info info;
    -+    virtio_snd_pcm_set_params params;
    -+    uint32_t id;
    -+    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
    -+    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
    -+    VirtIOSound *s;
    -+    bool flushing;
    -+    audsettings as;
    -+    union {
    -+        SWVoiceIn *in;
    -+        SWVoiceOut *out;
    -+    } voice;
    -+    QemuMutex queue_mutex;
    -+    QSIMPLEQ_HEAD(, VirtIOSoundPCMBlock) queue;
    -+};
    -+
     +struct VirtIOSound {
          VirtIODevice parent_obj;
      
 4:  49eb46f184 <  -:  ---------- virtio-sound: set PCM stream parameters
 5:  1f1dc7a200 !  4:  28b2ecfa1f virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
    @@ hw/virtio/trace-events: virtio_snd_vm_state_stopped(void) "vm state stopped"
      virtio_snd_handle_event(void) "event queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@
    - #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    - #define VIRTIO_SOUND_HDA_FN_NID 0
    - 
    -+static struct virtio_snd_info info_to_le32(struct virtio_snd_info val) {
    -+    val.hda_fn_nid = cpu_to_le32(val.hda_fn_nid);
    -+
    -+    return val;
    -+}
    -+
    -+static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
    -+    val.hdr = info_to_le32(val.hdr);
    -+    val.features = cpu_to_le32(val.features);
    -+    val.formats = cpu_to_le64(val.formats);
    -+    val.rates = cpu_to_le64(val.rates);
    -+
    -+    return val;
    -+}
    -+
    - static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
    -                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
    -                                   | BIT(VIRTIO_SND_PCM_FMT_S16)
     @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_set_params *virtio_snd_pcm_get_params(VirtIOSound *s,
              : &s->pcm->pcm_params[stream_id];
      }
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_set_params *virtio_snd_pcm_get_par
     +                                       virtio_snd_ctrl_command *cmd)
     +{
     +    uint32_t stream_id, start_id, count, size;
    ++    virtio_snd_pcm_info val;
     +    virtio_snd_query_info req;
     +    VirtIOSoundPCMStream *stream = NULL;
     +    g_autofree virtio_snd_pcm_info *pcm_info = NULL;
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_set_params *virtio_snd_pcm_get_par
     +                               cmd->elem->out_num,
     +                               0,
     +                               &req,
    -+                               sizeof(req));
    ++                               sizeof(virtio_snd_query_info));
     +
     +    if (msg_sz != sizeof(virtio_snd_query_info)) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                "%s: virtio-snd command size incorrect %zu vs \
    ++                %zu\n", __func__, msg_sz, sizeof(virtio_snd_query_info));
     +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_set_params *virtio_snd_pcm_get_par
     +
     +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
     +        sizeof(virtio_snd_hdr) + size * count) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
     +        error_report("pcm info: buffer too small, got: %zu, needed: %zu",
     +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
     +                sizeof(virtio_snd_pcm_info));
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_set_params *virtio_snd_pcm_get_par
     +            cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +            return;
     +        }
    -+        pcm_info[i] = pcm_info_to_le32(stream->info);
    ++        val = stream->info;
    ++        val.hdr.hda_fn_nid = cpu_to_le32(val.hdr.hda_fn_nid);
    ++        val.features = cpu_to_le32(val.features);
    ++        val.formats = cpu_to_le64(val.formats);
    ++        val.rates = cpu_to_le64(val.rates);
    ++        /*
    ++         * 5.14.6.6.2.1 Device Requirements: Stream Information The device MUST
    ++         * NOT set undefined feature, format, rate and direction values. The
    ++         * device MUST initialize the padding bytes to 0.
    ++         */
    ++        pcm_info[i] = val;
    ++        memset(&pcm_info[i].padding, 0, 5);
     +    }
     +
     +    cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
 6:  7fbbe07fda !  5:  a52d20b2c3 virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
    @@ hw/virtio/virtio-snd.c: static const char *print_code(uint32_t code)
     +                               cmd->elem->out_num,
     +                               0,
     +                               &req,
    -+                               sizeof(req));
    ++                               sizeof(virtio_snd_pcm_hdr));
     +
     +    if (msg_sz != sizeof(virtio_snd_pcm_hdr)) {
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                "%s: virtio-snd command size incorrect %zu vs \
    ++                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_hdr));
     +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
    @@ hw/virtio/virtio-snd.c: static const char *print_code(uint32_t code)
     +    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
     +            "VIRTIO_SND_R_PCM_STOP", stream_id);
     +    stream = virtio_snd_pcm_get_stream(s, stream_id);
    -+    if (!stream) {
    ++    if (stream == NULL) {
     +        error_report("Invalid stream id: %"PRIu32, req.stream_id);
     +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++        return;
     +    }
    ++    stream->active = start;
     +}
     +
      /*
 7:  92e65a6115 !  6:  25fbb2eb25 virtio-sound: handle VIRTIO_SND_R_PCM_SET_PARAMS
    @@ hw/virtio/virtio-snd.c: uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
     +                               cmd->elem->out_num,
     +                               0,
     +                               &req,
    -+                               sizeof(req));
    ++                               sizeof(virtio_snd_pcm_set_params));
     +
     +    if (msg_sz != sizeof(virtio_snd_pcm_set_params)) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                "%s: virtio-snd command size incorrect %zu vs \
    ++                %zu\n", __func__, msg_sz, sizeof(virtio_snd_pcm_set_params));
     +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
 8:  173bd9dafe !  7:  9e8d9923ba virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
    @@ hw/virtio/virtio-snd.c: static const char *print_code(uint32_t code)
     +                               sizeof(stream_id));
     +
     +    stream_id = le32_to_cpu(stream_id);
    -+    cmd->resp.code = msg_sz == sizeof(uint32_t)
    ++    cmd->resp.code = msg_sz == sizeof(stream_id)
     +                   ? virtio_snd_pcm_prepare(s, stream_id)
     +                   : cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +}
 9:  6e05194e02 !  8:  b50c94decc virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
    @@ hw/virtio/trace-events: virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTI
     
      ## hw/virtio/virtio-snd.c ##
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    -     }
    +     stream->active = start;
      }
      
     +/*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +                               &stream_id,
     +                               sizeof(stream_id));
     +
    -+    if (msg_sz != sizeof(uint32_t)) {
    ++    if (msg_sz != sizeof(stream_id)) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
    ++        qemu_log_mask(LOG_GUEST_ERROR,
    ++                "%s: virtio-snd command size incorrect %zu vs \
    ++                %zu\n", __func__, msg_sz, sizeof(stream_id));
     +        cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
     +        return;
     +    }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +    stream_id = le32_to_cpu(stream_id);
     +    trace_virtio_snd_handle_pcm_release(stream_id);
     +    stream = virtio_snd_pcm_get_stream(s, stream_id);
    -+    if (!stream) {
    ++    if (stream == NULL) {
    ++        /*
    ++         * TODO: do we need to set DEVICE_NEEDS_RESET?
    ++         */
     +        error_report("already released stream %"PRIu32, stream_id);
     +        virtio_error(VIRTIO_DEVICE(s),
     +                     "already released stream %"PRIu32,
10:  a241f8cf92 !  9:  4cbb908742 virtio-sound: implement audio output (TX)
    @@ Commit message
     
         Handle output IO messages in the transmit (TX) virtqueue.
     
    -    It allocates a VirtIOSoundPCMBlock for each IO message and copies the
    +    It allocates a VirtIOSoundPCMBuffer for each IO message and copies the
         data buffer to it. When the IO buffer is written to the host's sound
         card, the guest will be notified that it has been consumed.
     
    @@ hw/virtio/trace-events: virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_S
     +virtio_snd_handle_xfer(void) "tx/rx queue callback called"
     
      ## hw/virtio/virtio-snd.c ##
    -@@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
    -     return val;
    - }
    +@@
    + #define VIRTIO_SOUND_CHMAP_DEFAULT 0
    + #define VIRTIO_SOUND_HDA_FN_NID 0
      
     +static void virtio_snd_pcm_out_cb(void *data, int available);
     +static void virtio_snd_process_cmdq(VirtIOSound *s);
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_p
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
                                        | BIT(VIRTIO_SND_PCM_FMT_S16)
     @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
    -     memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
    + 
      }
      
     +static void
    -+virtio_snd_pcm_block_free(VirtIOSoundPCMBlock *block)
    ++virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
     +{
    -+    g_free(block->elem);
    -+    g_free(block);
    ++    g_free(buffer->elem);
    ++    g_free(buffer);
     +}
     +
      static void
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings
       */
      static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
      {
    -+    VirtIOSoundPCMBlock *block, *next;
    -+
     +    if (stream) {
    -+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+                virtqueue_push(block->vq,
    -+                        block->elem,
    -+                        sizeof(block->elem));
    -+                virtio_notify(VIRTIO_DEVICE(stream->s),
    -+                        block->vq);
    -+                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                virtio_snd_pcm_block_free(block);
    -+            }
    -+        }
     +        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
    ++            virtio_snd_pcm_flush(stream);
     +            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
     +            stream->voice.out = NULL;
     +        }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings
      }
      
      /*
    +@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
    +         stream->id = stream_id;
    +         stream->pcm = s->pcm;
    +         stream->s = s;
    ++        qemu_mutex_init(&stream->queue_mutex);
    ++        QSIMPLEQ_INIT(&stream->queue);
    ++        QSIMPLEQ_INIT(&stream->invalid);
    + 
    +         /*
    +          * stream_id >= s->snd_conf.streams was checked before so this is
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
          stream->positions[1] = VIRTIO_SND_CHMAP_FR;
          stream->as = as;
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, u
          return cpu_to_le32(VIRTIO_SND_S_OK);
      }
      
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    -                                              bool start)
    - {
    -     VirtIOSoundPCMStream *stream;
    -+    VirtIOSoundPCMBlock *block, *next;
    -     virtio_snd_pcm_hdr req;
    -     uint32_t stream_id;
    -     size_t msg_sz = iov_to_buf(cmd->elem->out_sg,
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
          cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_OK);
          trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_START" :
                  "VIRTIO_SND_R_PCM_STOP", stream_id);
     +
          stream = virtio_snd_pcm_get_stream(s, stream_id);
    --    if (!stream) {
    +-    if (stream == NULL) {
     -        error_report("Invalid stream id: %"PRIu32, req.stream_id);
     +    if (stream) {
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            stream->active = start;
    ++        }
     +        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
     +            AUD_set_active_out(stream->voice.out, start);
     +        }
    -+        /* remove previous buffers. */
    -+        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+                virtqueue_push(block->vq,
    -+                               block->elem,
    -+                               sizeof(block->elem));
    -+                virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
    -+                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                virtio_snd_pcm_block_free(block);
    -+            }
    -+        }
     +    } else {
     +        error_report("Invalid stream id: %"PRIu32, stream_id);
              cmd->resp.code = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    +         return;
          }
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
      }
      
      /*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     + */
     +static size_t virtio_snd_pcm_get_io_msgs_count(VirtIOSoundPCMStream *stream)
     +{
    -+    VirtIOSoundPCMBlock *block;
    -+    VirtIOSoundPCMBlock *next;
    ++    VirtIOSoundPCMBuffer *buffer, *next;
     +    size_t count = 0;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    ++        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
    ++            count += 1;
    ++        }
    ++        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
     +            count += 1;
     +        }
     +    }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s
     +         * - The device MUST NOT complete the control request while there
     +         *   are pending I/O messages for the specified stream ID.
     +         */
    -+        virtio_snd_process_cmdq(stream->s);
     +        trace_virtio_snd_pcm_stream_flush(stream_id);
     +        virtio_snd_pcm_flush(stream);
     +    }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +{
     +    VirtIOSound *s = VIRTIO_SND(vdev);
     +    VirtIOSoundPCMStream *stream = NULL;
    -+    VirtIOSoundPCMBlock *block;
    ++    VirtIOSoundPCMBuffer *buffer;
     +    VirtQueueElement *elem;
     +    size_t msg_sz, size;
     +    virtio_snd_pcm_xfer hdr;
     +    virtio_snd_pcm_status resp = { 0 };
     +    uint32_t stream_id;
    ++    /*
    ++     * If any of the I/O messages are invalid, put them in stream->invalid and
    ++     * return them after the for loop.
    ++     */
    ++    bool must_empty_invalid_queue = false;
     +
    -+    trace_virtio_snd_handle_xfer();
    ++    if (!virtio_queue_ready(vq)) {
    ++        return;
    ++    }
    ++    trace_virtio_snd_handle_tx_xfer();
     +
     +    for (;;) {
     +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
     +        }
     +        /* get the message hdr object */
     +        msg_sz = iov_to_buf(elem->out_sg,
    -+                        elem->out_num,
    -+                        0,
    -+                        &hdr,
    -+                        sizeof(hdr));
    -+        if (msg_sz != sizeof(hdr)) {
    ++                            elem->out_num,
    ++                            0,
    ++                            &hdr,
    ++                            sizeof(virtio_snd_pcm_xfer));
    ++        if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
     +            goto tx_err;
     +        }
     +        stream_id = le32_to_cpu(hdr.stream_id);
     +
     +        if (stream_id >= s->snd_conf.streams
    -+            || !s->pcm->streams[stream_id]) {
    ++            || s->pcm->streams[stream_id] == NULL) {
     +            goto tx_err;
     +        }
     +
     +        stream = s->pcm->streams[stream_id];
    -+        if (!stream || stream->info.direction != VIRTIO_SND_D_OUTPUT) {
    ++        if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
     +            goto tx_err;
     +        }
     +
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            size = iov_size(elem->out_sg, elem->out_num) -
    -+                sizeof(virtio_snd_pcm_xfer);
    -+            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
    -+            block->elem = elem;
    -+            block->vq = vq;
    -+            block->size = size;
    -+            block->offset = 0;
    ++            size = iov_size(elem->out_sg, elem->out_num);
     +
    -+            iov_to_buf(elem->out_sg,
    -+                    elem->out_num,
    -+                    sizeof(virtio_snd_pcm_xfer),
    -+                    block->data,
    -+                    size);
    ++            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
    ++            buffer->elem = elem;
    ++            buffer->stale = true;
    ++            buffer->vq = vq;
    ++            buffer->size = size;
    ++            buffer->offset = sizeof(virtio_snd_pcm_xfer);
     +
    -+            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
    ++            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
     +        }
     +        continue;
     +
     +tx_err:
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    -+            iov_from_buf(elem->in_sg,
    -+                         elem->in_num,
    -+                         0,
    -+                         &resp,
    -+                         sizeof(resp));
    -+            virtqueue_push(vq, elem, sizeof(elem));
    -+            break;
    ++            must_empty_invalid_queue = true;
    ++            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
    ++            buffer->elem = elem;
    ++            buffer->vq = vq;
    ++            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
     +        }
     +    }
     +
    -+    /*
    -+     * Notify vq about virtio_snd_pcm_status responses.
    -+     * Buffer responses must be notified separately later.
    -+     */
    -+    virtio_notify(VIRTIO_DEVICE(s), vq);
    ++    if (must_empty_invalid_queue) {
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
    ++                buffer = QSIMPLEQ_FIRST(&stream->invalid);
    ++
    ++                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++                iov_from_buf(buffer->elem->in_sg,
    ++                             buffer->elem->in_num,
    ++                             0,
    ++                             &resp,
    ++                             sizeof(virtio_snd_pcm_status));
    ++                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
    ++                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
    ++                virtio_snd_pcm_buffer_free(buffer);
    ++            }
    ++            /*
    ++             * Notify vq about virtio_snd_pcm_status responses.
    ++             * Buffer responses must be notified separately later.
    ++             */
    ++            virtio_notify(vdev, vq);
    ++        }
    ++    }
     +}
     +
      /*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +static void virtio_snd_pcm_out_cb(void *data, int available)
     +{
     +    VirtIOSoundPCMStream *stream = data;
    -+    VirtIOSoundPCMBlock *block;
    ++    VirtIOSoundPCMBuffer *buffer;
     +    size_t size;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
    -+            block = QSIMPLEQ_FIRST(&stream->queue);
    -+
    ++            buffer = QSIMPLEQ_FIRST(&stream->queue);
    ++            if (!virtio_queue_ready(buffer->vq)) {
    ++                return;
    ++            }
    ++            if (!stream->active) {
    ++                /* Stream has stopped, so do not perform AUD_write. */
    ++                goto return_tx_buffer;
    ++            }
    ++            if (buffer->stale) {
    ++                iov_to_buf(buffer->elem->out_sg,
    ++                           buffer->elem->out_num,
    ++                           buffer->offset,
    ++                           buffer->data,
    ++                           buffer->size);
    ++                buffer->stale = false;
    ++            }
     +            for (;;) {
     +                size = AUD_write(stream->voice.out,
    -+                                 block->data + block->offset,
    -+                                 MIN(block->size, available));
    -+                assert(size <= MIN(block->size, available));
    ++                                 buffer->data + buffer->offset,
    ++                                 MIN(buffer->size, available));
    ++                assert(size <= MIN(buffer->size, available));
     +                if (size == 0) {
     +                    /* break out of both loops */
     +                    available = 0;
     +                    break;
     +                }
    -+                block->size -= size;
    -+                block->offset += size;
    ++                buffer->size -= size;
    ++                buffer->offset += size;
     +                available -= size;
    -+                if (!block->size) {
    ++                if (buffer->size < 1) {
    ++return_tx_buffer:
     +                    virtio_snd_pcm_status resp = { 0 };
     +                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
     +                    resp.latency_bytes = 0;
    -+                    iov_from_buf(block->elem->in_sg,
    -+                                 block->elem->in_num,
    ++                    iov_from_buf(buffer->elem->in_sg,
    ++                                 buffer->elem->in_num,
     +                                 0,
     +                                 &resp,
    -+                                 sizeof(resp));
    -+                    virtqueue_push(block->vq,
    -+                                   block->elem,
    -+                                   sizeof(block->elem));
    -+                    virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
    ++                                 sizeof(virtio_snd_pcm_status));
    ++                    virtqueue_push(buffer->vq,
    ++                                   buffer->elem,
    ++                                   sizeof(virtio_snd_pcm_status));
    ++                    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    virtio_snd_pcm_block_free(block);
    ++                    virtio_snd_pcm_buffer_free(buffer);
     +                    break;
     +                }
    -+
     +                if (!available) {
     +                    break;
     +                }
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     + */
     +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
     +{
    -+    VirtIOSoundPCMBlock *block;
    -+    VirtIOSoundPCMBlock *next;
    ++    VirtIOSoundPCMBuffer *buffer, *next;
     +
     +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    -+            AUD_write(stream->voice.out, block->data + block->offset, block->size);
    -+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
    -+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
    -+            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
    ++        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
    ++            AUD_write(stream->voice.out,
    ++                      buffer->data + buffer->offset,
    ++                      buffer->size);
    ++            virtqueue_push(buffer->vq,
    ++                           buffer->elem,
    ++                           sizeof(VirtQueueElement));
    ++            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    ++            QSIMPLEQ_REMOVE(&stream->queue,
    ++                            buffer,
    ++                            VirtIOSoundPCMBuffer,
    ++                            entry);
    ++            virtio_snd_pcm_buffer_free(buffer);
     +        }
     +    }
     +}
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      static void virtio_snd_unrealize(DeviceState *dev)
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    +                 if (stream) {
    +                     virtio_snd_process_cmdq(stream->s);
    +                     virtio_snd_pcm_close(stream);
    ++                    qemu_mutex_destroy(&stream->queue_mutex);
    +                     g_free(stream);
    +                 }
    +             }
     
      ## include/hw/virtio/virtio-snd.h ##
     @@ include/hw/virtio/virtio-snd.h: typedef struct virtio_snd_ctrl_command virtio_snd_ctrl_command;
      
      typedef struct VirtIOSoundPCM VirtIOSoundPCM;
      
    -+typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
    ++typedef struct VirtIOSoundPCMBuffer VirtIOSoundPCMBuffer;
     +
    -+struct VirtIOSoundPCMBlock {
    -+    QSIMPLEQ_ENTRY(VirtIOSoundPCMBlock) entry;
    ++/*
    ++ * The VirtIO sound spec reuses layouts and values from the High Definition
    ++ * Audio spec (virtio/v1.2: 5.14 Sound Device). This struct handles each I/O
    ++ * message's buffer (virtio/v1.2: 5.14.6.8 PCM I/O Messages).
    ++ *
    ++ * In the case of TX (i.e. playback) buffers, we defer reading the raw PCM data
    ++ * from the virtqueue until QEMU's sound backsystem calls the output callback.
    ++ * This is tracked by the `bool stale;` field, which is set to false when data
    ++ * has been read into our own buffer for consumption.
    ++ *
    ++ * VirtIOSoundPCMBuffer has a dynamic size since it includes the raw PCM data
    ++ * in its allocation. It must be initialized and destroyed as follows:
    ++ *
    ++ *   size_t size = [[derived from owned VQ element descriptor sizes]];
    ++ *   buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
    ++ *   buffer->elem = [[owned VQ element]];
    ++ *
    ++ *   [..]
    ++ *
    ++ *   g_free(buffer->elem);
    ++ *   g_free(buffer);
    ++ */
    ++struct VirtIOSoundPCMBuffer {
    ++    QSIMPLEQ_ENTRY(VirtIOSoundPCMBuffer) entry;
     +    VirtQueueElement *elem;
     +    VirtQueue *vq;
     +    size_t size;
    ++    /*
    ++     * In TX / Plaback, `offset` represents the first unused position inside
    ++     * `data`. If `offset == size` then there are no unused data left.
    ++     */
     +    uint64_t offset;
    ++    /* Used for the TX queue for lazy I/O copy from `elem` */
    ++    bool stale;
    ++    /*
    ++     * VirtIOSoundPCMBuffer is an unsized type because it ends with an array of
    ++     * bytes. The size of `data` is determined from the I/O message's read-only
    ++     * or write-only size when allocating VirtIOSoundPCMBuffer.
    ++     */
     +    uint8_t data[];
     +};
     +
      struct VirtIOSoundPCM {
          VirtIOSound *snd;
    -     virtio_snd_pcm_set_params *pcm_params;
    +     /*
    +@@ include/hw/virtio/virtio-snd.h: struct VirtIOSoundPCMStream {
    +         SWVoiceIn *in;
    +         SWVoiceOut *out;
    +     } voice;
    ++    QemuMutex queue_mutex;
    +     bool active;
    ++    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
    ++    QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
    + };
    + 
    + /*
11:  6f3526e067 ! 10:  992b0d5ff4 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c
      #define VIRTIO_SOUND_CHMAP_DEFAULT 0
      #define VIRTIO_SOUND_HDA_FN_NID 0
      
    -@@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_pcm_info val) {
    - 
      static void virtio_snd_pcm_out_cb(void *data, int available);
      static void virtio_snd_process_cmdq(VirtIOSound *s);
     -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
    @@ hw/virtio/virtio-snd.c: static virtio_snd_pcm_info pcm_info_to_le32(virtio_snd_p
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    + {
    +     if (stream) {
              if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
    +-            virtio_snd_pcm_flush(stream);
    ++            virtio_snd_pcm_out_flush(stream);
                  AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
                  stream->voice.out = NULL;
     +        } else if (stream->info.direction == VIRTIO_SND_D_INPUT) {
    ++            virtio_snd_pcm_in_flush(stream);
     +            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
     +            stream->voice.in = NULL;
              }
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, u
     +                                        stream,
     +                                        virtio_snd_pcm_in_cb,
     +                                        &as);
    ++        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
          }
      
          return cpu_to_le32(VIRTIO_SND_S_OK);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    -     if (stream) {
    +         }
              if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
                  AUD_set_active_out(stream->voice.out, start);
     +        } else {
     +            AUD_set_active_in(stream->voice.in, start);
              }
    -         /* remove previous buffers. */
    -         WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    +     } else {
    +         error_report("Invalid stream id: %"PRIu32, stream_id);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
    +          *   are pending I/O messages for the specified stream ID.
               */
    -         virtio_snd_process_cmdq(stream->s);
              trace_virtio_snd_pcm_stream_flush(stream_id);
     -        virtio_snd_pcm_flush(stream);
     +        if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev,
      {
          VirtIOSound *s = VIRTIO_SND(vdev);
          VirtIOSoundPCMStream *stream = NULL;
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
    -     virtio_snd_pcm_status resp = { 0 };
    -     uint32_t stream_id;
    - 
    --    trace_virtio_snd_handle_xfer();
    -+    trace_virtio_snd_handle_tx_xfer();
    - 
    -     for (;;) {
    -         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
     @@ hw/virtio/virtio-snd.c: tx_err:
      }
      
    @@ hw/virtio/virtio-snd.c: tx_err:
     +{
     +    VirtIOSound *s = VIRTIO_SND(vdev);
     +    VirtIOSoundPCMStream *stream = NULL;
    -+    VirtIOSoundPCMBlock *block;
    ++    VirtIOSoundPCMBuffer *buffer;
     +    VirtQueueElement *elem;
     +    size_t msg_sz, size;
     +    virtio_snd_pcm_xfer hdr;
     +    virtio_snd_pcm_status resp = { 0 };
     +    uint32_t stream_id;
    ++    /*
    ++     * if any of the I/O messages are invalid, put them in stream->invalid and
    ++     * return them after the for loop.
    ++     */
    ++    bool must_empty_invalid_queue = false;
     +
    ++    if (!virtio_queue_ready(vq)) {
    ++        return;
    ++    }
     +    trace_virtio_snd_handle_rx_xfer();
     +
     +    for (;;) {
    @@ hw/virtio/virtio-snd.c: tx_err:
     +                            elem->out_num,
     +                            0,
     +                            &hdr,
    -+                            sizeof(hdr));
    -+        if (msg_sz != sizeof(hdr)) {
    ++                            sizeof(virtio_snd_pcm_xfer));
    ++        if (msg_sz != sizeof(virtio_snd_pcm_xfer)) {
     +            goto rx_err;
     +        }
     +        stream_id = le32_to_cpu(hdr.stream_id);
    @@ hw/virtio/virtio-snd.c: tx_err:
     +        }
     +
     +        stream = s->pcm->streams[stream_id];
    -+        if (!stream || stream->info.direction != VIRTIO_SND_D_INPUT) {
    ++        if (stream == NULL || stream->info.direction != VIRTIO_SND_D_INPUT) {
     +            goto rx_err;
     +        }
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
     +            size = iov_size(elem->in_sg, elem->in_num) -
     +                sizeof(virtio_snd_pcm_status);
    -+            block = g_malloc0(sizeof(VirtIOSoundPCMBlock) + size);
    -+            block->elem = elem;
    -+            block->vq = vq;
    -+            block->size = 0;
    -+            block->offset = 0;
    -+            QSIMPLEQ_INSERT_TAIL(&stream->queue, block, entry);
    ++            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
    ++            buffer->elem = elem;
    ++            buffer->vq = vq;
    ++            buffer->size = 0;
    ++            buffer->offset = 0;
    ++            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
     +        }
     +        continue;
     +
     +rx_err:
     +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    -+            resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    -+            iov_from_buf(elem->in_sg,
    -+                         elem->in_num,
    -+                         0,
    -+                         &resp,
    -+                         sizeof(resp));
    ++            must_empty_invalid_queue = true;
    ++            buffer = g_malloc0(sizeof(VirtIOSoundPCMBuffer));
    ++            buffer->elem = elem;
    ++            buffer->vq = vq;
    ++            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
     +        }
     +    }
     +
    -+    /*
    -+     * Notify vq about virtio_snd_pcm_status responses.
    -+     * Buffer responses must be notified separately later.
    -+     */
    -+    virtio_notify(VIRTIO_DEVICE(s), vq);
    ++    if (must_empty_invalid_queue) {
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
    ++                buffer = QSIMPLEQ_FIRST(&stream->invalid);
    ++
    ++                resp.status = cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
    ++                iov_from_buf(buffer->elem->in_sg,
    ++                             buffer->elem->in_num,
    ++                             0,
    ++                             &resp,
    ++                             sizeof(virtio_snd_pcm_status));
    ++                virtqueue_push(vq, buffer->elem, sizeof(virtio_snd_pcm_status));
    ++                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
    ++                virtio_snd_pcm_buffer_free(buffer);
    ++            }
    ++            /*
    ++             * Notify vq about virtio_snd_pcm_status responses.
    ++             * Buffer responses must be notified separately later.
    ++             */
    ++            virtio_notify(vdev, vq);
    ++        }
    ++    }
     +}
      
      static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
          qemu_mutex_init(&vsnd->cmdq_mutex);
          QTAILQ_INIT(&vsnd->cmdq);
      
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int available)
    +@@ hw/virtio/virtio-snd.c: return_tx_buffer:
      }
      
      /*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
     +static void virtio_snd_pcm_in_cb(void *data, int available)
      {
    +-    VirtIOSoundPCMBuffer *buffer, *next;
     +    VirtIOSoundPCMStream *stream = data;
    -     VirtIOSoundPCMBlock *block;
    --    VirtIOSoundPCMBlock *next;
    ++    VirtIOSoundPCMBuffer *buffer;
     +    virtio_snd_pcm_status resp = { 0 };
     +    size_t size;
      
          WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    --        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    --            AUD_write(stream->voice.out, block->data + block->offset, block->size);
    --            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
    --            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
    --            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
    +-        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
    +-            AUD_write(stream->voice.out,
    +-                      buffer->data + buffer->offset,
    +-                      buffer->size);
    +-            virtqueue_push(buffer->vq,
    +-                           buffer->elem,
    +-                           sizeof(VirtQueueElement));
    +-            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
    +-            QSIMPLEQ_REMOVE(&stream->queue,
    +-                            buffer,
    +-                            VirtIOSoundPCMBuffer,
    +-                            entry);
    +-            virtio_snd_pcm_buffer_free(buffer);
     +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
    -+            block = QSIMPLEQ_FIRST(&stream->queue);
    ++            buffer = QSIMPLEQ_FIRST(&stream->queue);
    ++            if (!virtio_queue_ready(buffer->vq)) {
    ++                return;
    ++            }
    ++            if (!stream->active) {
    ++                /* Stream has stopped, so do not perform AUD_read. */
    ++                goto return_rx_buffer;
    ++            }
     +
     +            for (;;) {
     +                size = AUD_read(stream->voice.in,
    -+                        block->data + block->size,
    -+                        MIN(available, (stream->params.period_bytes - block->size)));
    ++                        buffer->data + buffer->size,
    ++                        MIN(available, (stream->params.period_bytes -
    ++                                        buffer->size)));
     +                if (!size) {
     +                    available = 0;
     +                    break;
     +                }
    -+                block->size += size;
    ++                buffer->size += size;
     +                available -= size;
    -+                if (block->size >= stream->params.period_bytes) {
    ++                if (buffer->size >= stream->params.period_bytes) {
    ++return_rx_buffer:
     +                    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);
     +                    resp.latency_bytes = 0;
     +                    /* Copy data -if any- to guest */
    -+                    iov_from_buf(block->elem->in_sg,
    -+                                 block->elem->in_num,
    ++                    iov_from_buf(buffer->elem->in_sg,
    ++                                 buffer->elem->in_num,
     +                                 0,
    -+                                 block->data,
    -+                                 stream->params.period_bytes);
    -+                    iov_from_buf(block->elem->in_sg,
    -+                                 block->elem->in_num,
    -+                                 block->size,
    ++                                 buffer->data,
    ++                                 buffer->size);
    ++                    iov_from_buf(buffer->elem->in_sg,
    ++                                 buffer->elem->in_num,
    ++                                 buffer->size,
     +                                 &resp,
     +                                 sizeof(resp));
    -+                    virtqueue_push(block->vq,
    -+                                   block->elem,
    -+                                   sizeof(block->elem));
    -+                    virtio_notify(VIRTIO_DEVICE(stream->s),
    -+                                  block->vq);
    ++                    virtqueue_push(buffer->vq,
    ++                                   buffer->elem,
    ++                                   sizeof(virtio_snd_pcm_status) +
    ++                                    buffer->size);
    ++                    virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);
     +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    -+                    virtio_snd_pcm_block_free(block);
    ++                    virtio_snd_pcm_buffer_free(buffer);
     +                    break;
     +                }
     +                if (!available) {
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
          }
      }
      
    -+#define virtio_snd_pcm_flush(AUD_CB)                                    \
    -+    VirtIOSoundPCMBlock *block;                                         \
    -+    VirtIOSoundPCMBlock *next;                                          \
    -+    virtio_snd_pcm_status resp = { 0 };                                 \
    -+    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                         \
    -+    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                        \
    -+        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {     \
    -+            do {                                                        \
    -+                AUD_CB;                                                 \
    -+            } while (0)                                                 \
    -+            ;                                                           \
    -+            virtqueue_push(block->vq, block->elem, sizeof(block->elem));\
    -+            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);         \
    -+            QSIMPLEQ_REMOVE(&stream->queue,                             \
    -+                            block,                                      \
    -+                            VirtIOSoundPCMBlock,                        \
    -+                            entry);                                     \
    -+            virtio_snd_pcm_block_free(block);                           \
    -+        }                                                               \
    -+    }                                                                   \
    ++#define virtio_snd_pcm_flush(AUD_CB)                                         \
    ++    VirtIOSoundPCMBuffer *buffer;                                            \
    ++    virtio_snd_pcm_status resp = { 0 };                                      \
    ++    unsigned int len = 0;                                                    \
    ++    resp.status = cpu_to_le32(VIRTIO_SND_S_OK);                              \
    ++    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                             \
    ++        while (!QSIMPLEQ_EMPTY(&stream->queue)) {                            \
    ++            buffer = QSIMPLEQ_FIRST(&stream->queue);                         \
    ++            do {                                                             \
    ++                AUD_CB;                                                      \
    ++            } while (0)                                                      \
    ++            ;                                                                \
    ++            virtqueue_push(buffer->vq, buffer->elem, len);                   \
    ++            virtio_notify(VIRTIO_DEVICE(stream->s), buffer->vq);             \
    ++            QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);                     \
    ++            virtio_snd_pcm_buffer_free(buffer);                              \
    ++        }                                                                    \
    ++    }
     +
     +
     +/*
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     + */
     +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
     +{
    -+    /* We should flush the buffers as soon as possible, because it is a
    ++    /*
    ++     * We should flush the buffers as soon as possible, because it is a
     +     * time-sensitive operation.
     +     *
     +     * TODO: find out if copying leftover flushed data to an intermediate
     +     * buffer is a good approach.
     +     */
    ++    size_t written;
     +    virtio_snd_pcm_flush(
    -+            iov_from_buf(block->elem->in_sg,
    -+                         block->elem->in_num,
    ++            if (stream->active && buffer->stale) {
    ++                iov_to_buf(buffer->elem->out_sg,
    ++                           buffer->elem->out_num,
    ++                           buffer->offset,
    ++                           buffer->data,
    ++                           buffer->size);
    ++                buffer->stale = false;
    ++            }
    ++            if (stream->active)
    ++                while (buffer->size > 0) {
    ++                    written = AUD_write(stream->voice.out,
    ++                                        buffer->data + buffer->offset,
    ++                                        buffer->size);
    ++                    if (written < 1) {
    ++                        break;
    ++                    }
    ++                    buffer->size -= written;
    ++                    buffer->offset += written;
    ++                }
    ++            len = sizeof(virtio_snd_pcm_status);
    ++            iov_from_buf(buffer->elem->in_sg,
    ++                         buffer->elem->in_num,
     +                         0,
     +                         &resp,
    -+                         sizeof(resp));
    ++                         sizeof(virtio_snd_pcm_status));
     +            );
     +}
     +
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream)
     +{
     +    virtio_snd_pcm_flush(
    -+            iov_from_buf(block->elem->in_sg,
    -+                         block->elem->in_num,
    ++            len = sizeof(virtio_snd_pcm_status) + buffer->size;
    ++            iov_from_buf(buffer->elem->in_sg,
    ++                         buffer->elem->in_num,
     +                         0,
    -+                         block->data,
    -+                         block->size);
    -+            iov_from_buf(block->elem->in_sg,
    -+                         block->elem->in_num,
    -+                         block->size,
    ++                         buffer->data,
    ++                         buffer->size);
    ++            iov_from_buf(buffer->elem->in_sg,
    ++                         buffer->elem->in_num,
    ++                         buffer->size,
     +                         &resp,
    -+                         sizeof(resp));
    ++                         sizeof(virtio_snd_pcm_status));
     +            );
     +}
     +
      static void virtio_snd_unrealize(DeviceState *dev)
      {
          VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    -     virtio_cleanup(vdev);
    - }
    - 
    --
    - static void virtio_snd_reset(VirtIODevice *vdev)
    - {
    -     VirtIOSound *s = VIRTIO_SND(vdev);
12:  06e6b17186 ! 11:  b720e00121 docs/system: add basic virtio-snd documentation
    @@ Commit message
         Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
         Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
     
    + ## MAINTAINERS ##
    +@@ MAINTAINERS: M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
    + S: Supported
    + F: hw/virtio/virtio-snd*.c
    + F: include/hw/virtio/virtio-snd.h
    ++F: docs/system/devices/virtio-snd.rst
    + 
    + nvme
    + M: Keith Busch <kbusch@kernel.org>
    +
      ## docs/system/device-emulation.rst ##
     @@ docs/system/device-emulation.rst: Emulated Devices
         devices/usb.rst

base-commit: 36e9aab3c569d4c9ad780473596e18479838d1aa
-- 
2.39.2


