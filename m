Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11417BD97A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoLj-0003TF-Tp; Mon, 09 Oct 2023 07:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpoLh-0003Sy-W3; Mon, 09 Oct 2023 07:22:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpoLg-0007me-F6; Mon, 09 Oct 2023 07:22:57 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 958D5757234;
 Mon,  9 Oct 2023 13:22:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5A810757206; Mon,  9 Oct 2023 13:22:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 580447571FE;
 Mon,  9 Oct 2023 13:22:02 +0200 (CEST)
Date: Mon, 9 Oct 2023 13:22:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Bernhard Beschow <shentey@gmail.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH 1/3] via-ide: Fix legacy mode emulation
In-Reply-To: <3E7FF238-D512-4AC7-AF6B-C03C22E8FFED@gmail.com>
Message-ID: <c0c762fa-8b2b-9851-51ba-92507ca059a7@eik.bme.hu>
References: <cover.1696542537.git.balaton@eik.bme.hu>
 <12ce9caa682545cd43318c4679530202140117c0.1696542537.git.balaton@eik.bme.hu>
 <33347356-be91-4dde-8535-5a59ee1c80f1@ilande.co.uk>
 <a7821bf0-5d1f-ddda-f408-f4cd0432ddbf@eik.bme.hu>
 <3E7FF238-D512-4AC7-AF6B-C03C22E8FFED@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Mon, 9 Oct 2023, Bernhard Beschow wrote:
> Am 8. Oktober 2023 11:08:58 UTC schrieb BALATON Zoltan <balaton@eik.bme.hu>:
>> On Sun, 8 Oct 2023, Mark Cave-Ayland wrote:
>>> On 05/10/2023 23:13, BALATON Zoltan wrote:
>>>
>>>> The initial value for BARs were set in reset method for emulating
>>>> legacy mode at start but this does not work because PCI code resets
>>>> BARs after calling device reset method.
>>>
>>> This is certainly something I've noticed when testing previous versions of the VIA patches. Perhaps it's worth a separate thread to the PCI devs?
>>
>> I think I brought up this back then but was told current PCI code won't change and since that could break everything else that makes sense so this is something that we should take as given and accomodate that.
>
> Why not play safe like:
> 1. add a class property such as `reset_bar_addrs[PCI_NUM_REGIONS]`
> 2. set all elements to zero in `pci_device_class_init()`
> 3. respect `reset_bar_addrs` in `pci_reset_regions()`
> 4. assign the proper reset addresses of TYPE_VIA_IDE in `via_ide_class_init()`
>
> That would pretty obviously preserve the behavior of existing device 
> models while allowing TYPE_VIA_IDE to be reset properly. It would also 
> perform the main part of the workaround in the code that exhibits the 
> limitation, so the code could potentially be simplified at some point 
> without impacting all PCI device models.

That's a lot of complication for setting some values that will be 
overwritten first thing after reset. Either the guest sets native mode and 
writes the BARs itself so the reset values don't matter or it sets legacy 
mode when the workaround has to set legacy ports (that strangely don't 
match the reset values of the BARs) so sticking to those reset values 
makes no sense to me as it does not help to run any guest just makes the 
code more complex and harder to understand for no reason. So the patch 
with clarified comment as Mark asked should do for now. I'll send that in 
v2 later.

Regards,
BALATON Zoltan

