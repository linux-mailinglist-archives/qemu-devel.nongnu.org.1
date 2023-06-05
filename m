Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A36722C6A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 18:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Cxq-0008Hp-BQ; Mon, 05 Jun 2023 12:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org>)
 id 1q6Cxn-0008Go-Tm; Mon, 05 Jun 2023 12:21:47 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org>)
 id 1q6Cxl-0000i4-Rr; Mon, 05 Jun 2023 12:21:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QZf4g4xpQz4x4G;
 Tue,  6 Jun 2023 02:21:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QZf4X6WX5z4x4C;
 Tue,  6 Jun 2023 02:21:32 +1000 (AEST)
Message-ID: <aed4658a-4ee2-2ca0-1042-da5573d34774@kaod.org>
Date: Mon, 5 Jun 2023 18:21:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
 <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
 <0d11b78e-56f7-553a-3e85-0edef9b649ac@linaro.org>
 <523179dd-7842-7f03-14d6-678ed680a017@kaod.org>
 <6bfba08e-ce3e-539b-952d-697c8791fab2@linaro.org>
 <54d781f8-35d0-9e68-c2ec-743dd8f6a88e@kaod.org>
 <36c9bda8-3af2-ebf5-f8b9-599cafea0735@linaro.org>
 <467372F8-7DB7-41FB-8BA0-6CF12EC3AC50@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <467372F8-7DB7-41FB-8BA0-6CF12EC3AC50@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=6mOa=BZ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
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

On 6/5/23 07:57, Bernhard Beschow wrote:
> 
> 
> Am 31. Mai 2023 07:39:32 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> On 31/5/23 08:36, Cédric Le Goater wrote:
>>> On 5/31/23 08:17, Philippe Mathieu-Daudé wrote:
>>>> +QOM tinkerers
>>>>
>>>> On 31/5/23 07:59, Cédric Le Goater wrote:
>>>>> On 5/30/23 23:15, Philippe Mathieu-Daudé wrote:
>>>>>> On 30/5/23 22:34, Philippe Mathieu-Daudé wrote:
>>>>>>> On 8/5/23 09:58, Cédric Le Goater wrote:
>>>>>>>> Simple routine to retrieve a DeviceState object on a SPI bus using its
>>>>>>>> address/cs. It will be useful for the board to wire the CS lines.
>>>>>>>>
>>>>>>>> Cc: Alistair Francis <alistair@alistair23.me>
>>>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>>>> ---
>>>>>>>>    include/hw/ssi/ssi.h |  2 ++
>>>>>>>>    hw/ssi/ssi.c         | 15 +++++++++++++++
>>>>>>>>    2 files changed, 17 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
>>>>>>>> index ffd3a34ba4..c7beabdb09 100644
>>>>>>>> --- a/include/hw/ssi/ssi.h
>>>>>>>> +++ b/include/hw/ssi/ssi.h
>>>>>>>> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>>>>>>>>    uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>>>>>>>> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);
>>>>>>
>>>>>> Also, this helper should (preferably) return a SSIPeripheral type.
>>>>>
>>>>> Well, having a DeviceState is handy for the callers (today) and
>>>>> ssi_create_peripheral() returns a DeviceState. Let's keep it that
>>>>> way.
>>>>
>>>> Yes I know it is handy :) I'm not against your patch; besides other
>>>> APIs do that. I'm wondering about QOM design here. Having Foo device,
>>>> should FOO API return the common qdev abstract type (DeviceState) or
>>>> a Foo type? Either ways we keep QOM-casting around, but I still tend
>>>> to consider FOO API returning Foo pointer provides some type check
>>>> safety, and also provides the API user hints about what is used.
>>>> Need more coffee.
>>>
>>> It is used in two code paths today:
>>>
>>>       ...
>>>           DeviceState *dev = ssi_get_cs(bmc->soc.fmc.spi, 0);
>>>           BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
> 
> Looks like m25p80_get_blk() should take a more specific argument as well, like Phil suggested already. Wouldn't that avoid the QOM cast here?

Exposing the m25p80 internals could be painful. I'd rather keep the
definitions where they are under m25p80.c.

Thanks,

C.


> 
> Best regards,
> Bernhard
> 
>>>       ...
>>> and
>>>       ...
>>>           DeviceState *dev = ssi_get_cs(s->spi, i);
>>>           if (dev) {
>>>               qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
>>>       ...
>>>
>>>
>>> Changing the interface is not a radical change, it will add two QOM-casts.
>>> I can give it a try in v2.
>>
>> Hold on, lets see what others think first.


