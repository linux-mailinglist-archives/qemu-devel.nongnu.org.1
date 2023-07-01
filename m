Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B46744876
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXkY-0000BA-VW; Sat, 01 Jul 2023 06:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXkS-0000AR-E1; Sat, 01 Jul 2023 06:22:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qFXkQ-0003a8-Rq; Sat, 01 Jul 2023 06:22:36 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-66f3fc56ef4so1681350b3a.0; 
 Sat, 01 Jul 2023 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688206953; x=1690798953;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O72PscZFPNVARDC8/PyHf4xoQ94VFMAFmGSe9LC0mQ=;
 b=E+dsDVwbQ8R9GPtEiCNrLdHxUjXK0fH9ovbg2eml1AmLBuIrs3+0J3PsXDUPE3zopg
 SwYJWV4gBeFCuGGngGAvtgbS4Tg1gQZCbtjKxNGCw8Nrs1M/PPm0rkQO49iZPFgIvvqx
 PsyT6E5h6IZc8eWnzKWWCsB9urTseRaSgo7SbqpIwDQt5tMpe9hLBLN0l/Zvl6DbFfcS
 G6J/Nd4SUCinWUzAbpuYkDf0q1FfGDJShxw8HFSOLmEsAEKjkJjg0UBT3rPccolOLFIi
 2s2rOHZcfNQuEwKwDKFjQRSgE5G4b7t4mnAcvh2A16aEz8Hy+W8j8c0XwJoLXsIEtaHD
 mI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688206953; x=1690798953;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+O72PscZFPNVARDC8/PyHf4xoQ94VFMAFmGSe9LC0mQ=;
 b=IhUK+KSgEBmflLxy7+s+yR1HpIKZ0h48n2fZ3IzYJPMZj8/rzCdu8sQMpU5Y00GRZB
 WDIezDVGcvH83tI8eXQUk8QZtj2coPahWcLfsX1+rny0Bq1U5aa0KhxUaUnU6XqDqZhW
 U3eJxS/LAKXVFypG3JJxxt87eswa4XZSZO8aaT4pzdy9DzQeoZ2MkKKR/Fl6TShdcxPl
 94Rt9vpLjmPke90XcEWYlAs/YS+pWH/Rpb2ue0mNncsLcheA84MwyBAWpBemnwssR7lo
 TdEm9ug7tZPMkWsg3BSBDUQIaDoWUR4VqhiXfh/7NGlYzeu6Kxh/FTXVRUim+ldCLwGH
 7+fA==
X-Gm-Message-State: AC+VfDwEk99X12pvQ5eHujTEyr40pGgzgwJXieKuw+0Lo0EI/G936F8r
 wj2bh8xcUXI9sVmVJMAYidg=
X-Google-Smtp-Source: ACHHUZ5WSovuwuBNvWripQyD7XnS4xSOoUOVWGvS/yZqrtxDraYn2wbv1/hBtHpBBzU0Gq7gXzShPQ==
X-Received: by 2002:a05:6a00:1d0a:b0:678:7744:31fd with SMTP id
 a10-20020a056a001d0a00b00678774431fdmr11977685pfx.0.1688206952663; 
 Sat, 01 Jul 2023 03:22:32 -0700 (PDT)
Received: from localhost (220-244-154-206.tpgi.com.au. [220.244.154.206])
 by smtp.gmail.com with ESMTPSA id
 q25-20020a62ae19000000b0067a50223e44sm8249401pff.74.2023.07.01.03.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Jul 2023 03:22:32 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Jul 2023 20:22:27 +1000
Message-Id: <CTQRF129NSME.300WPYT84MANM@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH 4/4] ppc/pnv: Return zero for core thread state xscom
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-5-joel@jms.id.au>
In-Reply-To: <20230630035547.80329-5-joel@jms.id.au>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

On Fri Jun 30, 2023 at 1:55 PM AEST, Joel Stanley wrote:
> Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
> this warning doesn't trigger report the core thread state is 0.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/ppc/pnv_core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7fff2fd9e298..98356d7f6538 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -116,6 +116,8 @@ static const MemoryRegionOps pnv_core_power8_xscom_op=
s =3D {
>  #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
>  #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
> =20
> +#define PNV9_XSCOM_EC_CORE_THREAD_STATE    0x10ab3
> +
>  static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>                                             unsigned int width)
>  {
> @@ -134,6 +136,9 @@ static uint64_t pnv_core_power9_xscom_read(void *opaq=
ue, hwaddr addr,
>      case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
>          val =3D 0x0;
>          break;
> +    case PNV9_XSCOM_EC_CORE_THREAD_STATE:
> +        val =3D 0;
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "Warning: reading reg=3D0x%" HWADDR_PRI=
x "\n",
>                    addr);
> @@ -408,6 +413,8 @@ static const MemoryRegionOps pnv_quad_power9_xscom_op=
s =3D {
>   * POWER10 Quads
>   */
> =20
> +#define PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE 0x28412
> +
>  static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>  {
> @@ -415,6 +422,9 @@ static uint64_t pnv_quad_power10_xscom_read(void *opa=
que, hwaddr addr,
>      uint64_t val =3D -1;
> =20
>      switch (offset) {
> +    case PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE:
> +        val =3D 0;
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
>                        offset);

Yeah this is the problem, this is just addressing one core in the quad.
AFAIKS P9 may have the same problem though so I don't blame the
confusion.

The other patches seem good because we'll want a P10 quad too I think.

Thanks,
Nick

