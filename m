Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D58787E1EAA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzx38-0003Bk-JP; Mon, 06 Nov 2023 05:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzx2y-00036D-KN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:41:33 -0500
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzx2u-00087x-CU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:41:32 -0500
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-77a277eb084so285940285a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699267287; x=1699872087; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2iTzN6wcC0yCQTPhKuHRghFzkPe5Y7kdT2jph/a5rRU=;
 b=mfxJ1ljeWjKijgxRJJz3+gefhQ5m44MJZjyVQ9XuFVsxZ93anMZ8AWG1CV/ghePOkW
 acM//p5A0kO8rbYjFCI6pqmUpxwdTFHUb1k69VGapl7RH8hr826YRvtMXfyP8U8/90+6
 aKF/v68ESqStwDyCGUT/IPKnWN8hTFJVegMsPkwla9B8zhFH79NLp4h9TSFC00+xLQac
 0w30lAjfOy6VCONNxry1ZQDtG6y4aPz0NoOLzK/GJhW7S4X1fsK79bQVCsNcA2klpk2O
 vCEjTaMbodMLCboSWmWXE67V30fD3NidRBX4jUguS1kZxpopEJ5sX+UuL3pl4TrJzhst
 ZDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699267287; x=1699872087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2iTzN6wcC0yCQTPhKuHRghFzkPe5Y7kdT2jph/a5rRU=;
 b=eT+o9Ad/yeISfC9PCEuN/+0jeH/S5gDsivckZxLKigzPzpu/FxjQdit5292E+gHWwC
 F+EN8FAANzEykl7uidvQY0PbIInz8UTFiUbFE5b6weXLPqv/CWlSfgHO1bq3kvH8WkGj
 gAsjZMylEXHyz151JoxV+H1sjpeRVF9gmahIR8GgUBrUauNmR7ks9m3eYqQMs4hYHr68
 CuZPIHf34697fEVF7tvMEoUK6vLPr9WMT5X39DTwNWxAxjRvj+S2O9N7g0q6hIWAuzzm
 zNK+NEk0TxYePSzB1/DAlfXgIW6FbpKeUCxVPNN/1lF6Sqjxo3YRYSsfqjm+GTl7DbZF
 ZPKA==
X-Gm-Message-State: AOJu0YxXnOpXVcObPQwjeGzOqekVECsc4HJOWsDwS96416WgfF+ZboCr
 PaPbPGR+NUbrNdGCaBvvpVhQWvFemqmA0e6ANJI=
X-Google-Smtp-Source: AGHT+IGO6aiwsaZP3OP65bWZ3kLkU0eHzsig2j+peV1YbJJZrjEm5sQlJcp1OA+F49W0W7uuYUF/9eqItCoK5yHirdM=
X-Received: by 2002:a05:622a:345:b0:41e:173e:82b7 with SMTP id
 r5-20020a05622a034500b0041e173e82b7mr32214812qtw.66.1699267286804; Mon, 06
 Nov 2023 02:41:26 -0800 (PST)
MIME-Version: 1.0
References: <cover.1698871239.git.balaton@eik.bme.hu>
 <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
In-Reply-To: <ed0fba3f74e48143f02228b83bf8796ca49f3e7d.1698871239.git.balaton@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 14:41:15 +0400
Message-ID: <CAJ+F1CJx=dnLOO9QsjBVb9WHH1L1sBpfM8MqKPUZ+mAitCjWSA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ati-vga: Implement fallback for pixman routines
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::735;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x735.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Thu, Nov 2, 2023 at 12:46=E2=80=AFAM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> Pixman routines can fail if no implementation is available and it will
> become optional soon so add fallbacks when pixman does not work.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c     |  8 +++++
>  hw/display/ati_2d.c  | 75 +++++++++++++++++++++++++++++++-------------
>  hw/display/ati_int.h |  1 +
>  3 files changed, 62 insertions(+), 22 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index 5e38d2c3de..f911fbc327 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -1047,6 +1047,7 @@ static Property ati_vga_properties[] =3D {
>      DEFINE_PROP_UINT16("x-device-id", ATIVGAState, dev_id,
>                         PCI_DEVICE_ID_ATI_RAGE128_PF),
>      DEFINE_PROP_BOOL("guest_hwcursor", ATIVGAState, cursor_guest_mode, f=
alse),
> +    DEFINE_PROP_UINT8("x-pixman", ATIVGAState, use_pixman, 3),
>      DEFINE_PROP_END_OF_LIST()
>  };
>
> @@ -1068,11 +1069,18 @@ static void ati_vga_class_init(ObjectClass *klass=
, void *data)
>      k->exit =3D ati_vga_exit;
>  }
>
> +static void ati_vga_init(Object *o)
> +{
> +    object_property_set_description(o, "x-pixman", "Use pixman for: "
> +                                    "1: fill, 2: blit");
> +}
> +
>  static const TypeInfo ati_vga_info =3D {
>      .name =3D TYPE_ATI_VGA,
>      .parent =3D TYPE_PCI_DEVICE,
>      .instance_size =3D sizeof(ATIVGAState),
>      .class_init =3D ati_vga_class_init,
> +    .instance_init =3D ati_vga_init,
>      .interfaces =3D (InterfaceInfo[]) {
>            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>            { },
> diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
> index 7d786653e8..0e6b8e4367 100644
> --- a/hw/display/ati_2d.c
> +++ b/hw/display/ati_2d.c
> @@ -92,6 +92,7 @@ void ati_2d_blt(ATIVGAState *s)
>      switch (s->regs.dp_mix & GMC_ROP3_MASK) {
>      case ROP3_SRCCOPY:
>      {
> +        bool fallback =3D false;
>          unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
>                         s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_w=
idth);
>          unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
> @@ -122,27 +123,50 @@ void ati_2d_blt(ATIVGAState *s)
>                  src_bits, dst_bits, src_stride, dst_stride, bpp, bpp,
>                  src_x, src_y, dst_x, dst_y,
>                  s->regs.dst_width, s->regs.dst_height);
> -        if (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
> +        if ((s->use_pixman & BIT(1)) &&
> +            s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT &&
>              s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> -            pixman_blt((uint32_t *)src_bits, (uint32_t *)dst_bits,
> -                       src_stride, dst_stride, bpp, bpp,
> -                       src_x, src_y, dst_x, dst_y,
> -                       s->regs.dst_width, s->regs.dst_height);
> -        } else {
> +            fallback =3D !pixman_blt((uint32_t *)src_bits, (uint32_t *)d=
st_bits,
> +                                   src_stride, dst_stride, bpp, bpp,
> +                                   src_x, src_y, dst_x, dst_y,
> +                                   s->regs.dst_width, s->regs.dst_height=
);
> +        } else if (s->use_pixman & BIT(1)) {
>              /* FIXME: We only really need a temporary if src and dst ove=
rlap */
>              int llb =3D s->regs.dst_width * (bpp / 8);
>              int tmp_stride =3D DIV_ROUND_UP(llb, sizeof(uint32_t));
>              uint32_t *tmp =3D g_malloc(tmp_stride * sizeof(uint32_t) *
>                                       s->regs.dst_height);
> -            pixman_blt((uint32_t *)src_bits, tmp,
> -                       src_stride, tmp_stride, bpp, bpp,
> -                       src_x, src_y, 0, 0,
> -                       s->regs.dst_width, s->regs.dst_height);
> -            pixman_blt(tmp, (uint32_t *)dst_bits,
> -                       tmp_stride, dst_stride, bpp, bpp,
> -                       0, 0, dst_x, dst_y,
> -                       s->regs.dst_width, s->regs.dst_height);
> +            fallback =3D !pixman_blt((uint32_t *)src_bits, tmp,
> +                                   src_stride, tmp_stride, bpp, bpp,
> +                                   src_x, src_y, 0, 0,
> +                                   s->regs.dst_width, s->regs.dst_height=
);
> +            if (!fallback) {
> +                fallback =3D !pixman_blt(tmp, (uint32_t *)dst_bits,
> +                                       tmp_stride, dst_stride, bpp, bpp,
> +                                       0, 0, dst_x, dst_y,
> +                                       s->regs.dst_width, s->regs.dst_he=
ight);
> +            }
>              g_free(tmp);
> +        } else {
> +            fallback =3D true;
> +        }
> +        if (fallback) {
> +            unsigned int y, i, j, bypp =3D bpp / 8;
> +            unsigned int src_pitch =3D src_stride * sizeof(uint32_t);
> +            unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t);
> +
> +            for (y =3D 0; y < s->regs.dst_height; y++) {
> +                i =3D dst_x * bypp;
> +                j =3D src_x * bypp;
> +                if (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM) {
> +                    i +=3D (dst_y + y) * dst_pitch;
> +                    j +=3D (src_y + y) * src_pitch;
> +                } else {
> +                    i +=3D (dst_y + s->regs.dst_height - 1 - y) * dst_pi=
tch;
> +                    j +=3D (src_y + s->regs.dst_height - 1 - y) * src_pi=
tch;
> +                }
> +                memmove(&dst_bits[i], &src_bits[j], s->regs.dst_width * =
bypp);

This doesn't seem to handle overlapping regions the same as the
pixman-version. Or am I missing something?

> +            }
>          }
>          if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &&
>              dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
> @@ -180,14 +204,21 @@ void ati_2d_blt(ATIVGAState *s)
>
>          dst_stride /=3D sizeof(uint32_t);
>          DPRINTF("pixman_fill(%p, %d, %d, %d, %d, %d, %d, %x)\n",
> -                dst_bits, dst_stride, bpp,
> -                dst_x, dst_y,
> -                s->regs.dst_width, s->regs.dst_height,
> -                filler);
> -        pixman_fill((uint32_t *)dst_bits, dst_stride, bpp,
> -                    dst_x, dst_y,
> -                    s->regs.dst_width, s->regs.dst_height,
> -                    filler);
> +                dst_bits, dst_stride, bpp, dst_x, dst_y,
> +                s->regs.dst_width, s->regs.dst_height, filler);
> +        if (!(s->use_pixman & BIT(0)) ||
> +            !pixman_fill((uint32_t *)dst_bits, dst_stride, bpp, dst_x, d=
st_y,
> +                    s->regs.dst_width, s->regs.dst_height, filler)) {
> +            /* fallback when pixman failed or we don't want to call it *=
/
> +            unsigned int x, y, i, bypp =3D bpp / 8;
> +            unsigned int dst_pitch =3D dst_stride * sizeof(uint32_t);
> +            for (y =3D 0; y < s->regs.dst_height; y++) {
> +                i =3D dst_x * bypp + (dst_y + y) * dst_pitch;
> +                for (x =3D 0; x < s->regs.dst_width; x++, i +=3D bypp) {
> +                    stn_he_p(&dst_bits[i], bypp, filler);
> +                }
> +            }
> +        }
>          if (dst_bits >=3D s->vga.vram_ptr + s->vga.vbe_start_addr &&
>              dst_bits < s->vga.vram_ptr + s->vga.vbe_start_addr +
>              s->vga.vbe_regs[VBE_DISPI_INDEX_YRES] * s->vga.vbe_line_offs=
et) {
> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
> index 8abb873f01..f5a47b82b0 100644
> --- a/hw/display/ati_int.h
> +++ b/hw/display/ati_int.h
> @@ -90,6 +90,7 @@ struct ATIVGAState {
>      char *model;
>      uint16_t dev_id;
>      uint8_t mode;
> +    uint8_t use_pixman;
>      bool cursor_guest_mode;
>      uint16_t cursor_size;
>      uint32_t cursor_offset;
> --
> 2.30.9
>
>


--=20
Marc-Andr=C3=A9 Lureau

