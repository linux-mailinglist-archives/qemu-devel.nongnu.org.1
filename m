Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC50B7D5E57
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 00:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvQ5a-0002pW-HD; Tue, 24 Oct 2023 18:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5X-0002o1-BZ; Tue, 24 Oct 2023 18:41:27 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5R-0002hi-8I; Tue, 24 Oct 2023 18:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0iSNVIgoDqBbdYoyl+njrWXgG834i3sZNzE/xHFaVOs=; b=tW583NBWRB85+uxs0sYqszjnQn
 GhyvGPUoI7pFNR5g2cslx0ppt3q4E2+IiRHA/s+ps8c0+py+LbCClBacPSDH4fXHmXp9ac1yOPbuL
 VmbBeuuWw4lreYtBAfFAQ6PyXerS79BtaXSQegs/eKvaybZrE1VxSMARJNZnmQOhYhwumomrfbNMF
 gntbpSSexb2EUIVIYKjFKP9pwkNU8nxQHJHWt9NxkqtKOfrd6zqN1kImJwKd+zEzRlncntNafbtu5
 uVWV+3kU2UmpvoDQGPPHNpXS9hzMOD0GUnyq7J5vyZ0SgR6oSZOGIyy1ENn9DuDPbsG83Qv+1QEvj
 /o0icD8fNwBdoARRRwG9D2kl4S1/0LVleVGLAKcZr5+TN9To3T2taTnBLm+Ydu76Rg+mvYQhOaTow
 ojly7XmXVP7CT4wU4TBWbFfH9TBgbqu7uVSFnN4u1VhacYTkznWy/wYkEIs0n6vpXblhmuwMzRhXP
 SPWBj21HN9ouRrgZ0Gu5J2g8hcvedqf7LkHAtx3NjpgZx2IdW25IQY/Xigr4qrEeRmwnNV5klQ1ON
 jCPLfNslo8SpqU3EZVxVYsJdoefwthOerJdzJ86wn2HSQY/4jpeiZHlG/xJzAgSSHCxhJOftaGjX0
 R/lBmEPo+fzjIafn4otklhsf44g9eBnPpBOFd215k=;
Received: from [2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvQ5D-0002va-6D; Tue, 24 Oct 2023 23:41:11 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Tue, 24 Oct 2023 23:40:55 +0100
Message-Id: <20231024224056.842607-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:d6f1:6571:2310:5e57
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 2/3] ide/via: don't attempt to set default BAR addresses
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

The via-ide device currently attempts to set the default BAR addresses to the
values shown in the datasheet, but this doesn't work for 2 reasons: firstly
BARS 1-4 do not set the bottom 2 bits to PCI_BASE_ADDRESS_SPACE_IO, and
secondly the initial PCI bus reset clears the values of all PCI device BARs
after the device itself has been reset.

Remove the setting of the default BAR addresses from via_ide_reset() to ensure
there is no doubt that these values are never exposed to the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/via.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/ide/via.c b/hw/ide/via.c
index fff23803a6..87b134083a 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -132,11 +132,6 @@ static void via_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_STATUS, PCI_STATUS_FAST_BACK |
                  PCI_STATUS_DEVSEL_MEDIUM);
 
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_0, 0x000001f0);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_1, 0x000003f4);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_2, 0x00000170);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_3, 0x00000374);
-    pci_set_long(pci_conf + PCI_BASE_ADDRESS_4, 0x0000cc01); /* BMIBA: 20-23h */
     pci_set_long(pci_conf + PCI_INTERRUPT_LINE, 0x0000010e);
 
     /* IDE chip enable, IDE configuration 1/2, IDE FIFO Configuration*/
-- 
2.39.2


