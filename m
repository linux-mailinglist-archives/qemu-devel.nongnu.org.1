Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B797D579E
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:12:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvK0T-0000KA-O3; Tue, 24 Oct 2023 12:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvK0R-0000F5-Em; Tue, 24 Oct 2023 12:11:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvK0O-0006Xg-Ii; Tue, 24 Oct 2023 12:11:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AC784756062;
 Tue, 24 Oct 2023 18:11:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 702F77456A7; Tue, 24 Oct 2023 18:11:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6D643745681;
 Tue, 24 Oct 2023 18:11:41 +0200 (CEST)
Date: Tue, 24 Oct 2023 18:11:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v3 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <CWAEWI5YNWTD.11GO4ENF2OC5M@wheely>
Message-ID: <43e44ce6-2d80-57f7-4e33-b7b423d158db@eik.bme.hu>
References: <cover.1697311794.git.balaton@eik.bme.hu>
 <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
 <CWAEWI5YNWTD.11GO4ENF2OC5M@wheely>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-896184455-1698163901=:17080"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-896184455-1698163901=:17080
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Oct 2023, Nicholas Piggin wrote:
> On Tue Oct 17, 2023 at 8:25 AM AEST, BALATON Zoltan wrote:
>> On Sat, 14 Oct 2023, BALATON Zoltan wrote:
>>> Changes in v3:
>>> - Update values, comment and commit message in patch 1 again
>>>
>>> Changes in v2:
>>> - Update comment and commit message in patch 1 (Mark)
>>> - Fix irq mapping in patch 2 (Volker)
>>>
>>> Regards,
>>> BALATON Zoltan
>>>
>>> BALATON Zoltan (3):
>>>  via-ide: Fix legacy mode emulation
>>>  hw/pci-host: Add emulation of Mai Logic Articia S
>>>  hw/ppc: Add emulation of AmigaOne XE board
>>
>> Nick, Daniel, Cédric,
>>
>> Patch 1 is not related to PPC and is still debated but just to make sure
>> we don't get too close to freeze again I ask about patch 2 and 3 in the
>> maintime. Not sure who will merge this series at the end but if you can
>> give an Acked-by for the last two patches maybe Philippe can take care of
>> the series or is any of you plan to take it via ppc?
>
> Hey,
>
> I could take patch 2/3 via ppc tree, although I don't know much about
> platform and pci so some review/ack would be good.
>
> I guess you could submit the Amiga stuff yourself too if you wanted,
> you have much better understanding of it and I don't really know how to
> test either (other than a few of the free to download installer images
> for one or two of those OSes).

I can't send pull requests, don't have a signing key and never did that. 
So far it worked by submitting patches and the ppc maintainer merging them 
so I'd stay with that work flow. I'm listed as maintainer so if there's 
some problem with these machines I'll look to fix them and I try to 
make sure these work so you'd only need to do usual integration testing 
before pull and don't have to take responsibility for these machines 
otherwise.

Currently Mark wanted an alternative approach instead of patch 1 which was 
tested so just waiting for him to finalise that then remaining patch 2-4 
from latest version of this series (v5) should apply but I can resubmit 
that as v6 with a Based-on: tag if that helps.

I don't know who will metge Mark's series, Philippe seems to have some IDE 
patches queued so maybe he can take that too then might as well take this 
series if you give an Acked-by for it.

Regards,
BALATON Zoltan
--3866299591-896184455-1698163901=:17080--

