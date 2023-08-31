Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807078E773
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 09:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbcYb-0004Ew-Um; Thu, 31 Aug 2023 03:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcYZ-0004Ed-Rh; Thu, 31 Aug 2023 03:57:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qbcYX-0002Cf-Dz; Thu, 31 Aug 2023 03:57:35 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V7k1AR008264; Thu, 31 Aug 2023 07:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TPJAc8wfPbguUUzoWnvd5jGFxDjGi16T8MJPSYal6sQ=;
 b=bXGEzTp+KNkYdgWKOJFyqKUFOzygof9/CAYATr/l5jkWgiRnRaGQsydZe4sIKY9YlIRX
 /4mhKRvsZfqN3P6qzF+rJyA5niqJKYfU0bwcmRaQeMZcU3sfkLdsOGGIg3/eRS+omg7G
 7uTt5dkl0ARoACRStdpOk4hvwxelcePNEjrvjhwwKhXKvcSg+DQmU8N1AWLvZ4f4tYwO
 XH4QNDBcDeLihzJB0yHwAD+7LVSW+nJ/jjNcH0Vk//4fSpDzbn4/G0GhmizcYp4ZFmxl
 wnXvydiBx970L/qNDITZPwLiNMz8wBnFdWAOXz6oVheZkt/B69yTkqQzsWEhcpRnnQh/ wA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stbvypw94-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:57:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37V7qvaj000364;
 Thu, 31 Aug 2023 07:57:24 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3stbvypw90-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:57:23 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37V5i7SP019174; Thu, 31 Aug 2023 07:57:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe2252n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Aug 2023 07:57:23 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37V7vLMh39190898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 07:57:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F38E20040;
 Thu, 31 Aug 2023 07:57:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 321EB20043;
 Thu, 31 Aug 2023 07:57:21 +0000 (GMT)
Received: from [9.179.13.135] (unknown [9.179.13.135])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 31 Aug 2023 07:57:21 +0000 (GMT)
Message-ID: <f582e58c-487f-3947-6d9d-39552e1a8193@linux.ibm.com>
Date: Thu, 31 Aug 2023 09:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/4] ppc/xive: Add support for the PC MMIOs
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230829143236.219348-1-clg@kaod.org>
 <20230829143236.219348-5-clg@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <20230829143236.219348-5-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: boANMJTU_C1yQwwgPH1Lz1mpI2BmsSFP
X-Proofpoint-ORIG-GUID: wtYMK-1ch_0Hxe-VrHDjhQPMvTKKoW_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_05,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310067
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> The XIVE interrupt contoller maintains various fields on interrupt
> targets in a structure called NVT. Each unit has a NVT cache, backed
> by RAM.
> 
> When the NVT structure is not local (in RAM) to the chip, the XIVE
> interrupt controller forwards the memory operation to the owning chip
> using the PC MMIO region configured for this purpose. QEMU does not
> need to be so precise since software shouldn't perform any of these
> operations. The model implementation is simplified to return the RAM
> address of the NVT structure which is then used by pnv_xive_vst_write
> or read to perform the operation in RAM.
> 
> Remove the last use of pnv_xive_get_remote().
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> -


Nice cleanup

Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>

   Fred


>   hw/intc/pnv_xive.c | 84 ++++++++++++++++++++++++++--------------------
>   1 file changed, 48 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index aae5cb6f607b..9b10e905195a 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -84,28 +84,6 @@ static uint8_t pnv_xive_block_id(PnvXive *xive)
>       return blk;
>   }
>   
> -/*
> - * Remote access to controllers. HW uses MMIOs. For now, a simple scan
> - * of the chips is good enough.
> - *
> - * TODO: Block scope support
> - */
> -static PnvXive *pnv_xive_get_remote(uint8_t blk)
> -{
> -    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
> -    int i;
> -
> -    for (i = 0; i < pnv->num_chips; i++) {
> -        Pnv9Chip *chip9 = PNV9_CHIP(pnv->chips[i]);
> -        PnvXive *xive = &chip9->xive;
> -
> -        if (pnv_xive_block_id(xive) == blk) {
> -            return xive;
> -        }
> -    }
> -    return NULL;
> -}
> -
>   /*
>    * VST accessors for SBE, EAT, ENDT, NVT
>    *
> @@ -209,6 +187,42 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *xive, uint32_t type,
>       return pnv_xive_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
>   }
>   
> +/*
> + * This is a simplified model of operation forwarding on a remote IC.
> + *
> + * A PC MMIO address is built to identify the NVT structure. The load
> + * on the remote IC will return the address of the structure in RAM,
> + * which will then be used by pnv_xive_vst_write/read to perform the
> + * RAM operation.
> + */
> +static uint64_t pnv_xive_vst_addr_remote(PnvXive *xive, uint32_t type,
> +                                         uint64_t vsd, uint8_t blk,
> +                                         uint32_t idx)
> +{
> +    const XiveVstInfo *info = &vst_infos[type];
> +    uint64_t remote_addr = vsd & VSD_ADDRESS_MASK;
> +    uint64_t vst_addr;
> +    MemTxResult result;
> +
> +    if (type != VST_TSEL_VPDT) {
> +        xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
> +                   info->name, blk, idx);
> +        return 0;
> +    }
> +
> +    remote_addr |= idx << xive->pc_shift;
> +
> +    vst_addr = address_space_ldq_be(&address_space_memory, remote_addr,
> +                                    MEMTXATTRS_UNSPECIFIED, &result);
> +    if (result != MEMTX_OK) {
> +        xive_error(xive, "VST: read failed at @0x%"  HWADDR_PRIx
> +                   " for NVT %x/%x\n", remote_addr, blk, idx);
> +        return 0;
> +    }
> +
> +    return vst_addr;
> +}
> +
>   static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
>                                     uint32_t idx)
>   {
> @@ -225,14 +239,7 @@ static uint64_t pnv_xive_vst_addr(PnvXive *xive, uint32_t type, uint8_t blk,
>   
>       /* Remote VST access */
>       if (GETFIELD(VSD_MODE, vsd) == VSD_MODE_FORWARD) {
> -        if (type != VST_TSEL_VPDT) {
> -            xive_error(xive, "VST: invalid access on remote VST %s %x/%x !?",
> -                       info->name, blk, idx);
> -            return 0;
> -        }
> -        xive = pnv_xive_get_remote(blk);
> -
> -        return xive ? pnv_xive_vst_addr(xive, type, blk, idx) : 0;
> +        return pnv_xive_vst_addr_remote(xive, type, vsd, blk, idx);
>       }
>   
>       if (VSD_INDIRECT & vsd) {
> @@ -1785,16 +1792,20 @@ static const MemoryRegionOps pnv_xive_vc_ops = {
>   };
>   
>   /*
> - * Presenter Controller MMIO region. The Virtualization Controller
> - * updates the IPB in the NVT table when required. Not modeled.
> + * Presenter Controller MMIO region. Points to the NVT sets.
> + *
> + * HW implements all possible mem ops to the underlying NVT structure
> + * but QEMU does not need to be so precise. The model implementation
> + * simply returns the RAM address of the NVT structure which is then
> + * used by pnv_xive_vst_write/read to perform the RAM operation.
>    */
> -static uint64_t pnv_xive_pc_read(void *opaque, hwaddr addr,
> -                                 unsigned size)
> +static uint64_t pnv_xive_pc_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       PnvXive *xive = PNV_XIVE(opaque);
> +    uint32_t nvt_idx = offset >> xive->pc_shift;
> +    uint8_t blk = pnv_xive_block_id(xive); /* TODO: VDT -> block xlate */
>   
> -    xive_error(xive, "PC: invalid read @%"HWADDR_PRIx, addr);
> -    return -1;
> +    return pnv_xive_vst_addr(xive, VST_TSEL_VPDT, blk, nvt_idx);
>   }
>   
>   static void pnv_xive_pc_write(void *opaque, hwaddr addr,
> @@ -2016,6 +2027,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
>       /* Presenter Controller MMIO region (not modeled) */
>       memory_region_init_io(&xive->pc_mmio, OBJECT(xive), &pnv_xive_pc_ops, xive,
>                             "xive-pc", PNV9_XIVE_PC_SIZE);
> +    xive->pc_mmio.disable_reentrancy_guard = true;
>   
>       /* Thread Interrupt Management Area (Direct) */
>       memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &pnv_xive_tm_ops,

