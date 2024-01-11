Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3682B396
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 18:03:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNyQn-0004Bn-Hq; Thu, 11 Jan 2024 12:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQl-0004A2-1U
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNyQj-0003qF-4J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 12:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704992480;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAecuWwwe+7NT0YPT7Lurh8itBA8a8GTdMIrXfRNoUs=;
 b=ZiVbxPqUIic1qmSYBNZN4wgQu7ouWwwN2yo+6guKfejkx5TUCgsJ8O88oU33+euRr7Jvhh
 05nDwEcOD1M0HjVV9G1FBes1H0+QN+9BFOZS+2tcRLpxbU6JECfbJ/m9k06rYqEkUSAY52
 wJYEEW/i4ostSAqUhiQyMYXvSSsxNjY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-lYl5-zwTPAqSBAvpeuRh7Q-1; Thu,
 11 Jan 2024 12:01:19 -0500
X-MC-Unique: lYl5-zwTPAqSBAvpeuRh7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99BB228AC1C3;
 Thu, 11 Jan 2024 17:01:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 437A651D5;
 Thu, 11 Jan 2024 17:01:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Ido Plat <Ido.Plat@ibm.com>,
 qemu-stable@nongnu.org, David Hildenbrand <david@redhat.com>
Subject: [PULL 15/17] target/s390x: Fix LAE setting a wrong access register
Date: Thu, 11 Jan 2024 18:00:44 +0100
Message-ID: <20240111170047.909117-16-thuth@redhat.com>
In-Reply-To: <20240111170047.909117-1-thuth@redhat.com>
References: <20240111170047.909117-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

LAE should set the access register corresponding to the first operand,
instead, it always modifies access register 1.

Co-developed-by: Ido Plat <Ido.Plat@ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: a1c7610a6879 ("target-s390x: implement LAY and LAEY instructions")
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240111092328.929421-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 62ab2be8b1..8df00b7df9 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -3221,6 +3221,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
 {
     int b2 = get_field(s, b2);
     TCGv ar1 = tcg_temp_new_i64();
+    int r1 = get_field(s, r1);
 
     o->out = o->in2;
     o->in2 = NULL;
@@ -3244,7 +3245,7 @@ static DisasJumpType op_mov2e(DisasContext *s, DisasOps *o)
         break;
     }
 
-    tcg_gen_st32_i64(ar1, tcg_env, offsetof(CPUS390XState, aregs[1]));
+    tcg_gen_st32_i64(ar1, tcg_env, offsetof(CPUS390XState, aregs[r1]));
     return DISAS_NEXT;
 }
 
-- 
2.43.0


