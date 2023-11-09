Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C647E6C32
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:11:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15hP-0000yx-Nc; Thu, 09 Nov 2023 09:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15en-0003lk-6s; Thu, 09 Nov 2023 09:05:19 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ek-0007lG-3s; Thu, 09 Nov 2023 09:05:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB24631BF4;
 Thu,  9 Nov 2023 16:59:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C37DB3452B;
 Thu,  9 Nov 2023 16:59:50 +0300 (MSK)
Received: (nullmailer pid 1462961 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:47 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 60/62] target/s390x: Fix LAALG not updating cc_src
Date: Thu,  9 Nov 2023 16:59:28 +0300
Message-Id: <20231109135933.1462615-60-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
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

LAALG uses op_laa() and wout_addu64(). The latter expects cc_src to be
set, but the former does not do it. This can lead to assertion failures
if something sets cc_src to neither 0 nor 1 before.

Fix by introducing op_laa_addu64(), which sets cc_src, and using it for
LAALG.

Fixes: 4dba4d6fef61 ("target/s390x: Use atomic operations for LOAD AND OP")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231106093605.1349201-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit bea402482a8c94389638cbd3d7fe3963fb317f4c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0e328ea0fd..7c3362d2e7 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -442,7 +442,7 @@
     D(0xebe8, LAAG,    RSY_a, ILA, r3, a2, new, in2_r1, laa, adds64, MO_TEUQ)
 /* LOAD AND ADD LOGICAL */
     D(0xebfa, LAAL,    RSY_a, ILA, r3_32u, a2, new, in2_r1_32, laa, addu32, MO_TEUL)
-    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa, addu64, MO_TEUQ)
+    D(0xebea, LAALG,   RSY_a, ILA, r3, a2, new, in2_r1, laa_addu64, addu64, MO_TEUQ)
 /* LOAD AND AND */
     D(0xebf4, LAN,     RSY_a, ILA, r3_32s, a2, new, in2_r1_32, lan, nz32, MO_TESL)
     D(0xebe4, LANG,    RSY_a, ILA, r3, a2, new, in2_r1, lan, nz64, MO_TEUQ)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ff64d6c28f..b0173e968e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2809,17 +2809,32 @@ static DisasJumpType op_kxb(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+static DisasJumpType help_laa(DisasContext *s, DisasOps *o, bool addu64)
 {
     /* The real output is indeed the original value in memory;
        recompute the addition for the computation of CC.  */
     tcg_gen_atomic_fetch_add_i64(o->in2, o->in2, o->in1, get_mem_index(s),
                                  s->insn->data | MO_ALIGN);
     /* However, we need to recompute the addition for setting CC.  */
-    tcg_gen_add_i64(o->out, o->in1, o->in2);
+    if (addu64) {
+        tcg_gen_movi_i64(cc_src, 0);
+        tcg_gen_add2_i64(o->out, cc_src, o->in1, cc_src, o->in2, cc_src);
+    } else {
+        tcg_gen_add_i64(o->out, o->in1, o->in2);
+    }
     return DISAS_NEXT;
 }
 
+static DisasJumpType op_laa(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, false);
+}
+
+static DisasJumpType op_laa_addu64(DisasContext *s, DisasOps *o)
+{
+    return help_laa(s, o, true);
+}
+
 static DisasJumpType op_lan(DisasContext *s, DisasOps *o)
 {
     /* The real output is indeed the original value in memory;
-- 
2.39.2


