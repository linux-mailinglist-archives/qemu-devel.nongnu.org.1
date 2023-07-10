Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027B374D53C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:21:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpoL-0000oQ-UP; Mon, 10 Jul 2023 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo7-0000jU-Lq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpo4-0003NQ-Ik
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BWyNUgZf/ckJUtA2DjMN9hU9NUC24UeFupaRexThXs=;
 b=TCMwZdI3WMwLecOWC3wJxjlYY4bIj1PkDVQEN3X6nBheTF7aCD4g5AEnshtEh9aJO7Iqmb
 TgX4FlXvI/FP0JwQyhmmCd8nMm5fGpYF/VlWEXAODn1upjmjUamp2Nm4P/mUHn0evq6pZ5
 Zyk3cdCMQYaIbqFLl7Qbqz/tyuX5N04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-r7f1j4GePYePmJH3zyvSfg-1; Mon, 10 Jul 2023 08:15:50 -0400
X-MC-Unique: r7f1j4GePYePmJH3zyvSfg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 265F3104458D;
 Mon, 10 Jul 2023 12:15:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.206])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 056A7F5CFA;
 Mon, 10 Jul 2023 12:15:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 03/21] target/s390x: Fix EPSW CC reporting
Date: Mon, 10 Jul 2023 14:15:25 +0200
Message-Id: <20230710121543.197250-4-thuth@redhat.com>
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

EPSW should explicitly calculate and insert CC, like IPM does.

Fixes: e30a9d3fea58 ("target-s390: Implement EPSW")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20230704081506.276055-3-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index a6ee2d4423..0cef6efbef 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2383,10 +2383,14 @@ static DisasJumpType op_epsw(DisasContext *s, DisasOps *o)
     int r1 = get_field(s, r1);
     int r2 = get_field(s, r2);
     TCGv_i64 t = tcg_temp_new_i64();
+    TCGv_i64 t_cc = tcg_temp_new_i64();
 
     /* Note the "subsequently" in the PoO, which implies a defined result
        if r1 == r2.  Thus we cannot defer these writes to an output hook.  */
+    gen_op_calc_cc(s);
+    tcg_gen_extu_i32_i64(t_cc, cc_op);
     tcg_gen_shri_i64(t, psw_mask, 32);
+    tcg_gen_deposit_i64(t, t, t_cc, 12, 2);
     store_reg32_i64(r1, t);
     if (r2 != 0) {
         store_reg32_i64(r2, psw_mask);
-- 
2.39.3


