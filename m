Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E93E7CC7DD
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 17:47:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsmHg-0005wr-Dt; Tue, 17 Oct 2023 11:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHd-0005wR-W1
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:02 -0400
Received: from ams.source.kernel.org ([145.40.68.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qsmHc-000331-Bk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 11:47:01 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 2E41AB81EB5;
 Tue, 17 Oct 2023 15:46:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C06C433C8;
 Tue, 17 Oct 2023 15:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697557617;
 bh=Jl2KdCBw2z5J958OgozApqgwsvMeiX/PPsEA0t441bw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P8D9Nhl8DT8plgdejS+q40Firj0yZ3APKBQ2ZFQcsyo19icODbfGObv8Hf7rBMZcI
 mMB22l0pXpaV4t0mlrDCBytzvz/UHskowNUU7ffy1/pldGgUZpL+OjQ0iR16mhebew
 +GnEfX4QblpsnRzo8i350xlOto6pX9hAp99TsfX5zPE3QFmxLClEoEDynRR1eINZQq
 pBMRCCZrAznz/LRqncAzhrIC7YkiR+kXKWwiaiQ+97hQpGKhh5vTthwoccCLnRxvr2
 3izrWUBA2iR/EfERbdFfh54hL7w01u+zXOwJGsOSZPmCi7BO7NtbvcYa4/OIkVB4+x
 J1XLIyiqduunQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 04/11] MAINTAINERS: Add Astro PCI host for hppa machines
Date: Tue, 17 Oct 2023 17:46:38 +0200
Message-ID: <20231017154645.95844-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017154645.95844-1-deller@kernel.org>
References: <20231017154645.95844-1-deller@kernel.org>
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


