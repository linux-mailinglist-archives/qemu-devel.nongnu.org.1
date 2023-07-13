Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75F75238E
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 15:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJwHZ-0004HY-DK; Thu, 13 Jul 2023 09:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJwHR-0004HN-5n
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:22:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJwHL-0006RM-ME
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 09:22:48 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDIKg3018420; Thu, 13 Jul 2023 13:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=20HVu5h6e6AmMtOKkhC5S3yinIMiiDtJhKq3vaHf5Jk=;
 b=KgvmLbCZpArLhmQOuMk1toZaBXI/oVSyzMWtMzcdIVJhYjCQnXfoCvx8Cx7lXt3T70dx
 gSDEPvL+i3OMaFCXc+Un1LnkXBzZ7kR4XOi1dOAL+Jyi0LhDwxoD2DEcbN/x/5KOIa7C
 DfQiJVFrsoiLB4Y20dupjcCPMuiQC4vxu39tADnU+z/kjbRdXxs9WljEpFM2P1NF9ffx
 WqqfM05IDv/0uTIpUuea09FqREpU6yoUxEVKmo3+j77enzb1KONCgd1pS7mLGPWs9k8n
 xbeIFcHlQKdz2CuaF6pGZd1A+KhU4Sl/F70QaVXtrH4aYLSxrApknwg8W0Q5CDGRGej9 zw== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtj1er403-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:22:39 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36DCMql0005249;
 Thu, 13 Jul 2023 13:22:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3rpye6p5u4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 13:22:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DDMbB950528548
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 13:22:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7599358045;
 Thu, 13 Jul 2023 13:22:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F255058052;
 Thu, 13 Jul 2023 13:22:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 13:22:36 +0000 (GMT)
Message-ID: <9611ce4e-c11c-bb63-4bc0-7ce544588451@linux.ibm.com>
Date: Thu, 13 Jul 2023 09:22:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 01/11] tpm_crb: refactor common code
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-2-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-2-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: se4vmiO633WPygabzI1dOMgkGTfuARmy
X-Proofpoint-ORIG-GUID: se4vmiO633WPygabzI1dOMgkGTfuARmy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 7/12/23 23:51, Joelle van Dyne wrote:
> In preparation for the SysBus variant, we move common code styled
> after the TPM TIS devices.
> 
> To maintain compatibility, we do not rename the existing tpm-crb
> device.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>   docs/specs/tpm.rst      |   1 +
>   hw/tpm/tpm_crb.h        |  76 +++++++++++
>   hw/tpm/tpm_crb.c        | 270 ++++++----------------------------------
>   hw/tpm/tpm_crb_common.c | 218 ++++++++++++++++++++++++++++++++
>   hw/tpm/meson.build      |   1 +
>   hw/tpm/trace-events     |   2 +-
>   6 files changed, 333 insertions(+), 235 deletions(-)
>   create mode 100644 hw/tpm/tpm_crb.h
>   create mode 100644 hw/tpm/tpm_crb_common.c
> 
> diff --git a/docs/specs/tpm.rst b/docs/specs/tpm.rst
> index efe124a148..2bc29c9804 100644
> --- a/docs/specs/tpm.rst
> +++ b/docs/specs/tpm.rst
> @@ -45,6 +45,7 @@ operating system.
> 
>   QEMU files related to TPM CRB interface:
>    - ``hw/tpm/tpm_crb.c``
> + - ``hw/tpm/tpm_crb_common.c``

If you could add the command line to use for Windows on AARCH64 to this document in 11/11
that would be helpful because what is there right now ony works for Linux iirc.

Regarding this patch here:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> 
>   SPAPR interface
>   ---------------
> diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> new file mode 100644
> index 0000000000..da3a0cf256
> --- /dev/null
> +++ b/hw/tpm/tpm_crb.h
> @@ -0,0 +1,76 @@
> +/*
> + * tpm_crb.h - QEMU's TPM CRB interface emulator
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *   Marc-André Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interface
> + * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
> + * Family “2.0” Level 00 Revision 01.03 v22
> + */
> +#ifndef TPM_TPM_CRB_H
> +#define TPM_TPM_CRB_H
> +
> +#include "exec/memory.h"
> +#include "hw/acpi/tpm.h"
> +#include "sysemu/tpm_backend.h"
> +#include "tpm_ppi.h"
> +
> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> +
> +typedef struct TPMCRBState {
> +    TPMBackend *tpmbe;
> +    TPMBackendCmd cmd;
> +    uint32_t regs[TPM_CRB_R_MAX];
> +    MemoryRegion mmio;
> +    MemoryRegion cmdmem;
> +
> +    size_t be_buffer_size;
> +
> +    bool ppi_enabled;
> +    TPMPPI ppi;
> +} TPMCRBState;
> +
> +#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
> +#define CRB_INTF_VERSION_CRB 0b1
> +#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
> +#define CRB_INTF_CAP_IDLE_FAST 0b0
> +#define CRB_INTF_CAP_XFER_SIZE_64 0b11
> +#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> +#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> +#define CRB_INTF_IF_SELECTOR_CRB 0b1
> +
> +enum crb_loc_ctrl {
> +    CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
> +    CRB_LOC_CTRL_RELINQUISH = BIT(1),
> +    CRB_LOC_CTRL_SEIZE = BIT(2),
> +    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT = BIT(3),
> +};
> +
> +enum crb_ctrl_req {
> +    CRB_CTRL_REQ_CMD_READY = BIT(0),
> +    CRB_CTRL_REQ_GO_IDLE = BIT(1),
> +};
> +
> +enum crb_start {
> +    CRB_START_INVOKE = BIT(0),
> +};
> +
> +enum crb_cancel {
> +    CRB_CANCEL_INVOKE = BIT(0),
> +};
> +
> +#define TPM_CRB_NO_LOCALITY 0xff
> +
> +void tpm_crb_request_completed(TPMCRBState *s, int ret);
> +enum TPMVersion tpm_crb_get_version(TPMCRBState *s);
> +int tpm_crb_pre_save(TPMCRBState *s);
> +void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr);
> +void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp);
> +
> +#endif /* TPM_TPM_CRB_H */
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index ea930da545..3ef4977fb5 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -31,257 +31,62 @@
>   #include "tpm_ppi.h"
>   #include "trace.h"
>   #include "qom/object.h"
> +#include "tpm_crb.h"
> 
>   struct CRBState {
>       DeviceState parent_obj;
> 
> -    TPMBackend *tpmbe;
> -    TPMBackendCmd cmd;
> -    uint32_t regs[TPM_CRB_R_MAX];
> -    MemoryRegion mmio;
> -    MemoryRegion cmdmem;
> -
> -    size_t be_buffer_size;
> -
> -    bool ppi_enabled;
> -    TPMPPI ppi;
> +    TPMCRBState state;
>   };
>   typedef struct CRBState CRBState;
> 
>   DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>                            TYPE_TPM_CRB)
> 
> -#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
> -#define CRB_INTF_VERSION_CRB 0b1
> -#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
> -#define CRB_INTF_CAP_IDLE_FAST 0b0
> -#define CRB_INTF_CAP_XFER_SIZE_64 0b11
> -#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
> -#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
> -#define CRB_INTF_IF_SELECTOR_CRB 0b1
> -
> -#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
> -
> -enum crb_loc_ctrl {
> -    CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
> -    CRB_LOC_CTRL_RELINQUISH = BIT(1),
> -    CRB_LOC_CTRL_SEIZE = BIT(2),
> -    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT = BIT(3),
> -};
> -
> -enum crb_ctrl_req {
> -    CRB_CTRL_REQ_CMD_READY = BIT(0),
> -    CRB_CTRL_REQ_GO_IDLE = BIT(1),
> -};
> -
> -enum crb_start {
> -    CRB_START_INVOKE = BIT(0),
> -};
> -
> -enum crb_cancel {
> -    CRB_CANCEL_INVOKE = BIT(0),
> -};
> -
> -#define TPM_CRB_NO_LOCALITY 0xff
> -
> -static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> -                                  unsigned size)
> -{
> -    CRBState *s = CRB(opaque);
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
> -static uint8_t tpm_crb_get_active_locty(CRBState *s)
> -{
> -    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
> -        return TPM_CRB_NO_LOCALITY;
> -    }
> -    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
> -}
> -
> -static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> -                               uint64_t val, unsigned size)
> -{
> -    CRBState *s = CRB(opaque);
> -    uint8_t locty =  addr >> 12;
> -
> -    trace_tpm_crb_mmio_write(addr, size, val);
> -
> -    switch (addr) {
> -    case A_CRB_CTRL_REQ:
> -        switch (val) {
> -        case CRB_CTRL_REQ_CMD_READY:
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> -                             tpmIdle, 0);
> -            break;
> -        case CRB_CTRL_REQ_GO_IDLE:
> -            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> -                             tpmIdle, 1);
> -            break;
> -        }
> -        break;
> -    case A_CRB_CTRL_CANCEL:
> -        if (val == CRB_CANCEL_INVOKE &&
> -            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> -            tpm_backend_cancel_cmd(s->tpmbe);
> -        }
> -        break;
> -    case A_CRB_CTRL_START:
> -        if (val == CRB_START_INVOKE &&
> -            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> -            tpm_crb_get_active_locty(s) == locty) {
> -            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> -
> -            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
> -            s->cmd = (TPMBackendCmd) {
> -                .in = mem,
> -                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
> -                .out = mem,
> -                .out_len = s->be_buffer_size,
> -            };
> -
> -            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> -        }
> -        break;
> -    case A_CRB_LOC_CTRL:
> -        switch (val) {
> -        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
> -            /* not loc 3 or 4 */
> -            break;
> -        case CRB_LOC_CTRL_RELINQUISH:
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> -                             locAssigned, 0);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> -                             Granted, 0);
> -            break;
> -        case CRB_LOC_CTRL_REQUEST_ACCESS:
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> -                             Granted, 1);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> -                             beenSeized, 0);
> -            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> -                             locAssigned, 1);
> -            break;
> -        }
> -        break;
> -    }
> -}
> -
> -static const MemoryRegionOps tpm_crb_memory_ops = {
> -    .read = tpm_crb_mmio_read,
> -    .write = tpm_crb_mmio_write,
> -    .endianness = DEVICE_LITTLE_ENDIAN,
> -    .valid = {
> -        .min_access_size = 1,
> -        .max_access_size = 4,
> -    },
> -};
> -
> -static void tpm_crb_request_completed(TPMIf *ti, int ret)
> +static void tpm_crb_none_request_completed(TPMIf *ti, int ret)
>   {
>       CRBState *s = CRB(ti);
> 
> -    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
> -    if (ret != 0) {
> -        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> -                         tpmSts, 1); /* fatal error */
> -    }
> -    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +    tpm_crb_request_completed(&s->state, ret);
>   }
> 
> -static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
> +static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
>   {
>       CRBState *s = CRB(ti);
> 
> -    return tpm_backend_get_tpm_version(s->tpmbe);
> +    return tpm_crb_get_version(&s->state);
>   }
> 
> -static int tpm_crb_pre_save(void *opaque)
> +static int tpm_crb_none_pre_save(void *opaque)
>   {
>       CRBState *s = opaque;
> 
> -    tpm_backend_finish_sync(s->tpmbe);
> -
> -    return 0;
> +    return tpm_crb_pre_save(&s->state);
>   }
> 
> -static const VMStateDescription vmstate_tpm_crb = {
> +static const VMStateDescription vmstate_tpm_crb_none = {
>       .name = "tpm-crb",
> -    .pre_save = tpm_crb_pre_save,
> +    .pre_save = tpm_crb_none_pre_save,
>       .fields = (VMStateField[]) {
> -        VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
> +        VMSTATE_UINT32_ARRAY(state.regs, CRBState, TPM_CRB_R_MAX),
>           VMSTATE_END_OF_LIST(),
>       }
>   };
> 
> -static Property tpm_crb_properties[] = {
> -    DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> -    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
> +static Property tpm_crb_none_properties[] = {
> +    DEFINE_PROP_TPMBE("tpmdev", CRBState, state.tpmbe),
> +    DEFINE_PROP_BOOL("ppi", CRBState, state.ppi_enabled, true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
> 
> -static void tpm_crb_reset(void *dev)
> +static void tpm_crb_none_reset(void *dev)
>   {
>       CRBState *s = CRB(dev);
> 
> -    if (s->ppi_enabled) {
> -        tpm_ppi_reset(&s->ppi);
> -    }
> -    tpm_backend_reset(s->tpmbe);
> -
> -    memset(s->regs, 0, sizeof(s->regs));
> -
> -    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> -                     tpmRegValidSts, 1);
> -    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> -                     tpmIdle, 1);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     InterfaceVersion, CRB_INTF_VERSION_CRB);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> -                     RID, 0b0000);
> -    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> -                     VID, PCI_VENDOR_ID_IBM);
> -
> -    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
> -    s->regs[R_CRB_CTRL_CMD_LADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
> -    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
> -    s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
> -
> -    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
> -                            CRB_CTRL_CMD_SIZE);
> -
> -    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
> -        exit(1);
> -    }
> +    return tpm_crb_reset(&s->state, TPM_CRB_ADDR_BASE);
>   }
> 
> -static void tpm_crb_realize(DeviceState *dev, Error **errp)
> +static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
>   {
>       CRBState *s = CRB(dev);
> 
> @@ -289,64 +94,61 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
>           error_setg(errp, "at most one TPM device is permitted");
>           return;
>       }
> -    if (!s->tpmbe) {
> +    if (!s->state.tpmbe) {
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> 
> -    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> -        "tpm-crb-mmio", sizeof(s->regs));
> -    memory_region_init_ram(&s->cmdmem, OBJECT(s),
> -        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +    tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> 
>       memory_region_add_subregion(get_system_memory(),
> -        TPM_CRB_ADDR_BASE, &s->mmio);
> +        TPM_CRB_ADDR_BASE, &s->state.mmio);
>       memory_region_add_subregion(get_system_memory(),
> -        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
> +        TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
> 
> -    if (s->ppi_enabled) {
> -        tpm_ppi_init(&s->ppi, get_system_memory(),
> +    if (s->state.ppi_enabled) {
> +        tpm_ppi_init(&s->state.ppi, get_system_memory(),
>                        TPM_PPI_ADDR_BASE, OBJECT(s));
>       }
> 
>       if (xen_enabled()) {
> -        tpm_crb_reset(dev);
> +        tpm_crb_none_reset(dev);
>       } else {
> -        qemu_register_reset(tpm_crb_reset, dev);
> +        qemu_register_reset(tpm_crb_none_reset, dev);
>       }
>   }
> 
> -static void tpm_crb_class_init(ObjectClass *klass, void *data)
> +static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       TPMIfClass *tc = TPM_IF_CLASS(klass);
> 
> -    dc->realize = tpm_crb_realize;
> -    device_class_set_props(dc, tpm_crb_properties);
> -    dc->vmsd  = &vmstate_tpm_crb;
> +    dc->realize = tpm_crb_none_realize;
> +    device_class_set_props(dc, tpm_crb_none_properties);
> +    dc->vmsd  = &vmstate_tpm_crb_none;
>       dc->user_creatable = true;
>       tc->model = TPM_MODEL_TPM_CRB;
> -    tc->get_version = tpm_crb_get_version;
> -    tc->request_completed = tpm_crb_request_completed;
> +    tc->get_version = tpm_crb_none_get_version;
> +    tc->request_completed = tpm_crb_none_request_completed;
> 
>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>   }
> 
> -static const TypeInfo tpm_crb_info = {
> +static const TypeInfo tpm_crb_none_info = {
>       .name = TYPE_TPM_CRB,
>       /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
>       .parent = TYPE_DEVICE,
>       .instance_size = sizeof(CRBState),
> -    .class_init  = tpm_crb_class_init,
> +    .class_init  = tpm_crb_none_class_init,
>       .interfaces = (InterfaceInfo[]) {
>           { TYPE_TPM_IF },
>           { }
>       }
>   };
> 
> -static void tpm_crb_register(void)
> +static void tpm_crb_none_register(void)
>   {
> -    type_register_static(&tpm_crb_info);
> +    type_register_static(&tpm_crb_none_info);
>   }
> 
> -type_init(tpm_crb_register)
> +type_init(tpm_crb_none_register)
> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> new file mode 100644
> index 0000000000..4c173affb6
> --- /dev/null
> +++ b/hw/tpm/tpm_crb_common.c
> @@ -0,0 +1,218 @@
> +/*
> + * tpm_crb.c - QEMU's TPM CRB interface emulator
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *   Marc-André Lureau <marcandre.lureau@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interface
> + * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
> + * Family “2.0” Level 00 Revision 01.03 v22
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/module.h"
> +#include "qapi/error.h"
> +#include "exec/address-spaces.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/pci/pci_ids.h"
> +#include "hw/acpi/tpm.h"
> +#include "migration/vmstate.h"
> +#include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm_util.h"
> +#include "sysemu/reset.h"
> +#include "sysemu/xen.h"
> +#include "tpm_prop.h"
> +#include "tpm_ppi.h"
> +#include "trace.h"
> +#include "qom/object.h"
> +#include "tpm_crb.h"
> +
> +static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
> +                                  unsigned size)
> +{
> +    TPMCRBState *s = opaque;
> +    void *regs = (void *)&s->regs + (addr & ~3);
> +    unsigned offset = addr & 3;
> +    uint32_t val = *(uint32_t *)regs >> (8 * offset);
> +
> +    switch (addr) {
> +    case A_CRB_LOC_STATE:
> +        val |= !tpm_backend_get_tpm_established_flag(s->tpmbe);
> +        break;
> +    }
> +
> +    trace_tpm_crb_mmio_read(addr, size, val);
> +
> +    return val;
> +}
> +
> +static uint8_t tpm_crb_get_active_locty(TPMCRBState *s)
> +{
> +    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
> +        return TPM_CRB_NO_LOCALITY;
> +    }
> +    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
> +}
> +
> +static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
> +                               uint64_t val, unsigned size)
> +{
> +    TPMCRBState *s = opaque;
> +    uint8_t locty =  addr >> 12;
> +
> +    trace_tpm_crb_mmio_write(addr, size, val);
> +
> +    switch (addr) {
> +    case A_CRB_CTRL_REQ:
> +        switch (val) {
> +        case CRB_CTRL_REQ_CMD_READY:
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +                             tpmIdle, 0);
> +            break;
> +        case CRB_CTRL_REQ_GO_IDLE:
> +            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +                             tpmIdle, 1);
> +            break;
> +        }
> +        break;
> +    case A_CRB_CTRL_CANCEL:
> +        if (val == CRB_CANCEL_INVOKE &&
> +            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
> +            tpm_backend_cancel_cmd(s->tpmbe);
> +        }
> +        break;
> +    case A_CRB_CTRL_START:
> +        if (val == CRB_START_INVOKE &&
> +            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
> +            tpm_crb_get_active_locty(s) == locty) {
> +            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
> +
> +            s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
> +            s->cmd = (TPMBackendCmd) {
> +                .in = mem,
> +                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
> +                .out = mem,
> +                .out_len = s->be_buffer_size,
> +            };
> +
> +            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
> +        }
> +        break;
> +    case A_CRB_LOC_CTRL:
> +        switch (val) {
> +        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
> +            /* not loc 3 or 4 */
> +            break;
> +        case CRB_LOC_CTRL_RELINQUISH:
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +                             locAssigned, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +                             Granted, 0);
> +            break;
> +        case CRB_LOC_CTRL_REQUEST_ACCESS:
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +                             Granted, 1);
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
> +                             beenSeized, 0);
> +            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +                             locAssigned, 1);
> +            break;
> +        }
> +        break;
> +    }
> +}
> +
> +const MemoryRegionOps tpm_crb_memory_ops = {
> +    .read = tpm_crb_mmio_read,
> +    .write = tpm_crb_mmio_write,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
> +    .valid = {
> +        .min_access_size = 1,
> +        .max_access_size = 4,
> +    },
> +};
> +
> +void tpm_crb_request_completed(TPMCRBState *s, int ret)
> +{
> +    s->regs[R_CRB_CTRL_START] &= ~CRB_START_INVOKE;
> +    if (ret != 0) {
> +        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +                         tpmSts, 1); /* fatal error */
> +    }
> +    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
> +}
> +
> +enum TPMVersion tpm_crb_get_version(TPMCRBState *s)
> +{
> +    return tpm_backend_get_tpm_version(s->tpmbe);
> +}
> +
> +int tpm_crb_pre_save(TPMCRBState *s)
> +{
> +    tpm_backend_finish_sync(s->tpmbe);
> +
> +    return 0;
> +}
> +
> +void tpm_crb_reset(TPMCRBState *s, uint64_t baseaddr)
> +{
> +    if (s->ppi_enabled) {
> +        tpm_ppi_reset(&s->ppi);
> +    }
> +    tpm_backend_reset(s->tpmbe);
> +
> +    memset(s->regs, 0, sizeof(s->regs));
> +
> +    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
> +                     tpmRegValidSts, 1);
> +    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
> +                     tpmIdle, 1);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceVersion, CRB_INTF_VERSION_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
> +                     RID, 0b0000);
> +    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
> +                     VID, PCI_VENDOR_ID_IBM);
> +
> +    baseaddr += A_CRB_DATA_BUFFER;
> +    s->regs[R_CRB_CTRL_CMD_SIZE] = CRB_CTRL_CMD_SIZE;
> +    s->regs[R_CRB_CTRL_CMD_LADDR] = (uint32_t)baseaddr;
> +    s->regs[R_CRB_CTRL_CMD_HADDR] = (uint32_t)(baseaddr >> 32);
> +    s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
> +    s->regs[R_CRB_CTRL_RSP_ADDR] = (uint32_t)baseaddr;
> +
> +    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
> +                            CRB_CTRL_CMD_SIZE);
> +
> +    if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
> +        exit(1);
> +    }
> +}
> +
> +void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
> +{
> +    memory_region_init_io(&s->mmio, obj, &tpm_crb_memory_ops, s,
> +        "tpm-crb-mmio", sizeof(s->regs));
> +    memory_region_init_ram(&s->cmdmem, obj,
> +        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +}
> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> index 6968e60b3f..cb8204d5bc 100644
> --- a/hw/tpm/meson.build
> +++ b/hw/tpm/meson.build
> @@ -3,6 +3,7 @@ system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
> +system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
> 
> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> index fa882dfefe..3ab1bdb97b 100644
> --- a/hw/tpm/trace-events
> +++ b/hw/tpm/trace-events
> @@ -1,6 +1,6 @@
>   # See docs/devel/tracing.rst for syntax documentation.
> 
> -# tpm_crb.c
> +# tpm_crb_common.c
>   tpm_crb_mmio_read(uint64_t addr, unsigned size, uint32_t val) "CRB read 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
>   tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_t val) "CRB write 0x%016" PRIx64 " len:%u val: 0x%" PRIx32
> 

