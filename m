Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D6978E76E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:56:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcWg-0002rO-Qf; Thu, 31 Aug 2023 03:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcWe-0002qi-La; Thu, 31 Aug 2023 03:55:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcWb-0001xf-OP; Thu, 31 Aug 2023 03:55:36 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7dQXe029465; Thu, 31 Aug 2023 07:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=OrOlnLaF44Lp7Lw7xqlWZmfA5qPGUn6WZuZXKkjQ8qg=;
 b=oKiHkoa6W/Jr8j/h0LeNOFJkAQhZgsdrIRkrZR5WCGndfXQoo1Ru3e22ey4yJQo6qyxW
 iR01uMo8p6zZlVjAhzKRUyo4EwBpZXD/ogLqokvQ34DYboNJcQvmOD2boAK2paIPJ+CA
 HpeuBKE8XG29Sh8To9Uinyp2heGV7NW12vm/TYrshp+fP7ulBVqChnPwsbPhy/suhGI0
 F5dNSB+6CbBkM2XvMAQDQXl7GPxfWvNW+vdiNyNEmB0cDfqEWScxYqOPPnnBqNsMVcVN
 FIRsXTPa+rh9C5Gak73002r3Yzic0ik6SWAXwwGsOJS1tBS5Hwm6zhcehMs26MS8pXck PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ste4ku8ek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:55:23 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V7g5IW005972;
 Thu, 31 Aug 2023 07:55:23 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ste4ku8e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:55:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7RR2g014115; Thu, 31 Aug 2023 07:55:22 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxka9k5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:55:22 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37V7tKmZ46137642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 07:55:20 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 566B72004B;
 Thu, 31 Aug 2023 07:55:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11E5820043;
 Thu, 31 Aug 2023 07:55:20 +0000 (GMT)
Received: from [9.179.13.135] (unknown [9.179.13.135])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 31 Aug 2023 07:55:19 +0000 (GMT)
Message-ID: <1c97cd3b-e3f5-2624-9992-c4d1a377e1ca@linux.ibm.com>
Date: Thu, 31 Aug 2023 09:55:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] ppc/xive: Handle END triggers between chips with MMIOs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230829143236.219348-1-clg@kaod.org>
 <20230829143236.219348-4-clg@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230829143236.219348-4-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jSiSD8t_S2mof1JR6AkurKwNAL1GHSOo
X-Proofpoint-GUID: fkw_dglRevINp2524lE6cqZV0EDcCQxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_05,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 mlxlogscore=973 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310067
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 29/08/2023 16:32, Cédric Le Goater wrote:
> The notify page of the interrupt controller can either be used to
> receive trigger events from the HW controllers (PHB, PSI) or to
> reroute interrupts between Interrupt Controllers. In which case, the
> VSD table is used to determine the address of the notify page of the
> remote IC and the store data is forwarded.
> 
> Today, our model grabs the remote VSD (EAS, END, NVT) address using
> pnv_xive_get_remote() helper. Be more precise and implement remote END
> triggers using a store on the remote IC notify page.
> 
> We still have a shortcut in the model for the NVT accesses which we
> will address later.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---


Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   hw/intc/pnv_xive_regs.h |  1 +
>   hw/intc/pnv_xive.c      | 69 +++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive_regs.h b/hw/intc/pnv_xive_regs.h
> index c78f030c0260..793847638bce 100644
> --- a/hw/intc/pnv_xive_regs.h
> +++ b/hw/intc/pnv_xive_regs.h
> @@ -228,6 +228,7 @@
>    *       VSD and is only meant to be used in indirect mode !
>    */
>   #define VSD_MODE                PPC_BITMASK(0, 1)
> +#define  VSD_MODE_INVALID       0
>   #define  VSD_MODE_SHARED        1
>   #define  VSD_MODE_EXCLUSIVE     2
>   #define  VSD_MODE_FORWARD       3
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index b2bafd61b157..aae5cb6f607b 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -225,6 +225,11 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
>   
>       /* Remote VST access */
>       if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
> +        if (type != VST_TSEL_VPDT) {
> +            xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
> +                       info->name, blk, idx);
> +            return 0;
> +        }
>           xive = pnv_xive_get_remote(blk);
>   
>           return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
> @@ -294,12 +299,26 @@ static int pnv_xive_vst_write(PnvXive *xive, uint32_t type, uint8_t blk,
>   static int pnv_xive_get_end(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>                               XiveEND *end)
>   {
> +    PnvXive *xive = PNV_XIVE(xrtr);
> +
> +    if (pnv_xive_block_id(xive) != blk) {
> +        xive_error(xive, "VST: END %x/%x is remote !?", blk, idx);
> +        return -1;
> +    }
> +
>       return pnv_xive_vst_read(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, end);
>   }
>   
>   static int pnv_xive_write_end(XiveRouter *xrtr, uint8_t blk, uint32_t idx,
>                                 XiveEND *end, uint8_t word_number)
>   {
> +    PnvXive *xive = PNV_XIVE(xrtr);
> +
> +    if (pnv_xive_block_id(xive) != blk) {
> +        xive_error(xive, "VST: END %x/%x is remote !?", blk, idx);
> +        return -1;
> +    }
> +
>       return pnv_xive_vst_write(PNV_XIVE(xrtr), VST_TSEL_EQDT, blk, idx, end,
>                                 word_number);
>   }
> @@ -1368,6 +1387,50 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops = {
>   #define PNV_XIVE_SYNC_PUSH          0xf00 /* Sync push context */
>   #define PNV_XIVE_SYNC_VPC           0xf80 /* Sync remove VPC store */
>   
> +static void pnv_xive_end_notify(XiveRouter *xrtr, XiveEAS *eas)
> +{
> +    PnvXive *xive = PNV_XIVE(xrtr);
> +    uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
> +    uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
> +    uint32_t end_data = xive_get_field64(EAS_END_DATA, eas->w);
> +    uint64_t end_vsd = xive->vsds[VST_TSEL_EQDT][end_blk];
> +
> +    switch (GETFIELD(VSD_MODE, end_vsd)) {
> +    case VSD_MODE_EXCLUSIVE:
> +        /* Perform the END notification on the local IC. */
> +        xive_router_end_notify(xrtr, eas);
> +        break;
> +
> +    case VSD_MODE_FORWARD: {
> +        MemTxResult result;
> +        uint64_t notif_port = end_vsd & VSD_ADDRESS_MASK;
> +        uint64_t data = XIVE_TRIGGER_END | XIVE_TRIGGER_PQ |
> +            be64_to_cpu(eas->w);
> +
> +        /* Forward the store on the remote IC notify page. */
> +        address_space_stq_be(&address_space_memory, notif_port, data,
> +                             MEMTXATTRS_UNSPECIFIED, &result);
> +        if (result != MEMTX_OK) {
> +            xive_error(xive, "IC: Forward notif END %x/%x [%x] failed @%"
> +                       HWADDR_PRIx, end_blk, end_idx, end_data, notif_port);
> +            return;
> +        }
> +        break;
> +    }
> +
> +    case VSD_MODE_INVALID:
> +    default:
> +        /* Set FIR */
> +        xive_error(xive, "IC: Invalid END VSD for block %x", end_blk);
> +        return;
> +    }
> +}
> +
> +/*
> + * The notify page can either be used to receive trigger events from
> + * the HW controllers (PHB, PSI) or to reroute interrupts between
> + * Interrupt controllers.
> + */
>   static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t val)
>   {
>       uint8_t blk;
> @@ -1376,8 +1439,8 @@ static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t val)
>       trace_pnv_xive_ic_hw_trigger(addr, val);
>   
>       if (val & XIVE_TRIGGER_END) {
> -        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"PRIx64,
> -                   addr, val);
> +        val = cpu_to_be64(val);
> +        pnv_xive_end_notify(XIVE_ROUTER(xive), (XiveEAS *) &val);
>           return;
>       }
>   
> @@ -1917,6 +1980,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
>       memory_region_init_io(&xive->ic_notify_mmio, OBJECT(dev),
>                             &pnv_xive_ic_notify_ops,
>                             xive, "xive-ic-notify", 1 << xive->ic_shift);
> +    xive->ic_notify_mmio.disable_reentrancy_guard = true;
>   
>       /* The Pervasive LSI trigger and EOI pages (not modeled) */
>       memory_region_init_io(&xive->ic_lsi_mmio, OBJECT(dev), &pnv_xive_ic_lsi_ops,
> @@ -2017,6 +2081,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
>       xrc->get_nvt = pnv_xive_get_nvt;
>       xrc->write_nvt = pnv_xive_write_nvt;
>       xrc->get_block_id = pnv_xive_get_block_id;
> +    xrc->end_notify = pnv_xive_end_notify;
>   
>       xnc->notify = pnv_xive_notify;
>       xpc->match_nvt  = pnv_xive_match_nvt;

