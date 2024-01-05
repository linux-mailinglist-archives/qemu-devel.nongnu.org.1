Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A88F825307
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:41:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiZP-0007vt-Ag; Fri, 05 Jan 2024 06:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiZL-0007ve-Ib
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiZJ-0000Sh-2i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704454849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oP1VlZpkrUhgekxAV3udaImnWoev5bQkO1k7FzXrcs=;
 b=FqDKu1xnQ3bZg9OnrH2u0UrHr8nEtVD6uoGS2w0jxFnt9FYOP+4znio5rIHGxA4/87h7iM
 axCaIxnQYq842A2oSeh9cZviEW+alkR5g36OW+lThGkiyo0PcWPOkdLYTQCfe9STp+muii
 XapqXfkGfKNsUn1P1devZhTwTr8CD/4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-hXsVqL3VO9mWQCjHQ2X-8w-1; Fri, 05 Jan 2024 06:40:47 -0500
X-MC-Unique: hXsVqL3VO9mWQCjHQ2X-8w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5573edbf0fbso104833a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454846; x=1705059646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3oP1VlZpkrUhgekxAV3udaImnWoev5bQkO1k7FzXrcs=;
 b=hYnHG5qRxOx0PHygeYRjfPFzB/BY4v6HuknxSMm7+9v1LGp3OjhRxvsHi8CYjmtOYe
 HAx6Fia+Rpdd+Hxe8wuZKRyDWcJt0lMQEaG/rr0H5eq6pCem1jG/kvbofaToi7AIk7E4
 f4aFm5IoTEb0EuWfm9k7wrDqGgPUEOX77dUduete9w+HIzSSdbQzdd8riHL4h+3KzGpH
 5f6Bq2dEhieH3EG4KNZTDvD5fB/bpON3Oi/nrg2L4krX2wqvdYeqoJxw3cL7yLYhrY3d
 NzW4eeCqqh2j2SuD776AHEhn3sJKbBCBJidJaNW5091Hxb3C4y3CELgEHpIrKaKZWoO4
 J5Mw==
X-Gm-Message-State: AOJu0YzCbxWDMvMwR3wLz872Sl6Uu/zDoEOk4gj1Fjbvuz27FS3tl2HR
 oK2ySKIIBtwHggxnGH+24A9TfGOzE9J2Vo/7Uz0Mk0q9l47mrlNp2U45NZ8gxFAmIHzcnxG6eNf
 NCZ9BgYeo/ZofJOfhkLJZrhako2CpRP96SVKO/3E=
X-Received: by 2002:a50:d65b:0:b0:557:fe5:a682 with SMTP id
 c27-20020a50d65b000000b005570fe5a682mr1011145edj.80.1704454846491; 
 Fri, 05 Jan 2024 03:40:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgryfTh71ozEBLd/DSW9TfQ0MTL0HXvrboxLk4gWSjHn0Fg0kvjO0iUVdHNMJXae97HHwdYs+pk7AWDVT0hVs=
X-Received: by 2002:a50:d65b:0:b0:557:fe5:a682 with SMTP id
 c27-20020a50d65b000000b005570fe5a682mr1011137edj.80.1704454846200; Fri, 05
 Jan 2024 03:40:46 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-7-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-7-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jan 2024 15:40:34 +0400
Message-ID: <CAMxuvaxz-_=5wyR6C8xgYcRrF5CYUeKGCYAFs5MsnJ6obxD0nw@mail.gmail.com>
Subject: Re: [PATCH 07/10] hw/audio/virtio-sound: introduce
 virtio_snd_set_active()
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Split out the function virtio_snd_pcm_set_active() from
> virtio_snd_pcm_start_stop(). A later patch also needs this
> new funcion. There is no functional change.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/virtio-snd.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index a1d2b3367e..16e8c49655 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -473,6 +473,21 @@ static void virtio_snd_pcm_open(VirtIOSoundPCMStream=
 *stream)
>      }
>  }
>
> +/*
> + * Activate/deactivate a stream.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + * @active: whether to activate or deactivate the stream
> + */
> +static void virtio_snd_pcm_set_active(VirtIOSoundPCMStream *stream, bool=
 active)
> +{
> +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        AUD_set_active_out(stream->voice.out, active);
> +    } else {
> +        AUD_set_active_in(stream->voice.in, active);
> +    }
> +}
> +
>  /*
>   * Close a stream and free all its resources.
>   *
> @@ -613,11 +628,7 @@ static uint32_t virtio_snd_pcm_start_stop(VirtIOSoun=
d *s,
>          stream->state =3D VSND_PCMSTREAM_STATE_STOPPED;
>      }
>
> -    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> -        AUD_set_active_out(stream->voice.out, start);
> -    } else {
> -        AUD_set_active_in(stream->voice.in, start);
> -    }
> +    virtio_snd_pcm_set_active(stream, start);
>
>      return cpu_to_le32(VIRTIO_SND_S_OK);
>  }
> --
> 2.35.3
>


