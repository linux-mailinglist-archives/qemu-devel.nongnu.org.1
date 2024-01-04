Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00C824951
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 21:00:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLTsW-00072h-7v; Thu, 04 Jan 2024 14:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLTsQ-00072P-Lz
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:59:38 -0500
Received: from jedlik.phy.bme.hu ([152.66.102.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1rLTsO-0006yM-VB
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:59:38 -0500
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id 94E1DA014D; Thu,  4 Jan 2024 20:59:34 +0100 (CET)
Date: Thu, 4 Jan 2024 20:59:34 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: deller@kernel.org
cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 Bruno Haible <bruno@clisp.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 3/9] hw/pci-host/astro: Add missing astro & elroy registers
 for NetBSD
In-Reply-To: <20240104183628.101366-4-deller@kernel.org>
Message-ID: <alpine.LMD.2.03.2401042059000.28870@eik.bme.hu>
References: <20240104183628.101366-1-deller@kernel.org>
 <20240104183628.101366-4-deller@kernel.org>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Received-SPF: none client-ip=152.66.102.83;
 envelope-from=balaton@jedlik.phy.bme.hu; helo=jedlik.phy.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 4 Jan 2024, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
>
> NetBSD accesses some astro and elroy registers which aren't accesses

Typo: accessed by Linux

Regards,
BALATON Zoltan

> by Linux yet. Add emulation for those registers to allow NetBSD to
> boot further.
> Please note that this patch is not sufficient to completely boot up
> NetBSD on the 64-bit C3700 machine yet.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> hw/pci-host/astro.c | 26 +++++++++++++++++++++++---
> 1 file changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
> index 7d68ccee7e..cb2c8a828d 100644
> --- a/hw/pci-host/astro.c
> +++ b/hw/pci-host/astro.c
> @@ -166,6 +166,8 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
>     trace_elroy_write(addr, size, val);
>
>     switch ((addr >> 3) << 3) {
> +    case 0x000: /* PCI_ID & PCI_COMMAND_STATUS_REG */
> +        break;
>     case 0x080:
>         put_val_in_int64(&s->arb_mask, addr, size, val);
>         break;
> @@ -175,6 +177,9 @@ static MemTxResult elroy_chip_write_with_attrs(void *opaque, hwaddr addr,
>     case 0x200 ... 0x250 - 1:   /* LMMIO, GMMIO, WLMMIO, WGMMIO, ... */
>         put_val_in_arrary(s->mmio_base, 0x200, addr, size, val);
>         break;
> +    case 0x300: /* ibase */
> +    case 0x308: /* imask */
> +        break;
>     case 0x0680:
>         put_val_in_int64(&s->error_config, addr, size, val);
>         break;
> @@ -538,6 +543,9 @@ static MemTxResult astro_chip_read_with_attrs(void *opaque, hwaddr addr,
>     case 0x0030:        /* HP-UX 10.20 and 11.11 reads it. No idea. */
>         val = -1;
>         break;
> +    case 0x0078:        /* NetBSD reads 0x78 ? */
> +        val = -1;
> +        break;
>     case 0x0300 ... 0x03d8:     /* LMMIO_DIRECT0_BASE... */
>         index = (addr - 0x300) / 8;
>         val = s->ioc_ranges[index];
> @@ -624,31 +632,43 @@ static MemTxResult astro_chip_write_with_attrs(void *opaque, hwaddr addr,
>     case 0x10220:
>     case 0x10230:        /* HP-UX 11.11 reads it. No idea. */
>         break;
> -    case 0x22108:        /* IOC STATUS_CONTROL */
> -        put_val_in_int64(&s->ioc_status_ctrl, addr, size, val);
> -        break;
>     case 0x20200 ... 0x20240 - 1: /* IOC Rope0_Control ... */
>         put_val_in_arrary(s->ioc_rope_control, 0x20200, addr, size, val);
>         break;
>     case 0x20040:        /* IOC Rope config */
> +    case 0x22040:
>         put_val_in_int64(&s->ioc_rope_config, addr, size, val);
>         break;
>     case 0x20300:
> +    case 0x22300:
>         put_val_in_int64(&s->tlb_ibase, addr, size, val);
>         break;
>     case 0x20308:
> +    case 0x22308:
>         put_val_in_int64(&s->tlb_imask, addr, size, val);
>         break;
>     case 0x20310:
> +    case 0x22310:
>         put_val_in_int64(&s->tlb_pcom, addr, size, val);
>         /* TODO: flush iommu */
>         break;
>     case 0x20318:
> +    case 0x22318:
>         put_val_in_int64(&s->tlb_tcnfg, addr, size, val);
>         break;
>     case 0x20320:
> +    case 0x22320:
>         put_val_in_int64(&s->tlb_pdir_base, addr, size, val);
>         break;
> +    case 0x22000:       /* func_id */
> +        break;
> +    case 0x22008:       /* func_class */
> +        break;
> +    case 0x22050:       /* rope_debug */
> +        break;
> +    case 0x22108:        /* IOC STATUS_CONTROL */
> +        put_val_in_int64(&s->ioc_status_ctrl, addr, size, val);
> +        break;
>     /*
>      * empty placeholders for non-existent elroys, e.g.
>      * func_class, pci config & data
> -- 
> 2.43.0
>
>
>

