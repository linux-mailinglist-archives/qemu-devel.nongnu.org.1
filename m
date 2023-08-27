Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151C6789FE2
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 17:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaHWi-000878-IY; Sun, 27 Aug 2023 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWd-00085f-1U
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:18:05 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWZ-0006MP-Aw
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:18:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A367B60B5B;
 Sun, 27 Aug 2023 15:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE51C433C9;
 Sun, 27 Aug 2023 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693149477;
 bh=/QhnCG1n9XlObV83D3BWo3qXZwJLh8PEl4X2ZK1Xi7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LOcQIA9y60pUzHhZ4NXMyuSFSz1iOEMY9iae4E3ToAGfQCpHhJDV/PoUY8/ESPaM9
 a45GtzWfHJ/+y5xPZI+0mDRaRgPcSYYyCq6WkGDwqxyOzFXUAHS/I8lf+If+99IDhV
 Y5ljMN5k7srvNorIUbb+w3FO2A4Kk/NEvFFoYFGjpGRmpS6vw7eFdcaQ7Jc3f57n74
 gDKJKy1QJKM+wECvilqydqpKINqMjTsMdwpKtxl+E/YLYSxXp6KdhrKCyFj2A5mbYU
 DQs8N/OYEpkkMNHK5LtMb1aWpnQ+C5GfRl+sSqxj4K/NUdEQ54+5O8J7/phEIti23J
 B0+3ttPbWfprQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/5] target/hppa: Use privilege helper in
 hppa_get_physical_address()
Date: Sun, 27 Aug 2023 17:17:45 +0200
Message-ID: <20230827151747.290653-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827151747.290653-1-deller@kernel.org>
References: <20230827151747.290653-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Convert hppa_get_physical_address() to use the privilege helper macro.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/mem_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 6f04c101dd..46c3dcaf15 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -73,7 +73,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot)
 {
     hwaddr phys;
-    int prot, r_prot, w_prot, x_prot;
+    int prot, r_prot, w_prot, x_prot, priv;
     hppa_tlb_entry *ent;
     int ret = -1;
 
@@ -97,9 +97,10 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     phys = ent->pa + (addr & ~TARGET_PAGE_MASK);
 
     /* Map TLB access_rights field to QEMU protection.  */
-    r_prot = (mmu_idx <= ent->ar_pl1) * PAGE_READ;
-    w_prot = (mmu_idx <= ent->ar_pl2) * PAGE_WRITE;
-    x_prot = (ent->ar_pl2 <= mmu_idx && mmu_idx <= ent->ar_pl1) * PAGE_EXEC;
+    priv = MMU_IDX_TO_PRIV(mmu_idx);
+    r_prot = (priv <= ent->ar_pl1) * PAGE_READ;
+    w_prot = (priv <= ent->ar_pl2) * PAGE_WRITE;
+    x_prot = (ent->ar_pl2 <= priv && priv <= ent->ar_pl1) * PAGE_EXEC;
     switch (ent->ar_type) {
     case 0: /* read-only: data page */
         prot = r_prot;
-- 
2.41.0


