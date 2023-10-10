Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F557BF827
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:01:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9Xp-000540-9z; Tue, 10 Oct 2023 06:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qq9Xd-000528-4Q; Tue, 10 Oct 2023 06:00:41 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qq9Xa-0005zy-4Y; Tue, 10 Oct 2023 06:00:40 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7afc13d58c6so2346701241.1; 
 Tue, 10 Oct 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696932036; x=1697536836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmrLXs68+lVNqWk9VwvtYs/bkR8VDr5LEOlltfNmQbc=;
 b=Oc59FOhlnoCDDqs4QvPeWKJR4nVNgXvF3SUuVajyGkP0COfA/IAa8ROMyQ6g35OrIy
 WCce/y2Ocq8+eLw4j/J+sfwTT1p6/ex0fT+HT35pHcShrAI9shMWwC1gzE+1Lon5KTUN
 YZ0oqgE/aOv04jKZ3DChqEhodszcPBRF3AivqEEOA1brrlUAbWuNMM8j94nfAS6MFJzb
 qdN8bir61i15lmIOk4F0rAn8KNgciNiJ1koAvAr2IG1I2FOBgQbdZRoKh8nR2AxfWy3Z
 fqHze6GNjM9MTfifDcvoH1KG3qO2zuD9QNp7mbGNUrnJg2zT8jVCoHtYGk9W1Qd9TBWn
 ZQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696932036; x=1697536836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmrLXs68+lVNqWk9VwvtYs/bkR8VDr5LEOlltfNmQbc=;
 b=VVD7gjVq3D6Gbg5JYo/4jY8iEFERLDsF/mzWKnpGpeTsArNJUOZPUgen5QB7OcwkEE
 NDcwhlY67M/XHDxU0hzSTRyh4zM7g7UUqUnkvvbzLc4/+MuuNqkXcVUC/yaUplsR6eXX
 UhgaI+R5+hb+jKnvVHDPbhCuKJGtZwBA+ECEElXqZCVgrqYfItKqxPmmhNcsBuvd2hNw
 Hp4nhzyCm0gGZMB/SYZqFcbL9KZVDd8S+eB/8r57PxdxzrvmJpfksyBOiedFxfCX514o
 5m/eYcdMJmLmjdwiskIET/0nCS8RFGKEtAUgMOaIaRPKxo9uK3VsHCTJEHCo+WQeRPsS
 NbCQ==
X-Gm-Message-State: AOJu0YwGkMbalsMXio/jXYZhrPND3oVO9C7mIcNPAoPsA3cpAYcp028X
 IcwrKL3hNaYwi6uNiwFjmCa24csJCu2/nl85nTk=
X-Google-Smtp-Source: AGHT+IFJLuuBsSRcbWHBuTAc+I4ZDjpaIVRpmIp2rjh0CILvY0EqKRHXPOIKolbuhg04mc4WT4ncS21IqspWGjnfTw8=
X-Received: by 2002:a1f:4cc7:0:b0:493:7c76:bbac with SMTP id
 z190-20020a1f4cc7000000b004937c76bbacmr12287523vka.2.1696932036279; Tue, 10
 Oct 2023 03:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230918135206.2739222-1-marcandre.lureau@redhat.com>
 <20230918135206.2739222-17-marcandre.lureau@redhat.com>
 <433e2db8-e85e-d1ce-e54f-80edadd71643@eik.bme.hu>
 <CAJ+F1C+w3mQY2B3A=-6TQyyCT9kZT2EEprnLygK7t7rKLSwBvw@mail.gmail.com>
 <4ea37bd5-7278-b0e7-6cd4-652ac3eb0ae7@eik.bme.hu>
In-Reply-To: <4ea37bd5-7278-b0e7-6cd4-652ac3eb0ae7@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 10 Oct 2023 14:00:24 +0400
Message-ID: <CAJ+F1CLSkdRcpkA3Mud+q3-J21SWXExKMoEARFhiWzaQAVtR9w@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] hw/sm501: allow compiling without PIXMAN
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "open list:sam460ex" <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x930.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 10, 2023 at 1:53=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Tue, 10 Oct 2023, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Zoltan
> >
> > On Mon, Sep 18, 2023 at 9:59=E2=80=AFPM BALATON Zoltan <balaton@eik.bme=
.hu> wrote:
> >>
> >> On Mon, 18 Sep 2023, marcandre.lureau@redhat.com wrote:
> >>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>>
> >>> Drop the "x-pixman" property and use fallback path in such case.
> >>>
> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>> ---
> >>> hw/display/sm501.c | 19 ++++++++++++++++---
> >>> 1 file changed, 16 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> >>> index 0eecd00701..a897c82f04 100644
> >>> --- a/hw/display/sm501.c
> >>> +++ b/hw/display/sm501.c
> >>> @@ -730,7 +730,6 @@ static void sm501_2d_operation(SM501State *s)
> >>>     switch (cmd) {
> >>>     case 0: /* BitBlt */
> >>>     {
> >>> -        static uint32_t tmp_buf[16384];
> >>>         unsigned int src_x =3D (s->twoD_source >> 16) & 0x01FFF;
> >>>         unsigned int src_y =3D s->twoD_source & 0xFFFF;
> >>>         uint32_t src_base =3D s->twoD_source_base & 0x03FFFFFF;
> >>> @@ -828,9 +827,11 @@ static void sm501_2d_operation(SM501State *s)
> >>>                 de =3D db + (width + (height - 1) * dst_pitch) * bypp=
;
> >>>                 overlap =3D (db < se && sb < de);
> >>>             }
> >>> +#ifdef CONFIG_PIXMAN
> >>>             if (overlap && (s->use_pixman & BIT(2))) {
> >>>                 /* pixman can't do reverse blit: copy via temporary *=
/
> >>>                 int tmp_stride =3D DIV_ROUND_UP(width * bypp, sizeof(=
uint32_t));
> >>> +                static uint32_t tmp_buf[16384];
> >>>                 uint32_t *tmp =3D tmp_buf;
> >>>
> >>>                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(t=
mp_buf)) {
> >>> @@ -860,9 +861,12 @@ static void sm501_2d_operation(SM501State *s)
> >>>                                        dst_pitch * bypp / sizeof(uint=
32_t),
> >>>                                        8 * bypp, 8 * bypp, src_x, src=
_y,
> >>>                                        dst_x, dst_y, width, height);
> >>> -            } else {
> >>> +            } else
> >>> +#else
> >>> +            {
> >>>                 fallback =3D true;
> >>>             }
> >>> +#endif
> >>>             if (fallback) {
> >>>                 uint8_t *sp =3D s->local_mem + src_base;
> >>>                 uint8_t *d =3D s->local_mem + dst_base;
> >>> @@ -894,10 +898,13 @@ static void sm501_2d_operation(SM501State *s)
> >>>             color =3D cpu_to_le16(color);
> >>>         }
> >>>
> >>> +#ifdef CONFIG_PIXMAN
> >>>         if (!(s->use_pixman & BIT(0)) || (width =3D=3D 1 && height =
=3D=3D 1) ||
> >>>             !pixman_fill((uint32_t *)&s->local_mem[dst_base],
> >>>                          dst_pitch * bypp / sizeof(uint32_t), 8 * byp=
p,
> >>> -                         dst_x, dst_y, width, height, color)) {
> >>> +                         dst_x, dst_y, width, height, color))
> >>> +#endif
> >>> +        {
> >>>             /* fallback when pixman failed or we don't want to call i=
t */
> >>>             uint8_t *d =3D s->local_mem + dst_base;
> >>>             unsigned int x, y, i;
> >>> @@ -2038,7 +2045,9 @@ static void sm501_realize_sysbus(DeviceState *d=
ev, Error **errp)
> >>>
> >>> static Property sm501_sysbus_properties[] =3D {
> >>>     DEFINE_PROP_UINT32("vram-size", SM501SysBusState, vram_size, 0),
> >>> +#ifdef CONFIG_PIXMAN
> >>>     DEFINE_PROP_UINT8("x-pixman", SM501SysBusState, state.use_pixman,=
 7),
> >>> +#endif
> >>
> >> Do we want to omit the property when compiled without pixman? I think =
we
> >> could leave it there and it would just be ignored without pixman but t=
he
> >> same command line would still work and need less ifdefs in code.
> >
> > That's a reasonable idea to me. At least, it can handle x-pixman=3D0
> > fine when !CONFIG_PIXMAN then.
> >
> > Btw, looking at it, it seems it should be DEFINE_PROP_BIT instead. I
> > will add a TODO :)
>
> Erm, a bit can be 1 or 0 but the default value of it is 7. It's not a
> single but but a bitmask the enable/disable pisman for different
> operations separately so I think it can't be _BIT.

Sure, but we could have more explicitly different BIT properties
("x-pixman-fill", "x-pixman-blit", "x-pixman-overlap-blit").

thanks

--=20
Marc-Andr=C3=A9 Lureau

