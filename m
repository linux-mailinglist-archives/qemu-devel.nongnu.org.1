Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FB2825306
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiYJ-0007E6-Mn; Fri, 05 Jan 2024 06:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiYB-0007Cp-K6
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:39:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiY9-0008WQ-AA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:39:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704454779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wYaxd+jfiII0VKZHvYMlhDjcpL3E0arQtcnIGMxgxEo=;
 b=dmJvgB2gs8WMClm8o862WbCzXKYai1+J1iohjCu27p65D1btkU3QcOQF3mqkS+aWl6OFI2
 clIsUvkXmzaYMctOkk2/9f7erur1+lgQpgWRR2iE+Il93t3Vn0tU5JpxEbM7IXEeTL8nxK
 5XHB2p67BcbTdW3jg3i1B3U/kz4ogXM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-3XG2pFEeNKGZIJH_sn1F7Q-1; Fri, 05 Jan 2024 06:39:38 -0500
X-MC-Unique: 3XG2pFEeNKGZIJH_sn1F7Q-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-55369c474e1so707928a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454777; x=1705059577;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wYaxd+jfiII0VKZHvYMlhDjcpL3E0arQtcnIGMxgxEo=;
 b=hXaypo/UOaH9ED5+UDjQ9n588EHkqjcKEYp5QSsneVXC6kZpi0ZnxiJC5ZK6qwMCPd
 AsPpXmLWXomBHUNN8jK1D00uM2XlU9MV4FT0TiXYpQ9a8OK4VYA+nr8MLvpYTImmPbh1
 BSQY5E57qtxAgt9Z6pgtofs9qnDQzN3dlO9Gp8zyCTUl32D/Q+JagWdD6RRUZECWuEs6
 0YTItuKFTsDQrXAQg4jlMpQOEnMG09uzDesLWFK1qZkW+sF+kSCN6CCBPOWHtc99YdN/
 qHPi/WLKsAfZ9od+BJk/erk+w4Z6ZN/l6REPYas2ZNQYTQHJ9MCf9cfvPfs+lsQkAjIp
 Bvxw==
X-Gm-Message-State: AOJu0Yw80dke29i70dVkG/l0c5Mkz7tZN3tlq8O2GmHqNqgV89d6uv4g
 FqnAPu71QdLvUFTBkDmGiDeJGsI9ir4u4x6YmJ5dUUq+wC/MxLUWG/wPQ0DXpvsFHjp+Fe4JaW+
 zx3mdEjgC+mG35UAy9OIEBPaUu6mPwYzznul3fVg=
X-Received: by 2002:a50:a6d2:0:b0:556:e9c5:577b with SMTP id
 f18-20020a50a6d2000000b00556e9c5577bmr524166edc.135.1704454777402; 
 Fri, 05 Jan 2024 03:39:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjBtU2vXkByuLCwkQEpv2RHB2DRSacQlFxbmHa2LrGCaJZgEfgOzMo4nvhs3FDiN6OuWZbUI5tIVrCXZF1sbY=
X-Received: by 2002:a50:a6d2:0:b0:556:e9c5:577b with SMTP id
 f18-20020a50a6d2000000b00556e9c5577bmr524159edc.135.1704454777098; Fri, 05
 Jan 2024 03:39:37 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-6-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-6-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jan 2024 15:39:25 +0400
Message-ID: <CAMxuvazqiuQe3OyzGjJ=7aiKJHUg-L6T4S4orgTu8Ym=ha=6OQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
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

On Fri, Jan 5, 2024 at 12:34=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Split out the function virtio_snd_pcm_open() from
> virtio_snd_pcm_prepare(). A later patch also needs
> the new function. There is no functional change.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/virtio-snd.c | 57 +++++++++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 9f3269d72b..a1d2b3367e 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -443,6 +443,36 @@ static void virtio_snd_get_qemu_audsettings(audsetti=
ngs *as,
>      as->endianness =3D target_words_bigendian() ? 1 : 0;
>  }
>
> +/*
> + * Open a stream.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
> +{
> +    virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
> +    stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> +    stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> +
> +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        stream->voice.out =3D AUD_open_out(&stream->s->card,
> +                                         stream->voice.out,
> +                                         "virtio-sound.out",
> +                                         stream,
> +                                         virtio_snd_pcm_out_cb,
> +                                         &stream->as);
> +        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
> +    } else {
> +        stream->voice.in =3D AUD_open_in(&stream->s->card,
> +                                       stream->voice.in,
> +                                       "virtio-sound.in",
> +                                       stream,
> +                                       virtio_snd_pcm_in_cb,
> +                                       &stream->as);
> +        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
> +    }
> +}
> +
>  /*
>   * Close a stream and free all its resources.
>   *
> @@ -468,8 +498,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream=
 *stream)
>   */
>  static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_i=
d)
>  {
> -    audsettings as;
> -    virtio_snd_pcm_set_params *params;
>      VirtIOSoundPCMStream *stream;
>
>      stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> @@ -491,30 +519,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *=
s, uint32_t stream_id)
>          QSIMPLEQ_INIT(&stream->invalid);
>      }
>
> -    params =3D virtio_snd_pcm_get_params(s, stream_id);
> -
> -    virtio_snd_get_qemu_audsettings(&as, params);
> -    stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> -    stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> -    stream->as =3D as;
> -
> -    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> -        stream->voice.out =3D AUD_open_out(&s->card,
> -                                         stream->voice.out,
> -                                         "virtio-sound.out",
> -                                         stream,
> -                                         virtio_snd_pcm_out_cb,
> -                                         &as);
> -        AUD_set_volume_out(stream->voice.out, 0, 255, 255);
> -    } else {
> -        stream->voice.in =3D AUD_open_in(&s->card,
> -                                        stream->voice.in,
> -                                        "virtio-sound.in",
> -                                        stream,
> -                                        virtio_snd_pcm_in_cb,
> -                                        &as);
> -        AUD_set_volume_in(stream->voice.in, 0, 255, 255);
> -    }
> +    virtio_snd_pcm_open(stream);
>
>      stream->state =3D VSND_PCMSTREAM_STATE_PREPARED;
>
> --
> 2.35.3
>


