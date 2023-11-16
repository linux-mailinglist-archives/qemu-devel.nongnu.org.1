Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC57EDEA3
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:35:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZhL-0004Gm-VH; Thu, 16 Nov 2023 05:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhJ-0004Fq-BR; Thu, 16 Nov 2023 05:34:09 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhH-0006Hx-LH; Thu, 16 Nov 2023 05:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rDnB6s29L8ULZ5Fck3KUKcaMHfXPQIZUcEf3B7HEzQU=; b=kN3y3NY3kSCGb4f/J4MK0ePZtY
 P6g7Z8E+Z9E/yjMNZb8pHVJi6X7Owkw7aHg1N9/zy7/7UE8nbqHpuQYUNHlV+A/HE2iXjtWPB8Hi9
 PAi/ZA/pTzM2HsfZjCQF0u3zkDwmhA6EEhvgwTmsmyZ0vZgKz7ObLLP7G5b0fWfRQwQSq1UBV9Nps
 K3kq4vOVibm5vhfo2gp4QQ4rTzY+7JHMdEeXsPVT8eTzsGxdvCHr4GZtt25Ryn4CSBRBSBkijD/IO
 rusif81hlv0guCO/kPAceKxHsfs07JQnbrhjBN7odmwy8X9MvWx0o23Nl9/qDdx4dj3rNYxnuj9tH
 CxxeVkkCXAUwsXbUXYWr4bH6Wi7ogbzR+4dDJ24opckBrUZmUpY2WZwcaoRAl5BnbGqXv4SqklOk0
 f70S5yTcGvcgFca2A9wdKxg0VlnUCL97q6+ucUNCkrZFW0F3Dhto5rBgNtFfU/9fNLrsSEwS1XndL
 XECgxvzO5TQTNHjMvz+WmuhrDpO8gwsF/1TAxqIXi8lgkvLbqFlK+6pxwr18nM6RCAIOdMaSaFW0P
 04WkJemYohz3LSIOkAI9TIcOezZASggD8QK+zdO6cjZTywWnp8BJ/a5wGkIvj0x4fvO2daTcnexO/
 w1Ry2FLXoZi/B9EF22eiyohXxkfSmHmGR+pLN9N7M=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3Zgw-0001bP-9Z; Thu, 16 Nov 2023 10:33:50 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu, philmd@linaro.org,
 shentey@gmail.com
Date: Thu, 16 Nov 2023 10:33:51 +0000
Message-Id: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 0/4] ide: implement simple legacy/native mode switching for
 PCI IDE controllers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This series adds a simple implementation of legacy/native mode switching for PCI
IDE controllers and updates the via-ide device to use it.

The approach I take here is to add a new pci_ide_update_mode() function which handles
management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
details of the internal logic to individual PCI IDE controllers.

As noted in [1] this is extracted from a local WIP branch I have which contains
further work in this area. However for the moment I've kept it simple (and
restricted it to the via-ide device) which is good enough for Zoltan's PPC
images whilst paving the way for future improvements after 8.2.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html

v3:
- Rebase onto master
- Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent duplication in
  hw/ide/pci.c
- Don't zero BARs when switching from native mode to legacy mode, instead always force
  them to read zero as suggested in the PCI IDE specification (note: this also appears
  to fix the fuloong2e machine booting from IDE)
- Add comments in pci_ide_update_mode() suggested by Kevin
- Drop the existing R-B and T-B tags: whilst this passes my local tests, the behaviour
  around zero BARs feels different enough here

v2:
- Rebase onto master
- Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in patch 1
- Add patch 2 to remove the default BAR addresses to avoid confusion
- Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is already set
  by pci_ide_update_mode() in patch 3, and reword the commit message accordingly
- Add Tested-By tags from Zoltan and Bernhard


Mark Cave-Ayland (4):
  ide/ioport: move ide_portio_list[] and ide_portio_list2[] definitions
    to IDE core
  ide/pci: introduce pci_ide_update_mode() function
  ide/via: don't attempt to set default BAR addresses
  hw/ide/via: implement legacy/native mode switching

 hw/ide/core.c             | 12 ++++++
 hw/ide/ioport.c           | 12 ------
 hw/ide/pci.c              | 84 +++++++++++++++++++++++++++++++++++++++
 hw/ide/via.c              | 44 ++++++++++++++++----
 include/hw/ide/internal.h |  3 ++
 include/hw/ide/pci.h      |  1 +
 6 files changed, 137 insertions(+), 19 deletions(-)

-- 
2.39.2


