Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABEA7CCAC7
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsou5-000262-00; Tue, 17 Oct 2023 14:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsou2-00024j-4w
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:50 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsotz-0002tq-AN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:34:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 85600615A8;
 Tue, 17 Oct 2023 18:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F35EC433CA;
 Tue, 17 Oct 2023 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697567686;
 bh=gq81V2jyigN9JS/a9mIXeTME4yQ0gG4TgYnxMo6EYcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XL8VJsU4+Kpuyfwgs3mEioG6r/n7qkFRUXIucmvcTJPWKPXGunprff8pPbysVPHxV
 3m5bF46zmYYyAWOhY4MKZ4aV1BgbClRg7d4TmRNlYFz0bYlhMI7w9CTp0bf9POkR6W
 TcHZtqCPKsqJOka31z32rWZ5cqHKfr7JOW2xkiIQzJeLNEuvz2jTttlliFEziN3EzB
 1jAbjgJEUWpqiqAjzc2d1CJCduWNEM+8NSTbe43gv7K5FXToisClWuahgS8V5zq3pI
 1aBxdJIaZH9nDWrgfy+KvCK4H9C+EU+m1QmK51GHSQjI0QxC/TqhGFvMbXhM9B8rQW
 NpyAui2/E1u3w==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 06/11] pci-host: Wire up new Astro/Elroy PCI bridge
Date: Tue, 17 Oct 2023 20:34:27 +0200
Message-ID: <20231017183432.117243-7-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017183432.117243-1-deller@kernel.org>
References: <20231017183432.117243-1-deller@kernel.org>
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

Allow the Astro source to be built.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig         | 1 +
 hw/pci-host/Kconfig     | 4 ++++
 hw/pci-host/meson.build | 1 +
 3 files changed, 6 insertions(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index 5dd8b5b21e..ff8528aaa8 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -3,6 +3,7 @@ config HPPA_B160L
     imply PCI_DEVICES
     imply E1000_PCI
     imply VIRTIO_VGA
+    select ASTRO
     select DINO
     select LASI
     select SERIAL
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index a07070eddf..54a609d2ca 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -82,6 +82,10 @@ config DINO
     bool
     select PCI
 
+config ASTRO
+    bool
+    select PCI
+
 config GT64120
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 64eada76fe..f891f026cb 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -27,6 +27,7 @@ pci_ss.add(when: 'CONFIG_MV64361', if_true: files('mv64361.c'))
 pci_ss.add(when: 'CONFIG_VERSATILE_PCI', if_true: files('versatile.c'))
 
 # HPPA devices
+pci_ss.add(when: 'CONFIG_ASTRO', if_true: files('astro.c'))
 pci_ss.add(when: 'CONFIG_DINO', if_true: files('dino.c'))
 
 system_ss.add_all(when: 'CONFIG_PCI', if_true: pci_ss)
-- 
2.41.0


