Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E9C7F13F0
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:10:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r541s-0002gk-Mc; Mon, 20 Nov 2023 08:09:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r541p-0002fy-BI; Mon, 20 Nov 2023 08:09:29 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r541k-00059r-9p; Mon, 20 Nov 2023 08:09:29 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF94675A4BE;
 Mon, 20 Nov 2023 14:09:54 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2E8E75A406; Mon, 20 Nov 2023 14:09:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E0DE1756094;
 Mon, 20 Nov 2023 14:09:54 +0100 (CET)
Date: Mon, 20 Nov 2023 14:09:54 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, philmd@linaro.org, shentey@gmail.com, 
 Rene Engel <ReneEngel80@emailn.de>
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
Message-ID: <63ff9c1a-5d05-985a-bf2f-69420b72db90@eik.bme.hu>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <c4bb80e8-e985-b6b2-aac1-f6e8d446b8ea@eik.bme.hu>
 <295aec31-e9c1-49d8-9bea-edad8f7b81e4@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-858078896-1700485794=:81200"
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

--3866299591-858078896-1700485794=:81200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Nov 2023, Mark Cave-Ayland wrote:
> On 19/11/2023 21:43, BALATON Zoltan wrote:
>> On Thu, 16 Nov 2023, Mark Cave-Ayland wrote:
>>> This series adds a simple implementation of legacy/native mode switching 
>>> for PCI
>>> IDE controllers and updates the via-ide device to use it.
>>> 
>>> The approach I take here is to add a new pci_ide_update_mode() function 
>>> which handles
>>> management of the PCI BARs and legacy IDE ioports for each mode to avoid 
>>> exposing
>>> details of the internal logic to individual PCI IDE controllers.
>>> 
>>> As noted in [1] this is extracted from a local WIP branch I have which 
>>> contains
>>> further work in this area. However for the moment I've kept it simple (and
>>> restricted it to the via-ide device) which is good enough for Zoltan's PPC
>>> images whilst paving the way for future improvements after 8.2.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> 
>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>> 
>>> v3:
>>> - Rebase onto master
>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent 
>>> duplication in
>>>  hw/ide/pci.c
>>> - Don't zero BARs when switching from native mode to legacy mode, instead 
>>> always force
>>>  them to read zero as suggested in the PCI IDE specification (note: this 
>>> also appears
>>>  to fix the fuloong2e machine booting from IDE)
>> 
>> Not sure you're getting this, see also:
>> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg04167.html
>> but this seems to break latest version of the AmigaOS driver for some 
>> reason. I assume this is the BAR zeroing that causes this as it works with 
>> v2 series and nothing else changed in v3 that could cause this. Testing was 
>> done by Rene Engel, cc'd so maybe he can add more info. It seems to work 
>> with my patch that sets BARs to legacy values and with v2 that sets them to 
>> 0 but not with v3 which should also read 0 but maybe something is off here.
>
> I've been AFK for a few days, so just starting to catch up on various bits 
> and pieces.

OK just wasn't sure if you saw my emails at all as it happened before that 
some spam filters disliked my mail server and put messages in the spam 
folder.

> The only difference I can think of regarding the BAR zeroing is that the 
> BMDMA BAR is zeroed here. Does the following diff fix things?

This helps, with this the latest driver does not crash but still reads 
BAR4 as 0 instead of 0xcc00 so UDMA won't work but at least it boots.

Regards,
BALATON Zoltan

> diff --git a/hw/ide/via.c b/hw/ide/via.c
> index 47223b1268..2d3124ebd7 100644
> --- a/hw/ide/via.c
> +++ b/hw/ide/via.c
> @@ -164,10 +164,10 @@ static uint32_t via_ide_cfg_read(PCIDevice *pd, 
> uint32_t addr, int len)
>     uint8_t mode = pd->config[PCI_CLASS_PROG];
>
>     if ((mode & 0xf) == 0xa && ranges_overlap(addr, len,
> -                                              PCI_BASE_ADDRESS_0, 24)) {
> +                                              PCI_BASE_ADDRESS_0, 16)) {
>         /* BARs always read back zero in legacy mode */
>         for (int i = addr; i < addr + len; i++) {
> -            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 24) {
> +            if (i >= PCI_BASE_ADDRESS_0 && i < PCI_BASE_ADDRESS_0 + 16) {
>                 val &= ~(0xffULL << ((i - addr) << 3));
>             }
>         }
>
>>> - Add comments in pci_ide_update_mode() suggested by Kevin
>>> - Drop the existing R-B and T-B tags: whilst this passes my local tests, 
>>> the behaviour
>>>  around zero BARs feels different enough here
>>> 
>>> v2:
>>> - Rebase onto master
>>> - Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in 
>>> patch 1
>>> - Add patch 2 to remove the default BAR addresses to avoid confusion
>>> - Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is already 
>>> set
>>>  by pci_ide_update_mode() in patch 3, and reword the commit message 
>>> accordingly
>>> - Add Tested-By tags from Zoltan and Bernhard
>>> 
>>> 
>>> Mark Cave-Ayland (4):
>>>  ide/ioport: move ide_portio_list[] and ide_portio_list2[] definitions
>>>    to IDE core
>>>  ide/pci: introduce pci_ide_update_mode() function
>>>  ide/via: don't attempt to set default BAR addresses
>>>  hw/ide/via: implement legacy/native mode switching
>>> 
>>> hw/ide/core.c             | 12 ++++++
>>> hw/ide/ioport.c           | 12 ------
>>> hw/ide/pci.c              | 84 +++++++++++++++++++++++++++++++++++++++
>>> hw/ide/via.c              | 44 ++++++++++++++++----
>>> include/hw/ide/internal.h |  3 ++
>>> include/hw/ide/pci.h      |  1 +
>>> 6 files changed, 137 insertions(+), 19 deletions(-)
>
>
> ATB,
>
> Mark.
>
>
--3866299591-858078896-1700485794=:81200--

