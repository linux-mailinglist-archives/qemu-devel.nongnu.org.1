Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE367BFE30
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqD1A-00039B-4n; Tue, 10 Oct 2023 09:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qqD18-00038q-SG
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qqD17-0007da-7S
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696945400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T5IGK0H78SzZcvYhqao3albA8l9XbfggFQZDp1ib3Dc=;
 b=IhXROqDu6NEV6j8rhy+PkMTxOloH58+COlboz5x0QsHiygRE8Y2s9Chs3z+5JyfaZRHNn9
 RRC805ee94rNNOOi4t/bzRyG0ejv4BPbsTXQcq3SMfs3U8pRz5JYXhuyt17BpSuFAGuvmq
 6SJpSyrvRQaNFW6BEm9vC5uKbWNpoTs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-FMRQsGi-PnKa5VjD9gKxQg-1; Tue, 10 Oct 2023 09:43:14 -0400
X-MC-Unique: FMRQsGi-PnKa5VjD9gKxQg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9adad8f306fso428273966b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696945393; x=1697550193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T5IGK0H78SzZcvYhqao3albA8l9XbfggFQZDp1ib3Dc=;
 b=UXg7TaNaae+T/+zMQ/8BAWbIyS+FJtWojKsVFyh6Z2VbrWcWpzLrUQpfP7kCJl2Nz0
 fI1JxUL2dlD1rGfipZ2lVL6SCMnGiDIFMIB0x70GSAGtg4+wu8iwK0OLCpmiekPR1fkc
 yflvV3oCGLEHmn6zKoT0+ltNlSpM3/HBo1HDm7vniuYCivMQux1ZleYEeLCV90oMj7TV
 N3ckCpslDx+FuLRMf/rqRqYovuJ5E7WOyizUUoLPNYdhfsnKjOXfNr5ten+iiGLPRcn+
 dSTqNlz+k24nW+l/unisTR2ZbArAdfHVw2f7Mb3aHlN0XWNvzaYpJ/jw0Rqm/XtFACn9
 qBWw==
X-Gm-Message-State: AOJu0YwqApfn8DsXz7iekGbapJAQdETFjy+Wt6mbgS0WxOC8QBGNI4g7
 QP1GhooueUKcstThpBlfSPpXmPrbM1BD543V9S2QdSb4a3N5bnYj1W4Lzsf4YVpBEeEgxDcUGDN
 9rPDqFkVKbG+S+6AHAvjowWFoWD1ZWcg=
X-Received: by 2002:aa7:c382:0:b0:525:d95b:cd4c with SMTP id
 k2-20020aa7c382000000b00525d95bcd4cmr16737037edq.20.1696945393387; 
 Tue, 10 Oct 2023 06:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDXtOhpFanOZSZje15VuwZzYa6jnwBMiomzae9w/rwYtgeYvMksBgty2GTTCEthwFPlAGVfzWc/z1Y7orRMsE=
X-Received: by 2002:aa7:c382:0:b0:525:d95b:cd4c with SMTP id
 k2-20020aa7c382000000b00525d95bcd4cmr16737023edq.20.1696945393105; Tue, 10
 Oct 2023 06:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231010073830.606570-1-marcandre.lureau@redhat.com>
 <20231010073830.606570-17-marcandre.lureau@redhat.com>
 <6365e1f5-bffe-ef11-7e9e-55077e66c4d0@eik.bme.hu>
In-Reply-To: <6365e1f5-bffe-ef11-7e9e-55077e66c4d0@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2023 17:43:01 +0400
Message-ID: <CAMxuvawusdxuc-Ck5wCmj-XisbuosJVSdXnSuxtbOwrCvY1M9Q@mail.gmail.com>
Subject: Re: [PATCH v3 16/18] hw/sm501: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, qemu-arm@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Oct 10, 2023 at 3:59=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 10 Oct 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Drop the "x-pixman" property and use fallback path in such case.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/display/sm501.c | 46 +++++++++++++++++++++++++++++++++++++---------
> > 1 file changed, 37 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 0eecd00701..bc5faa19f0 100644
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
> > @@ -894,10 +904,13 @@ static void sm501_2d_operation(SM501State *s)
> >             color =3D cpu_to_le16(color);
> >         }
> >
> > +#ifdef CONFIG_PIXMAN
> >         if (!(s->use_pixman & BIT(0)) || (width =3D=3D 1 && height =3D=
=3D 1) ||
> >             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
> >                          dst_pitch * bypp / sizeof(uint32_t), 8 * bypp,
> > -                         dst_x, dst_y, width, height, color)) {
> > +                         dst_x, dst_y, width, height, color))
> > +#endif
> > +        {
> >             /* fallback when pixman failed or we don't want to call it =
*/
> >             uint8_t *d =3D s->local_mem + dst_base;
> >             unsigned int x, y, i;
> > @@ -1875,9 +1888,16 @@ static void sm501_reset(SM501State *s)
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
> > +        error_setg(errp, "x-pixman!=3D0, however PIXMAN is not availab=
le");
> > +        return false;
> > +    }
> > +#endif
>
> I think this should be just a warning saying that x-pixman !=3D 0 is not
> effective without pixman and not a hard error. The goal is to keep comman=
d
> lines working the same not to annoy users unnecesarily.

ok

>
> > +
> >     s->local_mem_size_index =3D get_local_mem_size_index(local_mem_byte=
s);
> >
> >     /* local memory */
> > @@ -1916,6 +1936,7 @@ static void sm501_init(SM501State *s, DeviceState=
 *dev,
> >
> >     /* create qemu graphic console */
> >     s->con =3D graphic_console_init(dev, 0, &sm501_ops, s);
> > +    return true;
> > }
> >
> > static const VMStateDescription vmstate_sm501_state =3D {
> > @@ -2014,7 +2035,9 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> >     MemoryRegion *mr;
> >
> > -    sm501_init(&s->state, dev, s->vram_size);
> > +    if (!sm501_init(&s->state, dev, s->vram_size, errp)) {
> > +        return;
> > +    }
> >     if (get_local_mem_size(&s->state) !=3D s->vram_size) {
> >         error_setg(errp, "Invalid VRAM size, nearest valid size is %" P=
RIu32,
> >                    get_local_mem_size(&s->state));
> > @@ -2038,7 +2061,8 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >
> > static Property sm501_sysbus_properties[] =3D {
> >     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> > -    DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, =
7),
> > +    /* TODO: consider PROP_BIT instead */
>
> I don't think a comment is needed here but don't mind it you think it
> helps to note this here too but I'd keep the single value instead of
> separate BIT properties.

yes, that will avoid someone else proposing the same change again.

thanks


