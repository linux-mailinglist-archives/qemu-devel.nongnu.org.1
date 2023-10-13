Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F17C7DB6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBhI-0001Yv-Ul; Fri, 13 Oct 2023 02:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qrBhG-0001Y0-A5; Fri, 13 Oct 2023 02:30:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qrBhB-0006a8-RR; Fri, 13 Oct 2023 02:30:53 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D6PqIU008532; Fri, 13 Oct 2023 06:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6iv5XOdgqMwIy41aEdNRoYbqzggqd54U8PvkqT3l3q0=;
 b=eNJV6xiEJH6+s0CTm0C71x6UpG9vYeK5f/Dl0vfbpHLSxVJSdgj1yYUO7ILFnM1jYz5c
 ufipJA0LxvLrfHHspPLEHOChGTBYcHAHK9ux4hSRQv3tPPDKC5wN35lK8cm/xjcfHR/G
 5FgV8tltOjHWwvNWxMjlfVnK7KSnQaL/XLJ2NxCWAqkWO7zjCUn6q53pPDymfBJWTIrG
 eiuKDBMr5GcHZAw+Pcmo6bXpsfPdP5jZPCp0kPjjuwu5n1YieK3sHgsyyjtCc3CqkJch
 XLggESpPksqTyBSmGoFj3ERc1GI1NaYuabQZycf+POtnjnYgRk3Hd9AAmW7UzimqKZ8b zA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq0g808f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 06:30:45 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39D6QqNY013408;
 Fri, 13 Oct 2023 06:30:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tq0g808er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 06:30:45 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39D5Mq6A026141; Fri, 13 Oct 2023 06:30:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tpt54t2a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Oct 2023 06:30:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39D6Uh7L19268346
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Oct 2023 06:30:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B064B58067;
 Fri, 13 Oct 2023 06:30:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9932658069;
 Fri, 13 Oct 2023 06:30:39 +0000 (GMT)
Received: from [9.43.35.251] (unknown [9.43.35.251])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Oct 2023 06:30:39 +0000 (GMT)
Message-ID: <d332fbc6-a51e-43ea-a1fa-3953b6709357@linux.ibm.com>
Date: Fri, 13 Oct 2023 12:00:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/pci-host: Update PHB5 XSCOM registers
Content-Language: en-US
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
References: <20231012104852.14537-1-saif.abrar@linux.vnet.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20231012104852.14537-1-saif.abrar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xcO396BAKVVhmXatovKnGO3vENUWsbTr
X-Proofpoint-ORIG-GUID: W59cjdzY8RwK3Ho-7aUAHAU98EblTcuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_03,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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



On 10/12/23 16:18, Saif Abrar wrote:
> Add new XSCOM registers introduced in PHB5.
> Apply bit-masks within xscom-write methods.
> 
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> ---
>   hw/pci-host/pnv_phb4.c              | 29 +++++++++++++++----------
>   hw/pci-host/pnv_phb4_pec.c          | 33 ++++++++++++++++++++++++-----
>   include/hw/pci-host/pnv_phb4.h      |  2 +-
>   include/hw/pci-host/pnv_phb4_regs.h |  4 +++-
>   4 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> index 29cb11a5d9..5661ed1472 100644
> --- a/hw/pci-host/pnv_phb4.c
> +++ b/hw/pci-host/pnv_phb4.c
> @@ -855,7 +855,7 @@ static uint64_t pnv_pec_stk_nest_xscom_read(void *opaque, hwaddr addr,
>       PnvPHB4 *phb = PNV_PHB4(opaque);
>       uint32_t reg = addr >> 3;
>   
> -    /* TODO: add list of allowed registers and error out if not */
> +    /* All registers are read-able */
>       return phb->nest_regs[reg];
>   }
>   
> @@ -1000,7 +1000,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (reg) {
>       case PEC_NEST_STK_PCI_NEST_FIR:
> -        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val;
> +        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] = val & 0xfffffff000000000ull;

Should we prefer a macro for such masks (applies to other masks used 
below also)?

Otherwise,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

>           break;
>       case PEC_NEST_STK_PCI_NEST_FIR_CLR:
>           phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] &= val;
> @@ -1009,7 +1009,8 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
>           phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] |= val;
>           break;
>       case PEC_NEST_STK_PCI_NEST_FIR_MSK:
> -        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val;
> +        phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] = val
> +                                                        & 0xfffffff000000000ull;
>           break;
>       case PEC_NEST_STK_PCI_NEST_FIR_MSKC:
>           phb->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] &= val;
> @@ -1019,7 +1020,7 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
>           break;
>       case PEC_NEST_STK_PCI_NEST_FIR_ACT0:
>       case PEC_NEST_STK_PCI_NEST_FIR_ACT1:
> -        phb->nest_regs[reg] = val;
> +        phb->nest_regs[reg] = val & 0xfffffff000000000ull;
>           break;
>       case PEC_NEST_STK_PCI_NEST_FIR_WOF:
>           phb->nest_regs[reg] = 0;
> @@ -1060,10 +1061,15 @@ static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
>           pnv_pec_phb_update_map(phb);
>           break;
>       case PEC_NEST_STK_DATA_FRZ_TYPE:
> -    case PEC_NEST_STK_PBCQ_TUN_BAR:
>           /* Not used for now */
>           phb->nest_regs[reg] = val;
>           break;
> +    case PEC_NEST_STK_PBCQ_SPARSE_PAGE:
> +        phb->nest_regs[reg] = val & 0x1c00000000000000ull;
> +        break;
> +    case PEC_NEST_STK_PBCQ_CACHE_INJ:
> +        phb->nest_regs[reg] = val & 0xff00000000000000ull;
> +        break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "phb4_pec: nest_xscom_write 0x%"HWADDR_PRIx
>                         "=%"PRIx64"\n", addr, val);
> @@ -1086,7 +1092,7 @@ static uint64_t pnv_pec_stk_pci_xscom_read(void *opaque, hwaddr addr,
>       PnvPHB4 *phb = PNV_PHB4(opaque);
>       uint32_t reg = addr >> 3;
>   
> -    /* TODO: add list of allowed registers and error out if not */
> +    /* All registers are read-able */
>       return phb->pci_regs[reg];
>   }
>   
> @@ -1095,10 +1101,9 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
>   {
>       PnvPHB4 *phb = PNV_PHB4(opaque);
>       uint32_t reg = addr >> 3;
> -
>       switch (reg) {
>       case PEC_PCI_STK_PCI_FIR:
> -        phb->pci_regs[reg] = val;
> +        phb->pci_regs[reg] = val & 0xfc00000000000000ull;
>           break;
>       case PEC_PCI_STK_PCI_FIR_CLR:
>           phb->pci_regs[PEC_PCI_STK_PCI_FIR] &= val;
> @@ -1107,7 +1112,7 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
>           phb->pci_regs[PEC_PCI_STK_PCI_FIR] |= val;
>           break;
>       case PEC_PCI_STK_PCI_FIR_MSK:
> -        phb->pci_regs[reg] = val;
> +        phb->pci_regs[reg] = val & 0xfc00000000000000ull;
>           break;
>       case PEC_PCI_STK_PCI_FIR_MSKC:
>           phb->pci_regs[PEC_PCI_STK_PCI_FIR_MSK] &= val;
> @@ -1117,7 +1122,7 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
>           break;
>       case PEC_PCI_STK_PCI_FIR_ACT0:
>       case PEC_PCI_STK_PCI_FIR_ACT1:
> -        phb->pci_regs[reg] = val;
> +        phb->pci_regs[reg] = val & 0xfc00000000000000ull;
>           break;
>       case PEC_PCI_STK_PCI_FIR_WOF:
>           phb->pci_regs[reg] = 0;
> @@ -1129,8 +1134,10 @@ static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
>       case PEC_PCI_STK_PBAIB_ERR_REPORT:
>           break;
>       case PEC_PCI_STK_PBAIB_TX_CMD_CRED:
> +        phb->pci_regs[reg] = val & 0xe03fe03fe07fe03full;
> +        break;
>       case PEC_PCI_STK_PBAIB_TX_DAT_CRED:
> -        phb->pci_regs[reg] = val;
> +        phb->pci_regs[reg] = val & 0x600f0000;
>           break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "phb4_pec_stk: pci_xscom_write 0x%"HWADDR_PRIx
> diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
> index 3b2850f7a3..6c9b4650ad 100644
> --- a/hw/pci-host/pnv_phb4_pec.c
> +++ b/hw/pci-host/pnv_phb4_pec.c
> @@ -34,7 +34,7 @@ static uint64_t pnv_pec_nest_xscom_read(void *opaque, hwaddr addr,
>       PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
>       uint32_t reg = addr >> 3;
>   
> -    /* TODO: add list of allowed registers and error out if not */
> +    /* All registers are readable */
>       return pec->nest_regs[reg];
>   }
>   
> @@ -45,18 +45,36 @@ static void pnv_pec_nest_xscom_write(void *opaque, hwaddr addr,
>       uint32_t reg = addr >> 3;
>   
>       switch (reg) {
> -    case PEC_NEST_PBCQ_HW_CONFIG:
>       case PEC_NEST_DROP_PRIO_CTRL:
> +        pec->nest_regs[reg] = val & 0xFFFFFFC000000000ull;
> +        break;
>       case PEC_NEST_PBCQ_ERR_INJECT:
> +        pec->nest_regs[reg] = val & 0xFFE0000000000000ull;
> +        break;
>       case PEC_NEST_PCI_NEST_CLK_TRACE_CTL:
> +        pec->nest_regs[reg] = val & 0xFFFF800000000000ull;
> +        break;
>       case PEC_NEST_PBCQ_PMON_CTRL:
> +        pec->nest_regs[reg] = val & 0xFFFFFFFFFC000000ull;
> +        break;
>       case PEC_NEST_PBCQ_PBUS_ADDR_EXT:
> +        pec->nest_regs[reg] = val & 0xFFE0000000000000ull;
> +        break;
>       case PEC_NEST_PBCQ_PRED_VEC_TIMEOUT:
> -    case PEC_NEST_CAPP_CTRL:
> +        pec->nest_regs[reg] = val & 0xFFFF000000000000ull;
> +        break;
>       case PEC_NEST_PBCQ_READ_STK_OVR:
> +        pec->nest_regs[reg] = val & 0xFFFFFFFFFFFF8000ull;
> +        break;
>       case PEC_NEST_PBCQ_WRITE_STK_OVR:
>       case PEC_NEST_PBCQ_STORE_STK_OVR:
> +        pec->nest_regs[reg] = val & 0xFFFFFF8000000000ull;
> +        break;
>       case PEC_NEST_PBCQ_RETRY_BKOFF_CTRL:
> +        pec->nest_regs[reg] = val & 0xFFFFFFFFFFC00000ull;
> +        break;
> +    case PEC_NEST_PBCQ_HW_CONFIG:
> +    case PEC_NEST_CAPP_CTRL:
>           pec->nest_regs[reg] = val;
>           break;
>       default:
> @@ -81,7 +99,7 @@ static uint64_t pnv_pec_pci_xscom_read(void *opaque, hwaddr addr,
>       PnvPhb4PecState *pec = PNV_PHB4_PEC(opaque);
>       uint32_t reg = addr >> 3;
>   
> -    /* TODO: add list of allowed registers and error out if not */
> +    /* All registers are readable */
>       return pec->pci_regs[reg];
>   }
>   
> @@ -93,8 +111,13 @@ static void pnv_pec_pci_xscom_write(void *opaque, hwaddr addr,
>   
>       switch (reg) {
>       case PEC_PCI_PBAIB_HW_CONFIG:
> +        pec->pci_regs[reg] = val & 0xffffffffffe00000ull;
> +        break;
> +    case PEC_PCI_PBAIB_HW_OVR:
> +        pec->pci_regs[reg] = val & 0xffff000000000000ull;
> +        break;
>       case PEC_PCI_PBAIB_READ_STK_OVR:
> -        pec->pci_regs[reg] = val;
> +        pec->pci_regs[reg] = val & 0xffffffffffff8000ull;
>           break;
>       default:
>           phb_pec_error(pec, "%s @0x%"HWADDR_PRIx"=%"PRIx64"\n", __func__,
> diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> index 2d026db9a3..3212e68160 100644
> --- a/include/hw/pci-host/pnv_phb4.h
> +++ b/include/hw/pci-host/pnv_phb4.h
> @@ -117,7 +117,7 @@ struct PnvPHB4 {
>       MemoryRegion pci_regs_mr;
>   
>       /* Nest registers */
> -#define PHB4_PEC_NEST_STK_REGS_COUNT  0x17
> +#define PHB4_PEC_NEST_STK_REGS_COUNT  0x18
>       uint64_t nest_regs[PHB4_PEC_NEST_STK_REGS_COUNT];
>       MemoryRegion nest_regs_mr;
>   
> diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> index 4a0d3b28ef..bea96f4d91 100644
> --- a/include/hw/pci-host/pnv_phb4_regs.h
> +++ b/include/hw/pci-host/pnv_phb4_regs.h
> @@ -77,10 +77,12 @@
>   #define   PEC_NEST_STK_BAR_EN_PHB               PPC_BIT(2)
>   #define   PEC_NEST_STK_BAR_EN_INT               PPC_BIT(3)
>   #define PEC_NEST_STK_DATA_FRZ_TYPE      0x15
> -#define PEC_NEST_STK_PBCQ_TUN_BAR       0x16
> +#define PEC_NEST_STK_PBCQ_SPARSE_PAGE   0x16 /* P10 */
> +#define PEC_NEST_STK_PBCQ_CACHE_INJ     0x17 /* P10 */
>   
>   /* XSCOM PCI global registers */
>   #define PEC_PCI_PBAIB_HW_CONFIG         0x00
> +#define PEC_PCI_PBAIB_HW_OVR            0x01
>   #define PEC_PCI_PBAIB_READ_STK_OVR      0x02
>   
>   /* XSCOM PCI per-stack registers */

