Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C250D809111
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 20:12:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBJlu-0005Vt-CF; Thu, 07 Dec 2023 14:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rBJlV-0005Q3-QC
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 14:10:30 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rBJlS-00054P-KY
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 14:10:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4557975A4BC;
 Thu,  7 Dec 2023 20:10:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id IXLez3bKPGXV; Thu,  7 Dec 2023 20:10:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0843675A406; Thu,  7 Dec 2023 20:10:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 06A2C756094;
 Thu,  7 Dec 2023 20:10:21 +0100 (CET)
Date: Thu, 7 Dec 2023 20:10:21 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: aziz tlili <aziztlili2222@gmail.com>, qemu-devel@nongnu.org
Subject: Re: Request for New PPC Machine Supporting Multiple SMP Cores
In-Reply-To: <CAFEAcA-1zqY51hLh029-n_SdArf++TEdeo82Fj6YJx7miR3Ocg@mail.gmail.com>
Message-ID: <bf3c7437-9c67-3b42-0e0e-5929b16f73f8@eik.bme.hu>
References: <CAHwHw5A6g428uTpMEQ=NCkXP7sXVfCWv5QSUw3pHfncmG-2gPA@mail.gmail.com>
 <5f2068a4-955a-9d16-347d-4d2771b78aa8@eik.bme.hu>
 <CAFEAcA-1zqY51hLh029-n_SdArf++TEdeo82Fj6YJx7miR3Ocg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Thu, 7 Dec 2023, Peter Maydell wrote:
> On Thu, 7 Dec 2023 at 17:40, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Thu, 7 Dec 2023, aziz tlili wrote:
>>> Dear QEMU Team,
>>>
>>> I hope this message finds you well. I've been a user of QEMU for well over
>>> a year.
>>>
>>> I wanted to share an idea for a potential enhancement that I believe could
>>> benefit many users, including myself. It would be fantastic to have a new
>>> PPC machine model similar to the existing mac99, but with support for
>>> multiple SMP cores for both qemu-system-ppc and qemu-system-ppc64.
>>
>> There are several machines in qemu-system-ppc64 that support SMP such as
>> pseries and powernv I think. For qemu-system-ppc maybe only ppce500. The
>> mac99 may create multiple CPUs (G4 when ron with qemu-system-ppc or G5
>> with qemu-system-ppc64) but not sure if there's an OS that can actually
>> use that. Linux support for mac99 may not be the best.
>
> I think our mac99 machine refuses to create more than one CPU, because
> it sets mc->max_cpus to 1 in core99_machine_class_init(). This in

Right. I remembered there was some quirk about that but it still has a 
loop when creating CPUs that's then apparently disabled. I've tried to 
send patches before to detangle this machine a bit as it also behaves 
differently depending if it's called from qemu-system-ppc or 
qemu-system-ppc64 or if machine properties are set which can be confusing 
but we could not agree on some naming so those patches were dropped at the 
end.

> turn is probably because nobody has ever implemented and tested
> whatever the SMP support handling would need to be for this machine
> type.

It's likely that chipset support needed for SMP is missing although not 
sure how much of that would Linux need. So for now better try the others 
I've mentioned which may work better than mac99.

>> Problem is not in understanding the potential advantages but the lack of
>> people interested in working on that so progress depends on somebody doing
>> it and sending patches.
>
> Entirely agreed. This is a feature request from two years ago about
> adding SMP support to the newworld machines:
> https://gitlab.com/qemu-project/qemu/-/issues/672
> Nobody has done that work in two years, but anybody who has the
> interest and time to do so is welcome to.

One thing that makes it a bit difficult is that there aren't much 
documentation available so those interested may need to consult Linux and 
XNU sources to find out what would need to be emulated.

Regards,
BALATON Zoltan

