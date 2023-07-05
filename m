Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D27480CD
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 11:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGynI-0003Z8-Tv; Wed, 05 Jul 2023 05:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qGynG-0003Yp-SK; Wed, 05 Jul 2023 05:27:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qGynE-0005vF-Uv; Wed, 05 Jul 2023 05:27:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwvSW3yL3z4wxW;
 Wed,  5 Jul 2023 19:27:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwvSV1Fjqz4wqX;
 Wed,  5 Jul 2023 19:27:05 +1000 (AEST)
Message-ID: <453581d7-4bab-9bda-d26c-39202a47782a@kaod.org>
Date: Wed, 5 Jul 2023 11:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Always pass a presenter object when accessing
 the TIMA
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230705081400.218408-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230705081400.218408-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=c5xU=CX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 7/5/23 10:14, Frederic Barrat wrote:
> The low-level functions to access the TIMA take a presenter object as
> a first argument. When accessing the TIMA from the IC BAR,
> i.e. indirect calls, we currently pass a NULL pointer for the
> presenter argument. While it appears ok with the current usage, it's
> dangerous. And it's pretty easy to figure out the presenter in that
> context, so this patch fixes it.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>



Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 82fcd3ea22..bbb44a533c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1624,6 +1624,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>                                                 unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    XivePresenter *xptr = XIVE_PRESENTER(xive);
>       hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
> @@ -1633,7 +1634,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>       hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
> +        val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
>       }
>   
>       return val;
> @@ -1643,6 +1644,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>                                              uint64_t val, unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    XivePresenter *xptr = XIVE_PRESENTER(xive);
>       hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
> @@ -1651,7 +1653,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>       hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
> +        xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
>       }
>   }
>   


