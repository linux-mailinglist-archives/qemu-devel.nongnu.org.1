Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE147442D1
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJzE-00071X-Jv; Fri, 30 Jun 2023 15:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJyw-0006jH-13; Fri, 30 Jun 2023 15:40:39 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qFJyr-0008F1-H9; Fri, 30 Jun 2023 15:40:36 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-560b56b638eso1435548eaf.0; 
 Fri, 30 Jun 2023 12:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688154009; x=1690746009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DREDO8oZuPwjKzt+3AECgEVTh3edrujUdZacXoV5Vfc=;
 b=Ik/e7qbwT/+sDwbA7aq1jtBCOTBBGEMy6nW561VwHMK8wFz1NJrj869eD6+8lZAVcu
 vcEjpECMiUSNy7aF3/ov0k4duwslodrTgZzhg8udNLa3YLi5mnCbjFefCk/ErDm4eftu
 NuhJWTsm7ncCoUrNsod8Qa0VzGQhJQQ5z9U3VJ9mh8q9ekIi24o6LUb0guTh4gkIHli6
 D88bTkgDuHnXsEuSARL6vksz2V9QnjE48SjtofAd9pCY0CvYMiCAD+QnQeRWoUmRIs+n
 RDF5IhUIM1skBmlRIiaqRSPIyXrQH5ZJ5viqmt+zaecWblOS/IoRXjJVQ6OVUignNv+F
 XesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688154009; x=1690746009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DREDO8oZuPwjKzt+3AECgEVTh3edrujUdZacXoV5Vfc=;
 b=S9P9KXwFjUJHguiW7ccjKV3ZAzJY1UD30UPKyU+XKSsr4t6CWsigF/j/iqBHxbD1/+
 sQZOS6eFMuUQ/TVxle6Z70JQ8jcGOCSTU0RbvGkP7QapJAhJdLW2QP5esIyBQtW6oJXw
 1h18gZF3A+8btypju/EGpITTCCmIqSNSnDcWtNXRaFO3prVsau/SsI7TiyXDm6ygEvE3
 bMy/Ii6SA1up+4uyavn1pb4Pqzo7cl/WGzg3U7cMeu2O1OTu3K1lQKL997jz16PJQmK+
 RSCoNu7XwslGhDXOOdWOWjrsbsMk1RK0vdTylt2dXH8nOXQX8TyNSin+duXrd0BcA4sI
 WplQ==
X-Gm-Message-State: AC+VfDwb5wcR/m8B80QeFDm1L1veqVxUaKTVuZnSre3NVIejCK0JK4Yy
 o9rorkE8HsA5wsbddQxKNOA=
X-Google-Smtp-Source: ACHHUZ6y6c/ZzwH6mwFOIgsfRYJcIEyGng3XajDstQVN4nQKI6oQq6qVN4VLf7IPXn5KkP4MG8vYEA==
X-Received: by 2002:a05:6820:218:b0:560:bc01:24e2 with SMTP id
 bw24-20020a056820021800b00560bc0124e2mr5056442oob.4.1688154009420; 
 Fri, 30 Jun 2023 12:40:09 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 m19-20020a4ae3d3000000b0056520f122eesm3626460oov.44.2023.06.30.12.40.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:40:09 -0700 (PDT)
Message-ID: <917b0537-10da-f6c7-c756-523382b31872@gmail.com>
Date: Fri, 30 Jun 2023 16:40:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] sungem: Add WOL MMIO
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230625201628.65231-1-npiggin@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230625201628.65231-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.095,
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



On 6/25/23 17:16, Nicholas Piggin wrote:
> Apple sungem devices are expected to have WOL MMIO registers.
> Add a region to prevent transaction failures, and implement the
> WOL-disable CSR write because the Linux driver reset writes
> this.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Queued in gitlab.com/danielhb/qemu/tree/ppc-next. Thanks,


Daniel

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

