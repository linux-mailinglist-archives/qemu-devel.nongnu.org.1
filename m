Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C089EC29
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 09:35:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSMP-00017r-Ne; Wed, 10 Apr 2024 03:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLY-0006Jw-7g; Wed, 10 Apr 2024 03:26:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSLS-0004aV-Lw; Wed, 10 Apr 2024 03:26:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E4E245D692;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B756B02D3;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191752 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 35/87] target/i386: introduce function to query MMU
 indices
Date: Wed, 10 Apr 2024 10:22:08 +0300
Message-Id: <20240410072303.4191455-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Remove knowledge of specific MMU indexes (other than MMU_NESTED_IDX and
MMU_PHYS_IDX) from mmu_translate().  This will make it possible to split
32-bit and 64-bit MMU indexes.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 5f97afe2543f09160a8d123ab6e2e8c6d98fa9ce)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: context fixup in target/i386/cpu.h due to other changes in that area)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 705d925e6c..df1f602758 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2302,6 +2302,16 @@ static inline int cpu_mmu_index(CPUX86State *env, bool ifetch)
         ? MMU_KNOSMAP_IDX : MMU_KSMAP_IDX;
 }
 
+static inline bool is_mmu_index_smap(int mmu_index)
+{
+    return mmu_index == MMU_KSMAP_IDX;
+}
+
+static inline bool is_mmu_index_user(int mmu_index)
+{
+    return mmu_index == MMU_USER_IDX;
+}
+
 static inline bool is_mmu_index_32(int mmu_index)
 {
     assert(mmu_index < MMU_PHYS_IDX);
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index e16d3a69d1..18fde700c1 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -136,7 +136,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
 {
     const target_ulong addr = in->addr;
     const int pg_mode = in->pg_mode;
-    const bool is_user = (in->mmu_idx == MMU_USER_IDX);
+    const bool is_user = is_mmu_index_user(in->mmu_idx);
     const MMUAccessType access_type = in->access_type;
     uint64_t ptep, pte, rsvd_mask;
     PTETranslate pte_trans = {
@@ -357,7 +357,7 @@ do_check_protect_pse36:
     }
 
     int prot = 0;
-    if (in->mmu_idx != MMU_KSMAP_IDX || !(ptep & PG_USER_MASK)) {
+    if (!is_mmu_index_smap(in->mmu_idx) || !(ptep & PG_USER_MASK)) {
         prot |= PAGE_READ;
         if ((ptep & PG_RW_MASK) || !(is_user || (pg_mode & PG_MODE_WP))) {
             prot |= PAGE_WRITE;
-- 
2.39.2


