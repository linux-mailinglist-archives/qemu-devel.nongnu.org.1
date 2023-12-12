Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4821580F9E7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 23:05:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDArV-0006QL-1y; Tue, 12 Dec 2023 17:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDArB-0006Pi-W9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 17:04:02 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rDAr7-0001RQ-1c
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 17:04:00 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 167F075A4DC;
 Tue, 12 Dec 2023 23:03:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id UnfrqF1B1Nqz; Tue, 12 Dec 2023 23:03:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DDD0275A4DB; Tue, 12 Dec 2023 23:03:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC2E075A4D3;
 Tue, 12 Dec 2023 23:03:51 +0100 (CET)
Date: Tue, 12 Dec 2023 23:03:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Marek Glogowski <smarkusg@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Subject: Re: Inconsistent qemu-system-ppc speed on Apple M1 (was: Re: [PATCH
 v6] ui/cocoa: Use NSWindow's ability to resize)
In-Reply-To: <CAFEAcA8vsBDyG6rSVnHg7vMLJkQeHNFbLtdwhQRGCNRv8Lra0w@mail.gmail.com>
Message-ID: <e766249d-f7b6-87fd-cf7e-204519da0adb@eik.bme.hu>
References: <bea2e165-5203-5b9c-f36e-4c9fc91b9447@eik.bme.hu>
 <CAFEAcA8vsBDyG6rSVnHg7vMLJkQeHNFbLtdwhQRGCNRv8Lra0w@mail.gmail.com>
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

On Tue, 12 Dec 2023, Peter Maydell wrote:
> On Tue, 12 Dec 2023 at 18:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> On Tue, 12 Dec 2023, Marek Glogowski wrote:
>>> Additionally, how can I use this message on qemu-devel.
>>> It has a post for people who use Macos or Asahi Linux. Verify random qemu
>>> sessions under Macos .Some are faster others are slow.
>>> The topic is posted on qemu-discuss@nongnu.org (I don't know if developers
>>> look there often)
>>>
>>> https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html
>>>
>>> The program posted there was prepared by one of the maintainers of ppc qemu
>>> machines "BALATON Zoltan".
>>>
>>> We are starting to gather as much information as possible for it.
>>> I hope nobody will be offended about this information in this topic. I do
>>> not want to start a topic and litter other lists
>>
>> It's better to do that in a separate thead, I've changed the subject
>> accordingly. I only came up with the idea and scripted it but the actual
>> test case comes from Marek and the original report from Rene Engel.
>>
>> This problem was first seen running AmigaOS with qemu-system-ppc but then
>> we also reproduced it with Linux guest with the test in the qemu-discuss
>> messgage linked above. The runs are not exactly random but there seem to
>> be slow and fast sessions with the slow one about half the expected speed.
>> If we get a fast or slow session seems to be random. This was seen on
>> Apple M1 and Apple M1 Max under macOS but could not reproduce on x86_64
>> host under Linux or Apple M2 host under Linux so it may either be related
>> to Apple M1 or macOS host.
>
> Is this possibly related to https://gitlab.com/qemu-project/qemu/-/issues/334
> where App Nap is reported as causing QEMU to slow down when the window
> doesn't have focus, or does it happen even when the QEMU window has
> focus the whole time the benchmark is running ?

Yes, the original test which found it was running Quake timedemo on 
AmgiaOS with QEMU running in foreground and that does a lot of what is 
listed to prevent App Nap such as playing sound and doing graphics. Also 
the sessions are either fast or slow from the start, they don't start fast 
then become slow but sometimes run fast while most of the time they are 
slow and this happens randomly when starting the same command multiple 
times in a row as the scripted test that runs lame to encode mp3 with 
Linux guest does. So this does not seem related to App Nap to me. It did 
not seem to happen on Linux host even on Apple M2 but more testing with 
those might be needed to confirm that.

Regards,
BALATON Zoltan

