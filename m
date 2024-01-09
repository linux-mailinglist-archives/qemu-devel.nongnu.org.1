Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F7828F74
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 23:10:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNKHb-0007IX-6Y; Tue, 09 Jan 2024 17:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKHJ-0007Gq-O0; Tue, 09 Jan 2024 17:08:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1rNKHG-0004AZ-1H; Tue, 09 Jan 2024 17:08:56 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 409LY7xx016383; Tue, 9 Jan 2024 22:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lyQ55igLuzLNmSMuTQ2CxmrWrBO01F1GMmLRqq07uoE=;
 b=iYGsh+bJKvlXH8Oc/E+uQdNX4DEsHJJz+1LvsAGh30ZYc2WWee8DItzc1NF0oNhYaV7d
 vt7noLnISRc5BTa1c+zRZewzhNH4Rya5Z7MBmUub+S2yJMfxw/JXRJfHw5CSvOXsmZn0
 lsPfj01WElTEAQJ9NEIMX2pMyQDFzlXCofOQLffIE68Whp2VT5wihVh0AFpLHJsZ4zNH
 QwhB1p7B/xvAYHyGPY0ucPgHepsu+/kLs/JlroTqRJT4K1q79QQ+o58snunTpXVvC4xA
 8bZxy4KrTh+jhOgPp0mF7MBaEKdlRRZWlf7akPHQEPYgZrjlUnIsYSzA4q7DeB8ukNPj hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f906we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:08:33 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409LkUTC012220;
 Tue, 9 Jan 2024 22:08:32 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh9f906w5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:08:32 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 409KbaCj000926; Tue, 9 Jan 2024 22:08:31 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdk94q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jan 2024 22:08:31 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 409M8UAB42074418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jan 2024 22:08:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C737B5805D;
 Tue,  9 Jan 2024 22:08:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C48058057;
 Tue,  9 Jan 2024 22:08:30 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jan 2024 22:08:30 +0000 (GMT)
Message-ID: <3a0efed2-620f-48e1-b400-a0313694476b@linux.ibm.com>
Date: Tue, 9 Jan 2024 16:08:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] hw/fsi: Introduce IBM's cfam,fsi-slave,scratchpad
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231128235700.599584-1-ninad@linux.ibm.com>
 <20231128235700.599584-4-ninad@linux.ibm.com>
 <4bce745f-c70f-414a-bf1a-f53503d5bc1a@kaod.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <4bce745f-c70f-414a-bf1a-f53503d5bc1a@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kzX97PInrku-9liL0AvFBW0WlX3OYYQ9
X-Proofpoint-ORIG-GUID: LvatMcKMKLvNttfx6MdfR5FhnJPChDbt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401090177
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
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

Hello Cedric,


>> +
>> +#define TYPE_FSI_SCRATCHPAD "fsi.scratchpad"
>> +#define SCRATCHPAD(obj) OBJECT_CHECK(FSIScratchPad, (obj), 
>> TYPE_FSI_SCRATCHPAD)
>> +
>> +typedef struct FSIScratchPad {
>> +        FSILBusDevice parent;
>> +
>> +        uint32_t reg;
>> +} FSIScratchPad;
>
> We could extend to 4 regs possibly.
OK, Added 4 registers.
>
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
>
> The address space is not used. please remove.
Removed address space.
>
>>
>> +#include "exec/memory.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#include "hw/fsi/lbus.h"
>> +
>> +#include <stdint.h>
>
> Not needed. Please remove.
Removed the header file.
>
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
>
> Please introduce a macro to build these register values.
Added macros
>
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
>
> If I understand correctly, the register 0xC contains some static config
> value for the first device engine, the scratchpad device mapped at 0xC00,
> and following registers would do the same for other devices if they were
> modelled.
>
> This is certtainly hardwired in HW, so I would simplify to :
>
>     case 0xC:
>         return ldc->config
>     default:
>         /* log not implemented */
>
> And extend the list when more devices are modeled.
Simplified as per your suggestion.
>
>> +        /*
>> +         * As per FSI specification, This is a magic value at 
>> address 0 of
>> +         * given FSI port. This causes FSI master to send BREAK 
>> command for
>> +         * initialization and recovery.
>> +         */
>> +        return CFAM_CONFIG_CHIP_ID_BREAK;
>
> This looks weird. I don't understant to which offset this value belongs.
Yes, Removed it for now. We are handling break command in the config write.
>
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
>
> Couldn't we introduce a proper define for this reg ? and can we write to
> the config space ? This break command seems to be sent to the FSI master,
> according to Linux. Why is it handled in the CFAM config space ?
Added new PEEK_STATUS register. The BREAK command is send by FSI-master 
to FSI-slave and FSI-slave is embedded into CFAM hence we are handling 
it here.
>
>> +        if (data == CFAM_CONFIG_CHIP_ID_BREAK) {
>> +            bus_cold_reset(BUS(&cfam->lbus));
>> +        }
>> +    break;
>
> alignment is not good.
Fixed the alignment.
>
>>
>> +static void fsi_cfam_realize(DeviceState *dev, Error **errp)
>> +{
>> +    FSICFAMState *cfam = FSI_CFAM(dev);
>> +    FSISlaveState *slave = FSI_SLAVE(dev);
>> +
>> +    /* Each slave has a 2MiB address space */
>> +    memory_region_init_io(&cfam->mr, OBJECT(cfam), 
>> &fsi_cfam_unimplemented_ops,
>> +                          cfam, TYPE_FSI_CFAM, 2 * 1024 * 1024);
>
> 2 * MiB
Now using MiB.
>
>> +
>> +    /* Add scratchpad engine */
>> +    if (!qdev_realize_and_unref(DEVICE(&cfam->scratchpad), 
>> BUS(&cfam->lbus),
>
> cfam->scratchpad is not allocated. We should use qdev_realize instead.
Fixed it.
>
>>
>> +    /* TODO: clarify scratchpad mapping */
>
> You can remove the TODO now. All Local bus devices are mapped at offset
> 0xc00.
Removed it.
>
>>
>> +static void fsi_scratchpad_reset(DeviceState *dev)
>> +{
>> +    FSIScratchPad *s = SCRATCHPAD(dev);
>> +
>> +    s->reg = 0;
>
> Just one reg ! Too easy :) let's have a few more.
Now clear 4 registers.
>
>
>>
>> +    ldc->config =
>> +          ENGINE_CONFIG_NEXT            | /* valid */
>> +          0x00010000                    | /* slots */
>> +          0x00001000                    | /* version */
>> +          ENGINE_CONFIG_TYPE_SCRATCHPAD | /* type */
>> +          0x00000007;                     /* crc */
>
> This class and attribute do not  look useful. Please use a macro
> to build the value and return it in the CFAM config read operation.
Added macro for SCARTCHPAD config value but keeping the class as new 
devices need it.
>
>
>>
>> +
>> +static uint64_t fsi_slave_read(void *opaque, hwaddr addr, unsigned 
>> size)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(opaque);
>> +
>> +    trace_fsi_slave_read(addr, size);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>
> This test is mixing memory region offsets and memop size. These are two
> fields of different nature. So this is quite incorrect !
>
> Ideally, we should have a switch statement with handlers for implemented
> registers and a default for the rest. Please see the aspeed_scu model
> for an example.
I have fixed the limit check but registers are simply used as a memory 
region hence did not add switch statement.
>
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
>
> Same here.
Fixed the limit check.
>
>> +
>> +static void fsi_slave_init(Object *o)
>> +{
>> +    FSISlaveState *s = FSI_SLAVE(o);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &fsi_slave_ops,
>> +                          s, TYPE_FSI_SLAVE, 0x400);
>> +}
>
>
> No reset handler ?

Added reset handler.

Thanks for the review.

Regards,

Ninad


