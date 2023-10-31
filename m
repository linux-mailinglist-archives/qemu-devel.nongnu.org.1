Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE77DCDA9
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:20:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoer-0002lP-Gc; Tue, 31 Oct 2023 09:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxoeo-0002jL-TM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:19:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1qxoej-000129-6S
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:19:46 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VDEcLA011317; Tue, 31 Oct 2023 13:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=fqX5nypWcHH7gV5hrm+a0nRSwVFmalRI/zvpJZIGrBo=;
 b=cOUPTn5cKLq/gAZ8Gsp6KVsE3IVidvpTKrKDqgyharSZwg489d3PdAKn3cd1GG565P63
 YM9M5ZwbfJaISWMp1+9iTmcwaWSVlsbJkJRh208nSB9lcVBWWPkg2dn8ZXaJco4IBZ49
 nJdB4G0UGUy/Nijp2xeolrqW0VzJZPJOvHyDH+lG8msYyXajimFvAGQclVUcb06w1PYr
 cc3Qv1o9iN5Vlgt2dN9JvDXLtZ4d4hIeIC8Yk+rG05TcF18C3EXc5qqRITdC9ZfbicGh
 zmdmuvZJXAf7RF0CyGjR3X6lV50CrOSKcF6S1Bh5ICSXMPBsRUkQiD9cWsHwDW3YYDNt AQ== 
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u329sg6tq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 13:19:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39VD2l6m020308; Tue, 31 Oct 2023 13:19:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0ygt2t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 13:19:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39VDJcpK23265916
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 13:19:38 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3EC958067;
 Tue, 31 Oct 2023 13:19:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A64365806A;
 Tue, 31 Oct 2023 13:19:37 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 31 Oct 2023 13:19:37 +0000 (GMT)
Message-ID: <c8b7f48d-7580-428c-a81f-1c22998a880a@linux.ibm.com>
Date: Tue, 31 Oct 2023 09:19:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/14] tpm-sysbus: add plug handler for TPM on SysBus
Content-Language: en-US
To: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-7-j@getutm.app>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20231031040021.65582-7-j@getutm.app>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ps3HgqlNe6pogERak8VdA6vIR3eA9qlc
X-Proofpoint-GUID: ps3HgqlNe6pogERak8VdA6vIR3eA9qlc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_01,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxlogscore=812 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> TPM needs to know its own base address in order to generate its DSDT
> device entry.
>
> Signed-off-by: Joelle van Dyne <j@getutm.app>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


> ---
>   include/sysemu/tpm.h |  4 ++++
>   hw/tpm/tpm-sysbus.c  | 47 ++++++++++++++++++++++++++++++++++++++++++++
>   hw/tpm/meson.build   |  1 +
>   3 files changed, 52 insertions(+)
>   create mode 100644 hw/tpm/tpm-sysbus.c
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 1ee568b3b6..ffd300e607 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -12,6 +12,8 @@
>   #ifndef QEMU_TPM_H
>   #define QEMU_TPM_H
>
> +#include "qemu/osdep.h"
> +#include "exec/hwaddr.h"
>   #include "qapi/qapi-types-tpm.h"
>   #include "qom/object.h"
>
> @@ -78,6 +80,8 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>       return TPM_IF_GET_CLASS(ti)->get_version(ti);
>   }
>
> +void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base);
> +
>   #else /* CONFIG_TPM */
>
>   #define tpm_init()  (0)
> diff --git a/hw/tpm/tpm-sysbus.c b/hw/tpm/tpm-sysbus.c
> new file mode 100644
> index 0000000000..732ce34c73
> --- /dev/null
> +++ b/hw/tpm/tpm-sysbus.c
> @@ -0,0 +1,47 @@
> +/*
> + * tpm-sysbus.c - Support functions for SysBus TPM devices
> + *
> + * Copyright (c) 2023 QEMU contributors
> + *
> + * Authors:
> + *   Joelle van Dyne <j@getutm.app>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "sysemu/tpm.h"
> +#include "hw/platform-bus.h"
> +#include "hw/sysbus.h"
> +#include "qapi/error.h"
> +
> +/**
> + * Called from a machine's pre_plug handler to set the device's physical addr.
> + */
> +void tpm_sysbus_plug(TPMIf *tpmif, Object *pbus, hwaddr pbus_base)
> +{
> +    PlatformBusDevice *pbusdev = PLATFORM_BUS_DEVICE(pbus);
> +    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpmif);
> +    MemoryRegion *sbdev_mr;
> +    hwaddr tpm_base;
> +    uint64_t tpm_size;
> +
> +    /* exit early if TPM is not a sysbus device */
> +    if (!object_dynamic_cast(OBJECT(tpmif), TYPE_SYS_BUS_DEVICE)) {
> +        return;
> +    }
> +
> +    assert(object_dynamic_cast(pbus, TYPE_PLATFORM_BUS_DEVICE));
> +
> +    tpm_base = platform_bus_get_mmio_addr(pbusdev, sbdev, 0);
> +    assert(tpm_base != -1);
> +
> +    tpm_base += pbus_base;
> +
> +    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
> +    tpm_size = memory_region_size(sbdev_mr);
> +
> +    object_property_set_uint(OBJECT(sbdev), "x-baseaddr",
> +                             tpm_base, &error_abort);
> +    object_property_set_uint(OBJECT(sbdev), "x-size",
> +                             tpm_size, &error_abort);
> +}
> diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
> index cb8204d5bc..3060ac05e8 100644
> --- a/hw/tpm/meson.build
> +++ b/hw/tpm/meson.build
> @@ -1,6 +1,7 @@
>   system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_tis_common.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_ISA', if_true: files('tpm_tis_isa.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm_tis_sysbus.c'))
> +system_ss.add(when: 'CONFIG_TPM_TIS_SYSBUS', if_true: files('tpm-sysbus.c'))
>   system_ss.add(when: 'CONFIG_TPM_TIS_I2C', if_true: files('tpm_tis_i2c.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
>   system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb_common.c'))

