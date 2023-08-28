Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF62978BB39
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qal9R-00034p-Pr; Mon, 28 Aug 2023 18:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qal9O-00033x-BM; Mon, 28 Aug 2023 18:56:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qal9K-0003yE-Ph; Mon, 28 Aug 2023 18:56:01 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SMgVHn023622; Mon, 28 Aug 2023 22:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XzA5Pxo0Nct2PYWJOnfz3R+5cnvtWU3I5LUBFbPuNjA=;
 b=AtrifIUUz02W/8EyMDzOIV0q3c2gijldfk+DZ6dkLCxJ4hjsFoqziw5FyUn8nKDDdDmM
 N8rRdyD9Tj+Rw61AGi7D2Q7cXgZZjolkrMjqbymtao3NtYDjkO0v3aDoydYpsnjuqN0w
 OggKD/jVhG85UPweAAfVYfbabnouKX4MYJNg8xXKQA/s8rcD90vRudc90xb3yrUtqA0Q
 1O13bgjC6DiT/kXQ8qIiJ9nGT+VExEJoMgGPgmbbVy0T/gd1Voe9V+yavogPfMWQU/Ql
 yeG3IndP5z1UvU/I3rn7wLpzrg2/+kfEWWYrmEGKtmQ2z55pG2ds7m6BP6wHFgUaO9CP 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vyc5rh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:55:38 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SMa93S002426;
 Mon, 28 Aug 2023 22:55:37 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr7vyc5ra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:55:37 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SLO8up014209; Mon, 28 Aug 2023 22:55:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjpe2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:55:36 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37SMtZqu3605158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 22:55:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9489F5805F;
 Mon, 28 Aug 2023 22:55:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36DDC5805E;
 Mon, 28 Aug 2023 22:55:35 +0000 (GMT)
Received: from [9.61.30.201] (unknown [9.61.30.201])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Aug 2023 22:55:35 +0000 (GMT)
Message-ID: <c57b7b31-13c3-40d6-9081-be2c04b01e67@linux.ibm.com>
Date: Mon, 28 Aug 2023 17:55:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/7] hw/fsi: Introduce IBM's Local bus
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-2-ninad@linux.ibm.com>
 <CACPK8Xfd=FLCA2=1cvcyD=wcX56v7O88wH_zRf-D8oA4L8ORfw@mail.gmail.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CACPK8Xfd=FLCA2=1cvcyD=wcX56v7O88wH_zRf-D8oA4L8ORfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QdKvqLDRSYwve3_cKhKX07ZORR3TaNdj
X-Proofpoint-GUID: r6K9hro_HTsVIRjS1cUrm1CLYaocgZx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Hi Joel,

On 8/28/23 23:34, Joel Stanley wrote:
> On Fri, 25 Aug 2023 at 20:31, Ninad Palsule <ninad@linux.ibm.com> wrote:
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
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   hw/Kconfig            |  1 +
>>   hw/fsi/Kconfig        |  2 +
>>   hw/fsi/lbus.c         | 94 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/fsi/meson.build    |  1 +
>>   hw/meson.build        |  1 +
>>   include/hw/fsi/bits.h | 15 +++++++
>>   include/hw/fsi/lbus.h | 57 ++++++++++++++++++++++++++
>>   7 files changed, 171 insertions(+)
>>   create mode 100644 hw/fsi/Kconfig
>>   create mode 100644 hw/fsi/lbus.c
>>   create mode 100644 hw/fsi/meson.build
>>   create mode 100644 include/hw/fsi/bits.h
>>   create mode 100644 include/hw/fsi/lbus.h
>>
>> diff --git a/hw/Kconfig b/hw/Kconfig
>> index ba62ff6417..2ccb73add5 100644
>> --- a/hw/Kconfig
>> +++ b/hw/Kconfig
>> @@ -9,6 +9,7 @@ source core/Kconfig
>>   source cxl/Kconfig
>>   source display/Kconfig
>>   source dma/Kconfig
>> +source fsi/Kconfig
>>   source gpio/Kconfig
>>   source hyperv/Kconfig
>>   source i2c/Kconfig
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> new file mode 100644
>> index 0000000000..687449e14e
>> --- /dev/null
>> +++ b/hw/fsi/Kconfig
>> @@ -0,0 +1,2 @@
>> +config LBUS
>> +    bool
>> diff --git a/hw/fsi/lbus.c b/hw/fsi/lbus.c
>> new file mode 100644
>> index 0000000000..afb26ef7ea
>> --- /dev/null
>> +++ b/hw/fsi/lbus.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Local bus where FSI slaves are connected
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +
>> +#include "hw/fsi/lbus.h"
>> +
>> +#include "hw/qdev-properties.h"
>> +
>> +static void lbus_realize(BusState *bus, Error **errp)
>> +{
>> +    LBusNode *node;
>> +    LBus *lbus = LBUS(bus);
>> +
>> +    memory_region_init(&lbus->mr, OBJECT(lbus), TYPE_LBUS,
>> +                       (2 * 1024 * 1024) - 0x400);
>> +
>> +    QLIST_FOREACH(node, &lbus->devices, next) {
>> +        memory_region_add_subregion(&lbus->mr, node->ldev->address,
>> +                                    &node->ldev->iomem);
>> +    }
>> +}
>> +
>> +static void lbus_init(Object *o)
>> +{
>> +}
>> +
>> +static void lbus_class_init(ObjectClass *klass, void *data)
>> +{
>> +    BusClass *k = BUS_CLASS(klass);
>> +    k->realize = lbus_realize;
>> +}
>> +
>> +static const TypeInfo lbus_info = {
>> +    .name = TYPE_LBUS,
>> +    .parent = TYPE_BUS,
>> +    .instance_init = lbus_init,
>> +    .instance_size = sizeof(LBus),
>> +    .class_init = lbus_class_init,
>> +};
>> +
>> +static Property lbus_device_props[] = {
>> +    DEFINE_PROP_UINT32("address", LBusDevice, address, 0),
>> +    DEFINE_PROP_END_OF_LIST(),
>> +};
>> +
>> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr)
>> +{
>> +    DeviceState *dev;
>> +    LBusNode *node;
>> +
>> +    dev = qdev_new(type);
>> +    qdev_prop_set_uint8(dev, "address", addr);
>> +    qdev_realize_and_unref(dev, &bus->bus, &error_fatal);
>> +
>> +    /* Move to post_load */
>> +    node = g_malloc(sizeof(struct LBusNode));
>> +    node->ldev = LBUS_DEVICE(dev);
>> +    QLIST_INSERT_HEAD(&bus->devices, node, next);
>> +
>> +    return dev;
>> +}
>> +
>> +static void lbus_device_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->bus_type = TYPE_LBUS;
>> +    device_class_set_props(dc, lbus_device_props);
>> +}
>> +
>> +static const TypeInfo lbus_device_type_info = {
>> +    .name = TYPE_LBUS_DEVICE,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_size = sizeof(LBusDevice),
>> +    .abstract = true,
>> +    .class_init = lbus_device_class_init,
>> +    .class_size = sizeof(LBusDeviceClass),
>> +};
>> +
>> +static void lbus_register_types(void)
>> +{
>> +    type_register_static(&lbus_info);
>> +    type_register_static(&lbus_device_type_info);
>> +}
>> +
>> +type_init(lbus_register_types);
>> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
>> new file mode 100644
>> index 0000000000..e1007d5fea
>> --- /dev/null
>> +++ b/hw/fsi/meson.build
>> @@ -0,0 +1 @@
>> +system_ss.add(when: 'CONFIG_LBUS', if_true: files('lbus.c'))
>> diff --git a/hw/meson.build b/hw/meson.build
>> index c7ac7d3d75..6c71ee9cfa 100644
>> --- a/hw/meson.build
>> +++ b/hw/meson.build
>> @@ -43,6 +43,7 @@ subdir('virtio')
>>   subdir('watchdog')
>>   subdir('xen')
>>   subdir('xenpv')
>> +subdir('fsi')
>>
>>   subdir('alpha')
>>   subdir('arm')
>> diff --git a/include/hw/fsi/bits.h b/include/hw/fsi/bits.h
>> new file mode 100644
>> index 0000000000..338ae483cf
>> --- /dev/null
>> +++ b/include/hw/fsi/bits.h
>> @@ -0,0 +1,15 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * Bit operation macros
>> + */
>> +#ifndef FSI_BITS_H
>> +#define FSI_BITS_H
>> +
>> +#define BE_BIT(x)                          BIT(31 - (x))
>> +#define GENMASK(t, b) \
>> +    (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
>> +#define BE_GENMASK(t, b)                   GENMASK(BE_BIT(t), BE_BIT(b))
> These are similar to the PPC_BIT definitions. We have a copy of them
> in taget/ppc/cpu.h, perhaps they could be moved into a common header.
Moved it to bitopts.h and removed a bits.h file.
>
>> +
>> +#endif /* FSI_BITS_H */
>> diff --git a/include/hw/fsi/lbus.h b/include/hw/fsi/lbus.h
>> new file mode 100644
>> index 0000000000..00ed7e5250
>> --- /dev/null
>> +++ b/include/hw/fsi/lbus.h
>> @@ -0,0 +1,57 @@
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
>> +#define TYPE_LBUS_DEVICE "lbus.device"
>> +#define LBUS_DEVICE(obj) \
>> +    OBJECT_CHECK(LBusDevice, (obj), TYPE_LBUS_DEVICE)
>> +#define LBUS_DEVICE_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(LBusDeviceClass, (klass), TYPE_LBUS_DEVICE)
>> +#define LBUS_DEVICE_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(LBusDeviceClass, (obj), TYPE_LBUS_DEVICE)
> I think we can use OBJECT_DECLARE_SIMPLE_TYPE here to create the macros for us.
Changed it various places.
>
>> +
>> +typedef struct LBusDevice {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +    uint32_t address;
>> +} LBusDevice;
>> +
>> +typedef struct LBusDeviceClass {
>> +    DeviceClass parent;
>> +
>> +    uint32_t config;
>> +} LBusDeviceClass;
>> +
>> +typedef struct LBusNode {
>> +    LBusDevice *ldev;
>> +
>> +    QLIST_ENTRY(LBusNode) next;
>> +} LBusNode;
>> +
>> +#define TYPE_LBUS "lbus"
>> +#define LBUS(obj) OBJECT_CHECK(LBus, (obj), TYPE_LBUS)
>> +#define LBUS_CLASS(klass) \
>> +    OBJECT_CLASS_CHECK(LBusClass, (klass), TYPE_LBUS)
>> +#define LBUS_GET_CLASS(obj) \
>> +    OBJECT_GET_CLASS(LBusClass, (obj), TYPE_LBUS)
> Same here.
Fixed.
>
>> +
>> +typedef struct LBus {
>> +    BusState bus;
>> +
>> +    MemoryRegion mr;
>> +
>> +    QLIST_HEAD(, LBusNode) devices;
>> +} LBus;
>> +
>> +DeviceState *lbus_create_device(LBus *bus, const char *type, uint32_t addr);
>> +int lbus_add_device(LBus *bus, LBusDevice *dev);
>> +#endif /* FSI_LBUS_H */
>> --
>> 2.39.2
>>
Thanks for the review

Ninad


