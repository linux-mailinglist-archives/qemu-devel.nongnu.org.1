Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BF57D7D91
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 09:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvujL-0005To-Gl; Thu, 26 Oct 2023 03:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvujI-0005TU-2f; Thu, 26 Oct 2023 03:24:32 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qvujF-0007Ay-FH; Thu, 26 Oct 2023 03:24:31 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4197fa36b6aso4500251cf.3; 
 Thu, 26 Oct 2023 00:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698305067; x=1698909867; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4IKgkow9KV1QDgpIYwoApam0Yih1r6UaSRebEEpnqI=;
 b=dYGSuqgHST0E5Mj/aKckPfF/rCkN/9yUNRsUJFfodRS4vYVZHxdIniM5UfqpP89xBc
 7ncLoGhjda0SkBa/sd/YuR2+xkweAYXUw24oh0XvoADaMbQc1OWMrmtkZU3pfuPfaGJ8
 wyhqcajtV2wZpIpdBEWsqrVfGQeIvLUHpf/a/N1eiyLf8Gl+mrA2iTTXZlt5fLuHrvij
 gPM4cOF40e8yTTQpHyq+OyjaM1a2wtuZvGWOPW2Iti2tfEEvWnNTcI1UikC+jaLPPYnm
 E2WGiO+brnaoJrwyBxPhsJQSFsj8kKB6jifEWnV3Fd8YTba3pFpwhhhtLnPA6nV1+AhZ
 kM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698305067; x=1698909867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4IKgkow9KV1QDgpIYwoApam0Yih1r6UaSRebEEpnqI=;
 b=fdDQIX/RHHBXTiHg56+dEI+rVVQnwpTuStE9kBnQi6YeFRQU6DoOtvsGThsrYmomSU
 vTk3ynfqOrl7YLA/6vMLxG+CZMtGRcgPNdzoIm/lseW6wwacQaeMercfPMg7JF0VrH+m
 KsxC27vqJ9WT2+sN+79d0jNQemm75a/XyFABzd/txIM2abJWF1AmrpMGDu2ItulkEzn4
 tX61TOqp2aHtlXY0b1XKSc2C9YuiF5sz6tHD0b8keSGm8vElzgrIHvZx/fE8OhCARhcg
 NIfzRZZ0hDw9zfgoJIsyCVf9ALP9FLHR6Cnn8+SMsXWPrYdYc0fPxu4lxPr6pubTTn8T
 FE1g==
X-Gm-Message-State: AOJu0Yz4Llg/HPmOQ3AzpGXOXtWGooJJ7wr16ltn0JAe9LnVHddTYVv2
 SrEsuVwZ1xoelv6cYMZNaIFoFJ8CyvsQWr/6ycw=
X-Google-Smtp-Source: AGHT+IFLXlNKpPdcFpC9bZhqqKv1hhEjwHRJ59/kCWVPtU6c1JGioXYkAW5vSGy5v06viqbYxlM50fRwa+SJNJqtGgc=
X-Received: by 2002:a05:622a:1305:b0:412:1fd7:dfa1 with SMTP id
 v5-20020a05622a130500b004121fd7dfa1mr18249402qtk.8.1698305067564; Thu, 26 Oct
 2023 00:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231025190818.3278423-1-marcandre.lureau@redhat.com>
 <20231025190818.3278423-13-marcandre.lureau@redhat.com>
 <151fc11c-df21-51e6-f12c-e926e8764dc4@eik.bme.hu>
In-Reply-To: <151fc11c-df21-51e6-f12c-e926e8764dc4@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 26 Oct 2023 11:24:15 +0400
Message-ID: <CAJ+F1CLGsqapfed+Mnk2bYzWRqraUMBCAdRRkZTqKg2P9sLpGQ@mail.gmail.com>
Subject: Re: [PATCH v6 12/23] virtio-gpu: replace PIXMAN for region/rect test
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x829.google.com
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

On Thu, Oct 26, 2023 at 12:55=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu=
> wrote:
>
> On Wed, 25 Oct 2023, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Use a simpler implementation for rectangle geometry & intersect, drop
> > the need for (more complex) PIXMAN functions.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> > include/ui/rect.h       | 59 +++++++++++++++++++++++++++++++++++++++++
> > hw/display/virtio-gpu.c | 30 ++++++++-------------
> > 2 files changed, 70 insertions(+), 19 deletions(-)
> > create mode 100644 include/ui/rect.h
> >
> > diff --git a/include/ui/rect.h b/include/ui/rect.h
> > new file mode 100644
> > index 0000000000..94898f92d0
> > --- /dev/null
> > +++ b/include/ui/rect.h
> > @@ -0,0 +1,59 @@
> > +/*
> > + * SPDX-License-Identifier: GPL-2.0-or-later
> > + */
> > +#ifndef QEMU_RECT_H
> > +#define QEMU_RECT_H
> > +
> > +#include <stdint.h>
> > +#include <stdbool.h>
> > +
> > +typedef struct QemuRect {
> > +    int16_t x;
> > +    int16_t y;
> > +    uint16_t width;
> > +    uint16_t height;
> > +} QemuRect;
> > +
> > +static inline void qemu_rect_init(QemuRect *rect,
> > +                                  int16_t x, int16_t y,
> > +                                  uint16_t width, uint16_t height)
> > +{
> > +    rect->x =3D x;
> > +    rect->y =3D x;
> > +    rect->width =3D width;
> > +    rect->height =3D height;
> > +}
> > +
> > +static inline void qemu_rect_translate(QemuRect *rect,
> > +                                       int16_t dx, int16_t dy)
> > +{
> > +    rect->x +=3D dx;
> > +    rect->y +=3D dy;
> > +}
> > +
> > +static inline bool qemu_rect_intersect(const QemuRect *a, const QemuRe=
ct *b,
> > +                                       QemuRect *res)
> > +{
> > +    int16_t x1, x2, y1, y2;
> > +
> > +    x1 =3D MAX(a->x, b->x);
> > +    y1 =3D MAX(a->y, b->y);
> > +    x2 =3D MIN(a->x + a->width, b->x + b->width);
> > +    y2 =3D MIN(a->y + a->height, b->y + b->height);
> > +
> > +    if (x1 >=3D x2 || y1 >=3D y2) {
> > +        if (res) {
> > +            qemu_rect_init(res, 0, 0, 0, 0);
> > +        }
> > +
> > +        return false;
> > +    }
> > +
> > +    if (res) {
> > +        qemu_rect_init(res, x1, y1, x2 - x1, y2 - y1);
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +#endif
>
> Maybe you could move these to pixman-minimal.h as well implementing the
> missing pixman_region funcs so no need to change the callers? But I don't
> mind either way.
>

The pixman region functions are more complex than what we actually
need in QEMU (simple rectangle geometry).

> Regards,
> BALATON Zoltan
>
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 4265316cbb..a8e767245f 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -16,6 +16,7 @@
> > #include "qemu/iov.h"
> > #include "sysemu/cpus.h"
> > #include "ui/console.h"
> > +#include "ui/rect.h"
> > #include "trace.h"
> > #include "sysemu/dma.h"
> > #include "sysemu/sysemu.h"
> > @@ -503,7 +504,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
> >     struct virtio_gpu_simple_resource *res;
> >     struct virtio_gpu_resource_flush rf;
> >     struct virtio_gpu_scanout *scanout;
> > -    pixman_region16_t flush_region;
> > +    QemuRect flush_rect;
> >     bool within_bounds =3D false;
> >     bool update_submitted =3D false;
> >     int i;
> > @@ -565,34 +566,25 @@ static void virtio_gpu_resource_flush(VirtIOGPU *=
g,
> >         return;
> >     }
> >
> > -    pixman_region_init_rect(&flush_region,
> > -                            rf.r.x, rf.r.y, rf.r.width, rf.r.height);
> > +    qemu_rect_init(&flush_rect, rf.r.x, rf.r.y, rf.r.width, rf.r.heigh=
t);
> >     for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > -        pixman_region16_t region, finalregion;
> > -        pixman_box16_t *extents;
> > +        QemuRect rect;
> >
> >         if (!(res->scanout_bitmask & (1 << i))) {
> >             continue;
> >         }
> >         scanout =3D &g->parent_obj.scanout[i];
> >
> > -        pixman_region_init(&finalregion);
> > -        pixman_region_init_rect(&region, scanout->x, scanout->y,
> > -                                scanout->width, scanout->height);
> > +        qemu_rect_init(&rect, scanout->x, scanout->y,
> > +                       scanout->width, scanout->height);
> >
> > -        pixman_region_intersect(&finalregion, &flush_region, &region);
> > -        pixman_region_translate(&finalregion, -scanout->x, -scanout->y=
);
> > -        extents =3D pixman_region_extents(&finalregion);
> >         /* work out the area we need to update for each console */
> > -        dpy_gfx_update(g->parent_obj.scanout[i].con,
> > -                       extents->x1, extents->y1,
> > -                       extents->x2 - extents->x1,
> > -                       extents->y2 - extents->y1);
> > -
> > -        pixman_region_fini(&region);
> > -        pixman_region_fini(&finalregion);
> > +        if (qemu_rect_intersect(&flush_rect, &rect, &rect)) {
> > +            qemu_rect_translate(&rect, -scanout->x, -scanout->y);
> > +            dpy_gfx_update(g->parent_obj.scanout[i].con,
> > +                           rect.x, rect.y, rect.width, rect.height);
> > +        }
> >     }
> > -    pixman_region_fini(&flush_region);
> > }
> >
> > static void virtio_unref_resource(pixman_image_t *image, void *data)
> >



--=20
Marc-Andr=C3=A9 Lureau

