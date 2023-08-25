Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B778806B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 08:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZQkb-00069K-CB; Fri, 25 Aug 2023 02:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkW-000688-P9
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:52 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZQkU-0007Y0-M3
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 02:56:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0762562D34;
 Fri, 25 Aug 2023 06:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA8FC433C8;
 Fri, 25 Aug 2023 06:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692946608;
 bh=jj6VCafdXtZ0ti0M1QbCs6Yx24ov6Jbm0/NprowIN2g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mGOve1omiZ3HtOKMYXTTl6mb0hsd5dhP1t4vm5VhCIto/6pZULS8jtLMjP0sdjaoM
 eCuFBObkPS55kBSbq3zpOFgFCipPkaadNIp2dEVheWd/ipma+vdsv6PS7xfhCzO7wj
 lGHQ7HDNQeLb3cghBjGLgsd8i/iEnm1jNvWFsOCGr93B3iLilQC/bvLTpqYdlh7muW
 Oq7WICLYgjJQtnDSH5aqUQtJ6HfGrV7XeHQ2K6yRhAZhdmPGPBmpmOy7C4fLZYa3++
 EXE4rnXslTITIFEDsrhYM20RM8wNf6sB5PCSFlJHAL17pfY1zu9TaC3xhvvIqbjcgo
 8eLR/kw9IdteQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v2 5/5] target/hppa: Switch to use MMU indices 11-15
Date: Fri, 25 Aug 2023 08:56:38 +0200
Message-ID: <20230825065638.7262-6-deller@kernel.org>
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

The MMU indices 9-15 will use shorter assembler instructions
when run on a x86-64 host. So, switch over to those to get
smaller code and maybe minimally faster emulation.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 6623712644..fa13694dab 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -30,14 +30,14 @@
    basis.  It's probably easier to fall back to a strong memory model.  */
 #define TCG_GUEST_DEFAULT_MO        TCG_MO_ALL
 
-#define MMU_KERNEL_IDX   0
-#define MMU_PL1_IDX      1
-#define MMU_PL2_IDX      2
-#define MMU_USER_IDX     3
-#define MMU_PHYS_IDX     4
-
-#define PRIV_TO_MMU_IDX(priv)    (priv)
-#define MMU_IDX_TO_PRIV(mmu_idx) (mmu_idx)
+#define MMU_KERNEL_IDX   11
+#define MMU_PL1_IDX      12
+#define MMU_PL2_IDX      13
+#define MMU_USER_IDX     14
+#define MMU_PHYS_IDX     15
+
+#define PRIV_TO_MMU_IDX(priv)    (MMU_KERNEL_IDX + (priv))
+#define MMU_IDX_TO_PRIV(mmu_idx) ((mmu_idx) - MMU_KERNEL_IDX)
 
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-- 
2.41.0


