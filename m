Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C47825275
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:56:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhqg-0002tB-6b; Fri, 05 Jan 2024 05:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLhqe-0002sw-1h
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLhqc-0002T7-48
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704452080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEKAh8RK7Caekh3724OYJB8Cezmk11dnGaHSBrvI2Kg=;
 b=AOqj52EdP+gMUt+qcRncYkdynqAVyr6Wpxae1qQUKUgtFf1GqYkpM7A2ZifKzxfSd6EEBr
 CY7Sr0n2euyraaBp3ykRT2NfSQ0pwBnTmI27fLm2bKDG4IDRSnyAiWFWfsD3cSjzzOsjC0
 f7KIssJHeSeVDFYvgtnxLw0fNk2W27o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-ciae3-dtOSmt-pf3082PKg-1; Fri, 05 Jan 2024 05:54:39 -0500
X-MC-Unique: ciae3-dtOSmt-pf3082PKg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a28b20b48a8so64251466b.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704452078; x=1705056878;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VEKAh8RK7Caekh3724OYJB8Cezmk11dnGaHSBrvI2Kg=;
 b=fwbY8NFzVKKFBR+lJ4s+57jK4fsiiqbfbCqyRvPdAIpXUbTYkTyI29SPbLVmRzc5cE
 yj9TDMgFMzMuYuMXILmcrzXnyqD2jyMZ7kADpI7UlHe6jlRHtISOig5CqBilkYub0V30
 p1fCVlIUzza8bys+KMnpxNH/LtXndOq4zKxHfuN948jc9yJBs+tO22E65XET9uENLQdY
 AjW8k68RGCzf5PMsiV73wG/hWwwv3zmrKyTlF6XjB0lapFLAd5H/AIZsYGeJ8cDiFnqA
 tJTOUTyLiZFnDdNEGwJO3Uz45PDPGgrnoHUavGS1QUbur2/K9DEQGeK98udhnyacAEJ4
 8hCw==
X-Gm-Message-State: AOJu0Yz/B10EPyouqtpPV3C4ly9uDEI+Fu9LL3ymwN2JMMFg3il7wFQt
 2bmWHRX0SPVDN0yhikFc4YADI99gl2R2X3uBXBeXfYuARf1NGaGiehj/zV9enPRAC1OAy92JY9U
 iybt2g26z4PloLahYgbChRFt/PNn53aVhicZFGT4=
X-Received: by 2002:a50:9984:0:b0:553:33b6:36d8 with SMTP id
 m4-20020a509984000000b0055333b636d8mr970069edb.76.1704452077919; 
 Fri, 05 Jan 2024 02:54:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGJ8QX9O/cPoFg89cf9nGpHOZY+Vre70eNHVRe4OR/iEd3HiZyWRsj4Nz7n2kSKT3WkGxtW8n4/33fg/2coBA=
X-Received: by 2002:a50:9984:0:b0:553:33b6:36d8 with SMTP id
 m4-20020a509984000000b0055333b636d8mr970060edb.76.1704452077518; Fri, 05 Jan
 2024 02:54:37 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-2-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-2-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jan 2024 14:54:26 +0400
Message-ID: <CAMxuvazUD51rzJAL0h6u70dm4EP33CMYoz=akydJ0k8cEmaOpQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw/audio/virtio-sound: allocate all streams in
 advance
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Fri, Jan 5, 2024 at 12:34=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> It is much easier to migrate an array of structs than individual
> structs that are accessed via a pointer to a pointer to an array
> of pointers to struct, where some pointers can also be NULL.
>
> For this reason, the audio streams are already allocated during
> the realization phase and all stream variables that are constant
> at runtime are initialised immediately after allocation. This is
> a step towards being able to migrate the audio streams of the
> virtio sound device after the next few patches.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c         | 35 ++++++++++++++++++++++-------------
>  include/hw/audio/virtio-snd.h |  1 +
>  2 files changed, 23 insertions(+), 13 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 8344f61c64..36b1bb502c 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -447,11 +447,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *=
s, uint32_t stream_id)
>
>      stream =3D virtio_snd_pcm_get_stream(s, stream_id);
>      if (stream =3D=3D NULL) {
> -        stream =3D g_new0(VirtIOSoundPCMStream, 1);
> +        stream =3D &s->streams[stream_id];
>          stream->active =3D false;
> -        stream->id =3D stream_id;
>          stream->pcm =3D s->pcm;
> -        stream->s =3D s;
>          QSIMPLEQ_INIT(&stream->queue);
>          QSIMPLEQ_INIT(&stream->invalid);

note: I can't find where s->pcm->streams[stream_id] is reset to NULL
on pcm_release...

>
> @@ -463,14 +461,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *=
s, uint32_t stream_id)
>      }
>
>      virtio_snd_get_qemu_audsettings(&as, params);
> -    stream->info.direction =3D stream_id < s->snd_conf.streams / 2 +
> -        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_I=
NPUT;
> -    stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> -    stream->info.features =3D 0;
> -    stream->info.channels_min =3D 1;
> -    stream->info.channels_max =3D as.nchannels;
> -    stream->info.formats =3D supported_formats;
> -    stream->info.rates =3D supported_rates;
>      stream->params =3D *params;
>
>      stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> @@ -1074,6 +1064,24 @@ static void virtio_snd_realize(DeviceState *dev, E=
rror **errp)
>      vsnd->vmstate =3D
>          qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsn=
d);
>
> +    vsnd->streams =3D g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.stream=
s);
> +
> +    for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> +        VirtIOSoundPCMStream *stream =3D &vsnd->streams[i];
> +
> +        stream->id =3D i;
> +        stream->s =3D vsnd;
> +        stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> +        stream->info.features =3D 0;
> +        stream->info.formats =3D supported_formats;
> +        stream->info.rates =3D supported_rates;
> +        stream->info.direction =3D
> +            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1=
)
> +            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
> +        stream->info.channels_min =3D 1;
> +        stream->info.channels_max =3D 2;

Fixed max channels set to 2.. ? before this was set to
MIN(AUDIO_MAX_CHANNELS, params->channels)

> +    }
> +
>      vsnd->pcm =3D g_new0(VirtIOSoundPCM, 1);
>      vsnd->pcm->snd =3D vsnd;
>      vsnd->pcm->streams =3D
> @@ -1314,14 +1322,13 @@ static void virtio_snd_unrealize(DeviceState *dev=
)
>      qemu_del_vm_change_state_handler(vsnd->vmstate);
>      trace_virtio_snd_unrealize(vsnd);
>
> -    if (vsnd->pcm) {
> +    if (vsnd->streams) {
>          if (vsnd->pcm->streams) {
>              for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
>                  stream =3D vsnd->pcm->streams[i];
>                  if (stream) {
>                      virtio_snd_process_cmdq(stream->s);
>                      virtio_snd_pcm_close(stream);
> -                    g_free(stream);
>                  }
>              }
>              g_free(vsnd->pcm->streams);
> @@ -1329,6 +1336,8 @@ static void virtio_snd_unrealize(DeviceState *dev)
>          g_free(vsnd->pcm->pcm_params);
>          g_free(vsnd->pcm);
>          vsnd->pcm =3D NULL;
> +        g_free(vsnd->streams);
> +        vsnd->streams =3D NULL;
>      }
>      AUD_remove_card(&vsnd->card);
>      virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index ea6315f59b..05b4490488 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -216,6 +216,7 @@ struct VirtIOSound {
>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>      uint64_t features;
>      VirtIOSoundPCM *pcm;
> +    VirtIOSoundPCMStream *streams;
>      QEMUSoundCard card;
>      VMChangeStateEntry *vmstate;
>      virtio_snd_config snd_conf;
> --
> 2.35.3
>


