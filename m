Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548497EB40A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vd7-0006aC-Oz; Tue, 14 Nov 2023 10:47:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2vcp-0006Jt-6z
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:46:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1r2vcm-0005HL-84
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:46:50 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEFgkbN026189; Tue, 14 Nov 2023 15:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bW//tuUhLXmEJKDv1r8qnwjFmreNkwD/Zu8cgRJLvFg=;
 b=SAzyiTt3QNLLPtT97gnKuuLE42JXrb+0UZkvcQm6kiLg5bZEifVBnSL7CKb/eeDsn6he
 FjKqdgUeZHxM2tLZXfv8yrL7NtjXC/sxP5R+ubYz1KiASowE1eFTXxGsqh6A9X5Owvfz
 1L/SSS2iXm3puCVfT3JhMNJ8uPmR3xKpEy6HUP+kb2HAT9RxLMAlgGTzlrRWu+rg4AbY
 bebfjxMveAtGYM4CPw3WLMzcu1glx3TEnw5NorcieL23kNb+DxduiNnhswxctbBnejui
 dbZOusEgSpVX9yGBJ1o7kmmmaPeGehzCqNoeaVV7s5/lbDFXcZ3lzhgfLw16SZ5k4Eh2 sw== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucbs5g6q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:46:45 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AEE31d2011087; Tue, 14 Nov 2023 15:46:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uapn1garm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Nov 2023 15:46:44 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AEFkhhN25166410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Nov 2023 15:46:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6281B58043;
 Tue, 14 Nov 2023 15:46:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA0DE58053;
 Tue, 14 Nov 2023 15:46:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Nov 2023 15:46:42 +0000 (GMT)
Message-ID: <763663ee-e08c-4fe7-a6ad-ef1416a8a22c@linux.ibm.com>
Date: Tue, 14 Nov 2023 10:46:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/14] tpm_crb: use a single read-as-mem/write-as-mmio
 mapping
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231114020927.62315-1-j@getutm.app>
 <20231114020927.62315-5-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231114020927.62315-5-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Pwetun6q41oi7tVzkroF4sat-CmUySvX
X-Proofpoint-ORIG-GUID: Pwetun6q41oi7tVzkroF4sat-CmUySvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140122
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



On 11/13/23 21:09, Joelle van Dyne wrote:
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   hw/tpm/tpm_crb.h        |   5 +-
>   hw/tpm/tpm_crb.c        |  30 ++++++++-
>   hw/tpm/tpm_crb_common.c | 145 +++++++++++++++++++++++-----------------
>   3 files changed, 114 insertions(+), 66 deletions(-)
> 
> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> index da3a0cf256..36863e1664 100644
> --- a/hw/tpm/tpm_crb.h
> +++ b/hw/tpm/tpm_crb.h
> @@ -26,9 +26,7 @@
>   typedef struct TPMCRBState {
>       TPMBackend *tpmbe;
>       TPMBackendCmd cmd;
> -    uint32_t regs[TPM_CRB_R_MAX];
>       MemoryRegion mmio;
> -    MemoryRegion cmdmem;
> 
>       size_t be_buffer_size;
> 
> @@ -72,5 +70,8 @@ enum TPMVersion tpm_crb_get_version(TPMCRBState *s);
>   int tpm_crb_pre_save(TPMCRBState *s);
>   void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr);
>   void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
> +void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *saved_cmdmem);
> +void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> +                      const void *saved_cmdmem);
> 
>   #endif /* TPM_TPM_CRB_H */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 598c3e0161..99c64dd72a 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -37,6 +37,10 @@ struct CRBState {
>       DeviceState parent_obj;
> 
>       TPMCRBState state;
> +
> +    /* These states are only for migration */
> +    uint32_t saved_regs[TPM_CRB_R_MAX];
> +    MemoryRegion saved_cmdmem;
>   };
>   typedef struct CRBState CRBState;
> 
> @@ -57,18 +61,36 @@ static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
>       return tpm_crb_get_version(&s->state);
>   }
> 
> +/**
> + * For migrating to an older version of QEMU
> + */
>   static int tpm_crb_none_pre_save(void *opaque)
>   {
>       CRBState *s = opaque;
> +    void *saved_cmdmem = memory_region_get_ram_ptr(&s->saved_cmdmem);
> 
> +    tpm_crb_mem_save(&s->state, s->saved_regs, saved_cmdmem);
>       return tpm_crb_pre_save(&s->state);
>   }
> 
> +/**
> + * For migrating from an older version of QEMU
> + */
> +static int tpm_crb_none_post_load(void *opaque, int version_id)
> +{
> +    CRBState *s = opaque;
> +    void *saved_cmdmem = memory_region_get_ram_ptr(&s->saved_cmdmem);
> +
> +    tpm_crb_mem_load(&s->state, s->saved_regs, saved_cmdmem);
> +    return 0;
> +}
> +
>   static const VMStateDescription vmstate_tpm_crb_none = {
>       .name = "tpm-crb",
>       .pre_save = tpm_crb_none_pre_save,
> +    .post_load = tpm_crb_none_post_load,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
> +        VMSTATE_UINT32_ARRAY(saved_regs, CRBState, TPM_CRB_R_MAX),
>           VMSTATE_END_OF_LIST(),
>       }
>   };
> @@ -101,10 +123,12 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
> 
>       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> 
> +    /* only used for migration */
> +    memory_region_init_ram(&s->saved_cmdmem, OBJECT(s),
> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +
>       memory_region_add_subregion(get_system_memory(),
>           TPM_CRB_ADDR_BASE, &s->state.mmio);
> -    memory_region_add_subregion(get_system_memory(),
> -        TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
> 
>       if (s->state.ppi_enabled) {
>           memory_region_add_subregion(get_system_memory(),
> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> index bee0b71fee..f96a8cf299 100644
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
> @@ -63,35 +44,49 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
> +    /* receive TPM command bytes in DATA_BUFFER */
> +    if (addr >= A_CRB_DATA_BUFFER) {
> +        assert(addr + size <= TPM_CRB_ADDR_SIZE);
> +        assert(size <= sizeof(val));
> +        memcpy(mem + addr - A_CRB_DATA_BUFFER, &val, size);
> +        memory_region_set_dirty(&s->mmio, addr, size);
> +        return;
> +    }
> 
> +    /* otherwise we are doing MMIO writes */
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
> @@ -108,26 +103,27 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
> @@ -138,12 +134,16 @@ const MemoryRegionOps tpm_crb_memory_ops = {
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
> @@ -160,45 +160,50 @@ int tpm_crb_pre_save(TPMCRBState *s)
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
> @@ -206,15 +211,33 @@ void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
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
> +    memcpy(saved_regs, regs, A_CRB_DATA_BUFFER);
> +    memcpy(saved_cmdmem, &regs[R_CRB_DATA_BUFFER], CRB_CTRL_CMD_SIZE);
> +}
> +
> +void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> +                      const void *saved_cmdmem)
> +{
> +    uint32_t *regs = memory_region_get_ram_ptr(&s->mmio);
> +
> +    memcpy(regs, saved_regs, A_CRB_DATA_BUFFER);
> +    memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, CRB_CTRL_CMD_SIZE);
> +}

