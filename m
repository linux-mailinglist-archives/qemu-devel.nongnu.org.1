Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0A7448B2
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 13:15:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFYYO-00012s-Kc; Sat, 01 Jul 2023 07:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFYYK-00011H-DZ; Sat, 01 Jul 2023 07:14:08 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFYYI-0003W3-5H; Sat, 01 Jul 2023 07:14:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688210038; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=bkZclbPisHJobEphVnOcu/EpjMLahuUQiaemsfs0BSwsRF5GBdIScelNoCZqAal19M
 noaSYiQLB9IdDxhiVTFnJZcAenpn1FEyJK3VmcwfsJ7NVzeb0FC69C4Mlo0C4/pOY17L
 wmYKle49tP/Qjkwis9Wr+cTYaklSRKVoX/+PhiEFJY2XzS175KZ98w5P3IDy7qrRbSwC
 JQQble1a+dCwCnKPmE704A49Q1lpZFgJl6csv+XI0M8A7AKAXRN6nXpZAfPf/EH8Ukde
 887UMome1Sed/F7IhfwZFsseGHbIVwrJm0lE4l1Eho9GkR4gnLry+KRRVWJM5AiJPp3Y
 2hVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688210038;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xnhF1YuGVpO22XZF73jTbrQhcNAQ39iTS5YAm5aHm3M=;
 b=lAQj09uKlR5XxWLDvBP9edDn58tPcraSLLKjolavr1LxTTQQH3GRz8SNSKFegT5H4N
 ti6V5a3mEGFKJnJ/527e1uYqfMo2eXz7VI+LQgU38Y3CFiulx+X4X5++mGgNJYcPLCqo
 Ulak7YWTJWOZHjhZx1InzfKL0g5lODXrqT6p6eCtbBruun4bZwMkTHShm8VV/MT2X3S1
 iNFh5HyI68V2xwNEc/3hgpi8NXl1W18WgWaso0UhG4YkFHwpgzPqb8XmYnAjVOJXFk2C
 NmnwXzyIqen3nyO+PianHL8AXqYo20YfrxSsE6OJhXhY+0qvDfMtFki/p5rY4Fda4AdT
 T2RQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688210038;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xnhF1YuGVpO22XZF73jTbrQhcNAQ39iTS5YAm5aHm3M=;
 b=cQdnCZ3jZ8brkk+Cn8uKk0smt2G8I+hpXUsZYQjwPXd8ZvofA207Z7xd7vyV1R1GYb
 3voeYVodhecbNjmkjwrsSIsalt4pKwIg+/lFTYG53K0GWXqFA1JESaCgtjW3cgamKPPy
 2j5A/dOcGx1bgK5bmOfZGRoHXh+X+cBRMUr+GL46tUtRT/RsboW/53ErTWK0pJKjo8Ye
 ymrm/Qh86aqTBWrOOqk0MHx/AUUXDzNivPDShtgnypCdgXRvy1eio97A2M7/wqOrMElH
 po1P3LptLijacRUo0tlOkOhYyzjLy+GlSjwxqMTiab+3qXqF2AorsUOC8CfWcwqwSeLk
 SFPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688210038;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xnhF1YuGVpO22XZF73jTbrQhcNAQ39iTS5YAm5aHm3M=;
 b=DTGCVdwbrVMXgNVgOSbJ8xRmy74m7PDFdkbMWz1wpQXQkKJBCoAw8c+SSUg7kGSTCg
 gO5xWTtlXY6H4uzueEAQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x+1/7Qcst+v+6egNSCv2nSejLpXdlt4RWwKmQOQ=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az61BDw15t
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 1 Jul 2023 13:13:58 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Lev Kujawski <lkujaw@member.fsf.org>, Bernhard Beschow <shentey@gmail.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PATCH v1] hw/ide/piix: properly initialize the BMIBA register
Date: Sat,  1 Jul 2023 13:13:41 +0200
Message-Id: <20230701111341.25500-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=85.215.255.52; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA—BUS
MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
32bit wide. To properly reset it to default values, all 32bit need to be
cleared. Bit #1 "Resource Type Indicator (RTE)" needs to be enabled.

The initial change wrote just the lower 8 bit, leaving parts of the "Bus
Master Interface Base Address" address at bit 15:4 unchanged.

This bug went unnoticed until commit ee358e919e38 ("hw/ide/piix: Convert
reset handler to DeviceReset"). After this change, piix_ide_reset is
exercised after the "unplug" command from a Xen HVM domU, which was not
the case prior that commit. This function resets the command register.
As a result the ata_piix driver inside the domU will see a disabled PCI
device. The generic PCI code will reenable the PCI device. On the qemu
side, this runs pci_default_write_config/pci_update_mappings. Here a
changed address is returned by pci_bar_address, this is the address
which was truncated in piix_ide_reset. In case of a Xen HVM domU, the
address changes from 0xc120 to 0xc100.

While the unplug is supposed to hide the IDE disks, the changed BMIBA
address breaks the UHCI device. In case the domU has an USB tablet
configured, to recive absolute pointer coordinates for the GUI, it will
cause a hang during device discovery of the partly discovered USB hid
device. Reading the USBSTS word size register will fail. The access ends
up in the QEMU piix-bmdma device, instead of the expected uhci device.
Here a byte size request is expected, and a value of ~0 is returned. As
a result the UCHI driver sees an error state in the register, and turns
off the UHCI controller.

Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved support for 82371SB (Function 1)")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 hw/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 41d60921e3..6449ba8b6b 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -118,7 +118,7 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
+    pci_set_word(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
 }
 
 static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)

base-commit: d145c0da22cde391d8c6672d33146ce306e8bf75

