Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7157F7EDEA1
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 11:35:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3ZhW-0004OT-Fr; Thu, 16 Nov 2023 05:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhT-0004M0-KZ; Thu, 16 Nov 2023 05:34:19 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3ZhS-0006MK-0J; Thu, 16 Nov 2023 05:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yrmhDZxZsl9NK2mk1D/ZOcI5KmCbxwTuwLctF+mlH4w=; b=N+8S0eI2zSP8vytMrgEWjXklF4
 YWUQg2Szy7X8D2zLyiOaLJVt8+pv9gDcpvDdbF7IKryh7hLURZiKzzpbn9d9zFmTKl0iJ0S0pL4l/
 R/whvMXH0WSYjFc9CoXa0yR35us98im02qCho7rSgGNAMV4PbcIzSHL+HBbx3di4eoHyuH9iX9xix
 yHilSaG+nbCYQLaPfSB9+jWDEqAe823jqQo67Dcrp8X789Vp382tfzfIXZxz2KGceWZmcPmHzEQq9
 3X7Y8cU07RCk1r0tZLc0zlIhxJLA7iwsFqcqQTxBQ2xT3SgsEn3+A7R0fMMJvWpzxRyN+wjoeTG3x
 rSe516rVvQWYiNqZ971Og+eLp++kOdH/OVie/Pi7HyzQCFuaGl19sfoRQeQxEOU0uTPT8Me9U7joa
 dmul2RgTC9aCpMXaMBWqapUZAcsZtwIvr6Nu2hK4s7af2YC7DZvzk/lUtIh8xMyQ29V2edN7RKGyS
 ABAND39+WzUg0A/vms13DTm7Ysue7rAxWvy++xdsc0He5KytsJCtW9LeCiSIaR9gnLo049M3CVr7Y
 zezDejc390e3c427AklSJD2Pi5SEaVz/+7D4CSUStdgmeswWHnHXZgP1VCn1muaiwNDN2ORKUPP4d
 3fcwl30mDrx1K4VzLG+QlI423KXG+KbMc3EqMXQbk=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r3Zh9-0001bP-LV; Thu, 16 Nov 2023 10:34:03 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, balaton@eik.bme.hu, philmd@linaro.org,
 shentey@gmail.com
Date: Thu, 16 Nov 2023 10:33:54 +0000
Message-Id: <20231116103355.588580-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 3/4] ide/via: don't attempt to set default BAR addresses
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

The via-ide device currently attempts to set the default BAR addresses to the
values shown in the datasheet, but this doesn't work for 2 reasons: firstly
BARS 1-4 do not set the bottom 2 bits to PCI_BASE_ADDRESS_SPACE_IO, and
secondly the initial PCI bus reset clears the values of all PCI device BARs
after the device itself has been reset.

Remove the setting of the default BAR addresses from via_ide_reset() to ensure
there is no doubt that these values are never exposed to the guest.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


