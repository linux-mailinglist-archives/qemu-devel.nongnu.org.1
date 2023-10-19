Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ABD7D0518
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 00:54:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtbtK-0008AR-Ge; Thu, 19 Oct 2023 18:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtH-00088A-Uw
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:20 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtF-0002fV-OD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:19 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 39316CE32A5;
 Thu, 19 Oct 2023 22:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAAFC433C8;
 Thu, 19 Oct 2023 22:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697755993;
 bh=YAOsCYw+oe8yoNCu2Ef5fy0wU/iJfBxizrjqXL2e3R0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NAvGk6NQ0vX2K/yPnQE8Mi+xcECAFdR3SMb1z6YkiqJbZh6+T23ZbRNJrM7lpxvRc
 VNYppDKc48g91pAPq6iEXXw6RSQDyHIHuXcVga2qV4RLhPQ5ltRoyBqTWcG7H2IGv1
 8KwbKxhtfP0dj1R8AoyM13IH2rq/3ge3Oee/xTpJYrO5/RzkUB16G7ebfo0jfJ2Sbn
 kk6C1l6kzwNWllFhXUSPJhsvAPoIZGQx3SZV0w2ELOBV0I4tz26VJFHPCYxK3Tb58L
 xbsUURlNlkM1GdlDyjGHiIzd1Po5NvtFskc9c2FhrjBruwbgqUV/m0U0wmX7PTwBnD
 mX7nBGMHGLoCQ==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/11] MAINTAINERS: Update HP-PARISC entries
Date: Fri, 20 Oct 2023 00:52:53 +0200
Message-ID: <20231019225257.383071-8-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019225257.383071-1-deller@kernel.org>
References: <20231019225257.383071-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
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

Add the new HP C3700 machine, the new Astro PCI host and
add the missing entry for the seabios-hppa directory.

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


