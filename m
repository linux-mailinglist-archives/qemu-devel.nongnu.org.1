Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF32746A29
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 08:56:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGZwm-0003TP-HV; Tue, 04 Jul 2023 02:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGZwk-0003SZ-6w; Tue, 04 Jul 2023 02:55:34 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGZwi-0001bg-6R; Tue, 04 Jul 2023 02:55:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwD7y365rz4wxn;
 Tue,  4 Jul 2023 16:55:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwD7w5Ym7z4wZs;
 Tue,  4 Jul 2023 16:55:24 +1000 (AEST)
Message-ID: <075a1389-0e68-7a48-b413-1e037fe176cb@kaod.org>
Date: Tue, 4 Jul 2023 08:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] ppc/pnv: Add P10 core xscom model
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230704054204.168547-1-joel@jms.id.au>
 <20230704054204.168547-5-joel@jms.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230704054204.168547-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 7/4/23 07:42, Joel Stanley wrote:
> Like the quad xscoms, add a core model for P10 to allow future
> differentiation from P9.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/ppc/pnv_core.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index e4df435b15e9..1eec28c88c41 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -167,6 +167,47 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
>       .endianness = DEVICE_BIG_ENDIAN,
>   };
>   
> +/*
> + * POWER10 core controls
> + */
> +
> +static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
> +                                           unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +    uint64_t val = 0;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: reading reg=0x%" HWADDR_PRIx "\n",
> +                  addr);
> +    }
> +
> +    return val;
> +}
> +
> +static void pnv_core_power10_xscom_write(void *opaque, hwaddr addr,
> +                                         uint64_t val, unsigned int width)
> +{
> +    uint32_t offset = addr >> 3;
> +
> +    switch (offset) {
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "Warning: writing to reg=0x%" HWADDR_PRIx "\n",
> +                      addr);
> +    }
> +}
> +
> +static const MemoryRegionOps pnv_core_power10_xscom_ops = {
> +    .read = pnv_core_power10_xscom_read,
> +    .write = pnv_core_power10_xscom_write,
> +    .valid.min_access_size = 8,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 8,
> +    .impl.max_access_size = 8,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
>   static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp)
>   {
>       CPUPPCState *env = &cpu->env;
> @@ -315,8 +356,7 @@ static void pnv_core_power10_class_init(ObjectClass *oc, void *data)
>   {
>       PnvCoreClass *pcc = PNV_CORE_CLASS(oc);
>   
> -    /* TODO: Use the P9 XSCOMs for now on P10 */
> -    pcc->xscom_ops = &pnv_core_power9_xscom_ops;
> +    pcc->xscom_ops = &pnv_core_power10_xscom_ops;
>   }
>   
>   static void pnv_core_class_init(ObjectClass *oc, void *data)


