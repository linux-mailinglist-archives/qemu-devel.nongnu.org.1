Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3259D7176C4
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4FCq-00022w-TG; Wed, 31 May 2023 02:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4FCn-00022K-L0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:21:09 -0400
Received: from 7.mo552.mail-out.ovh.net ([188.165.59.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4FCl-0000WQ-8W
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:21:09 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.235])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 598362A583;
 Wed, 31 May 2023 06:21:03 +0000 (UTC)
Received: from kaod.org (37.59.142.97) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 08:21:02 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002a2eb4104-7210-41cd-99cd-c70ef00cc8bf,
 AD4A5C7A17A66D4AFB6DE796C11E1CF112258E66) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <77971657-2e7f-31f1-951c-acfebad6035b@kaod.org>
Date: Wed, 31 May 2023 08:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 07/12] hw/ssi: Check for duplicate addresses
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis
 <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-8-clg@kaod.org>
 <f8a075cd-0100-f3d0-dc26-bf733917fbee@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <f8a075cd-0100-f3d0-dc26-bf733917fbee@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.97]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: f42affb7-c9bc-4bc1-b19f-b214c07a254f
X-Ovh-Tracer-Id: 16667540748447746924
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekkedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdeljedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhjohgvlhesjhhmshdrihgurdgruhdprghnughrvgifsegrjhdrihgurdgruhdpvggughgrrhdrihhglhgvshhirghssehgmhgrihhlrdgtohhmpdgrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpoffvte
 fjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.59.253; envelope-from=clg@kaod.org;
 helo=7.mo552.mail-out.ovh.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/30/23 23:05, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> This to avoid address conflicts on the same SSI bus. Adapt machines
>> using multiple devices on the same bus to avoid breakage.
>>
>> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/arm/stellaris.c                  |  4 +++-
>>   hw/arm/xilinx_zynq.c                |  1 +
>>   hw/arm/xlnx-versal-virt.c           |  1 +
>>   hw/arm/xlnx-zcu102.c                |  2 ++
>>   hw/microblaze/petalogix_ml605_mmu.c |  1 +
>>   hw/ssi/ssi.c                        | 20 ++++++++++++++++++++
>>   6 files changed, 28 insertions(+), 1 deletion(-)
> 
> 
>> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
>> index a25e064417..685b7678e0 100644
>> --- a/hw/ssi/ssi.c
>> +++ b/hw/ssi/ssi.c
>> @@ -42,10 +42,30 @@ DeviceState *ssi_get_cs(SSIBus *bus, int addr)
>>       return NULL;
>>   }
>> +static bool ssi_bus_check_address(BusState *b, DeviceState *dev, Error **errp)
>> +{
>> +    SSIPeripheral *s = SSI_PERIPHERAL(dev);
>> +
>> +    if (ssi_get_cs(SSI_BUS(b), s->addr)) {
>> +        error_setg(errp, "addr '0x%x' already in use", s->addr);
> 
> We could return "... in use by a $MODEL device".
> 
>    DeviceState *d = ssi_get_cs(SSI_BUS(b), s->addr);
>    if (d) {
>        "... in use by a %s device", ..., object_get_typename(OBJECT(d)));
>    }

Yes. I will change the error message.

Thanks,

C.


> Anyhow,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
> 


