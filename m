Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684877EDC35
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:46:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X4z-00071H-AI; Thu, 16 Nov 2023 02:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X4M-0006G2-LJ; Thu, 16 Nov 2023 02:45:46 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X4K-0005Zj-OG; Thu, 16 Nov 2023 02:45:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B240233BE8;
 Thu, 16 Nov 2023 10:45:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4A1F83584E;
 Thu, 16 Nov 2023 10:44:42 +0300 (MSK)
Received: (nullmailer pid 3202532 invoked by uid 1000);
 Thu, 16 Nov 2023 07:44:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 15/27] target/hppa: spelling fixes: Indicies, Truely
Date: Thu, 16 Nov 2023 10:44:29 +0300
Message-Id: <20231116074441.3202417-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231116074441.3202417-1-mjt@tls.msk.ru>
References: <20231116074441.3202417-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: bb67ec32a0bb "target/hppa: Include PSW_P in tb flags and mmu index"
Fixes: d7553f3591bb "target/hppa: Populate an interval tree with valid tlb entries"
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 target/hppa/cpu.h     | 2 +-
 target/hppa/machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index bcfed04f7c..8be45c69c9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -56,7 +56,7 @@
          1 << MMU_PL2_IDX    | 1 << MMU_PL2_P_IDX    |  \
          1 << MMU_USER_IDX   | 1 << MMU_USER_P_IDX)
 
-/* Indicies to flush for access_id changes. */
+/* Indices to flush for access_id changes. */
 #define HPPA_MMU_FLUSH_P_MASK \
         (1 << MMU_KERNEL_P_IDX | 1 << MMU_PL1_P_IDX  |  \
          1 << MMU_PL2_P_IDX    | 1 << MMU_USER_P_IDX)
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 2f8e8cc5a1..15cbc5e6d0 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -129,7 +129,7 @@ static int tlb_post_load(void *opaque, int version_id)
 
     /*
      * Re-create the interval tree from the valid entries.
-     * Truely invalid entries should have start == end == 0.
+     * Truly invalid entries should have start == end == 0.
      * Otherwise it should be the in-flight tlb_partial entry.
      */
     for (uint32_t i = 0; i < ARRAY_SIZE(env->tlb); ++i) {
-- 
2.39.2


