Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF959738690
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:16:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBycB-00044J-Ct; Wed, 21 Jun 2023 10:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBybv-0003ub-G3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:15:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBybq-0003M2-LM
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 10:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/rzUBg0aKFBHZM/Dn/xlUNKB9LnFIZR7Ak5kcCHLEt0=; b=MMsFLJaFcrJ4E9wLiYbLmjcQIn
 sSVJpJznL41j/00un0/mvNzwRESZCHROrWuvIjgLCJUB3dLglaMV2AGlrrt47s2Sicl+PeFLQBYVG
 ZejTFONwqEPo71XWi9SpcZlA1nidSHcXeZpwtHa8Hzv2T8IDCstHktp23FBkYdjJXFK2IX8Zqrqse
 mWE8KuNMNbqVDiQz9fhS9ajqhTC0WWQCRNpOiwXHuTrMWY/JARNWYWEphCPnEqKE2avLYnQOcPZdv
 laMYWm9GF1XkpW5oKBZ1XAuB6qqTj117vdVpx80ZudXUKbEfbOvW7GX2vIpAfB9A8rsHBFUlLPp+p
 G+VBJUEq8kllMJ/H2QWuuUglYEY0s1B1+se2wq6fQdVU7kh7Rp7O8UT7WKVqvkIfHWiPQotm3/Ici
 pHTZRL58AgdM3nR1vBMganDljqjL1nohpQyc66aqxyIRG0VZoPVDTdovnoBCU9UGJweUuS+5Ma2TE
 TuGnyj6UtY9wDDYvRvAj+TElNFp9ZUS8w+tmsCPrZPgN+IS8qC0zUmmw4XGokFw0NLdAjECmch/TF
 dcgYYLvgToI6o0uQP44rCZdXPYITgrAfPGg/9NRMkTPhgjLPhuOiiKa8i7e8qJ11EwLdkYlh209m6
 GMVWuvI9Rz7Ax43FRiQVJMSkGdZKKvft6it4cmjUc=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBybX-0003IJ-Hn; Wed, 21 Jun 2023 15:14:43 +0100
Message-ID: <0fcee3b0-145b-b640-aa9b-d86247e4e224@ilande.co.uk>
Date: Wed, 21 Jun 2023 15:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: laurent@vivier.eu, qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-4-mark.cave-ayland@ilande.co.uk>
 <3ffba6ed-4213-2e57-dcd1-ba1315f2df31@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <3ffba6ed-4213-2e57-dcd1-ba1315f2df31@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 03/24] q800: introduce Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/06/2023 12:33, BALATON Zoltan wrote:

> On Wed, 21 Jun 2023, Mark Cave-Ayland wrote:
>> This provides an overall container and owner for Machine-related objects such
>> as MemoryRegions.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> MAINTAINERS            |  1 +
>> hw/m68k/q800.c         |  2 ++
>> include/hw/m68k/q800.h | 40 ++++++++++++++++++++++++++++++++++++++++
>> 3 files changed, 43 insertions(+)
>> create mode 100644 include/hw/m68k/q800.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 88b5a7ee0a..748a66fbaa 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1236,6 +1236,7 @@ F: include/hw/misc/mac_via.h
>> F: include/hw/nubus/*
>> F: include/hw/display/macfb.h
>> F: include/hw/block/swim.h
>> +F: include/hw/m68k/q800.h
>>
>> virt
>> M: Laurent Vivier <laurent@vivier.eu>
>> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
>> index 465c510c18..c0256c8a90 100644
>> --- a/hw/m68k/q800.c
>> +++ b/hw/m68k/q800.c
>> @@ -38,6 +38,7 @@
>> #include "standard-headers/asm-m68k/bootinfo.h"
>> #include "standard-headers/asm-m68k/bootinfo-mac.h"
>> #include "bootinfo.h"
>> +#include "hw/m68k/q800.h"
>> #include "hw/misc/mac_via.h"
>> #include "hw/input/adb.h"
>> #include "hw/nubus/mac-nubus-bridge.h"
>> @@ -749,6 +750,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>> static const TypeInfo q800_machine_typeinfo = {
>>     .name       = MACHINE_TYPE_NAME("q800"),
>>     .parent     = TYPE_MACHINE,
>> +    .instance_size = sizeof(Q800MachineState),
>>     .class_init = q800_machine_class_init,
>> };
>>
>> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
>> new file mode 100644
>> index 0000000000..f3bc17aa1b
>> --- /dev/null
>> +++ b/include/hw/m68k/q800.h
> 
> Why is this defined in a public header? Moving struct definitions of devices to allow 
> them to be embedded in other structs makes sense but is there ever a reason to embed 
> a machine state anywhere else than using it in q800.c? I don't think so, thus to 
> preserve locality and save some lines in this series I think this machine state 
> should just be in q800.c like I have similar struct in pegasos2.c. It may only make 
> sense to put it in a header if q800.c was split up to multiple files but even then it 
> should be a local header in hw/m68k and not a public header in my opinion.

This is just following our standard guidelines since MachineState is a QOM object of 
TYPE_MACHINE. Note that there are also a number of existing examples of this 
currently within the QEMU tree.


ATB,

Mark.


