Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2067B7527EE
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJykk-0000RT-7V; Thu, 13 Jul 2023 12:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJykb-0000NP-KA
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:01:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qJykY-0005LK-Ck
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:01:05 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DFthWP015237; Thu, 13 Jul 2023 16:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=d4D4Og/uykT2w3MUXlvrbwdb4Li8upLfuvg3pLPEsfk=;
 b=ESm1J1u0s1ayMJs7dAK0LuUzQE7DEARF94+cuiaSww8nDKptSvxvywK2V456CUKY0ba7
 XHVlDd9VZH3gSG7/+ZwIS9CiOrHuQsShH4Yi4G3/sNMOcc5qMRbrlvcjzaN1PsMkFBKX
 ytrq+PH03UJWz4riKRzstdBGcikFZ646YHTQO4hLCfwekKm/J8ZMsavKPXd/qjWq3gfG
 83iGWxbHUTSIoHxClI9+HpdqHVlWvTvs9mWp9Y37zcTC6wcK3NtiuOcbj5tODYQCzu0z
 6xzn6lxKRBBKfybPpPArbbfcMGl5m2PH5X1CkKgI8J+Oh2jSS7BAIkqBuE9FD8MuB5zB bg== 
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtm73rdcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:00:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36DDtqCx005046; Thu, 13 Jul 2023 16:00:55 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rqj4rrasn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Jul 2023 16:00:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36DG0sFn64487904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jul 2023 16:00:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAFC758063;
 Thu, 13 Jul 2023 16:00:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7217358062;
 Thu, 13 Jul 2023 16:00:54 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jul 2023 16:00:54 +0000 (GMT)
Message-ID: <b06e0319-676c-e090-abc2-18174aa02905@linux.ibm.com>
Date: Thu, 13 Jul 2023 12:00:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/11] tpm_ppi: refactor memory space initialization
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-4-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230713035232.48406-4-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o0Wm0sSXgk0kVVI1x1oGd5QYYq0ahpev
X-Proofpoint-ORIG-GUID: o0Wm0sSXgk0kVVI1x1oGd5QYYq0ahpev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130137
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
> Instead of calling `memory_region_add_subregion` directly, we defer to
> the caller to do it. This allows us to re-use the code for a SysBus
> device.
> 
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   hw/tpm/tpm_ppi.h        | 10 +++-------
>   hw/tpm/tpm_crb.c        |  4 ++--
>   hw/tpm/tpm_crb_common.c |  3 +++
>   hw/tpm/tpm_ppi.c        |  5 +----
>   hw/tpm/tpm_tis_isa.c    |  5 +++--
>   5 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> index bf5d4a300f..30863c6438 100644
> --- a/hw/tpm/tpm_ppi.h
> +++ b/hw/tpm/tpm_ppi.h
> @@ -20,17 +20,13 @@ typedef struct TPMPPI {
>   } TPMPPI;
> 
>   /**
> - * tpm_ppi_init:
> + * tpm_ppi_init_memory:
>    * @tpmppi: a TPMPPI
> - * @m: the address-space / MemoryRegion to use
> - * @addr: the address of the PPI region
>    * @obj: the owner object
>    *
> - * Register the TPM PPI memory region at @addr on the given address
> - * space for the object @obj.
> + * Creates the TPM PPI memory region.
>    **/
> -void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
> -                  hwaddr addr, Object *obj);
> +void tpm_ppi_init_memory(TPMPPI *tpmppi, Object *obj);
> 
>   /**
>    * tpm_ppi_reset:
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 3ef4977fb5..598c3e0161 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -107,8 +107,8 @@ static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
>           TPM_CRB_ADDR_BASE + sizeof(s->state.regs), &s->state.cmdmem);
> 
>       if (s->state.ppi_enabled) {
> -        tpm_ppi_init(&s->state.ppi, get_system_memory(),
> -                     TPM_PPI_ADDR_BASE, OBJECT(s));
> +        memory_region_add_subregion(get_system_memory(),
> +            TPM_PPI_ADDR_BASE, &s->state.ppi.ram);
>       }
> 
>       if (xen_enabled()) {
> diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> index 228e2d0faf..e56e910670 100644
> --- a/hw/tpm/tpm_crb_common.c
> +++ b/hw/tpm/tpm_crb_common.c
> @@ -216,4 +216,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s, Error **errp)
>           "tpm-crb-mmio", sizeof(s->regs));
>       memory_region_init_ram(&s->cmdmem, obj,
>           "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
> +    if (s->ppi_enabled) {
> +        tpm_ppi_init_memory(&s->ppi, obj);
> +    }
>   }
> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> index 7f74e26ec6..40cab59afa 100644
> --- a/hw/tpm/tpm_ppi.c
> +++ b/hw/tpm/tpm_ppi.c
> @@ -44,14 +44,11 @@ void tpm_ppi_reset(TPMPPI *tpmppi)
>       }
>   }
> 
> -void tpm_ppi_init(TPMPPI *tpmppi, MemoryRegion *m,
> -                  hwaddr addr, Object *obj)
> +void tpm_ppi_init_memory(TPMPPI *tpmppi, Object *obj)
>   {
>       tpmppi->buf = qemu_memalign(qemu_real_host_page_size(),
>                                   HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
>       memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
>                                         TPM_PPI_ADDR_SIZE, tpmppi->buf);
>       vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> -
> -    memory_region_add_subregion(m, addr, &tpmppi->ram);
>   }
> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
> index 91e3792248..7cd7415f30 100644
> --- a/hw/tpm/tpm_tis_isa.c
> +++ b/hw/tpm/tpm_tis_isa.c
> @@ -134,8 +134,9 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
>                                   TPM_TIS_ADDR_BASE, &s->mmio);
> 
>       if (s->ppi_enabled) {
> -        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
> -                     TPM_PPI_ADDR_BASE, OBJECT(dev));
> +        tpm_ppi_init_memory(&s->ppi, OBJECT(dev));
> +        memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
> +                                    TPM_PPI_ADDR_BASE, &s->ppi.ram);
>       }
>   }
> 

