Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD0828D55
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:25:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNHhy-0007pa-QK; Tue, 09 Jan 2024 14:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNHhv-0007p1-Cj; Tue, 09 Jan 2024 14:24:16 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNHhs-0003uc-Mg; Tue, 09 Jan 2024 14:24:14 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409Ig3gx024507; Tue, 9 Jan 2024 19:23:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=F40FYYpRe1pVvmEFSoSVFLkq/ixDj4ITB+4b+qGHmro=;
 b=CvXkeFjqxfuV7Ixd0zBxxuiCCtc+1CPdoAFcpjdSC1kIVnSWy1Hl3/N7qLaXOKbWjphQ
 ncC4vmC/je+PxL2RCwidwqeFr2cAQSJI3kTs8pib202iL/SYayIP1vUi8DS6a8QDHml4
 kYPtUwWB7x/kbb3dnMMnqmGyrVBi/P4+QZT9x8e8WX5uj+nID65QVQFxH342hjCKqDVo
 GlaN5nVKqBvvMtgVJtTFm5W3ExiMRNAdjgD/Dzq+MHagNJ8s9bOKKExIKbAYkFPA6F39
 o4CE805S2sdHSINmfOl4PJO1TXfE/1wLGbDLNHyL4pV8OWtnusBdM0u0ACLwJjF5nwe2 ig== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhbn8911b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 19:23:37 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409JLLZ0025718;
 Tue, 9 Jan 2024 19:23:37 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhbn890yx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 19:23:37 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409Hswks027026; Tue, 9 Jan 2024 19:23:35 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw207ew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 19:23:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409JNZxL35586384
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 19:23:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 358F958059;
 Tue,  9 Jan 2024 19:23:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA09C58055;
 Tue,  9 Jan 2024 19:23:34 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 19:23:34 +0000 (GMT)
Message-ID: <f827c2e5-699d-48cf-afca-d73897564b59@linux.ibm.com>
Date: Tue, 9 Jan 2024 13:23:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] hw/fsi: Introduce IBM's Local bus
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-2-ninad@linux.ibm.com>
 <2645397c-eacd-48d4-b452-c9d6cce83d96@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <2645397c-eacd-48d4-b452-c9d6cce83d96@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ERlBoPVNthSnjN9uielCpiLO2Sj2HrX_
X-Proofpoint-ORIG-GUID: 2HvBCHIzwO-iv1-CWF3W2zLe_3dIX2ah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_09,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 mlxlogscore=894 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090156
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
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

Hello Cedric,

On 12/12/23 08:46, Cédric Le Goater wrote:
> On 11/29/23 00:56, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The LBUS is modelled to maintain mapped memory for the devices. The
>> memory is mapped after CFAM config, peek table and FSI slave registers.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> [ clg: - removed lbus_add_device() bc unused
>>         - removed lbus_create_device() bc used only once
>>         - removed "address" property
>>         - updated meson.build to build fsi dir
>>         - included an empty hw/fsi/trace-events ]
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   meson.build           |  1 +
>>   hw/fsi/trace.h        |  1 +
>>   include/hw/fsi/lbus.h | 40 +++++++++++++++++++++++++++++++++
>>   hw/fsi/lbus.c         | 51 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/Kconfig            |  1 +
>>   hw/fsi/Kconfig        |  2 ++
>>   hw/fsi/meson.build    |  1 +
>>   hw/fsi/trace-events   |  1 +
>>   hw/meson.build        |  1 +
>>   9 files changed, 99 insertions(+)
>>   create mode 100644 hw/fsi/trace.h
>>   create mode 100644 include/hw/fsi/lbus.h
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/meson.build
>>   create mode 100644 hw/fsi/trace-events
>>
>> diff --git a/meson.build b/meson.build
>> index ec01f8b138..b6556efd51 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3298,6 +3298,7 @@ if have_system
>>       'hw/char',
>>       'hw/display',
>>       'hw/dma',
>> +    'hw/fsi',
>>       'hw/hyperv',
>>       'hw/i2c',
>>       'hw/i386',
>> diff --git a/hw/fsi/trace.h b/hw/fsi/trace.h
>> new file mode 100644
>> index 0000000000..ee67c7fb04
>> --- /dev/null
>> +++ b/hw/fsi/trace.h
>> @@ -0,0 +1 @@
>> +#include "trace/trace-hw_fsi.h"
>> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
>> new file mode 100644
>> index 0000000000..a58e33d061
>> --- /dev/null
>> +++ b/include/hw/fsi/lbus.h
>> @@ -0,0 +1,40 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Local bus and connected device structures.
>> + */
>> +#ifndef FSI_LBUS_H
>> +#define FSI_LBUS_H
>> +
>> +#include "exec/memory.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
>> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
>> +
>> +#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
>> +#define FSI_LBUSDEV_IOMEM_START   0xc00 /* 3K used by CFAM config 
>> etc */
>
> I don't think sizing the local bus MMIO region exactly to the size of
> the CFAM MMIO region is necessary. The upper LBUS/CFAM addresses might
> not even be backed by device registers.
>
> I would simplify with :
>
> #define FSI_LBUS_MEM_REGION_SIZE  (1 * MiB)
>
> and forget about the offset.
>
ok, I made it as 1MB.

Thanks for the review.

Regards,

Ninad



