Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB9743426
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6cu-0002tb-U0; Fri, 30 Jun 2023 01:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6cr-0002TU-Em; Fri, 30 Jun 2023 01:24:57 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Okcj=CS=kaod.org=clg@ozlabs.org>)
 id 1qF6cp-0006Cm-Lb; Fri, 30 Jun 2023 01:24:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskKJ6ydgz4wpc;
 Fri, 30 Jun 2023 15:24:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskKH2Cjwz4wZy;
 Fri, 30 Jun 2023 15:24:51 +1000 (AEST)
Message-ID: <5eb72aa6-ea82-a760-776d-b9456a2475b5@kaod.org>
Date: Fri, 30 Jun 2023 07:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] ppc/pnv: Return zero for core thread state xscom
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230630035547.80329-1-joel@jms.id.au>
 <20230630035547.80329-5-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230630035547.80329-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Okcj=CS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
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

On 6/30/23 05:55, Joel Stanley wrote:
> Firmware now warns if booting in LPAR per core mode (PPC bit 62). So
> this warning doesn't trigger report the core thread state is 0.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/ppc/pnv_core.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7fff2fd9e298..98356d7f6538 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -116,6 +116,8 @@ static const MemoryRegionOps pnv_core_power8_xscom_ops = {
>   #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_HYP 0xf010d
>   #define PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR 0xf010a
>   
> +#define PNV9_XSCOM_EC_CORE_THREAD_STATE    0x10ab3
> +
>   static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>                                              unsigned int width)
>   {
> @@ -134,6 +136,9 @@ static uint64_t pnv_core_power9_xscom_read(void *opaque, hwaddr addr,
>       case PNV9_XSCOM_EC_PPM_SPECIAL_WKUP_OTR:
>           val = 0x0;
>           break;
> +    case PNV9_XSCOM_EC_CORE_THREAD_STATE:
> +        val = 0;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
>                     addr);
> @@ -408,6 +413,8 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
>    * POWER10 Quads
>    */
>   
> +#define PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE 0x28412
> +
>   static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>                                               unsigned int width)
>   {
> @@ -415,6 +422,9 @@ static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
>       uint64_t val = -1;
>   
>       switch (offset) {
> +    case PNV10_XSCOM_EC_PC_PMC_CORE_THREAD_STATE:
> +        val = 0;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
>                         offset);


