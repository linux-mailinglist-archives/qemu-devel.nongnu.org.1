Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7143B7F16D5
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 16:11:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55vH-0001B1-9t; Mon, 20 Nov 2023 10:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r55vE-00017k-OA; Mon, 20 Nov 2023 10:10:48 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r55vC-00021z-8M; Mon, 20 Nov 2023 10:10:48 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B4D6E75A4BE;
 Mon, 20 Nov 2023 16:11:19 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A8DD275A406; Mon, 20 Nov 2023 16:11:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A6D40756094;
 Mon, 20 Nov 2023 16:11:19 +0100 (CET)
Date: Mon, 20 Nov 2023 16:11:19 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kevin Wolf <kwolf@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 shentey@gmail.com, Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <ZVt0B1pSsWWK7ReX@redhat.com>
Message-ID: <085a9043-6850-0022-1f7c-ebf365b5570c@eik.bme.hu>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
 <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
 <ZVtiV8XXHxS+cw8o@redhat.com>
 <b9ea9c20-f9a5-9b79-6e70-624665fb5148@eik.bme.hu>
 <ZVt0B1pSsWWK7ReX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 20 Nov 2023, Kevin Wolf wrote:
> Am 20.11.2023 um 14:47 hat BALATON Zoltan geschrieben:
>> On Mon, 20 Nov 2023, Kevin Wolf wrote:
>>> Am 20.11.2023 um 14:09 hat BALATON Zoltan geschrieben:
>>>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>>>> The only difference I can think of regarding the BAR zeroing is that the
>>>>> BMDMA BAR is zeroed here. Does the following diff fix things?
>>>>
>>>> This helps, with this the latest driver does not crash but still reads BAR4
>>>> as 0 instead of 0xcc00 so UDMA won't work but at least it boots.
>>>
>>> And disabling only the first four BARs is actually what the spec says,
>>> too. So I'll make this change to the queued patches.
>>>
>>> If I understand correctly, UDMA didn't work before this series either,
>>> so it's a separate goal and doing it in its own patch is best anyway.
>>
>> UDMA works with my original series, did not work with earlier versions of
>> this alternative from Mark but could be fixed up on top unless Mark can send
>> a v4 now.
>>
>>> As we don't seem to have a good place to set a default, maybe just
>>> overriding it in via_ide_cfg_read(), too, and making it return 0xcc01 in
>>> compatibility mode is enough?
>>
>> I could give that a try and see if that helps but all this
>> via_ide_cfg_read() seems like an unnecessary complication to me. Why can't
>> we just set the BARs (o for BAR1-3 and default for BAR4) then we don't need
>> to override config read?
>
> I would be fine with setting 0xcc00 as the default value for BAR 4, but
> as you said yourself, we can't do that in reset because it will be
> overwritten by the PCI core code. Where else could we meaningfully do
> that? As far as I understand, we don't have any hint that the
> native/compatibility mode switch resets it on real hardware, so I'm
> hesitant to do it there (and if the guest OS doesn't even switch, it
> would never get set).

Luckily machines which need legacy mode also seem to set it explicitly on 
startup so we can set the defaults there. The check to see if something 
changed the BARs before is enough to avoid breaking it when legacy mode is 
set after native mode which does not seem to reset BARs according to how 
pegasos2 Linux behaves that sets legacy mode after firmware set native and 
proframmed BARs but the keep using BAR addresses. The AmigaOne I think 
just uses the default values with setting legacy mode doing nothing as 
that's the default but we can detect this as setting legacy mode with BARs 
unset so that's a good place to set default values which is what my patch 
did and I added a lot of comments trying to explain this.

> As for BAR 0-3, didn't we conclude that the via device still accepts I/O
> to the configured addresses even though they read as zeros? Having
> inconsistent config space and PCIIORegion seems like a bad idea, the
> next call to pci_update_mappings() would break it.

I don't quite get this but then we could also just leave BARs alone and it 
would still work. It probably does not matter what it reads back when the 
device is in legacy mode. What would call pci_update_mappings() if device 
is in legacy and if something switches it to native it will very likely 
also program BARs. I can't imagine what would want to turn on native mode 
without trying to use a PCI driver and program BARs.

Regards,
BALATON Zoltan

