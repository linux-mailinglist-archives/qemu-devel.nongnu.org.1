Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3C7806348
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 01:16:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAfZk-0003rT-Mj; Tue, 05 Dec 2023 19:15:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfZh-0003ii-VM; Tue, 05 Dec 2023 19:15:37 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfZf-0006ND-PS; Tue, 05 Dec 2023 19:15:37 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-54c5d041c23so6068382a12.2; 
 Tue, 05 Dec 2023 16:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701821733; x=1702426533; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mpurPHJIfdPOD6bMn02GtsIkK16hB0NQq2Z0Tl+Odl8=;
 b=ABvsrZ8nJiCwr4u+gvp8DCqogkfeK2fzODng/nx6ZOvjeyWmR4LStAe9kYzRtQcXv3
 umdR4poAVNpP8xQ0UCIU3etBFRZNICyf04J9qdnbs0MW4uIFM+XOQHOmzmOHtbb0G3os
 jVfA8tOezg7XJ7WuevtOeBp88tmX6r/zFDU93i0Z4EilSR5onxC9LZx3BpAIRvYaHCuN
 bO7CAo+GW2t2uTHGWj6N6yEmp88O3d2aDON2YihjozyKUE272j89vza2LVs6+lPGmur5
 s96rlAkhMX5sS9+f3xPsrnfZBhppV63FJm3oqsmuG/Uu6YMWReiOW/ILh1OMhBiZd00r
 pH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701821733; x=1702426533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mpurPHJIfdPOD6bMn02GtsIkK16hB0NQq2Z0Tl+Odl8=;
 b=oys0F1qIBOqizTYIyNHivAnDSs6jKP1IIEb6zZArn/c7dvjkir2vDUvDe/MjkiqZXH
 hy1ggF1d0fbIyzZ+eMI6/w6+xalU5BexznhI9uMuv2Eg/1ZykFzRu5XKnhS8Jl15Oetb
 m2ePw4ayqY0IUs7E3RSvCk4fd7fC6dvc7WhEEPldesaU2cPG99U+On479UNuq0K+y32I
 CQ7zBMwcyQuAoXFIjHn8Q6vI894s9YECwUFsetXOLCfFNjjzll27feHb15ZtyoxrIJjG
 k1cB22xdJsGuyNPlcKTtayjAb/rsvk1kB781MaTlel8Ga8q+sjiyGueq+z8OTZW56DYF
 0rQg==
X-Gm-Message-State: AOJu0YwcnsvxZA145kFhoaZiKqEm050p6Q4AINiGaP61E6imv8DHh3jO
 8Tz6ITtqztDOzBIpa2HjKKdYnTpmqXoideWA9jE=
X-Google-Smtp-Source: AGHT+IGrF8ERVBU6Y1KId45K0cstoRHm8qwmO9Hiyy7+J6/f55OQ4m1ZA9uCzmuAR0M0gvOXEtQTFFfN88q/kebqgmM=
X-Received: by 2002:a50:d783:0:b0:54c:e9af:43a7 with SMTP id
 w3-20020a50d783000000b0054ce9af43a7mr31925edi.99.1701821732899; Tue, 05 Dec
 2023 16:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20231124143505.1493184-1-fkonrad@amd.com>
 <20231124143505.1493184-3-fkonrad@amd.com>
In-Reply-To: <20231124143505.1493184-3-fkonrad@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 10:15:05 +1000
Message-ID: <CAKmqyKOCmdEBEgeajm55pr-=YJH-uOu4PXUzBTskO8dozJ6mUg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fix some url for amd / xilinx models
To: Frederic Konrad <fkonrad@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, francisco.iglesias@amd.com, 
 peter.maydell@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me, 
 luc.michel@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Nov 25, 2023 at 12:37=E2=80=AFAM Frederic Konrad <fkonrad@amd.com> =
wrote:
>
> It seems that the url changed a bit, and it triggers an error.  Fix the U=
RLs so
> the documentation can be reached again.
>
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xlnx_csu_dma.c                      | 2 +-
>  include/hw/misc/xlnx-versal-cframe-reg.h   | 2 +-
>  include/hw/misc/xlnx-versal-cfu.h          | 2 +-
>  include/hw/misc/xlnx-versal-pmc-iou-slcr.h | 2 +-
>  include/hw/ssi/xlnx-versal-ospi.h          | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/dma/xlnx_csu_dma.c b/hw/dma/xlnx_csu_dma.c
> index e89089821a..531013f35a 100644
> --- a/hw/dma/xlnx_csu_dma.c
> +++ b/hw/dma/xlnx_csu_dma.c
> @@ -33,7 +33,7 @@
>
>  /*
>   * Ref: UG1087 (v1.7) February 8, 2019
> - * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrasc=
ale-registers.html
> + * https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-ultrasc=
ale-registers
>   * CSUDMA Module section
>   */
>  REG32(ADDR, 0x0)
> diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/x=
lnx-versal-cframe-reg.h
> index a14fbd7fe4..0091505246 100644
> --- a/include/hw/misc/xlnx-versal-cframe-reg.h
> +++ b/include/hw/misc/xlnx-versal-cframe-reg.h
> @@ -12,7 +12,7 @@
>   *     https://www.xilinx.com/support/documentation/architecture-manuals=
/am011-versal-acap-trm.pdf
>   *
>   * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-regi=
ster-reference.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/C=
FRAME_REG-Module
>   */
>  #ifndef HW_MISC_XLNX_VERSAL_CFRAME_REG_H
>  #define HW_MISC_XLNX_VERSAL_CFRAME_REG_H
> diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-ver=
sal-cfu.h
> index 86fb841053..be62bab8c8 100644
> --- a/include/hw/misc/xlnx-versal-cfu.h
> +++ b/include/hw/misc/xlnx-versal-cfu.h
> @@ -12,7 +12,7 @@
>   *     https://www.xilinx.com/support/documentation/architecture-manuals=
/am011-versal-acap-trm.pdf
>   *
>   * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/htmldocs/registers/am012/am012-versal-regi=
ster-reference.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/C=
FU_CSR-Module
>   */
>  #ifndef HW_MISC_XLNX_VERSAL_CFU_APB_H
>  #define HW_MISC_XLNX_VERSAL_CFU_APB_H
> diff --git a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h b/include/hw/misc=
/xlnx-versal-pmc-iou-slcr.h
> index f7d24c93c4..0c4a4fd66d 100644
> --- a/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
> +++ b/include/hw/misc/xlnx-versal-pmc-iou-slcr.h
> @@ -34,7 +34,7 @@
>   *     https://www.xilinx.com/support/documentation/architecture-manuals=
/am011-versal-acap-trm.pdf
>   *
>   * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-reg=
ister-reference.html#mod___pmc_iop_slcr.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/P=
MC_IOP_SLCR-Module
>   *
>   * QEMU interface:
>   * + sysbus MMIO region 0: MemoryRegion for the device's registers
> diff --git a/include/hw/ssi/xlnx-versal-ospi.h b/include/hw/ssi/xlnx-vers=
al-ospi.h
> index 5d131d351d..4ac975aa2f 100644
> --- a/include/hw/ssi/xlnx-versal-ospi.h
> +++ b/include/hw/ssi/xlnx-versal-ospi.h
> @@ -34,7 +34,7 @@
>   *     https://www.xilinx.com/support/documentation/architecture-manuals=
/am011-versal-acap-trm.pdf
>   *
>   * [2] Versal ACAP Register Reference,
> - *     https://www.xilinx.com/html_docs/registers/am012/am012-versal-reg=
ister-reference.html#mod___ospi.html
> + *     https://docs.xilinx.com/r/en-US/am012-versal-register-reference/O=
SPI-Module
>   *
>   *
>   * QEMU interface:
> --
> 2.25.1
>
>

