Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8721A74D546
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoP-0000rS-Mz; Mon, 10 Jul 2023 08:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpoC-0000l9-3U
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo8-0003Om-1Z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQHrYo9ktGwu4MQIuHyHLJzMGRXoDB86nuz87enATSs=;
 b=RGC7l0mzuTlFk9At+qE1/XDArWK3NuBM8O/L8WtYQ+QHhuzSzBcllnlgT79ipOmiZQG6pj
 vI/SiPRaeHOzbnqid0VgusPoRhOb2+zqeVocpBQjvGQfJiiwwy0qkKQXAGkMMYm8PJpwvm
 b4KYGSsRHKxkzVazyGIm0hdKLZKP53c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-aeDE7CI0PrGGB2zxtF8efA-1; Mon, 10 Jul 2023 08:15:55 -0400
X-MC-Unique: aeDE7CI0PrGGB2zxtF8efA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A407E381D1F4;
 Mon, 10 Jul 2023 12:15:54 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2FBF5CFA;
 Mon, 10 Jul 2023 12:15:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 06/21] target/s390x: Fix LRA overwriting the top 32 bits on DAT
 error
Date: Mon, 10 Jul 2023 14:15:28 +0200
Message-Id: <20230710121543.197250-7-thuth@redhat.com>
In-Reply-To: <20230710121543.197250-1-thuth@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 target/s390x/helper.h         | 2 +-
 target/s390x/tcg/mem_helper.c | 4 ++--
 target/s390x/tcg/translate.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6bc01df73d..05102578fc 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -355,7 +355,7 @@ DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
 DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
-DEF_HELPER_2(lra, i64, env, i64)
+DEF_HELPER_3(lra, i64, env, i64, i64)
 DEF_HELPER_1(per_check_exception, void, env)
 DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 84ad85212c..f417fb1183 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -2356,7 +2356,7 @@ void HELPER(purge)(CPUS390XState *env)
 }
 
 /* load real address */
-uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
+uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
 {
     uint64_t asc = env->psw.mask & PSW_MASK_ASC;
     uint64_t ret, tec;
@@ -2370,7 +2370,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
     exc = mmu_translate(env, addr, MMU_S390_LRA, asc, &ret, &flags, &tec);
     if (exc) {
         cc = 3;
-        ret = exc | 0x80000000;
+        ret = (r1 & 0xFFFFFFFF00000000ULL) | exc | 0x80000000;
     } else {
         cc = 0;
         ret |= addr & ~TARGET_PAGE_MASK;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 0cef6efbef..a6079ab7b4 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2932,7 +2932,7 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
 
 static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lra(o->out, cpu_env, o->in2);
+    gen_helper_lra(o->out, cpu_env, o->out, o->in2);
     set_cc_static(s);
     return DISAS_NEXT;
 }
-- 
2.39.3


