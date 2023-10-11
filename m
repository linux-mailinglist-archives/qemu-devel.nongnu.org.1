Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7897A7C558C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZLj-0007hC-Vb; Wed, 11 Oct 2023 09:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1qqXgg-0007P8-Ly
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:47:38 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1qqXgf-0006j2-0T
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:47:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C0BC861BD5;
 Wed, 11 Oct 2023 11:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073EAC433C9;
 Wed, 11 Oct 2023 11:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697024848;
 bh=5eol+w9isDPPTceO0nec+Q5JC7nAOskqOPXHsIAf75Q=;
 h=From:To:Cc:Subject:Date:From;
 b=rn63VAU0/bWUAp3lCxWWpkSw9gd9a42ATMVADGPkaClKeM6rE5K2L3RtE0+uAMYeS
 8tu7jbJSDzs+gLhP+5LZK8j8Gg4F8Zr4jd2pf1PuhaPXprA9XeS6lu5f/Kd20pxWTg
 qc5D1dnzOnztti8h0IlLDHg52+bahm8Edro1oexxTO5TnwfqWAbL8wMybH7HVghNXB
 2v/XkKWu1P9WLthhCx5fxuV55ZKZZUflHJypPLIg/WT/62a/6c2Tume2Yc8hcl00S6
 ptFuxGkq6EEdNl3n7SW7ygbHETur+TiHQXsOpzFXjkkqLpfLjKJmHDms62y6rfV3ts
 7BAeo8HCGH/5A==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] riscv, qemu_fw_cfg: Add support for RISC-V architecture
Date: Wed, 11 Oct 2023 13:47:21 +0200
Message-Id: <20231011114721.193732-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:31:52 -0400
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

From: Björn Töpel <bjorn@rivosinc.com>

Qemu fw_cfg support was missing for RISC-V, which made it hard to do
proper vmcore dumps from qemu.

Add the missing RISC-V arch-defines.

You can now do vmcore dumps from qemu. Add "-device vmcoreinfo" to the
qemu command-line. From the qemu montior:
  (qemu) dump-guest-memory vmcore

The vmcore can now be used, e.g., with the "crash" utility.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/firmware/Kconfig       | 2 +-
 drivers/firmware/qemu_fw_cfg.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index b59e3041fd62..f05ff56629b3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -155,7 +155,7 @@ config RASPBERRYPI_FIRMWARE
 
 config FW_CFG_SYSFS
 	tristate "QEMU fw_cfg device support in sysfs"
-	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || SPARC || X86)
+	depends on SYSFS && (ARM || ARM64 || PARISC || PPC_PMAC || RISCV || SPARC || X86)
 	depends on HAS_IOPORT_MAP
 	default n
 	help
diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index a69399a6b7c0..1448f61173b3 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -211,7 +211,7 @@ static void fw_cfg_io_cleanup(void)
 
 /* arch-specific ctrl & data register offsets are not available in ACPI, DT */
 #if !(defined(FW_CFG_CTRL_OFF) && defined(FW_CFG_DATA_OFF))
-# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
+# if (defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_RISCV))
 #  define FW_CFG_CTRL_OFF 0x08
 #  define FW_CFG_DATA_OFF 0x00
 #  define FW_CFG_DMA_OFF 0x10

base-commit: 1c8b86a3799f7e5be903c3f49fcdaee29fd385b5
-- 
2.39.2


