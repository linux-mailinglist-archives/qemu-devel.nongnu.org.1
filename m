Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1338D7D5606
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:23:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJF4-0003YG-D6; Tue, 24 Oct 2023 11:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvJEW-0003Ed-2u; Tue, 24 Oct 2023 11:22:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1ohf=GG=kaod.org=clg@ozlabs.org>)
 id 1qvJEO-0003DQ-J2; Tue, 24 Oct 2023 11:22:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFG4p5dlnz4x5l;
 Wed, 25 Oct 2023 02:22:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFG4k2ccYz4wy6;
 Wed, 25 Oct 2023 02:21:58 +1100 (AEDT)
Message-ID: <58deedee-a291-4d73-a3f1-09ea16c953f0@kaod.org>
Date: Tue, 24 Oct 2023 17:21:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/10] hw/fsi: Aspeed APB2OPB interface
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>
References: <20231021211720.3571082-1-ninad@linux.ibm.com>
 <20231021211720.3571082-7-ninad@linux.ibm.com>
 <c1aace06-0eab-4805-b58d-e108b53158dc@kaod.org>
 <1b83521d-4885-490e-b8d7-1d760de5c173@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <1b83521d-4885-490e-b8d7-1d760de5c173@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1ohf=GG=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/24/23 17:00, Ninad Palsule wrote:
> Hello Cedric,
> 
> On 10/24/23 02:46, Cédric Le Goater wrote:
>> On 10/21/23 23:17, Ninad Palsule wrote:
>>> This is a part of patchset where IBM's Flexible Service Interface is
>>> introduced.
>>>
>>> An APB-to-OPB bridge enabling access to the OPB from the ARM core in
>>> the AST2600. Hardware limitations prevent the OPB from being directly
>>> mapped into APB, so all accesses are indirect through the bridge.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> ---
>>> v2:
>>> - Incorporated review comments by Joel
>>> v3:
>>> - Incorporated review comments by Thomas Huth
>>> v4:
>>>    - Compile FSI with ASPEED_SOC only.
>>> v5:
>>> - Incorporated review comments by Cedric.
>>> v6:
>>> - Incorporated review comments by Cedric.
>>> ---
>>>   include/hw/fsi/aspeed-apb2opb.h |  33 ++++
>>>   hw/fsi/aspeed-apb2opb.c         | 280 ++++++++++++++++++++++++++++++++
>>>   hw/arm/Kconfig                  |   1 +
>>>   hw/fsi/Kconfig                  |   4 +
>>>   hw/fsi/meson.build              |   1 +
>>>   hw/fsi/trace-events             |   2 +
>>>   6 files changed, 321 insertions(+)
>>>   create mode 100644 include/hw/fsi/aspeed-apb2opb.h
>>>   create mode 100644 hw/fsi/aspeed-apb2opb.c
>>>
>>> diff --git a/include/hw/fsi/aspeed-apb2opb.h b/include/hw/fsi/aspeed-apb2opb.h
>>> new file mode 100644
>>> index 0000000000..a81ae67023
>>> --- /dev/null
>>> +++ b/include/hw/fsi/aspeed-apb2opb.h
>>> @@ -0,0 +1,33 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + * Copyright (C) 2023 IBM Corp.
>>> + *
>>> + * ASPEED APB2OPB Bridge
>>> + */
>>> +#ifndef FSI_ASPEED_APB2OPB_H
>>> +#define FSI_ASPEED_APB2OPB_H
>>> +
>>> +#include "hw/sysbus.h"
>>> +#include "hw/fsi/opb.h"
>>> +
>>> +#define TYPE_ASPEED_APB2OPB "aspeed.apb2opb"
>>> +OBJECT_DECLARE_SIMPLE_TYPE(AspeedAPB2OPBState, ASPEED_APB2OPB)
>>> +
>>> +#define ASPEED_APB2OPB_NR_REGS ((0xe8 >> 2) + 1)
>>> +
>>> +#define ASPEED_FSI_NUM 2
>>> +
>>> +typedef struct AspeedAPB2OPBState {
>>> +    /*< private >*/
>>> +    SysBusDevice parent_obj;
>>> +
>>> +    /*< public >*/
>>> +    MemoryRegion iomem;
>>> +
>>> +    uint32_t regs[ASPEED_APB2OPB_NR_REGS];
>>> +    qemu_irq irq;
>>> +
>>> +    OPBus opb[ASPEED_FSI_NUM];
>>> +} AspeedAPB2OPBState;
>>> +
>>> +#endif /* FSI_ASPEED_APB2OPB_H */
>>> diff --git a/hw/fsi/aspeed-apb2opb.c b/hw/fsi/aspeed-apb2opb.c
>>> new file mode 100644
>>> index 0000000000..6f97a6bc7d
>>> --- /dev/null
>>> +++ b/hw/fsi/aspeed-apb2opb.c
>>> @@ -0,0 +1,280 @@
>>> +/*
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + * Copyright (C) 2023 IBM Corp.
>>> + *
>>> + * ASPEED APB-OPB FSI interface
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qom/object.h"
>>> +#include "qapi/error.h"
>>> +#include "trace.h"
>>> +
>>> +#include "hw/fsi/aspeed-apb2opb.h"
>>> +#include "hw/qdev-core.h"
>>> +
>>> +#define TO_REG(x) (x >> 2)
>>> +#define GENMASK(t, b) (((1ULL << ((t) + 1)) - 1) & ~((1ULL << (b)) - 1))
>>> +
>>> +#define APB2OPB_VERSION                    TO_REG(0x00)
>>> +#define   APB2OPB_VERSION_VER              GENMASK(7, 0)
>>> +
>>> +#define APB2OPB_TRIGGER                    TO_REG(0x04)
>>> +#define   APB2OPB_TRIGGER_EN               BIT(0)
>>> +
>>> +#define APB2OPB_CONTROL                    TO_REG(0x08)
>>> +#define   APB2OPB_CONTROL_OFF              GENMASK(31, 13)
>>> +
>>> +#define APB2OPB_OPB2FSI                    TO_REG(0x0c)
>>> +#define   APB2OPB_OPB2FSI_OFF              GENMASK(31, 22)
>>> +
>>> +#define APB2OPB_OPB0_SEL                   TO_REG(0x10)
>>> +#define APB2OPB_OPB1_SEL                   TO_REG(0x28)
>>> +#define   APB2OPB_OPB_SEL_EN               BIT(0)
>>> +
>>> +#define APB2OPB_OPB0_MODE                  TO_REG(0x14)
>>> +#define APB2OPB_OPB1_MODE                  TO_REG(0x2c)
>>> +#define   APB2OPB_OPB_MODE_RD              BIT(0)
>>> +
>>> +#define APB2OPB_OPB0_XFER                  TO_REG(0x18)
>>> +#define APB2OPB_OPB1_XFER                  TO_REG(0x30)
>>> +#define   APB2OPB_OPB_XFER_FULL            BIT(1)
>>> +#define   APB2OPB_OPB_XFER_HALF            BIT(0)
>>> +
>>> +#define APB2OPB_OPB0_ADDR                  TO_REG(0x1c)
>>> +#define APB2OPB_OPB0_WRITE_DATA            TO_REG(0x20)
>>> +
>>> +#define APB2OPB_OPB1_ADDR                  TO_REG(0x34)
>>> +#define APB2OPB_OPB1_WRITE_DATA                  TO_REG(0x38)
>>> +
>>> +#define APB2OPB_IRQ_STS                    TO_REG(0x48)
>>> +#define   APB2OPB_IRQ_STS_OPB1_TX_ACK      BIT(17)
>>> +#define   APB2OPB_IRQ_STS_OPB0_TX_ACK      BIT(16)
>>> +
>>> +#define APB2OPB_OPB0_WRITE_WORD_ENDIAN     TO_REG(0x4c)
>>> +#define   APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE 0x0011101b
>>> +#define APB2OPB_OPB0_WRITE_BYTE_ENDIAN     TO_REG(0x50)
>>> +#define   APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE 0x0c330f3f
>>> +#define APB2OPB_OPB1_WRITE_WORD_ENDIAN     TO_REG(0x54)
>>> +#define APB2OPB_OPB1_WRITE_BYTE_ENDIAN     TO_REG(0x58)
>>> +#define APB2OPB_OPB0_READ_BYTE_ENDIAN      TO_REG(0x5c)
>>> +#define APB2OPB_OPB1_READ_BYTE_ENDIAN      TO_REG(0x60)
>>> +#define   APB2OPB_OPB0_READ_WORD_ENDIAN_BE  0x00030b1b
>>> +
>>> +#define APB2OPB_OPB0_READ_DATA         TO_REG(0x84)
>>> +#define APB2OPB_OPB1_READ_DATA         TO_REG(0x90)
>>> +
>>> +/*
>>> + * The following magic values came from AST2600 data sheet
>>> + * The register values are defined under section "FSI controller"
>>> + * as initial values.
>>> + */
>>> +static const uint32_t aspeed_apb2opb_reset[ASPEED_APB2OPB_NR_REGS] = {
>>> +     [APB2OPB_VERSION]                = 0x000000a1,
>>> +     [APB2OPB_OPB0_WRITE_WORD_ENDIAN] = 0x0044eee4,
>>> +     [APB2OPB_OPB0_WRITE_BYTE_ENDIAN] = 0x0055aaff,
>>> +     [APB2OPB_OPB1_WRITE_WORD_ENDIAN] = 0x00117717,
>>> +     [APB2OPB_OPB1_WRITE_BYTE_ENDIAN] = 0xffaa5500,
>>> +     [APB2OPB_OPB0_READ_BYTE_ENDIAN]  = 0x0044eee4,
>>> +     [APB2OPB_OPB1_READ_BYTE_ENDIAN]  = 0x00117717
>>> +};
>>> +
>>> +static uint64_t fsi_aspeed_apb2opb_read(void *opaque, hwaddr addr,
>>> +                                        unsigned size)
>>> +{
>>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
>>> +
>>> +    trace_fsi_aspeed_apb2opb_read(addr, size);
>>> +
>>> +    if (addr + size > sizeof(s->regs)) {
>>
>>
>> hmm, the parameter 'size' is a memop transaction size not an address offset.
> OK, Changed it to validate the register (index) instead of addr + size.
>>
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: Out of bounds read: 0x%"HWADDR_PRIx" for %u\n",
>>> +                      __func__, addr, size);
>>> +        return 0;
>>> +    }
>>> +
>>> +    return s->regs[TO_REG(addr)];
>>> +}
>>> +
>>> +static void fsi_aspeed_apb2opb_write(void *opaque, hwaddr addr, uint64_t data,
>>> +                                     unsigned size)
>>> +{
>>> +    AspeedAPB2OPBState *s = ASPEED_APB2OPB(opaque);
>>> +
>>> +    trace_fsi_aspeed_apb2opb_write(addr, size, data);
>>> +
>>> +    if (addr + size > sizeof(s->regs)) {
>>
>> same comment.
> Fixed it same as above.
>>
>>
>>> +        qemu_log_mask(LOG_GUEST_ERROR,
>>> +                      "%s: Out of bounds write: %"HWADDR_PRIx" for %u\n",
>>> +                      __func__, addr, size);
>>> +        return;
>>> +    }
>>> +
>>> +    switch (TO_REG(addr)) {
>>> +    case APB2OPB_CONTROL:
>>> +        fsi_opb_fsi_master_address(&s->opb[0], data & APB2OPB_CONTROL_OFF);
>>
>> fsi_opb_fsi_master_address() should statically defined in this file
> We have separation of OPB bus implementation and APB2OPB interface. If we move this function here then we will be exposing OPB implementation here.
>>
>>> +        break;
>>> +    case APB2OPB_OPB2FSI:
>>> +        fsi_opb_opb2fsi_address(&s->opb[0], data & APB2OPB_OPB2FSI_OFF);
>>
>>
>> same for fsi_opb_opb2fsi_address()
> Same as above.
>>
>>> +        break;
>>> +    case APB2OPB_OPB0_WRITE_WORD_ENDIAN:
>>> +        if (data != APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>>> +                          __func__, APB2OPB_OPB0_WRITE_WORD_ENDIAN_BE);
>>> +        }
>>> +        break;
>>> +    case APB2OPB_OPB0_WRITE_BYTE_ENDIAN:
>>> +        if (data != APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>>> +                          __func__, APB2OPB_OPB0_WRITE_BYTE_ENDIAN_BE);
>>> +        }
>>> +        break;
>>> +    case APB2OPB_OPB0_READ_BYTE_ENDIAN:
>>> +        if (data != APB2OPB_OPB0_READ_WORD_ENDIAN_BE) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: Bridge needs to be driven as BE (0x%x)\n",
>>> +                          __func__, APB2OPB_OPB0_READ_WORD_ENDIAN_BE);
>>> +        }
>>> +        break;
>>> +    case APB2OPB_TRIGGER:
>>> +    {
>>> +        uint32_t opb, op_mode, op_size, op_addr, op_data;
>>> +
>>> +        assert((s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) ^
>>> +               (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN));
>>> +
>>> +        if (s->regs[APB2OPB_OPB0_SEL] & APB2OPB_OPB_SEL_EN) {
>>> +            opb = 0;
>>> +            op_mode = s->regs[APB2OPB_OPB0_MODE];
>>> +            op_size = s->regs[APB2OPB_OPB0_XFER];
>>> +            op_addr = s->regs[APB2OPB_OPB0_ADDR];
>>> +            op_data = s->regs[APB2OPB_OPB0_WRITE_DATA];
>>> +        } else if (s->regs[APB2OPB_OPB1_SEL] & APB2OPB_OPB_SEL_EN) {
>>> +            opb = 1;
>>> +            op_mode = s->regs[APB2OPB_OPB1_MODE];
>>> +            op_size = s->regs[APB2OPB_OPB1_XFER];
>>> +            op_addr = s->regs[APB2OPB_OPB1_ADDR];
>>> +            op_data = s->regs[APB2OPB_OPB1_WRITE_DATA];
>>> +        } else {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "%s: Invalid operation: 0x%"HWADDR_PRIx" for %u\n",
>>> +                          __func__, addr, size);
>>> +            return;
>>> +        }
>>> +
>>> +        if (op_size & ~(APB2OPB_OPB_XFER_HALF | APB2OPB_OPB_XFER_FULL)) {
>>> +            qemu_log_mask(LOG_GUEST_ERROR,
>>> +                          "OPB transaction failed: Unrecognised access width: %d\n",
>>
>> Unrecognized
> Fixed
>>
>>> +                          op_size);
>>> +            return;
>>> +        }
>>> +
>>> +        op_size += 1;
>>> +
>>> +        if (op_mode & APB2OPB_OPB_MODE_RD) {
>>> +            int index = opb ? APB2OPB_OPB1_READ_DATA
>>> +                : APB2OPB_OPB0_READ_DATA;
>>> +
>>> +            switch (op_size) {
>>> +            case 1:
>>> +                s->regs[index] = fsi_opb_read8(&s->opb[opb], op_addr);
>>> +                break;
>>> +            case 2:
>>> +                s->regs[index] = fsi_opb_read16(&s->opb[opb], op_addr);
>>> +                break;
>>> +            case 4:
>>> +                s->regs[index] = fsi_opb_read32(&s->opb[opb], op_addr);
>>> +                break;
>>> +            default:
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "%s: Size not supported: %u\n",
>>> +                              __func__, size);
>>
>> this should use op_size and not size and seems redudant with
>> the unrecognized test above.
> true, Keeping it in case bits meaning change in future.
>>
>>
>>> +                return;
>>> +            }
>>> +        } else {
>>> +            /* FIXME: Endian swizzling */
>>> +            switch (op_size) {
>>> +            case 1:
>>> +                fsi_opb_write8(&s->opb[opb], op_addr, op_data);
>>> +                break;
>>> +            case 2:
>>> +                fsi_opb_write16(&s->opb[opb], op_addr, op_data);
>>> +                break;
>>> +            case 4:
>>> +                fsi_opb_write32(&s->opb[opb], op_addr, op_data);
>>> +                break;
>>> +            default:
>>> +                qemu_log_mask(LOG_GUEST_ERROR,
>>> +                              "%s: Size not supported: %u\n",
>>> +                              __func__, op_size);
>>> +                return;
>>> +            }
>>> +        }
>>
>>
>> The above is equivalent to :
>>
>>         MemTxResult result;
>>         bool is_write = !(op_mode & APB2OPB_OPB_MODE_RD);
>>         int index = opb ? APB2OPB_OPB1_READ_DATA : APB2OPB_OPB0_READ_DATA;
>>         AddressSpace *as = &s->opb[opb].as;
>>
>>         result = address_space_rw(as, op_addr, MEMTXATTRS_UNSPECIFIED,
>>                                   &op_data, op_size, is_write);
>>         if (result != MEMTX_OK) {
>>             qemu_log_mask(LOG_GUEST_ERROR, "%s: OPB %s failed @%08x\n",
>>                           __func__, is_write ? "write" : "read", op_addr);
>>             return;
>>         }
>>
>>         if (!is_write) {
>>             s->regs[index] = op_data;
>>         }
>>
>> and the fsi_opb_* routines are useless to me.
> We are trying to keep the separation between OPB implementation and interface hence we have all those fsi_opb_*. I feel that we should keep as it is so that future extensions will be easier. Please let me know.

Well, I can't really tell because I don't know enough about FSI :/

The models look fragile and I have spent already a lot of time trying
to untangle what they are trying to do. Please ask your teammates or
let's see in the next QEMU cycle.

Thanks,

C.



