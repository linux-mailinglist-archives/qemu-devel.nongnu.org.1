Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41E798E4D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 20:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qegLG-0008Gz-F7; Fri, 08 Sep 2023 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qegLB-0008Am-Bg; Fri, 08 Sep 2023 14:36:25 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qegL5-0000up-SI; Fri, 08 Sep 2023 14:36:25 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52e5900cf77so3174481a12.2; 
 Fri, 08 Sep 2023 11:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694198177; x=1694802977; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FUWSUJ4Dj1NQdoDwziFz0NVvbrXKViUEyYu30R/42PE=;
 b=q0U58ac3LKkfuRUD2w7r9oU7M12D6SSY5lA+OvGnw/aIIiayATEE4ciD+NycnOWKoU
 x8l06kYt1RfHdgrbxTaal5jpIqqVJmI+TqczpQnthvg4RVOaCzlMWPpyUyBXHA8ZHpSg
 WWq/6ITAm/PCwz+X33SXwudz9/o5UQQNVKAxTPIjuzxeDPUYS98en4UjvBUHYbeGJZK2
 b7/KCqlCqeVyXnCF7Dx7RsQe0kbubfDo84DY5pt3rgFEVfcn33JfsuTR/dElkWa86iv/
 pRcWQU6DcDRyCmj3hyaYdJl2HlU272Rz/H9tg5UZ6yUmRTPavPS+qv5jRDxlbVN6YbaJ
 W2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694198177; x=1694802977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FUWSUJ4Dj1NQdoDwziFz0NVvbrXKViUEyYu30R/42PE=;
 b=fnE7T/DYuFR6M2TN7uGdKuKk3ZORm6lSRLc0JLNs9QQormNCLvKuL9nOb1obqlb5Aw
 anb0IwvZRSTihIcIm48Q5fhJK4DJBTP5dIojAf8hqdnpGCCu8ExELOfgZZ1wgxeO4KDJ
 mLgtSD4LENhEZaME5AgMFN3OQGKYtCZeKmlJxgSa+NwKesjc3ur5yCHPgpralPAuHIrI
 BVlULuDW7FPKsYtMhvacyrf3jH/fagtQbqRkWPlbj4dsW02CBkWSC98mIjxHr2HGNeQF
 TNSvg/kbFTK7FxAvT8bzKq4wP6+3RuFnWkwDjZLZwRayOP+eaGnTebO3ANXJXw40NE7/
 qWQQ==
X-Gm-Message-State: AOJu0YxgMsG3U++t2scVxeIkJzi++6XcFz7moY/NwCNzRoR7VAv+DlMy
 GuykdFQteybl0lzqUGwEZp0vKm+p7y6XNvclfOByw37mewIDvg==
X-Google-Smtp-Source: AGHT+IGgwBQW5rNmQ3ncljT4cX8VI845HP38chyaJHmomGrvi/F+VC6o+8+HQGjBH7oIq8erC5Yvajjv4BcdnnNsCXM=
X-Received: by 2002:a17:906:1005:b0:9a6:4dfd:1a6f with SMTP id
 5-20020a170906100500b009a64dfd1a6fmr2922470ejm.52.1694198177063; Fri, 08 Sep
 2023 11:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
 <20230905201425.118918-5-strahinja.p.jankovic@gmail.com>
 <15b0f385-7a81-3b11-e5c2-773c49bc53d4@linaro.org>
In-Reply-To: <15b0f385-7a81-3b11-e5c2-773c49bc53d4@linaro.org>
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Date: Fri, 8 Sep 2023 20:36:05 +0200
Message-ID: <CABtshVQzoHMd8cA4K1+2XZub1F_PtrtwHXZsvj1wx-pW1sCwtQ@mail.gmail.com>
Subject: Re: [RFC Patch 4/5] hw/display: Allwinner A10 LCDC emulation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000085e6e70604dd4015"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000085e6e70604dd4015
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Thank you for your comment.



On Wed, Sep 6, 2023 at 7:03=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> +Gerd & Marc-Andr=C3=A9 for the ui/fb parts.
>
> On 5/9/23 22:14, Strahinja Jankovic wrote:
> > This patch adds support for Allwinner A10 LCD controller.
> > Current emulation supports only RGB32 colorspace and interacts with
> > DEBE0 to obtain framebuffer address and screen size.
> >
> > Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
> > ---
> >   hw/arm/allwinner-a10.c                  |  10 +
> >   hw/display/allwinner-a10-lcdc.c         | 275 +++++++++++++++++++++++=
+
> >   hw/display/meson.build                  |   1 +
> >   hw/display/trace-events                 |   5 +
> >   include/hw/arm/allwinner-a10.h          |   2 +
> >   include/hw/display/allwinner-a10-lcdc.h |  77 +++++++
> >   6 files changed, 370 insertions(+)
> >   create mode 100644 hw/display/allwinner-a10-lcdc.c
> >   create mode 100644 include/hw/display/allwinner-a10-lcdc.h
> >
> > diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> > index 624e95af46..f93bc5266d 100644
> > --- a/hw/arm/allwinner-a10.c
> > +++ b/hw/arm/allwinner-a10.c
> > @@ -41,6 +41,7 @@
> >   #define AW_A10_WDT_BASE         0x01c20c90
> >   #define AW_A10_RTC_BASE         0x01c20d00
> >   #define AW_A10_I2C0_BASE        0x01c2ac00
> > +#define AW_A10_LCDC0_BASE       0x01c0c000
> >   #define AW_A10_HDMI_BASE        0x01c16000
> >   #define AW_A10_GPU_BASE         0x01c40000
> >   #define AW_A10_DE_BE0_BASE      0x01e60000
> > @@ -101,6 +102,8 @@ static void aw_a10_init(Object *obj)
> >
> >       object_initialize_child(obj, "hdmi", &s->hdmi, TYPE_AW_A10_HDMI);
> >
> > +    object_initialize_child(obj, "lcd0", &s->lcd0, TYPE_AW_A10_LCDC);
> > +
> >       object_initialize_child(obj, "de_be0", &s->de_be0,
> TYPE_AW_A10_DEBE);
> >
> >       object_initialize_child(obj, "mali400", &s->gpu, TYPE_AW_GPU);
> > @@ -230,6 +233,13 @@ static void aw_a10_realize(DeviceState *dev, Error
> **errp)
> >       sysbus_realize(SYS_BUS_DEVICE(&s->de_be0), &error_fatal);
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->de_be0), 0, AW_A10_DE_BE0_BASE=
);
> >
> > +    /* LCD Controller */
> > +    object_property_set_link(OBJECT(&s->lcd0), "debe",
> > +                             OBJECT(&s->de_be0), &error_fatal);
>
> IIUC you have LCDC polling DEBE for size update then invalidate,
> shouldn't be the opposite, LCDC linked to DEBE and DEBE call the
> LCDC invalidate handler on resize?
>

I think I understand what you meant. In this case, it was easier to do it
this way, since this way only LCDC needs to store a pointer to DEBE, there
is no need for storing the pointer the other way around as well.
Also the update function should be called frequently, so that should not
affect the performance.

If there is another way to implement this behavior, I am open to changing
this implementation.

Best regards,
Strahinja



> > +    sysbus_realize(SYS_BUS_DEVICE(&s->lcd0), &error_fatal);
> > +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->lcd0), 0, AW_A10_LCDC0_BASE);
> > +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lcd0), 0,
> qdev_get_gpio_in(dev, 44));
> > +
> >       /* MALI GPU */
> >       sysbus_realize(SYS_BUS_DEVICE(&s->gpu), &error_fatal);
> >       sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpu), 0, AW_A10_GPU_BASE);
> > diff --git a/hw/display/allwinner-a10-lcdc.c
> b/hw/display/allwinner-a10-lcdc.c
> > new file mode 100644
> > index 0000000000..8367ac32be
> > --- /dev/null
> > +++ b/hw/display/allwinner-a10-lcdc.c
> > @@ -0,0 +1,275 @@
> > +/*
> > + * Allwinner A10 LCD Control Module emulation
> > + *
> > + * Copyright (C) 2023 Strahinja Jankovic <
> strahinja.p.jankovic@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu/units.h"
> > +#include "hw/sysbus.h"
> > +#include "migration/vmstate.h"
> > +#include "qemu/log.h"
> > +#include "hw/qdev-properties.h"
> > +#include "qemu/module.h"
> > +#include "hw/display/allwinner-a10-lcdc.h"
> > +#include "hw/irq.h"
> > +#include "ui/pixel_ops.h"
> > +#include "trace.h"
> > +#include "sysemu/dma.h"
> > +#include "framebuffer.h"
> > +
> > +/* LCDC register offsets */
> > +enum {
> > +    REG_TCON_GCTL       =3D 0x0000, /* TCON Global control register */
> > +    REG_TCON_GINT0      =3D 0x0004, /* TCON Global interrupt register =
0 */
> > +};
> > +
> > +/* TCON_GCTL register fields */
> > +#define REG_TCON_GCTL_EN        (1 << 31)
> > +
> > +/* TCON_GINT0 register fields */
> > +#define REG_TCON_GINT0_VB_INT_EN    (1 << 31)
> > +#define REG_TCON_GINT0_VB_INT_FLAG  (1 << 14)
> > +
> > +#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
> > +
> > +static void allwinner_a10_lcdc_tick(void *opaque)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(opaque);
> > +
> > +    if (s->regs[REG_INDEX(REG_TCON_GINT0)] & REG_TCON_GINT0_VB_INT_EN)=
 {
> > +        s->regs[REG_INDEX(REG_TCON_GINT0)] |=3D
> REG_TCON_GINT0_VB_INT_FLAG;
> > +        qemu_irq_raise(s->irq);
> > +    }
> > +}
> > +
> > +static uint64_t allwinner_a10_lcdc_read(void *opaque, hwaddr offset,
> > +                                       unsigned size)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +    uint32_t val =3D s->regs[idx];
> > +
> > +    switch (offset) {
> > +    case 0x800 ... AW_A10_LCDC_IOSIZE:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                  __func__, (uint32_t)offset);
> > +        return 0;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    trace_allwinner_a10_lcdc_read(offset, val);
> > +
> > +    return val;
> > +}
> > +
> > +static void allwinner_a10_lcdc_write(void *opaque, hwaddr offset,
> > +                                   uint64_t val, unsigned size)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(opaque);
> > +    const uint32_t idx =3D REG_INDEX(offset);
> > +
> > +    switch (offset) {
> > +    case REG_TCON_GCTL:
> > +        s->is_enabled =3D !!REG_TCON_GCTL_EN;
> > +        break;
> > +    case REG_TCON_GINT0:
> > +        if (0 =3D=3D (val & REG_TCON_GINT0_VB_INT_FLAG)) {
> > +            qemu_irq_lower(s->irq);
> > +        }
> > +        break;
> > +    case 0x800 ... AW_A10_LCDC_IOSIZE:
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset
> 0x%04x\n",
> > +                  __func__, (uint32_t)offset);
> > +        break;
> > +    default:
> > +        break;
> > +    }
> > +
> > +    trace_allwinner_a10_lcdc_write(offset, (uint32_t)val);
> > +
> > +    s->regs[idx] =3D (uint32_t) val;
> > +}
> > +
> > +static const MemoryRegionOps allwinner_a10_lcdc_ops =3D {
> > +    .read =3D allwinner_a10_lcdc_read,
> > +    .write =3D allwinner_a10_lcdc_write,
> > +    .endianness =3D DEVICE_NATIVE_ENDIAN,
> > +    .valid =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 4,
> > +    },
> > +    .impl.min_access_size =3D 1,
> > +};
> > +
> > +#define COPY_PIXEL(to, from) do { *(uint32_t *)to =3D from; to +=3D 4;=
 }
> while (0)
> > +
> > +static void draw_line(void *opaque, uint8_t *d, const uint8_t *src,
> > +                      int width, int deststep)
> > +{
> > +    uint32_t data;
> > +    unsigned int r, g, b;
> > +    while (width > 0) {
> > +        data =3D *(uint32_t *)src;
> > +        b =3D data & 0xff;
> > +        g =3D (data >> 8) & 0xff;
> > +        r =3D (data >> 16) & 0xff;
> > +        COPY_PIXEL(d, rgb_to_pixel32(r, g, b));
> > +        width--;
> > +        src +=3D 4;
> > +    }
> > +}
> > +
> > +static void allwinner_a10_lcdc_invalidate_display(void *opaque)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(opaque);
> > +    qemu_console_resize(s->con, s->debe->width, s->debe->height);
> > +    s->invalidate =3D 1;
> > +}
> > +
> > +static void allwinner_a10_lcdc_update_display(void *opaque)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(opaque);
> > +    DisplaySurface *surface;
> > +    int step, width, height, linesize, first =3D 0, last;
> > +
> > +    if (!s->is_enabled || !s->debe->ready) {
> > +        return;
> > +    }
> > +
> > +    width =3D s->debe->width;
> > +    height =3D s->debe->height;
> > +    step =3D width * (s->debe->bpp >> 3);
> > +
> > +    if (s->debe->invalidate) {
> > +        allwinner_a10_lcdc_invalidate_display(opaque);
> > +        s->debe->invalidate =3D false;
> > +    }
> > +
> > +    surface =3D qemu_console_surface(s->con);
> > +    linesize =3D surface_stride(surface);
> > +
> > +    if (s->invalidate) {
> > +        framebuffer_update_memory_section(&s->fbsection,
> > +
> sysbus_address_space(SYS_BUS_DEVICE(s)),
> > +                                    s->debe->framebuffer_offset,
> > +                                    height, step);
> > +    }
> > +
> > +    framebuffer_update_display(surface, &s->fbsection,
> > +                               width, height,
> > +                               step, linesize, 0,
> > +                               s->invalidate,
> > +                               draw_line, NULL,
> > +                               &first, &last);
> > +
> > +    trace_allwinner_a10_draw(first, last, s->invalidate);
> > +
> > +    if (first >=3D 0) {
> > +        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
> > +    }
> > +    s->invalidate =3D 0;
> > +
> > +}
> > +
> > +static const GraphicHwOps allwinner_a10_lcdc_gfx_ops =3D {
> > +    .invalidate  =3D allwinner_a10_lcdc_invalidate_display,
> > +    .gfx_update  =3D allwinner_a10_lcdc_update_display,
> > +};
> > +
> > +static void allwinner_a10_lcdc_reset_enter(Object *obj, ResetType type=
)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(obj);
> > +    s->invalidate =3D 1;
> > +}
> > +
> > +static void allwinner_a10_lcdc_init(Object *obj)
> > +{
> > +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(obj);
> > +
> > +    /* Memory mapping */
> > +    memory_region_init_io(&s->iomem, OBJECT(s),
> &allwinner_a10_lcdc_ops, s,
> > +                          TYPE_AW_A10_LCDC, AW_A10_LCDC_IOSIZE);
> > +    sysbus_init_mmio(sbd, &s->iomem);
> > +    sysbus_init_irq(sbd, &s->irq);
> > +    s->invalidate =3D 1;
> > +    s->is_enabled =3D 0;
> > +}
> > +
> > +static void allwinner_a10_lcdc_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AwA10LcdcState *s =3D AW_A10_LCDC(dev);
> > +
> > +    s->timer =3D ptimer_init(allwinner_a10_lcdc_tick, s,
> > +                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
> > +                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
> > +                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
> > +
> > +    ptimer_transaction_begin(s->timer);
> > +    /* Set to 60Hz */
> > +    ptimer_set_freq(s->timer, 60);
> > +    ptimer_set_limit(s->timer, 0x1, 1);
> > +    ptimer_run(s->timer, 0);
> > +    ptimer_transaction_commit(s->timer);
> > +
> > +    s->invalidate =3D 1;
> > +    s->con =3D graphic_console_init(NULL, 0, &allwinner_a10_lcdc_gfx_o=
ps,
> s);
> > +    qemu_console_resize(s->con, s->debe->width, s->debe->height);
> > +}
> > +
> > +static const VMStateDescription allwinner_a10_lcdc_vmstate =3D {
> > +    .name =3D "allwinner-a10_lcdc",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT32_ARRAY(regs, AwA10LcdcState,
> AW_A10_LCDC_REGS_NUM),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> > +static Property allwinner_a10_lcdc_properties[] =3D {
> > +    DEFINE_PROP_LINK("debe", AwA10LcdcState, debe,
> > +                     TYPE_AW_A10_DEBE, AwA10DEBEState *),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void allwinner_a10_lcdc_class_init(ObjectClass *klass, void
> *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
> > +
> > +    rc->phases.enter =3D allwinner_a10_lcdc_reset_enter;
> > +    dc->vmsd =3D &allwinner_a10_lcdc_vmstate;
> > +    dc->realize =3D allwinner_a10_lcdc_realize;
> > +    device_class_set_props(dc, allwinner_a10_lcdc_properties);
> > +}
> > +
> > +static const TypeInfo allwinner_a10_lcdc_info =3D {
> > +    .name          =3D TYPE_AW_A10_LCDC,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_init =3D allwinner_a10_lcdc_init,
> > +    .instance_size =3D sizeof(AwA10LcdcState),
> > +    .class_init    =3D allwinner_a10_lcdc_class_init,
> > +};
> > +
> > +static void allwinner_a10_lcdc_register(void)
> > +{
> > +    type_register_static(&allwinner_a10_lcdc_info);
> > +}
> > +
> > +type_init(allwinner_a10_lcdc_register)
> > diff --git a/hw/display/meson.build b/hw/display/meson.build
> > index a3ef580b1c..e233026fdd 100644
> > --- a/hw/display/meson.build
> > +++ b/hw/display/meson.build
> > @@ -40,6 +40,7 @@ system_ss.add(when: 'CONFIG_VGA', if_true:
> files('vga.c'))
> >
> >   system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true:
> files('allwinner-a10-debe.c',
> >
> 'allwinner-a10-hdmi.c',
> > +
>  'allwinner-a10-lcdc.c',
> >
> 'allwinner-gpu.c'))
> >
> >   if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
> > diff --git a/hw/display/trace-events b/hw/display/trace-events
> > index 132b66fc81..4b962d6eda 100644
> > --- a/hw/display/trace-events
> > +++ b/hw/display/trace-events
> > @@ -186,6 +186,11 @@ allwinner_a10_debe_write(uint64_t offset, uint64_t
> data) "Write: offset 0x%" PRI
> >   allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) "Read: offset
> 0x%" PRIx64 " data 0x%" PRIx64
> >   allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) "Write:
> offset 0x%" PRIx64 " data 0x%" PRIx64
> >
> > +# allwinner-a10-lcdc.c
> > +allwinner_a10_lcdc_read(uint64_t offset, uint64_t data) "Read: offset
> 0x%" PRIx64 " data 0x%" PRIx64
> > +allwinner_a10_lcdc_write(uint64_t offset, uint64_t data) "Write: offse=
t
> 0x%" PRIx64 " data 0x%" PRIx64
> > +allwinner_a10_draw(uint32_t first, uint32_t last, uint32_t invalidate)
> "Draw: 0x%x, 0x%x, 0x%x"
> > +
> >   # allwinner-gpu.c
> >   allwinner_gpu_read(uint64_t offset, uint64_t data) "Read: offset 0x%"
> PRIx64 " data 0x%" PRIx64
> >   allwinner_gpu_write(uint64_t offset, uint64_t data) "Write: offset
> 0x%" PRIx64 " data 0x%" PRIx64
> > diff --git a/include/hw/arm/allwinner-a10.h
> b/include/hw/arm/allwinner-a10.h
> > index 2de7e402b2..c99ca6c1c4 100644
> > --- a/include/hw/arm/allwinner-a10.h
> > +++ b/include/hw/arm/allwinner-a10.h
> > @@ -14,6 +14,7 @@
> >   #include "hw/misc/allwinner-a10-dramc.h"
> >   #include "hw/display/allwinner-a10-debe.h"
> >   #include "hw/display/allwinner-a10-hdmi.h"
> > +#include "hw/display/allwinner-a10-lcdc.h"
> >   #include "hw/display/allwinner-gpu.h"
> >   #include "hw/i2c/allwinner-i2c.h"
> >   #include "hw/watchdog/allwinner-wdt.h"
> > @@ -49,6 +50,7 @@ struct AwA10State {
> >       AwA10DEBEState de_be0;
> >       AwGpuState gpu;
> >       AwA10HdmiState hdmi;
> > +    AwA10LcdcState lcd0;
> >       MemoryRegion sram_a;
> >       EHCISysBusState ehci[AW_A10_NUM_USB];
> >       OHCISysBusState ohci[AW_A10_NUM_USB];
> > diff --git a/include/hw/display/allwinner-a10-lcdc.h
> b/include/hw/display/allwinner-a10-lcdc.h
> > new file mode 100644
> > index 0000000000..82f6d397fb
> > --- /dev/null
> > +++ b/include/hw/display/allwinner-a10-lcdc.h
> > @@ -0,0 +1,77 @@
> > +/*
> > + * Allwinner A10 LCD Control Module emulation
> > + *
> > + * Copyright (C) 2023 Strahinja Jankovic <
> strahinja.p.jankovic@gmail.com>
> > + *
> > + * This program is free software: you can redistribute it and/or modif=
y
> > + * it under the terms of the GNU General Public License as published b=
y
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program.  If not, see <http://www.gnu.org/licenses/
> >.
> > + */
> > +
> > +#ifndef HW_DISPLAY_ALLWINNER_A10_LCDC_H
> > +#define HW_DISPLAY_ALLWINNER_A10_LCDC_H
> > +
> > +#include "qom/object.h"
> > +#include "hw/ptimer.h"
> > +#include "hw/sysbus.h"
> > +#include "ui/console.h"
> > +#include "hw/display/allwinner-a10-debe.h"
> > +
> > +/**
> > + * @name Constants
> > + * @{
> > + */
> > +
> > +/** Size of register I/O address space used by LCDC device */
> > +#define AW_A10_LCDC_IOSIZE        (0x1000)
> > +
> > +/** Total number of known registers */
> > +#define AW_A10_LCDC_REGS_NUM      (AW_A10_LCDC_IOSIZE /
> sizeof(uint32_t))
> > +
> > +/** @} */
> > +
> > +/**
> > + * @name Object model
> > + * @{
> > + */
> > +
> > +#define TYPE_AW_A10_LCDC    "allwinner-a10-lcdc"
> > +OBJECT_DECLARE_SIMPLE_TYPE(AwA10LcdcState, AW_A10_LCDC)
> > +
> > +/** @} */
> > +
> > +/**
> > + * Allwinner A10 LCDC object instance state.
> > + */
> > +struct AwA10LcdcState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +    /*< public >*/
> > +    qemu_irq irq;
> > +    struct ptimer_state *timer;
> > +    QemuConsole *con;
> > +
> > +    MemoryRegionSection fbsection;
> > +
> > +    int invalidate;
> > +    bool is_enabled;
> > +
> > +    AwA10DEBEState *debe;
> > +
> > +    /** Maps I/O registers in physical memory */
> > +    MemoryRegion iomem;
> > +
> > +    /** Array of hardware registers */
> > +    uint32_t regs[AW_A10_LCDC_REGS_NUM];
> > +};
> > +
> > +#endif /* HW_DISPLAY_ALLWINNER_A10_LCDC_H */
>
>

--00000000000085e6e70604dd4015
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Philippe,<div><br></div><div>Thank you=
 for your comment.</div><div><br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 6, 2023 =
at 7:03=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd=
@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">+Gerd &amp; Marc-Andr=C3=A9 for the ui/fb par=
ts.<br>
<br>
On 5/9/23 22:14, Strahinja Jankovic wrote:<br>
&gt; This patch adds support for Allwinner A10 LCD controller.<br>
&gt; Current emulation supports only RGB32 colorspace and interacts with<br=
>
&gt; DEBE0 to obtain framebuffer address and screen size.<br>
&gt; <br>
&gt; Signed-off-by: Strahinja Jankovic &lt;<a href=3D"mailto:strahinja.p.ja=
nkovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<br>
&gt;=C2=A0 =C2=A0hw/display/allwinner-a10-lcdc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| 275 ++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/display/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/display/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-a10.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A02 +<br>
&gt;=C2=A0 =C2=A0include/hw/display/allwinner-a10-lcdc.h |=C2=A0 77 +++++++=
<br>
&gt;=C2=A0 =C2=A06 files changed, 370 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/display/allwinner-a10-lcdc.c<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/display/allwinner-a10-lcdc.h=
<br>
&gt; <br>
&gt; diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c<br>
&gt; index 624e95af46..f93bc5266d 100644<br>
&gt; --- a/hw/arm/allwinner-a10.c<br>
&gt; +++ b/hw/arm/allwinner-a10.c<br>
&gt; @@ -41,6 +41,7 @@<br>
&gt;=C2=A0 =C2=A0#define AW_A10_WDT_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=
x01c20c90<br>
&gt;=C2=A0 =C2=A0#define AW_A10_RTC_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=
x01c20d00<br>
&gt;=C2=A0 =C2=A0#define AW_A10_I2C0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c2=
ac00<br>
&gt; +#define AW_A10_LCDC0_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c0c000<br>
&gt;=C2=A0 =C2=A0#define AW_A10_HDMI_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c1=
6000<br>
&gt;=C2=A0 =C2=A0#define AW_A10_GPU_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00=
x01c40000<br>
&gt;=C2=A0 =C2=A0#define AW_A10_DE_BE0_BASE=C2=A0 =C2=A0 =C2=A0 0x01e60000<=
br>
&gt; @@ -101,6 +102,8 @@ static void aw_a10_init(Object *obj)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;hdmi&quot=
;, &amp;s-&gt;hdmi, TYPE_AW_A10_HDMI);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 object_initialize_child(obj, &quot;lcd0&quot;, &amp;s-&=
gt;lcd0, TYPE_AW_A10_LCDC);<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;de_be0&qu=
ot;, &amp;s-&gt;de_be0, TYPE_AW_A10_DEBE);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;mali400&q=
uot;, &amp;s-&gt;gpu, TYPE_AW_GPU);<br>
&gt; @@ -230,6 +233,13 @@ static void aw_a10_realize(DeviceState *dev, Erro=
r **errp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;de_=
be0), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;de=
_be0), 0, AW_A10_DE_BE0_BASE);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 /* LCD Controller */<br>
&gt; +=C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;lcd0), &quot=
;debe&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(&amp;s-&gt;de_be0), &amp;error_fa=
tal);<br>
<br>
IIUC you have LCDC polling DEBE for size update then invalidate,<br>
shouldn&#39;t be the opposite, LCDC linked to DEBE and DEBE call the<br>
LCDC invalidate handler on resize?<br></blockquote><div><br></div><div>I th=
ink I understand what you meant. In this case, it was easier to do it this =
way, since this way only LCDC needs to store a pointer to DEBE, there is no=
 need for storing the pointer the other way around as well.</div><div>Also =
the update function should be called frequently, so that should not affect =
the performance.</div><div><br></div><div>If there is another way to implem=
ent this behavior, I am open to changing this implementation.</div><div><br=
></div><div>Best regards,</div><div>Strahinja</div><div><br></div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;lcd0), &amp;er=
ror_fatal);<br>
&gt; +=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;lcd0), 0, AW_=
A10_LCDC0_BASE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;lcd0), 0, =
qdev_get_gpio_in(dev, 44));<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* MALI GPU */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gpu=
), &amp;error_fatal);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gp=
u), 0, AW_A10_GPU_BASE);<br>
&gt; diff --git a/hw/display/allwinner-a10-lcdc.c b/hw/display/allwinner-a1=
0-lcdc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..8367ac32be<br>
&gt; --- /dev/null<br>
&gt; +++ b/hw/display/allwinner-a10-lcdc.c<br>
&gt; @@ -0,0 +1,275 @@<br>
&gt; +/*<br>
&gt; + * Allwinner A10 LCD Control Module emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2023 Strahinja Jankovic &lt;<a href=3D"mailto:strahi=
nja.p.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com<=
/a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +#include &quot;qemu/units.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;migration/vmstate.h&quot;<br>
&gt; +#include &quot;qemu/log.h&quot;<br>
&gt; +#include &quot;hw/qdev-properties.h&quot;<br>
&gt; +#include &quot;qemu/module.h&quot;<br>
&gt; +#include &quot;hw/display/allwinner-a10-lcdc.h&quot;<br>
&gt; +#include &quot;hw/irq.h&quot;<br>
&gt; +#include &quot;ui/pixel_ops.h&quot;<br>
&gt; +#include &quot;trace.h&quot;<br>
&gt; +#include &quot;sysemu/dma.h&quot;<br>
&gt; +#include &quot;framebuffer.h&quot;<br>
&gt; +<br>
&gt; +/* LCDC register offsets */<br>
&gt; +enum {<br>
&gt; +=C2=A0 =C2=A0 REG_TCON_GCTL=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0000, /* =
TCON Global control register */<br>
&gt; +=C2=A0 =C2=A0 REG_TCON_GINT0=C2=A0 =C2=A0 =C2=A0 =3D 0x0004, /* TCON =
Global interrupt register 0 */<br>
&gt; +};<br>
&gt; +<br>
&gt; +/* TCON_GCTL register fields */<br>
&gt; +#define REG_TCON_GCTL_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 31)<b=
r>
&gt; +<br>
&gt; +/* TCON_GINT0 register fields */<br>
&gt; +#define REG_TCON_GINT0_VB_INT_EN=C2=A0 =C2=A0 (1 &lt;&lt; 31)<br>
&gt; +#define REG_TCON_GINT0_VB_INT_FLAG=C2=A0 (1 &lt;&lt; 14)<br>
&gt; +<br>
&gt; +#define REG_INDEX(offset)=C2=A0 =C2=A0 (offset / sizeof(uint32_t))<br=
>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_tick(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(opaque);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;regs[REG_INDEX(REG_TCON_GINT0)] &amp; REG_TCO=
N_GINT0_VB_INT_EN) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;regs[REG_INDEX(REG_TCON_GINT0)] |=
=3D REG_TCON_GINT0_VB_INT_FLAG;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_raise(s-&gt;irq);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint64_t allwinner_a10_lcdc_read(void *opaque, hwaddr offset,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +=C2=A0 =C2=A0 uint32_t val =3D s-&gt;regs[idx];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case 0x800 ... AW_A10_LCDC_IOSIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func=
__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_lcdc_read(offset, val);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_write(void *opaque, hwaddr offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t val, unsig=
ned size)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(opaque);<br>
&gt; +=C2=A0 =C2=A0 const uint32_t idx =3D REG_INDEX(offset);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (offset) {<br>
&gt; +=C2=A0 =C2=A0 case REG_TCON_GCTL:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;is_enabled =3D !!REG_TCON_GCTL_EN;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case REG_TCON_GINT0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (0 =3D=3D (val &amp; REG_TCON_GINT0_VB=
_INT_FLAG)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_irq_lower(s-&gt;irq);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 case 0x800 ... AW_A10_LCDC_IOSIZE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset 0x%04x\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __func=
__, (uint32_t)offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_lcdc_write(offset, (uint32_t)val);<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;regs[idx] =3D (uint32_t) val;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const MemoryRegionOps allwinner_a10_lcdc_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .read =3D allwinner_a10_lcdc_read,<br>
&gt; +=C2=A0 =C2=A0 .write =3D allwinner_a10_lcdc_write,<br>
&gt; +=C2=A0 =C2=A0 .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
&gt; +=C2=A0 =C2=A0 .valid =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 1,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 .impl.min_access_size =3D 1,<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define COPY_PIXEL(to, from) do { *(uint32_t *)to =3D from; to +=3D 4=
; } while (0)<br>
&gt; +<br>
&gt; +static void draw_line(void *opaque, uint8_t *d, const uint8_t *src,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 int width, int deststep)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 uint32_t data;<br>
&gt; +=C2=A0 =C2=A0 unsigned int r, g, b;<br>
&gt; +=C2=A0 =C2=A0 while (width &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D *(uint32_t *)src;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 b =3D data &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g =3D (data &gt;&gt; 8) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 r =3D (data &gt;&gt; 16) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 COPY_PIXEL(d, rgb_to_pixel32(r, g, b));<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 width--;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 src +=3D 4;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_invalidate_display(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(opaque);<br>
&gt; +=C2=A0 =C2=A0 qemu_console_resize(s-&gt;con, s-&gt;debe-&gt;width, s-=
&gt;debe-&gt;height);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;invalidate =3D 1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_update_display(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(opaque);<br>
&gt; +=C2=A0 =C2=A0 DisplaySurface *surface;<br>
&gt; +=C2=A0 =C2=A0 int step, width, height, linesize, first =3D 0, last;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;is_enabled || !s-&gt;debe-&gt;ready) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 width =3D s-&gt;debe-&gt;width;<br>
&gt; +=C2=A0 =C2=A0 height =3D s-&gt;debe-&gt;height;<br>
&gt; +=C2=A0 =C2=A0 step =3D width * (s-&gt;debe-&gt;bpp &gt;&gt; 3);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;debe-&gt;invalidate) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 allwinner_a10_lcdc_invalidate_display(opa=
que);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;debe-&gt;invalidate =3D false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 surface =3D qemu_console_surface(s-&gt;con);<br>
&gt; +=C2=A0 =C2=A0 linesize =3D surface_stride(surface);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;invalidate) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 framebuffer_update_memory_section(&amp;s-=
&gt;fbsection,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sysbus_address_spa=
ce(SYS_BUS_DEVICE(s)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;debe-&gt;fra=
mebuffer_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 height, step);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 framebuffer_update_display(surface, &amp;s-&gt;fbsectio=
n,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0width, height,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0step, linesize, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;invalidate,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0draw_line, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;first, &amp;last);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 trace_allwinner_a10_draw(first, last, s-&gt;invalidate)=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (first &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 dpy_gfx_update(s-&gt;con, 0, first, width=
, last - first + 1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;invalidate =3D 0;<br>
&gt; +<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const GraphicHwOps allwinner_a10_lcdc_gfx_ops =3D {<br>
&gt; +=C2=A0 =C2=A0 .invalidate=C2=A0 =3D allwinner_a10_lcdc_invalidate_dis=
play,<br>
&gt; +=C2=A0 =C2=A0 .gfx_update=C2=A0 =3D allwinner_a10_lcdc_update_display=
,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_reset_enter(Object *obj, ResetType typ=
e)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(obj);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;invalidate =3D 1;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_init(Object *obj)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(obj);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Memory mapping */<br>
&gt; +=C2=A0 =C2=A0 memory_region_init_io(&amp;s-&gt;iomem, OBJECT(s), &amp=
;allwinner_a10_lcdc_ops, s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_A10_LCDC, AW_A10_LCDC_IOSIZE);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_mmio(sbd, &amp;s-&gt;iomem);<br>
&gt; +=C2=A0 =C2=A0 sysbus_init_irq(sbd, &amp;s-&gt;irq);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;invalidate =3D 1;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;is_enabled =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_realize(DeviceState *dev, Error **errp=
)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState *s =3D AW_A10_LCDC(dev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;timer =3D ptimer_init(allwinner_a10_lcdc_tick, s,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PTIMER_POLICY_NO_IMMEDIATE_RELOAD |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 ptimer_transaction_begin(s-&gt;timer);<br>
&gt; +=C2=A0 =C2=A0 /* Set to 60Hz */<br>
&gt; +=C2=A0 =C2=A0 ptimer_set_freq(s-&gt;timer, 60);<br>
&gt; +=C2=A0 =C2=A0 ptimer_set_limit(s-&gt;timer, 0x1, 1);<br>
&gt; +=C2=A0 =C2=A0 ptimer_run(s-&gt;timer, 0);<br>
&gt; +=C2=A0 =C2=A0 ptimer_transaction_commit(s-&gt;timer);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;invalidate =3D 1;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;con =3D graphic_console_init(NULL, 0, &amp;allwin=
ner_a10_lcdc_gfx_ops, s);<br>
&gt; +=C2=A0 =C2=A0 qemu_console_resize(s-&gt;con, s-&gt;debe-&gt;width, s-=
&gt;debe-&gt;height);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const VMStateDescription allwinner_a10_lcdc_vmstate =3D {<br>
&gt; +=C2=A0 =C2=A0 .name =3D &quot;allwinner-a10_lcdc&quot;,<br>
&gt; +=C2=A0 =C2=A0 .version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .minimum_version_id =3D 1,<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32_ARRAY(regs, AwA10LcdcState=
, AW_A10_LCDC_REGS_NUM),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_END_OF_LIST()<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static Property allwinner_a10_lcdc_properties[] =3D {<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;debe&quot;, AwA10LcdcState, debe=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0TYPE_AW_A10_DEBE, AwA10DEBEState *),<br>
&gt; +=C2=A0 =C2=A0 DEFINE_PROP_END_OF_LIST(),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_class_init(ObjectClass *klass, void *d=
ata)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
&gt; +=C2=A0 =C2=A0 ResettableClass *rc =3D RESETTABLE_CLASS(klass);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 rc-&gt;phases.enter =3D allwinner_a10_lcdc_reset_enter;=
<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;vmsd =3D &amp;allwinner_a10_lcdc_vmstate;<br>
&gt; +=C2=A0 =C2=A0 dc-&gt;realize =3D allwinner_a10_lcdc_realize;<br>
&gt; +=C2=A0 =C2=A0 device_class_set_props(dc, allwinner_a10_lcdc_propertie=
s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const TypeInfo allwinner_a10_lcdc_info =3D {<br>
&gt; +=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_A10=
_LCDC,<br>
&gt; +=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
&gt; +=C2=A0 =C2=A0 .instance_init =3D allwinner_a10_lcdc_init,<br>
&gt; +=C2=A0 =C2=A0 .instance_size =3D sizeof(AwA10LcdcState),<br>
&gt; +=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_a10_lcdc_class_i=
nit,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void allwinner_a10_lcdc_register(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 type_register_static(&amp;allwinner_a10_lcdc_info);<br>
&gt; +}<br>
&gt; +<br>
&gt; +type_init(allwinner_a10_lcdc_register)<br>
&gt; diff --git a/hw/display/meson.build b/hw/display/meson.build<br>
&gt; index a3ef580b1c..e233026fdd 100644<br>
&gt; --- a/hw/display/meson.build<br>
&gt; +++ b/hw/display/meson.build<br>
&gt; @@ -40,6 +40,7 @@ system_ss.add(when: &#39;CONFIG_VGA&#39;, if_true: f=
iles(&#39;vga.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0system_ss.add(when: &#39;CONFIG_ALLWINNER_A10&#39;, if_tru=
e: files(&#39;allwinner-a10-debe.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;allwinner-a10-hdmi.c&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;allw=
inner-a10-lcdc.c&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &=
#39;allwinner-gpu.c&#39;))<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0if (config_all_devices.has_key(&#39;CONFIG_VGA_CIRRUS&#39;=
) or<br>
&gt; diff --git a/hw/display/trace-events b/hw/display/trace-events<br>
&gt; index 132b66fc81..4b962d6eda 100644<br>
&gt; --- a/hw/display/trace-events<br>
&gt; +++ b/hw/display/trace-events<br>
&gt; @@ -186,6 +186,11 @@ allwinner_a10_debe_write(uint64_t offset, uint64_=
t data) &quot;Write: offset 0x%&quot; PRI<br>
&gt;=C2=A0 =C2=A0allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) &q=
uot;Read: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt;=C2=A0 =C2=A0allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) &=
quot;Write: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +# allwinner-a10-lcdc.c<br>
&gt; +allwinner_a10_lcdc_read(uint64_t offset, uint64_t data) &quot;Read: o=
ffset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt; +allwinner_a10_lcdc_write(uint64_t offset, uint64_t data) &quot;Write:=
 offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt; +allwinner_a10_draw(uint32_t first, uint32_t last, uint32_t invalidate=
) &quot;Draw: 0x%x, 0x%x, 0x%x&quot;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0# allwinner-gpu.c<br>
&gt;=C2=A0 =C2=A0allwinner_gpu_read(uint64_t offset, uint64_t data) &quot;R=
ead: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt;=C2=A0 =C2=A0allwinner_gpu_write(uint64_t offset, uint64_t data) &quot;=
Write: offset 0x%&quot; PRIx64 &quot; data 0x%&quot; PRIx64<br>
&gt; diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner=
-a10.h<br>
&gt; index 2de7e402b2..c99ca6c1c4 100644<br>
&gt; --- a/include/hw/arm/allwinner-a10.h<br>
&gt; +++ b/include/hw/arm/allwinner-a10.h<br>
&gt; @@ -14,6 +14,7 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/misc/allwinner-a10-dramc.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/display/allwinner-a10-debe.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/display/allwinner-a10-hdmi.h&quot;<br>
&gt; +#include &quot;hw/display/allwinner-a10-lcdc.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/display/allwinner-gpu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/i2c/allwinner-i2c.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;hw/watchdog/allwinner-wdt.h&quot;<br>
&gt; @@ -49,6 +50,7 @@ struct AwA10State {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwA10DEBEState de_be0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwGpuState gpu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0AwA10HdmiState hdmi;<br>
&gt; +=C2=A0 =C2=A0 AwA10LcdcState lcd0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0EHCISysBusState ehci[AW_A10_NUM_USB];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0OHCISysBusState ohci[AW_A10_NUM_USB];<br>
&gt; diff --git a/include/hw/display/allwinner-a10-lcdc.h b/include/hw/disp=
lay/allwinner-a10-lcdc.h<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..82f6d397fb<br>
&gt; --- /dev/null<br>
&gt; +++ b/include/hw/display/allwinner-a10-lcdc.h<br>
&gt; @@ -0,0 +1,77 @@<br>
&gt; +/*<br>
&gt; + * Allwinner A10 LCD Control Module emulation<br>
&gt; + *<br>
&gt; + * Copyright (C) 2023 Strahinja Jankovic &lt;<a href=3D"mailto:strahi=
nja.p.jankovic@gmail.com" target=3D"_blank">strahinja.p.jankovic@gmail.com<=
/a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software: you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation, either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + * You should have received a copy of the GNU General Public License<=
br>
&gt; + * along with this program.=C2=A0 If not, see &lt;<a href=3D"http://w=
ww.gnu.org/licenses/" rel=3D"noreferrer" target=3D"_blank">http://www.gnu.o=
rg/licenses/</a>&gt;.<br>
&gt; + */<br>
&gt; +<br>
&gt; +#ifndef HW_DISPLAY_ALLWINNER_A10_LCDC_H<br>
&gt; +#define HW_DISPLAY_ALLWINNER_A10_LCDC_H<br>
&gt; +<br>
&gt; +#include &quot;qom/object.h&quot;<br>
&gt; +#include &quot;hw/ptimer.h&quot;<br>
&gt; +#include &quot;hw/sysbus.h&quot;<br>
&gt; +#include &quot;ui/console.h&quot;<br>
&gt; +#include &quot;hw/display/allwinner-a10-debe.h&quot;<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @name Constants<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +/** Size of register I/O address space used by LCDC device */<br>
&gt; +#define AW_A10_LCDC_IOSIZE=C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x1000)<br>
&gt; +<br>
&gt; +/** Total number of known registers */<br>
&gt; +#define AW_A10_LCDC_REGS_NUM=C2=A0 =C2=A0 =C2=A0 (AW_A10_LCDC_IOSIZE =
/ sizeof(uint32_t))<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * @name Object model<br>
&gt; + * @{<br>
&gt; + */<br>
&gt; +<br>
&gt; +#define TYPE_AW_A10_LCDC=C2=A0 =C2=A0 &quot;allwinner-a10-lcdc&quot;<=
br>
&gt; +OBJECT_DECLARE_SIMPLE_TYPE(AwA10LcdcState, AW_A10_LCDC)<br>
&gt; +<br>
&gt; +/** @} */<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * Allwinner A10 LCDC object instance state.<br>
&gt; + */<br>
&gt; +struct AwA10LcdcState {<br>
&gt; +=C2=A0 =C2=A0 /*&lt; private &gt;*/<br>
&gt; +=C2=A0 =C2=A0 SysBusDevice parent_obj;<br>
&gt; +=C2=A0 =C2=A0 /*&lt; public &gt;*/<br>
&gt; +=C2=A0 =C2=A0 qemu_irq irq;<br>
&gt; +=C2=A0 =C2=A0 struct ptimer_state *timer;<br>
&gt; +=C2=A0 =C2=A0 QemuConsole *con;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 MemoryRegionSection fbsection;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int invalidate;<br>
&gt; +=C2=A0 =C2=A0 bool is_enabled;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 AwA10DEBEState *debe;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Maps I/O registers in physical memory */<br>
&gt; +=C2=A0 =C2=A0 MemoryRegion iomem;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /** Array of hardware registers */<br>
&gt; +=C2=A0 =C2=A0 uint32_t regs[AW_A10_LCDC_REGS_NUM];<br>
&gt; +};<br>
&gt; +<br>
&gt; +#endif /* HW_DISPLAY_ALLWINNER_A10_LCDC_H */<br>
<br>
</blockquote></div></div>

--00000000000085e6e70604dd4015--

