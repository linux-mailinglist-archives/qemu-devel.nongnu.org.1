Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D0E7D37DE
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:23:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quusx-0007ec-GT; Mon, 23 Oct 2023 09:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1quuso-0007eT-QY
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1quusn-0003Hd-3e
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698067331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxSbq0sc1ZAr/JRiYAFnmYeY89c5LKmxBzgT1ddDD7c=;
 b=fLfhNWVJN3k6ldfqXJZB+45Iffo2MkVo4csPFyuI3k0Cls6VpDSUnIIVxRO+iArnR3YRGE
 dl1FPmJO30DaYI6Kftrz0BEB5RQ3X6w12iXYO5/X5HGt3kD5Fg1oON8X9dqzX0eZ955QOL
 Dunwpdi1+JKjd4BmyMuB8VNS6wcDZgc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-dzGbas4bMNaEq8-W3D2xnQ-1; Mon, 23 Oct 2023 09:22:00 -0400
X-MC-Unique: dzGbas4bMNaEq8-W3D2xnQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e02a0ebfdso2089335a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 06:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698067319; x=1698672119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HxSbq0sc1ZAr/JRiYAFnmYeY89c5LKmxBzgT1ddDD7c=;
 b=TLvb/PLDiidtKdWcqCky6cEKXGJbC/3xaJHYgY/+3vd2PsD4vvnr3yoBs+fACOsB9n
 ezDu9XMr++wXKhtf3577RkF0hEmzFbKcJHARlal5Z62O0yYrXyc/vXhB8aMzWrqJeYzs
 loNvtEkLFBKmz5JVcleBYTchqmYdXA7gM3jVOGj6KT1y2cuf5p9HfwueU2d1hMH65p+d
 VSmpH2JQJQS4rkcqBcYrvnOcqIZmNiTgrYn1rwvpkHZArwt7X9QyIV/WjUKCZFs/rsCN
 vVRu9gRXihUbopbQM8C7zXXk6gmUH7ut74Nc/jCa/KU1Vo6jCnryrLHG7K2TlvfguHZK
 QQwg==
X-Gm-Message-State: AOJu0Yx831jIQHUOMl+dE7yTUMb/NXKoXRiWQFAf6k2f/vIR+XiL+nma
 ix58PZ4QssMrQRLYY6S3qz0zPgPj+L59B1i4cuSPKCSLwNk2DTztIHHlgymWMs7Z/7U7uAOmvMZ
 rmyDI3xcHYhTkm6//0FzItClqGJUsyiQ=
X-Received: by 2002:a05:6402:278d:b0:53f:be89:4e4b with SMTP id
 b13-20020a056402278d00b0053fbe894e4bmr7146064ede.4.1698067319184; 
 Mon, 23 Oct 2023 06:21:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxavO27BL4UHWpEd5Qe6Wy0+I2sfmN7f38i36THcWfyYkuAFeCBHX0q8ax1sGPa4CI5zhmm+Y12EakpNFdigk=
X-Received: by 2002:a05:6402:278d:b0:53f:be89:4e4b with SMTP id
 b13-20020a056402278d00b0053fbe894e4bmr7146039ede.4.1698067318893; Mon, 23 Oct
 2023 06:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-18-marcandre.lureau@redhat.com>
 <1bb1f023-0618-5dad-c269-07bb010f5a14@eik.bme.hu>
In-Reply-To: <1bb1f023-0618-5dad-c269-07bb010f5a14@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 23 Oct 2023 17:21:47 +0400
Message-ID: <CAMxuvayrAdnPdskWzc1_1kJu6J8oHsGuYrcR10_QwGavPzXSBA@mail.gmail.com>
Subject: Re: [PATCH v5 17/19] hw/sm501: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 23, 2023 at 5:15=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Mon, 23 Oct 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Drop the "x-pixman" property and use fallback path in such case.
>
> Patch diverged from commit message, the x-pixman property is not dropped
> just the default changed. Needs updated commit message to reflect that.
>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/display/sm501.c | 59 +++++++++++++++++++++++++++++++++-------------
> > 1 file changed, 42 insertions(+), 17 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 0eecd00701..282671d1b3 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -438,6 +438,12 @@
> > #define SM501_HWC_WIDTH                 64
> > #define SM501_HWC_HEIGHT                64
> >
> > +#ifdef CONFIG_PIXMAN
> > +#define DEFAULT_X_PIXMAN 7
> > +#else
> > +#define DEFAULT_X_PIXMAN 0
> > +#endif
> > +
> > /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
> > static const uint32_t sm501_mem_local_size[] =3D {
> >     [0] =3D 4 * MiB,
> > @@ -730,7 +736,6 @@ static void sm501_2d_operation(SM501State *s)
> >     switch (cmd) {
> >     case 0: /* BitBlt */
> >     {
> > -        static uint32_t tmp_buf[16384];
> >         unsigned int src_x =3D (s->twoD_source >> 16) & 0x01FFF;
> >         unsigned int src_y =3D s->twoD_source & 0xFFFF;
> >         uint32_t src_base =3D s->twoD_source_base & 0x03FFFFFF;
> > @@ -828,9 +833,11 @@ static void sm501_2d_operation(SM501State *s)
> >                 de =3D db + (width + (height - 1) * dst_pitch) * bypp;
> >                 overlap =3D (db < se && sb < de);
> >             }
> > +#ifdef CONFIG_PIXMAN
> >             if (overlap && (s->use_pixman & BIT(2))) {
> >                 /* pixman can't do reverse blit: copy via temporary */
> >                 int tmp_stride =3D DIV_ROUND_UP(width * bypp, sizeof(ui=
nt32_t));
> > +                static uint32_t tmp_buf[16384];
> >                 uint32_t *tmp =3D tmp_buf;
> >
> >                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp=
_buf)) {
> > @@ -860,9 +867,12 @@ static void sm501_2d_operation(SM501State *s)
> >                                        dst_pitch * bypp / sizeof(uint32=
_t),
> >                                        8 * bypp, 8 * bypp, src_x, src_y=
,
> >                                        dst_x, dst_y, width, height);
> > -            } else {
> > +            } else
> > +#else
> > +            {
> >                 fallback =3D true;
> >             }
> > +#endif
> >             if (fallback) {
> >                 uint8_t *sp =3D s->local_mem + src_base;
> >                 uint8_t *d =3D s->local_mem + dst_base;
> > @@ -894,20 +904,23 @@ static void sm501_2d_operation(SM501State *s)
> >             color =3D cpu_to_le16(color);
> >         }
> >
> > +#ifdef CONFIG_PIXMAN
> >         if (!(s->use_pixman & BIT(0)) || (width =3D=3D 1 && height =3D=
=3D 1) ||
> >             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
> >                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
> > -                         dst_x, dst_y, width, height, color)) {
> > -            /* fallback when pixman failed or we don't want to call it=
 */
> > -            uint8_t *d =3D s->local_mem + dst_base;
> > -            unsigned int x, y, i;
> > -            for (y =3D 0; y < height; y++) {
> > -                i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
> > -                for (x =3D 0; x < width; x++, i +=3D bypp) {
> > -                    stn_he_p(&d[i], bypp, color);
> > +                         dst_x, dst_y, width, height, color))
> > +#endif
> > +            {
> > +                /* fallback when pixman failed or we don't want to cal=
l it */
> > +                uint8_t *d =3D s->local_mem + dst_base;
> > +                unsigned int x, y, i;
> > +                for (y =3D 0; y < height; y++) {
> > +                    i =3D (dst_x + (dst_y + y) * dst_pitch) * bypp;
> > +                    for (x =3D 0; x < width; x++, i +=3D bypp) {
> > +                        stn_he_p(&d[i], bypp, color);
> > +                    }
> >                 }
> >             }
> > -        }
> >         break;
> >     }
> >     default:
> > @@ -1875,9 +1888,15 @@ static void sm501_reset(SM501State *s)
> >     s->twoD_wrap =3D 0;
> > }
> >
> > -static void sm501_init(SM501State *s, DeviceState *dev,
> > -                       uint32_t local_mem_bytes)
> > +static bool sm501_init(SM501State *s, DeviceState *dev,
> > +                       uint32_t local_mem_bytes, Error **errp)
> > {
> > +#ifndef CONFIG_PIXMAN
> > +    if (s->use_pixman !=3D 0) {
> > +        error_setg(&error_warn, "x-pixman !=3D 0, not effective withou=
t PIXMAN");
>
> I think this should just be warn_report not an error

It's a warning (error_warn), but I will change it to warn_report()

>
> > +    }
> > +#endif
> > +
> >     s->local_mem_size_index =3D get_local_mem_size_index(local_mem_byte=
s);
> >
> >     /* local memory */
> > @@ -1916,6 +1935,7 @@ static void sm501_init(SM501State *s, DeviceState=
 *dev,
> >
> >     /* create qemu graphic console */
> >     s->con =3D graphic_console_init(dev, 0, &sm501_ops, s);
> > +    return true;
>
> and no need to add errp as we never return false so it won't be printed
> anyway.
>

ok

> > }
> >
> > static const VMStateDescription vmstate_sm501_state =3D {
> > @@ -2014,7 +2034,9 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> >     MemoryRegion *mr;
> >
> > -    sm501_init(&s->state, dev, s->vram_size);
> > +    if (!sm501_init(&s->state, dev, s->vram_size, errp)) {
> > +        return;
> > +    }
>
> This could be left alone too, just issuing a warning above should be
> enough, no other cahnges are needed.
>
> Regards,
> BALATON Zoltan
>
> >     if (get_local_mem_size(&s->state) !=3D s->vram_size) {
> >         error_setg(errp, "Invalid VRAM size, nearest valid size is %" P=
RIu32,
> >                    get_local_mem_size(&s->state));
> > @@ -2038,7 +2060,8 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >
> > static Property sm501_sysbus_properties[] =3D {
> >     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> > -    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, =
7),
> > +    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplic=
ity */
> > +    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, =
DEFAULT_X_PIXMAN),
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >
> > @@ -2112,7 +2135,9 @@ static void sm501_realize_pci(PCIDevice *dev, Err=
or **errp)
> > {
> >     SM501PCIState *s =3D PCI_SM501(dev);
> >
> > -    sm501_init(&s->state, DEVICE(dev), s->vram_size);
> > +    if (!sm501_init(&s->state, DEVICE(dev), s->vram_size, errp)) {
> > +        return;
> > +    }
> >     if (get_local_mem_size(&s->state) !=3D s->vram_size) {
> >         error_setg(errp, "Invalid VRAM size, nearest valid size is %" P=
RIu32,
> >                    get_local_mem_size(&s->state));
> > @@ -2126,7 +2151,7 @@ static void sm501_realize_pci(PCIDevice *dev, Err=
or **errp)
> >
> > static Property sm501_pci_properties[] =3D {
> >     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB)=
,
> > -    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
> > +    DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, DEF=
AULT_X_PIXMAN),
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >
> >


