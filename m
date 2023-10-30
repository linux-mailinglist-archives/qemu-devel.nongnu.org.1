Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F9A7DB8DF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:20:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQI7-0000dG-E9; Mon, 30 Oct 2023 07:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxQI4-0000cq-Cw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:18:40 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qxQI2-00017a-Py
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:18:40 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so28604301cf.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698664717; x=1699269517; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z7ge0+SRqEvtmZFHThRXF8vNChbSLG96kEb/yJk2gwU=;
 b=JF08GGI96joGLlE/HPhiJAXfyv1rK7MpCXvWbeJNOrKZh1rBvGrGjFxXajiayNdwbo
 b0d44o4Fvb8dpAHhbPRssO870FYIfPZndHG3RkJjFSWhktIV2ETzzhnOtN0ZKZfrFaC4
 7CGm2bRkdz6RIpSkt1120AE68CSKHwr3Jy58daG3/0Sap/5SyjzbGVtjftP45Tq7/vl1
 fqFF2aD7y8MpmuwrvENUhZPvouTd0RKElGEn8ShxY2jIM4pMTavNw7QDnW1x1dGAuH0U
 VZD9AA4kqEdFB/SJ3+67oc4IjtK0r4mVUIt54DA33mN0VdFIK835xWiBVdkSUoQYgt//
 9OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698664717; x=1699269517;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z7ge0+SRqEvtmZFHThRXF8vNChbSLG96kEb/yJk2gwU=;
 b=I8zGr3bnx9u/7VKm9Hv6dPSONn07H3NPcAU1DyJiZZi9PThUoZwncHqMU6gixgoeRq
 xL3WAMY3B7qAyly0Bjbn6pbHpYWz6sva957Fl//dahr342Jd2rAzUFYNBxuFsVcjVora
 90A1OFkgM30vcvBn/1JIOin2GPYK0IdYNe3sjeYj9IjEkWsY3Q7JsC4rrY+1ZbNCQexx
 chu3GW2UV+EITLgN27rFjCXfbA0fLdo5S9kJ6RHLSzGptnWIFHpao+Khonkb15JDgnRe
 Zx31KRDhlrSGica6pecmw+jt+n3MtgOx6MrRovHbyvGbdSB0Qen/T00AeVFXh7nYi5o1
 oJYg==
X-Gm-Message-State: AOJu0YzJUJEVcjc3/SG5QjTG5zS7tpkwLMYF0KefvjKC6FpUCC6/w+Aq
 H75bUCPpL6VKJOBtlU5vgnNFYqmNcJRvKiOdjDdZwC5UwCyDXw==
X-Google-Smtp-Source: AGHT+IFZkSDwCQUxsUG+61pbCnUmmbuqF8g0KhdoVhpvYOa5w6rKIpuq/bDYvirkywrWTsxbR7iCylaKK6ZuS/+nxcc=
X-Received: by 2002:a05:622a:18a4:b0:41e:2423:f0be with SMTP id
 v36-20020a05622a18a400b0041e2423f0bemr13553778qtc.40.1698664717636; Mon, 30
 Oct 2023 04:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696942148.git.balaton@eik.bme.hu>
 <b768c6506526caea0da8cd4025dbb05e109da4c5.1696942148.git.balaton@eik.bme.hu>
In-Reply-To: <b768c6506526caea0da8cd4025dbb05e109da4c5.1696942148.git.balaton@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 30 Oct 2023 15:18:25 +0400
Message-ID: <CAJ+F1C+iOpJWtQrHkJeq5bGxeK3nnvheE9_AKq1X703EsJD4DQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ati-vga: Fix aperture sizes
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

Hi

On Tue, Oct 10, 2023 at 5:03=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> Apparently these should be half the memory region sizes confirmed at
> least by Radeon drivers while Rage 128 Pro drivers don't seem to use
> these.

There doesn't seem to be adjustments for the kernel PPC driver
https://github.com/torvalds/linux/blob/master/drivers/video/fbdev/aty/radeo=
n_base.c#L2037

Do you have any other pointers?

thanks

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/ati.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ati.c b/hw/display/ati.c
> index c36282c343..f0bf1d7493 100644
> --- a/hw/display/ati.c
> +++ b/hw/display/ati.c
> @@ -349,14 +349,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>                                        PCI_BASE_ADDRESS_0, size) & 0xffff=
fff0;
>          break;
>      case CONFIG_APER_SIZE:
> -        val =3D s->vga.vram_size;
> +        val =3D s->vga.vram_size / 2;
>          break;
>      case CONFIG_REG_1_BASE:
>          val =3D pci_default_read_config(&s->dev,
>                                        PCI_BASE_ADDRESS_2, size) & 0xffff=
fff0;
>          break;
>      case CONFIG_REG_APER_SIZE:
> -        val =3D memory_region_size(&s->mm);
> +        val =3D memory_region_size(&s->mm) / 2;
>          break;
>      case MC_STATUS:
>          val =3D 5;
> --
> 2.30.9
>
>


--=20
Marc-Andr=C3=A9 Lureau

