Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B37D78D583
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 13:24:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbJIj-0006BK-FV; Wed, 30 Aug 2023 07:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qbJIa-0006Am-IX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:23:49 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qbJIX-0006gQ-BM
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 07:23:48 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso5120737276.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693394623; x=1693999423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LtAfDI2ZgovRG4eywtJRoUXa+4rrAQaw44bUsY7tSXg=;
 b=NOy4b3RoACXmKdWXEaQMYJQHVB/T+wAdQKoHFgzU5biQS6nUGAEw+unei/fGS8/LgA
 upuMg5FCCUKRkHN8anXcIlvVg2ePhYCBTYrYciACaJoExD6MjLVD8hw6FfX4qdZVeDYk
 8/NXumEv/WyoCIqh8uCa/F0yUxhBS4uJ1LmeXLaXe6B9EzfBSfaPDcZ9VQisHzfYnvbY
 yFGQPKqlO0vqdGizO0ZLiRqy6B3o0ehshYatwGKOBGdR2DfbcJeS6pKrdXWvC3RH2Ra0
 q6HZ8FPaW1WSXKCSIjwOanuj+KCFu0IgpL0Jci4TPb9SnsGY/VcMrob9npHFmOovyiXF
 la9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693394623; x=1693999423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LtAfDI2ZgovRG4eywtJRoUXa+4rrAQaw44bUsY7tSXg=;
 b=PjLudDT0iiYN1TcqE4NhBBPx74klEjyQoSA1Vi0TDjBeuhmMeyJypzos2+72PhlpUE
 PNygjLKKj1l2mIzRKqr673y9Dxv3pvw8xp9/BFMGjonlw4ML4d3PKc5Hp3Hkn0zZIGFc
 msfR1Rv0QhgQKBq0vthfPmaaa4dtR2Vyw+1W+XOKB9LKMemWOSWAinv5wHBxtH23n64n
 LOKk34/kioeC2qINzGYoY4D9fGQZmuMIN6uVPn9N6C8HZpMcH0x96pM2DjG4MrtIwZOW
 PUnIOkwz1/0z0BzQa5Lu+ItoCiWir3mef1DPpXIohZzP+RJC9STVUt5/jKWSUvj2oL7K
 vFlQ==
X-Gm-Message-State: AOJu0YwIgoJyFrJwKGFEC/c4cFcIZciTRzLsjnP2kH7HydENKcMz5npY
 mj6gz/mBlyYmg43ch6CzYvR3Bnfifs4hGilcL4I=
X-Google-Smtp-Source: AGHT+IFTb7UDlTJZ4RRBrQc3HBsMznq7Rzf0/RC9QNRx66yEN+6Hb1h62rUy29ichvuKVzxSo5+TGF6773Y2L7lLmUU=
X-Received: by 2002:a25:d48d:0:b0:d00:cc5b:8a9f with SMTP id
 m135-20020a25d48d000000b00d00cc5b8a9fmr2065976ybf.16.1693394623444; Wed, 30
 Aug 2023 04:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-54-marcandre.lureau@redhat.com>
 <ZO8lMuOzsjfj+Atd@redhat.com>
In-Reply-To: <ZO8lMuOzsjfj+Atd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 30 Aug 2023 15:23:31 +0400
Message-ID: <CAJ+F1CJ9jwCVMyObV9ipx4c3_1uShuCqO5=tU6eYLdLYxZcuZA@mail.gmail.com>
Subject: Re: [PATCH 53/67] ui: add pixman-compat.h
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb2a.google.com
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

On Wed, Aug 30, 2023 at 3:17=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:27PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > This is a tiny subset of PIXMAN API that is used pervasively in QEMU
> > codebase to manage images and identify the underlying format.
> >
> > It doesn't seems worth to wrap this in a QEMU-specific API.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/ui/pixman-compat.h | 190 +++++++++++++++++++++++++++++++++++++
> >  include/ui/qemu-pixman.h   |   4 +
> >  2 files changed, 194 insertions(+)
> >  create mode 100644 include/ui/pixman-compat.h
>
> This patch is what makes me feel the end state of this series
> is somewhat dubious.  This pixman-compat.h shows we clearly
> still need the pixman APIs, and trying to make pixman optional
> is causing us to re-invent a part of pixman via copy+paste.
> I don't find this very appealing.

It's very limited though, as that compat doesn't offer any pixel manipulati=
on.

>
> If it is possible to disable the build of parts of QEMU such
> that what remains compiled does not require pixman at all,
> that is reasonable.

I am afraid this leads to x10 of #ifdef if we follow that path. I was
personally disgusted: not only it was getting horrible to deal with,
but it makes you wonder what can be kept or not with embarrassing
questions and behaviours. This compat approach is way saner and
simpler. As can be seen, this is a fraction of the API, just to wrap
the bits and define the formats. It's ridiculously small imho to keep
most of QEMU code still work.

>
> Keeping building stuff that actually wants pixman, via a
> compat API is imposing a burden on QEMU without a compelling
> gain IMHO.
>
> >
> > diff --git a/include/ui/pixman-compat.h b/include/ui/pixman-compat.h
> > new file mode 100644
> > index 0000000000..e511c8b946
> > --- /dev/null
> > +++ b/include/ui/pixman-compat.h
> > @@ -0,0 +1,190 @@
> > +/*
> > + * SPDX-License-Identifier: MIT
> > + *
> > + * Tiny subset of PIXMAN API commonly used by QEMU.
> > + *
> > + * Copyright 1987, 1988, 1989, 1998  The Open Group
> > + * Copyright 1987, 1988, 1989 Digital Equipment Corporation
> > + * Copyright 1999, 2004, 2008 Keith Packard
> > + * Copyright 2000 SuSE, Inc.
> > + * Copyright 2000 Keith Packard, member of The XFree86 Project, Inc.
> > + * Copyright 2004, 2005, 2007, 2008, 2009, 2010 Red Hat, Inc.
> > + * Copyright 2004 Nicholas Miell
> > + * Copyright 2005 Lars Knoll & Zack Rusin, Trolltech
> > + * Copyright 2005 Trolltech AS
> > + * Copyright 2007 Luca Barbato
> > + * Copyright 2008 Aaron Plattner, NVIDIA Corporation
> > + * Copyright 2008 Rodrigo Kumpera
> > + * Copyright 2008 Andr=C3=A9 Tupinamb=C3=A1
> > + * Copyright 2008 Mozilla Corporation
> > + * Copyright 2008 Frederic Plourde
> > + * Copyright 2009, Oracle and/or its affiliates. All rights reserved.
> > + * Copyright 2009, 2010 Nokia Corporation
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaini=
ng a
> > + * copy of this software and associated documentation files (the "Soft=
ware"),
> > + * to deal in the Software without restriction, including without limi=
tation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,
> > + * and/or sell copies of the Software, and to permit persons to whom t=
he
> > + * Software is furnished to do so, subject to the following conditions=
:
> > + *
> > + * The above copyright notice and this permission notice (including th=
e next
> > + * paragraph) shall be included in all copies or substantial portions =
of the
> > + * Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT =
SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING
> > + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
> > + * DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#ifndef PIXMAN_COMPAT_H
> > +#define PIXMAN_COMPAT_H
> > +
> > +#define PIXMAN_TYPE_OTHER       0
> > +#define PIXMAN_TYPE_ARGB        2
> > +#define PIXMAN_TYPE_ABGR        3
> > +#define PIXMAN_TYPE_BGRA        8
> > +#define PIXMAN_TYPE_RGBA        9
> > +
> > +#define PIXMAN_FORMAT(bpp,type,a,r,g,b) (((bpp) << 24) |  \
> > +                                         ((type) << 16) | \
> > +                                         ((a) << 12) |    \
> > +                                         ((r) << 8) |     \
> > +                                         ((g) << 4) |     \
> > +                                         ((b)))
> > +
> > +#define PIXMAN_FORMAT_RESHIFT(val, ofs, num)                          =
  \
> > +        (((val >> (ofs)) & ((1 << (num)) - 1)) << ((val >> 22) & 3))
> > +
> > +#define PIXMAN_FORMAT_BPP(f)    PIXMAN_FORMAT_RESHIFT(f, 24, 8)
> > +#define PIXMAN_FORMAT_TYPE(f)   (((f) >> 16) & 0x3f)
> > +#define PIXMAN_FORMAT_A(f)      PIXMAN_FORMAT_RESHIFT(f, 12, 4)
> > +#define PIXMAN_FORMAT_R(f)      PIXMAN_FORMAT_RESHIFT(f, 8, 4)
> > +#define PIXMAN_FORMAT_G(f)      PIXMAN_FORMAT_RESHIFT(f, 4, 4)
> > +#define PIXMAN_FORMAT_B(f)      PIXMAN_FORMAT_RESHIFT(f, 0, 4)
> > +#define PIXMAN_FORMAT_DEPTH(f)  (PIXMAN_FORMAT_A(f) +   \
> > +                                 PIXMAN_FORMAT_R(f) +   \
> > +                                 PIXMAN_FORMAT_G(f) +   \
> > +                                 PIXMAN_FORMAT_B(f))
> > +
> > +typedef enum {
> > +    /* 32bpp formats */
> > +    PIXMAN_a8r8g8b8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_ARGB,8,8,8,8),
> > +    PIXMAN_x8r8g8b8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_ARGB,0,8,8,8),
> > +    PIXMAN_a8b8g8r8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_ABGR,8,8,8,8),
> > +    PIXMAN_x8b8g8r8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_ABGR,0,8,8,8),
> > +    PIXMAN_b8g8r8a8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_BGRA,8,8,8,8),
> > +    PIXMAN_b8g8r8x8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_BGRA,0,8,8,8),
> > +    PIXMAN_r8g8b8a8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_RGBA,8,8,8,8),
> > +    PIXMAN_r8g8b8x8 =3D    PIXMAN_FORMAT(32,PIXMAN_TYPE_RGBA,0,8,8,8),
> > +    /* 24bpp formats */
> > +    PIXMAN_r8g8b8 =3D      PIXMAN_FORMAT(24,PIXMAN_TYPE_ARGB,0,8,8,8),
> > +    PIXMAN_b8g8r8 =3D      PIXMAN_FORMAT(24,PIXMAN_TYPE_ABGR,0,8,8,8),
> > +    /* 16bpp formats */
> > +    PIXMAN_r5g6b5 =3D      PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,0,5,6,5),
> > +    PIXMAN_a1r5g5b5 =3D    PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,1,5,5,5),
> > +    PIXMAN_x1r5g5b5 =3D    PIXMAN_FORMAT(16,PIXMAN_TYPE_ARGB,0,5,5,5),
> > +} pixman_format_code_t;
> > +
> > +typedef struct pixman_image pixman_image_t;
> > +
> > +typedef void (* pixman_image_destroy_func_t)(pixman_image_t *image, vo=
id *data);
> > +
> > +struct pixman_image {
> > +    int ref_count;
> > +    pixman_format_code_t format;
> > +    int width;
> > +    int height;
> > +    int stride;
> > +    uint8_t *data;
> > +    pixman_image_destroy_func_t destroy_func;
> > +    void *destroy_data;
> > +};
> > +
> > +typedef struct pixman_color {
> > +    uint16_t    red;
> > +    uint16_t    green;
> > +    uint16_t    blue;
> > +    uint16_t    alpha;
> > +} pixman_color_t;
> > +
> > +static inline pixman_image_t *pixman_image_create_bits(pixman_format_c=
ode_t format,
> > +                                                       int width,
> > +                                                       int height,
> > +                                                       uint32_t *bits,
> > +                                                       int rowstride_b=
ytes)
> > +{
> > +    pixman_image_t *i =3D g_new0(pixman_image_t, 1);
> > +
> > +    i->width =3D width;
> > +    i->height =3D height;
> > +    i->stride =3D rowstride_bytes ?: width * DIV_ROUND_UP(PIXMAN_FORMA=
T_BPP(format), 8);
> > +    i->format =3D format;
> > +    i->data =3D bits ?: g_malloc0(rowstride_bytes * height);
> > +    i->ref_count =3D 1;
> > +
> > +    return i;
> > +}
> > +
> > +static inline pixman_image_t *pixman_image_ref(pixman_image_t *i)
> > +{
> > +    i->ref_count++;
> > +    return i;
> > +}
> > +
> > +static inline bool pixman_image_unref(pixman_image_t *i)
> > +{
> > +    i->ref_count--;
> > +
> > +    if (i->ref_count =3D=3D 0) {
> > +        if (i->destroy_func) {
> > +            i->destroy_func (i, i->destroy_data);
> > +            g_free(i->data);
> > +            g_free(i);
> > +        }
> > +
> > +        return true;
> > +    }
> > +
> > +    return false;
> > +}
> > +
> > +static inline void pixman_image_set_destroy_function(pixman_image_t *i=
,
> > +                                                     pixman_image_dest=
roy_func_t func,
> > +                                                     void *data)
> > +
> > +{
> > +    i->destroy_func =3D func;
> > +    i->destroy_data =3D data;
> > +}
> > +
> > +static inline uint8_t* pixman_image_get_data(pixman_image_t *i)
> > +{
> > +    return i->data;
> > +}
> > +
> > +static inline int pixman_image_get_height(pixman_image_t *i)
> > +{
> > +    return i->height;
> > +}
> > +
> > +static inline int pixman_image_get_width(pixman_image_t *i)
> > +{
> > +    return i->width;
> > +}
> > +
> > +static inline int pixman_image_get_stride(pixman_image_t *i)
> > +{
> > +    return i->stride;
> > +}
> > +
> > +static inline pixman_format_code_t pixman_image_get_format(pixman_imag=
e_t *i)
> > +{
> > +    return i->format;
> > +}
> > +
> > +#endif /* PIXMAN_COMPAT_H */
> > diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> > index c5a0911cc7..9c693df8dd 100644
> > --- a/include/ui/qemu-pixman.h
> > +++ b/include/ui/qemu-pixman.h
> > @@ -6,11 +6,15 @@
> >  #ifndef QEMU_PIXMAN_H
> >  #define QEMU_PIXMAN_H
> >
> > +#ifdef CONFIG_PIXMAN
> >  /* pixman-0.16.0 headers have a redundant declaration */
> >  #pragma GCC diagnostic push
> >  #pragma GCC diagnostic ignored "-Wredundant-decls"
> >  #include <pixman.h>
> >  #pragma GCC diagnostic pop
> > +#else
> > +#include "pixman-compat.h"
> > +#endif
> >
> >  /*
> >   * pixman image formats are defined to be native endian,
> > --
> > 2.41.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

