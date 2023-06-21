Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0307B738B0E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:26:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0eG-0004Om-Nl; Wed, 21 Jun 2023 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qC0e3-0004O5-HE
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:25:23 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qC0dx-0004Y8-6A
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:25:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 233BA748A56;
 Wed, 21 Jun 2023 18:25:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5A104748A60; Wed, 21 Jun 2023 18:25:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 58865748A5D;
 Wed, 21 Jun 2023 18:25:05 +0200 (CEST)
Date: Wed, 21 Jun 2023 18:25:05 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 03/24] q800: introduce Q800MachineState
In-Reply-To: <0fcee3b0-145b-b640-aa9b-d86247e4e224@ilande.co.uk>
Message-ID: <6fa2d5e8-5b15-31d8-f135-612da8f50050@eik.bme.hu>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
 <3ffba6ed-4213-2e57-dcd1-ba1315f2df31@eik.bme.hu>
 <0fcee3b0-145b-b640-aa9b-d86247e4e224@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2028280993-1687364705=:5320"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2028280993-1687364705=:5320
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
> On 21/06/2023 12:33, BALATON Zoltan wrote:
>
>> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>>> This provides an overall container and owner for Machine-related objects 
>>> such
>>> as MemoryRegions.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> MAINTAINERS            |  1 +
>>> hw/m68k/q800.c         |  2 ++
>>> include/hw/m68k/q800.h | 40 ++++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 43 insertions(+)
>>> create mode 100644 include/hw/m68k/q800.h
>>> 
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 88b5a7ee0a..748a66fbaa 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1236,6 +1236,7 @@ F: include/hw/misc/mac_via.h
>>> F: include/hw/nubus/*
>>> F: include/hw/display/macfb.h
>>> F: include/hw/block/swim.h
>>> +F: include/hw/m68k/q800.h
>>> 
>>> virt
>>> M: Laurent Vivier <laurent@vivier.eu>
>>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>>> index 465c510c18..c0256c8a90 100644
>>> --- a/hw/m68k/q800.c
>>> +++ b/hw/m68k/q800.c
>>> @@ -38,6 +38,7 @@
>>> #include "standard-headers/asm-m68k/bootinfo.h"
>>> #include "standard-headers/asm-m68k/bootinfo-mac.h"
>>> #include "bootinfo.h"
>>> +#include "hw/m68k/q800.h"
>>> #include "hw/misc/mac_via.h"
>>> #include "hw/input/adb.h"
>>> #include "hw/nubus/mac-nubus-bridge.h"
>>> @@ -749,6 +750,7 @@ static void q800_machine_class_init(ObjectClass *oc, 
>>> void *data)
>>> static const TypeInfo q800_machine_typeinfo = {
>>>     .name       = MACHINE_TYPE_NAME("q800"),
>>>     .parent     = TYPE_MACHINE,
>>> +    .instance_size = sizeof(Q800MachineState),
>>>     .class_init = q800_machine_class_init,
>>> };
>>> 
>>> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
>>> new file mode 100644
>>> index 0000000000..f3bc17aa1b
>>> --- /dev/null
>>> +++ b/include/hw/m68k/q800.h
>> 
>> Why is this defined in a public header? Moving struct definitions of 
>> devices to allow them to be embedded in other structs makes sense but is 
>> there ever a reason to embed a machine state anywhere else than using it in 
>> q800.c? I don't think so, thus to preserve locality and save some lines in 
>> this series I think this machine state should just be in q800.c like I have 
>> similar struct in pegasos2.c. It may only make sense to put it in a header 
>> if q800.c was split up to multiple files but even then it should be a local 
>> header in hw/m68k and not a public header in my opinion.
>
> This is just following our standard guidelines since MachineState is a QOM

Again, is this a documented guideline or something vaguely agreen upon? 
I'd argue that only objects that are used by other objects (such as 
devices that can be embedded in machines or other devices) should be 
declared in public headers but there could be local objects that are only 
used locally which don't have to be exported. This machine state is 
definitely a local object of q800 that nothing else should mess with so to 
make that clear I think it should not be in a public header.

> object of TYPE_MACHINE. Note that there are also a number of existing 
> examples of this currently within the QEMU tree.

There are examples for the opposite as well so without an rationale that 
alone is not explaining it.  (Also not having a public header may make 
this series considerably shorter but the main reason I suggest it is to 
ensure locality of this object to q800.)

Regards,
BALATON Zoltan

>
> ATB,
>
> Mark.
>
>
--3866299591-2028280993-1687364705=:5320--

