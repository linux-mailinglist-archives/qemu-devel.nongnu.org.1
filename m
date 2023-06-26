Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E794073D7B4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:20:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfZo-0006ws-5c; Mon, 26 Jun 2023 02:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfZl-0006w5-UB; Mon, 26 Jun 2023 02:19:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfZj-0004Si-QQ; Mon, 26 Jun 2023 02:19:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHkT0z4zz4wb4;
 Mon, 26 Jun 2023 16:19:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHkR52VJz4wb3;
 Mon, 26 Jun 2023 16:19:43 +1000 (AEST)
Message-ID: <0f707254-ac37-5fcb-f051-81e0290dfd9e@kaod.org>
Date: Mon, 26 Jun 2023 08:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sungem: Add WOL MMIO
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230625201628.65231-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230625201628.65231-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/25/23 22:16, Nicholas Piggin wrote:
> Apple sungem devices are expected to have WOL MMIO registers.
> Add a region to prevent transaction failures, and implement the
> WOL-disable CSR write because the Linux driver reset writes
> this.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
> This fixes the failed MMIO error in the Linux sungem driver reset
> when it clears the WOL CSR.
> 
> Thanks,
> Nick
> 
>   hw/net/sungem.c     | 52 +++++++++++++++++++++++++++++++++++++++++++++
>   hw/net/trace-events |  2 ++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/hw/net/sungem.c b/hw/net/sungem.c
> index eb01520790..e0e8e5ae41 100644
> --- a/hw/net/sungem.c
> +++ b/hw/net/sungem.c
> @@ -107,6 +107,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
>   #define RXDMA_FTAG        0x0110UL    /* RX FIFO Tag */
>   #define RXDMA_FSZ         0x0120UL    /* RX FIFO Size */
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
>   /* MAC Registers */
>   #define SUNGEM_MMIO_MAC_SIZE   0x200
>   
> @@ -168,6 +177,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
>   #define SUNGEM_MMIO_PCS_SIZE   0x60
>   #define PCS_MIISTAT       0x0004UL    /* PCS MII Status Register */
>   #define PCS_ISTAT         0x0018UL    /* PCS Interrupt Status Reg */
> +
>   #define PCS_SSTATE        0x005CUL    /* Serialink State Register */
>   
>   /* Descriptors */
> @@ -200,6 +210,7 @@ struct SunGEMState {
>       MemoryRegion greg;
>       MemoryRegion txdma;
>       MemoryRegion rxdma;
> +    MemoryRegion wol;
>       MemoryRegion mac;
>       MemoryRegion mif;
>       MemoryRegion pcs;
> @@ -1076,6 +1087,43 @@ static const MemoryRegionOps sungem_mmio_rxdma_ops = {
>       },
>   };
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
>   static void sungem_mmio_mac_write(void *opaque, hwaddr addr, uint64_t val,
>                                     unsigned size)
>   {
> @@ -1344,6 +1392,10 @@ static void sungem_realize(PCIDevice *pci_dev, Error **errp)
>                             "sungem.rxdma", SUNGEM_MMIO_RXDMA_SIZE);
>       memory_region_add_subregion(&s->sungem, 0x4000, &s->rxdma);
>   
> +    memory_region_init_io(&s->wol, OBJECT(s), &sungem_mmio_wol_ops, s,
> +                          "sungem.wol", SUNGEM_MMIO_WOL_SIZE);
> +    memory_region_add_subregion(&s->sungem, 0x3000, &s->wol);
> +
>       memory_region_init_io(&s->mac, OBJECT(s), &sungem_mmio_mac_ops, s,
>                             "sungem.mac", SUNGEM_MMIO_MAC_SIZE);
>       memory_region_add_subregion(&s->sungem, 0x6000, &s->mac);
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index e4a98b2c7d..930e5b4293 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -350,6 +350,8 @@ sungem_mmio_txdma_write(uint64_t addr, uint64_t val) "MMIO txdma write to 0x%"PR
>   sungem_mmio_txdma_read(uint64_t addr, uint64_t val) "MMIO txdma read from 0x%"PRIx64" val=0x%"PRIx64
>   sungem_mmio_rxdma_write(uint64_t addr, uint64_t val) "MMIO rxdma write to 0x%"PRIx64" val=0x%"PRIx64
>   sungem_mmio_rxdma_read(uint64_t addr, uint64_t val) "MMIO rxdma read from 0x%"PRIx64" val=0x%"PRIx64
> +sungem_mmio_wol_write(uint64_t addr, uint64_t val) "MMIO wol write to 0x%"PRIx64" val=0x%"PRIx64
> +sungem_mmio_wol_read(uint64_t addr, uint64_t val) "MMIO wol read from 0x%"PRIx64" val=0x%"PRIx64
>   sungem_mmio_mac_write(uint64_t addr, uint64_t val) "MMIO mac write to 0x%"PRIx64" val=0x%"PRIx64
>   sungem_mmio_mac_read(uint64_t addr, uint64_t val) "MMIO mac read from 0x%"PRIx64" val=0x%"PRIx64
>   sungem_mmio_mif_write(uint64_t addr, uint64_t val) "MMIO mif write to 0x%"PRIx64" val=0x%"PRIx64


