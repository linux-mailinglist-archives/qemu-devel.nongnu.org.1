Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE2798A62
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 18:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qedxj-0000AZ-TC; Fri, 08 Sep 2023 12:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qedxh-0000A9-NN
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qedxf-0001MW-IN
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 12:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fglzyna0bINHGsb31H0ZRYIX/l8Z4D81WHkhz2EKPTw=; b=EbbBYou9jhgJ41mUS+KMfxQlvt
 JnWYq9BgpwW7BW+dq5SPqS7W0gmRE20n3b5aw/YulToWIbFZDQbkCbrrU0DTxtdWrv0kaRETMMjzn
 +4hT+ICxz9GN8VuX4bRFR8hiFQkQUID9WDscyHJp1fs2bSfbj3cMtvkOTykoP4JI3LpXwwbBmzPTH
 w1LRb47otbsT2DuS+rcXMvdtfgfZLxTvnoHC2KGcmdUWDYpDz45NDw5bGDdXU/KbNs/968iubzcFR
 86kV91QMQkhTuZXJIi0bJrvwwXHift74ZfIrvQzJHw+gJOe4QWbD5MGxIn4LXOlI1dcrqW6uocP+V
 0wBZevUV/1Gj5EiseMLrudbJ9kBSKxj17cg5E/8GZDIWdhSkYYB5PW4ISXEbGGC7k0O+HSy/+UEyR
 xMdVytpitJX5778qTFvP5O2zkyqdZCE6124zCJLO4kkvNGZ56dcC1ZpzgK/F8dP14BcBCtMK+FGV2
 KqPHOxcJ06lCCDYa8+BHKFE83fqysdqh3r/9ZH+yS7sOpKG2Zy/Q6U3nIl4eGRTCKA8mctDhg53YM
 Fp8BST/l0A3O1jwbCnQLuGMydp1E8u6wYP8wggRynFKOoIr0ocJ4/neZ++eThcC/LgbHUCi/dt98Y
 CpxOcTRzYBWifiME9mLePuyCdU+kusN1ZDDik4V4E=;
Received: from host81-158-188-207.range81-158.btcentralplus.com
 ([81.158.188.207] helo=[10.8.0.10])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qedxX-0009Ir-TD; Fri, 08 Sep 2023 17:03:56 +0100
Message-ID: <ed274425-43bd-a4b6-b1d6-1d1d42784cf7@ilande.co.uk>
Date: Fri, 8 Sep 2023 17:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 laurent@vivier.eu, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
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
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <44e50cdb-37f0-c18d-4d64-0f34777a193d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.188.207
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

On 08/09/2023 10:42, Philippe Mathieu-Daudé wrote:

> On 8/9/23 08:54, Mark Cave-Ayland wrote:
>> On 07/07/2023 09:29, Philippe Mathieu-Daudé wrote:
>>
>>> On 2/7/23 17:48, Mark Cave-Ayland wrote:
>>>> This determines whether the Apple Sound Chip (ASC) is set to enhanced mode
>>>> (default) or to original mode. The real Q800 hardware used an EASC chip however
>>>> a lot of older software only works with the older ASC chip.
>>>>
>>>> Adding this as a machine parameter allows QEMU to be used as an developer aid
>>>> for testing and migrating code from ASC to EASC.
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> ---
>>>>   hw/m68k/q800.c         | 30 +++++++++++++++++++++++++++++-
>>>>   include/hw/m68k/q800.h |  1 +
>>>>   2 files changed, 30 insertions(+), 1 deletion(-)
>>>
>>>
>>>> +static bool q800_get_easc(Object *obj, Error **errp)
>>>> +{
>>>> +    Q800MachineState *ms = Q800_MACHINE(obj);
>>>> +
>>>> +    return ms->easc;
>>>> +}
>>>
>>> Is the getter useful? Otherwise:
>>
>> Isn't it a requirement? Otherwise I can see that if we decide to enumerate machine 
>> properties (similar as to how device properties appear in "info qtree") then it 
>> would be impossible to display its value. Certainly at the moment we consider that 
>> adding an object property to an underlying struct effectively makes it "public".
> 
> Just FYI this is not a requirement, per "qom/object.h":
> 
>    /**
>     * object_property_add_bool:
>     * @obj: the object to add a property to
>     * @name: the name of the property
>     * @get: the getter or NULL if the property is write-only.
>     * @set: the setter or NULL if the property is read-only
> 
> I'm not sure when we want a write-only QOM boolean property, so I
> genuinely ask, since I agree introspecting QOM object fields from
> the monitor is helpful.

Agreed, although I'd be interested to hear if anyone can come up with a compelling 
use case for write-only properties. In that case I'll assume your R-B stands when I 
re-send the latest version of the series ;)


ATB,

Mark.


