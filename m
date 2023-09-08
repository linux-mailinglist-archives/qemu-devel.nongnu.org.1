Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC137982B9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:50:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVK9-0007TK-UN; Fri, 08 Sep 2023 02:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVK1-0007BZ-SZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:50:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVJp-0003tA-0W
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KSRfl0+p35AEpcSu92c7S1maSBgEmSPdpQ3uXqSuGvA=; b=yyyo6odMiTGYF47EY9KMMPm6hK
 AVxU2h0bgCPb1lcH6d+SlM9Io16slhaYr+HuXs71mscxwNZLL+q3XtS4KSd84RUkdAvZqzM2Q07xi
 EBuZXZAP02m7GfW9/Rhrnf1wabRPWMApVF1sg9LYhJQi+Up+T8QoV1qFhnypXXX5mt69JIbAkXTn3
 R+g8gNKg1rzCHmwgk8+n6jtdA3dtgzFpTn0td1mAn+zujnYfFPErvfiEzCemOrFFiOWnp+rEF9Mhk
 utnboiu4qeQQ37Q39hbuZ9BwaGLKjJ8+6L10uucFEUQiN5Ywcav8/3svkz+a6OOa30Gi/qk0NamAt
 74vcQQ5kmMsRXQCcvQIQOCj+DzWnKWjq50vqtOMY7ie3A4Jy69SlA5nltWt6+5YdAumr7Q5s+Ozws
 8TKsrbV3rRBht5N1cO25Q6YTf1JG5foYsrPp48hCxSQNzDHIuPd3zeQtP8Gjcn+dW2EGI+q7diUOW
 dkqHGhbVGEiT9alURIDZsiwVAmEMlWsS8bRFM24YyeJCEY3DihOC1tAufP3atwLGz6IuQlKMsbSVg
 /HGbaBilE0o8RGXiN/OR0UAUMsIW0Eg0DAnTqQmuFCOdf2UYkpt00GVv+s0+eJ8RU3iV3Byfj9Xi8
 tb9HRCHK7a5OXzWE7NEHBtD/56vLqCHHdrve54LZg=;
Received: from [2a00:23c4:8baf:5f00:cfe1:e4f1:db23:3678]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qeVJd-00072j-OI; Fri, 08 Sep 2023 07:50:09 +0100
Message-ID: <82f59553-4b2f-549b-5b06-48b5a548e11b@ilande.co.uk>
Date: Fri, 8 Sep 2023 07:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-6-mark.cave-ayland@ilande.co.uk>
 <5eebfd86-e888-5c7b-803c-d4c5f9c7b080@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <5eebfd86-e888-5c7b-803c-d4c5f9c7b080@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:cfe1:e4f1:db23:3678
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 05/21] q800: add IOSB subsystem
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07/07/2023 09:25, Philippe Mathieu-Daudé wrote:

> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>> It is needed because it defines the BIOSConfig area.
>>
>> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   MAINTAINERS            |   2 +
>>   hw/m68k/Kconfig        |   1 +
>>   hw/m68k/q800.c         |   9 +++
>>   hw/misc/Kconfig        |   3 +
>>   hw/misc/iosb.c         | 137 +++++++++++++++++++++++++++++++++++++++++
>>   hw/misc/meson.build    |   1 +
>>   hw/misc/trace-events   |   4 ++
>>   include/hw/m68k/q800.h |   2 +
>>   include/hw/misc/iosb.h |  25 ++++++++
>>   9 files changed, 184 insertions(+)
>>   create mode 100644 hw/misc/iosb.c
>>   create mode 100644 include/hw/misc/iosb.h
> 
> 
>> diff --git a/hw/misc/iosb.c b/hw/misc/iosb.c
>> new file mode 100644
>> index 0000000000..4fc10bcf9f
>> --- /dev/null
>> +++ b/hw/misc/iosb.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * QEMU IOSB emulation
>> + *
>> + * Copyright (c) 2019 Laurent Vivier
>> + * Copyright (c) 2022 Mark Cave-Ayland
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "migration/vmstate.h"
>> +#include "hw/sysbus.h"
>> +#include "hw/misc/iosb.h"
>> +#include "trace.h"
>> +
>> +#define IOSB_SIZE          0x2000
>> +
>> +#define IOSB_CONFIG        0x0
>> +#define IOSB_CONFIG2       0x100
>> +#define IOSB_SONIC_SCSI    0x200
>> +#define IOSB_REVISION      0x300
>> +#define IOSB_SCSI_RESID    0x400
>> +#define IOSB_BRIGHTNESS    0x500
>> +#define IOSB_TIMEOUT       0x600
>> +
>> +
>> +static uint64_t iosb_read(void *opaque, hwaddr addr,
>> +                          unsigned size)
>> +{
>> +    IOSBState *s = IOSB(opaque);
>> +    uint64_t val = 0;
>> +
>> +    switch (addr) {
>> +    case IOSB_CONFIG:
>> +    case IOSB_CONFIG2:
>> +    case IOSB_SONIC_SCSI:
>> +    case IOSB_REVISION:
>> +    case IOSB_SCSI_RESID:
>> +    case IOSB_BRIGHTNESS:
>> +    case IOSB_TIMEOUT:
>> +        val = s->regs[addr >> 8];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented read addr=0x%"PRIx64
>> +                                 " val=0x%"PRIx64 " size=%d\n",
>> +                                 addr, val, size);
>> +    }
>> +
>> +    trace_iosb_read(addr, val, size);
>> +    return val;
>> +}
>> +
>> +static void iosb_write(void *opaque, hwaddr addr, uint64_t val,
>> +                       unsigned size)
>> +{
>> +    IOSBState *s = IOSB(opaque);
>> +
>> +    switch (addr) {
>> +    case IOSB_CONFIG:
>> +    case IOSB_CONFIG2:
>> +    case IOSB_SONIC_SCSI:
>> +    case IOSB_REVISION:
>> +    case IOSB_SCSI_RESID:
>> +    case IOSB_BRIGHTNESS:
>> +    case IOSB_TIMEOUT:
>> +        s->regs[addr >> 8] = val;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "IOSB: unimplemented write addr=0x%"PRIx64
>> +                                 " val=0x%"PRIx64 " size=%d\n",
>> +                                 addr, val, size);
>> +    }
>> +
>> +    trace_iosb_write(addr, val, size);
>> +}
>> +
>> +static const MemoryRegionOps iosb_mmio_ops = {
>> +    .read = iosb_read,
>> +    .write = iosb_write,
>> +    .endianness = DEVICE_BIG_ENDIAN,
>> +    .impl = {
>> +        .min_access_size = 1,
> 
> IIUC .impl.min_access_size = 4.
> 
> Do you mean .valid.min_access_size = 1?

Hmmm I can't remember the exact origin of this, but indeed looking at the stride this 
doesn't make much sense. I've done some tests with .impl removed completely and 
haven't seen any issues, so I'll drop this from v2.

> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +        .max_access_size = 4,
>> +    },
>> +};


ATB,

Mark.


