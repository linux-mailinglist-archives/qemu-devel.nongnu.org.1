Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80F97BF465
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7GZ-0006Do-Dg; Tue, 10 Oct 2023 03:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qq7GV-0006Ba-Pz; Tue, 10 Oct 2023 03:34:51 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qq7GP-0000aW-3m; Tue, 10 Oct 2023 03:34:51 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4196ae80fc3so32604411cf.0; 
 Tue, 10 Oct 2023 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696923283; x=1697528083; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCWEZtDIFQg4ZcCqFnNAOXG1/q1z+WOe4qE27mrXQUE=;
 b=D7CqFCvaASVTOu2QvP31BRerPhmPuLebMphdKI+9wRT/w2pKJY12qGmDgYQAvUj5TD
 2yplpR78oSwVFtjrLpqvaAddd/4IKIci+XaVuO/KcIxZfXGn0jGApiSaxz3nGYrjZS1/
 BnAtGdq1vPCoNf0XP0oa67t91vBE7gCeWZujFOxKcBWN7IwdsiwDDvLFDUm5skvz+yWB
 g1GWwKv5jbOgJE7PIYQhS+qTKf7i+zaoCquRiWZOkcKJvBRvKttJpbO2XaCwSaBhkutY
 i9U3VemYmFriQ2LkLvUJphOFH18xL2/adVPbF7UV56hcgYvzVL+KlxF2BRpVSF2aD4eT
 4WGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923283; x=1697528083;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RCWEZtDIFQg4ZcCqFnNAOXG1/q1z+WOe4qE27mrXQUE=;
 b=HD6YtgUa7bv2dgXtsoDc7OR1bS/U6fti0muGJSRH70fmK5vmz9ldVj6uhfBZWDrT3w
 q1vkYQBy1Fub7XPzpUXoeEb/tqu/ctfMmvF47pstFpN9Widb2pQtDxFPbA9xU1tXfzxV
 bQuHh+hKSEnyW6fu1XS/hzEperXvWueQtB9TZMZ7jdhQy253n81ZJDBPHrJQbaJDytqN
 /zFrH6E7TvcWdwwyUzVBRbJt0ndiWyd91VwYD6mJyYJfU5NTYR23dbFBYu0xssdWmJq2
 somOdVi+3qOrfsUcOoN48JtXsSpSiN9/GuFOFoKb68YuH9zp0nznJ1qbEScu6BArkOIz
 3ZcQ==
X-Gm-Message-State: AOJu0YweYQUFHKqp5Z46tA8tx5fDN/GVJPUquMaUroPCCNj/ikn+LXBO
 QKLAz/QounBu2Rz1dc734OPMYKrYtVcgZ2WrBy0=
X-Google-Smtp-Source: AGHT+IEMmrzChyTigzQNloyFQ+Fnn18G9mTZhqzUWjOHUHSKlmQNgvN7kjaF1MsZLtB+A7Lap0nDpTtRx7sxcVNJ5fU=
X-Received: by 2002:a05:622a:1183:b0:417:9e48:44d7 with SMTP id
 m3-20020a05622a118300b004179e4844d7mr20690598qtk.1.1696923283222; Tue, 10 Oct
 2023 00:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-17-marcandre.lureau@redhat.com>
 <433e2db8-e85e-d1ce-e54f-80edadd71643@eik.bme.hu>
In-Reply-To: <433e2db8-e85e-d1ce-e54f-80edadd71643@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Oct 2023 11:34:31 +0400
Message-ID: <CAJ+F1C+w3mQY2B3A=-6TQyyCT9kZT2EEprnLygK7t7rKLSwBvw@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] hw/sm501: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "open list:sam460ex" <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Zoltan

On Mon, Sep 18, 2023 at 9:59=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Mon, 18 Sep 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Drop the "x-pixman" property and use fallback path in such case.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > hw/display/sm501.c | 19 ++++++++++++++++---
> > 1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> > index 0eecd00701..a897c82f04 100644
> > --- a/hw/display/sm501.c
> > +++ b/hw/display/sm501.c
> > @@ -730,7 +730,6 @@ static void sm501_2d_operation(SM501State *s)
> >     switch (cmd) {
> >     case 0: /* BitBlt */
> >     {
> > -        static uint32_t tmp_buf[16384];
> >         unsigned int src_x =3D (s->twoD_source >> 16) & 0x01FFF;
> >         unsigned int src_y =3D s->twoD_source & 0xFFFF;
> >         uint32_t src_base =3D s->twoD_source_base & 0x03FFFFFF;
> > @@ -828,9 +827,11 @@ static void sm501_2d_operation(SM501State *s)
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
> > @@ -860,9 +861,12 @@ static void sm501_2d_operation(SM501State *s)
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
> > @@ -894,10 +898,13 @@ static void sm501_2d_operation(SM501State *s)
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
> > @@ -2038,7 +2045,9 @@ static void sm501_realize_sysbus(DeviceState *dev=
, Error **errp)
> >
> > static Property sm501_sysbus_properties[] =3D {
> >     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> > +#ifdef CONFIG_PIXMAN
> >     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman, 7=
),
> > +#endif
>
> Do we want to omit the property when compiled without pixman? I think we
> could leave it there and it would just be ignored without pixman but the
> same command line would still work and need less ifdefs in code.

That's a reasonable idea to me. At least, it can handle x-pixman=3D0
fine when !CONFIG_PIXMAN then.

Btw, looking at it, it seems it should be DEFINE_PROP_BIT instead. I
will add a TODO :)


>
> Otherwise:
>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Regards,
> BALATON Zoltan
>
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >
> > @@ -2126,7 +2135,9 @@ static void sm501_realize_pci(PCIDevice *dev, Err=
or **errp)
> >
> > static Property sm501_pci_properties[] =3D {
> >     DEFINE_PROP_UINT32("vram-size", SM501PCIState, vram_size, 64 * MiB)=
,
> > +#ifdef CONFIG_PIXMAN
> >     DEFINE_PROP_UINT8("x-pixman", SM501PCIState, state.use_pixman, 7),
> > +#endif
> >     DEFINE_PROP_END_OF_LIST(),
> > };
> >
> > @@ -2169,8 +2180,10 @@ static void sm501_pci_class_init(ObjectClass *kl=
ass, void *data)
> >
> > static void sm501_pci_init(Object *o)
> > {
> > +#ifdef CONFIG_PIXMAN
> >     object_property_set_description(o, "x-pixman", "Use pixman for: "
> >                                     "1: fill, 2: blit, 4: overlap blit"=
);
> > +#endif
> > }
> >
> > static const TypeInfo sm501_pci_info =3D {
> >



--
Marc-Andr=C3=A9 Lureau

