Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BF978BB45
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 00:59:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalBT-0004vN-Uf; Mon, 28 Aug 2023 18:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalBQ-0004su-0I; Mon, 28 Aug 2023 18:58:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalBM-0004aq-Cb; Mon, 28 Aug 2023 18:58:07 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SMcTIs004934; Mon, 28 Aug 2023 22:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HW97Na586UHT373IRoGfWf659jPgcZteu9lKvhth2xE=;
 b=IBh1WMQL93QNS7JR1Cao26XQNWNISA2o1muy1xwRoNnWhds9/wwQ3FXL9fR36dPhPeox
 AHe4KVJU3VpC04XLKuEknB/qZGant/GVtDyBR4sJvlPz35vRkOeSyqwRHPJFy2YTUQLO
 JxHFOmCM1dnKJT2An7UiErDK92hbNKPG011UObFF5dEM0XOeK3RQ/sNtHMu2mU6zDjt8
 d0IjHb3FA/K1TQfDXUhA7vtFgoxhxfLi+s1vLWkywTLG3Q6RxIPYT5FHUkbDFnkc/d6Z
 SYuAccf7MqVYmYeOM/KPoJG1qXrT1J605tJqg4XHfTePNuu0JeQb9CxBwg5fGgHv+Tmy lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr9j2tkjg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:57:50 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SMnS0B007356;
 Mon, 28 Aug 2023 22:57:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sr9j2tkjc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:57:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SKjSSi009989; Mon, 28 Aug 2023 22:57:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqw7k6p0q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:57:49 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37SMvmuT27329144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 22:57:48 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 52E625805C;
 Mon, 28 Aug 2023 22:57:48 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8801958051;
 Mon, 28 Aug 2023 22:57:47 +0000 (GMT)
Received: from [9.61.30.201] (unknown [9.61.30.201])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Aug 2023 22:57:47 +0000 (GMT)
Message-ID: <7a889563-99e1-4466-a1d9-4e897fe50c9c@linux.ibm.com>
Date: Mon, 28 Aug 2023 17:57:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/7] hw/fsi: Aspeed APB2OPB interface
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 qemu-arm@nongnu.org
References: <20230825203046.3692467-1-ninad@linux.ibm.com>
 <20230825203046.3692467-7-ninad@linux.ibm.com>
 <CACPK8XdS5hCBb43QjhKaAjphqzK_S=0n3xOKXeNaOH39Bzb4nA@mail.gmail.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CACPK8XdS5hCBb43QjhKaAjphqzK_S=0n3xOKXeNaOH39Bzb4nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SJGurk8nyUfOTO9qw3c5B-ICQaDv7Yaw
X-Proofpoint-ORIG-GUID: 8WT0sSFjxh8v_9pCmku5hXtuy55Sqq8v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280194
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

Hi Joel,

On 8/28/23 23:55, Joel Stanley wrote:
> On Fri, 25 Aug 2023 at 20:31, Ninad Palsule <ninad@linux.ibm.com> wrote:
>> This is a part of patchset where IBM's Flexible Service Interface is
>> introduced.
>>
>> An APB-to-OPB bridge enabling access to the OPB from the ARM core in
>> the AST2600. Hardware limitations prevent the OPB from being directly
>> mapped into APB, so all accesses are indirect through the bridge.
>>
>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   hw/arm/Kconfig                  |   1 +
>>   hw/fsi/Kconfig                  |   4 +
>>   hw/fsi/aspeed-apb2opb.c         | 346 ++++++++++++++++++++++++++++++++
>>   hw/fsi/meson.build              |   1 +
>>   hw/fsi/trace-events             |   2 +
>>   hw/fsi/trace.h                  |   1 +
>>   include/hw/fsi/aspeed-apb2opb.h |  32 +++
>>   meson.build                     |   1 +
>>   8 files changed, 388 insertions(+)
>>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>>   create mode 100644 hw/fsi/trace-events
>>   create mode 100644 hw/fsi/trace.h
>>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>>
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 7e68348440..a6994cd9d7 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -589,6 +589,7 @@ config FSL_IMX7
>>       select PCI_EXPRESS_DESIGNWARE
>>       select SDHCI
>>       select UNIMP
>> +    select APB2OPB_ASPEED
>>
>>   config ARM_SMMUV3
>>       bool
>> diff --git a/hw/fsi/Kconfig b/hw/fsi/Kconfig
>> index 560ce536db..fbb021658d 100644
>> --- a/hw/fsi/Kconfig
>> +++ b/hw/fsi/Kconfig
>> @@ -1,3 +1,7 @@
>> +config APB2OPB_ASPEED
>> +    bool
>> +    select OPB
>> +
>>   config OPB
>>       bool
>>       select CFAM
>> diff --git a/hw/fsi/aspeed-apb2opb.c b/hw/fsi/aspeed-apb2opb.c
>> new file mode 100644
>> index 0000000000..bbc63f2eb3
>> --- /dev/null
>> +++ b/hw/fsi/aspeed-apb2opb.c
>> @@ -0,0 +1,346 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * ASPEED APB-OPB FSI interface
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qom/object.h"
>> +#include "qapi/error.h"
>> +#include "trace.h"
>> +
>> +#include "hw/fsi/aspeed-apb2opb.h"
>> +#include "hw/qdev-core.h"
>> +
>> +#define TO_REG(x) (x >> 2)
>> +#define GENMASK(t, b) (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
> We should put this in a common header.
Moved it to bitops.h
>
>> +
>> +#define APB2OPB_VERSION                    TO_REG(0x00)
>> +#define   APB2OPB_VERSION_VER              GENMASK(7, 0)
>> +
>> +#define APB2OPB_TRIGGER                    TO_REG(0x04)
>> +#define   APB2OPB_TRIGGER_EN               BIT(0)
>> +
>> +#define APB2OPB_CONTROL                    TO_REG(0x08)
>> +#define   APB2OPB_CONTROL_OFF              GENMASK(31, 13)
>> +
>> +#define APB2OPB_OPB2FSI                    TO_REG(0x0c)
>> +#define   APB2OPB_OPB2FSI_OFF              GENMASK(31, 22)
>> +
>> +#define APB2OPB_OPB0_SEL                   TO_REG(0x10)
>> +#define APB2OPB_OPB1_SEL                   TO_REG(0x28)
>> +#define   APB2OPB_OPB_SEL_EN               BIT(0)
>> +
>> +#define APB2OPB_OPB0_MODE                  TO_REG(0x14)
>> +#define APB2OPB_OPB1_MODE                  TO_REG(0x2c)
>> +#define   APB2OPB_OPB_MODE_RD              BIT(0)
>> +
>> +#define APB2OPB_OPB0_XFER                  TO_REG(0x18)
>> +#define APB2OPB_OPB1_XFER                  TO_REG(0x30)
>> +#define   APB2OPB_OPB_XFER_FULL            BIT(1)
>> +#define   APB2OPB_OPB_XFER_HALF            BIT(0)
>> +
>> +#define APB2OPB_OPB0_ADDR                  TO_REG(0x1c)
>> +#define APB2OPB_OPB0_WRITE_DATA            TO_REG(0x20)
>> +
>> +#define APB2OPB_OPB1_DMA_EN                TO_REG(0x24)
>> +#define APB2OPB_OPB1_DMA_EN_3              BIT(3)
>> +#define APB2OPB_OPB1_DMA_EN_2              BIT(2)
>> +#define APB2OPB_OPB1_DMA_EN_1              BIT(1)
>> +#define APB2OPB_OPB1_DMA_EN_0              BIT(0)
>> +
>> +#define APB2OPB_OPB1_ADDR                  TO_REG(0x34)
>> +#define APB2OPB_OPB1_WRITE_DATA                  TO_REG(0x38)
>> +
>> +#define APB2OPB_OPB_CLK                    TO_REG(0x3c)
>> +#define   APB2OPB_OPB_CLK_SYNC             BIT(0)
>> +
>> +#define APB2OPB_IRQ_CLEAR                  TO_REG(0x40)
>> +#define   APB2OPB_IRQ_CLEAR_EN             BIT(0)
>> +
>> +#define APB2OPB_IRQ_MASK                   TO_REG(0x44)
>> +#define   APB2OPB_IRQ_MASK_OPB1_TX_ACK     BIT(17)
>> +#define   APB2OPB_IRQ_MASK_OPB0_TX_ACK     BIT(16)
>> +#define   APB2OPB_IRQ_MASK_CH3_TCONT       BIT(15)
>> +#define   APB2OPB_IRQ_MASK_CH2_TCONT       BIT(14)
>> +#define   APB2OPB_IRQ_MASK_CH1_TCONT       BIT(13)
>> +#define   APB2OPB_IRQ_MASK_CH0_TCONT       BIT(12)
>> +#define   APB2OPB_IRQ_MASK_CH3_FIFO_EMPTY  BIT(11)
>> +#define   APB2OPB_IRQ_MASK_CH2_FIFO_EMPTY  BIT(10)
>> +#define   APB2OPB_IRQ_MASK_CH1_FIFO_EMPTY  BIT(9)
>> +#define   APB2OPB_IRQ_MASK_CH0_FIFO_EMPTY  BIT(8)
>> +#define   APB2OPB_IRQ_MASK_CH3_FIFO_FULL   BIT(7)
>> +#define   APB2OPB_IRQ_MASK_CH2_FIFO_FULL   BIT(6)
>> +#define   APB2OPB_IRQ_MASK_CH1_FIFO_FULL   BIT(5)
>> +#define   APB2OPB_IRQ_MASK_CH0_FIFO_FULL   BIT(4)
>> +#define   APB2OPB_IRQ_MASK_CH3_DMA_EOT     BIT(3)
>> +#define   APB2OPB_IRQ_MASK_CH2_DMA_EOT     BIT(2)
>> +#define   APB2OPB_IRQ_MASK_CH1_DMA_EOT     BIT(1)
>> +#define   APB2OPB_IRQ_MASK_CH0_DMA_EOT     BIT(0)
>> +
>> +#define APB2OPB_IRQ_STS                    TO_REG(0x48)
>> +#define   APB2OPB_IRQ_STS_MASTER_ERROR     BIT(28)
>> +#define   APB2OPB_IRQ_STS_PORT_ERROR       BIT(27)
>> +#define   APB2OPB_IRQ_STS_HOTPLUG          BIT(26)
>> +#define   APB2OPB_IRQ_STS_SLAVE_7          BIT(25)
>> +#define   APB2OPB_IRQ_STS_SLAVE_6          BIT(24)
>> +#define   APB2OPB_IRQ_STS_SLAVE_5          BIT(23)
>> +#define   APB2OPB_IRQ_STS_SLAVE_4          BIT(22)
>> +#define   APB2OPB_IRQ_STS_SLAVE_3          BIT(21)
>> +#define   APB2OPB_IRQ_STS_SLAVE_2          BIT(20)
>> +#define   APB2OPB_IRQ_STS_SLAVE_1          BIT(19)
>> +#define   APB2OPB_IRQ_STS_SLAVE_0          BIT(18)
>> +#define   APB2OPB_IRQ_STS_OPB1_TX_ACK      BIT(17)
>> +#define   APB2OPB_IRQ_STS_OPB0_TX_ACK      BIT(16)
>> +#define   APB2OPB_IRQ_STS_CH3_TCONT        BIT(15)
>> +#define   APB2OPB_IRQ_STS_CH2_TCONT        BIT(14)
>> +#define   APB2OPB_IRQ_STS_CH1_TCONT        BIT(13)
>> +#define   APB2OPB_IRQ_STS_CH0_TCONT        BIT(12)
>> +#define   APB2OPB_IRQ_STS_CH3_FIFO_EMPTY   BIT(11)
>> +#define   APB2OPB_IRQ_STS_CH2_FIFO_EMPTY   BIT(10)
>> +#define   APB2OPB_IRQ_STS_CH1_FIFO_EMPTY   BIT(9)
>> +#define   APB2OPB_IRQ_STS_CH0_FIFO_EMPTY   BIT(8)
>> +#define   APB2OPB_IRQ_STS_CH3_FIFO_FULL    BIT(7)
>> +#define   APB2OPB_IRQ_STS_CH2_FIFO_FULL    BIT(6)
>> +#define   APB2OPB_IRQ_STS_CH1_FIFO_FULL    BIT(5)
>> +#define   APB2OPB_IRQ_STS_CH0_FIFO_FULL    BIT(4)
>> +#define   APB2OPB_IRQ_STS_CH3_DMA_EOT      BIT(3)
>> +#define   APB2OPB_IRQ_STS_CH2_DMA_EOT      BIT(2)
>> +#define   APB2OPB_IRQ_STS_CH1_DMA_EOT      BIT(1)
>> +#define   APB2OPB_IRQ_STS_CH0_DMA_EOT      BIT(0)
>> +
>> +#define APB2OPB_OPB0_WRITE_WORD_ENDIAN     TO_REG(0x4c)
>> +#define   APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE 0x0011101b
>> +#define APB2OPB_OPB0_WRITE_BYTE_ENDIAN     TO_REG(0x50)
>> +#define   APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE 0x0c330f3f
>> +#define APB2OPB_OPB1_WRITE_WORD_ENDIAN     TO_REG(0x54)
>> +#define APB2OPB_OPB1_WRITE_BYTE_ENDIAN     TO_REG(0x58)
>> +#define APB2OPB_OPB0_READ_BYTE_ENDIAN      TO_REG(0x5c)
>> +#define   APB2OPB_OPB0_READ_WORD_ENDIAN_BE  0x00030b1b
>> +#define APB2OPB_OPB1_READ_BYTE_ENDIAN      TO_REG(0x60)
>> +
>> +#define APB2OPB_RETRY                      TO_REG(0x64)
>> +#define   APB2OPB_RETRY_COUNTER            GENMASK(15, 0)
>> +
>> +#define APB2OPB_OPB0_STATUS                TO_REG(0x80)
>> +#define APB2OPB_OPB1_STATUS                TO_REG(0x8c)
>> +#define   APB2OPB_OPB_STATUS_TIMEOUT       BIT(4)
>> +#define   APB2OPB_OPB_STATUS_RETRY         BIT(3)
>> +#define   APB2OPB_OPB_STATUS_ERROR_ACK     BIT(2)
>> +#define   APB2OPB_OPB_STATUS_FW_ACK        BIT(1)
>> +#define   APB2OPB_OPB_STATUS_HW_ACK        BIT(0)
>> +
>> +#define APB2OPB_OPB0_READ_DATA         TO_REG(0x84)
>> +
>> +#define APB2OPB_OPB1_DMA_STATUS            TO_REG(0x88)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH3_EOT  BIT(7)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH2_EOT  BIT(6)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH1_EOT  BIT(5)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH0_EOT  BIT(4)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH3_REQ  BIT(3)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH2_REQ  BIT(2)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH1_REQ  BIT(1)
>> +#define   APB2OPB_OPB1_DMA_STATUS_CH0_REQ  BIT(0)
>> +
>> +#define APB2OPB_OPB1_READ_DATA         TO_REG(0x90)
>> +
>> +static uint64_t aspeed_apb2opb_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
>> +
>> +    trace_aspeed_apb2opb_read(addr, size);
>> +
>> +    assert(!(addr & 3));
>> +    assert(size == 4);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
>> +                      __func__, addr, size);
>> +        return 0;
>> +    }
>> +
>> +    return s->regs[TO_REG(addr)];
>> +}
>> +
>> +static void aspeed_apb2opb_write(void *opaque, hwaddr addr, uint64_t data,
>> +                                 unsigned size)
>> +{
>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
>> +
>> +    trace_aspeed_apb2opb_write(addr, size, data);
>> +
>> +    assert(!(addr & 3));
>> +    assert(size == 4);
>> +
>> +    if (addr + size > sizeof(s->regs)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
>> +                      __func__, addr, size);
>> +        return;
>> +    }
>> +
>> +    switch (TO_REG(addr)) {
>> +    case APB2OPB_CONTROL:
>> +        opb_fsi_master_address(&s->opb[0], data & APB2OPB_CONTROL_OFF);
>> +        break;
>> +    case APB2OPB_OPB2FSI:
>> +        opb_opb2fsi_address(&s->opb[0], data & APB2OPB_OPB2FSI_OFF);
>> +        break;
>> +    case APB2OPB_OPB0_WRITE_WORD_ENDIAN:
>> +        if (data != APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>> +                          __func__, APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE);
>> +        }
>> +        break;
>> +    case APB2OPB_OPB0_WRITE_BYTE_ENDIAN:
>> +        if (data != APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>> +                          __func__, APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE);
>> +        }
>> +        break;
>> +    case APB2OPB_OPB0_READ_BYTE_ENDIAN:
>> +        if (data != APB2OPB_OPB0_READ_WORD_ENDIAN_BE) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>> +                          __func__, APB2OPB_OPB0_READ_WORD_ENDIAN_BE);
>> +        }
>> +        break;
>> +    case APB2OPB_TRIGGER:
>> +    {
>> +        uint32_t opb, op_mode, op_size, op_addr, op_data;
>> +
>> +        assert((s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) ^
>> +               (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN));
>> +
>> +        if (s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) {
>> +            opb = 0;
>> +            op_mode = s->regs[APB2OPB_OPB0_MODE];
>> +            op_size = s->regs[APB2OPB_OPB0_XFER];
>> +            op_addr = s->regs[APB2OPB_OPB0_ADDR];
>> +            op_data = s->regs[APB2OPB_OPB0_WRITE_DATA];
>> +        } else if (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN) {
>> +            opb = 1;
>> +            op_mode = s->regs[APB2OPB_OPB1_MODE];
>> +            op_size = s->regs[APB2OPB_OPB1_XFER];
>> +            op_addr = s->regs[APB2OPB_OPB1_ADDR];
>> +            op_data = s->regs[APB2OPB_OPB1_WRITE_DATA];
>> +        } else {
>> +            g_assert_not_reached();
>> +        }
>> +
>> +        if (op_size & ~(APB2OPB_OPB_XFER_HALF | APB2OPB_OPB_XFER_FULL)) {
>> +            qemu_log_mask(LOG_GUEST_ERROR,
>> +                          "OPB transaction failed: Unrecognised access width: %d\n",
>> +                          op_size);
>> +            return;
>> +        }
>> +
>> +        op_size += 1;
>> +
>> +        if (op_mode & APB2OPB_OPB_MODE_RD) {
>> +            int index = opb ? APB2OPB_OPB1_READ_DATA
>> +                : APB2OPB_OPB0_READ_DATA;
>> +
>> +            switch (op_size) {
>> +            case 1:
>> +                s->regs[index] = opb_read8(&s->opb[opb], op_addr);
>> +                break;
>> +            case 2:
>> +                s->regs[index] = opb_read16(&s->opb[opb], op_addr);
>> +                break;
>> +            case 4:
>> +                s->regs[index] = opb_read32(&s->opb[opb], op_addr);
>> +                break;
>> +            default:
>> +                g_assert_not_reached(); /* should have bailed above */
>> +            }
>> +        } else {
>> +            /* FIXME: Endian swizzling */
>> +            switch (op_size) {
>> +            case 1:
>> +                opb_write8(&s->opb[opb], op_addr, op_data);
>> +                break;
>> +            case 2:
>> +                opb_write16(&s->opb[opb], op_addr, op_data);
>> +                break;
>> +            case 4:
>> +                opb_write32(&s->opb[opb], op_addr, op_data);
>> +                break;
>> +            default:
>> +                g_assert_not_reached(); /* should have bailed above */
>> +            }
>> +        }
>> +        s->regs[APB2OPB_IRQ_STS] |= opb ? APB2OPB_IRQ_STS_OPB1_TX_ACK
>> +            : APB2OPB_IRQ_STS_OPB0_TX_ACK;
>> +        break;
>> +    }
>> +    }
>> +
>> +    s->regs[TO_REG(addr)] = data;
>> +}
>> +
>> +static const struct MemoryRegionOps aspeed_apb2opb_ops = {
>> +    .read = aspeed_apb2opb_read,
>> +    .write = aspeed_apb2opb_write,
>> +    .endianness = DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void aspeed_apb2opb_realize(DeviceState *dev, Error **errp)
>> +{
>> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
>> +
>> +    qbus_init(&s->opb[0], sizeof(s->opb[0]), TYPE_OP_BUS,
>> +                        DEVICE(s), NULL);
>> +    qbus_init(&s->opb[1], sizeof(s->opb[1]), TYPE_OP_BUS,
>> +                        DEVICE(s), NULL);
>> +
>> +    sysbus_init_irq(sbd, &s->irq);
>> +
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_apb2opb_ops, s,
>> +                          TYPE_ASPEED_APB2OPB, 0x1000);
>> +    sysbus_init_mmio(sbd, &s->iomem);
>> +}
>> +
>> +static void aspeed_apb2opb_reset(DeviceState *dev)
>> +{
>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(dev);
>> +
>> +    memset(s->regs, 0, sizeof(s->regs));
>> +
>> +    s->regs[APB2OPB_VERSION] = 0x000000a1;
>> +    s->regs[APB2OPB_OPB0_WRITE_WORD_ENDIAN] = 0x0044eee4;
>> +    s->regs[APB2OPB_OPB0_WRITE_BYTE_ENDIAN] = 0x0055aaff;
>> +    s->regs[APB2OPB_OPB1_WRITE_WORD_ENDIAN] = 0x00117717;
>> +    s->regs[APB2OPB_OPB1_WRITE_BYTE_ENDIAN] = 0xffaa5500;
>> +    s->regs[APB2OPB_OPB0_READ_BYTE_ENDIAN] = 0x0044eee4;
>> +    s->regs[APB2OPB_OPB0_READ_BYTE_ENDIAN] = 0x00117717;
> Add a comment about the source of these magic numbers. I think this is
> the best reference we have:
>
> https://git.kernel.org/torvalds/c/5e5022995683539609b3904213b7d72ab71188b7
>
> I'm not sure if the reset values were taken from the hardware, or the
> kernel driver.
Added comment. These magic numbers are from AST2600 data sheet.
>
>> +}
>> +
>> +static void aspeed_apb2opb_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->desc = "ASPEED APB2OPB Bridge";
>> +    dc->realize = aspeed_apb2opb_realize;
>> +    dc->reset = aspeed_apb2opb_reset;
>> +}
>> +
>> +static const TypeInfo aspeed_apb2opb_info = {
>> +    .name = TYPE_ASPEED_APB2OPB,
>> +    .parent = TYPE_SYS_BUS_DEVICE,
>> +    .instance_size = sizeof(AspeedAPB2OPBState),
>> +    .class_init = aspeed_apb2opb_class_init,
>> +};
>> +
>> +static void aspeed_apb2opb_register_types(void)
>> +{
>> +    type_register_static(&aspeed_apb2opb_info);
>> +}
>> +
>> +type_init(aspeed_apb2opb_register_types);
>> diff --git a/hw/fsi/meson.build b/hw/fsi/meson.build
>> index cab645f4ea..ce8b9555ce 100644
>> --- a/hw/fsi/meson.build
>> +++ b/hw/fsi/meson.build
>> @@ -3,3 +3,4 @@ system_ss.add(when: 'CONFIG_SCRATCHPAD', if_true: files('engine-scratchpad.c'))
>>   system_ss.add(when: 'CONFIG_CFAM', if_true: files('cfam.c'))
>>   system_ss.add(when: 'CONFIG_FSI', if_true: files('fsi.c','fsi-master.c','fsi-slave.c'))
>>   system_ss.add(when: 'CONFIG_OPB', if_true: files('opb.c'))
>> +system_ss.add(when: 'CONFIG_APB2OPB_ASPEED', if_true: files('aspeed-apb2opb.c'))
>> diff --git a/hw/fsi/trace-events b/hw/fsi/trace-events
>> new file mode 100644
>> index 0000000000..c64245f7f6
>> --- /dev/null
>> +++ b/hw/fsi/trace-events
>> @@ -0,0 +1,2 @@
>> +aspeed_apb2opb_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
>> +aspeed_apb2opb_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
>> diff --git a/hw/fsi/trace.h b/hw/fsi/trace.h
>> new file mode 100644
>> index 0000000000..ee67c7fb04
>> --- /dev/null
>> +++ b/hw/fsi/trace.h
>> @@ -0,0 +1 @@
>> +#include "trace/trace-hw_fsi.h"
>> diff --git a/include/hw/fsi/aspeed-apb2opb.h b/include/hw/fsi/aspeed-apb2opb.h
>> new file mode 100644
>> index 0000000000..4acc980e7d
>> --- /dev/null
>> +++ b/include/hw/fsi/aspeed-apb2opb.h
>> @@ -0,0 +1,32 @@
>> +/*
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + * Copyright (C) 2023 IBM Corp.
>> + *
>> + * ASPEED APB2OPB Bridge
>> + */
>> +#ifndef FSI_ASPEED_APB2OPB_H
>> +#define FSI_ASPEED_APB2OPB_H
>> +
>> +#include "hw/sysbus.h"
>> +#include "hw/fsi/opb.h"
>> +
>> +#define TYPE_ASPEED_APB2OPB "aspeed.apb2opb"
>> +#define ASPEED_APB2OPB(obj) \
>> +    OBJECT_CHECK(AspeedAPB2OPBState, (obj), TYPE_ASPEED_APB2OPB)
>> +
>> +#define ASPEED_APB2OPB_NR_REGS ((0xe8 >> 2) + 1)
>> +
>> +typedef struct AspeedAPB2OPBState {
>> +    /*< private >*/
>> +    SysBusDevice parent_obj;
>> +
>> +    /*< public >*/
>> +    MemoryRegion iomem;
>> +
>> +    uint32_t regs[ASPEED_APB2OPB_NR_REGS];
>> +    qemu_irq irq;
>> +
>> +    OPBus opb[2];
>> +} AspeedAPB2OPBState;
>> +
>> +#endif /* FSI_ASPEED_APB2OPB_H */
>> diff --git a/meson.build b/meson.build
>> index 98e68ef0b1..1a722693a6 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -3244,6 +3244,7 @@ if have_system
>>       'hw/char',
>>       'hw/display',
>>       'hw/dma',
>> +    'hw/fsi',
>>       'hw/hyperv',
>>       'hw/i2c',
>>       'hw/i386',
>> --
>> 2.39.2
>>
Thanks for the review.

Ninad


