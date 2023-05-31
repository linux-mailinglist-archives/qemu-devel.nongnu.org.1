Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52800717C75
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IVP-00082n-FW; Wed, 31 May 2023 05:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4IVJ-00082E-1D
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:52:29 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4IVD-0003kT-MO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:52:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6dbe3c230so57000305e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685526741; x=1688118741;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXeZMXh3FW/i0MyE+s2Xt1pvfOqs4286fgVFb7XME+A=;
 b=dFGm4lI78qZpIDfp7PxYapWEZO0kl1atHjHVr6x6XtLlrqgYoKl4NjU9DaY1B8yDkc
 wQTltOyEZqEefLDh4yYtu6OLTWs4TgBd9SqvXkp1hOhBlwMGEtwy5wBZ5hrXQJI6Osur
 fpOI1gBuJVqD9QJX3+Nl8pl8t8dYdQPtg8pNM6LepkRLXdKo4kTUJIsp9eVUGUSeKKvG
 20g04upAfT/2KE+hfiQc62RnE+68+5aBNi7KehdZzamKrJ/YY80jpUcYrm2sh8IHH2jy
 yafYXSPv389D8fptNFzd7pIw/cBFhdxmcWV1Q+84F/RJO5FIkouYZTpBG+60Ug3dnZ/W
 etxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685526741; x=1688118741;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MXeZMXh3FW/i0MyE+s2Xt1pvfOqs4286fgVFb7XME+A=;
 b=D3apYLptbey9AV/aflC0eipy6ew14t6bSyiXflZ+EdzktTCQStHErn7CHNDxX4HbPR
 Y19hSxZMhWP4gVE79UnD/dJGN1uy2OZlbqTp+k4FYpf28iGsKfQ/HXjY0VWqkYoDU+4/
 KxAWBIb6HpJJjuiKXYMeCcO5dmlX94fCFsb8P1Nc14yTvn1cJ+7aXqk/x7Ys2Sab/u4+
 39gGfbEK7ZGQHJCOWYC0VT0dJoTIq6WeP8MCgGWRsEFgoMh/3WaiuVO9HB74k1E187PT
 AdZS1pYGTi/mBdlIRtSmO4VYVCiFMhiwkf1LEKuRUEqyHM4w9UPDyeHDKfzH9IEqQQrp
 yegw==
X-Gm-Message-State: AC+VfDxxfovkUKD2I8HZNplE4jqWRDOBBSonyQE8FuuiNdZDoc8NLISu
 lI9FrAPW0KB4tcpgZU1ITZmvy3RJavcT8BI0Hrw=
X-Google-Smtp-Source: ACHHUZ4bpRJ3OU//6WT1orF7c9dorx1F5Zsq7lNm4VDv+AzVRs7nQ74nsRdqBZlt4xQN31XT7+ETKA==
X-Received: by 2002:a05:600c:2105:b0:3f4:2ae5:b35d with SMTP id
 u5-20020a05600c210500b003f42ae5b35dmr4472747wml.40.1685526741090; 
 Wed, 31 May 2023 02:52:21 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a7bcc01000000b003f50e29bce3sm20139196wmh.48.2023.05.31.02.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 02:52:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 06B881FFBB;
 Wed, 31 May 2023 10:52:20 +0100 (BST)
References: <20230526204845.673031-1-manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Add virtio-sound and virtio-sound-pci devices
Date: Wed, 31 May 2023 10:36:25 +0100
In-reply-to: <20230526204845.673031-1-manos.pitsidianakis@linaro.org>
Message-ID: <87a5xkde0c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
> spec (1.2) and a corresponding PCI wrapper device.
>
> PCM functionality is implemented, and jack[0], chmaps[1] messages are
> at the moment ignored.
>
> To test this, you'll need a >6.0 kernel compiled with the virtio-snd
> flag enabled, which distros have off by default.
>
> Use with following flags in the invocation:
>
>   -device virtio-sound-pci,disable-legacy=3Don
>
> And an audio backend listed with `-audio driver=3Dhelp` that works on
> your host machine, e.g.:
>
> Pulseaudio:
>   -audio driver=3Dpa,model=3Dvirtio-sound,server=3D/run/user/1000/pulse/n=
ative
> sdl:
>   -audio driver=3Dsdl,model=3Dvirtio-sound
> coreaudio:
>   -audio driver=3Dcoreaudio,model=3Dvirtio-sound
> etc.
>
> You can use speaker-test from alsa-tools to play noise, sines, or
> WAV files.
>
> PS2: This patch was based on a draft patch posted by opensynergy a few
>      years ago.

If it's based of shouldn't we keep the author attribution and their
original s-o-b?

What about:

  https://patchew.org/QEMU/20220211221319.193404-1-chouhan.shreyansh2702@gm=
ail.com/

(which is also much more nicely split up).

>
> [0]: https://www.kernel.org/doc/html/latest/sound/designs/jack-controls.h=
tml
> [1]: https://www.kernel.org/doc/html/latest/sound/designs/channel-mapping=
-api.html
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/Kconfig               |    5 +
>  hw/audio/meson.build           |    1 +
>  hw/audio/trace-events          |   23 +
>  hw/audio/virtio-snd.c          | 1139 ++++++++++++++++++++++++++++++++
>  hw/virtio/Kconfig              |    5 +
>  hw/virtio/meson.build          |    1 +
>  hw/virtio/virtio-snd-pci.c     |  104 +++

virtio-snd-pci should be a separate patch. Also why split across
hw/virtio and hw/audio. I appreciate QEMU isn't super consistent between
allocating VirtIO devices between hw/virtio and hw/device-class but we
should at least be consistent for the same device type.

>  include/hw/pci/pci.h           |    1 +
>  include/hw/virtio/virtio-snd.h |  193 ++++++
>  softmmu/qdev-monitor.c         |    1 +
>  10 files changed, 1473 insertions(+)
>  create mode 100644 hw/audio/virtio-snd.c
>  create mode 100644 hw/virtio/virtio-snd-pci.c
>  create mode 100644 include/hw/virtio/virtio-snd.h
>
> diff --git a/hw/audio/Kconfig b/hw/audio/Kconfig
> index e76c69ca7e..74afa21c50 100644
> --- a/hw/audio/Kconfig
> +++ b/hw/audio/Kconfig
> @@ -47,3 +47,8 @@ config PL041
>=20=20
>  config CS4231
>      bool
> +
> +config VIRTIO_SND
> +    bool
> +    default y
> +    depends on VIRTIO
> diff --git a/hw/audio/meson.build b/hw/audio/meson.build
> index e48a9fc73d..455e6a1501 100644
> --- a/hw/audio/meson.build
> +++ b/hw/audio/meson.build
> @@ -12,3 +12,4 @@ softmmu_ss.add(when: 'CONFIG_PL041', if_true: files('pl=
041.c', 'lm4549.c'))
>  softmmu_ss.add(when: 'CONFIG_SB16', if_true: files('sb16.c'))
>  softmmu_ss.add(when: 'CONFIG_VT82C686', if_true: files('via-ac97.c'))
>  softmmu_ss.add(when: 'CONFIG_WM8750', if_true: files('wm8750.c'))
> +softmmu_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd.c'))
> diff --git a/hw/audio/trace-events b/hw/audio/trace-events
> index 4dec48a4fd..d8ade63f13 100644
> --- a/hw/audio/trace-events
> +++ b/hw/audio/trace-events
> @@ -17,3 +17,26 @@ via_ac97_codec_write(uint8_t addr, uint16_t val) "0x%x=
 <- 0x%x"
>  via_ac97_sgd_fetch(uint32_t curr, uint32_t addr, char stop, char eol, ch=
ar flag, uint32_t len) "curr=3D0x%x addr=3D0x%x %c%c%c len=3D%d"
>  via_ac97_sgd_read(uint64_t addr, unsigned size, uint64_t val) "0x%"PRIx6=
4" %d -> 0x%"PRIx64
>  via_ac97_sgd_write(uint64_t addr, unsigned size, uint64_t val) "0x%"PRIx=
64" %d <- 0x%"PRIx64
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
 for stream %id"
> +virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
> +virtio_snd_handle_xfer(void) "tx/rx queue callback called"
> +virtio_snd_handle_xfer_elem(const char * k) "xfer handled in virtio_snd_=
pcm_%s"
> +virtio_snd_handle_event(void) "event queue callback called"
> +virtio_snd_cpu_is_stopped(void *snd, int size) "snd %p: cpu is stopped, =
dropping %d bytes"
> +virtio_snd_realize(void *snd) "snd %p: realize"
> +virtio_snd_unrealize(void *snd) "snd %p: realize"
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
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> new file mode 100644
> index 0000000000..3bf657f368
> --- /dev/null
> +++ b/hw/audio/virtio-snd.c
> @@ -0,0 +1,1139 @@
> +/*
> + * VIRTIO Sound Device conforming to
> + *
> + * "Virtual I/O Device (VIRTIO) Version 1.2
> + * Committee Specification Draft 01
> + * 09 May 2022"
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
> +#include "qemu/osdep.h"
> +#include "qemu/iov.h"
> +#include "qemu/log.h"
> +#include "sysemu/runstate.h"
> +#include "trace.h"
> +#include "qapi/error.h"
> +#include "hw/virtio/virtio-snd.h"
> +
> +#define VIRTIO_SOUND_VM_VERSION 1
> +
> +#define VIRTIO_SOUND_JACK_DEFAULT 0
> +#define VIRTIO_SOUND_STREAM_DEFAULT 1
> +#define VIRTIO_SOUND_CHMAP_DEFAULT 0
> +
> +#define VIRTIO_SOUND_HDA_FN_NID_OUT 0
> +#define VIRTIO_SOUND_HDA_FN_NID_IN 1
> +
> +static const VMStateDescription vmstate_virtio_snd_device =3D {
> +    .name =3D TYPE_VIRTIO_SND,
> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> +};
> +
> +static const VMStateDescription vmstate_virtio_snd =3D {
> +    .name =3D "virtio-sound",
> +    .minimum_version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .version_id =3D VIRTIO_SOUND_VM_VERSION,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_VIRTIO_DEVICE,
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static Property virtio_snd_properties[] =3D {
> +    DEFINE_AUDIO_PROPERTIES(VirtIOSound, card),
> +    DEFINE_PROP_UINT32("jacks", VirtIOSound, snd_conf.jacks,
> +                       VIRTIO_SOUND_JACK_DEFAULT),
> +    DEFINE_PROP_UINT32("streams", VirtIOSound, snd_conf.streams,
> +                       VIRTIO_SOUND_STREAM_DEFAULT),
> +    DEFINE_PROP_UINT32("chmaps", VirtIOSound, snd_conf.chmaps,
> +                       VIRTIO_SOUND_CHMAP_DEFAULT),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void
> +virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    trace_virtio_snd_get_config(vdev,
> +                                s->snd_conf.jacks,
> +                                s->snd_conf.streams,
> +                                s->snd_conf.chmaps);
> +
> +    memcpy(config, &s->snd_conf, sizeof(s->snd_conf));
> +}
> +
> +static void
> +virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    const virtio_snd_config *sndconfig =3D
> +        (const virtio_snd_config *)config;
> +
> +
> +   trace_virtio_snd_set_config(vdev,
> +                               s->snd_conf.jacks,
> +                               sndconfig->jacks,
> +                               s->snd_conf.streams,
> +                               sndconfig->streams,
> +                               s->snd_conf.chmaps,
> +                               sndconfig->chmaps);
> +
> +    memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
> +}
> +
> +static void virtio_snd_process_cmdq(VirtIOSound *s);
> +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> +static void virtio_snd_pcm_out_cb(void *data, int available);
> +static uint32_t virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
> +                                          VirtQueue *vq,
> +                                          VirtQueueElement *element,
> +                                          bool read);
> +
> +/*
> + * Get a specific stream from the virtio sound card device.
> + * Returns NULL if @stream_id is invalid or not allocated.
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + */
> +static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
> +                                                       uint32_t stream_i=
d)
> +{
> +    if (stream_id >=3D s->snd_conf.streams) {
> +        return NULL;
> +    }
> +    return s->pcm->streams[stream_id];
> +}
> +
> +/*
> + * Get params for a specific stream.
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + */
> +static VirtIOSoundPCMParams *virtio_snd_pcm_get_params(VirtIOSound *s,
> +                                                       uint32_t stream_i=
d)
> +{
> +    if (stream_id >=3D s->snd_conf.streams) {
> +        return NULL;
> +    }
> +    return s->pcm->pcm_params[stream_id];
> +}
> +
> +/*
> + * Handle the VIRTIO_SND_R_PCM_INFO request.
> + * The function writes the info structs to the request element.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> +                                       virtio_snd_ctrl_command *cmd)
> +{
> +    virtio_snd_query_info req;
> +    uint32_t sz;
> +    VirtIOSoundPCMStream *stream =3D NULL;
> +    virtio_snd_pcm_info *pcm_info =3D NULL;

We can make this:

   g_autofree virtio_snd_pcm_info *pcm_info =3D NULL;

then...

> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg,
> +                    cmd->elem->out_num,
> +                    0,
> +                    &req,
> +                    sizeof(req));
> +    assert(sz =3D=3D sizeof(virtio_snd_query_info));
> +
> +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
> +        sizeof(virtio_snd_hdr) + req.size * req.count) {
> +        error_report("pcm info: buffer too small, got: %lu, needed: %lu",
> +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
> +                sizeof(virtio_snd_pcm_info));
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +        goto done;

we can simply return here.

> +    }
> +
> +    pcm_info =3D g_new0(virtio_snd_pcm_info, req.count);
> +    for (int i =3D req.start_id; i < req.start_id + req.count; i++) {
> +        trace_virtio_snd_handle_pcm_info(i);
> +        stream =3D virtio_snd_pcm_get_stream(s, i);
> +
> +        if (!stream) {
> +            error_report("Invalid stream id: %d", i);
> +            cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +            goto done;

and here.

> +        }
> +
> +        pcm_info[i - req.start_id].hdr.hda_fn_nid =3D stream->info.hdr.h=
da_fn_nid;
> +        pcm_info[i - req.start_id].features =3D stream->features;
> +        pcm_info[i - req.start_id].formats =3D stream->formats;
> +        pcm_info[i - req.start_id].rates =3D stream->rates;
> +        pcm_info[i - req.start_id].direction =3D stream->direction;
> +        pcm_info[i - req.start_id].channels_min =3D stream->channels_min;
> +        pcm_info[i - req.start_id].channels_max =3D stream->channels_max;
> +
> +        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
> +    }
> +
> +    cmd->resp.code =3D VIRTIO_SND_S_OK;
> +
> +    done:
> +
> +    if (cmd->resp.code =3D=3D VIRTIO_SND_S_BAD_MSG) {
> +        if (pcm_info !=3D NULL) {
> +            g_free(pcm_info);
> +        }
> +        return;
> +    }
> +
> +    sz =3D iov_from_buf(cmd->elem->in_sg,
> +                      cmd->elem->in_num,
> +                      sizeof(virtio_snd_hdr),
> +                      pcm_info,
> +                      sizeof(virtio_snd_pcm_info) * req.count);
> +    assert(sz =3D=3D req.size * req.count);
> +
> +    if (pcm_info !=3D NULL) {
> +        g_free(pcm_info);
> +    }

And drop the done: and the resp.code check and g_free().

> +
> +    return;
> +}
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
> +    uint32_t stream_id =3D params->hdr.stream_id;
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
> +    VirtIOSoundPCMParams *st_params =3D virtio_snd_pcm_get_params(s, str=
eam_id);
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
> +    uint32_t supported_formats =3D 1 << VIRTIO_SND_PCM_FMT_S8
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U8
> +                                 | 1 << VIRTIO_SND_PCM_FMT_S16
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U16
> +                                 | 1 << VIRTIO_SND_PCM_FMT_S32
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U32
> +                                 | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
> +
> +    uint32_t supported_rates =3D 1 << VIRTIO_SND_PCM_RATE_5512
> +                               | 1 << VIRTIO_SND_PCM_RATE_8000
> +                               | 1 << VIRTIO_SND_PCM_RATE_11025
> +                               | 1 << VIRTIO_SND_PCM_RATE_16000
> +                               | 1 << VIRTIO_SND_PCM_RATE_22050
> +                               | 1 << VIRTIO_SND_PCM_RATE_32000
> +                               | 1 << VIRTIO_SND_PCM_RATE_44100
> +                               | 1 << VIRTIO_SND_PCM_RATE_48000
> +                               | 1 << VIRTIO_SND_PCM_RATE_64000
> +                               | 1 << VIRTIO_SND_PCM_RATE_88200
> +                               | 1 << VIRTIO_SND_PCM_RATE_96000
> +                               | 1 << VIRTIO_SND_PCM_RATE_176400
> +                               | 1 << VIRTIO_SND_PCM_RATE_192000
> +                               | 1 << VIRTIO_SND_PCM_RATE_384000;
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
> +    sz =3D iov_to_buf(cmd->elem->out_sg,
> +                    cmd->elem->out_num,
> +                    0,
> +                    &req,
> +                    sizeof(req));
> +    assert(sz =3D=3D sizeof(virtio_snd_pcm_set_params));
> +
> +    trace_virtio_snd_handle_pcm_set_params(req.hdr.stream_id);
> +    cmd->resp.code =3D virtio_snd_pcm_set_params_impl(s, &req);
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
> +    as->nchannels =3D params->channels;
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
> +    if (!s->pcm->streams
> +            || !s->pcm->pcm_params
> +            || !s->pcm->pcm_params[stream_id]) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    uint32_t supported_formats =3D 1 << VIRTIO_SND_PCM_FMT_S8
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U8
> +                                 | 1 << VIRTIO_SND_PCM_FMT_S16
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U16
> +                                 | 1 << VIRTIO_SND_PCM_FMT_S32
> +                                 | 1 << VIRTIO_SND_PCM_FMT_U32
> +                                 | 1 << VIRTIO_SND_PCM_FMT_FLOAT;
> +
> +    uint32_t supported_rates =3D 1 << VIRTIO_SND_PCM_RATE_5512
> +                               | 1 << VIRTIO_SND_PCM_RATE_8000
> +                               | 1 << VIRTIO_SND_PCM_RATE_11025
> +                               | 1 << VIRTIO_SND_PCM_RATE_16000
> +                               | 1 << VIRTIO_SND_PCM_RATE_22050
> +                               | 1 << VIRTIO_SND_PCM_RATE_32000
> +                               | 1 << VIRTIO_SND_PCM_RATE_44100
> +                               | 1 << VIRTIO_SND_PCM_RATE_48000
> +                               | 1 << VIRTIO_SND_PCM_RATE_64000
> +                               | 1 << VIRTIO_SND_PCM_RATE_88200
> +                               | 1 << VIRTIO_SND_PCM_RATE_96000
> +                               | 1 << VIRTIO_SND_PCM_RATE_176400
> +                               | 1 << VIRTIO_SND_PCM_RATE_192000
> +                               | 1 << VIRTIO_SND_PCM_RATE_384000;
> +
> +    VirtIOSoundPCMParams *params =3D virtio_snd_pcm_get_params(s, stream=
_id);
> +    assert(params);
> +
> +    VirtIOSoundPCMStream *stream =3D g_new0(VirtIOSoundPCMStream, 1);
> +
> +    stream->pcm =3D s->pcm;
> +    stream->direction =3D stream_id < s->snd_conf.streams / 2 +
> +        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_I=
NPUT;
> +    stream->info.hdr.hda_fn_nid =3D stream->direction =3D=3D VIRTIO_SND_=
D_OUTPUT ?
> +        VIRTIO_SOUND_HDA_FN_NID_OUT : VIRTIO_SOUND_HDA_FN_NID_IN;
> +    stream->features =3D 0;
> +    stream->channels_min =3D 1;
> +    stream->channels_max =3D AUDIO_MAX_CHANNELS;
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
> +    audsettings as;
> +    virtio_snd_get_qemu_audsettings(&as, params);
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
> +        /*
> +         * Unimplemented.
> +         * stream->voice.in =3D AUD_open_in(&s->card,
> +         *                                stream->voice.in,
> +         *                                "virtio_snd_card",
> +         *                                stream,
> +         *                                virtio_snd_input_cb,
> +         *                                &as);
> +         */

  qemu_log(LOG_UNIMP, ) - although why not implement it?

> +    }
> +
> +    stream->as =3D as;
> +    stream->desired_as =3D stream->as;
> +    qemu_mutex_init(&stream->queue_mutex);
> +    QSIMPLEQ_INIT(&stream->queue);
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
> +    virtio_snd_pcm_hdr req;
> +    size_t sz;
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg,
> +                    cmd->elem->out_num,
> +                    0,
> +                    &req,
> +                    sizeof(req));
> +    assert(sz =3D=3D sizeof(virtio_snd_pcm_hdr));
> +
> +    cmd->resp.code =3D VIRTIO_SND_S_OK;
> +    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_STA=
RT" :
> +            "VIRTIO_SND_R_PCM_STOP", req.stream_id);
> +
> +    VirtIOSoundPCMStream *stream =3D virtio_snd_pcm_get_stream(s, req.st=
ream_id);
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
> +    qemu_mutex_lock(&stream->queue_mutex);
> +    QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +        size +=3D block->size;
> +    }
> +    qemu_mutex_unlock(&stream->queue_mutex);

You could consider a QEMU_LOCK_GUARD here.

> +    return size;
> +}
> +
> +/*
> + * Releases the resources allocated to a stream. Seperated from the hand=
ler
> + * so that the code can be reused in the unrealize function.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @stream: VirtIOSoundPCMStream stream
> + * @stream_id: stream id
> + */
> +static uint32_t virtio_snd_pcm_release_impl(VirtIOSoundPCMStream *stream,
> +                                            uint32_t stream_id)
> +{
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
> +    if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        AUD_close_out(&stream->s->card, stream->voice.out);
> +    } else {
> +        AUD_close_in(&stream->s->card, stream->voice.in);
> +    }
> +
> +    assert(stream->s->pcm->streams[stream_id] =3D=3D stream);
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
> +
> +    sz =3D iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num,
> +            sizeof(virtio_snd_hdr), &stream_id, sizeof(stream_id));
> +    assert(sz =3D=3D sizeof(uint32_t));
> +
> +    trace_virtio_snd_handle_pcm_release(stream_id);
> +
> +    VirtIOSoundPCMStream *stream =3D virtio_snd_pcm_get_stream(s, stream=
_id);
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
> +        /*
> +         * Unimplemented
> +         * virtio_snd_handle_jack_info(s, cmd);
> +         */
> +        break;
> +    case VIRTIO_SND_R_JACK_REMAP:
> +        /*
> +         * Unimplemented
> +         * virtio_snd_handle_jack_remap(s, cmd);
> +         */
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
> +    if (sz !=3D sizeof(cmd->resp)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "%s: virtio-snd response size incorrect %zu vs %zu\n",
> +                __func__, sz, sizeof(cmd->resp));
> +    }

In a bunch of other places we plain assert. I think this is the right
thing here because the guest should never be able to make QEMU abort()
by feeding it bad data.

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
> +    qemu_mutex_lock(&s->cmdq_mutex);
> +    qatomic_set(&s->processing_cmdq, true);
> +    while (!QTAILQ_EMPTY(&s->cmdq)) {
> +        cmd =3D QTAILQ_FIRST(&s->cmdq);
> +
> +        /* process command */
> +        process_cmd(s, cmd);
> +
> +        QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +
> +        assert(cmd->finished);
> +        g_free(cmd);
> +    }
> +    qatomic_set(&s->processing_cmdq, false);
> +    qemu_mutex_unlock(&s->cmdq_mutex);

and here.

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
> +        stream =3D s->pcm->streams[hdr.stream_id];
> +        assert(stream);
> +
> +        qemu_mutex_lock(&stream->queue_mutex);
> +        virtio_snd_pcm_read_write(stream,
> +                                  vq,
> +                                  elem,
> +                                  hdr.stream_id =3D=3D VIRTIO_SND_D_INPU=
T);
> +
> +        virtio_snd_pcm_status resp =3D { 0 };
> +        resp.status =3D VIRTIO_SND_S_OK;
> +        sz =3D iov_from_buf(elem->in_sg,
> +                          elem->in_num,
> +                          0,
> +                          &resp,
> +                          sizeof(resp));
> +        assert(sz =3D=3D sizeof(virtio_snd_pcm_status));
> +        qemu_mutex_unlock(&stream->queue_mutex);
> +    }
> +
> +    /*
> +     * Notify vq about virtio_snd_pcm_status responses.
> +     * Buffer responses must be notified separately later.
> +     */
> +    virtio_notify(VIRTIO_DEVICE(s), vq);
> +}
> +
> +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
> +                             Error **errp)
> +{
> +    /*
> +     * virtio-v1.2-csd01, 5.14.3,
> +     * Feature Bits
> +     * None currently defined.
> +     */
> +    trace_virtio_snd_get_features(vdev, features);
> +    return features | 1UL << VIRTIO_F_VERSION_1 | 1UL << VIRTIO_F_IN_ORD=
ER;
> +}
> +
> +static void virtio_snd_set_pcm(VirtIOSound *snd)
> +{
> +    VirtIOSoundPCM *pcm;
> +
> +    pcm =3D g_new0(VirtIOSoundPCM, 1);
> +    pcm->snd =3D snd;
> +
> +    pcm->streams =3D g_new0(VirtIOSoundPCMStream *, snd->snd_conf.stream=
s);
> +    pcm->pcm_params =3D g_new0(VirtIOSoundPCMParams *, snd->snd_conf.str=
eams);
> +    pcm->jacks =3D g_new0(struct virtio_snd_jack *, snd->snd_conf.jacks);
> +
> +    snd->pcm =3D pcm;
> +
> +    return;
> +}
> +
> +void virtio_snd_common_realize(DeviceState *dev,
> +                               VirtIOHandleOutput ctrl,
> +                               VirtIOHandleOutput evt,
> +                               VirtIOHandleOutput txq,
> +                               VirtIOHandleOutput rxq,
> +                               Error **errp)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +    virtio_snd_pcm_set_params default_params;
> +    uint32_t status;
> +
> +    virtio_snd_set_pcm(vsnd);
> +
> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> +
> +    /* set number of jacks and streams */
> +    if (vsnd->snd_conf.jacks > 8) {
> +        error_setg(errp,
> +                   "Invalid number of jacks: %d",
> +                   vsnd->snd_conf.jacks);
> +        return;
> +    }
> +    if (vsnd->snd_conf.streams < 1 || vsnd->snd_conf.streams > 10) {
> +        error_setg(errp,
> +                   "Invalid number of streams: %d",
> +                    vsnd->snd_conf.streams);
> +        return;
> +    }
> +
> +    if (vsnd->snd_conf.chmaps > VIRTIO_SND_CHMAP_MAX_SIZE) {
> +        error_setg(errp,
> +                   "Invalid number of channel maps: %d",
> +                   vsnd->snd_conf.chmaps);
> +        return;
> +    }
> +
> +    AUD_register_card("virtio-sound", &vsnd->card);
> +
> +    /* set default params for all streams */
> +    default_params.features =3D 0;
> +    default_params.buffer_bytes =3D 8192;
> +    default_params.period_bytes =3D 4096;
> +    default_params.channels =3D 2;
> +    default_params.format =3D VIRTIO_SND_PCM_FMT_S16;
> +    default_params.rate =3D VIRTIO_SND_PCM_RATE_44100;
> +
> +    vsnd->queues[VIRTIO_SND_VQ_CONTROL] =3D virtio_add_queue(vdev, 64, c=
trl);
> +    vsnd->queues[VIRTIO_SND_VQ_EVENT] =3D virtio_add_queue(vdev, 64, evt=
);
> +    vsnd->queues[VIRTIO_SND_VQ_TX] =3D virtio_add_queue(vdev, 64, txq);
> +    vsnd->queues[VIRTIO_SND_VQ_RX] =3D virtio_add_queue(vdev, 64, rxq);
> +    qemu_mutex_init(&vsnd->cmdq_mutex);
> +    QTAILQ_INIT(&vsnd->cmdq);
> +
> +    for (int i =3D 0; i < vsnd->snd_conf.streams; i++) {
> +        default_params.hdr.stream_id =3D i;
> +        status =3D virtio_snd_pcm_set_params_impl(vsnd, &default_params);
> +        if (status !=3D VIRTIO_SND_S_OK) {
> +            error_setg(errp,
> +                       "Can't initalize stream params, device responded =
with %s.",
> +                       print_code(status));
> +            return;
> +        }
> +        status =3D virtio_snd_pcm_prepare_impl(vsnd, i);
> +        if (status !=3D VIRTIO_SND_S_OK) {
> +            error_setg(errp,
> +                       "Can't prepare streams, device responded with %s.=
",
> +                       print_code(status));
> +            return;
> +        }
> +    }
> +}
> +
> +static void
> +virtio_snd_vm_state_change(void *opaque, bool running, RunState state)
> +{
> +    if (running) {
> +        trace_virtio_snd_vm_state_running();
> +    } else {
> +        trace_virtio_snd_vm_state_stopped();
> +    }
> +}
> +
> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
> +{
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +    Error *err =3D NULL;
> +
> +    vsnd->pcm =3D NULL;
> +    vsnd->vmstate =3D
> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsn=
d);
> +
> +    trace_virtio_snd_realize(vsnd);
> +
> +    virtio_snd_common_realize(dev,
> +                              virtio_snd_handle_ctrl,
> +                              virtio_snd_handle_event,
> +                              virtio_snd_handle_xfer,
> +                              virtio_snd_handle_xfer,
> +                              &err);
> +    if (err !=3D NULL) {
> +        error_propagate(errp, err);
> +        return;
> +    }
> +}
> +
> +/*
> + * AUD_* output callback.
> + *
> + * @data: VirtIOSoundPCMStream stream
> + * @available: number of bytes that can be written with AUD_write()
> + */
> +static void virtio_snd_pcm_out_cb(void *data, int available)
> +{
> +    VirtIOSoundPCMStream *stream =3D data;
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +
> +    qemu_mutex_lock(&stream->queue_mutex);
> +    QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +        int size =3D MIN(block->size, available);
> +
> +        for (;;) {
> +            size =3D AUD_write(stream->voice.out,
> +                             block->data + block->offset,
> +                             size);
> +            block->size -=3D size;
> +            block->offset +=3D size;
> +            if (!block->size) {
> +                virtqueue_push(block->vq,
> +                               block->elem,
> +                               sizeof(block->elem));
> +                virtio_notify(VIRTIO_DEVICE(stream->s),
> +                              block->vq);
> +                QSIMPLEQ_REMOVE(&stream->queue,
> +                                block,
> +                                VirtIOSoundPCMBlock,
> +                                entry);
> +                available -=3D size;
> +                break;
> +            }
> +
> +            available -=3D size;
> +            if (!available) {
> +                break;
> +            }
> +        }
> +        if (!available) {
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&stream->queue_mutex);
> +}
> +
> +/*
> + * Flush all buffer data from this stream's queue into the driver's virt=
ual
> + * queue.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
> +{
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +
> +    qemu_mutex_lock(&stream->queue_mutex);
> +    QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +        AUD_write(stream->voice.out, block->data, block->size);
> +        virtqueue_push(block->vq, block->elem, sizeof(block->elem));
> +        virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
> +        QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entr=
y);
> +    }
> +    qemu_mutex_unlock(&stream->queue_mutex);
> +}
> +
> +/*
> + * Close the sound card.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
> +{
> +    virtio_snd_process_cmdq(stream->s);
> +    if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
> +        stream->voice.out =3D NULL;
> +    } else {
> +        AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
> +        stream->voice.in =3D NULL;
> +    }
> +
> +}
> +
> +static void virtio_snd_unrealize(DeviceState *dev)
> +{
> +    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(dev);
> +
> +    qemu_del_vm_change_state_handler(vsnd->vmstate);
> +    virtio_del_queue(vdev, 0);
> +
> +    trace_virtio_snd_unrealize(vsnd);
> +
> +    for (int i =3D VIRTIO_SND_D_OUTPUT; i <=3D VIRTIO_SND_D_INPUT; i++) {
> +        VirtIOSoundPCMStream *stream =3D vsnd->pcm->streams[i];
> +
> +        virtio_snd_pcm_close(stream);
> +
> +        g_free(stream);
> +    }
> +
> +    AUD_remove_card(&vsnd->card);
> +    g_free(vsnd->pcm);
> +    virtio_cleanup(vdev);
> +}
> +
> +
> +static uint32_t
> +virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
> +                          VirtQueue *vq,
> +                          VirtQueueElement *element,
> +                          bool read)
> +{
> +    VirtIOSoundPCMBlock *fragment;
> +    size_t size =3D iov_size(element->out_sg, element->out_num) -
> +        sizeof(virtio_snd_pcm_xfer);
> +    assert(size <=3D stream->period_bytes);
> +
> +    trace_virtio_snd_handle_xfer_elem(read ? "read" : "write");
> +
> +    fragment =3D g_malloc(sizeof(VirtIOSoundPCMBlock) + size);
> +    fragment->elem =3D element;
> +    fragment->vq =3D vq;
> +    fragment->size =3D size;
> +    fragment->offset =3D 0;
> +
> +    iov_to_buf(element->out_sg, element->out_num,
> +               sizeof(virtio_snd_pcm_xfer),
> +               fragment->data,
> +               size);
> +
> +    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
> +
> +    return fragment->size;
> +}
> +
> +static void virtio_snd_reset(VirtIODevice *vdev)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    virtio_snd_ctrl_command *cmd;
> +
> +    qemu_mutex_lock(&s->cmdq_mutex);
> +    while (!QTAILQ_EMPTY(&s->cmdq)) {
> +        cmd =3D QTAILQ_FIRST(&s->cmdq);
> +        QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +        g_free(cmd);
> +    }
> +    qemu_mutex_unlock(&s->cmdq_mutex);
> +}
> +
> +static void virtio_snd_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_CLASS(klass);
> +
> +
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +    device_class_set_props(dc, virtio_snd_properties);
> +
> +    dc->vmsd =3D &vmstate_virtio_snd;
> +    vdc->vmsd =3D &vmstate_virtio_snd_device;
> +    vdc->realize =3D virtio_snd_realize;
> +    vdc->unrealize =3D virtio_snd_unrealize;
> +    vdc->get_config =3D virtio_snd_get_config;
> +    vdc->set_config =3D virtio_snd_set_config;
> +    vdc->get_features =3D get_features;
> +    vdc->reset =3D virtio_snd_reset;
> +    vdc->legacy_features =3D 0;
> +}
> +
> +static const TypeInfo virtio_snd_info =3D {
> +    .name          =3D TYPE_VIRTIO_SND,
> +    .parent        =3D TYPE_VIRTIO_DEVICE,
> +    .instance_size =3D sizeof(VirtIOSound),
> +    .class_init    =3D virtio_snd_class_init,
> +};
> +
> +static void virtio_snd_register(void)
> +{
> +    type_register_static(&virtio_snd_info);
> +}
> +
> +type_init(virtio_snd_register);
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
> index bdec78bfc6..4990aad748 100644
> --- a/hw/virtio/meson.build
> +++ b/hw/virtio/meson.build
> @@ -58,6 +58,7 @@ virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true=
: files('virtio-serial-pc
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_PMEM', if_true: files('virtio-pme=
m-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-io=
mmu-pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VIRTIO_MEM', if_true: files('virtio-mem-=
pci.c'))
> +virtio_pci_ss.add(when: 'CONFIG_VIRTIO_SND', if_true: files('virtio-snd-=
pci.c'))
>  virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-de=
v-pci.c'))
>=20=20
>  specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pc=
i_ss)
> diff --git a/hw/virtio/virtio-snd-pci.c b/hw/virtio/virtio-snd-pci.c
> new file mode 100644
> index 0000000000..eb3334b691
> --- /dev/null
> +++ b/hw/virtio/virtio-snd-pci.c
> @@ -0,0 +1,104 @@
> +/*
> + * VIRTIO Sound Device PCI Bindings
> + *
> + * Copyright (c) 2023 Emmanouil Pitsidianakis <manos.pitsidianakis@linar=
o.org>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> + * (at your option) any later version.  See the COPYING file in the
> + * top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/audio/soundhw.h"
> +#include "hw/virtio/virtio-pci.h"
> +#include "hw/virtio/virtio-snd.h"
> +
> +typedef struct VirtIOSoundPCI VirtIOSoundPCI;
> +
> +/*
> + * virtio-snd-pci: This extends VirtioPCIProxy.
> + */
> +#define TYPE_VIRTIO_SND_PCI "virtio-sound-pci-base"
> +DECLARE_INSTANCE_CHECKER(VirtIOSoundPCI, VIRTIO_SOUND_PCI,
> +                         TYPE_VIRTIO_SND_PCI)
> +
> +struct VirtIOSoundPCI {
> +    VirtIOPCIProxy parent;
> +    VirtIOSound vdev;
> +};
> +
> +static Property virtio_snd_pci_properties[] =3D {
> +    DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static const char *audiodev_id;
> +
> +static int virtio_snd_init_pci(PCIBus *init_bus, const char *audiodev)
> +{
> +    audiodev_id =3D audiodev;
> +    return 0;
> +}
> +
> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error **err=
p)
> +{
> +    VirtIOSoundPCI *dev =3D VIRTIO_SOUND_PCI(vpci_dev);
> +    DeviceState *vdev =3D DEVICE(&dev->vdev);
> +    VirtIOSound *vsnd =3D VIRTIO_SND(&dev->vdev);
> +
> +    /*
> +     * According to spec, non-legacy virtio PCI devices are always little
> +     * endian
> +     */
> +    vsnd->virtio_access_is_big_endian =3D false;
> +
> +
> +    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus), errp);
> +
> +
> +    qdev_prop_set_string(vdev, "audiodev", audiodev_id);
> +    AUD_register_card ("virtio-sound", &dev->vdev.card);
> +
> +    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
> +}
> +
> +static void virtio_snd_pci_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    VirtioPCIClass *vpciklass =3D VIRTIO_PCI_CLASS(klass);
> +    PCIDeviceClass *pcidev_k =3D PCI_DEVICE_CLASS(klass);
> +
> +    vpciklass->realize =3D virtio_snd_pci_realize;
> +    set_bit(DEVICE_CATEGORY_SOUND, dc->categories);
> +
> +    pcidev_k->vendor_id =3D PCI_VENDOR_ID_REDHAT_QUMRANET;
> +    pcidev_k->device_id =3D PCI_DEVICE_ID_VIRTIO_SND;
> +    pcidev_k->revision =3D VIRTIO_PCI_ABI_VERSION;
> +    pcidev_k->class_id =3D PCI_CLASS_MULTIMEDIA_AUDIO;
> +    device_class_set_props(dc, virtio_snd_pci_properties);
> +}
> +
> +static void virtio_snd_pci_instance_init(Object *obj)
> +{
> +    VirtIOSoundPCI *dev =3D VIRTIO_SOUND_PCI(obj);
> +
> +    virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
> +                                TYPE_VIRTIO_SND);
> +}
> +
> +static const VirtioPCIDeviceTypeInfo virtio_snd_pci_info =3D {
> +    .base_name     =3D TYPE_VIRTIO_SND_PCI,
> +    .generic_name  =3D "virtio-sound-pci",
> +    .instance_size =3D sizeof(VirtIOSoundPCI),
> +    .instance_init =3D virtio_snd_pci_instance_init,
> +    .class_init    =3D virtio_snd_pci_class_init,
> +};
> +
> +static void virtio_snd_pci_register(void)
> +{
> +    virtio_pci_types_register(&virtio_snd_pci_info);
> +    pci_register_soundhw("virtio-sound", "Virtio Sound Device",
> +                         virtio_snd_init_pci);
> +}
> +
> +type_init(virtio_snd_pci_register);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index 935b4b91b4..7e736f53ed 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -85,6 +85,7 @@ extern bool pci_available;
>  #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
>  #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
>  #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
> +#define PCI_DEVICE_ID_VIRTIO_SND         0x1019
>=20=20
>  /*
>   * modern virtio-pci devices get their id assigned automatically,
> diff --git a/include/hw/virtio/virtio-snd.h b/include/hw/virtio/virtio-sn=
d.h
> new file mode 100644
> index 0000000000..88fd8896cc
> --- /dev/null
> +++ b/include/hw/virtio/virtio-snd.h
> @@ -0,0 +1,193 @@
> +/*
> + * VIRTIO Sound Device conforming to
> + *
> + * "Virtual I/O Device (VIRTIO) Version 1.2
> + * Committee Specification Draft 01
> + * 09 May 2022"
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
> +#ifndef QEMU_VIRTIO_SOUND_H
> +#define QEMU_VIRTIO_SOUND_H
> +
> +#include "hw/virtio/virtio.h"
> +#include "audio/audio.h"
> +#include "standard-headers/linux/virtio_ids.h"
> +#include "standard-headers/linux/virtio_snd.h"
> +
> +#define TYPE_VIRTIO_SND "virtio-sound-device"
> +#define VIRTIO_SND(obj) \
> +        OBJECT_CHECK(VirtIOSound, (obj), TYPE_VIRTIO_SND)
> +
> +typedef struct VirtIOSound {
> +    VirtIODevice parent_obj;
> +    struct VirtQueue *queues[VIRTIO_SND_VQ_MAX];
> +    struct VirtIOSoundPCM *pcm;
> +    bool virtio_access_is_big_endian;
> +    QEMUSoundCard card;
> +    VMChangeStateEntry *vmstate;
> +    char *audiodev;
> +    struct virtio_snd_config snd_conf;
> +    QemuMutex cmdq_mutex;
> +    QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
> +    bool processing_cmdq;
> +} VirtIOSound;
> +
> +typedef struct virtio_snd_ctrl_command {
> +    struct VirtQueueElement *elem;
> +    struct VirtQueue *vq;
> +    struct virtio_snd_hdr ctrl;
> +    struct virtio_snd_hdr resp;
> +    bool finished;
> +    QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
> +} virtio_snd_ctrl_command;
> +
> +#define VIRTIO_SND_FILL_CMD(out) do {                                   \
> +        size_t s;                                                       \
> +        s =3D iov_to_buf(cmd->elem->out_sg, cmd->elem->out_num, 0,      =
  \
> +                       &out, sizeof(out));                              \
> +        if (s !=3D sizeof(out)) {                                       =
  \
> +            qemu_log_mask(LOG_GUEST_ERROR,                              \
> +                          "%s: virtio-snd command size incorrect %zu vs \
> +                          %zu\n", __func__, s, sizeof(out));            \
> +            return;                                                     \
> +        }                                                               \
> +    } while (0)
> +
> +/* CONFIGURATION SPACE */
> +
> +typedef struct virtio_snd_config virtio_snd_config;
> +
> +/* COMMON DEFINITIONS */
> +
> +/* common header for request/response*/
> +typedef struct virtio_snd_hdr virtio_snd_hdr;
> +
> +/* event notification */
> +typedef struct virtio_snd_event virtio_snd_event;
> +
> +/* common control request to query an item information */
> +typedef struct virtio_snd_query_info virtio_snd_query_info;
> +
> +/* JACK CONTROL MESSAGES */
> +
> +typedef struct virtio_snd_jack_hdr virtio_snd_jack_hdr;
> +
> +/* jack information structure */
> +typedef struct virtio_snd_jack_info virtio_snd_jack_info;
> +
> +/* jack remapping control request */
> +typedef struct virtio_snd_jack_remap virtio_snd_jack_remap;
> +
> +/*
> + * PCM CONTROL MESSAGES
> + */
> +typedef struct virtio_snd_pcm_hdr virtio_snd_pcm_hdr;
> +
> +/* PCM stream info structure */
> +typedef struct virtio_snd_pcm_info virtio_snd_pcm_info;
> +
> +/* set PCM stream params */
> +typedef struct virtio_snd_pcm_set_params virtio_snd_pcm_set_params;
> +
> +/* I/O request header */
> +typedef struct virtio_snd_pcm_xfer virtio_snd_pcm_xfer;
> +
> +/* I/O request status */
> +typedef struct virtio_snd_pcm_status virtio_snd_pcm_status;
> +
> +/* Stream params */
> +typedef struct VirtIOSoundPCMParams {
> +    uint32_t features;
> +    uint32_t buffer_bytes;          /* size of hardware buffer in bytes =
*/
> +    uint32_t period_bytes;          /* size of hardware period in bytes =
*/
> +    uint8_t channels;
> +    uint8_t format;
> +    uint8_t rate;
> +} VirtIOSoundPCMParams;
> +
> +#define VIRTIO_SND_PCM_MIN_CHANNELS     2
> +
> +typedef struct VirtIOSoundPCMBlock VirtIOSoundPCMBlock;
> +typedef struct VirtIOSoundPCM VirtIOSoundPCM;
> +
> +struct VirtIOSoundPCMBlock {
> +    QSIMPLEQ_ENTRY(VirtIOSoundPCMBlock) entry;
> +    struct VirtQueueElement *elem;
> +    struct VirtQueue *vq;
> +    int size;
> +    int offset;
> +    uint8_t data[];
> +};
> +
> +typedef struct VirtIOSoundPCMStream {
> +    VirtIOSoundPCM *pcm;
> +    struct virtio_snd_pcm_info info;
> +    uint32_t buffer_bytes;
> +    uint32_t period_bytes;
> +    /* channel position values (VIRTIO_SND_CHMAP_XXX) */
> +    uint8_t positions[VIRTIO_SND_CHMAP_MAX_SIZE];
> +    VirtIOSound *s;
> +    uint32_t features; /* 1 << VIRTIO_SND_PCM_F_XXX */
> +    uint64_t formats; /* 1 << VIRTIO_SND_PCM_FMT_XXX */
> +    uint64_t rates; /* 1 << VIRTIO_SND_PCM_RATE_XXX */
> +    uint8_t direction;
> +    uint8_t channels_min;
> +    uint8_t channels_max;
> +    bool flushing;
> +    struct audsettings as;
> +    struct audsettings desired_as;
> +    union {
> +        SWVoiceIn *in;
> +        SWVoiceOut *out;
> +    } voice;
> +    QemuMutex queue_mutex;
> +    QSIMPLEQ_HEAD(, VirtIOSoundPCMBlock) queue;
> +} VirtIOSoundPCMStream;
> +
> +struct VirtIOSoundPCM {
> +    VirtIOSound *snd;
> +    struct VirtIOSoundPCMParams **pcm_params;
> +    VirtIOSoundPCMStream **streams;
> +    struct virtio_snd_jack **jacks;
> +};
> +
> +void virtio_snd_common_realize(DeviceState *dev,
> +                               VirtIOHandleOutput ctrl,
> +                               VirtIOHandleOutput evt,
> +                               VirtIOHandleOutput txq,
> +                               VirtIOHandleOutput rxq,
> +                               Error **errp);
> +
> +static inline const char *print_code(int code)
> +{
> +  switch (code) {
> +  case VIRTIO_SND_R_JACK_INFO:
> +    return "VIRTIO_SND_R_JACK_INFO";
> +  case VIRTIO_SND_R_JACK_REMAP:
> +    return "VIRTIO_SND_R_JACK_REMAP";
> +  case VIRTIO_SND_R_PCM_INFO:
> +    return "VIRTIO_SND_R_PCM_INFO";
> +  case VIRTIO_SND_R_PCM_SET_PARAMS:
> +    return "VIRTIO_SND_R_PCM_SET_PARAMS";
> +  case VIRTIO_SND_R_PCM_PREPARE:
> +    return "VIRTIO_SND_R_PCM_PREPARE";
> +  case VIRTIO_SND_R_PCM_RELEASE:
> +    return "VIRTIO_SND_R_PCM_RELEASE";
> +  case VIRTIO_SND_R_PCM_START:
> +    return "VIRTIO_SND_R_PCM_START";
> +  case VIRTIO_SND_R_PCM_STOP:
> +    return "VIRTIO_SND_R_PCM_STOP";
> +  case VIRTIO_SND_R_CHMAP_INFO:
> +    return "VIRTIO_SND_R_CHMAP_INFO";
> +  default:
> +    return "invalid code";
> +  }
> +};
> +#endif
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index b8d2c4dadd..49d68495a3 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -108,6 +108,7 @@ static const QDevAlias qdev_alias_table[] =3D {
>      { "virtio-serial-device", "virtio-serial", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-serial-ccw", "virtio-serial", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-serial-pci", "virtio-serial", QEMU_ARCH_VIRTIO_PCI},
> +    { "virtio-sound-pci", "virtio-sound", QEMU_ARCH_VIRTIO_PCI},
>      { "virtio-tablet-device", "virtio-tablet", QEMU_ARCH_VIRTIO_MMIO },
>      { "virtio-tablet-ccw", "virtio-tablet", QEMU_ARCH_VIRTIO_CCW },
>      { "virtio-tablet-pci", "virtio-tablet", QEMU_ARCH_VIRTIO_PCI },


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

