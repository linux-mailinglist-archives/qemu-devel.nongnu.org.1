Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C24788064
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 08:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQkZ-00068f-1a; Fri, 25 Aug 2023 02:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkQ-000674-U2
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:46 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkO-0007X5-Oi
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A971062D34;
 Fri, 25 Aug 2023 06:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF56C433C8;
 Fri, 25 Aug 2023 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692946603;
 bh=NvQBxQAHTMb8qYx5lzwNVD4iX5uQmG5G6+mCxHboXQA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B72XUwwpT4Ij9HaFoRdhv1mF0GgslSuXqUvKNbv/yo1Jyzah2lXt/NhBNmR0mqxf2
 HWeaoT/7sotjnh0RvF6JcBtyPhd1+u51AgrgYpR0io8y+nIb7qEF1RKieuhcqPSzO8
 3ykleqZGrZBk9InwXpCLzJmkcb1rNErTFBM/xPpNYCnHGtPkpWBY3x0eOIlFQm/+P9
 qMLOrekdmsaDy7oPOtrW1b/e1kdoHsgwx+QhcQdx3dccE9URf7HxeWOVmpskTMaIKz
 wSfGjhCqclle7Io/Ksi1FUjsIJNiUqYFqzQpcs1r+bLJMAKRxfjqiLVl/dfGadlTw8
 /fz0FB6JZXohg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 1/5] target/hppa: Add missing PL1 and PL2 privilege levels
Date: Fri, 25 Aug 2023 08:56:34 +0200
Message-ID: <20230825065638.7262-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825065638.7262-1-deller@kernel.org>
References: <20230825065638.7262-1-deller@kernel.org>
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

The hppa CPU has 4 privilege levels (0-3).
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


