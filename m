Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1624F8359BA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 04:28:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRky5-000335-Pj; Sun, 21 Jan 2024 22:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRky4-00032s-5A; Sun, 21 Jan 2024 22:27:24 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rRky1-0001DO-OB; Sun, 21 Jan 2024 22:27:23 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7d2940ad0e1so609205241.1; 
 Sun, 21 Jan 2024 19:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705894040; x=1706498840; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2igC9J/DXbp0p2cQRhRVs1QMFzrKhrr2jRPbTk8b3Y=;
 b=NvhV+8b70omzccwp/UUDKxwI3j9OnEfdBLm0iBQOfEDG+NH1Xk7ezjIrAtBiPYpeF/
 3v7Tas7fA9u8jg66LexNedVvAH4mNaOdnNktjJdaIFQYYYacqFUjbOBSybFV3Oo4yX0W
 L7pHr4VfR30Y6YtKNzZn1ZgcWs2SIWCuVglOQWWtB3fXS3dkUOYB9QpVYG7HvOQaMt4z
 f6S1CoAiZR3oNp91IZCZlxCEGIJemBmZU8E/QC5J+Lf98jVUkx2I/hPwZSwxjhZh2PT9
 +ZBldbv7uUi6qw008KLCZdhH7PSWqC9upe+8AidK77X81rCjMqiYe/sKNVFUOJgIgaLl
 okhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705894040; x=1706498840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2igC9J/DXbp0p2cQRhRVs1QMFzrKhrr2jRPbTk8b3Y=;
 b=eHaH7Pc82vTE2BgcPZO9Z30ilrlJl0kVFUwgvTjNcv7zNvnUDGsLhKZ4bohft1xQY4
 HtGG2cl73zsjRQWqL5ITeVVFE/A/ahh2Gx4X3sPoW0x8a0DMRvt2LoeEsRNEnadPcibl
 oMPpo/9haPI2BOQqs0ME6nu4jT0UtUvfHcJdjF7KP5lBh4yzZxiWY3wFpekK6kIYK31d
 ZBcXMq0x188DvoeuaE/Hun8SyFSPaH18vd8YTaP9Dx68R/EuyezmHs3cROfN1oU66ftv
 llmAr3Xe60l/JxgDNaYfoT4OQRKCKb37RDz38cvmhowf/2j7yrYWubJeb0FRuHaBX8hN
 XDJA==
X-Gm-Message-State: AOJu0YwVTNnseaqhBiq5uJ70F/z65qS8Rv6gzrCA2t4uXdrDC9jjcz1v
 D07JWwEGlSXsFDbJZJoykuA7jzjB+BnUbIzrEZAB61vBblvej/+xaDFlZ/4kuahZFjsMo0XWUmA
 ZU66UUjvL8dkoQXC3S9orBgXW5Nc=
X-Google-Smtp-Source: AGHT+IHdCZBMYImZDjE4BfLkd0ZtVEmQ76if7xWyrMEgYMSHWJe6hjNNHOMUBMWcnabmGRsOiNVm/qwO92OQIEv/N9E=
X-Received: by 2002:a67:fa45:0:b0:467:fa58:7eb7 with SMTP id
 j5-20020a67fa45000000b00467fa587eb7mr961350vsq.50.1705894039988; Sun, 21 Jan
 2024 19:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20240115043431.3900922-1-bin.meng@windriver.com>
 <20240115043431.3900922-2-bin.meng@windriver.com>
In-Reply-To: <20240115043431.3900922-2-bin.meng@windriver.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jan 2024 13:26:53 +1000
Message-ID: <CAKmqyKNm3cLk1_VDi76W2qXM1kw4XmvP8Fn5NmsYg+sj3iQdEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/arm: Refactor struct arm_boot_info::get_dtb()
To: Bin Meng <bin.meng@windriver.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x929.google.com
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

On Mon, Jan 15, 2024 at 2:36=E2=80=AFPM Bin Meng <bin.meng@windriver.com> w=
rote:
>
> At present we expect struct arm_boot_info::get_dtb() to return the
> device tree pointer as well as the device tree size. However, this
> is not necessary as we can get the device tree size via the device
> tree header directly. Change get_dtb() signature to drop the *size
> argument, and get the size by ourselves.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  include/hw/arm/boot.h     | 8 ++++----
>  hw/arm/boot.c             | 3 ++-
>  hw/arm/sbsa-ref.c         | 3 +--
>  hw/arm/virt.c             | 4 +---
>  hw/arm/xlnx-versal-virt.c | 4 +---
>  5 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
> index 80c492d742..37fd1b520e 100644
> --- a/include/hw/arm/boot.h
> +++ b/include/hw/arm/boot.h
> @@ -82,11 +82,11 @@ struct arm_boot_info {
>                                       const struct arm_boot_info *info);
>      /* if a board is able to create a dtb without a dtb file then it
>       * sets get_dtb. This will only be used if no dtb file is provided
> -     * by the user. On success, sets *size to the length of the created
> -     * dtb, and returns a pointer to it. (The caller must free this memo=
ry
> -     * with g_free() when it has finished with it.) On failure, returns =
NULL.
> +     * by the user. On success, returns a pointer to it. (The caller mus=
t
> +     * free this memory with g_free() when it has finished with it.)
> +     * On failure, returns NULL.
>       */
> -    void *(*get_dtb)(const struct arm_boot_info *info, int *size);
> +    void *(*get_dtb)(const struct arm_boot_info *info);
>      /* if a board needs to be able to modify a device tree provided by
>       * the user it should implement this hook.
>       */
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 84ea6a807a..ff1173299f 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -538,11 +538,12 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>          }
>          g_free(filename);
>      } else {
> -        fdt =3D binfo->get_dtb(binfo, &size);
> +        fdt =3D binfo->get_dtb(binfo);
>          if (!fdt) {
>              fprintf(stderr, "Board was unable to create a dtb blob\n");
>              goto fail;
>          }
> +        size =3D fdt_totalsize(fdt);
>      }
>
>      if (addr_limit > addr && size > (addr_limit - addr)) {
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 477dca0637..c5023871a7 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -681,12 +681,11 @@ static void create_pcie(SBSAMachineState *sms)
>      create_smmu(sms, pci->bus);
>  }
>
> -static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_si=
ze)
> +static void *sbsa_ref_dtb(const struct arm_boot_info *binfo)
>  {
>      const SBSAMachineState *board =3D container_of(binfo, SBSAMachineSta=
te,
>                                                   bootinfo);
>
> -    *fdt_size =3D board->fdt_size;
>      return board->fdt;
>  }
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2793121cb4..1996fffa99 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1577,14 +1577,12 @@ static void create_secure_ram(VirtMachineState *v=
ms,
>      g_free(nodename);
>  }
>
> -static void *machvirt_dtb(const struct arm_boot_info *binfo, int *fdt_si=
ze)
> +static void *machvirt_dtb(const struct arm_boot_info *binfo)
>  {
>      const VirtMachineState *board =3D container_of(binfo, VirtMachineSta=
te,
>                                                   bootinfo);
>      MachineState *ms =3D MACHINE(board);
>
> -
> -    *fdt_size =3D board->fdt_size;
>      return ms->fdt;
>  }
>
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 537118224f..1e043c813e 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -551,12 +551,10 @@ static void versal_virt_modify_dtb(const struct arm=
_boot_info *binfo,
>      fdt_add_memory_nodes(s, fdt, binfo->ram_size);
>  }
>
> -static void *versal_virt_get_dtb(const struct arm_boot_info *binfo,
> -                                  int *fdt_size)
> +static void *versal_virt_get_dtb(const struct arm_boot_info *binfo)
>  {
>      const VersalVirt *board =3D container_of(binfo, VersalVirt, binfo);
>
> -    *fdt_size =3D board->fdt_size;
>      return board->fdt;
>  }
>
> --
> 2.34.1
>
>

