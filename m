Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA2E7F95EA
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 23:51:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Nwj-0002hA-VR; Sun, 26 Nov 2023 17:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwY-0002fO-PL
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:38 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwV-0002PX-0T
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:38 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D75F275607B;
 Sun, 26 Nov 2023 23:49:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CBB29756078; Sun, 26 Nov 2023 23:49:28 +0100 (CET)
Message-Id: <cover.1701035944.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 0/4] Fix IRQ routing in via south bridge
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
Date: Sun, 26 Nov 2023 23:49:28 +0100 (CET)
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

Philippe,

Could this be merged for 8.2 as it fixes USB on the amigaone machine?
This would be useful as usb-storage is the simplest way to share data
with the host with these machines.

This is a slight change from v2 adding more comments and improving
commit messages and clean things a bit but otherwise should be the
same as previous versions. Even v1 worked the same as this one and v2,
the additional check to avoid stuck bits is just paranoia, it does not
happen in practice as IRQ mappings are quite static, they are set once
at boot and don't change afterwards.

The rest is just some explanation on how we got here but can be
skipped if not interested in history.

This is going back to my original implementation of this IRQ routing
that I submitted already for 8.0 in the beginning of this year
(https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/)
but Mark had concerns about that because he wanted to use PCI
interrupt routing instead. I've already told back then that won't work
but I could not convince reviewers about that. Now with the amigaone
machine this can also be seen and that's why this series is needed now.

The routing code in PCIBus cannot be used as that only considers the 4
PCI interrupts but there are about 12 interrupt sources in this chip
that need to be routed to ISA IRQs (the embedded chip functions and
the 4 PCI interrupts that are coming in through 4 pins of the chip).
Also the chip does not own the PCIBus, that's part of the north bridge
so it should not change the PCI interrupt routing of a bus it does not
own. (Piix calling pci_bus_irqs() I think is also wrong because the
PCI bus in that machine is also owned by the north bridge and piix
should not take over routing of IRQs on a bus it's connected to.)
Another concern from Mark was that this makes chip functions specific
to the chip and they cannot be used as individual PCI devices. Well,
yes, they are chip functions, are not user creatable and don't exist
as individual devices so it does not make sense to use them without
the actual VIA chip they are a function of so that's not a real
concern. These functions are also not actual PCI devices, they are
PCIDevice because they appear as PCI functions of the chip but are
connected internally and this series also models that correctly. This
seems to be supported by comments in Linux about how these VIA chip
function aren't following PCI standards and use ISA IRQs instead:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/pci/quirks.c?h=v6.5.6#n1172

Therefore I think Mark's proposals are not improving this model so I
went back to the original approach which was tested to work and is
also simpler and easier to understand than trying to reuse PCI
intrrupt routing which does not work and would be more complex anyway
for no good reason.

Regards,
BALATON Zoltan

BALATON Zoltan (4):
  hw/isa/vt82c686: Bring back via_isa_set_irq()
  hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
  hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
  hw/audio/via-ac97: Route interrupts using via_isa_set_irq()

 hw/audio/via-ac97.c        |  8 ++--
 hw/isa/vt82c686.c          | 79 +++++++++++++++++++++++++-------------
 hw/usb/vt82c686-uhci-pci.c |  9 +++++
 include/hw/isa/vt82c686.h  |  2 +
 4 files changed, 67 insertions(+), 31 deletions(-)

-- 
2.30.9


