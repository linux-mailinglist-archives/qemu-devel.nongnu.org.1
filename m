Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9187D3D1B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 19:11:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quyS1-0005aL-8Q; Mon, 23 Oct 2023 13:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quyRx-0005YV-KF; Mon, 23 Oct 2023 13:10:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quyRs-0004gk-4R; Mon, 23 Oct 2023 13:10:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NGjYa9020572; Mon, 23 Oct 2023 17:10:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NkApxX6WK85LJrxd11lFHZhji6YRgUPPuXS1yHZxqVU=;
 b=Jw0OSCQ9IZ28iPnKchIhaURed2Uy1C4KD6p0UhMkLN7wQnfiUjudtpY0iBN8GnxHmJGA
 WERKa8OgOI/kfj6jOlG0iExRsZ2Y3uBKJA7Ifc9Pz5oP/jg/N1Vx/lTWGbLByjP1KDiv
 9BjAa6QeUx+ShN4XohvX4yDGjyxTEqPqjnoRtLuPnz/VZW7mXRJAInDWvVm53xauHuw2
 g1Ym3pxqEgX9PQKdlry+wmvLeHKUa8FuVmkbeoS0EdbQhR0TFZoJFhezKmXDKJSKHLWj
 ZDb5BEW2GTEYqCjZiQDVB9dbgpWPHOF+z4OXhkTNDg1VEeeED4lb23gIFjxCCBNtk4qz Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twvmsrwxt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 17:10:29 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39NH9cOr026651;
 Mon, 23 Oct 2023 17:10:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3twvmsrwx9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 17:10:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39NFal2Z010224; Mon, 23 Oct 2023 17:10:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tvsbya5w9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Oct 2023 17:10:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39NHARxf15401488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Oct 2023 17:10:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65FB15806B;
 Mon, 23 Oct 2023 17:10:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF81558052;
 Mon, 23 Oct 2023 17:10:25 +0000 (GMT)
Received: from [9.67.93.191] (unknown [9.67.93.191])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Oct 2023 17:10:25 +0000 (GMT)
Message-ID: <7e6307ff-9046-4d26-8937-51139572b7f6@linux.ibm.com>
Date: Mon, 23 Oct 2023 12:10:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/10] hw/fsi: Introduce IBM's Local bus
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-2-ninad@linux.ibm.com>
 <fee75322-5fc5-a1e8-e23c-b49c8177472d@linaro.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <fee75322-5fc5-a1e8-e23c-b49c8177472d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uTjA8jiKfl7b6ycK_A49QIO6hz5eb15N
X-Proofpoint-GUID: SoONfFHO_nIcH1JAQZvSfORtuNZ_Uhv1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_15,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310230148
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello Philippe,

On 10/23/23 09:58, Philippe Mathieu-Daudé wrote:
> Hi Ninad and Andrew,
>
> On 21/10/23 23:17, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The LBUS is modelled to maintain the qdev bus hierarchy and to take
>> advantage of the object model to automatically generate the CFAM
>> configuration block. The configuration block presents engines in the
>> order they are attached to the CFAM's LBUS. Engine implementations
>> should subclass the LBusDevice and set the 'config' member of
>> LBusDeviceClass to match the engine's type.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v2:
>> - Incorporated Joel's review comments.
>> v5:
>> - Incorporated review comments by Cedric.
>> v6:
>> - Incorporated review comments by Cedric & Daniel.
>> ---
>>   include/hw/fsi/lbus.h | 43 ++++++++++++++++++++++++
>>   hw/fsi/lbus.c         | 76 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/Kconfig            |  1 +
>>   hw/fsi/Kconfig        |  2 ++
>>   hw/fsi/meson.build    |  1 +
>>   hw/meson.build        |  1 +
>>   6 files changed, 124 insertions(+)
>>   create mode 100644 include/hw/fsi/lbus.h
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/meson.build
>
>
>> +#define TYPE_FSI_LBUS_DEVICE "fsi.lbus.device"
>> +OBJECT_DECLARE_TYPE(FSILBusDevice, FSILBusDeviceClass, FSI_LBUS_DEVICE)
>> +
>> +#define FSI_LBUS_MEM_REGION_SIZE  (2 * 1024 * 1024)
>> +#define FSI_LBUSDEV_IOMEM_SIZE    0x400
>> +
>> +typedef struct FSILBusDevice {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +    uint32_t address;
>
> [1] 32-bit address,
>
>> +} FSILBusDevice;
>> +
>
>
>> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
>> new file mode 100644
>> index 0000000000..50d926dbe2
>> --- /dev/null
>> +++ b/hw/fsi/lbus.c
>> @@ -0,0 +1,76 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Local bus where FSI slaves are connected
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "hw/fsi/lbus.h"
>> +
>> +#include "hw/qdev-properties.h"
>> +
>> +static void lbus_init(Object *o)
>> +{
>> +    FSILBus *lbus = FSI_LBUS(o);
>> +
>> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_FSI_LBUS,
>> +                       FSI_LBUS_MEM_REGION_SIZE - 
>> FSI_LBUSDEV_IOMEM_SIZE);
>> +}
>> +
>> +static const TypeInfo lbus_info = {
>> +    .name = TYPE_FSI_LBUS,
>> +    .parent = TYPE_BUS,
>> +    .instance_init = lbus_init,
>> +    .instance_size = sizeof(FSILBus),
>> +};
>> +
>> +static Property lbus_device_props[] = {
>> +    DEFINE_PROP_UINT32("address", FSILBusDevice, address, 0),
>
> [2] 32-bit address,
>
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +DeviceState *lbus_create_device(FSILBus *bus, const char *type, 
>> uint32_t addr)
>> +{
>> +    DeviceState *ds;
>> +    BusState *state = BUS(bus);
>> +    FSILBusDevice *dev;
>> +
>> +    ds = qdev_new(type);
>> +    qdev_prop_set_uint8(ds, "address", addr);
>
> [3] set 8-bit address but [1] and [2] declare as 32-bit.
Good catch. Fixed it.
>
>> +    qdev_realize_and_unref(ds, state, &error_fatal);
>
> If you pass the bus as argument here, ...
>
>> +
>> +    dev = FSI_LBUS_DEVICE(ds);
>> +    memory_region_add_subregion(&bus->mr, dev->address,
>> +                                &dev->iomem);
>> +
>> +    qdev_set_parent_bus(ds, state, &error_abort);
>
> ... why do you need that call here?

You are right. qdev_realize() call qdev_set_parent_bus() so I removed 
this call. I will publish the change in version 7.

Thanks for the review.

Regards,

Ninad

>
>> +
>> +    return ds;
>> +}
>
> Thanks,
>
> Phil.

