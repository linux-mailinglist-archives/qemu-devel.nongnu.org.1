Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4587A88AB
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 17:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qizKn-0003Y8-7s; Wed, 20 Sep 2023 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizKi-0003Xe-3d
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:41:44 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizKg-0006f1-KK
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AIAib1BJS3rjfr+TssE4CXiZE1sI6ppa1cSS9AqQkEk=; b=vROyzy+Y9qXVlT2fW4oVlimOG7
 HA6nRDWa+fQfSoxEBjqlTFTnBXXRYkQrSB2SazTJ1jSqvr4DG1MCxPjlAl2i6ndJnw9M8t29VENCI
 cwyWACPsR/JiMGnf8BUmeHxvUzZe+Lv+q+8IEwKCQdBn9tYlcRV+H2LQWplqWlIwYq4sE7bp+USZf
 S/hq/y3FcXO3z1YlA0bY5pWeIKTkitIpQHDnEnNovFGwrce1Q8BDtleD5XCXaVEGn47q4HkyW7DNe
 1QDnWNOKeZJnpiTQs6gYaiLD9jFgQYAA5rQ7PmMbrfnuITHSeQfhkuQwj7WaGHw7pfJ+H44O2+Bus
 f/EWeRi2JLzbjxY/f7Lor0JE67IFxK4/MQpEutwPzC+uu+QiiYOoiL/KmRtMIAIl2q3R5/8kI8/wG
 pOKnKrV37+NxNfXKkMKRkmEPQPG5EKhnK4HuodQnYYGUMMyTnYnT6btj+cyT7+V+d8z0kdZN+MAQd
 YozizLeprVq09gtJ59S+bp3GmKnuD/7SP+Ke4Cr46h/MD/IrzoJMm0/USP9q3cm+efVx1RLq/e0r+
 pl5hGLcZz0nFsU4lUi+bHqcnyXIOCc+zF2T5mP10pHrhkBzT2XvqqcOcCN58ab3sOcFRvKXGfzHWE
 1qt0u79rZSaKFEjwMKrCqNsrKgr5vxUhfMgXcnZ48=;
Received: from [2a00:23c4:8baf:5f00:4f7d:f5b:6c8a:d0af]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizKT-0004mY-IA; Wed, 20 Sep 2023 16:41:33 +0100
Message-ID: <ae8d9cc8-d633-0ea0-3714-352e87bddede@ilande.co.uk>
Date: Wed, 20 Sep 2023 16:41:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-11-mark.cave-ayland@ilande.co.uk>
 <e3fe143f-2c07-2d59-3dca-4534a767391d@linaro.org>
 <f639b4b1-965a-fe9d-a988-2dbd2c1c0e68@ilande.co.uk>
 <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
 <87ledd1eaz.fsf@pond.sub.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <87ledd1eaz.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:4f7d:f5b:6c8a:d0af
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 10/21] q800: add easc bool machine class property to
 switch between ASC and EASC
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

On 11/09/2023 06:15, Markus Armbruster wrote:

> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 8/9/23 08:54, Mark Cave-Ayland wrote:
>>> On 07/07/2023 09:29, Philippe Mathieu-Daudé wrote:
>>>
>>>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>>>> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
>>>>> (default) or to original mode. The real Q800 hardware used an EASC chip however
>>>>> a lot of older software only works with the older ASC chip.
>>>>>
>>>>> Adding this as a machine parameter allows QEMU to be used as an developer aid
>>>>> for testing and migrating code from ASC to EASC.
>>>>>
>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>> ---
>>>>>    hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>>>>>    include/hw/m68k/q800.h |  1 +
>>>>>    2 files changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>>
>>>>> +static bool q800_get_easc(Object *obj, Error **errp)
>>>>> +{
>>>>> +    Q800MachineState *ms = Q800_MACHINE(obj);
>>>>> +
>>>>> +    return ms->easc;
>>>>> +}
>>>>
>>>> Is the getter useful? Otherwise:
>>> Isn't it a requirement? Otherwise I can see that if we decide to enumerate machine properties (similar as to how device properties appear in "info qtree") then it would be impossible to display its value. Certainly at the moment we consider that adding an object property to an underlying struct effectively makes it "public".
>>
>> Just FYI this is not a requirement, per "qom/object.h":
>>
>>    /**
>>     * object_property_add_bool:
>>     * @obj: the object to add a property to
>>     * @name: the name of the property
>>     * @get: the getter or NULL if the property is write-only.
>>     * @set: the setter or NULL if the property is read-only
>>
>> I'm not sure when we want a write-only QOM boolean property, so I
>> genuinely ask, since I agree introspecting QOM object fields from
>> the monitor is helpful.
> 
> I suspect write-only properties came out of QOM's generality curse.  Do
> we have even one?  QOM's design makes this somewhat to tell.

Good question. Given that it's towards the beginning of the next dev cycle, perhaps 
it is worth sending a patch to find out? ;)


ATB,

Mark.


