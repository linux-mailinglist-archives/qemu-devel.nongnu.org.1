Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9F75697C
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRLx-0003Qv-S8; Mon, 17 Jul 2023 12:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLRLr-0003EZ-UL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:45:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLRLm-0005KJ-Ku
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:45:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so36234465e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689612327; x=1692204327;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9G3mKvQe+3OfNuyw9uHVHKEegZlnydAZPmVkbrX6xgI=;
 b=mu6o7JN5oCuLakmE+fqU8U2zK+Nv8bFZ2D4jYhfffaLOunYn1XBgMSrz4ft085oReF
 GhYLbmXun4EI/Lup2oyEI/wuhdakBms2CB8GtapEFAYjJzdSAFw6xC5kwWI9QHcPeGgK
 35WDN1jXfDR6/WJn8ogVAoR3jdItG8/4PlfQcr/uCA6SA0iDQEzLph9FzgPONkA80cPf
 D5DOTfSWCYxxLt6UMTGW+57mSL2DbOBVTKT9LfnBxTKKtm9bHZkLuhSM1NrtMpDEjYH2
 kQB5h898Li38uNQ3hdTkHxCFW3JsQI6Rbx243bOnWgx+IK5Yq1hIDoSpEefL/I05fgAz
 3CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689612327; x=1692204327;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9G3mKvQe+3OfNuyw9uHVHKEegZlnydAZPmVkbrX6xgI=;
 b=Mw9eKuzuUC9wURS0KvcbPHIIp1s66xsUuZLa/+O2x+oY+rZlY+Ev1Nt6SqQRLpPQUh
 J7Mxq5eRqnBnq0sTceynFA00BHZGrUe9seznixUaEGR+6z6ZyTNtii++vusf0nbV/ABQ
 lkQvS3DK5LCYHxBICbYVhOxet0NMIexHRVFB6YG/uIIOqer+Wejnydtm2MTGAvvz59nZ
 cv2DRChshsn16yraPO22aAw0zRSZJDi8/f49tA3uZkFo2joeyp0ubtrzHgZW45o0yxYP
 TJyED+tCj6gmciPtfI2Vf182H/2GYAHXxlaeSMQtDxlOjLOjwf4Fj5I75hr6GsOk1nIe
 MhdA==
X-Gm-Message-State: ABy/qLa6j+2/vGWxYyDQC5vM34Wzh0X3ExbZhmy4AOynxtRxGvBOMkBN
 +HqpaqZRJ4/YwAqUFFVyFhLCFg==
X-Google-Smtp-Source: APBJJlEbu8RsBQNU2e+95xfCgCcblaO1992s8fk82g+TblSzwrp+//Z1p8q6wifwGuvxR1uX9FftAA==
X-Received: by 2002:a5d:42cf:0:b0:313:f3c0:62d8 with SMTP id
 t15-20020a5d42cf000000b00313f3c062d8mr9304168wrr.21.1689612326724; 
 Mon, 17 Jul 2023 09:45:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfe608000000b003141f3843e6sm19553542wrm.90.2023.07.17.09.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 09:45:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CBBF01FFBB;
 Mon, 17 Jul 2023 17:45:24 +0100 (BST)
References: <cover.1686238728.git.manos.pitsidianakis@linaro.org>
 <95d564fc1f36c9e12b466c07ea000b38d14aec4e.1686238728.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/3] Add virtio-sound device
Date: Mon, 17 Jul 2023 16:38:29 +0100
In-reply-to: <95d564fc1f36c9e12b466c07ea000b38d14aec4e.1686238728.git.manos.pitsidianakis@linaro.org>
Message-ID: <87lefewkpn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This patch adds an audio device implementing the recent virtio sound
> spec (1.2).
>
> PCM functionality is implemented, and jack[0], chmaps[1] messages are
> at the moment left unimplemented.
>
> PS2: This patch was based on a draft patch posted by OpenSynergy in 2019.=
 [2]
>
> [0]: https://www.kernel.org/doc/html/latest/sound/designs/jack-controls.h=
tml
> [1]: https://www.kernel.org/doc/html/latest/sound/designs/channel-mapping=
-api.html
> [2]: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40=
a8e603f4da92471#diff-fa5c10be8476fb5385a280885d527b0b40dfc11ddcc74369fce085=
d8b5b17bbd
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> ---
>  MAINTAINERS                    |    6 +
>  hw/virtio/Kconfig              |    5 +
>  hw/virtio/meson.build          |    1 +
>  hw/virtio/trace-events         |   21 +
>  hw/virtio/virtio-snd.c         | 1121 ++++++++++++++++++++++++++++++++
>  include/hw/virtio/virtio-snd.h |  194 ++++++
>  6 files changed, 1348 insertions(+)
>  create mode 100644 hw/virtio/virtio-snd.c
>  create mode 100644 include/hw/virtio/virtio-snd.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1c93ab0ee5..5d5475b1c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2218,6 +2218,12 @@ F: hw/virtio/virtio-mem-pci.h
>  F: hw/virtio/virtio-mem-pci.c
>  F: include/hw/virtio/virtio-mem.h
>=20=20
> +virtio-snd
> +M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> +S: Supported
> +F: hw/virtio/virtio-snd*.c
> +F: include/hw/virtio/virtio-snd.h
> +
>  nvme
>  M: Keith Busch <kbusch@kernel.org>
>  M: Klaus Jensen <its@irrelevant.dk>
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 89e9e426d8..fcc522ed21 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -17,6 +17,11 @@ config VIRTIO_PCI
>      depends on PCI
>      select VIRTIO
>=20=20
> +config VIRTIO_SND
> +    bool
> +    default y
> +    depends on VIRTIO
> +
>  config VIRTIO_MMIO
>      bool
>      select VIRTIO
> diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
> index bdec78bfc6..8cf49af618 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -68,5 +68,6 @@ softmmu_ss.add(when: 'CONFIG_VIRTIO', if_false: files('=
virtio-stub.c'))
>  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
>  softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('virtio-stub.c'))
>  softmmu_ss.add(files('virtio-hmp-cmds.c'))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_SND', if_true:
> files('virtio-snd.c'))

I suspect this wants to be above with the other specific_virtio_ss devices,
currently:

  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI', 'CONFIG_VHOST_USER_GPI=
O'], if_true: files('vhost-user-gpio-pci.c'))
  specific_virtio_ss.add(when: 'CONFIG_VHOST_USER_SCMI', if_true: files('vh=
ost-user-scmi.c'))
  specific_virtio_ss.add(when: ['CONFIG_VIRTIO_PCI','CONFIG_VHOST_USER_SCMI=
'], if_true: files('vhost-user-sc

Although I suspect the vhost-user-scmi-pci and vhost-user-gpio-pci need
to be shuffled down into the virtio_pci_ss source set bellow (as
separate patches, and maybe start sorting them?)

>=20=20
>  specific_ss.add_all(when: 'CONFIG_VIRTIO', if_true: specific_virtio_ss)
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8f8d05cf9b..b77d78abdc 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -151,3 +151,24 @@ virtio_pmem_flush_done(int type) "fsync return=3D%d"
>  virtio_gpio_start(void) "start"
>  virtio_gpio_stop(void) "stop"
>  virtio_gpio_set_status(uint8_t status) "0x%x"
> +
> +#virtio-snd.c
> +virtio_snd_pcm_stream_flush(int stream) "flushing stream %d"
> +virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event =
for queue %p"
> +#virtio_snd_handle_jack_info(int jack) "VIRTIO_SND_JACK_INFO called for =
jack %d"
> +#virtio_snd_handle_jack_remap(void) "VIRTIO_SND_PCM_JACK_REMAP called"
> +virtio_snd_handle_pcm_info(int stream) "VIRTIO_SND_R_PCM_INFO called for=
 stream %d"
> +virtio_snd_handle_pcm_set_params(int stream) "VIRTIO_SND_PCM_SET_PARAMS =
called for stream %d"
> +virtio_snd_handle_pcm_start_stop(const char *code, int stream) "%s calle=
d for stream %d"
> +virtio_snd_handle_pcm_release(int stream) "VIRTIO_SND_PCM_RELEASE called=
 for stream %d"
> +virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
> +virtio_snd_handle_xfer(void) "tx/rx queue callback called"
> +virtio_snd_handle_event(void) "event queue callback called"
> +virtio_snd_realize(void *snd) "snd %p: realize"
> +virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> +virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_feat=
ures 0x%"PRIx64
> +virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint=
32_t chmaps) "snd %p: get_config jacks=3D%d streams=3D%d chmaps=3D%d"
> +virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, ui=
nt32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps)=
 "snd %p: set_config jacks from %d->%d, streams from %d->%d, chmaps from %d=
->%d"
> +virtio_snd_vm_state_running(void) "vm state running"
> +virtio_snd_vm_state_stopped(void) "vm state stopped"
> +virtio_snd_handle_code(int val, const char *code) "ctrl code msg val =3D=
 %d =3D=3D %s"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> new file mode 100644
> index 0000000000..e3b6c353ad
> --- /dev/null
> +++ b/hw/virtio/virtio-snd.c
> @@ -0,0 +1,1121 @@
> +/*
> + * VIRTIO Sound Device conforming to
> + *
> + * "Virtual I/O Device (VIRTIO) Version 1.2
> + * Committee Specification Draft 01
> + * 09 May 2022"

The canonical URL wouldn't go amiss here:

  https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-52900014

> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linar=
o.org>
> + * Copyright (C) 2019 OpenSynergy GmbH
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
<snip>
> +
> +/*
> + * Set the given stream params.
> + * Called by both virtio_snd_handle_pcm_set_params and during device
> + * initialization.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @s: VirtIOSound device
> + * @params: The PCM params as defined in the virtio specification
> + */
> +static
> +uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *s,
> +                                       virtio_snd_pcm_set_params *params)
> +{
> +    uint32_t supported_formats, supported_rates;
> +    VirtIOSoundPCMParams *st_params;
> +    uint32_t stream_id =3D params->hdr.stream_id;
> +
> +    if (stream_id > s->snd_conf.streams || !(s->pcm->pcm_params)) {
> +        virtio_error(VIRTIO_DEVICE(s), "Streams have not been initialize=
d.\n");
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    if (!s->pcm->pcm_params[stream_id]) {
> +        s->pcm->pcm_params[stream_id] =3D g_new0(VirtIOSoundPCMParams, 1=
);
> +    }
> +    st_params =3D virtio_snd_pcm_get_params(s, stream_id);
> +
> +    st_params->features =3D params->features;
> +    st_params->buffer_bytes =3D params->buffer_bytes;
> +    st_params->period_bytes =3D params->period_bytes;
> +
> +    if (params->channels < 1 || params->channels > AUDIO_MAX_CHANNELS) {
> +        error_report("Number of channels is not supported.");
> +        return VIRTIO_SND_S_NOT_SUPP;
> +    }
> +    st_params->channels =3D params->channels;
> +
> +    supported_formats =3D 1 << VIRTIO_SND_PCM_FMT_S8
> +                      | 1 << VIRTIO_SND_PCM_FMT_U8
> +                      | 1 << VIRTIO_SND_PCM_FMT_S16
> +                      | 1 << VIRTIO_SND_PCM_FMT_U16
> +                      | 1 << VIRTIO_SND_PCM_FMT_S32
> +                      | 1 << VIRTIO_SND_PCM_FMT_U32
> +                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
> +
> +    supported_rates =3D 1 << VIRTIO_SND_PCM_RATE_5512
> +                    | 1 << VIRTIO_SND_PCM_RATE_8000
> +                    | 1 << VIRTIO_SND_PCM_RATE_11025
> +                    | 1 << VIRTIO_SND_PCM_RATE_16000
> +                    | 1 << VIRTIO_SND_PCM_RATE_22050
> +                    | 1 << VIRTIO_SND_PCM_RATE_32000
> +                    | 1 << VIRTIO_SND_PCM_RATE_44100
> +                    | 1 << VIRTIO_SND_PCM_RATE_48000
> +                    | 1 << VIRTIO_SND_PCM_RATE_64000
> +                    | 1 << VIRTIO_SND_PCM_RATE_88200
> +                    | 1 << VIRTIO_SND_PCM_RATE_96000
> +                    | 1 << VIRTIO_SND_PCM_RATE_176400
> +                    | 1 << VIRTIO_SND_PCM_RATE_192000
> +                    | 1 << VIRTIO_SND_PCM_RATE_384000;

There seems to be a lot of duplication of constants with
virtio_snd_pcm_prepare_impl bellow. Is this stuff that depends on the
backend? Is it fixed or dynamic depending on the machine?

> +
> +    if (!(supported_formats & (1 << params->format))) {
> +        error_report("Stream format is not supported.");
> +        return VIRTIO_SND_S_NOT_SUPP;
> +    }
> +    st_params->format =3D params->format;
> +
> +    if (!(supported_rates & (1 << params->rate))) {
> +        error_report("Stream rate is not supported.");
> +        return VIRTIO_SND_S_NOT_SUPP;
> +    }
> +    st_params->rate =3D params->rate;
> +    st_params->period_bytes =3D params->period_bytes;
> +    st_params->buffer_bytes =3D params->buffer_bytes;
> +
> +    return VIRTIO_SND_S_OK;
> +}
> +
> +/*
> + * Handles the VIRTIO_SND_R_PCM_SET_PARAMS request.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_set_params(VirtIOSound *s,
> +                                             virtio_snd_ctrl_command *cm=
d)
> +{
> +    virtio_snd_pcm_set_params req;
> +    uint32_t sz;
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg,
> +                    cmd->elem->out_num,
> +                    0,
> +                    &req,
> +                    sizeof(req));
> +    assert(sz =3D=3D sizeof(virtio_snd_pcm_set_params));
> +
> +    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
> +    cmd->resp.code =3D virtio_snd_pcm_set_params_impl(s, &req);
> +
> +    return;
> +}
> +
> +/*
> + * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_=
FMT_*
> + */
> +static AudioFormat virtio_snd_get_qemu_format(uint32_t format)
> +{
> +    switch (format) {
> +    case VIRTIO_SND_PCM_FMT_U8:
> +        return AUDIO_FORMAT_U8;

Dare I suggest macros?

  #define CASE(FMT)                              \
      case VIRTIO_SND_PCM_FMT__##FMT:            \
          return AUDIO_FORMAT_##FMT

      case(S8);
      case(U16);
      ...
      default:
          return -1;

  #undef CASE

I know it's not quite as hygienic as rust but this is C ;-)

> +    case VIRTIO_SND_PCM_FMT_S8:
> +        return AUDIO_FORMAT_S8;
> +    case VIRTIO_SND_PCM_FMT_U16:
> +        return AUDIO_FORMAT_U16;
> +    case VIRTIO_SND_PCM_FMT_S16:
> +        return AUDIO_FORMAT_S16;
> +    case VIRTIO_SND_PCM_FMT_U32:
> +        return AUDIO_FORMAT_U32;
> +    case VIRTIO_SND_PCM_FMT_S32:
> +        return AUDIO_FORMAT_S32;
> +    case VIRTIO_SND_PCM_FMT_FLOAT:
> +        return AUDIO_FORMAT_F32;
> +    default:
> +        return -1;
> +    }
> +}
> +
> +/*
> + * Get a QEMU Audiosystem compatible frequency value from a
> + * VIRTIO_SND_PCM_RATE_*
> + */
> +static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
> +{
> +    switch (rate) {
> +    case VIRTIO_SND_PCM_RATE_5512:
> +        return 5512;

Same?

> +    case VIRTIO_SND_PCM_RATE_8000:
> +        return 8000;
> +    case VIRTIO_SND_PCM_RATE_11025:
> +        return 11025;
> +    case VIRTIO_SND_PCM_RATE_16000:
> +        return 16000;
> +    case VIRTIO_SND_PCM_RATE_22050:
> +        return 22050;
> +    case VIRTIO_SND_PCM_RATE_32000:
> +        return 32000;
> +    case VIRTIO_SND_PCM_RATE_44100:
> +        return 44100;
> +    case VIRTIO_SND_PCM_RATE_48000:
> +        return 48000;
> +    case VIRTIO_SND_PCM_RATE_64000:
> +        return 64000;
> +    case VIRTIO_SND_PCM_RATE_88200:
> +        return 88200;
> +    case VIRTIO_SND_PCM_RATE_96000:
> +        return 96000;
> +    case VIRTIO_SND_PCM_RATE_176400:
> +        return 176400;
> +    case VIRTIO_SND_PCM_RATE_192000:
> +        return 192000;
> +    case VIRTIO_SND_PCM_RATE_384000:
> +        return 384000;
> +    default:
> +        return -1;
> +    }
> +}
> +
> +/*
> + * Get QEMU Audiosystem compatible audsettings from virtio based pcm str=
eam
> + * params.
> + */
> +static void virtio_snd_get_qemu_audsettings(audsettings *as,
> +                                            VirtIOSoundPCMParams *params)
> +{
> +    as->nchannels =3D MIN(AUDIO_MAX_CHANNELS, params->channels);
> +    as->fmt =3D virtio_snd_get_qemu_format(params->format);
> +    as->freq =3D virtio_snd_get_qemu_freq(params->rate);
> +    as->endianness =3D AUDIO_HOST_ENDIANNESS;
> +}
> +
> +/*
> + * Prepares a VirtIOSound card stream.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + */
> +static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t str=
eam_id)
> +{
> +    audsettings as;
> +    uint32_t supported_formats, supported_rates;
> +    VirtIOSoundPCMParams *params;
> +    VirtIOSoundPCMStream *stream;
> +
> +    if (!s->pcm->streams
> +            || !s->pcm->pcm_params
> +            || !s->pcm->pcm_params[stream_id]) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    supported_formats =3D 1 << VIRTIO_SND_PCM_FMT_S8
> +                      | 1 << VIRTIO_SND_PCM_FMT_U8
> +                      | 1 << VIRTIO_SND_PCM_FMT_S16
> +                      | 1 << VIRTIO_SND_PCM_FMT_U16
> +                      | 1 << VIRTIO_SND_PCM_FMT_S32
> +                      | 1 << VIRTIO_SND_PCM_FMT_U32
> +                      | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
> +
> +    supported_rates =3D 1 << VIRTIO_SND_PCM_RATE_5512
> +                    | 1 << VIRTIO_SND_PCM_RATE_8000
> +                    | 1 << VIRTIO_SND_PCM_RATE_11025
> +                    | 1 << VIRTIO_SND_PCM_RATE_16000
> +                    | 1 << VIRTIO_SND_PCM_RATE_22050
> +                    | 1 << VIRTIO_SND_PCM_RATE_32000
> +                    | 1 << VIRTIO_SND_PCM_RATE_44100
> +                    | 1 << VIRTIO_SND_PCM_RATE_48000
> +                    | 1 << VIRTIO_SND_PCM_RATE_64000
> +                    | 1 << VIRTIO_SND_PCM_RATE_88200
> +                    | 1 << VIRTIO_SND_PCM_RATE_96000
> +                    | 1 << VIRTIO_SND_PCM_RATE_176400
> +                    | 1 << VIRTIO_SND_PCM_RATE_192000
> +                    | 1 << VIRTIO_SND_PCM_RATE_384000;
> +
> +    params =3D virtio_snd_pcm_get_params(s, stream_id);
> +    assert(params);

asserting for something you expect to happen is bad form. If it
shouldn't happen maybe the assert should be lower (i.e. in
virtio_snd_pcm_get_params itself)?

> +
> +    virtio_snd_get_qemu_audsettings(&as, params);
> +
> +    stream =3D g_new0(VirtIOSoundPCMStream, 1);
> +
> +    stream->id =3D stream_id;
> +    stream->pcm =3D s->pcm;
> +    stream->direction =3D stream_id < s->snd_conf.streams / 2 +
> +        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_I=
NPUT;
> +    stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> +    stream->features =3D 0;
> +    stream->channels_min =3D 1;
> +    stream->channels_max =3D as.nchannels;
> +    stream->formats =3D supported_formats;
> +    stream->rates =3D supported_rates;
> +    stream->s =3D s;
> +
> +    stream->buffer_bytes =3D params->buffer_bytes;
> +    stream->period_bytes =3D params->period_bytes;
> +
> +    stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> +    stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> +
> +
> +    if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        stream->voice.out =3D AUD_open_out(&s->card,
> +                                         stream->voice.out,
> +                                         "virtio_snd_card",
> +                                         stream,
> +                                         virtio_snd_pcm_out_cb,
> +                                         &as);
> +
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimpleme=
nted.");
> +        /*
> +         * stream->voice.in =3D AUD_open_in(&s->card,
> +         *                                stream->voice.in,
> +         *                                "virtio_snd_card",
> +         *                                stream,
> +         *                                virtio_snd_input_cb,
> +         *                                &as);
> +         */
> +    }
> +
> +    stream->as =3D as;
> +    stream->desired_as =3D stream->as;
> +    qemu_mutex_init(&stream->queue_mutex);
> +    QSIMPLEQ_INIT(&stream->queue);
> +
> +    s->pcm->streams[stream_id] =3D stream;
> +
> +    return VIRTIO_SND_S_OK;
> +}
> +
> +/*
> + * Handles VIRTIO_SND_R_PCM_PREPARE.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
> +                                          virtio_snd_ctrl_command *cmd)
> +{
> +    uint32_t stream_id;
> +    size_t sz;
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
> +                    sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id=
));
> +    assert(sz =3D=3D sizeof(uint32_t));
> +
> +    cmd->resp.code =3D virtio_snd_pcm_prepare_impl(s, stream_id);
> +    return;
> +}
> +
> +/*
> + * Handles VIRTIO_SND_R_PCM_START.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + * @start: whether to start or stop the device
> + */
> +static void virtio_snd_handle_pcm_start_stop(VirtIOSound *s,
> +                                             virtio_snd_ctrl_command *cm=
d,
> +                                             bool start)
> +{
> +    VirtIOSoundPCMStream *stream;
> +    virtio_snd_pcm_hdr req;
> +    size_t sz;
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg,
> +                    cmd->elem->out_num,
> +                    0,
> +                    &req,
> +                    sizeof(req));
> +    assert(sz =3D=3D sizeof(virtio_snd_pcm_hdr));

asserting on guest data is also a no no.

> +
> +    cmd->resp.code =3D VIRTIO_SND_S_OK;
> +    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_STA=
RT" :
> +            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
> +
> +    stream =3D virtio_snd_pcm_get_stream(s, req.stream_id);
> +
> +    if (stream) {
> +        if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +            AUD_set_active_out(stream->voice.out, start);
> +        }
> +    } else {
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +    }
> +    return;
> +}
> +
> +/*
> + * Returns the number of bytes that have not been passed to AUD_write ye=
t.
> + *
> + * @stream: VirtIOSoundPCMStream
> + */
> +static int virtio_snd_pcm_get_pending_bytes(VirtIOSoundPCMStream *stream)
> +{
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +    int size =3D 0;
> +
> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +            size +=3D block->size;
> +        }
> +    }
> +    return size;
> +}
> +
> +/*
> + * Releases the buffer resources allocated to a stream. Seperated from t=
he
> + * handler so that the code can be reused in the unrealize function. Ret=
urns
> + * the response status code. (VIRTIO_SND_S_*).
> + *
> + * @stream: VirtIOSoundPCMStream stream
> + * @stream_id: stream id
> + */
> +static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
> +                                            uint32_t stream_id)
> +{
> +    assert(stream->s->pcm->streams[stream_id] =3D=3D stream);
> +
> +    if (virtio_snd_pcm_get_pending_bytes(stream)) {
> +        /*
> +         * virtio-v1.2-csd01, 5.14.6.6.5.1,
> +         * Device Requirements: Stream Release
> +         *
> +         * - The device MUST complete all pending I/O messages for the
> +         *   specified stream ID.
> +         * - The device MUST NOT complete the control request while there
> +         *   are pending I/O messages for the specified stream ID.
> +         */
> +        virtio_snd_process_cmdq(stream->s);
> +        trace_virtio_snd_pcm_stream_flush(stream_id);
> +        virtio_snd_pcm_flush(stream);
> +    }
> +
> +    return VIRTIO_SND_S_OK;
> +}
> +
> +/*
> + * Handles VIRTIO_SND_R_PCM_RELEASE.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_release(VirtIOSound *s,
> +                                          virtio_snd_ctrl_command *cmd)
> +{
> +    uint32_t stream_id;
> +    size_t sz;
> +    VirtIOSoundPCMStream *stream;
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
> +            sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id));
> +    assert(sz =3D=3D sizeof(uint32_t));

ditto

> +
> +    trace_virtio_snd_handle_pcm_release(stream_id);
> +
> +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> +    if (!stream) {
> +        error_report("already released stream %d", stream_id);
> +        virtio_error(VIRTIO_DEVICE(s), "already released stream %d", str=
eam_id);
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +        return;
> +    }
> +    cmd->resp.code =3D virtio_snd_pcm_release_impl(stream, stream_id);
> +    return;
> +}
> +
> +/*
> + * The actual processing done in virtio_snd_process_cmdq().
> + *
> + * @s: VirtIOSound device
> + * @cmd: control command request
> + */
> +static inline void
> +process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cmd)
> +{
> +    VIRTIO_SND_FILL_CMD(cmd->ctrl);
> +    size_t sz;
> +
> +    trace_virtio_snd_handle_code(cmd->ctrl.code,
> +                                 print_code(cmd->ctrl.code));
> +
> +    switch (cmd->ctrl.code) {
> +    case VIRTIO_SND_R_JACK_INFO:
> +    case VIRTIO_SND_R_JACK_REMAP:
> +        qemu_log_mask(LOG_UNIMP,
> +                     "virtio_snd: jack functionality is unimplemented.");
> +        break;
> +    case VIRTIO_SND_R_PCM_INFO:
> +        virtio_snd_handle_pcm_info(s, cmd);
> +        break;
> +    case VIRTIO_SND_R_PCM_SET_PARAMS:
> +        virtio_snd_handle_pcm_set_params(s, cmd);
> +        break;
> +    case VIRTIO_SND_R_PCM_PREPARE:
> +        virtio_snd_handle_pcm_prepare(s, cmd);
> +        break;
> +    case VIRTIO_SND_R_PCM_START:
> +        virtio_snd_handle_pcm_start_stop(s, cmd, true);
> +        break;
> +    case VIRTIO_SND_R_PCM_STOP:
> +        virtio_snd_handle_pcm_start_stop(s, cmd, false);
> +        break;
> +    case VIRTIO_SND_R_PCM_RELEASE:
> +        virtio_snd_handle_pcm_release(s, cmd);
> +        break;
> +    case VIRTIO_SND_R_CHMAP_INFO:
> +        qemu_log_mask(LOG_UNIMP,
> +                     "virtio_snd: chmap info functionality is unimplemen=
ted.");
> +        trace_virtio_snd_handle_chmap_info();
> +        break;
> +    default:
> +        /* error */
> +        error_report("virtio snd header not recognized: %d", cmd->ctrl.c=
ode);
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    sz =3D iov_from_buf(cmd->elem->in_sg,
> +                      cmd->elem->in_num,
> +                      0,
> +                      &cmd->resp,
> +                      sizeof(cmd->resp));
> +    assert(sz =3D=3D sizeof(cmd->resp));
> +    virtqueue_push(cmd->vq, cmd->elem, sizeof(cmd->elem));
> +    virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
> +    cmd->finished =3D true;
> +}
> +
> +/*
> + * Consume all elements in command queue.
> + *
> + * @s: VirtIOSound device
> + */
> +static void virtio_snd_process_cmdq(VirtIOSound *s)
> +{
> +    virtio_snd_ctrl_command *cmd;
> +
> +    if (unlikely(qatomic_read(&s->processing_cmdq))) {
> +        return;
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
> +        qatomic_set(&s->processing_cmdq, true);
> +        while (!QTAILQ_EMPTY(&s->cmdq)) {
> +            cmd =3D QTAILQ_FIRST(&s->cmdq);
> +
> +            /* process command */
> +            process_cmd(s, cmd);
> +
> +            QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +
> +            assert(cmd->finished);
> +            g_free(cmd);
> +        }
> +        qatomic_set(&s->processing_cmdq, false);
> +    }
> +}
> +
> +/*
> + * The control message handler. Pops an element from the control virtque=
ue,
> + * and stores them to VirtIOSound's cmdq queue and finally calls
> + * virtio_snd_process_cmdq() for processing.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: Control virtqueue
> + */
> +static void virtio_snd_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    VirtQueueElement *elem;
> +    virtio_snd_ctrl_command *cmd;
> +
> +    trace_virtio_snd_handle_ctrl(vdev, vq);
> +
> +    if (!virtio_queue_ready(vq)) {
> +        return;
> +    }
> +
> +    elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    while (elem) {
> +        cmd =3D g_new0(virtio_snd_ctrl_command, 1);
> +        cmd->elem =3D elem;
> +        cmd->vq =3D vq;
> +        cmd->finished =3D false;
> +        cmd->resp.code =3D VIRTIO_SND_S_OK;
> +        QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    }
> +
> +    virtio_snd_process_cmdq(s);
> +}
> +
> +/*
> + * The event virtqueue handler.
> + * Not implemented yet.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: event vq
> + */
> +static void virtio_snd_handle_event(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    qemu_log_mask(LOG_UNIMP, "virtio_snd: event queue is unimplemented."=
);
> +    trace_virtio_snd_handle_event();
> +}
> +
> +/*
> + * The tx virtqueue handler. Makes the buffers available to their respec=
tive
> + * streams for consumption.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: tx virtqueue
> + */
> +static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    VirtIOSoundPCMStream *stream =3D NULL;
> +    VirtQueueElement *elem;
> +    size_t sz;
> +    virtio_snd_pcm_xfer hdr;
> +    virtio_snd_pcm_status resp =3D { 0 };
> +
> +    trace_virtio_snd_handle_xfer();
> +
> +    for (;;) {
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            break;
> +        }
> +        /* get the message hdr object */
> +        sz =3D iov_to_buf(elem->out_sg,
> +                        elem->out_num,
> +                        0,
> +                        &hdr,
> +                        sizeof(hdr));
> +        assert(sz =3D=3D sizeof(hdr));

ditto


I'm stopping now because this patch is too big...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

