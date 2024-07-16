Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E2E932138
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 09:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcdG-0005ao-FV; Tue, 16 Jul 2024 03:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTcdD-0005OL-So; Tue, 16 Jul 2024 03:29:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTccz-0006fw-FL; Tue, 16 Jul 2024 03:29:51 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNW0v0Bmmz4w2R;
 Tue, 16 Jul 2024 17:29:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNW0r50V0z4wbh;
 Tue, 16 Jul 2024 17:29:32 +1000 (AEST)
Message-ID: <322f6d78-4214-40a6-8e37-e1c93b9b467d@kaod.org>
Date: Tue, 16 Jul 2024 09:29:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] pnv/xive2: Add NVG and NVC to cache watch facility
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
 <20240715183332.27287-5-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240715183332.27287-5-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/15/24 20:33, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> The cache watch facility uses the same register interface to handle
> entries in the NVP, NVG and NVC tables. A bit-field in the 'watchX
> specification' register tells the table type. So far, that bit-field
> was not read and the code assumed a read/write to the NVP table.
> 
> This patch allows to read/write entries in the NVG and NVC table as
> well.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
> ---
>   hw/intc/pnv_xive2.c | 59 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 42 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index d62ac20d98..c72c66dd6a 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -462,46 +462,71 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>                                 word_number);
>   }
>   
> -static int pnv_xive2_nvp_update(PnvXive2 *xive, uint8_t watch_engine)
> +static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
>   {
> -    uint8_t  blk;
> -    uint32_t idx;
> +    switch (nxc_type) {
> +    case PC_NXC_WATCH_NXC_NVP:
> +        *table_type = VST_NVP;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVG:
> +        *table_type = VST_NVG;
> +        break;
> +    case PC_NXC_WATCH_NXC_NVC:
> +        *table_type = VST_NVC;
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: invalid table type for nxc operation\n");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int pnv_xive2_nxc_update(PnvXive2 *xive, uint8_t watch_engine)
> +{
> +    uint8_t  blk, nxc_type;
> +    uint32_t idx, table_type = -1;
>       int i, spec_reg, data_reg;
>       uint64_t nxc_watch[4];
>   
> -    if (watch_engine > 3) {
> -        return -1;
> -    }
> +    assert(watch_engine < ARRAY_SIZE(nxc_watch));
> +

This belongs to patch 1.

>       spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>       data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
>       blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>       idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>   
> +    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
> +
>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
>           nxc_watch[i] = cpu_to_be64(xive->pc_regs[data_reg + i]);
>       }
>   
> -    return pnv_xive2_vst_write(xive, VST_NVP, blk, idx, nxc_watch,
> +    return pnv_xive2_vst_write(xive, table_type, blk, idx, nxc_watch,
>                                 XIVE_VST_WORD_ALL);
>   }
>   
> -static void pnv_xive2_nvp_cache_load(PnvXive2 *xive, uint8_t watch_engine)
> +static void pnv_xive2_nxc_cache_load(PnvXive2 *xive, uint8_t watch_engine)
>   {
> -    uint8_t  blk;
> -    uint32_t idx;
> +    uint8_t  blk, nxc_type;
> +    uint32_t idx, table_type = -1;
>       uint64_t nxc_watch[4] = { 0 };
>       int i, spec_reg, data_reg;
>   
> -    if (watch_engine > 3) {
> -        return;
> -    }
> +    assert(watch_engine < ARRAY_SIZE(nxc_watch));
> +
>       spec_reg = (PC_NXC_WATCH0_SPEC + watch_engine * 0x40) >> 3;
>       data_reg = (PC_NXC_WATCH0_DATA0 + watch_engine * 0x40) >> 3;
> +    nxc_type = GETFIELD(PC_NXC_WATCH_NXC_TYPE, xive->pc_regs[spec_reg]);
>       blk = GETFIELD(PC_NXC_WATCH_BLOCK_ID, xive->pc_regs[spec_reg]);
>       idx = GETFIELD(PC_NXC_WATCH_INDEX, xive->pc_regs[spec_reg]);
>   
> -    if (pnv_xive2_vst_read(xive, VST_NVP, blk, idx, nxc_watch)) {
> -        xive2_error(xive, "VST: no NVP entry %x/%x !?", blk, idx);
> +    assert(pnv_xive2_nxc_to_table_type(nxc_type, &table_type));
> +
> +    if (pnv_xive2_vst_read(xive, table_type, blk, idx, nxc_watch)) {
> +        xive2_error(xive, "VST: no NXC entry %x/%x in %s table!?",
> +                    blk, idx, vst_infos[table_type].name);
>       }
>   
>       for (i = 0; i < ARRAY_SIZE(nxc_watch); i++) {
> @@ -1431,7 +1456,7 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>           * SPEC register
>           */
>           watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
> -        pnv_xive2_nvp_cache_load(xive, watch_engine);
> +        pnv_xive2_nxc_cache_load(xive, watch_engine);
>           val = xive->pc_regs[reg];
>           break;
>   
> @@ -1505,7 +1530,7 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>           /* writing to DATA0 triggers the cache write */
>           watch_engine = (offset - PC_NXC_WATCH0_DATA0) >> 6;
>           xive->pc_regs[reg] = val;
> -        pnv_xive2_nvp_update(xive, watch_engine);
> +        pnv_xive2_nxc_update(xive, watch_engine);
>           break;
>   
>      /* case PC_NXC_FLUSH_CTRL: */


