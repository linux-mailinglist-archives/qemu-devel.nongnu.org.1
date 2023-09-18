Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E7E7A4893
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 13:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiCat-0004JH-SS; Mon, 18 Sep 2023 07:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiCas-0004Hs-3v; Mon, 18 Sep 2023 07:39:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KtGU=FC=kaod.org=clg@ozlabs.org>)
 id 1qiCap-0002ve-LM; Mon, 18 Sep 2023 07:39:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rq2r65jPcz4x5m;
 Mon, 18 Sep 2023 21:39:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rq2r40vPnz4x5h;
 Mon, 18 Sep 2023 21:38:59 +1000 (AEST)
Message-ID: <ed55c276-7950-efa2-b7c8-5280726a3d66@kaod.org>
Date: Mon, 18 Sep 2023 13:38:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, groug@kaod.org,
 aik@ozlabs.ru
References: <20230915110507.194762-1-danielhb413@gmail.com>
 <CVLS27TKE0YM.3DW0F4YAP5BFA@wheely>
 <b86077f1-7078-722d-50e2-d1f97951ba83@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <b86077f1-7078-722d-50e2-d1f97951ba83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=KtGU=FC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 9/18/23 12:31, Daniel Henrique Barboza wrote:
> 
> 
> On 9/18/23 02:01, Nicholas Piggin wrote:
>> Hi Daniel,
>>
>> Thank you for your stwardship of ppc, I might hope to do half as good a
>> job with it as you have. And to Greg and David for all the work over the
>> years.
> 
> I'm pretty sure you'll be great :D and both Cedric and I will be around if
> you need assistance.

Yes, consider us as backups for the QEMU PPC project.

Cheers,

C.

> 
> 
> Thanks,
> 
> Daniel
> 
>>
>> Thanks,
>> Nick
>>
>> On Fri Sep 15, 2023 at 9:05 PM AEST, Daniel Henrique Barboza wrote:
>>> Update all relevant PowerPC entries as follows:
>>>
>>> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>>>    Nick has  been a solid contributor for the last couple of years and
>>>    has the required knowledge and motivation to drive the boat.
>>>
>>> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>>>    to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>>>    Kurz for all the years of service.
>>>
>>> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>>>    KVM CPUs. Change done per his request.
>>>
>>> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>>>    PPC KVM CPUs. It has been a long since I last touched those areas and
>>>    it's not justified to be kept as maintainer in them.
>>>
>>> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>>>    don't have the required knowledge to justify it.
>>>
>>> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>>>    better reflects the current state of the subsystem.
>>>
>>> Acked-by: Cédric Le Goater <clg@kaod.org>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> ---
>>>   MAINTAINERS | 20 +++++++-------------
>>>   1 file changed, 7 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 00562f924f..c4aa1c1c9f 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -298,11 +298,9 @@ F: hw/openrisc/
>>>   F: tests/tcg/openrisc/
>>>   PowerPC TCG CPUs
>>> +M: Nicholas Piggin <npiggin@gmail.com>
>>>   M: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>   R: Cédric Le Goater <clg@kaod.org>
>>> -R: David Gibson <david@gibson.dropbear.id.au>
>>> -R: Greg Kurz <groug@kaod.org>
>>> -R: Nicholas Piggin <npiggin@gmail.com>
>>>   L: qemu-ppc@nongnu.org
>>>   S: Odd Fixes
>>>   F: target/ppc/
>>> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>>>   F: target/mips/sysemu/
>>>   PPC KVM CPUs
>>> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> +M: Nicholas Piggin <npiggin@gmail.com>
>>> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>   R: Cédric Le Goater <clg@kaod.org>
>>> -R: David Gibson <david@gibson.dropbear.id.au>
>>> -R: Greg Kurz <groug@kaod.org>
>>>   S: Odd Fixes
>>>   F: target/ppc/kvm.c
>>> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>>>   F: tests/avocado/ppc_prep_40p.py
>>>   sPAPR (pseries)
>>> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> +M: Nicholas Piggin <npiggin@gmail.com>
>>> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>   R: Cédric Le Goater <clg@kaod.org>
>>>   R: David Gibson <david@gibson.dropbear.id.au>
>>> -R: Greg Kurz <groug@kaod.org>
>>>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>>   L: qemu-ppc@nongnu.org
>>>   S: Odd Fixes
>>> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
>>>   PowerNV (Non-Virtualized)
>>>   M: Cédric Le Goater <clg@kaod.org>
>>> +M: Nicholas Piggin <npiggin@gmail.com>
>>>   R: Frédéric Barrat <fbarrat@linux.ibm.com>
>>> -R: Nicholas Piggin <npiggin@gmail.com>
>>>   L: qemu-ppc@nongnu.org
>>>   S: Odd Fixes
>>>   F: docs/system/ppc/powernv.rst
>>> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
>>>   Virtual Open Firmware (VOF)
>>>   M: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> -R: Cédric Le Goater <clg@kaod.org>
>>> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>>>   R: David Gibson <david@gibson.dropbear.id.au>
>>> -R: Greg Kurz <groug@kaod.org>
>>>   L: qemu-ppc@nongnu.org
>>> -S: Maintained
>>> +S: Odd Fixes
>>>   F: hw/ppc/spapr_vof*
>>>   F: hw/ppc/vof*
>>>   F: include/hw/ppc/vof*
>>


