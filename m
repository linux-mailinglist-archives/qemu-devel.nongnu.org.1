Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD17185D6
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 17:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NWH-0002LD-2v; Wed, 31 May 2023 11:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4NWB-0002Ju-JI; Wed, 31 May 2023 11:13:43 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4NW8-0005M7-UL; Wed, 31 May 2023 11:13:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWXpR5Mzgz4x49;
 Thu,  1 Jun 2023 01:13:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWXpP6SvXz4x42;
 Thu,  1 Jun 2023 01:13:33 +1000 (AEST)
Message-ID: <f529c668-7c27-4368-4e21-faa8afeb744c@kaod.org>
Date: Wed, 31 May 2023 17:13:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pnv/xive2: Quiet down some error messages
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230531150537.369350-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531150537.369350-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vahk=BU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 5/31/23 17:05, Frederic Barrat wrote:
> When dumping the END and NVP tables ("info pic" from the HMP) on the
> P10 model, we're likely to be flooded with error messages such as:
> 
>    XIVE[0] - VST: invalid NVPT entry f33800 !?
> 
> The error is printed when finding an empty VSD in an indirect
> table (thus END and NVP tables with skiboot), which is going to happen
> when dumping the xive state. So let's tune down those messages. They
> can be re-enabled easily with a macro if needed.
> 
> Those errors were already hidden on xive/P9, for the same reason.

yes.

  
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   hw/intc/pnv_xive2.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index c80316657a..397679390c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -163,7 +163,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>       ldq_be_dma(&address_space_memory, vsd_addr, &vsd, MEMTXATTRS_UNSPECIFIED);
>   
>       if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE2_DEBUG
>           xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
> +#endif
>           return 0;
>       }
>   
> @@ -185,7 +187,9 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
>                      MEMTXATTRS_UNSPECIFIED);
>   
>           if (!(vsd & VSD_ADDRESS_MASK)) {
> +#ifdef XIVE2_DEBUG
>               xive2_error(xive, "VST: invalid %s entry %x !?", info->name, idx);
> +#endif
>               return 0;
>           }
>   


