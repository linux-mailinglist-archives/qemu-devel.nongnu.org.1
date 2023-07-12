Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD44750062
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUZh-00049N-BT; Wed, 12 Jul 2023 03:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qJUZc-000493-6X; Wed, 12 Jul 2023 03:47:44 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>)
 id 1qJUZZ-0002Ja-S3; Wed, 12 Jul 2023 03:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1689148056; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=eBBEfrSXi8XpC/6+whWLs0Ijtn2HRuhKbmrYdinn4Ma7HOkp/roRhEOh/olVVT7GrU
 kOupRXU5YYkWuzIDUYkA6106DdrwRJngJgI0Pq0CfVWmwLP/O9ZnRkF2ETleETf1i8y4
 ZdTNIpYMHyZUrS6r6cw9fIM9AEZIyq0MrQSWm31vq/Au3RxGvc9a/Z5zKeZ56zGBwmVU
 CVaGR6rw71kmk5fbQB6WNFhyVUVd2EmP37sOOw/WF+sFRpr06OPAcS8/fi5AzBYsUIeM
 f7d1NplUtiWEff58EvWxXz1cGRlweHpiockGcbMQRXoG8EcPEyUpJWKOigR07ko5o5t+
 45WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689148056;
 s=strato-dkim-0002; d=strato.com;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=Vo5Hv5s5+r7WZaEFYbVAXHsCg/WzZA8RZzq/ymUBu4E=;
 b=WdL63lgflRnmHWBm/jjbZQKUnphmsMjqGrx3BgRriMHI42FdddYLRUbq5iPYwMZQdV
 C/Zk+Aau4eiEnxGjTTkOYkEqxrtuAIMa1cPiwTF6KjcXEdZilH0dEbTS0XETmIzms9ey
 Kw7iKYecs7tbezKDt6UcSV8CmHGKb2yh/BtWgZzM1E3u7qBKJEH2zBznlltNTjoexxyg
 3H1JQyJQGc23wP/+xWBxU8POCzyM9enAi5Hz4McimUxPp45giWcn5p0RoyI0wUBojRHm
 qW2UL56Jv2k7sIcOUIaBzHR0GViB6fuXmI6Rum90W0z115Nq2RdtPSUXIaEA1UcKqKP/
 wgXg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689148056;
 s=strato-dkim-0002; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=Vo5Hv5s5+r7WZaEFYbVAXHsCg/WzZA8RZzq/ymUBu4E=;
 b=j+jyhs70WOec+uPtM4EygQE96LOwHCsucztflYo6sW14ZMx6qphGcW38vU5M9PNjO2
 eqKm+PMcg6EG5peN/tJLRpihtj6JfQfs//BhutDNf18MRzKYPtLdtgHKyU6qbAkgGBXw
 VjKBZmvcFrchGav4xeivqRgJLmCCkFCTe9qPP2FI1TDyXkJgxswZ09aC2mABi1V4NNrc
 vFV8KeZsUAfRPzM1LjspAHnKTVOsKFA/P8A0NRxW6GnsAZMei2dzPoeQe6sZuDm76wlB
 NYvQgQixshZLiGZGQ72f2MVIECy9KKpZFGixCYCSDgS6sA+RJkFk7tvBCgZ9ypZBYvRK
 Kfgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689148056;
 s=strato-dkim-0003; d=aepfle.de;
 h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
 bh=Vo5Hv5s5+r7WZaEFYbVAXHsCg/WzZA8RZzq/ymUBu4E=;
 b=7qWNWv2LiV6+76Hu7JOlwWQaIG6XjEgDcP19k5D37mLJGRwH3gNgxA2Ttb+q2l17TI
 HBvbjuQzyoby+dsD4BAg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4x/Q77Ep0tacRDpd3C7x0fRU/XAhBUWjct55BrKA=="
Received: from sender by smtp.strato.de (RZmta 49.6.0 AUTH)
 with ESMTPSA id y5401az6C7lafVE
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 12 Jul 2023 09:47:36 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PATCH v3] hw/ide/piix: properly initialize the BMIBA register
Date: Wed, 12 Jul 2023 09:47:22 +0200
Message-Id: <20230712074721.14728-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: none client-ip=81.169.146.160; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

According to the 82371FB documentation (82371FB.pdf, 2.3.9. BMIBA-BUS
MASTER INTERFACE BASE ADDRESS REGISTER, April 1997), the register is
32bit wide. To properly reset it to default values, all 32bit need to be
cleared. Bit #0 "Resource Type Indicator (RTE)" needs to be enabled.

The initial change wrote just the lower 8 bit, leaving parts of the "Bus
Master Interface Base Address" address at bit 15:4 unchanged.

Fixes: e6a71ae327 ("Add support for 82371FB (Step A1) and Improved support for 82371SB (Function 1)")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 151f206046..4e5e12935f 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -117,7 +117,7 @@ static void piix_ide_reset(DeviceState *dev)
     pci_set_word(pci_conf + PCI_COMMAND, 0x0000);
     pci_set_word(pci_conf + PCI_STATUS,
                  PCI_STATUS_DEVSEL_MEDIUM | PCI_STATUS_FAST_BACK);
-    pci_set_byte(pci_conf + 0x20, 0x01);  /* BMIBA: 20-23h */
+    pci_set_long(pci_conf + 0x20, 0x1);  /* BMIBA: 20-23h */
 }
 
 static bool pci_piix_init_bus(PCIIDEState *d, unsigned i, Error **errp)

base-commit: 887cba855bb6ff4775256f7968409281350b568c
prerequisite-patch-id: daed167f888bd89b010a2e890e3edd97872cfc05
prerequisite-patch-id: 532640812ba7cd0303414c77450923f6abcb5119
prerequisite-patch-id: abf2f4ed52b072599c49d993de902e6dd7f2b560

