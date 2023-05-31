Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E827176B5
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:17:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4F7n-0007P3-Sr; Wed, 31 May 2023 02:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4F6x-0006rI-PW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:15:07 -0400
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4F6u-0007W5-Eg
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:15:07 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.13])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id D3E4C2134A;
 Wed, 31 May 2023 06:15:00 +0000 (UTC)
Received: from kaod.org (37.59.142.96) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 08:15:00 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0011664d7e2-9b82-4938-94eb-eec7aa015665,
 AD4A5C7A17A66D4AFB6DE796C11E1CF112258E66) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ad2ef68a-f308-db96-a668-58bfd457788c@kaod.org>
Date: Wed, 31 May 2023 08:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 06/12] aspeed/smc: Wire CS lines at reset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-7-clg@kaod.org>
 <ad016c90-238c-2654-d550-9823bcb2a395@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ad016c90-238c-2654-d550-9823bcb2a395@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 01a55954-916b-46c3-91b1-fb65610c91bb
X-Ovh-Tracer-Id: 16565365330939906854
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekkedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdeliedpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepphhhihhlmhgusehlihhnrghrohdrohhrghdpqhgvmhhuqdgrrhhmsehnohhnghhnuhdrohhrghdpqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdpphgvthgvrhdrmhgrhiguvghllheslhhinhgrrhhordhorhhgpdhjohgvlhesjhhmshdrihgurdgruhdprghnughrvgifsegrjhdrihgurdgruhdpoffvtefjohhsthepmhhoheegkedpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
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

On 5/30/23 22:56, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> Currently, a set of default flash devices is created at machine init
>> and drives defined on the QEMU command line are associated to the FMC
>> and SPI controllers in sequence :
>>
>>     -drive file<file>,format=raw,if=mtd
>>     -drive file<file1>,format=raw,if=mtd
>>
>> The CS lines are wired in the same creation loop. This makes a strong
>> assumption on the ordering and is not very flexible since only a
>> limited set of flash devices can be defined : 1 FMC + 1 or 2 SPI,
>> which is less than what the SoC really supports.
>>
>> A better alternative would be to define the flash devices on the
>> command line using a blockdev attached to a CS line of a SSI bus :
>>
>>      -blockdev node-name=fmc0,driver=file,filename=./flash.img
>>      -device mx66u51235f,addr=0x0,bus=ssi.0,drive=fmc0
>>
>> However, user created flash devices are not correctly wired to their
>> SPI controller and consequently can not be used by the machine. Fix
>> that and wire the CS lines of all available devices when the SSI bus
>> is reset.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/arm/aspeed.c     | 5 +----
>>   hw/ssi/aspeed_smc.c | 8 ++++++++
>>   2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index b654513f35..9a15899cbc 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -299,17 +299,14 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>>       for (i = 0; i < count; ++i) {
>>           DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
>> -        qemu_irq cs_line;
>>           DeviceState *dev;
>>           dev = qdev_new(flashtype);
>>           if (dinfo) {
>>               qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
>>           }
>> +        qdev_prop_set_uint32(dev, "addr", i);
>>           qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
>> -
>> -        cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
>> -        qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
>>       }
>>   }
>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>> index 7281169322..2a4001b774 100644
>> --- a/hw/ssi/aspeed_smc.c
>> +++ b/hw/ssi/aspeed_smc.c
>> @@ -692,6 +692,14 @@ static void aspeed_smc_reset(DeviceState *d)
>>           memset(s->regs, 0, sizeof s->regs);
>>       }
>> +    for (i = 0; i < asc->cs_num_max; i++) {
>> +        DeviceState *dev = ssi_get_cs(s->spi, i);
>> +        if (dev) {
>> +            qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
>> +            qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
>> +        }
>> +    }
> 
> Why did you chose the DeviceReset handler?
> Shouldn't this be done in aspeed_smc_realize(), the DeviceRealize handler?

This looks weird, I agree, but the wiring needs to be done at reset time
to wire the user-created devices. I don't think there is another way.

Thanks,

C.
  
  
> 
>>       /* Unselect all peripherals */
>>       for (i = 0; i < asc->cs_num_max; ++i) {
>>           s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;
> 


