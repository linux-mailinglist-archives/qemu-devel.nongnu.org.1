Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C2F71101B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 17:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2DI5-0007oC-RA; Thu, 25 May 2023 11:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DI2-0007nu-CV; Thu, 25 May 2023 11:54:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DI0-0006bF-PZ; Thu, 25 May 2023 11:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DI9DBKAQKi61KeRqqNp692drMhIFCvbWZpfMHIX6bJU=; b=Kp1poO5/fMomAyjeI3e3uNKrfw
 LnL6SnjGAIKrjxLOjPlUL7Yk7zs8SniwJ3bQ5WzsmI8B3Av4IP98hLYSj43UeXjk4Qvys2IRVJ7/w
 w2KdIG+VmI1cuYdAueykO9t8wthzxnFM2Q3cAkcarGEPoDLVo2e4wScr3ba62FqiRELIY/XsisNjY
 rQ1r0SnjRn2GB2FNzih0HFzNKC+P4/s4M6LupFLU6SRFgXGTixZBUT6ZOjv7HcQce0l5SaCS4oV1B
 UTVB/7RcxPMFtJAqULsAJefz/3AW4HU92HTXYlysTsXcdE+CkqYpo0iI180A7C3/AUYrSUbUj5Cqa
 EJ6r3OEc3ZuhFCwu+PAitECuwaRWHhDEgj0faStnYgMSm7Hatezwuij5qSb1ftb+ry/JEDXpIlmYr
 +B2WIP3+sREC+eIo/H15c1DRFA0FHAZLaKY4tlY+Pgypc5v+pxjcHDGnoKhcUeIZnpJjTYvGUEo1N
 qKbDqWiXW6xu/Btb/1Ks3kjZe59ISDIPTVbHo9cMOiUO33JHXWOgqyLzWdjzdW5m1h7s4DpDSieNn
 Couf+F+4Lt9NdfnFofVHSEbwHBTM6clzohxlNHCLwc3EYthASvNxuWnvq/9whr9Lb+2tn/Ii12zn7
 +3JmQJGw5GSmOprX3voU5ej7DV3DFnCDO2zj5gvV0=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2DHe-00029g-Hd; Thu, 25 May 2023 16:53:50 +0100
Message-ID: <bf94e7f8-d1c3-6b00-975f-bdd26af25f1b@ilande.co.uk>
Date: Thu, 25 May 2023 16:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Huacai Chen <chenhuacai@kernel.org>, 
 qemu-ppc@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230521111534.207973-1-shentey@gmail.com>
 <20230521111534.207973-6-shentey@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230521111534.207973-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 5/6] hw/ide: Extract bmdma_status_writeb()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 21/05/2023 12:15, Bernhard Beschow wrote:
> Every TYPE_PCI_IDE device performs the same not-so-trivial bit manipulation by
> copy'n'paste code. Extract this into bmdma_status_writeb(), mirroring
> bmdma_cmd_writeb().
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/ide/pci.h | 1 +
>   hw/ide/cmd646.c      | 2 +-
>   hw/ide/pci.c         | 5 +++++
>   hw/ide/piix.c        | 2 +-
>   hw/ide/sii3112.c     | 6 ++----
>   hw/ide/via.c         | 2 +-
>   6 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/ide/pci.h b/include/hw/ide/pci.h
> index 74c127e32f..1ff469de87 100644
> --- a/include/hw/ide/pci.h
> +++ b/include/hw/ide/pci.h
> @@ -58,6 +58,7 @@ struct PCIIDEState {
>   
>   void bmdma_init(IDEBus *bus, BMDMAState *bm, PCIIDEState *d);
>   void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val);
> +void bmdma_status_writeb(BMDMAState *bm, uint32_t val);
>   extern MemoryRegionOps bmdma_addr_ioport_ops;
>   void pci_ide_create_devs(PCIDevice *dev);
>   
> diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
> index a094a6e12a..cabe9048b1 100644
> --- a/hw/ide/cmd646.c
> +++ b/hw/ide/cmd646.c
> @@ -144,7 +144,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
>           cmd646_update_irq(pci_dev);
>           break;
>       case 2:
> -        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
> +        bmdma_status_writeb(bm, val);
>           break;
>       case 3:
>           if (bm == &bm->pci_dev->bmdma[0]) {
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 4cf1e9c679..b258fd2f50 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -318,6 +318,11 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
>       bm->cmd = val & 0x09;
>   }
>   
> +void bmdma_status_writeb(BMDMAState *bm, uint32_t val)
> +{
> +    bm->status = (val & 0x60) | (bm->status & BM_STATUS_DMAING) | (bm->status & ~val & 0x06);

Does this fit the 80 char limit if you run the series through scripts/checkpatch.pl?

> +}
> +
>   static uint64_t bmdma_addr_read(void *opaque, hwaddr addr,
>                                   unsigned width)
>   {
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index a32f7ccece..47e0b474c3 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -76,7 +76,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
>           bmdma_cmd_writeb(bm, val);
>           break;
>       case 2:
> -        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
> +        bmdma_status_writeb(bm, val);
>           break;
>       }
>   }
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 5dd3d03c29..63dc4a0494 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -149,8 +149,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
>           break;
>       case 0x02:
>       case 0x12:
> -        d->i.bmdma[0].status = (val & 0x60) | (d->i.bmdma[0].status & 1) |
> -                               (d->i.bmdma[0].status & ~val & 6);
> +        bmdma_status_writeb(&d->i.bmdma[0], val);
>           break;
>       case 0x04 ... 0x07:
>           bmdma_addr_ioport_ops.write(&d->i.bmdma[0], addr - 4, val, size);
> @@ -165,8 +164,7 @@ static void sii3112_reg_write(void *opaque, hwaddr addr,
>           break;
>       case 0x0a:
>       case 0x1a:
> -        d->i.bmdma[1].status = (val & 0x60) | (d->i.bmdma[1].status & 1) |
> -                               (d->i.bmdma[1].status & ~val & 6);
> +        bmdma_status_writeb(&d->i.bmdma[1], val);
>           break;
>       case 0x0c ... 0x0f:
>           bmdma_addr_ioport_ops.write(&d->i.bmdma[1], addr - 12, val, size);
> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 91253fa4ef..fff23803a6 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -75,7 +75,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
>           bmdma_cmd_writeb(bm, val);
>           break;
>       case 2:
> -        bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
> +        bmdma_status_writeb(bm, val);
>           break;
>       default:;
>       }

Otherwise looks good to me:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.


