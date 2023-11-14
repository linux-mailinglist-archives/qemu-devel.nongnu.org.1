Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4B7EB53B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:01:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wlE-000756-7A; Tue, 14 Nov 2023 11:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wl6-0006rs-63; Tue, 14 Nov 2023 11:59:28 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wks-0004xB-Bp; Tue, 14 Nov 2023 11:59:19 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 179CF3326F;
 Tue, 14 Nov 2023 19:59:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D99E6351F6;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949099 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH trivial 09/21] target/hppa: spelling fixes: Indicies, Truely
Date: Tue, 14 Nov 2023 19:58:22 +0300
Message-Id: <20231114165834.2949011-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h     | 2 +-
 target/hppa/machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index cecec59700..80177c0df8 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -54,7 +54,7 @@
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


