Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122B7CE934
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDLb-00079k-Uv; Wed, 18 Oct 2023 16:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLa-00078R-1O
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:54 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtDLV-0000zo-PD
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:40:53 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4AFB961948;
 Wed, 18 Oct 2023 20:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB6FC433C7;
 Wed, 18 Oct 2023 20:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697661639;
 bh=/2SwI/9UCj0genMvRwRNkqJQ96z8MCfCSDJ44ruxY38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=n9u8lVMPr1+5oyeUPcpHDl51DFyaz7toBcldUVQGILiOZECsfe6DzEVUMe1YqA21I
 lrgo1WJOvU5UKD1AFylF+bgZ42a4wh6u2U4WEL+2vYDHUbxlIphwyhg7nNzu3yam7z
 +8/Q7XIdaNGfsgPXg5uwO5R2HV1x2vpRXkqcB2qCtBLHm96A8F++WKnbdfFul8HXCn
 jcZjZtjgs7+E5ndFS/wwTlkbuS3dOP/LiRsxnPmFYLbcBt8vTQlItlJ38QxMTq+nzy
 9DqBeZG0MEbxfyTaqTBlCp7EiEUTjNfTkQp89lkSV2/KBKLCKajS4nxqL0t7SyTwQN
 JRRF/Wy9DWI/w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 03/11] pci_ids/tulip: Add PCI vendor ID for HP and use it in
 tulip
Date: Wed, 18 Oct 2023 22:40:22 +0200
Message-ID: <20231018204030.391572-4-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018204030.391572-1-deller@kernel.org>
References: <20231018204030.391572-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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
index 85469b9b53..f1a53fea8d 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -179,6 +179,8 @@
 #define PCI_DEVICE_ID_AMD_LANCE          0x2000
 #define PCI_DEVICE_ID_AMD_SCSI           0x2020
 
+#define PCI_VENDOR_ID_HP                 0x103c
+
 #define PCI_VENDOR_ID_TI                 0x104c
 
 #define PCI_VENDOR_ID_MOTOROLA           0x1057
-- 
2.41.0


