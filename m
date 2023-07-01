Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D303E744AC1
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 19:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFegh-0005gp-Np; Sat, 01 Jul 2023 13:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFegf-0005g8-3X; Sat, 01 Jul 2023 13:47:09 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qFegd-0004K7-Cr; Sat, 01 Jul 2023 13:47:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1688233625; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=lB6poC13LurVBH0pewPpMp+RRZkJjUNPc/Ci36soo4Mp8Et1MN5fLvaC8yWXhRFY4H
 aSn+FmjNVR+XuhfU6bYYjXVvfG5P90s9E8Rspt6okP2/+h72VVBQaRwEhgGno5bJqFfq
 0mk7tMLLrv0p7Y80a0Emey+Qw9AGnWeRYkozbQHh8F+/P1sE0P3iSkM6XZ+fFZDDVc8I
 rSCXDOnU+fG6ZL0jKUfRgRUDW2T1JGFD7lbClRv802YH8V4YmTXg9lMj1XQWLBR5+lq7
 04eyEy4KJR3tJFj5H/thtj2QVGwV8gNGQE4b010buoQSsExE1duE6nAJ4GFrsZOp5QAI
 zV6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688233625;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xTvtMyLd8dhPFXKAVn5Rzsq2FBSYl+/GTXk/3+HxJSQ=;
 b=fqyFAuxMPzsAW6Rcms2lcAI2albJBo4W9ZhRDbcGg2CWQ1D6CryfJuWN1NJcBQnDYb
 6T2x3RiPjCJZFyPqU4o86ScDXs7B8z+eIsPmiCfcYeOpv2ndCcUYhrV1z5gkemRV9bwh
 +oHO0qgNerhr10r6C27Sx2m+HwJxm0UuazRoZBBft1bRP6OoVFn17Bzt2L3xpvTR/aQ6
 v43rz5WwbvicPaihP9L5HZgybcBgdKVqvWHkJhX2DSa2jmuduAhzCxmivo8kzJ0nKxeC
 WpmgVY54VONhj60nbQJevtSGdix8RYQX5Aoyk84WAxfOKeLS/km9DGR9xZrw0keSTCO5
 ydfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688233625;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xTvtMyLd8dhPFXKAVn5Rzsq2FBSYl+/GTXk/3+HxJSQ=;
 b=fz9nnCrIjWLIJvxn9zx8y2eOKsq0yvFJTDbTND03Ju7WOv7yLm4MQ36cWzpfexdJqp
 irePTCrs8HODgjIoh0QmYM9X2uXpF/vqKekAxqYtVsFLNr5fQfXeQG97Nxvqiz6Yr04L
 /Uwuh2DJJGFiHwzEdw5m7uSuUJ7c2nCglErxorv5JmyblNw251fDqVcgi0nqp1pMEI6c
 cZfVXI2Vb1Tw4izmyBBpYimraQ2tnkEOXnAePY5YVSX9v8ttyesnVOiqwJxJtTHeYsEI
 0bfCxry+wwkzQ/L6pfqvM9i1vHWT/SvDeX7ZvCFKXotY7/hD4POc+aP9VcQeZvvb53RV
 FQHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688233625;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=xTvtMyLd8dhPFXKAVn5Rzsq2FBSYl+/GTXk/3+HxJSQ=;
 b=I90m1GF2Pxxxx9qfcB0nL2WGT83EKEPnSmMW+lgeO0b1yrCyF9mkgQGkj18xq7OSzM
 SZQpa7l2H2IU71565JCg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x+1/7Qcst+v+6egNSCv2nSejLpXdlt4RWwKmQOQ=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az61Hl51ih
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 1 Jul 2023 19:47:05 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Lev Kujawski <lkujaw@member.fsf.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PATCH v2] hw/ide/piix: properly initialize the BMIBA register
Date: Sat,  1 Jul 2023 19:46:59 +0200
Message-Id: <20230701174659.10246-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=85.215.255.54; envelope-from=olaf@aepfle.de;
 helo=mo4-p01-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_NONE=0.001,
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
cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.

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
index 41d60921e3..1e346b1b1d 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -118,7 +118,7 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
+    pci_set_long(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
 }
 
 static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)

base-commit: d145c0da22cde391d8c6672d33146ce306e8bf75

