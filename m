Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A17D57C9624
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrklb-0003t3-Qj; Sat, 14 Oct 2023 15:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklX-0003sJ-5D
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:39 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklU-0004Yl-Vr
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 6A697B80B6F;
 Sat, 14 Oct 2023 19:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07061C433C9;
 Sat, 14 Oct 2023 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313447;
 bh=KOQB9asPRfNWHCQ74uOuHEU709p8vQZ9SA19aj3VrWI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lwzBqfuWWNP/Xjd8o9B+IMDqWGf8kQE4XYq6JSVhm9k4JHV3GadusfytwHplZqqJr
 rZj+FyhQlU0P5gYvY/h2uqSi1qEZ7Hhfd5sW74Cy5MI0uh8l1zNhbPLJSCWLdLDsKk
 J+i8KF8yaw5PVm1Pm+aeTawyAPUg2cLVH3YKWa8gjepoerwn8dke9q5DGyFfn10s+m
 ON05y8wEZGHEAaHJYKeeZVxZLRGknvCCIgd9daazXnlKE0pUmMgiNDSzGwrbnHZ0Aj
 RnezupDxGs334JE/aaVCADFNQp8tzl6Fm5zJCSa3hliX6mNTK9vz0UFhMUgx3IViQ/
 +4O+6Z2+CSsXQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 02/12] pci_ids: Add PCI vendor ID for HP
Date: Sat, 14 Oct 2023 21:57:09 +0200
Message-ID: <20231014195719.151397-3-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
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
 include/hw/pci/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

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


