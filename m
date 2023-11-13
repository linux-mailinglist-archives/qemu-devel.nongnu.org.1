Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1E07EA575
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 22:26:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2eQb-0001tN-5a; Mon, 13 Nov 2023 16:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2eQW-0001sx-4G; Mon, 13 Nov 2023 16:25:00 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2eQO-0007WS-Jt; Mon, 13 Nov 2023 16:24:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 813BB32DDF;
 Tue, 14 Nov 2023 00:25:05 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA59634E7C;
 Tue, 14 Nov 2023 00:24:48 +0300 (MSK)
Message-ID: <6222c257-2732-490c-8f84-3582f501d548@tls.msk.ru>
Date: Tue, 14 Nov 2023 00:24:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] s390x/pci: only limit DMA aperture if vfio DMA
 limit reported
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231110175108.465851-1-mjrosato@linux.ibm.com>
 <20231110175108.465851-3-mjrosato@linux.ibm.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231110175108.465851-3-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

10.11.2023 20:51, Matthew Rosato wrote:
> If the host kernel lacks vfio DMA limit reporting, do not attempt
> to shrink the guest DMA aperture.
> 
> Fixes: df202e3ff3 ("s390x/pci: shrink DMA aperture to be bound by vfio DMA limit")
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>

Is this stable-8.1 material?

Thanks,

/mjt

> ---
>   hw/s390x/s390-pci-vfio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index e28573b593..7dbbc76823 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -136,7 +136,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
>        * to the guest based upon the vfio DMA limit.
>        */
>       vfio_size = pbdev->iommu->max_dma_limit << TARGET_PAGE_BITS;
> -    if (vfio_size < (cap->end_dma - cap->start_dma + 1)) {
> +    if (vfio_size > 0 && vfio_size < cap->end_dma - cap->start_dma + 1) {
>           pbdev->zpci_fn.edma = cap->start_dma + vfio_size - 1;
>       }
>   }


