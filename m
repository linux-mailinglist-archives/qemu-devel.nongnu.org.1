Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F07ED7DAC0C
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 12:08:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx3dq-0007OO-7X; Sun, 29 Oct 2023 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx3dm-0007Ns-Jf
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:07:35 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx3dk-0000Hg-2k
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:07:34 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2A847756088;
 Sun, 29 Oct 2023 12:07:32 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E520D756082; Sun, 29 Oct 2023 12:07:31 +0100 (CET)
Message-Id: <cover.1698577151.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/4] Fix IRQ routing in via south bridge
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Date: Sun, 29 Oct 2023 12:07:31 +0100 (CET)
X-Spam-Probability: 8%
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

Changes in v2:
- Avoid a potential problem noticed by Volker before with not clearing
interrupts when mapping is changed (may not happen in practice but we
can handle it here) also add some comments explaining how it works.
- Update some commit messages

This is going back to my otiginal proposal in
https://patchew.org/QEMU/cover.1677004414.git.balaton@eik.bme.hu/
implementing routing of interrupts from device functions and PCI
devices to ISA interrupts. On pegasos2 the firmware sets evertyhing to
share IRQ 9 so the current simpified version worked for taht but with
the amigaone machine its firmware makes use of this feature and
assigns different interrupts to functions and PCI devices so we need
to properly impelent this. Since any ISA interrupt can be controlled
by any interrupt source (different functions of the multifunction
device plus the 4 input pins from PCI devices) there are more than 4
possible sources so this can't be handled by just the 4 PCI interrupt
lines. We need to keep track of the state of each interrupt source to
be able to determine the level of the ISA interrupt and avoid one
device clearing it while other still has an interrupt.

This fixes USB on amigaone and maybe other bugs not discovered yet.

Regards,
BALATON Zoltan

BALATON Zoltan (4):
  hw/isa/vt82c686: Bring back via_isa_set_irq()
  hw/usb/vt82c686-uhci-pci: Use ISA instead of PCI interrupts
  hw/isa/vt82c686: Route PIRQ inputs using via_isa_set_irq()
  hw/audio/via-ac97: Route interrupts using via_isa_set_irq()

 hw/audio/via-ac97.c        |  8 ++--
 hw/isa/vt82c686.c          | 75 +++++++++++++++++++++++++-------------
 hw/usb/vt82c686-uhci-pci.c |  9 +++++
 include/hw/isa/vt82c686.h  |  2 +
 4 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.30.9


