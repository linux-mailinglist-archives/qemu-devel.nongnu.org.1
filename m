Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D57E35DE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 08:26:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0GTl-0007Vt-Dd; Tue, 07 Nov 2023 02:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0GTT-00077M-DI
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:26:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0GTR-0003zj-Hl
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 02:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699341966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J8N9o6dzA5Gb2UtLvsNEvNbsE5b2WLMiZRQ71j+TzWQ=;
 b=a6ohsfpfIY+2pMCWH7GpK/TzZyMr67E3GlASzMyXs5GyU+6A/5d2t6mhrrPLX5z+s8/5mW
 O28/1F/8sUi5A5bvMx7tsJge6t96LLxfjnY+cpVUCGeLR/K2wmX/ga06Ghggm9NSwU7vHW
 pJ90U9lRcVVYwXXuTdX7BAUnZRveGLA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-SfvqRXflPF6JNk7VdKjHuw-1; Tue, 07 Nov 2023 02:25:54 -0500
X-MC-Unique: SfvqRXflPF6JNk7VdKjHuw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-53da5262466so4590921a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 23:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699341952; x=1699946752;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8N9o6dzA5Gb2UtLvsNEvNbsE5b2WLMiZRQ71j+TzWQ=;
 b=VH5p8pogTAH7CRyvbvMlVE215Jjrl4khl6DvCsPg+VGLz0abEpCIAWzQZREu+QkQ32
 2bkLavF9+QLjYPa36Cf0YLuxSQMqDyn2m1qzT/c7ocXPHz5pEB+ymouzOtAtY7ruiNwi
 8BzQ4C0GfMlHnPtb9+S5cVNkfwDHQ1tIg9Mi+V/MDGnwruAqtWkhIkH9GBKh/e+NoCGQ
 he+M+9noqdAcdOo0xSpXd6SLpWuEYvnmpZZDB8bO93RBWS3IQUQ/9FjnmSkp1rfsyMVH
 8lhbr/8iLlK6Zjtsdmo+XS8c0vlzK3KQcVpGsx1LSA15cpyHn+heBdXtEH9gAePj5CKd
 E0nQ==
X-Gm-Message-State: AOJu0YwToCMzu0A2ibr25uRKQosLze0TKm0HmeQ4EMQBe0hlaPu5D5fc
 eTeEeED95IlswefnDWPfzyOF6WAqaWko/17CNuLtyHK0zSEExuUPVhU4NmZxjVfLtpS08IUADUK
 ZpbtG0alkGezVqEW8eNlmOEHauVVlHHQpQw1IOyo=
X-Received: by 2002:a50:931e:0:b0:543:4fca:cc91 with SMTP id
 m30-20020a50931e000000b005434fcacc91mr18387086eda.20.1699341952256; 
 Mon, 06 Nov 2023 23:25:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlFwrRxlSnvqV/rmOogdSIE4zD+jzHPLOpGOYd8AIrgBgymcX9PS+UqrhyxX43x+8WGPf/Ir0negKL6omJcr0=
X-Received: by 2002:a50:931e:0:b0:543:4fca:cc91 with SMTP id
 m30-20020a50931e000000b005434fcacc91mr18387074eda.20.1699341951979; Mon, 06
 Nov 2023 23:25:51 -0800 (PST)
MIME-Version: 1.0
References: <20231107071915.2459115-1-marcandre.lureau@redhat.com>
 <20231107071915.2459115-24-marcandre.lureau@redhat.com>
In-Reply-To: <20231107071915.2459115-24-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Nov 2023 11:25:40 +0400
Message-ID: <CAMxuvaw+bvJKcCt1JBQpR3sPA-qr5W+qA-s6YoCv8etjPgc3nA@mail.gmail.com>
Subject: Re: [PATCH v8 23/24] hw/display/ati: allow compiling without PIXMAN
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
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

HI Zoltan

On Tue, Nov 7, 2023 at 11:21=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Change the "x-pixman" property default value and use the fallback path
> when PIXMAN support is disabled.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

please review today :) thanks

> ---
>  hw/display/ati.c       | 16 +++++++++++++++-
>  hw/display/ati_2d.c    | 11 +++++++----
>  hw/display/meson.build |  2 +-
>  3 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 9a87a5504a..51a3b156ac 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -32,6 +32,13 @@
>
>  #define ATI_DEBUG_HW_CURSOR 0
>
> +#ifdef CONFIG_PIXMAN
> +#define DEFAULT_X_PIXMAN 3
> +#else
> +#define DEFAULT_X_PIXMAN 0
> +#endif
> +
> +
>  static const struct {
>      const char *name;
>      uint16_t dev_id;
> @@ -946,6 +953,12 @@ static void ati_vga_realize(PCIDevice *dev, Error **=
errp)
>      ATIVGAState *s =3D ATI_VGA(dev);
>      VGACommonState *vga =3D &s->vga;
>
> +#ifndef CONFIG_PIXMAN
> +    if (s->use_pixman !=3D 0) {
> +        warn_report("x-pixman !=3D 0, not effective without PIXMAN");
> +    }
> +#endif
> +
>      if (s->model) {
>          int i;
>          for (i =3D 0; i < ARRAY_SIZE(ati_model_aliases); i++) {
> @@ -1033,7 +1046,8 @@ static Property ati_vga_properties[] =3D {
>      DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
>                         PCI_DEVICE_ID_ATI_RAGE128_PF),
>      DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, f=
alse),
> -    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
> +    /* this a debug option, prefer PROP_UINT over PROP_BIT for simplicit=
y */
> +    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, DEFAULT_X_PIX=
MAN),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 0e6b8e4367..e58acd0802 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -92,7 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
>      switch (s->regs.dp_mix & GMC_ROP3_MASK) {
>      case ROP3_SRCCOPY:
>      {
> -        bool fallback =3D false;
> +        bool fallback =3D true;
>          unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                         s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_w=
idth);
>          unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> @@ -119,6 +119,7 @@ void ati_2d_blt(ATIVGAState *s)
>
>          src_stride /=3D sizeof(uint32_t);
>          dst_stride /=3D sizeof(uint32_t);
> +#ifdef CONFIG_PIXMAN
>          DPRINTF("pixman_blt(%p, %p, %d, %d, %d, %d, %d, %d, %d, %d, %d, =
%d)\n",
>                  src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
>                  src_x, src_y, dst_x, dst_y,
> @@ -147,9 +148,8 @@ void ati_2d_blt(ATIVGAState *s)
>                                         s->regs.dst_width, s->regs.dst_he=
ight);
>              }
>              g_free(tmp);
> -        } else {
> -            fallback =3D true;
>          }
> +#endif
>          if (fallback) {
>              unsigned int y, i, j, bypp =3D bpp / 8;
>              unsigned int src_pitch =3D src_stride * sizeof(uint32_t);
> @@ -203,12 +203,15 @@ void ati_2d_blt(ATIVGAState *s)
>          }
>
>          dst_stride /=3D sizeof(uint32_t);
> +#ifdef CONFIG_PIXMAN
>          DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
>                  dst_bits, dst_stride, bpp, dst_x, dst_y,
>                  s->regs.dst_width, s->regs.dst_height, filler);
>          if (!(s->use_pixman & BIT(0)) ||
>              !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, d=
st_y,
> -                    s->regs.dst_width, s->regs.dst_height, filler)) {
> +                    s->regs.dst_width, s->regs.dst_height, filler))
> +#endif
> +        {
>              /* fallback when pixman failed or we don't want to call it *=
/
>              unsigned int x, y, i, bypp =3D bpp / 8;
>              unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t);
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 9c06aaee20..344dfe3d8c 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true:=
 files('xlnx_dp.c'))
>
>  system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>
> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', =
'ati_2d.c', 'ati_dbg.c'))
> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c=
', 'ati_dbg.c'), pixman])
>
>
>  if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> --
> 2.41.0
>


