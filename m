Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4617B2E70
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DY-00056m-Qz; Fri, 29 Sep 2023 04:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DK-0004xN-SY
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bh-L2
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AMZbLYPBV1xCTpn0hbevuva2cgsCsR3rt8ss4bjxa7M=;
 b=itqpEFpBbo0HPfBSgEdd7V7MplauhHztKSHAwcF8AeCFMLciC49u4NMuGIe8HUrIkKv7DN
 wx+rookXta3ONZOlqwdGfdx+MncGUbM6OpXNlyvPTXbXE5YYrPh6XMJGuDe74NsoBT/KnL
 Aaz1+pVHjVnqNGd+mb+mjya9xsAsgUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-L5gqqdaWP2WDBbIr-vM03w-1; Fri, 29 Sep 2023 04:50:56 -0400
X-MC-Unique: L5gqqdaWP2WDBbIr-vM03w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A48F6185A790;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6613740C6EC0;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69AF821E6912; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 09/56] target/arm/tcg: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:06 +0200
Message-ID: <20230929085053.2789105-10-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Fix:

  target/arm/tcg/translate-m-nocp.c: In function ‘gen_M_fp_sysreg_read’:
  target/arm/tcg/translate-m-nocp.c:509:18: warning: declaration of ‘tmp’ shadows a previous local [-Wshadow=compatible-local]
    509 |         TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
        |                  ^~~
  target/arm/tcg/translate-m-nocp.c:433:14: note: shadowed declaration is here
    433 |     TCGv_i32 tmp;
        |              ^~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘helper_mve_vqshlsb’:
  target/arm/tcg/mve_helper.c:1259:19: warning: declaration of ‘r’ shadows a previous local [-Wshadow=compatible-local]
   1259 |         typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32);  \
        |                   ^
  target/arm/tcg/mve_helper.c:1267:5: note: in expansion of macro ‘WRAP_QRSHL_HELPER’
   1267 |     WRAP_QRSHL_HELPER(do_sqrshl_bhs, N, M, false, satp)
        |     ^~~~~~~~~~~~~~~~~
  target/arm/tcg/mve_helper.c:927:22: note: in expansion of macro ‘DO_SQSHL_OP’
    927 |             TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
        |                      ^~
  target/arm/tcg/mve_helper.c:945:5: note: in expansion of macro ‘DO_2OP_SAT’
    945 |     DO_2OP_SAT(OP##b, 1, int8_t, FN)            \
        |     ^~~~~~~~~~
  target/arm/tcg/mve_helper.c:1277:1: note: in expansion of macro ‘DO_2OP_SAT_S’
   1277 | DO_2OP_SAT_S(vqshls, DO_SQSHL_OP)
        | ^~~~~~~~~~~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘do_sqrshl48_d’:
  target/arm/tcg/mve_helper.c:2463:17: warning: declaration of ‘extval’ shadows a previous local [-Wshadow=compatible-local]
   2463 |         int64_t extval = sextract64(src << shift, 0, 48);
        |                 ^~~~~~
  target/arm/tcg/mve_helper.c:2443:18: note: shadowed declaration is here
   2443 |     int64_t val, extval;
        |                  ^~~~~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘do_uqrshl48_d’:
  target/arm/tcg/mve_helper.c:2495:18: warning: declaration of ‘extval’ shadows a previous local [-Wshadow=compatible-local]
   2495 |         uint64_t extval = extract64(src << shift, 0, 48);
        |                  ^~~~~~
  target/arm/tcg/mve_helper.c:2479:19: note: shadowed declaration is here
   2479 |     uint64_t val, extval;
        |                   ^~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-3-philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/arm/tcg/mve_helper.c       | 16 ++++++++--------
 target/arm/tcg/translate-m-nocp.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index c666a96ba1..8b99736aad 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -925,8 +925,8 @@ DO_1OP_IMM(vorri, DO_ORRI)
         bool qc = false;                                                \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
             bool sat = false;                                           \
-            TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
-            mergemask(&d[H##ESIZE(e)], r, mask);                        \
+            TYPE r_ = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);         \
+            mergemask(&d[H##ESIZE(e)], r_, mask);                       \
             qc |= sat & mask & 1;                                       \
         }                                                               \
         if (qc) {                                                       \
@@ -1250,11 +1250,11 @@ DO_2OP_SAT(vqsubsw, 4, int32_t, DO_SQSUB_W)
 #define WRAP_QRSHL_HELPER(FN, N, M, ROUND, satp)                        \
     ({                                                                  \
         uint32_t su32 = 0;                                              \
-        typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32);  \
+        typeof(N) qrshl_ret = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32); \
         if (su32) {                                                     \
             *satp = true;                                               \
         }                                                               \
-        r;                                                              \
+        qrshl_ret;                                                      \
     })
 
 #define DO_SQSHL_OP(N, M, satp) \
@@ -1292,12 +1292,12 @@ DO_2OP_SAT_U(vqrshlu, DO_UQRSHL_OP)
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
             bool sat = false;                                           \
             if ((e & 1) == XCHG) {                                      \
-                TYPE r = FN(n[H##ESIZE(e)],                             \
+                TYPE vqdmladh_ret = FN(n[H##ESIZE(e)],                  \
                             m[H##ESIZE(e - XCHG)],                      \
                             n[H##ESIZE(e + (1 - 2 * XCHG))],            \
                             m[H##ESIZE(e + (1 - XCHG))],                \
                             ROUND, &sat);                               \
-                mergemask(&d[H##ESIZE(e)], r, mask);                    \
+                mergemask(&d[H##ESIZE(e)], vqdmladh_ret, mask);         \
                 qc |= sat & mask & 1;                                   \
             }                                                           \
         }                                                               \
@@ -2454,7 +2454,7 @@ static inline int64_t do_sqrshl48_d(int64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        int64_t extval = sextract64(src << shift, 0, 48);
+        extval = sextract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
@@ -2486,7 +2486,7 @@ static inline uint64_t do_uqrshl48_d(uint64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        uint64_t extval = extract64(src << shift, 0, 48);
+        extval = extract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 33f6478bb9..42308c4db5 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -506,7 +506,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
 
         gen_branch_fpInactive(s, TCG_COND_EQ, lab_active);
         /* fpInactive case: reads as FPDSCR_NS */
-        TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
+        tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
         storefn(s, opaque, tmp, true);
         lab_end = gen_new_label();
         tcg_gen_br(lab_end);
-- 
2.41.0


