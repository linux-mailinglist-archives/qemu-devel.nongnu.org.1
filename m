Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D651743BCC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 14:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFD9X-0006Bb-49; Fri, 30 Jun 2023 08:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qFD9T-0006B1-53; Fri, 30 Jun 2023 08:23:05 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qFD9Q-0006jI-K5; Fri, 30 Jun 2023 08:23:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qsvbf45W4z4whk;
 Fri, 30 Jun 2023 22:22:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qsvbc5rPRz4wb5;
 Fri, 30 Jun 2023 22:22:52 +1000 (AEST)
Message-ID: <f32ab985-c513-aa7e-f6b4-440dfa6dd0c5@kaod.org>
Date: Fri, 30 Jun 2023 14:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/psi: Allow access to PSI registers through xscom
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 joel@jms.id.au, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230630102609.193214-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630102609.193214-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.095,
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

On 6/30/23 12:26, Frederic Barrat wrote:
> skiboot only uses mmio to access the PSI registers (once the BAR is
> set) but we don't have any reason to block the accesses through
> xscom. This patch enables xscom access to the PSI registers. It
> converts the xscom addresses to mmio addresses, which requires a bit
> of care for the PSIHB, then reuse the existing mmio ops.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Looks good.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.




> ---
>   hw/ppc/pnv_psi.c | 31 +++++++++++++++++++++----------
>   1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 8aa09ab26b..46da58dff8 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -121,8 +121,12 @@
>   #define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
>   #define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
>   
> +/* mmio address to xscom address */
>   #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
>   
> +/* xscom address to mmio address */
> +#define PSIHB_MMIO(reg) ((reg - PSIHB_XSCOM_BAR) << 3)
> +
>   static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>   {
>       PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
> @@ -769,24 +773,31 @@ static const MemoryRegionOps pnv_psi_p9_mmio_ops = {
>   
>   static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, unsigned size)
>   {
> -    /* No read are expected */
> -    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "\n", addr);
> -    return -1;
> +    uint32_t reg = addr >> 3;
> +    uint64_t val = -1;
> +
> +    if (reg < PSIHB_XSCOM_BAR) {
> +        /* FIR, not modeled */
> +        qemu_log_mask(LOG_UNIMP, "PSI: xscom read at 0x%08x\n", reg);
> +    } else {
> +        val = pnv_psi_p9_mmio_read(opaque, PSIHB_MMIO(reg), size);
> +    }
> +    return val;
>   }
>   
>   static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
>                                   uint64_t val, unsigned size)
>   {
>       PnvPsi *psi = PNV_PSI(opaque);
> +    uint32_t reg = addr >> 3;
>   
> -    /* XSCOM is only used to set the PSIHB MMIO region */
> -    switch (addr >> 3) {
> -    case PSIHB_XSCOM_BAR:
> +    if (reg < PSIHB_XSCOM_BAR) {
> +        /* FIR, not modeled */
> +        qemu_log_mask(LOG_UNIMP, "PSI: xscom write at 0x%08x\n", reg);
> +    } else if (reg == PSIHB_XSCOM_BAR) {
>           pnv_psi_set_bar(psi, val);
> -        break;
> -    default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRIx64 "\n",
> -                      addr);
> +    } else {
> +        pnv_psi_p9_mmio_write(opaque, PSIHB_MMIO(reg), val, size);
>       }
>   }
>   


