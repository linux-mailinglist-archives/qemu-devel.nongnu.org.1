Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC47FC9B1
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 23:42:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r86ko-0000KY-Jb; Tue, 28 Nov 2023 17:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86ki-0000JH-6u; Tue, 28 Nov 2023 17:40:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1r86ke-00076w-FA; Tue, 28 Nov 2023 17:40:23 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASMM7OW005085; Tue, 28 Nov 2023 22:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=pp1; bh=y/GMD2CTW+jHvr8Rv1uO80jXD3wekU5bwjGlAgIxsp0=;
 b=ktIvF3QIKdDrwQXzVNoLKB5/ZzTMecjT8h1k7eSEzMy9KLg6W5O1L1GeQRVe6TPzSv4c
 sL6qXffuek6Pz3BtdHNd/JD7MAdur7x10ghexFg0miKJJqJgHhwOaOu4m+Ae0kF/0vE7
 Wo/rJv/bRVdzZqlfp2gh/vquiqXa60ogtTHEnZMU4/ost6dlyCv9+hKXTMUnWBYw2boO
 2bkNxXCpKkp8E08j4nrgMZiPXByv4T59o87nXfNpDDpegoRonjjymKLR29s5X1MqEDHf
 3bQaKu1YFF9A3vPNQE5LDoRnqt98tkfULcP0AnNX2MoJUF+GNFkwnG7n+W8/SzanQotU 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrxgg9s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:40:03 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ASMdsYO014348;
 Tue, 28 Nov 2023 22:40:03 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3unrxgg9b0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:40:03 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ASJvOF2018257; Tue, 28 Nov 2023 22:36:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy1tsun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Nov 2023 22:36:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ASMaNAT40567492
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Nov 2023 22:36:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B1885804B;
 Tue, 28 Nov 2023 22:36:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B8AD5805B;
 Tue, 28 Nov 2023 22:36:20 +0000 (GMT)
Received: from [9.67.87.213] (unknown [9.67.87.213])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Nov 2023 22:36:20 +0000 (GMT)
Content-Type: multipart/mixed; boundary="------------0UAOzqp8MLrTHoD9Nw9oxt6B"
Message-ID: <a1f52834-60e3-4814-b878-098f3549a145@linux.ibm.com>
Date: Tue, 28 Nov 2023 16:36:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <20231026164741.1184058-4-ninad@linux.ibm.com>
 <b7e62d5b-91a2-48c3-ad48-ce7cf8abffcb@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <b7e62d5b-91a2-48c3-ad48-ce7cf8abffcb@kaod.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Rd9M1gyVB_0w4JitklSI6q_iZxmrOU51
X-Proofpoint-ORIG-GUID: wqlZPNfPDMA-48ut_9Y0VfoK4MJKXN8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280178
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

This is a multi-part message in MIME format.
--------------0UAOzqp8MLrTHoD9Nw9oxt6B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Cedric,

On 11/27/23 10:31, Cédric Le Goater wrote:
> On 10/26/23 18:47, Ninad Palsule wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> The Common FRU Access Macro (CFAM), an address space containing
>> various "engines" that drive accesses on busses internal and external
>> to the POWER chip. Examples include the SBEFIFO and I2C masters. The
>> engines hang off of an internal Local Bus (LBUS) which is described
>> by the CFAM configuration block.
>>
>> The FSI slave: The slave is the terminal point of the FSI bus for
>> FSI symbols addressed to it. Slaves can be cascaded off of one
>> another. The slave's configuration registers appear in address space
>> of the CFAM to which it is attached.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>> v2:
>> - Incorporated Joel's review comments.
>> v3:
>> - Incorporated Thomas Huth's review comments.
>> v5:
>> - Incorporated review comments by Cedric.
>> v6:
>> - Incorporated review comments by Cedric & Daniel
>> ---
>>   include/hw/fsi/cfam.h      |  34 ++++++++
>>   include/hw/fsi/fsi-slave.h |  29 +++++++
>>   include/hw/fsi/fsi.h       |  20 +++++
>>   hw/fsi/cfam.c              | 173 +++++++++++++++++++++++++++++++++++++
>>   hw/fsi/fsi-slave.c         |  78 +++++++++++++++++
>>   hw/fsi/Kconfig             |   9 ++
>>   hw/fsi/meson.build         |   2 +
>>   hw/fsi/trace-events        |   7 ++
>>   8 files changed, 352 insertions(+)
>>   create mode 100644 include/hw/fsi/cfam.h
>>   create mode 100644 include/hw/fsi/fsi-slave.h
>>   create mode 100644 hw/fsi/cfam.c
>>   create mode 100644 hw/fsi/fsi-slave.c
>>
>> diff --git a/include/hw/fsi/cfam.h b/include/hw/fsi/cfam.h
>> new file mode 100644
>> index 0000000000..842a3bad0c
>> --- /dev/null
>> +++ b/include/hw/fsi/cfam.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Common FRU Access Macro
>> + */
>> +#ifndef FSI_CFAM_H
>> +#define FSI_CFAM_H
>> +
>> +#include "exec/memory.h"
>> +
>> +#include "hw/fsi/fsi-slave.h"
>> +#include "hw/fsi/lbus.h"
>> +
>> +#define TYPE_FSI_CFAM "cfam"
>> +#define FSI_CFAM(obj) OBJECT_CHECK(FSICFAMState, (obj), TYPE_FSI_CFAM)
>> +
>> +/* P9-ism */
>> +#define CFAM_CONFIG_NR_REGS 0x28
>> +
>> +typedef struct FSICFAMState {
>> +    /* < private > */
>> +    FSISlaveState parent;
>> +
>> +    /* CFAM config address space */
>> +    MemoryRegion config_iomem;
>> +
>> +    MemoryRegion mr;
>> +    AddressSpace as;
>> +
>> +    FSILBus lbus;
>> +} FSICFAMState;
>> +
>> +#endif /* FSI_CFAM_H */
>> diff --git a/include/hw/fsi/fsi-slave.h b/include/hw/fsi/fsi-slave.h
>> new file mode 100644
>> index 0000000000..f5f23f4457
>> --- /dev/null
>> +++ b/include/hw/fsi/fsi-slave.h
>> @@ -0,0 +1,29 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Flexible Service Interface slave
>> + */
>> +#ifndef FSI_FSI_SLAVE_H
>> +#define FSI_FSI_SLAVE_H
>> +
>> +#include "exec/memory.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#include "hw/fsi/lbus.h"
>> +
>> +#include <stdint.h>
>> +
>> +#define TYPE_FSI_SLAVE "fsi.slave"
>> +OBJECT_DECLARE_SIMPLE_TYPE(FSISlaveState, FSI_SLAVE)
>> +
>> +#define FSI_SLAVE_CONTROL_NR_REGS ((0x40 >> 2) + 1)
>> +
>> +typedef struct FSISlaveState {
>> +    DeviceState parent;
>> +
>> +    MemoryRegion iomem;
>> +    uint32_t regs[FSI_SLAVE_CONTROL_NR_REGS];
>> +} FSISlaveState;
>> +
>> +#endif /* FSI_FSI_H */
>> diff --git a/include/hw/fsi/fsi.h b/include/hw/fsi/fsi.h
>> index b08b97f62b..3cbc685226 100644
>> --- a/include/hw/fsi/fsi.h
>> +++ b/include/hw/fsi/fsi.h
>> @@ -8,9 +8,29 @@
>>   #define FSI_FSI_H
>>     #include "qemu/bitops.h"
>> +#include "hw/qdev-core.h"
>> +
>> +/*
>> + * TODO: Maybe unwind this dependency with const links? Store a
>> + * pointer in FSIBus?
>> + */
>> +#include "hw/fsi/cfam.h"
>>     /* Bitwise operations at the word level. */
>>   #define BE_BIT(x)           BIT(31 - (x))
>>   #define BE_GENMASK(hb, lb)  MAKE_64BIT_MASK((lb), ((hb) - (lb) + 1))
>>   +#define TYPE_FSI_BUS "fsi.bus"
>> +OBJECT_DECLARE_SIMPLE_TYPE(FSIBus, FSI_BUS)
>> +
>> +/* TODO: Figure out what's best with a point-to-point bus */
>> +typedef struct FSISlaveState FSISlaveState;
>> +
>> +typedef struct FSIBus {
>> +    BusState bus;
>> +
>> +    /* XXX: It's point-to-point, just instantiate the slave directly 
>> for now */
>> +    FSICFAMState slave;
>> +} FSIBus;
>> +
>>   #endif
>> diff --git a/hw/fsi/cfam.c b/hw/fsi/cfam.c
>> new file mode 100644
>> index 0000000000..a1c037925f
>> --- /dev/null
>> +++ b/hw/fsi/cfam.c
>> @@ -0,0 +1,173 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Common FRU Access Macro
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/cfam.h"
>> +#include "hw/fsi/fsi.h"
>> +#include "hw/fsi/engine-scratchpad.h"
>> +
>> +#include "hw/qdev-properties.h"
>> +
>> +#define TO_REG(x)                          ((x) >> 2)
>> +
>> +#define CFAM_ENGINE_CONFIG                  TO_REG(0x04)
>> +
>> +#define CFAM_CONFIG_CHIP_ID                TO_REG(0x00)
>> +#define CFAM_CONFIG_CHIP_ID_P9             0xc0022d15
>> +#define CFAM_CONFIG_CHIP_ID_BREAK          0xc0de0000
>> +
>> +static uint64_t fsi_cfam_config_read(void *opaque, hwaddr addr, 
>> unsigned size)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(opaque);
>> +    BusChild *kid;
>> +    int i;
>> +
>> +    trace_fsi_cfam_config_read(addr, size);
>> +
>> +    switch (addr) {
>> +    case 0x00:
>> +        return CFAM_CONFIG_CHIP_ID_P9;
>> +    case 0x04:
>> +        return ENGINE_CONFIG_NEXT       |   /* valid */
>> +               0x00010000               |   /* slots */
>> +               0x00001000               |   /* version */
>> +               ENGINE_CONFIG_TYPE_PEEK  |   /* type */
>> +               0x0000000c;                  /* crc */
>> +    case 0x08:
>> +        return ENGINE_CONFIG_NEXT       |   /* valid */
>> +               0x00010000               |   /* slots */
>> +               0x00005000               |   /* version */
>> +               ENGINE_CONFIG_TYPE_FSI   |   /* type */
>> +               0x0000000a;                  /* crc */
>> +        break;
>> +    default:
>> +        /* The config table contains different engines from 0xc 
>> onwards. */
>> +        i = 0xc;
>> +        QTAILQ_FOREACH(kid, &cfam->lbus.bus.children, sibling) {
>> +            if (i == addr) {
>> +                DeviceState *ds = kid->child;
>> +                FSILBusDevice *dev = FSI_LBUS_DEVICE(ds);
>> +                return FSI_LBUS_DEVICE_GET_CLASS(dev)->config;
>> +            }
>> +            i += size;
>> +        }
>> +
>> +        if (i == addr) {
>> +            return 0;
>> +        }
>> +
>> +        /*
>> +         * As per FSI specification, This is a magic value at 
>> address 0 of
>> +         * given FSI port. This causes FSI master to send BREAK 
>> command for
>> +         * initialization and recovery.
>> +         */
>> +        return CFAM_CONFIG_CHIP_ID_BREAK;
>> +    }
>> +}
>> +
>> +static void fsi_cfam_config_write(void *opaque, hwaddr addr, 
>> uint64_t data,
>> +                                  unsigned size)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(opaque);
>> +
>> +    trace_fsi_cfam_config_write(addr, size, data);
>> +
>> +    switch (TO_REG(addr)) {
>> +    case CFAM_CONFIG_CHIP_ID:
>> +    case CFAM_CONFIG_CHIP_ID + 4:
>> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
>> +            bus_cold_reset(BUS(&cfam->lbus));
>> +        }
>> +    break;
>> +    default:
>> +        trace_fsi_cfam_config_write_noaddr(addr, size, data);
>> +    }
>> +}
>> +
>> +static const struct MemoryRegionOps cfam_config_ops = {
>> +    .read = fsi_cfam_config_read,
>> +    .write = fsi_cfam_config_write,
>> +    .valid.max_access_size = 4,
>> +    .valid.min_access_size = 4,
>> +    .impl.max_access_size = 4,
>> +    .impl.min_access_size = 4,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static uint64_t fsi_cfam_unimplemented_read(void *opaque, hwaddr addr,
>> +                                            unsigned size)
>> +{
>> +    trace_fsi_cfam_unimplemented_read(addr, size);
>> +
>> +    return 0;
>> +}
>> +
>> +static void fsi_cfam_unimplemented_write(void *opaque, hwaddr addr,
>> +                                         uint64_t data, unsigned size)
>> +{
>> +    trace_fsi_cfam_unimplemented_write(addr, size, data);
>> +}
>> +
>> +static const struct MemoryRegionOps fsi_cfam_unimplemented_ops = {
>> +    .read = fsi_cfam_unimplemented_read,
>> +    .write = fsi_cfam_unimplemented_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void fsi_cfam_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(dev);
>> +    FSISlaveState *slave = FSI_SLAVE(dev);
>> +
>> +    /* Each slave has a 2MiB address space */
>> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), 
>> &fsi_cfam_unimplemented_ops,
>> +                          cfam, TYPE_FSI_CFAM, 2 * 1024 * 1024);
>> +    address_space_init(&cfam->as, &cfam->mr, TYPE_FSI_CFAM);
>> +
>> +    qbus_init(&cfam->lbus, sizeof(cfam->lbus), TYPE_FSI_LBUS,
>> +                        DEVICE(cfam), NULL);
>> +
>> +    memory_region_init_io(&cfam->config_iomem, OBJECT(cfam), 
>> &cfam_config_ops,
>> +                          cfam, TYPE_FSI_CFAM, 0x400);
>> +
>> +    if (!object_property_set_bool(OBJECT(&cfam->lbus), "realized", 
>> true,
>> +                                  errp)) {
>> +        return;
>> +    }
>> +
>> +    memory_region_add_subregion(&cfam->mr, 0, &cfam->config_iomem);
>> +    memory_region_add_subregion(&cfam->mr, 0x800, &slave->iomem);
>> +    memory_region_add_subregion(&cfam->mr, 0xc00, &cfam->lbus.mr);
>> +
>> +    /* Add scratchpad engine */
>> +    lbus_create_device(&cfam->lbus, TYPE_FSI_SCRATCHPAD, 0);
>
> I am bit lost in the various mappings. Could you please provide more
> explanations ?

Please see the attached file.

Thanks for the review.

Regards,

Ninad

>
>
> Thanks,
>
> C.
>
>
>> +}
>> +
>> +static void fsi_cfam_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +    dc->bus_type = TYPE_FSI_BUS;
>> +    dc->realize = fsi_cfam_realize;
>> +}
>> +
>> +static const TypeInfo fsi_cfam_info = {
>> +    .name = TYPE_FSI_CFAM,
>> +    .parent = TYPE_FSI_SLAVE,
>> +    .instance_size = sizeof(FSICFAMState),
>> +    .class_init = fsi_cfam_class_init,
>> +};
>> +
>> +static void fsi_cfam_register_types(void)
>> +{
>> +    type_register_static(&fsi_cfam_info);
>> +}
>> +
>> +type_init(fsi_cfam_register_types);
>> diff --git a/hw/fsi/fsi-slave.c b/hw/fsi/fsi-slave.c
>> new file mode 100644
>> index 0000000000..70386c0bb8
>> --- /dev/null
>> +++ b/hw/fsi/fsi-slave.c
>> @@ -0,0 +1,78 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * IBM Flexible Service Interface slave
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/error.h"
>> +#include "qemu/log.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/fsi-slave.h"
>> +#include "hw/fsi/fsi.h"
>> +
>> +#define TO_REG(x)                               ((x) >> 2)
>> +
>> +static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(opaque);
>> +
>> +    trace_fsi_slave_read(addr, size);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for 
>> %u\n",
>> +                      __func__, addr, size);
>> +        return 0;
>> +    }
>> +
>> +    return s->regs[TO_REG(addr)];
>> +}
>> +
>> +static void fsi_slave_write(void *opaque, hwaddr addr, uint64_t data,
>> +                                 unsigned size)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(opaque);
>> +
>> +    trace_fsi_slave_write(addr, size, data);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds write: 0x%"HWADDR_PRIx" for 
>> %u\n",
>> +                      __func__, addr, size);
>> +        return;
>> +    }
>> +
>> +    s->regs[TO_REG(addr)] = data;
>> +}
>> +
>> +static const struct MemoryRegionOps fsi_slave_ops = {
>> +    .read = fsi_slave_read,
>> +    .write = fsi_slave_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +};
>> +
>> +static void fsi_slave_init(Object *o)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(o);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
>> +                          s, TYPE_FSI_SLAVE, 0x400);
>> +}
>> +
>> +static const TypeInfo fsi_slave_info = {
>> +    .name = TYPE_FSI_SLAVE,
>> +    .parent = TYPE_DEVICE,
>> +    .instance_init = fsi_slave_init,
>> +    .instance_size = sizeof(FSISlaveState),
>> +};
>> +
>> +static void fsi_slave_register_types(void)
>> +{
>> +    type_register_static(&fsi_slave_info);
>> +}
>> +
>> +type_init(fsi_slave_register_types);
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> index f7c7fd1b28..8d712e77ed 100644
>> --- a/hw/fsi/Kconfig
>> +++ b/hw/fsi/Kconfig
>> @@ -1,3 +1,12 @@
>> +config FSI_CFAM
>> +    bool
>> +    select FSI
>> +    select FSI_SCRATCHPAD
>> +    select FSI_LBUS
>> +
>> +config FSI
>> +    bool
>> +
>>   config FSI_SCRATCHPAD
>>       bool
>>       select FSI_LBUS
>> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
>> index d45a98c223..a9e7cd4099 100644
>> --- a/hw/fsi/meson.build
>> +++ b/hw/fsi/meson.build
>> @@ -1,2 +1,4 @@
>>   system_ss.add(when: 'CONFIG_FSI_LBUS', if_true: files('lbus.c'))
>>   system_ss.add(when: 'CONFIG_FSI_SCRATCHPAD', if_true: 
>> files('engine-scratchpad.c'))
>> +system_ss.add(when: 'CONFIG_FSI_CFAM', if_true: files('cfam.c'))
>> +system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi-slave.c'))
>> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
>> index c5753e2791..b57b2dcc86 100644
>> --- a/hw/fsi/trace-events
>> +++ b/hw/fsi/trace-events
>> @@ -1,2 +1,9 @@
>>   fsi_scratchpad_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " 
>> size=%d"
>>   fsi_scratchpad_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_config_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " 
>> size=%d"
>> +fsi_cfam_config_write(uint64_t addr, uint32_t size, uint64_t data) 
>> "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_unimplemented_read(uint64_t addr, uint32_t size) "@0x%" 
>> PRIx64 " size=%d"
>> +fsi_cfam_unimplemented_write(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_cfam_config_write_noaddr(uint64_t addr, uint32_t size, uint64_t 
>> data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> +fsi_slave_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>> +fsi_slave_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" 
>> PRIx64 " size=%d value=0x%"PRIx64
>
--------------0UAOzqp8MLrTHoD9Nw9oxt6B
Content-Type: application/vnd.oasis.opendocument.text; name="MemoryMap.odt"
Content-Disposition: attachment; filename="MemoryMap.odt"
Content-Transfer-Encoding: base64

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
uhqwz2u7xGb1NXzuO0h3+XTcskqa66uTVfzZULweI8U7TGt2E/lqACK4afGr3FffDiCAtllA
tWfWU/s55ZKYIPrMB0mqSzW2929oA2SoEdtCPTwNie2x1LL1YAqHOLbHib85mt0bTl8OHIO2
AXXM7YmALF4B6QKyfAWkC8jVKyBdQK5fAekCcvMKSBeQ21dAuoDcvQLSBWT1CkivMQv/Qoh0
SS5MBZNYQFtcpGRb1XeuDcGvz4EpY1L9HkIsqk965l18h2il3rjqQTtRNEjVL1zuHHM8VE9g
Sp79ikr5O91CXCRjBpJhA614hUhrwZCa0cOt+aJAX7CvbpwXvSF4aiktDBSnsqaRIub6W061
1TtfeGhp7Ycd6tUDZMIJ1BLsuXwLy42OsLydk8pjmUfeAFPvhkZT9iRRn+veze3dkR5t7xZH
naulA3jSZ5yoz+nqZWZcckSkd3pFdXt3ezV2RXVKU0ANU7ixriUZY85+o2Di0c/RofFO3cW2
n/3UDAKXVpyBJpyH4a2Dg33Q9TcY4NATNNNydTfAhFL1bDrI06bkvScYJc0lDEr+Vwlp4sJE
ixnnkNe1UYvrb9s3SfPNTKj/89zvKoZW3jqcYaTe9fSPwEXBGTwV1MboaVDWhByJRkajrR5U
ks4+zbk2O8Hs5EZPfDD8Tw0efgNQSwcIfYEumLEIAACqMAAAUEsDBBQAAAgAADGyfFcAAAAA
AAAAAAAAAAAaAAAAQ29uZmlndXJhdGlvbnMyL3Rvb2xwYW5lbC9QSwMEFAAACAAAMbJ8VwAA
AAAAAAAAAAAAABgAAABDb25maWd1cmF0aW9uczIvbWVudWJhci9QSwMEFAAACAAAMbJ8VwAA
AAAAAAAAAAAAABoAAABDb25maWd1cmF0aW9uczIvcG9wdXBtZW51L1BLAwQUAAAIAAAxsnxX
AAAAAAAAAAAAAAAAGAAAAENvbmZpZ3VyYXRpb25zMi9mbG9hdGVyL1BLAwQUAAAIAAAxsnxX
AAAAAAAAAAAAAAAAGAAAAENvbmZpZ3VyYXRpb25zMi90b29sYmFyL1BLAwQUAAAIAAAxsnxX
AAAAAAAAAAAAAAAAHwAAAENvbmZpZ3VyYXRpb25zMi9pbWFnZXMvQml0bWFwcy9QSwMEFAAA
CAAAMbJ8VwAAAAAAAAAAAAAAABwAAABDb25maWd1cmF0aW9uczIvcHJvZ3Jlc3NiYXIvUEsD
BBQAAAgAADGyfFcAAAAAAAAAAAAAAAAcAAAAQ29uZmlndXJhdGlvbnMyL2FjY2VsZXJhdG9y
L1BLAwQUAAAIAAAxsnxXAAAAAAAAAAAAAAAAGgAAAENvbmZpZ3VyYXRpb25zMi9zdGF0dXNi
YXIvUEsDBBQAAAgAADGyfFdSVT6JpxcAAKcXAAAYAAAAVGh1bWJuYWlscy90aHVtYm5haWwu
cG5niVBORw0KGgoAAAANSUhEUgAAAMYAAAEACAMAAADfg/lyAAABSlBMVEUGBgYKCgorKysq
OkwyRlwzSF42S2M4TmY7Ums9VnA+WHNCQkJSUlJaWlpAWnVCXXpFYH5kZGRsbGxzc3N7e3tG
YoBIZYRKaIdMaotPbpBQb5FRcpRUdZlWeJ1Yep9Md69Pea9XeqBZfaNbgKZdgqpUg7pdib5g
hq5gh7BiirNljrlnkLtokb5fjMBhjcFjkMRplMRolshtmMZumspwlsNymcdyns59nMR4nch5
oMuDg4OMjIyTk5Obm5uLlKCKmq+jo6Orq6uzs7O7u7uCps6Kqc6OrdGRp8KQq82RrtKWs9Wa
tNSiuNSlvtqswty7xM6zxdy4yd+9zeHDw8PLy8vEy9PCzt7T09Pb29vAz+LD0uTJ1ubM2OjS
3erW4Oza4u3f5/Dj4+Pr6+vg5/Hk6vLp7vTt8fbv8/jz8/Px9Pj2+Pv+/v4AAAD///8hbBoA
AAAWGElEQVR42u1d+3fbuJXuPjqdaNvQSSyRKq1mLcoj07KPTLPhHovELh7T2T3TNjsboAWa
ZGYK1Ekwxv//+15Qfj9iW7Zlaw5BiyYlkuLHi3u/74Ig9Av3syi/aGA0MBoYDYwGRgOjgdHA
aGA0MBoYDYwGRgOjgdHAaGD8/GHs73+8cFooGHvfZuPx+IJX9vW7xYHxJit2i0tK/nrm7zWU
qgoj7Ky1zho/N37J/5d+2VEh/ZpfFIJwTugtYPwjKz5T8r/NCoMpyUpSVq6qEK5gRmDOHSoR
9gXwUYRFWQqJlcGVUAyjW8D4c/HZsju7NYjCuqocnDMRcN6EEiYdJmqCMKEYO07gTXywrS/4
FjC+/jyM4i4rOKvnlN6Db1zuGHUZL4iLX2GMxYExiMZpfyMdDcbhOEzbnajXGUSdNArCVpCP
9xcFRtzqxdFS0AqfxGm81IlXAEPSyVtfDlqdrxbFGq82B71e72k/HsRJFO+E0ThZiYNBrz+I
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
AAAAABoAAAAAAAAAAAAAAAAANgkAAENvbmZpZ3VyYXRpb25zMi90b29scGFuZWwvUEsBAhQA
FAAACAAAMbJ8VwAAAAAAAAAAAAAAABgAAAAAAAAAAAAAAAAAbgkAAENvbmZpZ3VyYXRpb25z
Mi9tZW51YmFyL1BLAQIUABQAAAgAADGyfFcAAAAAAAAAAAAAAAAaAAAAAAAAAAAAAAAAAKQJ
AABDb25maWd1cmF0aW9uczIvcG9wdXBtZW51L1BLAQIUABQAAAgAADGyfFcAAAAAAAAAAAAA
AAAYAAAAAAAAAAAAAAAAANwJAABDb25maWd1cmF0aW9uczIvZmxvYXRlci9QSwECFAAUAAAI
AAAxsnxXAAAAAAAAAAAAAAAAGAAAAAAAAAAAAAAAAAASCgAAQ29uZmlndXJhdGlvbnMyL3Rv
b2xiYXIvUEsBAhQAFAAACAAAMbJ8VwAAAAAAAAAAAAAAAB8AAAAAAAAAAAAAAAAASAoAAENv
bmZpZ3VyYXRpb25zMi9pbWFnZXMvQml0bWFwcy9QSwECFAAUAAAIAAAxsnxXAAAAAAAAAAAA
AAAAHAAAAAAAAAAAAAAAAACFCgAAQ29uZmlndXJhdGlvbnMyL3Byb2dyZXNzYmFyL1BLAQIU
ABQAAAgAADGyfFcAAAAAAAAAAAAAAAAcAAAAAAAAAAAAAAAAAL8KAABDb25maWd1cmF0aW9u
czIvYWNjZWxlcmF0b3IvUEsBAhQAFAAACAAAMbJ8VwAAAAAAAAAAAAAAABoAAAAAAAAAAAAA
AAAA+QoAAENvbmZpZ3VyYXRpb25zMi9zdGF0dXNiYXIvUEsBAhQAFAAACAAAMbJ8V1JVPomn
FwAApxcAABgAAAAAAAAAAAAAAAAAMQsAAFRodW1ibmFpbHMvdGh1bWJuYWlsLnBuZ1BLAQIU
ABQACAgIADGyfFe2uA4hXA0AACNkAAALAAAAAAAAAAAAAAAAAA4jAABjb250ZW50LnhtbFBL
AQIUABQACAgIADGyfFfjUlAMyAEAANMDAAAIAAAAAAAAAAAAAAAAAKMwAABtZXRhLnhtbFBL
AQIUABQACAgIADGyfFe092jSBQEAAIMDAAAMAAAAAAAAAAAAAAAAAKEyAABtYW5pZmVzdC5y
ZGZQSwECFAAUAAgICAAxsnxXksTHbeQGAAA+LwAADAAAAAAAAAAAAAAAAADgMwAAc2V0dGlu
Z3MueG1sUEsBAhQAFAAICAgAMbJ8V+Fc9tkvAQAAJQQAABUAAAAAAAAAAAAAAAAA/joAAE1F
VEEtSU5GL21hbmlmZXN0LnhtbFBLBQYAAAAAEQARAGUEAABwPAAAAAA=

--------------0UAOzqp8MLrTHoD9Nw9oxt6B--


