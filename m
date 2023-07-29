Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61859767EAF
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 13:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPhgy-0004wq-4I; Sat, 29 Jul 2023 07:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPhgo-0004wb-Kk
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 07:00:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qPhgm-00044T-5L
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 07:00:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690628446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HLGd0lS4NmnYUF77VnyQyIuneGXETpTKTy61IQPnYh4=;
 b=GDzRm6QDN7pb7bT4e4+A5wq4tqSCVel8PMQM8Env57AMKtO9BCfqOWQWAx0Wgr5Bf3vi3n
 4GcGqwgB24SekZE+v1DRQmzzYOiExIsusOvxRBXORm7IVKJYWxRHX2/tVSFxzuDXy8ORwC
 V/V9w5DOhnMJTZ8TGZHdB9hwZ8I/c7M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-D0vikGbLPCS37RJzTturUA-1; Sat, 29 Jul 2023 07:00:43 -0400
X-MC-Unique: D0vikGbLPCS37RJzTturUA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fdde274729so2995519e87.3
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 04:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690628442; x=1691233242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HLGd0lS4NmnYUF77VnyQyIuneGXETpTKTy61IQPnYh4=;
 b=L1XtjKfWXz4DKfhU07h/A3HOnRRMKNsASGbfFDkmsi1UEv31BS0qPUSxQqosV6TGTJ
 GfjfTv9uUUI/0KlO0iHUzMN8wX+5Egat++3s5rFOc16hKq+B4fsv+Dtj9cH3zc/0U8x5
 w06fAx9SH9AwHCV76IofrHT86+Id5VVWsYqbVAV25wVoxnTyM1BBxylh6iLqqHGHFBgj
 q0RMePZL43voNDZUEmgwh1I9z298ZosBt6HZz3cYvkgc2LE2VDp5lgkhlLtqvJtQ767D
 2qCO9Udx1EQsidsGHcX/hU9wafMRiA0RSyrdvCl4iGEghzRC/nguyFTdbp/twmnbqgUy
 gPbw==
X-Gm-Message-State: ABy/qLZhWBW7lmf/nxjLULPBR46yKeCB/Ynr3/dK6Q9hbzhGxeLLeV4v
 GuiUEO8OVOxtVVXM7mrMO8meLxzxO7BFhkUleTWUFkLZxJpeq476/u+dYdgw7mPGxpS1EfLwdju
 ls+Qi3fM3TXdhna5m5vKI+X7i5vwm2qg=
X-Received: by 2002:a05:6512:3b13:b0:4fe:c53:1824 with SMTP id
 f19-20020a0565123b1300b004fe0c531824mr4335429lfv.40.1690628442491; 
 Sat, 29 Jul 2023 04:00:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlENinzt3IqfGFQWVWxkMj85ct8ON43hGTk1YksOY1Wx229Ptm2+ELLCQ/PBuh/WPXq9UdTzyUUy7+nIdtTaO78=
X-Received: by 2002:a05:6512:3b13:b0:4fe:c53:1824 with SMTP id
 f19-20020a0565123b1300b004fe0c531824mr4335424lfv.40.1690628442191; Sat, 29
 Jul 2023 04:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690626150.git.manos.pitsidianakis@linaro.org>
 <19d95e841157a6a6d88e60e749025f487f010d22.1690626150.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <19d95e841157a6a6d88e60e749025f487f010d22.1690626150.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Jul 2023 15:00:30 +0400
Message-ID: <CAMxuvay5x2A1vu_0E4df+s3cSAkkFbH-FCFKbNCtKxE995aLGw@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] virtio-sound: prepare PCM streams
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 Alex Bennee <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Sat, Jul 29, 2023 at 2:39=E2=80=AFPM Emmanouil Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
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
> +    VirtIOSoundPCMParams *params;
> +    VirtIOSoundPCMStream *stream;
> +
> +    if (!s->pcm->streams ||
> +        !s->pcm->pcm_params ||
> +        !s->pcm->pcm_params[stream_id]) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    params =3D virtio_snd_pcm_get_params(s, stream_id);
> +    if (!params) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
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
> +    stream->as =3D as;
> +    stream->desired_as =3D stream->as;
> +    qemu_mutex_init(&stream->queue_mutex);
> +    QSIMPLEQ_INIT(&stream->queue);
> +
> +    s->pcm->streams[stream_id] =3D stream;

Same remark as v4:
Shouldn't it close & free the existing stream? Or return an error?


