Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE6A719C6D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:47:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hh0-0005Hb-Ek; Thu, 01 Jun 2023 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hgt-0005Dk-UI; Thu, 01 Jun 2023 08:46:08 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hgp-00054T-La; Thu, 01 Jun 2023 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5ZwL4ZL6rlQ3ymDkUdJbiwVqHg5lcjj8H/byeyc3ly8=; b=KYtgdzFm78z6gT4MhHnIOK8haN
 Z57Xhh8CZEeiGOFcYBgIg0u+8phToQX57wMi1uG6kFraXE44qRpba6Wfiiq5sUKYYAWGhxyIwBZ3O
 3MHJUIiMptP0dcpTqHNxhHiPjUX18cBBdg35fPrfoYYZZy5eA9hBicK5Nu9yzZGdBRzDtRudd1JPc
 9rCNftQzqgWeOrKYoMCWGEGkeICd9wUUI27PPmx3IuMUmwQi/VIHMco5yC9aHptNzAVibDB8GOo2p
 gSiDSq6ApH1ysVLtFZxwRLvVeoz/nTHCn+rBqhOgaCKSruzg5ulQKT3if33sQ7QIwhiJiiFnJ3NZ4
 kKwAQH7r9on0Ucv4R+zkVkGyUkuXm558JkABZiacs5kdQNxzQfa/WfZ0EtKYL1Ihgq85gmvIjs+mK
 zdaTQgkbX9i+EP0mrzumgb/46OQCuSDt2MrodHQWcUNKmjQJNyW3gCgj8w69HY6o+pKZRggohUmR8
 B+WtnC5gX3Fp1Ah0I6wqWMaAm4/7PCMjtkowrJcVDS+erYhS4a0++f6rU/p73/JoZyqmE8y8UrgzZ
 jZ17x61EYBRdiC3Rp2VRL6pZmgtcN9HQmFWELD53uuskV8USyhSLMcxF10j2DWK9mIVVNXwM+KYy5
 Zwtx8iw4EiMaebf7FrPzj5gFbluuLUPctJkKEIFog=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4hgW-0006Nd-7e; Thu, 01 Jun 2023 13:45:47 +0100
Message-ID: <5982629b-0ff1-2525-e16a-309257710a20@ilande.co.uk>
Date: Thu, 1 Jun 2023 13:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230523195608.125820-1-shentey@gmail.com>
 <c138717c-5085-3b4b-5a46-0fa93179f6a8@ilande.co.uk>
 <20230601080655-mutt-send-email-mst@kernel.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20230601080655-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 0/3] Trivial cleanups
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01/06/2023 13:07, Michael S. Tsirkin wrote:

> On Thu, May 25, 2023 at 05:03:15PM +0100, Mark Cave-Ayland wrote:
>> On 23/05/2023 20:56, Bernhard Beschow wrote:
>>
>>> This series:
>>> * Removes dead code from omap_uart and i82378
>>> * Resolves redundant code in the i8254 timer devices
>>>
>>> v3:
>>> * Drop TYPE_ISA_PARALLEL since they became obsolete by
>>>     https://lore.kernel.org/qemu-devel/20230522115014.1110840-9-thuth@redhat.com/
>>
>> Oh I didn't see that this had already been merged :/
>>
>> It's not a reason to block this series, but I'd still like to see your
>> changes to ParallelState and ISAParallelState merged separately since they
>> are a better match for our QOM coding standards.
>>
>>> v2:
>>> * Export ParallelState and ISAParallelState (Mark)
>>>
>>> Testing done:
>>> * `make check`
>>>
>>> Bernhard Beschow (3):
>>>     hw/timer/i8254_common: Share "iobase" property via base class
>>>     hw/arm/omap: Remove unused omap_uart_attach()
>>>     hw/isa/i82378: Remove unused "io" attribute
>>>
>>>    include/hw/arm/omap.h   | 1 -
>>>    hw/char/omap_uart.c     | 9 ---------
>>>    hw/i386/kvm/i8254.c     | 1 -
>>>    hw/isa/i82378.c         | 1 -
>>>    hw/timer/i8254.c        | 6 ------
>>>    hw/timer/i8254_common.c | 6 ++++++
>>>    6 files changed, 6 insertions(+), 18 deletions(-)
>>
>> Do we know who is going to pick up these series? I can send a PR if no-one minds?
>>
> 
> 
> Go ahead:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks Michael! Is there any objection to also including 
https://patchew.org/QEMU/20230531211043.41724-1-shentey@gmail.com/ at the same time?

Bernhard: if you are able to submit a rebased version of the ISA_PARALLEL cleanups at 
https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/ I think it is 
worth considering those for inclusion in the PR as well (note the comments re: an 
updated commit message and register definitions, but I can't really do this myself 
because of the missing SoB).


ATB,

Mark.


