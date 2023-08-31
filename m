Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DC178EE79
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:23:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhda-0001Fq-DR; Thu, 31 Aug 2023 09:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbhdN-000198-FI; Thu, 31 Aug 2023 09:22:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org>)
 id 1qbhdJ-0006QB-SM; Thu, 31 Aug 2023 09:22:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rc2045srmz4wy9;
 Thu, 31 Aug 2023 23:22:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rc2026xrpz4wb5;
 Thu, 31 Aug 2023 23:22:42 +1000 (AEST)
Message-ID: <a35c9605-7bea-0252-359e-86855e8ee304@kaod.org>
Date: Thu, 31 Aug 2023 15:22:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/7] aspeed: Create flash devices only when defaults
 are enabled
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230831123922.105200-1-clg@kaod.org>
 <20230831123922.105200-6-clg@kaod.org>
 <CACPK8XdiTpONmuLag5HnTCPXtoz+Zg-Yo+rrzt+Wuz17hbdDRg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CACPK8XdiTpONmuLag5HnTCPXtoz+Zg-Yo+rrzt+Wuz17hbdDRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=TXcQ=EQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 8/31/23 15:00, Joel Stanley wrote:
> On Thu, 31 Aug 2023 at 12:39, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> When the -nodefaults option is set, flash devices should be created
>> with :
>>
>>      -blockdev node-name=fmc0,driver=file,filename=./flash.img \
>>      -device mx66u51235f,cs=0x0,bus=ssi.0,drive=fmc0 \
>>
>> To be noted that in this case, the ROM will not be installed and the
>> initial boot sequence (U-Boot loading) will fetch instructions using
>> SPI transactions which is significantly slower. That's exactly how HW
>> operates though.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> 
> I think this is the first foray for the aspeed machines into
> nodefaults removing things that previously would have just worked.

This is true. It is change from the previous behavior.

QEMU should probably complain if no fmc0 are found to boot from.
Would that be ok ? And yes, documentation needs some update.

Thanks,

C.

> I
> know we haven't had it in our recommended command lines for a long
> time, so that's fine.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Should the content of your commit message go in the docs?
> 
>> ---
>>   hw/arm/aspeed.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index cd92cf9ce0bb..271512ce5ced 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -396,12 +396,14 @@ static void aspeed_machine_init(MachineState *machine)
>>       connect_serial_hds_to_uarts(bmc);
>>       qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
>>
>> -    aspeed_board_init_flashes(&bmc->soc.fmc,
>> +    if (defaults_enabled()) {
>> +        aspeed_board_init_flashes(&bmc->soc.fmc,
>>                                 bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
>>                                 amc->num_cs, 0);
>> -    aspeed_board_init_flashes(&bmc->soc.spi[0],
>> +        aspeed_board_init_flashes(&bmc->soc.spi[0],
>>                                 bmc->spi_model ? bmc->spi_model : amc->spi_model,
>>                                 1, amc->num_cs);
>> +    }
>>
>>       if (machine->kernel_filename && sc->num_cpus > 1) {
>>           /* With no u-boot we must set up a boot stub for the secondary CPU */
>> --
>> 2.41.0
>>


