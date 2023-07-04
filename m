Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA27747797
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 19:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGjcc-0006l9-2U; Tue, 04 Jul 2023 13:15:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGjcS-0006jv-9t; Tue, 04 Jul 2023 13:15:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGjcJ-0001mA-Q6; Tue, 04 Jul 2023 13:15:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwTts4wdTz4wZw;
 Wed,  5 Jul 2023 03:15:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwTtq6RKYz4wqZ;
 Wed,  5 Jul 2023 03:14:59 +1000 (AEST)
Message-ID: <697082fb-abb4-2e6f-de60-3a24ef1fd049@kaod.org>
Date: Tue, 4 Jul 2023 19:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive: Allow mmio operations of any size on the ESB CI
 pages
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704144848.164287-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230704144848.164287-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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

On 7/4/23 16:48, Frederic Barrat wrote:
> We currently only allow 64-bit operations on the ESB CI pages. There's
> no real reason for that limitation, skiboot/linux didn't need
> more. However the hardware supports any size, so this patch relaxes
> that restriction. It impacts both the ESB pages for "normal"
> interrupts as well as the ESB pages for escalation interrupts defined
> for the ENDs.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> 
> This should wrap-up the cleanup about mmio size for the xive BARs. The
> NVPG and NVC BAR accesses should also be relaxed but we don't really
> implement them, any load/store currently fails. Something to address
> when/if we implement them.
> 
>   hw/intc/xive.c  | 8 ++++----
>   hw/intc/xive2.c | 4 ++--
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index f60c878345..c014e961a4 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1175,11 +1175,11 @@ static const MemoryRegionOps xive_source_esb_ops = {
>       .write = xive_source_esb_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };
> @@ -2006,11 +2006,11 @@ static const MemoryRegionOps xive_end_source_ops = {
>       .write = xive_end_source_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4d9ff41956..c37ef25d44 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -954,11 +954,11 @@ static const MemoryRegionOps xive2_end_source_ops = {
>       .write = xive2_end_source_write,
>       .endianness = DEVICE_BIG_ENDIAN,
>       .valid = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>       .impl = {
> -        .min_access_size = 8,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };


