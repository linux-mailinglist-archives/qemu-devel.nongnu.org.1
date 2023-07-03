Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0F745748
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEqP-0005DQ-Fm; Mon, 03 Jul 2023 04:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGEqN-0005D4-GT; Mon, 03 Jul 2023 04:23:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGEqK-0006i3-Vq; Mon, 03 Jul 2023 04:23:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qvf7t1lSsz4wZp;
 Mon,  3 Jul 2023 18:23:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qvf7r697Pz4wZJ;
 Mon,  3 Jul 2023 18:23:20 +1000 (AEST)
Message-ID: <797a4272-1c22-9b91-125c-3aaf1bd854b0@kaod.org>
Date: Mon, 3 Jul 2023 10:23:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] pnv/xive2: Fix TIMA offset for indirect access
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230703080858.54060-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703080858.54060-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 7/3/23 10:08, Frederic Barrat wrote:
> Direct TIMA operations can be done through 4 pages, each with a
> different privilege level dictating what fields can be accessed. On
> the other hand, indirect TIMA accesses on P10 are done through a
> single page, which is the equivalent of the most privileged page of
> direct TIMA accesses.
> 
> The offset in the IC bar of an indirect access specifies what hw
> thread is targeted (page shift bits) and the offset in the
> TIMA being accessed (the page offset bits). When the indirect
> access is calling the underlying direct access functions, it is
> therefore important to clearly separate the 2, as the direct functions
> assume any page shift bits define the privilege ring level. For
> indirect accesses, those bits must be 0. This patch fixes the offset
> passed to direct TIMA functions.
> 
> It didn't matter for SMT1, as the 2 least significant bits of the page
> shift are part of the hw thread ID and always 0, so the direct TIMA
> functions were accessing the privilege ring 0 page. With SMT4/8, it is
> no longer true.
> 
> The fix is specific to P10, as indirect TIMA access on P9 was handled
> differently.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
> Changelog:
> v2: rename function and variable
>      rebase to Danel's ppc-next
> 
> hw/intc/pnv_xive2.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index e8ab176de6..82fcd3ea22 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1590,6 +1590,18 @@ static uint32_t pnv_xive2_ic_tm_get_pir(PnvXive2 *xive, hwaddr offset)
>       return xive->chip->chip_id << 8 | offset >> xive->ic_shift;
>   }
>   
> +static uint32_t pnv_xive2_ic_tm_get_hw_page_offset(PnvXive2 *xive,
> +                                                   hwaddr offset)
> +{
> +    /*
> +     * Indirect TIMA accesses are similar to direct accesses for
> +     * privilege ring 0. So remove any traces of the hw thread ID from
> +     * the offset in the IC BAR as it could be interpreted as the ring
> +     * privilege when calling the underlying direct access functions.
> +     */
> +    return offset & ((1ull << xive->ic_shift) - 1);
> +}
> +
>   static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
>   {
>       PnvChip *chip = xive->chip;
> @@ -1612,14 +1624,16 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
>                                                 unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
>       uint64_t val = -1;
>   
>       pir = pnv_xive2_ic_tm_get_pir(xive, offset);
> +    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        val = xive_tctx_tm_read(NULL, tctx, offset, size);
> +        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
>       }
>   
>       return val;
> @@ -1629,13 +1643,15 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
>                                              uint64_t val, unsigned size)
>   {
>       PnvXive2 *xive = PNV_XIVE2(opaque);
> +    hwaddr hw_page_offset;
>       uint32_t pir;
>       XiveTCTX *tctx;
>   
>       pir = pnv_xive2_ic_tm_get_pir(xive, offset);
> +    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
>       tctx = pnv_xive2_get_indirect_tctx(xive, pir);
>       if (tctx) {
> -        xive_tctx_tm_write(NULL, tctx, offset, val, size);
> +        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
>       }
>   }
>   


