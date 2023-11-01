Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973557DE76E
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 22:27:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyIjO-000432-NO; Wed, 01 Nov 2023 17:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qyIj6-00042N-Kj
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 17:26:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qyIj2-0001tk-Ju
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 17:26:12 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A1LCLLp029800; Wed, 1 Nov 2023 21:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zWP8XF9VpHmBmiRltgV8jTIqQ3p5xjzKykUfF1veHuY=;
 b=qQO2nHL3fQ5n1F5porQrWdqSCKxsuP8483vuKAXWFGVnWIM8wj33ogczHQezVOlZnfdk
 NEHyYxpN/3cc8WDVZctVooyYvU1NNJbXlX+Z8Z8uL1SZQvThxPBmKHA7ZwNSO/NWnLpX
 zvICiaevuHxQXKgyoYcmRvdwbVGQ7IamQK6TE25paarb/U688jJfOeIlQmdHuYNXdYoF
 H73zuokB+qIQNGfNlfIKlzj1l77NYlRxfXn2cyb8xxd6OXLJ718aoJ4xGd0nfWhrX+MK
 7mbuq2XDRFm8fYxMgX7dVodIACFo+2XD6fYvl8mREWCuoviRu3Gs6iaxls6O9Wwf/+OG kw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3xcrrgc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Nov 2023 21:25:44 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A1JZWKa011389; Wed, 1 Nov 2023 21:25:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1euk9sd2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Nov 2023 21:25:43 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A1LPg2913238790
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Nov 2023 21:25:42 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7412C5805D;
 Wed,  1 Nov 2023 21:25:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03E9E58043;
 Wed,  1 Nov 2023 21:25:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Wed,  1 Nov 2023 21:25:41 +0000 (GMT)
Message-ID: <e7a4c833-3e61-4a7f-ab9e-3921eb581613@linux.ibm.com>
Date: Wed, 1 Nov 2023 17:25:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-5-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231031040021.65582-5-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: doz6aAG9f9TqXPoEtFDLRrH6Akbzarup
X-Proofpoint-GUID: doz6aAG9f9TqXPoEtFDLRrH6Akbzarup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_20,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010158
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 10/31/23 00:00, Joelle van Dyne wrote:
> On Apple Silicon, when Windows performs a LDP on the CRB MMIO space,
> the exception is not decoded by hardware and we cannot trap the MMIO
> read. This led to the idea from @agraf to use the same mapping type as
> ROM devices: namely that reads should be seen as memory type and
> writes should trap as MMIO.
> 
> Once that was done, the second memory mapping of the command buffer
> region was redundent and was removed.
> 
> A note about the removal of the read trap for `CRB_LOC_STATE`:
> The only usage was to return the most up-to-date value for
> `tpmEstablished`. However, `tpmEstablished` is only cleared when a
> TPM2_HashStart operation is called which only exists for locality 4.
> We do not handle locality 4. Indeed, the comment for the write handler
> of `CRB_LOC_CTRL` makes the same argument for why it is not calling
> the backend to reset the `tpmEstablished` bit (to 1).
> As this bit is unused, we do not need to worry about updating it for
> reads.
> 
> In order to maintain migration compatibility with older versions of
> QEMU, we store a copy of the register data and command data which is
> used only during save/restore.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---

> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> index bee0b71fee..605e8576e9 100644
> --- a/hw/tpm/tpm_crb_common.c
> +++ b/hw/tpm/tpm_crb_common.c
> @@ -31,31 +31,12 @@
>   #include "qom/object.h"
>   #include "tpm_crb.h"
> 
> -static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> -                                  unsigned size)
> +static uint8_t tpm_crb_get_active_locty(TPMCRBState *s, uint32_t *regs)
>   {
> -    TPMCRBState *s = opaque;
> -    void *regs = (void *)&s->regs + (addr & ~3);
> -    unsigned offset = addr & 3;
> -    uint32_t val = *(uint32_t *)regs >> (8 * offset);
> -
> -    switch (addr) {
> -    case A_CRB_LOC_STATE:
> -        val |= !tpm_backend_get_tpm_established_flag(s->tpmbe);
> -        break;
> -    }
> -
> -    trace_tpm_crb_mmio_read(addr, size, val);
> -
> -    return val;
> -}
> -
> -static uint8_t tpm_crb_get_active_locty(TPMCRBState *s)
> -{
> -    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
> +    if (!ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, locAssigned)) {
>           return TPM_CRB_NO_LOCALITY;
>       }
> -    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
> +    return ARRAY_FIELD_EX32(regs, CRB_LOC_STATE, activeLocality);
>   }
> 
>   static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> @@ -63,35 +44,47 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>   {
>       TPMCRBState *s = opaque;
>       uint8_t locty =  addr >> 12;
> +    uint32_t *regs;
> +    void *mem;
> 
>       trace_tpm_crb_mmio_write(addr, size, val);
> +    regs = memory_region_get_ram_ptr(&s->mmio);
> +    mem = &regs[R_CRB_DATA_BUFFER];
> +    assert(regs);
> +
> +    if (addr >= A_CRB_DATA_BUFFER) {


Can you write here /* receive TPM command bytes */ ?


> +        assert(addr + size <= TPM_CRB_ADDR_SIZE);
> +        assert(size <= sizeof(val));
> +        memcpy(mem + addr - A_CRB_DATA_BUFFER, &val, size);

> +        memory_region_set_dirty(&s->mmio, addr, size);
> +        return;
> +    }
> 
>       switch (addr) {
>       case A_CRB_CTRL_REQ:
>           switch (val) {
>           case CRB_CTRL_REQ_CMD_READY:
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
>                                tpmIdle, 0);
>               break;
>           case CRB_CTRL_REQ_GO_IDLE:
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +            ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
>                                tpmIdle, 1);
>               break;
>           }
>           break;
>       case A_CRB_CTRL_CANCEL:
>           if (val == CRB_CANCEL_INVOKE &&
> -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> +            regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
>               tpm_backend_cancel_cmd(s->tpmbe);
>           }
>           break;
>       case A_CRB_CTRL_START:
>           if (val == CRB_START_INVOKE &&
> -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> -            tpm_crb_get_active_locty(s) == locty) {
> -            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> +            !(regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> +            tpm_crb_get_active_locty(s, regs) == locty) {
> 
> -            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
> +            regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
>               s->cmd = (TPMBackendCmd) {
>                   .in = mem,
>                   .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
> @@ -108,26 +101,27 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>               /* not loc 3 or 4 */
>               break;
>           case CRB_LOC_CTRL_RELINQUISH:
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
>                                locAssigned, 0);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
>                                Granted, 0);
>               break;
>           case CRB_LOC_CTRL_REQUEST_ACCESS:
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
>                                Granted, 1);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +            ARRAY_FIELD_DP32(regs, CRB_LOC_STS,
>                                beenSeized, 0);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +            ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
>                                locAssigned, 1);
>               break;
>           }
>           break;
>       }
> +
> +    memory_region_set_dirty(&s->mmio, 0, A_CRB_DATA_BUFFER);
>   }
> 
>   const MemoryRegionOps tpm_crb_memory_ops = {
> -    .read = tpm_crb_mmio_read,
>       .write = tpm_crb_mmio_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .valid = {
> @@ -138,12 +132,16 @@ const MemoryRegionOps tpm_crb_memory_ops = {
> 
>   void tpm_crb_request_completed(TPMCRBState *s, int ret)
>   {
> -    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
> +    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
> +
> +    assert(regs);
> +    regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
>       if (ret != 0) {
> -        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +        ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
>                            tpmSts, 1); /* fatal error */
>       }
> -    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +
> +    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
>   }
> 
>   enum TPMVersion tpm_crb_get_version(TPMCRBState *s)
> @@ -160,45 +158,50 @@ int tpm_crb_pre_save(TPMCRBState *s)
> 
>   void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
>   {
> +    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
> +
> +    assert(regs);
>       if (s->ppi_enabled) {
>           tpm_ppi_reset(&s->ppi);
>       }
>       tpm_backend_reset(s->tpmbe);
> 
> -    memset(s->regs, 0, sizeof(s->regs));
> +    memset(regs, 0, TPM_CRB_ADDR_SIZE);
> 
> -    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +    ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
>                        tpmRegValidSts, 1);
> -    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +    ARRAY_FIELD_DP32(regs, CRB_LOC_STATE,
> +                     tpmEstablished, 1);
> +    ARRAY_FIELD_DP32(regs, CRB_CTRL_STS,
>                        tpmIdle, 1);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        InterfaceVersion, CRB_INTF_VERSION_CRB);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID,
>                        RID, 0b0000);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> +    ARRAY_FIELD_DP32(regs, CRB_INTF_ID2,
>                        VID, PCI_VENDOR_ID_IBM);
> 
>       baseaddr += A_CRB_DATA_BUFFER;
> -    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
> -    s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
> -    s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
> -    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
> -    s->regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
> -    s->regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
> +    regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
> +    regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
> +    regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
> +    regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
> +    regs[R_CRB_CTRL_RSP_LADDR] = (uint32_t)baseaddr;
> +    regs[R_CRB_CTRL_RSP_HADDR] = (uint32_t)(baseaddr >> 32);
> 
>       s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
>                               CRB_CTRL_CMD_SIZE);
> @@ -206,15 +209,33 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
>       if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
>           exit(1);
>       }
> +
> +    memory_region_rom_device_set_romd(&s->mmio, true);
> +    memory_region_set_dirty(&s->mmio, 0, TPM_CRB_ADDR_SIZE);
>   }
> 
>   void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
>   {
> -    memory_region_init_io(&s->mmio, obj, &tpm_crb_memory_ops, s,
> -        "tpm-crb-mmio", sizeof(s->regs));
> -    memory_region_init_ram(&s->cmdmem, obj,
> -        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +    memory_region_init_rom_device_nomigrate(&s->mmio, obj, &tpm_crb_memory_ops,
> +        s, "tpm-crb-mem", TPM_CRB_ADDR_SIZE, errp);
>       if (s->ppi_enabled) {
>           tpm_ppi_init_memory(&s->ppi, obj);
>       }
>   }
> +
> +void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *saved_cmdmem)
> +{
> +    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
> +
> +    memcpy(saved_regs, regs, TPM_CRB_R_MAX);
> +    memcpy(saved_cmdmem, &regs[R_CRB_DATA_BUFFER], A_CRB_DATA_BUFFER);

I find it confusing that this function is here rather than in 
tpm_crb_non_pre_save().

The size should be CRB_CTRL_CMD_SIZE.

> +}
> +
> +void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> +                      const void *saved_cmdmem)
> +{
> +    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
> +
> +    memcpy(regs, saved_regs, TPM_CRB_R_MAX);
> +    memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, A_CRB_DATA_BUFFER);
> +}

Same comments; size seems wrong.

