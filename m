Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CED717729
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Fem-0003gw-8Q; Wed, 31 May 2023 02:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4Fdt-0003Xz-Bo; Wed, 31 May 2023 02:49:09 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vahk=BU=kaod.org=clg@ozlabs.org>)
 id 1q4Fdq-0005pD-Ma; Wed, 31 May 2023 02:49:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWKcD0GBxz4x48;
 Wed, 31 May 2023 16:49:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWKc84LvVz4whk;
 Wed, 31 May 2023 16:48:56 +1000 (AEST)
Message-ID: <516d4f95-a070-a03c-317c-2276cd42e871@kaod.org>
Date: Wed, 31 May 2023 08:48:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 09/12] m25p80: Introduce an helper to retrieve the
 BlockBackend of a device
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-10-clg@kaod.org>
 <5587a39e-1c17-2997-f679-d43a023149c6@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <5587a39e-1c17-2997-f679-d43a023149c6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=vahk=BU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 5/30/23 23:14, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> It will help in getting rid of some drive_get(IF_MTD) calls by
>> retrieving the BlockBackend directly from the m25p80 device.
>>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/block/flash.h | 4 ++++
>>   hw/block/m25p80.c        | 6 ++++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
>> index 7198953702..de93756cbe 100644
>> --- a/include/hw/block/flash.h
>> +++ b/include/hw/block/flash.h
>> @@ -76,4 +76,8 @@ uint8_t ecc_digest(ECCState *s, uint8_t sample);
>>   void ecc_reset(ECCState *s);
>>   extern const VMStateDescription vmstate_ecc_state;
>> +/* m25p80.c */
>> +
>> +BlockBackend *m25p80_get_blk(DeviceState *dev);
> 
> - Option 1, declare QOM typedef and use proper type:
> 
>    #define TYPE_M25P80 "m25p80-generic"
>    OBJECT_DECLARE_TYPE(Flash, M25P80Class, M25P80)
> 
>    BlockBackend *m25p80_get_blk(Flash *dev);
> 
> - Option 2, preliminary patch renaming 'Flash' type to
> 'M25P80' then option 1 again

That's a large change and we would need to introduce a m25p80.h with
these definitions. Given that the caller needs a DeviceState in the
end, may be not worth the extra hassle.

How would you rename 'Flash' ? 'SpiFlash' ?

Thanks,

C.

> 
> - Option 3: no change.
> 
> With the QOM style we try to enforce, I'd go for #2.
> 
> Still,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>>   #endif
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index dc5ffbc4ff..afc3fdf4d6 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/units.h"
>>   #include "sysemu/block-backend.h"
>>   #include "hw/block/block.h"
>> +#include "hw/block/flash.h"
>>   #include "hw/qdev-properties.h"
>>   #include "hw/qdev-properties-system.h"
>>   #include "hw/ssi/ssi.h"
>> @@ -1830,3 +1831,8 @@ static void m25p80_register_types(void)
>>   }
>>   type_init(m25p80_register_types)
>> +
>> +BlockBackend *m25p80_get_blk(DeviceState *dev)
>> +{
>> +    return M25P80(dev)->blk;
>> +}
> 


