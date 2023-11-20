Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED677F1692
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:59:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r55ic-0007GI-MV; Mon, 20 Nov 2023 09:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r55iZ-0007Fa-Rn; Mon, 20 Nov 2023 09:57:44 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r55iW-0002dL-Ev; Mon, 20 Nov 2023 09:57:43 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3B0975A4BE;
 Mon, 20 Nov 2023 15:58:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E8A5075A4BA; Mon, 20 Nov 2023 15:58:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E651575A4C2;
 Mon, 20 Nov 2023 15:58:10 +0100 (CET)
Date: Mon, 20 Nov 2023 15:58:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com, 
 Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <b61f2cce-068f-4130-8c0d-fea80e7026d1@ilande.co.uk>
Message-ID: <8b508004-ab00-128e-4bcd-231be3d7f201@eik.bme.hu>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <6e7576bd-ac39-424e-ac7e-898c58a6a2fa@ilande.co.uk>
 <3c442b7f-4f9e-5adf-e576-8f2930834bd3@eik.bme.hu>
 <a0a01470-c059-6a0f-21af-32ed43357c25@eik.bme.hu>
 <b61f2cce-068f-4130-8c0d-fea80e7026d1@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1949590591-1700492290=:13137"
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

--3866299591-1949590591-1700492290=:13137
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
> On 20/11/2023 13:30, BALATON Zoltan wrote:
>> On Mon, 20 Nov 2023, BALATON Zoltan wrote:
>>> On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
>>>> On 19/11/2023 21:43, BALATON Zoltan wrote:
>>>>> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
>>>>>> This series adds a simple implementation of legacy/native mode 
>>>>>> switching for PCI
>>>>>> IDE controllers and updates the via-ide device to use it.
>>>>>> 
>>>>>> The approach I take here is to add a new pci_ide_update_mode() function 
>>>>>> which handles
>>>>>> management of the PCI BARs and legacy IDE ioports for each mode to 
>>>>>> avoid exposing
>>>>>> details of the internal logic to individual PCI IDE controllers.
>>>>>> 
>>>>>> As noted in [1] this is extracted from a local WIP branch I have which 
>>>>>> contains
>>>>>> further work in this area. However for the moment I've kept it simple 
>>>>>> (and
>>>>>> restricted it to the via-ide device) which is good enough for Zoltan's 
>>>>>> PPC
>>>>>> images whilst paving the way for future improvements after 8.2.
>>>>>> 
>>>>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>>>> 
>>>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>>>>> 
>>>>>> v3:
>>>>>> - Rebase onto master
>>>>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent 
>>>>>> duplication in
>>>>>>  hw/ide/pci.c
>>>>>> - Don't zero BARs when switching from native mode to legacy mode, 
>>>>>> instead always force
>>>>>>  them to read zero as suggested in the PCI IDE specification (note: 
>>>>>> this also appears
>>>>>>  to fix the fuloong2e machine booting from IDE)
>>>>> 
>>>>> Not sure you're getting this, see also:
>>>>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
>>>>> but this seems to break latest version of the AmigaOS driver for some 
>>>>> reason. I assume this is the BAR zeroing that causes this as it works 
>>>>> with v2 series and nothing else changed in v3 that could cause this. 
>>>>> Testing was done by Rene Engel, cc'd so maybe he can add more info. It 
>>>>> seems to work with my patch that sets BARs to legacy values and with v2 
>>>>> that sets them to 0 but not with v3 which should also read 0 but maybe 
>>>>> something is off here.
>>>> 
>>>> Is this document here accurate as to how it works on real hardware? 
>>>> https://intuitionbase.com/hints.php.
>>> 
>>> That should be about right. On QEMU the U-boot env vars won't work because 
>>> NVRAM is not emulated yet so they can't be saved but you can call idetool 
>>> from startup-sequence boot script instead for same effect (UDMA is enabled 
>>> a bit later with that but after that it's the same).
>>> 
>>>> I can't understand why the base OS is attempting any access to BAR 4 if 
>>>> BMDMA isn't enabled by default on real hardware due to hardware bugs.
>>> 
>>> Real hardware had problems with DMA (the VIA chip was also infamous for it 
>>> on PC hardware and later also the ArticiaS was found to have its own 
>>> problems) so the default is to use IDE in PIO mode and UDMA has to be 
>>> enabled manually. But if it works (and it should on QEMU) it's much faster 
>>> so we want to enable it.
>>> 
>>>> Are we sure that the idetool hacks given in the link above to enable 
>>>> BMDMA haven't already been run on the AmigaOS install when testing an 
>>>> earlier version of the patches?
>>> 
>>> It was tested with my original series and works with that as my patch sets 
>>> the default vaules for BARs and the driver reads it correctly. Then we 
>>> tested your series too and I've noted for v2 already that it misses the 
>>> degault value for BAR4. Other BARs don't matter as it will apparently use 
>>> ISA IDE ports when it gets 0 or it knows that in legacy mode these shoud 
>>> be the port values but seems to read BAR4 for UDMA and only works if the 
>>> right default value is there, otherwise it lists DMA BAR 0 on start.
>> 
>> This probably wasn't clear so what I mean is:
>> 
>> a1ide.device 53.22 (28.6.2017)
>> [a1ide/dev_init] Found chip #0
>> [a1ide/init_port] ---> Port 0
>> [a1ide/init_port] IOBase 000001F0, AltBase 000003F6
>> [a1ide/init_port] bmcr_base 0000CC00
>> [a1ide/init_port] MMIOBase 00000000
>> 
>> This is with my patch: 
>> https://patchew.org/QEMU/cover.1697661160.git.balaton@eik.bme.hu/4095e01f4596e77a478759161ae736f0c398600a.1697661160.git.balaton@eik.bme.hu/ 
>> With yours bmcr_base is 0 and then when enabling UDMA with idetool it hangs 
>> as it needs this value from BAR4.
>
> Right, so what you're saying is that AmigaOS will run fine with the v3 series 
> out-of-the-box, but only fails when you try and enable UDMA with idetool 
> (which is explicitly changing the configuration from the AmigaOS default)?

No, what I said is it boots with v2 but fails when enabling UDMA but does 
not even boot with v3 as it crashes even before printing the above debug 
logs with v3. The changes you've and Kevin proposed fix v3 to boot and 
allow UDMA too which I've tested and sent another reply about.

Regards,
BALATON Zoltan
--3866299591-1949590591-1700492290=:13137--

