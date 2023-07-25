Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7190761A91
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:52:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINN-00060U-Od; Tue, 25 Jul 2023 09:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMN-0005JC-Qe; Tue, 25 Jul 2023 09:45:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMJ-0001Sk-PH; Tue, 25 Jul 2023 09:45:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2A356160F1;
 Tue, 25 Jul 2023 16:45:34 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DCA31194B4;
 Tue, 25 Jul 2023 16:45:31 +0300 (MSK)
Received: (nullmailer pid 3370810 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 09/31] target/s390x: Fix LRA overwriting the top 32
 bits on DAT error
Date: Tue, 25 Jul 2023 16:44:54 +0300
Message-Id: <20230725134517.3370706-9-mjt@tls.msk.ru>
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

When a DAT error occurs, LRA is supposed to write the error information
to the bottom 32 bits of R1, and leave the top 32 bits of R1 alone.

Fix by passing the original value of R1 into helper and copying the
top 32 bits to the return value.

Fixes: d8fe4a9c284f ("target-s390: Convert LRA")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20230704081506.276055-6-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 6da311a60d58dba27f5f790217d5ebba944e34ab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index f629f0fbcf..5038cfe851 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -359,7 +359,7 @@ DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_2(lra, i64, env, i64)
+DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 7141d0ad88..51894f17f5 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2374,7 +2374,7 @@ void HELPER(purge)(CPUS390XState *env)
 }
 
 /* load real address */
-uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
+uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
 {
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
@@ -2388,7 +2388,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     exc = mmu_translate(env, addr, MMU_S390_LRA, asc, &ret, &flags, &tec);
     if (exc) {
         cc = 3;
-        ret = exc | 0x80000000;
+        ret = (r1 & 0xFFFFFFFF00000000ULL) | exc | 0x80000000;
     } else {
         cc = 0;
         ret |= addr & ~TARGET_PAGE_MASK;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0c22d2f17f..c7498ff3f2 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2941,7 +2941,7 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lra(o->out, cpu_env, o->in2);
+    gen_helper_lra(o->out, cpu_env, o->out, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
 }
-- 
2.39.2


