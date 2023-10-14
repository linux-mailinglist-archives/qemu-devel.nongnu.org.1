Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 744477C962D
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrklf-0003z1-Qy; Sat, 14 Oct 2023 15:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklb-0003vy-V5
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:43 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklX-0004as-VJ
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D1D2C60A26;
 Sat, 14 Oct 2023 19:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95175C433C8;
 Sat, 14 Oct 2023 19:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313452;
 bh=zBhdmEU3W/GrhZzSD/DebCl62iiGxuNAdn+KHIsOxws=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cR3D0WLqnkbXE1vrUlpIcgYlxYeHwqWlFLZioqPlhmhdtZNV+0/k4BN/UKKuJ/bDW
 UMiCrYxVzE3P7laN8Remj+pK0BITKAevaPvR7mir1Kmtp027sUs1zTMFQEKwlRhzum
 QF7lHezEZELsP+aJKhDy7AQcsMKzLIvUAWO4d+ELcNiNXdnJVkc7pDr9la5n2o8GUY
 rapo/CnQvU1/X7OZTx+jao6fX0RxtO/iINeOOdNnaz4QuzFNHUMgS6uPjMi54jkSpE
 84NWw7WoSXwbraOeZPLaOGPN3Db7bzjMuE+yuJ3e3weUviaoA5HcipFOHbkQO5mrBW
 48NX9XE40+g2A==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 06/12] tulip: Use the HP PCI vendor ID instead of number
Date: Sat, 14 Oct 2023 21:57:13 +0200
Message-ID: <20231014195719.151397-7-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
 hw/net/tulip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.41.0


