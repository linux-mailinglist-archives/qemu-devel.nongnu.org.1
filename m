Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB6D7E36F9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:56:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0HsA-0006On-SF; Tue, 07 Nov 2023 03:55:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0Hs8-0006OR-Fh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0Hs6-0004Ky-S8
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699347342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XNR3RvMHRLRRBiPCYiu8UXbhcTIoWTxIzasu3giM0w=;
 b=cHp9s/tPX2mMyqO7EvJOYqbib7B7Pz82TZdj1iNLeE0c3JHYe+vMKNVaOcT3h4Deyrn66G
 17pvzaDCSuhzqTwaNG92UH/zUj6vM+UFuIxRjvwcCnrOhIv1nIbN2aCrsS7ZmTC8VanheT
 CGj+JxGKby1TWG8L/JUh0/foqJ6MxiU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-nbDkyDuWMeiTdHciQ7gI0w-1; Tue, 07 Nov 2023 03:55:31 -0500
X-MC-Unique: nbDkyDuWMeiTdHciQ7gI0w-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079a3362afso5382940e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:55:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699347329; x=1699952129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XNR3RvMHRLRRBiPCYiu8UXbhcTIoWTxIzasu3giM0w=;
 b=JLLq1uhbJrmL+229Jm5A1Q8NuGiLHdkxmWG30g0VQRF28MDzZqjTYKRCMpVa9lMmJL
 08NtrkIUBLkP4Qw/ujWrmrhWWCbyjsBSccF0Ya6hJx0jmh1DRB7tYUhwmmbuIrtavGsr
 9WNm6v8ML+fX/HS6Hom4SBGIe4RHAh/KbXb7Gkvtq6PL8dh/kGyjWpTZNVowrW8exoho
 3sRribaKNlt/ncw4xyda5uT2NqID2fyMy7oqBAZxzJYUy7ORFWF9XUj0jhfINS1eGosQ
 lPisKn2DLi4SgMneNAYxFSNawxmIM5utRYnKVOLzSJ6AfM8MwLppEBmscJaf6bnbmLnT
 fZQQ==
X-Gm-Message-State: AOJu0YzuIgnCG0ZK0y5krWV+IuyaDT8DgPFn0/ShCpb3+CbxgTbR/qOe
 nOEWVw68iMX8F0dXXvbuIfFwgR3j2dujQNK+9h+MAiGP3zyNz4ZrT/7LkeMpM6AkiGdzNyoLj7v
 tUar5TqnJdyAHeceIsOHyYEyF6GAfTAY=
X-Received: by 2002:a05:6512:10c7:b0:509:1227:ca71 with SMTP id
 k7-20020a05651210c700b005091227ca71mr26510253lfg.17.1699347329393; 
 Tue, 07 Nov 2023 00:55:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIwbbNe6as0r1YSKt92zbZUrAv9eWKnP0wNF7Ro28X7R1IRSbi/KV9p353yuLO89SnL7xliCkIk4C4EH4hsjA=
X-Received: by 2002:a05:6512:10c7:b0:509:1227:ca71 with SMTP id
 k7-20020a05651210c700b005091227ca71mr26510238lfg.17.1699347329031; Tue, 07
 Nov 2023 00:55:29 -0800 (PST)
MIME-Version: 1.0
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-24-marcandre.lureau@redhat.com>
 <15834680-16c1-6ed2-38fa-403d9bd14242@eik.bme.hu>
In-Reply-To: <15834680-16c1-6ed2-38fa-403d9bd14242@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Nov 2023 12:55:17 +0400
Message-ID: <CAMxuvaxnUVdWnwpUWd8J76WrRC0pPwTm1NeU6frs0A-T8TOQEg@mail.gmail.com>
Subject: Re: [PATCH v8 23/24] hw/display/ati: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 stefanha@gmail.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 7, 2023 at 12:46=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 7 Nov 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Change the "x-pixman" property default value and use the fallback path
> > when PIXMAN support is disabled.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/display/ati.c       | 16 +++++++++++++++-
> > hw/display/ati_2d.c    | 11 +++++++----
> > hw/display/meson.build |  2 +-
> > 3 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/display/ati.c b/hw/display/ati.c
> > index 9a87a5504a..51a3b156ac 100644
> > --- a/hw/display/ati.c
> > +++ b/hw/display/ati.c
> > @@ -32,6 +32,13 @@
> >
> > #define ATI_DEBUG_HW_CURSOR 0
> >
> > +#ifdef CONFIG_PIXMAN
> > +#define DEFAULT_X_PIXMAN 3
> > +#else
> > +#define DEFAULT_X_PIXMAN 0
> > +#endif
> > +
> > +
>
> Excess new line.

ok

>
> > static const struct {
> >     const char *name;
> >     uint16_t dev_id;
> > @@ -946,6 +953,12 @@ static void ati_vga_realize(PCIDevice *dev, Error =
**errp)
> >     ATIVGAState *s =3D ATI_VGA(dev);
> >     VGACommonState *vga =3D &s->vga;
> >
> > +#ifndef CONFIG_PIXMAN
> > +    if (s->use_pixman !=3D 0) {
> > +        warn_report("x-pixman !=3D 0, not effective without PIXMAN");
> > +    }
> > +#endif
> > +
> >     if (s->model) {
> >         int i;
> >         for (i =3D 0; i < ARRAY_SIZE(ati_model_aliases); i++) {
> > @@ -1033,7 +1046,8 @@ static Property ati_vga_properties[] =3D {
> >     DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
> >                        PCI_DEVICE_ID_ATI_RAGE128_PF),
> >     DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, =
false),
> > -    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
> > +    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplic=
ity */
>
> Comment not needed but if you still want it, should be "this is a debug..=
."

indeed

>
> > +    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_P=
IXMAN),
> >     DEFINE_PROP_END_OF_LIST()
> > };
> >
> > diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> > index 0e6b8e4367..e58acd0802 100644
> > --- a/hw/display/ati_2d.c
> > +++ b/hw/display/ati_2d.c
> > @@ -92,7 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
> >     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> >     case ROP3_SRCCOPY:
> >     {
> > -        bool fallback =3D false;
> > +        bool fallback =3D true;
> >         unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> >                        s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_=
width);
> >         unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> > @@ -119,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
> >
> >         src_stride /=3D sizeof(uint32_t);
> >         dst_stride /=3D sizeof(uint32_t);
> > +#ifdef CONFIG_PIXMAN
> >         DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d,=
 %d)\n",
> >                 src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
> >                 src_x, src_y, dst_x, dst_y,
>
> Keep debug log even without pixman so move ifdef after it (also below) as
> this provides info on the operation even if done by fallback.

ok

>
> > @@ -147,9 +148,8 @@ void ati_2d_blt(ATIVGAState *s)
> >                                        s->regs.dst_width, s->regs.dst_h=
eight);
> >             }
> >             g_free(tmp);
> > -        } else {
> > -            fallback =3D true;
> >         }
>
> If you cahnge default value to true this is not needed any more but for
> consistency with sm501 you could keep default and put this outside of
> #idfef instead so it's the same as sm501 or do the same there.

ok, and fixing the fallback=3Dtrue case in my sm501 patch while at it.

>
> > +#endif
> >         if (fallback) {
> >             unsigned int y, i, j, bypp =3D bpp / 8;
> >             unsigned int src_pitch =3D src_stride * sizeof(uint32_t);
> > @@ -203,12 +203,15 @@ void ati_2d_blt(ATIVGAState *s)
> >         }
> >
> >         dst_stride /=3D sizeof(uint32_t);
> > +#ifdef CONFIG_PIXMAN
> >         DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> >                 dst_bits, dst_stride, bpp, dst_x, dst_y,
> >                 s->regs.dst_width, s->regs.dst_height, filler);
>
> Move ifdef here.
>
> With these
>
> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Thanks for doing this in last minute.

thanks for the quick review!

>
> Regards,
> BALATON Zoltan
>
> >         if (!(s->use_pixman & BIT(0)) ||
> >             !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, =
dst_y,
> > -                    s->regs.dst_width, s->regs.dst_height, filler)) {
> > +                    s->regs.dst_width, s->regs.dst_height, filler))
> > +#endif
> > +        {
> >             /* fallback when pixman failed or we don't want to call it =
*/
> >             unsigned int x, y, i, bypp =3D bpp / 8;
> >             unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t);
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index 9c06aaee20..344dfe3d8c 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_tru=
e: files('xlnx_dp.c'))
> >
> > system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
> >
> > -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c'=
, 'ati_2d.c', 'ati_dbg.c'))
> > +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d=
.c', 'ati_dbg.c'), pixman])
> >
> >
> > if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >


