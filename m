Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D89320F0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 09:07:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTcGq-0003ct-OW; Tue, 16 Jul 2024 03:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTcGo-0003Wq-Pk; Tue, 16 Jul 2024 03:06:42 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org>)
 id 1sTcGm-0002CG-Jx; Tue, 16 Jul 2024 03:06:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WNVVQ1zvLz4wbh;
 Tue, 16 Jul 2024 17:06:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WNVVM6FZsz4wcR;
 Tue, 16 Jul 2024 17:06:35 +1000 (AEST)
Message-ID: <79375108-2b76-4029-8371-011241ec314c@kaod.org>
Date: Tue, 16 Jul 2024 09:06:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] pnv/xive2: Configure Virtualization Structure
 Tables through the PC
To: Michael Kowal <kowal@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
 <20240715183332.27287-6-kowal@linux.vnet.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240715183332.27287-6-kowal@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ZcYX=OQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Both the virtualization layer (VC) and presentation layer (PC) need to
> be configured to access the VSTs. Since the information is redundant,
> the xive model combines both into one set of tables and only the
> definitions going through the VC are kept. The definitions through the
> PC are ignored. That works well as long as firmware calls the VC for
> all the tables.
> 
> For the NVG and NVC tables, it can make sense to only configure them
> with the PC, since they are only used by the presenter. So this patch
> allows firmware to configure the VST tables through the PC as well.
> The definitions are still shared, since the VST tables can be set
> through both the VC and/or PC, they are dynamically re-mapped in
> memory by first deleting the memory subregion.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/intc/pnv_xive2.c | 47 ++++++++++++++++++++++++++++++++++++---------
>   1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index c72c66dd6a..9e45161869 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -759,6 +759,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
>            * entries provisioned by FW (such as skiboot) and resize the
>            * ESB window accordingly.
>            */
> +        if (memory_region_is_mapped(&xsrc->esb_mmio)) {
> +            memory_region_del_subregion(&xive->esb_mmio, &xsrc->esb_mmio);
> +        }
>           if (!(VSD_INDIRECT & vsd)) {
>               memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_BYTE
>                                      * (1ull << xsrc->esb_shift));
> @@ -774,6 +777,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
>           /*
>            * Backing store pages for the END.
>            */
> +        if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
> +            memory_region_del_subregion(&xive->end_mmio, &end_xsrc->esb_mmio);
> +        }
>           if (!(VSD_INDIRECT & vsd)) {
>               memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / info->size)
>                                      * (1ull << end_xsrc->esb_shift));
> @@ -798,13 +804,10 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
>    * Both PC and VC sub-engines are configured as each use the Virtual
>    * Structure Tables
>    */
> -static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
> +static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd,
> +                                   uint8_t type, uint8_t blk)
>   {
>       uint8_t mode = GETFIELD(VSD_MODE, vsd);
> -    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
> -                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
> -    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
> -                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
>       uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
>   
>       if (type > VST_ERQ) {
> @@ -839,6 +842,16 @@ static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
>       }
>   }
>   
> +static void pnv_xive2_vc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
> +{
> +    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
> +                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
> +    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
> +                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
> +
> +    pnv_xive2_vst_set_data(xive, vsd, type, blk);
> +}
> +
>   /*
>    * MMIO handlers
>    */
> @@ -1268,7 +1281,7 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
>       case VC_VSD_TABLE_ADDR:
>          break;
>       case VC_VSD_TABLE_DATA:
> -        pnv_xive2_vst_set_data(xive, val);
> +        pnv_xive2_vc_vst_set_data(xive, val);
>           break;
>   
>       /*
> @@ -1487,6 +1500,16 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
>       return val;
>   }
>   
> +static void pnv_xive2_pc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
> +{
> +    uint8_t type = GETFIELD(PC_VSD_TABLE_SELECT,
> +                            xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
> +    uint8_t blk = GETFIELD(PC_VSD_TABLE_ADDRESS,
> +                           xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
> +
> +    pnv_xive2_vst_set_data(xive, vsd, type, blk);
> +}
> +
>   static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>                                     uint64_t val, unsigned size)
>   {
> @@ -1497,12 +1520,18 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
>       switch (offset) {
>   
>       /*
> -     * VSD table settings. Only taken into account in the VC
> -     * sub-engine because the Xive2Router model combines both VC and PC
> -     * sub-engines
> +     * VSD table settings.
> +     * The Xive2Router model combines both VC and PC sub-engines. We
> +     * allow to configure the tables through both, for the rare cases
> +     * where a table only really needs to be configured for one of
> +     * them (e.g. the NVG table for the presenter). It assumes that
> +     * firmware passes the same address to the VC and PC when tables
> +     * are defined for both, which seems acceptable.
>        */
>       case PC_VSD_TABLE_ADDR:
> +        break;
>       case PC_VSD_TABLE_DATA:
> +        pnv_xive2_pc_vst_set_data(xive, val);
>           break;
>   
>       case PC_NXC_PROC_CONFIG:


