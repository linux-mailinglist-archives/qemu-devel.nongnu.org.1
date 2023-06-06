Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1DB723E7D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TPs-0001Aq-VL; Tue, 06 Jun 2023 05:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6TPe-000194-TP; Tue, 06 Jun 2023 05:55:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6TPb-0007U5-RQ; Tue, 06 Jun 2023 05:55:37 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9A4A4748A56;
 Tue,  6 Jun 2023 11:55:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C1FD6746377; Tue,  6 Jun 2023 11:55:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BEDBB746361;
 Tue,  6 Jun 2023 11:55:31 +0200 (CEST)
Date: Tue, 6 Jun 2023 11:55:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: Bernhard Beschow <shentey@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 =?ISO-8859-15?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Michael Tokarev <mjt@tls.msk.ru>, 
 qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 0/3] Trivial cleanups
In-Reply-To: <c753ab8b-4f9a-3309-ea16-3debaf2c4111@ilande.co.uk>
Message-ID: <c9ab0d96-1723-4359-5c37-3164ebb44ab8@eik.bme.hu>
References: <20230523195608.125820-1-shentey@gmail.com>
 <c138717c-5085-3b4b-5a46-0fa93179f6a8@ilande.co.uk>
 <20230601080655-mutt-send-email-mst@kernel.org>
 <5982629b-0ff1-2525-e16a-309257710a20@ilande.co.uk>
 <8187BA4B-5031-4AC6-A94C-27AB714C850C@gmail.com>
 <c753ab8b-4f9a-3309-ea16-3debaf2c4111@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 6 Jun 2023, Mark Cave-Ayland wrote:
> On 05/06/2023 07:58, Bernhard Beschow wrote:
>> Am 1. Juni 2023 12:45:47 UTC schrieb Mark Cave-Ayland 
>> <mark.cave-ayland@ilande.co.uk>:
>>> On 01/06/2023 13:07, Michael S. Tsirkin wrote:
>>> 
>>>> On Thu, May 25, 2023 at 05:03:15PM +0100, Mark Cave-Ayland wrote:
>>>>> On 23/05/2023 20:56, Bernhard Beschow wrote:
>>>>> 
>>>>>> This series:
>>>>>> * Removes dead code from omap_uart and i82378
>>>>>> * Resolves redundant code in the i8254 timer devices
>>>>>> 
>>>>>> v3:
>>>>>> * Drop TYPE_ISA_PARALLEL since they became obsolete by
>>>>>>      https://lore.kernel.org/qemu-devel/20230522115014.1110840-9-thuth@redhat.com/
>>>>> 
>>>>> Oh I didn't see that this had already been merged :/
>>>>> 
>>>>> It's not a reason to block this series, but I'd still like to see your
>>>>> changes to ParallelState and ISAParallelState merged separately since 
>>>>> they
>>>>> are a better match for our QOM coding standards.
>>>>> 
>>>>>> v2:
>>>>>> * Export ParallelState and ISAParallelState (Mark)
>>>>>> 
>>>>>> Testing done:
>>>>>> * `make check`
>>>>>> 
>>>>>> Bernhard Beschow (3):
>>>>>>      hw/timer/i8254_common: Share "iobase" property via base class
>>>>>>      hw/arm/omap: Remove unused omap_uart_attach()
>>>>>>      hw/isa/i82378: Remove unused "io" attribute
>>>>>>
>>>>>>     include/hw/arm/omap.h   | 1 -
>>>>>>     hw/char/omap_uart.c     | 9 ---------
>>>>>>     hw/i386/kvm/i8254.c     | 1 -
>>>>>>     hw/isa/i82378.c         | 1 -
>>>>>>     hw/timer/i8254.c        | 6 ------
>>>>>>     hw/timer/i8254_common.c | 6 ++++++
>>>>>>     6 files changed, 6 insertions(+), 18 deletions(-)
>>>>> 
>>>>> Do we know who is going to pick up these series? I can send a PR if 
>>>>> no-one minds?
>>>>> 
>>>> 
>>>> 
>>>> Go ahead:
>>>> 
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>> 
>>> Thanks Michael! Is there any objection to also including 
>>> https://patchew.org/QEMU/20230531211043.41724-1-shentey@gmail.com/ at the 
>>> same time?
>>> 
>>> Bernhard: if you are able to submit a rebased version of the ISA_PARALLEL 
>>> cleanups at 
>>> https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/ I 
>>> think it is worth considering those for inclusion in the PR as well (note 
>>> the comments re: an updated commit message and register definitions, but I 
>>> can't really do this myself because of the missing SoB).
>> 
>> What could I put into the commit message?
>
> That comment came from Zoltan (see 
> https://patchew.org/QEMU/20230521123049.312349-1-shentey@gmail.com/20230521123049.312349-5-shentey@gmail.com/#77413450-244e-287b-ad21-e57cb5e2abf5@eik.bme.hu). 
> Zoltan, would you like to suggest some alternative wording?
>
> If not, feel free to take my message at 
> https://patchew.org/QEMU/20230604131450.428797-1-mark.cave-ayland@ilande.co.uk/20230604131450.428797-14-mark.cave-ayland@ilande.co.uk/ 
> and tweak it accordingly.

I'm OK with your suggestion too or maybe something like:

Export ParallelState to allow embedding it in other devices.

If you just want the

#define TYPE_ISA_PARALLEL "isa-parallel"
OBJECT_DECLARE_SIMPLE_TYPE(ISAParallelState, ISA_PARALLEL)

part to be in a header then moving the structure there as well is not 
necessary, only when you also want to use the structure somewhere where 
its size is needed like adding it to another structure.

>> I'm also wondering: Why export the structure but not the register 
>> definitions? Are the register definitions not part of the interface? I 
>> think these could be used in unittests -- if we had any -- to avoid magic 
>> numbers.
>
> In theory that could be possible, but it's not something that people have 
> requested (yet). From the QEMU perspective a device is something with memory 
> regions and gpios that can be wired up within a board, so unless the #defines 
> are used directly within ParallelState it doesn't make too much sense to 
> export them currently.

On the other hand keeping the structure and defines in the c file ensures 
encapsulation so nothing else will mess with the internals of the object 
and keep these as implementation detail (it's also easier to work with a 
single file than having to look up struct definition elsewhere) so I'd 
prefer keeping things together unless the struct is needed elsewhere. The 
coding style does not clearly say which is preferred, in fact it only 
mentions thet OBJECT_DECLARE_SIMPLE_TYPE ofthen goes in a header but the 
struct is declared separately. The moving of structs to headers only 
started with preferring embedded objects over allocating them so we don't 
have to care about freeing them which needs the struct definition in the 
header breaking encapsulation.

Regards,
BALATON Zoltan

