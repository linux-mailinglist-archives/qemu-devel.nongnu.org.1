Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF21984339
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Sep 2024 12:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st2Xd-00064c-Fk; Tue, 24 Sep 2024 06:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1st2Xa-00062W-O3; Tue, 24 Sep 2024 06:13:06 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1st2XY-0003vJ-5S; Tue, 24 Sep 2024 06:13:06 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5C2444E6036;
 Tue, 24 Sep 2024 12:12:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id g8Gi0Fh500gn; Tue, 24 Sep 2024 12:12:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6729F4E601B; Tue, 24 Sep 2024 12:12:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 65342746F60;
 Tue, 24 Sep 2024 12:12:56 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:12:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Corey Minyard <cminyard@mvista.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: Re: [PATCH 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
In-Reply-To: <FEA742CA-ED2A-4D17-B9E7-A670A400D7FA@gmail.com>
Message-ID: <4fd6a062-b543-337a-4ade-6c8e04eb4737@eik.bme.hu>
References: <20240923093016.66437-1-shentey@gmail.com>
 <20240923093016.66437-12-shentey@gmail.com>
 <424c5118-c638-4e83-9796-8858b7fba78b@eik.bme.hu>
 <FEA742CA-ED2A-4D17-B9E7-A670A400D7FA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 23 Sep 2024, Bernhard Beschow wrote:
> Am 23. September 2024 10:49:53 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Mon, 23 Sep 2024, Bernhard Beschow wrote:
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> ---
>>> hw/i2c/mpc_i2c.c | 20 ++++++++------------
>>> 1 file changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
>>> index 3d79c15653..16f4309ea9 100644
>>> --- a/hw/i2c/mpc_i2c.c
>>> +++ b/hw/i2c/mpc_i2c.c
>>> @@ -20,7 +20,6 @@
>>> #include "qemu/osdep.h"
>>> #include "hw/i2c/i2c.h"
>>> #include "hw/irq.h"
>>> -#include "qemu/module.h"
>>> #include "hw/sysbus.h"
>>> #include "migration/vmstate.h"
>>> #include "qom/object.h"
>>> @@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
>>>     dc->desc = "MPC I2C Controller";
>>> }
>>>
>>> -static const TypeInfo mpc_i2c_type_info = {
>>> -    .name          = TYPE_MPC_I2C,
>>> -    .parent        = TYPE_SYS_BUS_DEVICE,
>>> -    .instance_size = sizeof(MPCI2CState),
>>> -    .class_init    = mpc_i2c_class_init,
>>> +static const TypeInfo types[] = {
>>> +    {
>>> +        .name          = TYPE_MPC_I2C,
>>> +        .parent        = TYPE_SYS_BUS_DEVICE,
>>> +        .instance_size = sizeof(MPCI2CState),
>>> +        .class_init    = mpc_i2c_class_init,
>>> +    },
>>> };
>>>
>>> -static void mpc_i2c_register_types(void)
>>> -{
>>> -    type_register_static(&mpc_i2c_type_info);
>>> -}
>>> -
>>> -type_init(mpc_i2c_register_types)
>>> +DEFINE_TYPES(types)
>>
>> What's the advantage of this when we have a single device? For these devices this looks like just code churn to me.
>
> It is still shorter and also more modern style. As a nice side effect it also helps in my experimental branch (which may never ship).

I don't mind changing this but I see no real advantage either. It removes 
a one line function but adds a one element array instead which is about 
the same level of boilerplate and not less confusing for new people so it 
does not seem to help much.

Regards,
BALATON Zoltan

