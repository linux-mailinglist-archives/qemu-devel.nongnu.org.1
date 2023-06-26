Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC473DC65
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjgA-0006BI-Fl; Mon, 26 Jun 2023 06:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDjg6-0006B0-54; Mon, 26 Jun 2023 06:42:38 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDjg2-0001MR-Iy; Mon, 26 Jun 2023 06:42:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqPYc0Hxnz4wZx;
 Mon, 26 Jun 2023 20:42:28 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqPYY4HRNz4w23;
 Mon, 26 Jun 2023 20:42:25 +1000 (AEST)
Message-ID: <ec69ce13-d4ad-6180-4d5a-77b449165eac@kaod.org>
Date: Mon, 26 Jun 2023 12:42:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
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

On 6/26/23 11:40, Frederic Barrat wrote:
> Booting linux on the powernv10 machine logs a few errors like:
> 
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
> 
> Those errors happen when linux is resetting XIVE. We're trying to
> read/write the enablement bit for the hardware context and qemu
> doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
> access can go through though, as well as indirect TIMA accesses on P9.
> So even though there are some restrictions regarding the address/size
> combinations for TIMA access, the example above is perfectly valid.
> 
> This patch lets indirect TIMA accesses of all sizes go through. The
> special operations will be intercepted and the default "raw" handlers
> will pick up all other requests and complain about invalid sizes as
> appropriate.
> 
> Tested-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index ed438a20ed..e8ab176de6 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1644,11 +1644,11 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
>       .write = pnv_xive2_ic_tm_indirect_write,
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


This makes the TM indirect ops and the TM direct ops similar on P10.
Same as P9

LGTM,


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


