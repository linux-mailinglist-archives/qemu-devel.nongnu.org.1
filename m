Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4153273B38A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd5P-00032g-CT; Fri, 23 Jun 2023 05:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd5L-0002ty-PB; Fri, 23 Jun 2023 05:28:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd5K-00058N-05; Fri, 23 Jun 2023 05:28:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX371l8lz4x3k;
 Fri, 23 Jun 2023 19:28:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX360RmPz4x1f;
 Fri, 23 Jun 2023 19:28:01 +1000 (AEST)
Message-ID: <66c9224d-6bd1-a617-7059-c629facfb833@kaod.org>
Date: Fri, 23 Jun 2023 11:28:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pnv/pci: Clean up error messages
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230619233636.57452-1-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230619233636.57452-1-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/20/23 01:36, Joel Stanley wrote:
> The phb error macros add a newline for you, so remove the second one to
> avoid double whitespace.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Applied to ppc-next.

Thanks,

C.



> ---
>   hw/pci-host/pnv_phb4.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 542f9e293221..6232cbeee161 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -133,13 +133,13 @@ static void pnv_phb4_rc_config_write(PnvPHB4 *phb, unsigned off,
>       PCIDevice *pdev;
>   
>       if (size != 4) {
> -        phb_error(phb, "rc_config_write invalid size %d\n", size);
> +        phb_error(phb, "rc_config_write invalid size %d", size);
>           return;
>       }
>   
>       pdev = pci_find_device(pci->bus, 0, 0);
>       if (!pdev) {
> -        phb_error(phb, "rc_config_write device not found\n");
> +        phb_error(phb, "rc_config_write device not found");
>           return;
>       }
>   
> @@ -155,13 +155,13 @@ static uint64_t pnv_phb4_rc_config_read(PnvPHB4 *phb, unsigned off,
>       uint64_t val;
>   
>       if (size != 4) {
> -        phb_error(phb, "rc_config_read invalid size %d\n", size);
> +        phb_error(phb, "rc_config_read invalid size %d", size);
>           return ~0ull;
>       }
>   
>       pdev = pci_find_device(pci->bus, 0, 0);
>       if (!pdev) {
> -        phb_error(phb, "rc_config_read device not found\n");
> +        phb_error(phb, "rc_config_read device not found");
>           return ~0ull;
>       }
>   
> @@ -1039,19 +1039,19 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
>           if (phb->nest_regs[PEC_NEST_STK_BAR_EN] &
>               (PEC_NEST_STK_BAR_EN_MMIO0 |
>                PEC_NEST_STK_BAR_EN_MMIO1)) {
> -            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
> +            phb_pec_error(pec, "Changing enabled BAR unsupported");
>           }
>           phb->nest_regs[reg] = val & 0xffffffffff000000ull;
>           break;
>       case PEC_NEST_STK_PHB_REGS_BAR:
>           if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_PHB) {
> -            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
> +            phb_pec_error(pec, "Changing enabled BAR unsupported");
>           }
>           phb->nest_regs[reg] = val & 0xffffffffffc00000ull;
>           break;
>       case PEC_NEST_STK_INT_BAR:
>           if (phb->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_INT) {
> -            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
> +            phb_pec_error(pec, "Changing enabled BAR unsupported");
>           }
>           phb->nest_regs[reg] = val & 0xfffffff000000000ull;
>           break;


