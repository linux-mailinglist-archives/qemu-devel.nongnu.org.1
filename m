Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DA7CCBEF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspTt-00028d-Ay; Tue, 17 Oct 2023 15:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qspTq-00022M-L2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:11:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qspTo-0002NX-D6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:11:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 58190757206;
 Tue, 17 Oct 2023 21:10:38 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1D4857571FA; Tue, 17 Oct 2023 21:10:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1B62A75715B;
 Tue, 17 Oct 2023 21:10:38 +0200 (CEST)
Date: Tue, 17 Oct 2023 21:10:38 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Helge Deller <deller@gmx.de>
cc: deller@kernel.org, qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 04/11] MAINTAINERS: Add Astro PCI host for hppa machines
In-Reply-To: <e6dbd713-36ee-417e-93ff-026edd4e5592@gmx.de>
Message-ID: <8ffce91c-00ab-2c56-823d-47ed0dd18e7a@eik.bme.hu>
References: <20231017154645.95844-1-deller@kernel.org>
 <20231017154645.95844-5-deller@kernel.org>
 <9a52309d-d5af-d572-aea0-e5315b301e3e@eik.bme.hu>
 <e6dbd713-36ee-417e-93ff-026edd4e5592@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 17 Oct 2023, Helge Deller wrote:
> On 10/17/23 18:19, BALATON Zoltan wrote:
>> On Tue, 17 Oct 2023, deller@kernel.org wrote:
>>> From: Helge Deller <deller@gmx.de>
>>> 
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>> MAINTAINERS | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> Is this better squashed in the previous patch adding this device?
>
> MAINTAINERS is updated by various patches/people, so keeping
> this change seperate makes handling and bisecting easier.
>
>> Then checkpatch won't complain about that
>
> It's just a warning, IMHO similiar to a reminder to update it.
>
>> and splitting out just this does not make the previous patch simpler > so 
>> not sure it should be separate patch.
>
> I disagree.

OK, I don't mind much if it's a separate patch either just did not make 
much sense to me to separate it from the patch that adds the files.

Regards,
BALATON Zoltan

>> The last line adding seabios is not mentioned in commit message.
>> Is that related ot just a fixup while you're there.
>
> Yes, I noticed that this directory was missing.
> So, I added it while updating the entries.
> IMHO this additional change is so trivial that I don't think it needs to be
> mentioned.
>
> Helge
>
>> Regards,
>> BALATON Zoltan
>> 
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index ceea4c2bf2..68d086a0f3 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -1174,7 +1174,7 @@ F: hw/*/etraxfs_*.c
>>> 
>>> HP-PARISC Machines
>>> ------------------
>>> -HP B160L
>>> +HP B160L, HP C3700
>>> M: Richard Henderson <richard.henderson@linaro.org>
>>> R: Helge Deller <deller@gmx.de>
>>> S: Odd Fixes
>>> @@ -1182,11 +1182,14 @@ F: configs/devices/hppa-softmmu/default.mak
>>> F: hw/hppa/
>>> F: hw/net/*i82596*
>>> F: hw/misc/lasi.c
>>> +F: hw/pci-host/astro.c
>>> F: hw/pci-host/dino.c
>>> F: include/hw/misc/lasi.h
>>> F: include/hw/net/lasi_82596.h
>>> +F: include/hw/pci-host/astro.h
>>> F: include/hw/pci-host/dino.h
>>> F: pc-bios/hppa-firmware.img
>>> +F: roms/seabios-hppa/
>>> 
>>> LoongArch Machines
>>> ------------------
>>> 
>> 
>
>

