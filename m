Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E1FAA64AF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 22:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAaPe-0002Oq-0l; Thu, 01 May 2025 16:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAaPX-0002MG-JE; Thu, 01 May 2025 16:21:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAaPU-0007uo-W6; Thu, 01 May 2025 16:21:35 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C1A5655D25C;
 Thu, 01 May 2025 22:21:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id dQ7pYLcRGhRs; Thu,  1 May 2025 22:21:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C48AE55D25A; Thu, 01 May 2025 22:21:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C0732745683;
 Thu, 01 May 2025 22:21:26 +0200 (CEST)
Date: Thu, 1 May 2025 22:21:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/3] hw/pci-host/designware: Remove unused include
In-Reply-To: <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
Message-ID: <01dbe30f-5ef7-c76d-59dd-d05bbce2029d@eik.bme.hu>
References: <20250501183445.2389-1-shentey@gmail.com>
 <20250501183445.2389-2-shentey@gmail.com>
 <e7088647-aa76-4f64-b443-0ca354df8f24@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-236068682-1746130886=:40469"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-236068682-1746130886=:40469
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 May 2025, Philippe Mathieu-Daudé wrote:
> On 1/5/25 20:34, Bernhard Beschow wrote:
>> The DEFINE_TYPES() macro doesn't need the qemu/module.h include.
>> 
>> Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types using
>> DEFINE_TYPES() macro")
>
> The 'Fixes:' tag is for bug being fixed. Here I suggest:

Wasn't that Resolves: that's used for bugs or Buglink: and Fixes: to 
refer to commits this fixes up? I thought we used Fixes: like that until 
now.

Regards,
BALATON Zoltan

>  Since commit 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM
>  types using DEFINE_TYPES() macro") which removed the type_init() use,
>  we don't need to include "qemu/module.h" anymore.
>
> (I can do the update when applying if you agree).
>
>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>> ---
>>   hw/pci-host/designware.c | 1 -
>>   1 file changed, 1 deletion(-)
>> 
>> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>> index 183f838392..b4bff14579 100644
>> --- a/hw/pci-host/designware.c
>> +++ b/hw/pci-host/designware.c
>> @@ -20,7 +20,6 @@
>>     #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> -#include "qemu/module.h"
>>   #include "qemu/log.h"
>>   #include "qemu/bitops.h"
>>   #include "hw/pci/msi.h"
>
> $ git grep -L type_init $(git grep -l qemu/module.h hw) | wc -l
>      50
>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>
>
--3866299591-236068682-1746130886=:40469--

