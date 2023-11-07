Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE9D7E4652
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:42:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0P91-0003O5-1D; Tue, 07 Nov 2023 11:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0P8z-0003LA-2T; Tue, 07 Nov 2023 11:41:37 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0P8v-0002Zm-GE; Tue, 07 Nov 2023 11:41:35 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7383675A4BE;
 Tue,  7 Nov 2023 17:41:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6825D75A4B8; Tue,  7 Nov 2023 17:41:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6626675A4B9;
 Tue,  7 Nov 2023 17:41:46 +0100 (CET)
Date: Tue, 7 Nov 2023 17:41:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, clg@kaod.org, philmd@linaro.org, 
 Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <aec69746-9cc6-4be4-bd06-2315886c2a1e@gmail.com>
Message-ID: <667ec305-4f58-133e-d60b-89babb183f91@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
 <88d6fff6-b97e-7c55-bf29-6d3aa2ed690d@eik.bme.hu>
 <8cd19dfe-d4cb-ad71-c99e-51741ab71e44@eik.bme.hu>
 <360e5b93-3b80-04b1-2dbf-2fd95809859c@eik.bme.hu>
 <aec69746-9cc6-4be4-bd06-2315886c2a1e@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1931393892-1699375306=:93891"
X-Virus-Scanned: ClamAV using ClamSMTP
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1931393892-1699375306=:93891
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 7 Nov 2023, Daniel Henrique Barboza wrote:
> On 11/7/23 11:42, BALATON Zoltan wrote:
>> On Tue, 7 Nov 2023, BALATON Zoltan wrote:
>>> On Mon, 6 Nov 2023, BALATON Zoltan wrote:
>>>> On Fri, 27 Oct 2023, BALATON Zoltan wrote:
>>>>> Changes in v7:
>>>>> - Increase default memory size to 512m to match pegasos2 and sam460ex
>>>>> and it's a better default for AmigaOS
>>>>> 
>>>>> Changes in v6:
>>>>> - Dropped patch 1, now it's
>>>>> 
>>>>> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>>>>> 
>>>>> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for 
>>>>> PCI IDE controllers)
>>>>> - Added Tested-by from Rene
>>>>> 
>>>>> Changes in v5:
>>>>> - Fixed avocado test
>>>>> 
>>>>> Changes in v4:
>>>>> - Found typo in comment in patch 1 so ended up rewording it again
>>>>> trying to make it more concise. Also take the idea of using
>>>>> range_covers_byte from Mark's patch
>>>>> - Added RFC patch for avocado test (untested, I don't have Avocado)
>>>>> 
>>>>> Changes in v3:
>>>>> - Update values, comment and commit message in patch 1 again
>>>>> 
>>>>> Changes in v2:
>>>>> - Update comment and commit message in patch 1 (Mark)
>>>>> - Fix irq mapping in patch 2 (Volker)
>>>>> 
>>>>> Regards,
>>>>> BALATON Zoltan
>>>>> 
>>>>> BALATON Zoltan (3):
>>>>>  hw/pci-host: Add emulation of Mai Logic Articia S
>>>>>  hw/ppc: Add emulation of AmigaOne XE board
>>>>>  tests/avocado: Add test for amigaone board
>>>> 
>>>> Nick,
>>>> 
>>>> Will you please send a pull request with this now? It's independent of 
>>>> the IDE fix which as a bugfix so can wait a little more but this series 
>>>> should be merged before the freeze starts tomorrow. (As this adds a new 
>>>> machine and does not touch anything else it can't break anything either.)
>>> 
>>> Is there a PPC pull request in the making with this series in it? It would 
>>> be really sad to miss the release not being able to merge such a simple 
>>> series for weeks. As I said this is independent of any other fixes so I'd 
>>> like to get this in now please.
>> 
>> Nick seems to be away so please Cédric, Daniel, Phil or whoever can send a 
>> pull request step in and please take care of this. This was posted a month 
>> ago with this last version on the list for 1.5 week so I'd hate to miss the 
>> release and wait until Easter next year to get this out to users because 
>> none of the maintainers are available before and arounf the freeze.
>
> Wait, do you think we would miss code freeze?
>
> Code freeze in QEMU is a blast! People getting mad because stuff got 
> left behind, PRs getting remade over and over because gitlab is nagging 
> about something, new bugs introduced, sometimes master doesn't even 
> build the following week. We might miss any other boring date like 
> release date or something, but code freeze? Nah, we're right here man.

OK, cool, thanks a lot. I was just worried that there was no answer that 
somebody is working on this and wanted to make sure it won't be missed. If 
it's being taken care of then sorry to bug you but had to make sure it 
won't get lost in the noise with all the things happening in last minute.

> The reason why we didn't interfere is because it's rude to short-circuit 
> the maintainer on duty. Nick didn't send an email asking for help, so we 
> were just monitoring.
>
> I'll consider Nick AWOL and take this PR. And don't worry, it's still 
> sunny in Brazil, we have plenty of time.

Good. It's dark and cold here and Stefan already sent a message hours ago 
when it was evening for him but glad to hear its bright in Brazil, I was 
still hoping for that. :-)

Regards,
BALATON Zoltan

>
>
> Thanks,
>
> Daniel
>
>> 
>> Regards,
>> BALATON Zoltan
>> 
>>>>> MAINTAINERS                             |   8 +
>>>>> configs/devices/ppc-softmmu/default.mak |   1 +
>>>>> hw/pci-host/Kconfig                     |   5 +
>>>>> hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>>>>> hw/pci-host/meson.build                 |   2 +
>>>>> hw/ppc/Kconfig                          |   7 +
>>>>> hw/ppc/amigaone.c                       | 164 +++++++++++++
>>>>> hw/ppc/meson.build                      |   2 +
>>>>> include/hw/pci-host/articia.h           |  17 ++
>>>>> tests/avocado/ppc_amiga.py              |  38 +++
>>>>> 10 files changed, 537 insertions(+)
>>>>> create mode 100644 hw/pci-host/articia.c
>>>>> create mode 100644 hw/ppc/amigaone.c
>>>>> create mode 100644 include/hw/pci-host/articia.h
>>>>> create mode 100644 tests/avocado/ppc_amiga.py
>>>>> 
>>>>> 
>>>> 
>>>> 
>>> 
>
>
--3866299591-1931393892-1699375306=:93891--

