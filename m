Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F151073E045
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:14:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDm2a-0001To-4P; Mon, 26 Jun 2023 09:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qDm2O-0001L4-FL; Mon, 26 Jun 2023 09:13:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qDm2L-00051w-HW; Mon, 26 Jun 2023 09:13:47 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98df6bc0048so257710566b.1; 
 Mon, 26 Jun 2023 06:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1687785223; x=1690377223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IPGa6l7CEQ/9n5OV+kLLjjRXIgkLg9+aV5jo1rPYVF0=;
 b=Qeu+yfazjlUBRhTjHflcv5GH16FYwQLex5SnJYhxEP2j6dpYvZvCNgUOiKD8dpUbjr
 r0qcQtq49nLvD4n7oSnuoqIuNI5EfzRCibDdVNGBlBUkmwdPBEqTuKsE/e0qPabE3bpI
 TKPAqNyBE2Blb0rByuXZxqCRxSzlQkaAMHyLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687785223; x=1690377223;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IPGa6l7CEQ/9n5OV+kLLjjRXIgkLg9+aV5jo1rPYVF0=;
 b=ezODo2FP7vrNV6ISFmlI9pxIENAwEYgxleGo1Ic+xshQ6hz8VGSD5uYBUr4B43ff73
 s3jxCuLuG7ioLNLWsSanGM/WgCmfyJnHFUAczHQhp+LNANOATIxt4Gq1xsHpwGEZsT31
 8QUgDv7mOQV5TJTnBu7IgidxCGdy0ykPayiu/wuUcbMYhHxmlY5abH17L4Nm7zXssUSy
 os2vpDCxQH4mS2DSHC2hxzg5A7VS3Gsr2HBpAYWAxD9ajpy9hRiWY2ytcoM0D/xRH/1q
 DW7bQ89oqAZ+1Ym2gqIOUHROhAZFIXRle3l1b2zNfpQ7E+//UonBlJp+CJTua87Vd8fO
 3tfw==
X-Gm-Message-State: AC+VfDwErMX6qHBfz0NNWaiRu+0d3Y0W0oTxx411X6c0wrSeAXUrhbo8
 lRCe6WWPwjpQfUgmu7ElDo9GRGrwPkmRSvhDMJA=
X-Google-Smtp-Source: ACHHUZ4H3Em4qLyuqCArk7C8ms4SkpE/ViI9bL2VRyF8vwqho5UTZm0yAlfcYcpQtEHjnsXw9Fxks+R3qADz+R7BhGk=
X-Received: by 2002:a17:907:6d1a:b0:988:6193:29d8 with SMTP id
 sa26-20020a1709076d1a00b00988619329d8mr19954666ejc.57.1687785222641; Mon, 26
 Jun 2023 06:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230625201628.65231-1-npiggin@gmail.com>
In-Reply-To: <20230625201628.65231-1-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 26 Jun 2023 13:13:30 +0000
Message-ID: <CACPK8XfHik2p4hD1pvD7OziSAipC0O29GHzV32qfbVRYUkMHbw@mail.gmail.com>
Subject: Re: [PATCH] sungem: Add WOL MMIO
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS=0.1 autolearn=no autolearn_force=no
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

On Sun, 25 Jun 2023 at 20:17, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Apple sungem devices are expected to have WOL MMIO registers.
> Add a region to prevent transaction failures, and implement the
> WOL-disable CSR write because the Linux driver reset writes
> this.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> This fixes the failed MMIO error in the Linux sungem driver reset
> when it clears the WOL CSR.
>
> Thanks,
> Nick
>
>  hw/net/sungem.c     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/net/trace-events |  2 ++
>  2 files changed, 54 insertions(+)
>
> diff --git a/hw/net/sungem.c b/hw/net/sungem.c
> index eb01520790..e0e8e5ae41 100644
> --- a/hw/net/sungem.c
> +++ b/hw/net/sungem.c
> @@ -107,6 +107,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
>  #define RXDMA_FTAG        0x0110UL    /* RX FIFO Tag */
>  #define RXDMA_FSZ         0x0120UL    /* RX FIFO Size */
>
> +/* WOL Registers */
> +#define SUNGEM_MMIO_WOL_SIZE   0x14
> +
> +#define WOL_MATCH0        0x0000UL
> +#define WOL_MATCH1        0x0004UL
> +#define WOL_MATCH2        0x0008UL
> +#define WOL_MCOUNT        0x000CUL
> +#define WOL_WAKECSR       0x0010UL
> +
>  /* MAC Registers */
>  #define SUNGEM_MMIO_MAC_SIZE   0x200
>
> @@ -168,6 +177,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
>  #define SUNGEM_MMIO_PCS_SIZE   0x60
>  #define PCS_MIISTAT       0x0004UL    /* PCS MII Status Register */
>  #define PCS_ISTAT         0x0018UL    /* PCS Interrupt Status Reg */
> +
>  #define PCS_SSTATE        0x005CUL    /* Serialink State Register */
>
>  /* Descriptors */
> @@ -200,6 +210,7 @@ struct SunGEMState {
>      MemoryRegion greg;
>      MemoryRegion txdma;
>      MemoryRegion rxdma;
> +    MemoryRegion wol;
>      MemoryRegion mac;
>      MemoryRegion mif;
>      MemoryRegion pcs;
> @@ -1076,6 +1087,43 @@ static const MemoryRegionOps sungem_mmio_rxdma_ops = {
>      },
>  };
>
> +static void sungem_mmio_wol_write(void *opaque, hwaddr addr, uint64_t val,
> +                                    unsigned size)
> +{
> +    trace_sungem_mmio_wol_write(addr, val);
> +
> +    switch (addr) {
> +    case WOL_WAKECSR:
> +        if (val != 0) {
> +            qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
> +        }
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
> +    }
> +}
> +
> +static uint64_t sungem_mmio_wol_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    uint32_t val = -1;
> +
> +    qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
> +
> +    trace_sungem_mmio_wol_read(addr, val);
> +
> +    return val;
> +}
> +
> +static const MemoryRegionOps sungem_mmio_wol_ops = {
> +    .read = sungem_mmio_wol_read,
> +    .write = sungem_mmio_wol_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .impl = {
> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};
> +
>  static void sungem_mmio_mac_write(void *opaque, hwaddr addr, uint64_t val,
>                                    unsigned size)
>  {
> @@ -1344,6 +1392,10 @@ static void sungem_realize(PCIDevice *pci_dev, Error **errp)
>                            "sungem.rxdma", SUNGEM_MMIO_RXDMA_SIZE);
>      memory_region_add_subregion(&s->sungem, 0x4000, &s->rxdma);
>
> +    memory_region_init_io(&s->wol, OBJECT(s), &sungem_mmio_wol_ops, s,
> +                          "sungem.wol", SUNGEM_MMIO_WOL_SIZE);
> +    memory_region_add_subregion(&s->sungem, 0x3000, &s->wol);
> +
>      memory_region_init_io(&s->mac, OBJECT(s), &sungem_mmio_mac_ops, s,
>                            "sungem.mac", SUNGEM_MMIO_MAC_SIZE);
>      memory_region_add_subregion(&s->sungem, 0x6000, &s->mac);
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e4a98b2c7d..930e5b4293 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -350,6 +350,8 @@ sungem_mmio_txdma_write(uint64_t addr, uint64_t val) "MMIO txdma write to 0x%"PR
>  sungem_mmio_txdma_read(uint64_t addr, uint64_t val) "MMIO txdma read from 0x%"PRIx64" val=0x%"PRIx64
>  sungem_mmio_rxdma_write(uint64_t addr, uint64_t val) "MMIO rxdma write to 0x%"PRIx64" val=0x%"PRIx64
>  sungem_mmio_rxdma_read(uint64_t addr, uint64_t val) "MMIO rxdma read from 0x%"PRIx64" val=0x%"PRIx64
> +sungem_mmio_wol_write(uint64_t addr, uint64_t val) "MMIO wol write to 0x%"PRIx64" val=0x%"PRIx64
> +sungem_mmio_wol_read(uint64_t addr, uint64_t val) "MMIO wol read from 0x%"PRIx64" val=0x%"PRIx64
>  sungem_mmio_mac_write(uint64_t addr, uint64_t val) "MMIO mac write to 0x%"PRIx64" val=0x%"PRIx64
>  sungem_mmio_mac_read(uint64_t addr, uint64_t val) "MMIO mac read from 0x%"PRIx64" val=0x%"PRIx64
>  sungem_mmio_mif_write(uint64_t addr, uint64_t val) "MMIO mif write to 0x%"PRIx64" val=0x%"PRIx64
> --
> 2.40.1
>
>

