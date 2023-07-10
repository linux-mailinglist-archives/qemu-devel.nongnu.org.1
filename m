Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 190A974D53E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoO-0000pM-6d; Mon, 10 Jul 2023 08:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo9-0000k9-OL
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo7-0003On-DH
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=84ObE6Kq3CWtFXtu+MWDfFwsqObGz+Ce2Ytgo5neX7o=;
 b=ET++KSLShby/2DD58K6j5vtRVMhcbZ54glLXY+FZaOIwiE6zrzrqXyuAyJ2FIIaWYLjikJ
 9DF6FTktqNbSR8dDmoUKYEAL6eBloYH3P0xJtaH4KeOVcOb2epRnw8Z02HW33wBVpRbblv
 /qN7E1D6d0asGkGomgBpva0lupixiR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-9N08pRWoMPae3iXufAMtwg-1; Mon, 10 Jul 2023 08:15:53 -0400
X-MC-Unique: 9N08pRWoMPae3iXufAMtwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97DD38FD7A1;
 Mon, 10 Jul 2023 12:15:51 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 682DBF66B9;
 Mon, 10 Jul 2023 12:15:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 04/21] target/s390x: Fix MDEB and MDEBR
Date: Mon, 10 Jul 2023 14:15:26 +0200
Message-Id: <20230710121543.197250-5-thuth@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These instructions multiply 32 bits by 32 bits, not 32 bits by 64 bits.

Fixes: 83b00736f3d8 ("target-s390: Convert FP MULTIPLY")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20230704081506.276055-4-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/insn-data.h.inc | 4 ++--
 target/s390x/tcg/fpu_helper.c    | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 0a45dbbcda..457ed25d2f 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -667,11 +667,11 @@
     F(0xb317, MEEBR,   RRE,   Z,   e1, e2, new, e1, meeb, 0, IF_BFP)
     F(0xb31c, MDBR,    RRE,   Z,   f1, f2, new, f1, mdb, 0, IF_BFP)
     F(0xb34c, MXBR,    RRE,   Z,   x1, x2, new_x, x1, mxb, 0, IF_BFP)
-    F(0xb30c, MDEBR,   RRE,   Z,   f1, e2, new, f1, mdeb, 0, IF_BFP)
+    F(0xb30c, MDEBR,   RRE,   Z,   e1, e2, new, f1, mdeb, 0, IF_BFP)
     F(0xb307, MXDBR,   RRE,   Z,   f1, f2, new_x, x1, mxdb, 0, IF_BFP)
     F(0xed17, MEEB,    RXE,   Z,   e1, m2_32u, new, e1, meeb, 0, IF_BFP)
     F(0xed1c, MDB,     RXE,   Z,   f1, m2_64, new, f1, mdb, 0, IF_BFP)
-    F(0xed0c, MDEB,    RXE,   Z,   f1, m2_32u, new, f1, mdeb, 0, IF_BFP)
+    F(0xed0c, MDEB,    RXE,   Z,   e1, m2_32u, new, f1, mdeb, 0, IF_BFP)
     F(0xed07, MXDB,    RXE,   Z,   f1, m2_64, new_x, x1, mxdb, 0, IF_BFP)
 /* MULTIPLY HALFWORD */
     C(0x4c00, MH,      RX_a,  Z,   r1_o, m2_16s, new, r1_32, mul, 0)
diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
index 57e5829283..4b7fa58af3 100644
--- a/target/s390x/tcg/fpu_helper.c
+++ b/target/s390x/tcg/fpu_helper.c
@@ -306,8 +306,9 @@ uint64_t HELPER(mdb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 /* 64/32-bit FP multiplication */
 uint64_t HELPER(mdeb)(CPUS390XState *env, uint64_t f1, uint64_t f2)
 {
+    float64 f1_64 = float32_to_float64(f1, &env->fpu_status);
     float64 ret = float32_to_float64(f2, &env->fpu_status);
-    ret = float64_mul(f1, ret, &env->fpu_status);
+    ret = float64_mul(f1_64, ret, &env->fpu_status);
     handle_exceptions(env, false, GETPC());
     return ret;
 }
-- 
2.39.3


