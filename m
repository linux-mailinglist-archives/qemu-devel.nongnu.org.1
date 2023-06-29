Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780C4742A4B
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 18:09:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEuBl-0004Nm-OR; Thu, 29 Jun 2023 12:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEuBf-0004LE-JI; Thu, 29 Jun 2023 12:08:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEuBc-0003hX-3t; Thu, 29 Jun 2023 12:08:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QsNdk6hB4z4wp1;
 Fri, 30 Jun 2023 02:07:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsNdh3KWSz4wgk;
 Fri, 30 Jun 2023 02:07:52 +1000 (AEST)
Message-ID: <1b0a81d8-b881-cef8-0c53-3c7cdfe9a769@kaod.org>
Date: Thu, 29 Jun 2023 18:07:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-6-clg@kaod.org>
 <03d52281-22fb-5786-e321-71a47a198e19@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <03d52281-22fb-5786-e321-71a47a198e19@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/29/23 13:09, Philippe Mathieu-Daudé wrote:
> On 7/6/23 06:39, Cédric Le Goater wrote:
>> Simple routine to retrieve a DeviceState object on a SPI bus using its
>> address/cs. It will be useful for the board to wire the CS lines.
>>
>> Cc: Alistair Francis <alistair@alistair23.me>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   include/hw/ssi/ssi.h |  2 ++
>>   hw/ssi/ssi.c         | 15 +++++++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>> index 9e0706a5248c..01662521b09a 100644
>> --- a/include/hw/ssi/ssi.h
>> +++ b/include/hw/ssi/ssi.h
>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>> +DeviceState *ssi_get_cs(SSIBus *bus, uint8_t addr);
> 
> Revisiting this patch, I now think this should be:
> 
>    qemu_irq ssi_get_cs(SSIBus *bus, uint8_t chipselect);

The device is needed for some other use. See :

   [PATCH v2 10/12] aspeed: Get the BlockBackend of FMC0 from the flash device

C.

> 
> 
>>   #endif
>> diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
>> index d4409535429c..7c71fce0db90 100644
>> --- a/hw/ssi/ssi.c
>> +++ b/hw/ssi/ssi.c
>> @@ -27,6 +27,21 @@ struct SSIBus {
>>   #define TYPE_SSI_BUS "SSI"
>>   OBJECT_DECLARE_SIMPLE_TYPE(SSIBus, SSI_BUS)
>> +DeviceState *ssi_get_cs(SSIBus *bus, uint8_t addr)
>> +{
>> +    BusState *b = BUS(bus);
>> +    BusChild *kid;
>> +
>> +    QTAILQ_FOREACH(kid, &b->children, sibling) {
>> +        SSIPeripheral *kid_ssi = SSI_PERIPHERAL(kid->child);
>> +        if (kid_ssi->addr == addr) {
>> +            return kid->child;
> 
> and:
> 
>                 return qdev_get_gpio_in_named(kid->child,
>                                               SSI_GPIO_CS, 0);
> 
>> +        }
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>>   static const TypeInfo ssi_bus_info = {
>>       .name = TYPE_SSI_BUS,
>>       .parent = TYPE_BUS,
> 


