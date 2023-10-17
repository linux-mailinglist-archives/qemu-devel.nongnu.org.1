Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6997CCACC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsou4-00024x-1b; Tue, 17 Oct 2023 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsou1-00024I-0i
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:49 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsotw-0002tP-6s
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 21ACCB81F2C;
 Tue, 17 Oct 2023 18:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AC0C433C7;
 Tue, 17 Oct 2023 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697567681;
 bh=4aHHWBjUnCIDyWDacJ4nIfdnNbjM1UEiQ33UHFU9Ddk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gizQLPYaDcStrKSLUKMS23FiSrol08IBIJxgAkc92feJG0oARwBJMVVQA+FHas/Wr
 Lg5v/uCGtANaxi67h/XpezBB6qSb2S1iwDbeJ23CtUc74FHx4xaOUGo4QfnIllZxJ7
 0HAjKfA/4IKlBeQ0++yp/54leXAg4k48ZPitmj6KnJn7a/2+urS0VpjUxCO8bMHDj/
 l9LfzKm1UxJifW+Prqt8sYEq9tOgZkp4RSW3k7QyE3dA4qvRpouYnVvUn9HdnIHgkC
 DdUkTQPUJ8mrOsiZqgUAxdG+PxZF8fplZhM6XCKk7PqivZrYdwksgl/tqekTBKpAGU
 yw9RjrUVQx4JQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 03/11] pci_ids/tulip: Add PCI vendor ID for HP and use it
 in tulip
Date: Tue, 17 Oct 2023 20:34:24 +0200
Message-ID: <20231017183432.117243-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017183432.117243-1-deller@kernel.org>
References: <20231017183432.117243-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.68.75; envelope-from=deller@kernel.org;
 helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/tulip.c           | 2 +-
 include/hw/pci/pci_ids.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 915e5fb595..11d866e431 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -1020,7 +1020,7 @@ static void tulip_class_init(ObjectClass *klass, void *data)
     k->exit = pci_tulip_exit;
     k->vendor_id = PCI_VENDOR_ID_DEC;
     k->device_id = PCI_DEVICE_ID_DEC_21143;
-    k->subsystem_vendor_id = 0x103c;
+    k->subsystem_vendor_id = PCI_VENDOR_ID_HP;
     k->subsystem_id = 0x104f;
     k->class_id = PCI_CLASS_NETWORK_ETHERNET;
     dc->vmsd = &vmstate_pci_tulip;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 85469b9b53..3c0e72df0e 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -171,6 +171,8 @@
 #define PCI_VENDOR_ID_DEC                0x1011
 #define PCI_DEVICE_ID_DEC_21143          0x0019
 
+#define PCI_VENDOR_ID_HP                 0x103c
+
 #define PCI_VENDOR_ID_CIRRUS             0x1013
 
 #define PCI_VENDOR_ID_IBM                0x1014
-- 
2.41.0


