Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B17E2032
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:41:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxqX-0004dr-BV; Mon, 06 Nov 2023 06:32:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzxqV-0004ck-27
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:32:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzxqP-0002Nz-W6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:32:42 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso7229226a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699270356; x=1699875156; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7IKZXWaKshQjlPCDGHmH81888aOR9Bu5FA8cabuQpk=;
 b=hip/1HuQmTe0jeO2EiARqCjV4BA535BVDTBZhy5IlhvNTObSIOCBlL5yt+WOIP8F6B
 E2mlqGanA/xrGA1cPvUMEctzfVmnuBc2uz7oR/zjDnBdnDHpmDBiUNghgc9cqNqGAcZz
 ze81nhu1vtTTSztyL7Q8eGgdtZGmAlajiOjg09APN5U5ZCUwjLHJXf5YI2GhOCkL3wl5
 CjMMXpSGr+ceBJLMDSbMH+9NNttlLFfU6B59/NywSFLksdXS8Ufu5V9KTTXyCC1ipO/1
 DqnXQu3HjIA+JGHcI6HDINx/Er56LZIDcfGjojIW7aZzr78sZOIrRWFBOMfXxiGw1qqo
 m0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699270356; x=1699875156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7IKZXWaKshQjlPCDGHmH81888aOR9Bu5FA8cabuQpk=;
 b=XDdCM7q2lkUjrfc67JXauPUqud7rqLCYwU7ZrcUFf3dmfOLoKwukMRimvXZFuuW4fB
 Xaw8NI/pjMCZQH1R8JtskU5Gvdbv49kZBCrihorynLQyvnYvUqNBFMvZgZxeHMhVXyXi
 Sj34k30kkqBD0WGnFbXOIZ+f2oPAP0l2junMmsF7K2+/MVfqL0MgxZMAiiKi8b/TrUwG
 S5hHcgbdJTUeUe3jcS1HlTpzo17g5x/fUUOrbUzeKCYCcR5eNMkDYL1rjzD/+mlAPjtA
 KWLTb+1R6qNdmi0B4uMLmwj+7B/pmYsE9XvL9NB5z/1kzYumxn2d94HUb+HJ8dMedclj
 wGsQ==
X-Gm-Message-State: AOJu0YxvWhXdQiL6eLXosrpacpoiCOxubzBjWeSc0CxRgWXO7fbq0JnW
 +aP2EVc9FD3dIYmn2iClw0mAnJUSkWlC2xZKf+o=
X-Google-Smtp-Source: AGHT+IFxP6K2/m2AoA5LVm4tec+sZTnhQSwgbF/pBVIEuRZAcnkA4yYws7ir+D3yFwacEjBd0Eu28AKsbr1MJSb8x8s=
X-Received: by 2002:a17:906:dc93:b0:9c7:3611:9e7c with SMTP id
 cs19-20020a170906dc9300b009c736119e7cmr13444889ejc.61.1699270356345; Mon, 06
 Nov 2023 03:32:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698871239.git.balaton@eik.bme.hu>
 <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
 <CAJ+F1CJx=dnLOO9QsjBVb9WHH1L1sBpfM8MqKPUZ+mAitCjWSA@mail.gmail.com>
 <4b0e7dc6-516e-a9da-2ac7-5bffb696d931@eik.bme.hu>
 <CAJ+F1CJWEHa1Rt=U7JY+YC9DKWM0MohBgYEZZAGXaXam3vKgZQ@mail.gmail.com>
 <31f20521-9685-3897-c087-f0521056af5f@eik.bme.hu>
In-Reply-To: <31f20521-9685-3897-c087-f0521056af5f@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 15:32:23 +0400
Message-ID: <CAJ+F1CJ4cW8NKg1cfm+LeVNdxpvLqxFNJZCBMe_7068c+yFyzw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ati-vga: Implement fallback for pixman routines
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Nov 6, 2023 at 3:17=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>
> On Mon, 6 Nov 2023, Marc-Andr=C3=A9 Lureau wrote:
> > On Mon, Nov 6, 2023 at 3:02=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.=
hu> wrote:
> >>
> >> On Mon, 6 Nov 2023, Marc-Andr=C3=A9 Lureau wrote:
> >>> On Thu, Nov 2, 2023 at 12:46=E2=80=AFAM BALATON Zoltan <balaton@eik.b=
me.hu> wrote:
> >>>>
> >>>> Pixman routines can fail if no implementation is available and it wi=
ll
> >>>> become optional soon so add fallbacks when pixman does not work.
> >>>>
> >>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >>>> ---
> >>>>  hw/display/ati.c     |  8 +++++
> >>>>  hw/display/ati_2d.c  | 75 +++++++++++++++++++++++++++++++----------=
---
> >>>>  hw/display/ati_int.h |  1 +
> >>>>  3 files changed, 62 insertions(+), 22 deletions(-)
> >>>>
> >>>> diff --git a/hw/display/ati.c b/hw/display/ati.c
> >>>> index 5e38d2c3de..f911fbc327 100644
> >>>> --- a/hw/display/ati.c
> >>>> +++ b/hw/display/ati.c
> >>>> @@ -1047,6 +1047,7 @@ static Property ati_vga_properties[] =3D {
> >>>>      DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
> >>>>                         PCI_DEVICE_ID_ATI_RAGE128_PF),
> >>>>      DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mo=
de, false),
> >>>> +    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
> >>>>      DEFINE_PROP_END_OF_LIST()
> >>>>  };
> >>>>
> >>>> @@ -1068,11 +1069,18 @@ static void ati_vga_class_init(ObjectClass *=
klass, void *data)
> >>>>      k->exit =3D ati_vga_exit;
> >>>>  }
> >>>>
> >>>> +static void ati_vga_init(Object *o)
> >>>> +{
> >>>> +    object_property_set_description(o, "x-pixman", "Use pixman for:=
 "
> >>>> +                                    "1: fill, 2: blit");
> >>>> +}
> >>>> +
> >>>>  static const TypeInfo ati_vga_info =3D {
> >>>>      .name =3D TYPE_ATI_VGA,
> >>>>      .parent =3D TYPE_PCI_DEVICE,
> >>>>      .instance_size =3D sizeof(ATIVGAState),
> >>>>      .class_init =3D ati_vga_class_init,
> >>>> +    .instance_init =3D ati_vga_init,
> >>>>      .interfaces =3D (InterfaceInfo[]) {
> >>>>            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> >>>>            { },
> >>>> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> >>>> index 7d786653e8..0e6b8e4367 100644
> >>>> --- a/hw/display/ati_2d.c
> >>>> +++ b/hw/display/ati_2d.c
> >>>> @@ -92,6 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
> >>>>      switch (s->regs.dp_mix & GMC_ROP3_MASK) {
> >>>>      case ROP3_SRCCOPY:
> >>>>      {
> >>>> +        bool fallback =3D false;
> >>>>          unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
> >>>>                         s->regs.src_x : s->regs.src_x + 1 - s->regs.=
dst_width);
> >>>>          unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> >>>> @@ -122,27 +123,50 @@ void ati_2d_blt(ATIVGAState *s)
> >>>>                  src_bits, dst_bits, src_stride, dst_stride, bpp, bp=
p,
> >>>>                  src_x, src_y, dst_x, dst_y,
> >>>>                  s->regs.dst_width, s->regs.dst_height);
> >>>> -        if (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
> >>>> +        if ((s->use_pixman & BIT(1)) &&
> >>>> +            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
> >>>>              s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> >>>> -            pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
> >>>> -                       src_stride, dst_stride, bpp, bpp,
> >>>> -                       src_x, src_y, dst_x, dst_y,
> >>>> -                       s->regs.dst_width, s->regs.dst_height);
> >>>> -        } else {
> >>>> +            fallback =3D !pixman_blt((uint32_t *)src_bits, (uint32_=
t *)dst_bits,
> >>>> +                                   src_stride, dst_stride, bpp, bpp=
,
> >>>> +                                   src_x, src_y, dst_x, dst_y,
> >>>> +                                   s->regs.dst_width, s->regs.dst_h=
eight);
> >>>> +        } else if (s->use_pixman & BIT(1)) {
> >>>>              /* FIXME: We only really need a temporary if src and ds=
t overlap */
> >>>>              int llb =3D s->regs.dst_width * (bpp / 8);
> >>>>              int tmp_stride =3D DIV_ROUND_UP(llb, sizeof(uint32_t));
> >>>>              uint32_t *tmp =3D g_malloc(tmp_stride * sizeof(uint32_t=
) *
> >>>>                                       s->regs.dst_height);
> >>>> -            pixman_blt((uint32_t *)src_bits, tmp,
> >>>> -                       src_stride, tmp_stride, bpp, bpp,
> >>>> -                       src_x, src_y, 0, 0,
> >>>> -                       s->regs.dst_width, s->regs.dst_height);
> >>>> -            pixman_blt(tmp, (uint32_t *)dst_bits,
> >>>> -                       tmp_stride, dst_stride, bpp, bpp,
> >>>> -                       0, 0, dst_x, dst_y,
> >>>> -                       s->regs.dst_width, s->regs.dst_height);
> >>>> +            fallback =3D !pixman_blt((uint32_t *)src_bits, tmp,
> >>>> +                                   src_stride, tmp_stride, bpp, bpp=
,
> >>>> +                                   src_x, src_y, 0, 0,
> >>>> +                                   s->regs.dst_width, s->regs.dst_h=
eight);
> >>>> +            if (!fallback) {
> >>>> +                fallback =3D !pixman_blt(tmp, (uint32_t *)dst_bits,
> >>>> +                                       tmp_stride, dst_stride, bpp,=
 bpp,
> >>>> +                                       0, 0, dst_x, dst_y,
> >>>> +                                       s->regs.dst_width, s->regs.d=
st_height);
> >>>> +            }
> >>>>              g_free(tmp);
> >>>> +        } else {
> >>>> +            fallback =3D true;
> >>>> +        }
> >>>> +        if (fallback) {
> >>>> +            unsigned int y, i, j, bypp =3D bpp / 8;
> >>>> +            unsigned int src_pitch =3D src_stride * sizeof(uint32_t=
);
> >>>> +            unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t=
);
> >>>> +
> >>>> +            for (y =3D 0; y < s->regs.dst_height; y++) {
> >>>> +                i =3D dst_x * bypp;
> >>>> +                j =3D src_x * bypp;
> >>>> +                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> >>>> +                    i +=3D (dst_y + y) * dst_pitch;
> >>>> +                    j +=3D (src_y + y) * src_pitch;
> >>>> +                } else {
> >>>> +                    i +=3D (dst_y + s->regs.dst_height - 1 - y) * d=
st_pitch;
> >>>> +                    j +=3D (src_y + s->regs.dst_height - 1 - y) * s=
rc_pitch;
> >>>> +                }
> >>>> +                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_wid=
th * bypp);
> >>>
> >>> This doesn't seem to handle overlapping regions the same as the
> >>> pixman-version. Or am I missing something?
> >>
> >> memmove (as opposed to memcpy) allows overlapping regions and handles =
them
> >> correctly so no temporary needed for this. I've tested it with MorphOS=
 and
> >> still got correct picture.
> >
> > But it is calling memmove() for each line, you may have overlapping
> > rectangles. Having a temporary like above should solve this issue,
> > assuming it's the correct behaviour.
>
> Lines are handled by DST_Y_TOP_TO_BOTTOM so they are processed either top
> down or bottom up to avoid overlap. We only need temporary for pixman
> because the only does top down left to right but here vertical direction
> is handled by going through lines in the right order and horisontal
> overlap is handled by memmove. No need for temporary in this case. This i=
s
> doing the same as sm501 so if you accept that works this is exactly the
> same only the coords calculation is a bit different due to ati-vga storin=
g
> values differently.

ok, thanks
Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> Regards,
> BALATON Zoltan
>
> >>>> +            }
> >>>>          }
> >>>>          if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &=
&
> >>>>              dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> >>>> @@ -180,14 +204,21 @@ void ati_2d_blt(ATIVGAState *s)
> >>>>
> >>>>          dst_stride /=3D sizeof(uint32_t);
> >>>>          DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> >>>> -                dst_bits, dst_stride, bpp,
> >>>> -                dst_x, dst_y,
> >>>> -                s->regs.dst_width, s->regs.dst_height,
> >>>> -                filler);
> >>>> -        pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
> >>>> -                    dst_x, dst_y,
> >>>> -                    s->regs.dst_width, s->regs.dst_height,
> >>>> -                    filler);
> >>>> +                dst_bits, dst_stride, bpp, dst_x, dst_y,
> >>>> +                s->regs.dst_width, s->regs.dst_height, filler);
> >>>> +        if (!(s->use_pixman & BIT(0)) ||
> >>>> +            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst=
_x, dst_y,
> >>>> +                    s->regs.dst_width, s->regs.dst_height, filler))=
 {
> >>>> +            /* fallback when pixman failed or we don't want to call=
 it */
> >>>> +            unsigned int x, y, i, bypp =3D bpp / 8;
> >>>> +            unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t=
);
> >>>> +            for (y =3D 0; y < s->regs.dst_height; y++) {
> >>>> +                i =3D dst_x * bypp + (dst_y + y) * dst_pitch;
> >>>> +                for (x =3D 0; x < s->regs.dst_width; x++, i +=3D by=
pp) {
> >>>> +                    stn_he_p(&dst_bits[i], bypp, filler);
> >>>> +                }
> >>>> +            }
> >>>> +        }
> >>>>          if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &=
&
> >>>>              dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> >>>>              s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line=
_offset) {
> >>>> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> >>>> index 8abb873f01..f5a47b82b0 100644
> >>>> --- a/hw/display/ati_int.h
> >>>> +++ b/hw/display/ati_int.h
> >>>> @@ -90,6 +90,7 @@ struct ATIVGAState {
> >>>>      char *model;
> >>>>      uint16_t dev_id;
> >>>>      uint8_t mode;
> >>>> +    uint8_t use_pixman;
> >>>>      bool cursor_guest_mode;
> >>>>      uint16_t cursor_size;
> >>>>      uint32_t cursor_offset;
> >>>> --
> >>>> 2.30.9
> >>>>
> >>>>
> >>>
> >>>
> >>>
> >
> >
> >
> >



--=20
Marc-Andr=C3=A9 Lureau

