Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54089787CB5
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 03:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZLES-0007Vz-2K; Thu, 24 Aug 2023 21:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVZ-0002dv-S7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:49 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVX-0001fT-Dy
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id E1BE263CAE;
 Thu, 24 Aug 2023 21:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E1BC433C8;
 Thu, 24 Aug 2023 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692911079;
 bh=W6BEb7EQIbRltudB7kn49iBM4xJcma5CKQeiyGLwgys=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZVWUq6Wcg/477pPJrxzTy5xuUyvF4JpgnVMr92WLVUt/5J4LslfnrtvJ2qwhm6Q4G
 JT7WZ5LFDr5eBX6nuJ9hI0Sze8kW4I514lS0/8kpl8h4GkwNFXlW/W0UkkAKcHwhVB
 KvY9YH9n+wwF879VqJ5sFx0RQoLRI2pYKgMAocUMacNMczy4SET4cQFFaTCXNe9o9K
 xyPZTzRZHnr3aKurcCwb+YNw8MkCOI0emz/+n9wTDzwDsF/3lRD4eOpc7iOfbwrnJo
 +ejyfwg80VmG3Jt6SFjGymsYF6d1qYMrLS61aBRdFLv90mAs5sQqOAp4wrKSHjSb5r
 9GuWbIXiLD9eQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 1/5] target/hppa: Add missing PL1 and PL2 priviledge levels
Date: Thu, 24 Aug 2023 23:04:30 +0200
Message-ID: <20230824210434.151971-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824210434.151971-1-deller@kernel.org>
References: <20230824210434.151971-1-deller@kernel.org>
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
X-Mailman-Approved-At: Thu, 24 Aug 2023 21:03:17 -0400
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

The hppa CPU has 4 priviledge levels (0-3).
Mention the missing PL1 and PL2 levels, although the Linux kernel
uses only 0 (KERNEL) and 3 (USER). Not sure about HP-UX.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 75c5c0ccf7..6c5b0e67c8 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -31,8 +31,11 @@
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
 #define MMU_KERNEL_IDX   0
+#define MMU_PL1_IDX      1
+#define MMU_PL2_IDX      2
 #define MMU_USER_IDX     3
 #define MMU_PHYS_IDX     4
+
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
 /* Hardware exceptions, interrupts, faults, and traps.  */
-- 
2.41.0


