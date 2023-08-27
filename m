Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7F1789FE6
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 17:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaHWg-00084b-8B; Sun, 27 Aug 2023 11:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWX-00084K-N9
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:17:57 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWV-0006Lw-Gs
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:17:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8E260691;
 Sun, 27 Aug 2023 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38EAC433C7;
 Sun, 27 Aug 2023 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693149472;
 bh=bf12EkYhs02Sea64Gguqzg5CpFkL3oXiSeHhMOzt/HM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ipV/1VS8VJvBa2DgvoM2ZK5RR5r1ML4D2PfwrJXP4Aw5lEX07KCAfDJ/seUIswk+N
 IfsVP2qzaQegVP9QKun4sGVzWwjnArrP/UKR4K6b8AbQ4W6e6XNKJ9yIqP3HVrCXVu
 IXWj6edv9lwd+0FFoKeLCL5sMc2ibFjCuNelCc9CM4wmGCQUcBxFhj4RGxvrG9yMi2
 /rMgyQp8ut98bx6aToh5+U3gTbpZVpATXd6wziyW/Jr8H7pDdl1jfGgonn1n7+81z/
 7BoEae1h8HBRoNxGTYg0zJ6/4qdmOskaSAWubHbcAQRstyQl7g/yqib9MMNJA7cKeq
 Fs42Dgfjl9HCA==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] target/hppa: Add missing PL1 and PL2 privilege levels
Date: Sun, 27 Aug 2023 17:17:42 +0200
Message-ID: <20230827151747.290653-2-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827151747.290653-1-deller@kernel.org>
References: <20230827151747.290653-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


