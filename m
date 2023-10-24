Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B74347D5E56
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 00:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvQ5W-0002lW-Sc; Tue, 24 Oct 2023 18:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5P-0002fu-SU; Tue, 24 Oct 2023 18:41:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5J-0002hO-4j; Tue, 24 Oct 2023 18:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9zJVhk4sq7qIdUr1QZu457Eltu8/+Io7kqPObznP+X8=; b=TOaezAD4TYg9F8jUXKD2H41Qqz
 yospjzUWQFV5kZuq5wkzEMUwokjM4xfClk+KGvXl4rZH2R1/0iOtK/TUk1P6WNQo9xqPTAUPRAT1R
 uPao22033g9K/45iRsZvrSMf7RpAcq1IrfiEi5SKAUTRFRmRSQJxzwdPHBwC2rF/JpnUj6+Z4at3r
 84g7QHpeCgqwbatToVPli5Eszma7WKTUi0iPcOHlxiWTTTMzhYFjIHs32YpoAuZTQW6ev1Jff311z
 ohsZ6bJ+SOUElja5yI4ETuM9SuQvNzpEUBoQjAkmy4InIymEymbKdMLiC9tBx/EfsRhVPCOSYq5dK
 sJHIlGNoJZbfOnaIKMQsZumfMWamwwOd8zP4EKvPtK1U7ZTIO9gYTyKlpNEiWgH4yV4/wcKRMMLyJ
 opoDO6gTGB9Wj1CCQsdVMOYS/u0SiPlYFFVj5qyv01otnynf3x7Stx/myctVrVvsThHJI3GGUwO61
 O0zchzfbE6W5J0+ulS6tS6wU0op3AT7Z5ATtIdwltwLxk6mxi6ZgYllAp2tacJHmIQmx+5BQ2ewVV
 CJE/QIYvoE6mPofKQpuKvruI2e6pIEzwmOrblNCcJRlZMur1ZBuzd/0SWPRXmlkUr7DAIUJLUwTrI
 TJYzpLexIKug6cIlKADFng15I8zhSyx48NxBRzlI8=;
Received: from [2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ55-0002va-6D; Tue, 24 Oct 2023 23:41:03 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Tue, 24 Oct 2023 23:40:53 +0100
Message-Id: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 0/3] ide: implement simple legacy/native mode switching for
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

v2:
- Rebase onto master
- Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in patch 1
- Add patch 2 to remove the default BAR addresses to avoid confusion
- Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is already set
  by pci_ide_update_mode() in patch 3, and reword the commit message accordingly
- Add Tested-By tags from Zoltan and Bernhard


Mark Cave-Ayland (3):
  ide/pci.c: introduce pci_ide_update_mode() function
  ide/via: don't attempt to set default BAR addresses
  hw/ide/via: implement legacy/native mode switching

 hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ide/via.c         | 25 ++++++++----
 include/hw/ide/pci.h |  1 +
 3 files changed, 109 insertions(+), 7 deletions(-)

-- 
2.39.2


