Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67673723829
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 08:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6QVV-0002gD-0i; Tue, 06 Jun 2023 02:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QVT-0002fo-2T; Tue, 06 Jun 2023 02:49:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QVR-0002yg-8Z; Tue, 06 Jun 2023 02:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0kjTQMHvurHakLs5QEBEICkdRhpch4fm+zP8C0Cj0cM=; b=ESn+cjKH/Bo3XQjvPPBH+P9YW1
 CfzzqExjBs7vecEHtvg4VFLC5eooWP0gc1nWjDppn6hA+zrwKBhQYwDF2hc9j29EdTBL5qpAwZMyJ
 INuhYox4CiGgUDMU2x+p+5jjwpVX9NzIKVWZ4VKZBDVBY5kgf6n/ev+1u8k3v6QA3B39iJflk5IbO
 BYJlOxsQZDT7W48zCX5csyff731U0x3YzbGVdesRH/ft64kR/BFqoT/OhWFDMqVWzOV7kJz7BU9rW
 pSZWSTJ1HewfiFc7Fruloni/IrD5g1O7BLIsRadOWlLSGbctYyFTJB4L6TrnhfwBfq1uAX4TBU75h
 4CFctzoL9wY+xKCF1dXX8L9VO3OnMCbNlhoIZP6sJXpLZ/ZfOBqVnPQDFmGD///kfsvUerAlk12+H
 JHSFN0yPSSIaadYfNySEEe6Nc9y+dPiCa4rLqt6rWO4BIZ2q6g66f/xnkCXK+KxMFHJRpiI9dL5aE
 bmu0+1mze+wwbyqMJLlViQ7DGQLrnt5MS8muABaX9CLSbdtvqkZRT5wyve2B3OiLqy2f+xS+hY1M/
 Nd1oWJIAgDAaCZlj+rPjAT/44JRfBVBueGBHcfu88trlaWMGaGI0UFyeW5/zwZKjzXygbk9jpAFK0
 wF3zwMh1mWPrxQggbCWZu9oeHdLXe0Sk1OTUjgluQ=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q6QVB-00055U-B8; Tue, 06 Jun 2023 07:49:13 +0100
Message-ID: <c753ab8b-4f9a-3309-ea16-3debaf2c4111@ilande.co.uk>
Date: Tue, 6 Jun 2023 07:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
References: <20230523195608.125820-1-shentey@gmail.com>
 <c138717c-5085-3b4b-5a46-0fa93179f6a8@ilande.co.uk>
 <20230601080655-mutt-send-email-mst@kernel.org>
 <5982629b-0ff1-2525-e16a-309257710a20@ilande.co.uk>
 <8187BA4B-5031-4AC6-A94C-27AB714C850C@gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <8187BA4B-5031-4AC6-A94C-27AB714C850C@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 05/06/2023 07:58, Bernhard Beschow wrote:

> Am 1. Juni 2023 12:45:47 UTC schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:
>> On 01/06/2023 13:07, Michael S. Tsirkin wrote:
>>
>>> On Thu, May 25, 2023 at 05:03:15PM +0100, Mark Cave-Ayland wrote:
>>>> On 23/05/2023 20:56, Bernhard Beschow wrote:
>>>>
>>>>> This series:
>>>>> * Removes dead code from omap_uart and i82378
>>>>> * Resolves redundant code in the i8254 timer devices
>>>>>
>>>>> v3:
>>>>> * Drop TYPE_ISA_PARALLEL since they became obsolete by
>>>>>      https://lore.kernel.org/qemu-devel/20230522115014.1110840-9-thuth@redhat.com/
>>>>
>>>> Oh I didn't see that this had already been merged :/
>>>>
>>>> It's not a reason to block this series, but I'd still like to see your
>>>> changes to ParallelState and ISAParallelState merged separately since they
>>>> are a better match for our QOM coding standards.
>>>>
>>>>> v2:
>>>>> * Export ParallelState and ISAParallelState (Mark)
>>>>>
>>>>> Testing done:
>>>>> * `make check`
>>>>>
>>>>> Bernhard Beschow (3):
>>>>>      hw/timer/i8254_common: Share "iobase" property via base class
>>>>>      hw/arm/omap: Remove unused omap_uart_attach()
>>>>>      hw/isa/i82378: Remove unused "io" attribute
>>>>>
>>>>>     include/hw/arm/omap.h   | 1 -
>>>>>     hw/char/omap_uart.c     | 9 ---------
>>>>>     hw/i386/kvm/i8254.c     | 1 -
>>>>>     hw/isa/i82378.c         | 1 -
>>>>>     hw/timer/i8254.c        | 6 ------
>>>>>     hw/timer/i8254_common.c | 6 ++++++
>>>>>     6 files changed, 6 insertions(+), 18 deletions(-)
>>>>
>>>> Do we know who is going to pick up these series? I can send a PR if no-one minds?
>>>>
>>>
>>>
>>> Go ahead:
>>>
>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Thanks Michael! Is there any objection to also including https://patchew.org/QEMU/20230531211043.41724-1-shentey@gmail.com/ at the same time?
>>
>> Bernhard: if you are able to submit a rebased version of the ISA_PARALLEL cleanups at https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/ I think it is worth considering those for inclusion in the PR as well (note the comments re: an updated commit message and register definitions, but I can't really do this myself because of the missing SoB).
> 
> What could I put into the commit message?

That comment came from Zoltan (see 
https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/20230521123049.312349-5-shentey@gmail.com/#77413450-244e-287b-ad21-e57cb5e2abf5@eik.bme.hu). 
Zoltan, would you like to suggest some alternative wording?

If not, feel free to take my message at 
https://patchew.org/QEMU/20230604131450.428797-1-mark.cave-ayland@ilande.co.uk/20230604131450.428797-14-mark.cave-ayland@ilande.co.uk/ 
and tweak it accordingly.

> I'm also wondering: Why export the structure but not the register definitions? Are the register definitions not part of the interface? I think these could be used in unittests -- if we had any -- to avoid magic numbers.

In theory that could be possible, but it's not something that people have requested 
(yet). From the QEMU perspective a device is something with memory regions and gpios 
that can be wired up within a board, so unless the #defines are used directly within 
ParallelState it doesn't make too much sense to export them currently.


ATB,

Mark.


