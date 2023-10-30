Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E937DB8E4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:22:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQKd-0001vF-OZ; Mon, 30 Oct 2023 07:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxQK6-0001jC-DE
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:20:50 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxQK3-0001YS-Gn
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:20:46 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cd4cc515fso33055831cf.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698664837; x=1699269637; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aLh6LysX7RhZ0+isTi8inVI1XjtbJcJXHMAXI6qKpvc=;
 b=ROyK68grt4CM6N1j6zEPRcgmQF1w7zKQebAAtVWcsGDoRbyGsgq6z8n2Gkkn8ctz6E
 UZOoSFxCTy+GrJ2bGfTbf+MHXQPk4gVapwalDcP0AcqK7pmlhrlicveR9dpbfouGwuqs
 ss+FPL/r1hyHPFZcTwao9Y5CnHfXhQq9GcgJuqzh+qy/jJ2Tgvu/wyOPPIqiYAy5/7qi
 2gpe4hARWoqDFycB1N4dXX7mhnMVgPm/gSYKo1x2+Bb9dtwF8Js4ejXxrXfCeZwX0+Wp
 XCbISPw7pk8G7PsCa4ZOdouMgUtEj+3pfQ3rcX4PQ0AHHgdqq72FQFMsRddZJVq5/dBf
 9A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698664837; x=1699269637;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLh6LysX7RhZ0+isTi8inVI1XjtbJcJXHMAXI6qKpvc=;
 b=QR0ptACYQtFVa6050FW+Oc0SLsKI9fMY5lenLZrvDBOqp9Fg0lZuYporyxQPyoCZjq
 CiRnsNdM3mo3lQ+GrPl6Cs6SavAKCzAZK82j68eXc/tGTcubm2UpmxFPtsGoKE6GYnVv
 0hPJ13oixe2GTlVx5te4JtIWcZbqgfqEtOICd+6Vj2/BqevkuTYDDKYVhBzK29fiPsgv
 ZbZDBr2yFrvba1ZF8vaxoRaWzkZzoAz8xE0qB/5R2yyEfFf9+ZnA6tveitjPknXXkzzE
 2ro/r9/vpnafzlWFISxFWTpfJbqDJO+/N36/JeUThHt6ACk3IAINTwkp0GzU3LJupPRo
 BgXA==
X-Gm-Message-State: AOJu0Yxrihxo7794q6sGH3Q4ppDV7RHRyzv3lInGRoTasTekqD2d9qMO
 FchjVBKoIkPuYiGNm2xzspI8pF27ohNjw73x9cY=
X-Google-Smtp-Source: AGHT+IFK7J34vfVGk4yPd2YUcOhjwsPewQFAZA1BLk5A0T0LSubOOSLSEjTrqBAJMCbBBTN4RLdMZjy2AcIcLR+RKqs=
X-Received: by 2002:a05:622a:214:b0:418:134f:17f4 with SMTP id
 b20-20020a05622a021400b00418134f17f4mr12915356qtx.22.1698664837375; Mon, 30
 Oct 2023 04:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696942148.git.balaton@eik.bme.hu>
 <fc668399935df877fe7f140d97c5e955dbe2574f.1696942148.git.balaton@eik.bme.hu>
In-Reply-To: <fc668399935df877fe7f140d97c5e955dbe2574f.1696942148.git.balaton@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Oct 2023 15:20:25 +0400
Message-ID: <CAJ+F1CK2B45S7ySjJejBcHRuJotmi3tb4v62=0EYE7FbgctB=Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] ati-vga: Support unaligned access to GPIO DDC
 registers
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

On Tue, Oct 10, 2023 at 5:03=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> The GPIO_VGA_DDC and GPIO_DVI_DDC registers are used on Radeon for DDC
> access. Some drivers like the PPC Mac FCode ROM uses unaligned writes
> to these registers so implement this the same way as already done for
> GPIO_MONID which is used the same way for the Rage 128 Pro.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/ati.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index f0bf1d7493..ce63935ead 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -319,11 +319,13 @@ static uint64_t ati_mm_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>      case DAC_CNTL:
>          val =3D s->regs.dac_cntl;
>          break;
> -    case GPIO_VGA_DDC:
> -        val =3D s->regs.gpio_vga_ddc;
> +    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
> +        val =3D ati_reg_read_offs(s->regs.gpio_vga_ddc,
> +                                addr - GPIO_VGA_DDC, size);
>          break;
> -    case GPIO_DVI_DDC:
> -        val =3D s->regs.gpio_dvi_ddc;
> +    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
> +        val =3D ati_reg_read_offs(s->regs.gpio_dvi_ddc,
> +                                addr - GPIO_DVI_DDC, size);
>          break;
>      case GPIO_MONID ... GPIO_MONID + 3:
>          val =3D ati_reg_read_offs(s->regs.gpio_monid,
> @@ -626,29 +628,34 @@ static void ati_mm_write(void *opaque, hwaddr addr,
>          s->regs.dac_cntl =3D data & 0xffffe3ff;
>          s->vga.dac_8bit =3D !!(data & DAC_8BIT_EN);
>          break;
> -    case GPIO_VGA_DDC:
> +    /*
> +     * GPIO regs for DDC access. Because some drivers access these via
> +     * multiple byte writes we have to be careful when we send bits to
> +     * avoid spurious changes in bitbang_i2c state. Only do it when eith=
er
> +     * the enable bits are changed or output bits changed while enabled.
> +     */
> +    case GPIO_VGA_DDC ... GPIO_VGA_DDC + 3:
>          if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
>              /* FIXME: Maybe add a property to select VGA or DVI port? */
>          }
>          break;
> -    case GPIO_DVI_DDC:
> +    case GPIO_DVI_DDC ... GPIO_DVI_DDC + 3:
>          if (s->dev_id !=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
> -            s->regs.gpio_dvi_ddc =3D ati_i2c(&s->bbi2c, data, 0);
> +            ati_reg_write_offs(&s->regs.gpio_dvi_ddc,
> +                               addr - GPIO_DVI_DDC, data, size);
> +            if ((addr <=3D GPIO_DVI_DDC + 2 && addr + size > GPIO_DVI_DD=
C + 2) ||
> +                (addr =3D=3D GPIO_DVI_DDC && (s->regs.gpio_dvi_ddc & 0x3=
0000))) {
> +                s->regs.gpio_dvi_ddc =3D ati_i2c(&s->bbi2c,
> +                                               s->regs.gpio_dvi_ddc, 0);
> +            }
>          }
>          break;
>      case GPIO_MONID ... GPIO_MONID + 3:
>          /* FIXME What does Radeon have here? */
>          if (s->dev_id =3D=3D PCI_DEVICE_ID_ATI_RAGE128_PF) {
> +            /* Rage128p accesses DDC via MONID(1-2) with additional mask=
 bit */
>              ati_reg_write_offs(&s->regs.gpio_monid,
>                                 addr - GPIO_MONID, data, size);
> -            /*
> -             * Rage128p accesses DDC used to get EDID via these bits.
> -             * Because some drivers access this via multiple byte writes
> -             * we have to be careful when we send bits to avoid spurious
> -             * changes in bitbang_i2c state. So only do it when mask is =
set
> -             * and either the enable bits are changed or output bits cha=
nged
> -             * while enabled.
> -             */
>              if ((s->regs.gpio_monid & BIT(25)) &&
>                  ((addr <=3D GPIO_MONID + 2 && addr + size > GPIO_MONID +=
 2) ||
>                   (addr =3D=3D GPIO_MONID && (s->regs.gpio_monid & 0x6000=
0)))) {
> --
> 2.30.9
>
>


--=20
Marc-Andr=C3=A9 Lureau

