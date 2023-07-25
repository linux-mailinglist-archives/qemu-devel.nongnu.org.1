Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CEE761A61
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINT-0006Xq-3N; Tue, 25 Jul 2023 09:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMO-0005Jf-Sq; Tue, 25 Jul 2023 09:45:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIML-0001T1-Um; Tue, 25 Jul 2023 09:45:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D0F5160F2;
 Tue, 25 Jul 2023 16:45:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0C7A8194B5;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: (nullmailer pid 3370813 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 10/31] target/s390x: Fix LRA when DAT is off
Date: Tue, 25 Jul 2023 16:44:55 +0300
Message-Id: <20230725134517.3370706-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

LRA should perform DAT regardless of whether it's on or off.
Disable DAT check for MMU_S390_LRA.

Fixes: defb0e3157af ("s390x: Implement opcode helpers")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20230704081506.276055-7-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit b0ef81062d2404ccef0289b1cc6e70244901c9be)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b04b57c235..fbb2f1b4d4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -417,7 +417,7 @@ int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint64_t asc,
 
     vaddr &= TARGET_PAGE_MASK;
 
-    if (!(env->psw.mask & PSW_MASK_DAT)) {
+    if (rw != MMU_S390_LRA && !(env->psw.mask & PSW_MASK_DAT)) {
         *raddr = vaddr;
         goto nodat;
     }
-- 
2.39.2


