Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373327C9630
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 21:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrkli-0003zc-4k; Sat, 14 Oct 2023 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklZ-0003tK-Am
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:41 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qrklW-0004Yz-Op
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 15:57:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 46840B80B72;
 Sat, 14 Oct 2023 19:57:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0A9C433C7;
 Sat, 14 Oct 2023 19:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697313449;
 bh=Jl2KdCBw2z5J958OgozApqgwsvMeiX/PPsEA0t441bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E7mOIZTtjXfLyxtifpK5kJc5tjYVnAQetAYOs/LzywzlZg6cfAu90jQDbPFFPk6uA
 V6t8S2sQvPcqBndxtM1OxXgRl5Zq/FryzfirdGnLkoFwWynwi6oCfQS0XXzIfDoPsJ
 nkSfFWi3QeuESzJiApSyhfGSvikbMkIM1CP4tv+dBRNb8JqzUSsO8t3XweFQnFcvGJ
 /446CGSw1kHoB/Vav905/lDod2AJva0EMVG8UvmkWxXooLkHxTNC1YtNFpGAInEsCI
 4IjkDqAq0DCFVncwAlQFfvFk7Eswx/fMayN5m/33U4lNApy7lJBzDshl40A7LSs665
 Kng01013apxOQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 04/12] MAINTAINERS: Add Astro PCI host for hppa machines
Date: Sat, 14 Oct 2023 21:57:11 +0200
Message-ID: <20231014195719.151397-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014195719.151397-1-deller@kernel.org>
References: <20231014195719.151397-1-deller@kernel.org>
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
 MAINTAINERS | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ceea4c2bf2..68d086a0f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1174,7 +1174,7 @@ F: hw/*/etraxfs_*.c
 
 HP-PARISC Machines
 ------------------
-HP B160L
+HP B160L, HP C3700
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Helge Deller <deller@gmx.de>
 S: Odd Fixes
@@ -1182,11 +1182,14 @@ F: configs/devices/hppa-softmmu/default.mak
 F: hw/hppa/
 F: hw/net/*i82596*
 F: hw/misc/lasi.c
+F: hw/pci-host/astro.c
 F: hw/pci-host/dino.c
 F: include/hw/misc/lasi.h
 F: include/hw/net/lasi_82596.h
+F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
+F: roms/seabios-hppa/
 
 LoongArch Machines
 ------------------
-- 
2.41.0


