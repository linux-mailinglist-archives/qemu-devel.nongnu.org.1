Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62DF7176D2
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 08:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4FKK-0003Yx-Tm; Wed, 31 May 2023 02:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4FK5-0003YN-F0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:28:41 -0400
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1q4FK3-0001w6-7B
 for qemu-devel@nongnu.org; Wed, 31 May 2023 02:28:41 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.233])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 60D1E263DF;
 Wed, 31 May 2023 06:28:35 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 31 May
 2023 08:28:34 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00437b43e1d-77cd-428a-b431-32d72408f43f,
 AD4A5C7A17A66D4AFB6DE796C11E1CF112258E66) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <aeb9f6a3-30e4-ce5d-c041-600a5097b27e@kaod.org>
Date: Wed, 31 May 2023 08:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 11/12] aspeed: Introduce a "uart" machine option
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>, Abhishek Singh
 Dagur <abhishek@drut.io>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-12-clg@kaod.org>
 <d0dedd1a-e2b7-5db9-d710-595e94b084a0@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d0dedd1a-e2b7-5db9-d710-595e94b084a0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 2cdb972e-613b-4805-b959-bcc10539c6e4
X-Ovh-Tracer-Id: 16794767436449549161
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekkedguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutddupdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeotghlgheskhgrohgurdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehphhhilhhmugeslhhinhgrrhhordhorhhgpdhqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgpdhpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdpjhhovghlsehjmhhsrdhiugdrrghupdgrnhgurhgvfiesrghjrdhiugdrrghupdgrsghhihhshhgvkhesughruhhtrdhiohdpoffvtefjohhsthepmhhoheehvddpmhhouggvpehsmhhtphhouhht
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
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

On 5/30/23 23:22, Philippe Mathieu-Daudé wrote:
> On 8/5/23 09:58, Cédric Le Goater wrote:
>> Most of the Aspeed machines use the UART5 device for the boot console,
>> and QEMU connects the first serial Chardev to this SoC device for this
>> purpose. See routine connect_serial_hds_to_uarts().
>>
>> Nevertheless, some machines use another boot console, such as the fuji,
>> and commit 5d63d0c76c ("hw/arm/aspeed: Allow machine to set UART
>> default") introduced a SoC class attribute 'uart_default' and property
>> to be able to change the boot console device. It was later changed by
>> commit d2b3eaefb4 ("aspeed: Refactor UART init for multi-SoC machines").
>>
>> The "uart" machine option goes a step further and lets the user define
>> the UART device from the QEMU command line without introducing a new
>> machine definition. For instance, to use device UART3 (mapped on
>> /dev/ttyS2 under Linux) instead of the default UART5, one would use :
>>
>>    -M ast2500-evb,uart=uart3
>>
>> Cc: Abhishek Singh Dagur <abhishek@drut.io>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   docs/system/arm/aspeed.rst | 10 ++++++++++
>>   hw/arm/aspeed.c            | 39 ++++++++++++++++++++++++++++++++++++--
>>   2 files changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
>> index d4e293e7f9..e70f0aeea3 100644
>> --- a/docs/system/arm/aspeed.rst
>> +++ b/docs/system/arm/aspeed.rst
>> @@ -122,6 +122,10 @@ Options specific to Aspeed machines are :
>>    * ``spi-model`` to change the SPI Flash model.
>> + * ``uart`` to change the default console device. Most of the machines
>> +   use the ``UART5`` device for a boot console, which is mapped on
>> +   ``/dev/ttyS4`` under Linux, but it is not always the case.
> 
> This comment ...
> 
>>   For instance, to start the ``ast2500-evb`` machine with a different
>>   FMC chip and a bigger (64M) SPI chip, use :
>> @@ -129,6 +133,12 @@ FMC chip and a bigger (64M) SPI chip, use :
>>     -M ast2500-evb,fmc-model=mx25l25635e,spi-model=mx66u51235f
>> +To change the boot console and use device ``UART3`` (``/dev/ttyS2``
>> +under Linux), use :
> 
> ... and this one suggest 'boot-console' could be a better name.
> 
> Or 'boot-console-index'.

you might be right. people expect to find the console messages on
this device. I will think about it.

> 
>> +.. code-block:: bash
>> +
>> +  -M ast2500-evb,uart=uart3
>>   Aspeed minibmc family boards (``ast1030-evb``)
>>   ==================================================================
>> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
>> index 3d5488faf7..6c32f674b9 100644
>> --- a/hw/arm/aspeed.c
>> +++ b/hw/arm/aspeed.c
>> @@ -43,6 +43,7 @@ struct AspeedMachineState {
>>       AspeedSoCState soc;
>>       MemoryRegion boot_rom;
>>       bool mmio_exec;
>> +    uint32_t uart_chosen;
>>       char *fmc_model;
>>       char *spi_model;
>>   };
>> @@ -331,10 +332,11 @@ static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
>>       AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>>       AspeedSoCState *s = &bmc->soc;
>>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
>> +    int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>> -    aspeed_soc_uart_set_chr(s, amc->uart_default, serial_hd(0));
>> +    aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
>>       for (int i = 1, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
>> -        if (uart == amc->uart_default) {
>> +        if (uart == uart_chosen) {
>>               continue;
>>           }
>>           aspeed_soc_uart_set_chr(s, uart, serial_hd(i));
>> @@ -1077,6 +1079,35 @@ static void aspeed_set_spi_model(Object *obj, const char *value, Error **errp)
>>       bmc->spi_model = g_strdup(value);
>>   }
>> +static char *aspeed_get_uart(Object *obj, Error **errp)
>> +{
>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>> +    int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
>> +
>> +    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1);
>> +}
>> +
>> +static void aspeed_set_uart(Object *obj, const char *value, Error **errp)
>> +{
>> +    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
>> +    AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
>> +    AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
>> +    int val;
>> +
>> +    if (sscanf(value, "uart%u", &val) != 1) {
>> +        error_setg(errp, "Bad value for \"uart\" property");
> 
> Why are you asking for a string and not an index?

because the literal name is what people find in the DT. See files
arch/arm/boot/dts/aspeed-bmc-* under Linux.

Thanks,

C.

> 
>> +        return;
>> +    }
>> +
>> +    /* The number of UART depends on the SoC */
>> +    if (val < 1 || val > sc->uarts_num) {
>> +        error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uarts_num);
>> +        return;
>> +    }
>> +    bmc->uart_chosen = ASPEED_DEV_UART1 + val - 1;
>> +}
>> +
>>   static void aspeed_machine_class_props_init(ObjectClass *oc)
>>   {
>>       object_class_property_add_bool(oc, "execute-in-place",
>> @@ -1085,6 +1116,10 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
>>       object_class_property_set_description(oc, "execute-in-place",
>>                              "boot directly from CE0 flash device");
>> +    object_class_property_add_str(oc, "uart", aspeed_get_uart, aspeed_set_uart);
>> +    object_class_property_set_description(oc, "uart",
>> +                           "Change the default UART to \"uartX\"");
>> +
>>       object_class_property_add_str(oc, "fmc-model", aspeed_get_fmc_model,
>>                                      aspeed_set_fmc_model);
>>       object_class_property_set_description(oc, "fmc-model",
> 


