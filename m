Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC53177C9FF
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 11:09:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVq1q-0005No-BO; Tue, 15 Aug 2023 05:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq1l-0005NM-OW
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:07:49 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qVq1h-000530-B5
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 05:07:49 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2b9cbaee7a9so80981951fa.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 02:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692090461; x=1692695261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TwWOWeRv8xsCYwkvghkTPpZhsCBcDh8ku93dzFzyWfk=;
 b=bIsl8i2R2bCNvmMMPRS9k3xvTK9HemrLONQspx9n29LwmQj1rITs3rJT2SJByKhCVv
 /IwQrEy8W4Vmz0n/sgELhrVsWEL7IGVF2J9leGAC0fUV+nxUsfdnb8nbakX7ekc+eHmZ
 FS3oN7A74+kyH15Kkmp5GLTPsV2YY5rWlcVeZivzsGSBUSYtTfV+80Ng6EWu+VMRfA8M
 rDCQUXg2+4iMZh/aQFYzEI/nNo0LtI8qJcRbZNqY7/QsJxbPaqFQjtwBXNz3rt0uVvqS
 Y07t5ZUVyP7/N4UJUcirfvbhJSnvDcAy/pMakdK+9ok4yWsumPyhwDR4aDAE2Y/qxTEN
 GUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692090461; x=1692695261;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TwWOWeRv8xsCYwkvghkTPpZhsCBcDh8ku93dzFzyWfk=;
 b=aB9vQNTnYi6otsfAS7PJIiQS26CMbM30Tgo3AzIPzg61guhYAWtWRsvLwRae8V687x
 F7z+4/DuBTmDxSpf9OBAo7Evd1E+cGkWrXXRMK/e3WdcrhCC7ZRTBT+R4hxiivPvkOBp
 pW8nus5VH7QQ/WRJjcP7xhBWBZ/HC/i+3Instq6Sa6bw2UYATbRZ2oK9C+klvfixl9N2
 D1D3V177M22CfG1RJWTBw8IfK5Ohre06pyiHvf2AKN5f5CYymB0oxj3Z4VMot+siqxb4
 cjc/5qZOIJqhvMQO6mbI4mrmBsNt7xnj4bWBycqAQUM0gmgGrfJxSN+0AaNwIcMnPUJC
 DD+A==
X-Gm-Message-State: AOJu0Yxe9itoSPgYiXR7FUZVatTnm0HLQQt+0WHBMYkITrwvAPvpzAtV
 KXLcCKaMcmA8dFdEOuKUxfEnPLqvMSNYY9yvQEE=
X-Google-Smtp-Source: AGHT+IEfp1cZ/5y+ubHRo+qD4Ei4Cr03ELPrKaAClv0s8/wtg/PYpT0k17Av1B02Z6gyM3dwhOkz8w==
X-Received: by 2002:a2e:9e97:0:b0:2b5:7dd9:74f5 with SMTP id
 f23-20020a2e9e97000000b002b57dd974f5mr8952298ljk.21.1692090461421; 
 Tue, 15 Aug 2023 02:07:41 -0700 (PDT)
Received: from localhost.localdomain (adsl-56.37.6.0.tellas.gr. [37.6.0.56])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe505319ffsm19774707wmk.18.2023.08.15.02.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 02:07:40 -0700 (PDT)
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
Subject: [PATCH v6 00/12] Add VIRTIO sound card
Date: Tue, 15 Aug 2023 12:07:05 +0300
Message-Id: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x229.google.com
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

https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v6

Main differences with v5 patch series [^v5]
<cover.1690626150.git.manos.pitsidianakis@linaro.org>:

- Free any existing PCM stream resources before allocating a new one.
- Add docs.

[^v5]: 
https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/

Previously:

[^v4]: 
https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
[^v3]: 
https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/


Emmanouil Pitsidianakis (12):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: set PCM stream parameters
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                        |    6 +
 docs/system/device-emulation.rst   |    1 +
 docs/system/devices/virtio-snd.rst |   36 +
 hw/virtio/Kconfig                  |    5 +
 hw/virtio/meson.build              |    2 +
 hw/virtio/trace-events             |   20 +
 hw/virtio/virtio-snd-pci.c         |   91 ++
 hw/virtio/virtio-snd.c             | 1308 ++++++++++++++++++++++++++++
 include/hw/pci/pci.h               |    1 +
 include/hw/virtio/virtio-snd.h     |  158 ++++
 softmmu/qdev-monitor.c             |    1 +
 11 files changed, 1629 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

Range-diff against v5:
 1:  899b9a06bb =  1:  86f98e0b7d Add virtio-sound device stub
 2:  035be510f8 =  2:  8f996f9aed Add virtio-sound-pci device
 3:  e6a3624f89 !  3:  66eac6c1e0 virtio-sound: handle control messages and streams
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      }
      
     +/*
    -+ * Close the sound card.
    ++ * Close the stream and free its resources.
     + *
     + * @stream: VirtIOSoundPCMStream *stream
     + */
     +static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
     +{
    -+    virtio_snd_process_cmdq(stream->s);
     +}
     +
      static void virtio_snd_unrealize(DeviceState *dev)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
      
          trace_virtio_snd_unrealize(vsnd);
      
    -+    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    -+        stream = vsnd->pcm->streams[i];
    -+        virtio_snd_pcm_close(stream);
    -+        g_free(stream);
    ++    if (vsnd->pcm) {
    ++        if (vsnd->pcm->streams) {
    ++            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    ++                stream = vsnd->pcm->streams[i];
    ++                if (stream) {
    ++                    virtio_snd_process_cmdq(stream->s);
    ++                    virtio_snd_pcm_close(stream);
    ++                    g_free(stream);
    ++                }
    ++            }
    ++            g_free(vsnd->pcm->streams);
    ++        }
    ++        g_free(vsnd->pcm);
    ++        vsnd->pcm = NULL;
     +    }
          AUD_remove_card(&vsnd->card);
    -+    g_free(vsnd->pcm);
          virtio_cleanup(vdev);
      }
      
 4:  82c80e2ae4 !  4:  fbb22214f2 virtio-sound: set PCM stream parameters
    @@ hw/virtio/virtio-snd.c: virtio_snd_set_config(VirtIODevice *vdev, const uint8_t
     +
     +    return VIRTIO_SND_S_OK;
     +}
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
    ++                                            VirtIOSoundPCMParams *params)
    ++{
    ++    as->nchannels = MIN(AUDIO_MAX_CHANNELS, params->channels);
    ++    as->fmt = virtio_snd_get_qemu_format(params->format);
    ++    as->freq = virtio_snd_get_qemu_freq(params->rate);
    ++    as->endianness = AUDIO_HOST_ENDIANNESS;
    ++}
    ++
    ++/*
    ++ * Close a stream and free all its resources.
    ++ *
    ++ * @stream: VirtIOSoundPCMStream *stream
    ++ */
    ++static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    ++{
    ++    if (stream) {
    ++        qemu_mutex_destroy(&stream->queue_mutex);
    ++        g_free(stream);
    ++    }
    ++}
    ++
    ++/*
    ++ * Prepares a VirtIOSound card stream.
    ++ * Returns the response status code. (VIRTIO_SND_S_*).
    ++ *
    ++ * @s: VirtIOSound device
    ++ * @stream_id: stream id
    ++ */
    ++static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
    ++{
    ++    audsettings as;
    ++    VirtIOSoundPCMParams *params;
    ++    VirtIOSoundPCMStream *stream;
    ++
    ++    if (!s->pcm->streams ||
    ++        !s->pcm->pcm_params ||
    ++        !s->pcm->pcm_params[stream_id]) {
    ++        return VIRTIO_SND_S_BAD_MSG;
    ++    }
    ++
    ++    params = virtio_snd_pcm_get_params(s, stream_id);
    ++    if (!params) {
    ++        return VIRTIO_SND_S_BAD_MSG;
    ++    }
    ++
    ++    virtio_snd_get_qemu_audsettings(&as, params);
    ++
    ++    virtio_snd_pcm_close(s->pcm->streams[stream_id]);
    ++
    ++    stream = g_new0(VirtIOSoundPCMStream, 1);
    ++
    ++    stream->id = stream_id;
    ++    stream->pcm = s->pcm;
    ++    stream->direction = stream_id < s->snd_conf.streams / 2 +
    ++        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
    ++    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
    ++    stream->features = 0;
    ++    stream->channels_min = 1;
    ++    stream->channels_max = as.nchannels;
    ++    stream->formats = supported_formats;
    ++    stream->rates = supported_rates;
    ++    stream->s = s;
    ++
    ++    stream->buffer_bytes = params->buffer_bytes;
    ++    stream->period_bytes = params->period_bytes;
    ++
    ++    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
    ++    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
    ++
    ++    stream->as = as;
    ++    stream->desired_as = stream->as;
    ++    qemu_mutex_init(&stream->queue_mutex);
    ++    QSIMPLEQ_INIT(&stream->queue);
    ++
    ++    s->pcm->streams[stream_id] = stream;
    ++
    ++    return VIRTIO_SND_S_OK;
    ++}
     +
      /*
       * The actual processing done in virtio_snd_process_cmdq().
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_common_realize(DeviceState *dev,
     +                       print_code(status));
     +            return;
     +        }
    ++        status = virtio_snd_pcm_prepare_impl(vsnd, i);
    ++        if (status != VIRTIO_SND_S_OK) {
    ++            error_setg(errp,
    ++                       "Can't prepare streams, device responded with %s.",
    ++                       print_code(status));
    ++            return;
    ++        }
     +    }
      }
      
      static void
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    +                               errp);
    + }
    + 
    +-/*
    +- * Close the stream and free its resources.
    +- *
    +- * @stream: VirtIOSoundPCMStream *stream
    +- */
    +-static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    +-{
    +-}
    +-
    + static void virtio_snd_unrealize(DeviceState *dev)
    + {
    +     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    +         vsnd->pcm = NULL;
    +     }
    +     AUD_remove_card(&vsnd->card);
    ++    qemu_mutex_destroy(&vsnd->cmdq_mutex);
    +     virtio_cleanup(vdev);
    + }
    + 
 5:  19d95e8411 <  -:  ---------- virtio-sound: prepare PCM streams
 6:  78777fb46f =  5:  06f676e360 virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
 7:  7641e21ee8 =  6:  d3102a0850 virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
 8:  48f9b776f5 =  7:  0cb3e8a3b5 virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
 9:  cdb8ab3ee2 =  8:  894b52532b virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
10:  bbc11d0348 !  9:  4aebc54222 virtio-sound: handle VIRTIO_SND_PCM_RELEASE
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
      }
      
     +/*
    -+ * Releases the buffer resources allocated to a stream. Seperated from the
    -+ * handler so that the code can be reused in the unrealize function. Returns
    -+ * the response status code. (VIRTIO_SND_S_*).
    -+ *
    -+ * @stream: VirtIOSoundPCMStream stream
    -+ * @stream_id: stream id
    -+ */
    -+static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
    -+                                            uint32_t stream_id)
    -+{
    -+    return VIRTIO_SND_S_OK;
    -+}
    -+
    -+/*
    -+ * Handles VIRTIO_SND_R_PCM_RELEASE.
    ++ * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
    ++ * a stream.
     + *
     + * @s: VirtIOSound device
     + * @cmd: The request command queue element from VirtIOSound cmdq field
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +        cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
     +        return;
     +    }
    -+    cmd->resp.code = virtio_snd_pcm_release_impl(stream, stream_id);
    ++    cmd->resp.code = VIRTIO_SND_S_OK;
     +}
     +
      /*
11:  d5fb4b058c ! 10:  ab95cdd4ae virtio-sound: implement audio output (TX)
    @@ hw/virtio/virtio-snd.c
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
                                        | BIT(VIRTIO_SND_PCM_FMT_S16)
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_get_qemu_audsettings(audsettings *as,
    +  */
    + static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    + {
    ++    VirtIOSoundPCMBlock *block, *next;
    ++
    +     if (stream) {
    ++        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
    ++            QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
    ++                virtqueue_push(block->vq,
    ++                        block->elem,
    ++                        sizeof(block->elem));
    ++                virtio_notify(VIRTIO_DEVICE(stream->s),
    ++                        block->vq);
    ++                QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
    ++                g_free(block);
    ++            }
    ++        }
    ++        if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    ++            AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
    ++            stream->voice.out = NULL;
    ++        }
    +         qemu_mutex_destroy(&stream->queue_mutex);
    +         g_free(stream);
    +     }
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
          stream->positions[0] = VIRTIO_SND_CHMAP_FL;
          stream->positions[1] = VIRTIO_SND_CHMAP_FR;
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
          }
      }
      
    -+/*
    + /*
    +- * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
    +- * a stream.
     + * Returns the number of bytes that have not been passed to AUD_write yet.
     + *
     + * @stream: VirtIOSoundPCMStream
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +    return size;
     +}
     +
    - /*
    -  * Releases the buffer resources allocated to a stream. Seperated from the
    -  * handler so that the code can be reused in the unrealize function. Returns
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
    - static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
    -                                             uint32_t stream_id)
    - {
    ++/*
    ++ * Handles VIRTIO_SND_R_PCM_RELEASE.
    +  *
    +  * @s: VirtIOSound device
    +  * @cmd: The request command queue element from VirtIOSound cmdq field
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
    +         cmd->resp.code = VIRTIO_SND_S_BAD_MSG;
    +         return;
    +     }
    ++
     +    if (virtio_snd_pcm_get_pending_bytes(stream)) {
     +        /*
     +         * virtio-v1.2-csd01, 5.14.6.6.5.1,
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
     +        virtio_snd_pcm_flush(stream);
     +    }
     +
    -     return VIRTIO_SND_S_OK;
    +     cmd->resp.code = VIRTIO_SND_S_OK;
      }
      
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error *
     +    }
     +}
     +
    - /*
    -  * Close the sound card.
    -  *
    -@@ hw/virtio/virtio-snd.c: static void virtio_snd_realize(DeviceState *dev, Error **errp)
    - static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    - {
    -     virtio_snd_process_cmdq(stream->s);
    -+    if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    -+        AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
    -+        stream->voice.out = NULL;
    -+    }
    - }
    - 
      static void virtio_snd_unrealize(DeviceState *dev)
    + {
    +     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
    - 
    -     trace_virtio_snd_unrealize(vsnd);
    - 
    --    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    --        stream = vsnd->pcm->streams[i];
    --        virtio_snd_pcm_close(stream);
    --        g_free(stream);
    -+    if (vsnd->pcm) {
    -+        if (vsnd->pcm->streams) {
    -+            for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
    -+                stream = vsnd->pcm->streams[i];
    -+                if (stream) {
    -+                    virtio_snd_pcm_close(stream);
    -+                    g_free(stream);
    -+                }
    -+            }
    -+            g_free(vsnd->pcm->streams);
    -+            g_free(vsnd->pcm->pcm_params);
    -+            g_free(vsnd->pcm->jacks);
    -+        }
    -+
    -+        g_free(vsnd->pcm);
    +             }
    +             g_free(vsnd->pcm->streams);
    +         }
    ++        g_free(vsnd->pcm->pcm_params);
    ++        g_free(vsnd->pcm->jacks);
    +         g_free(vsnd->pcm);
    +         vsnd->pcm = NULL;
          }
    -+
    -+    vsnd->pcm = NULL;
    -     AUD_remove_card(&vsnd->card);
    --    g_free(vsnd->pcm);
    -     virtio_cleanup(vdev);
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
      }
      
      
12:  e2c30e2a21 ! 11:  5e8f423499 virtio-sound: implement audio capture (RX)
    @@ hw/virtio/virtio-snd.c
      
      static uint32_t supported_formats = BIT(VIRTIO_SND_PCM_FMT_S8)
                                        | BIT(VIRTIO_SND_PCM_FMT_U8)
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
    +         if (stream->direction == VIRTIO_SND_D_OUTPUT) {
    +             AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
    +             stream->voice.out = NULL;
    ++        } else if (stream->direction == VIRTIO_SND_D_INPUT) {
    ++            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
    ++            stream->voice.in = NULL;
    +         }
    +         qemu_mutex_destroy(&stream->queue_mutex);
    +         g_free(stream);
     @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t stream_id)
                                               virtio_snd_pcm_out_cb,
                                               &as);
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_start_stop(VirtIOSound
              }
          } else {
              error_report("Invalid stream id: %"PRIu32, req.stream_id);
    -@@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
    +@@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_pcm_release(VirtIOSound *s,
               */
              virtio_snd_process_cmdq(stream->s);
              trace_virtio_snd_pcm_stream_flush(stream_id);
    @@ hw/virtio/virtio-snd.c: static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundP
     +        }
          }
      
    -     return VIRTIO_SND_S_OK;
    +     cmd->resp.code = VIRTIO_SND_S_OK;
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
       * @vdev: VirtIOSound device
       * @vq: tx virtqueue
    @@ hw/virtio/virtio-snd.c: static void virtio_snd_pcm_out_cb(void *data, int availa
     +            );
     +}
     +
    - /*
    -  * Close the sound card.
    -  *
    + static void virtio_snd_unrealize(DeviceState *dev)
    + {
    +     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     @@ hw/virtio/virtio-snd.c: static void virtio_snd_unrealize(DeviceState *dev)
      
      
 -:  ---------- > 12:  a3f2576f6a docs/system: add basic virtio-snd documentation

base-commit: 408af44d04476c633065bfb1eca6865ea93f2984
-- 
2.39.2


