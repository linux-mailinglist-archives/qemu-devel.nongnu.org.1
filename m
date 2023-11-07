Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFBD7E484F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:33:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Qsa-0002qj-43; Tue, 07 Nov 2023 13:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsY-0002pH-3w
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r0QsW-0007OI-FJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:32:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699381964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNBzpnOU4HIy+lNr3aW7/kOfqbgMTDfyI5ts4rQJcf4=;
 b=YFFLsnzsxUXphoy50fgGqTrXE3hJYu9QSghew0ScvVQljwjp5R2Kd78XHA5NNT3YmiR918
 CbE+gpLTk0Cy1TQJdMsddp2CaLlLURcsfOaqmt9+D5y71a8oJrAZ2GxxNfy3xrYD8ZUetK
 eF8x64w4ubudgy+YF2sl+W7p+lkDK2I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-sfwXw-EzNp2ic5fmsEgffQ-1; Tue, 07 Nov 2023 13:32:41 -0500
X-MC-Unique: sfwXw-EzNp2ic5fmsEgffQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3746B185A783;
 Tue,  7 Nov 2023 18:32:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 317272166B27;
 Tue,  7 Nov 2023 18:32:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 06/11] target/s390x: Fix CLC corrupting cc_src
Date: Tue,  7 Nov 2023 19:32:23 +0100
Message-ID: <20231107183228.276424-7-thuth@redhat.com>
In-Reply-To: <20231107183228.276424-1-thuth@redhat.com>
References: <20231107183228.276424-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

CLC updates cc_src before accessing the second operand; if the latter
is inaccessible, the former ends up containing a bogus value.

Fix by reading cc_src into a temporary first.

Fixes: 4f7403d52b1c ("target-s390: Convert CLC")
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1865
Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20231106093605.1349201-2-iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 4bae1509f5..a0d6a2a35d 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2007,6 +2007,7 @@ static DisasJumpType op_cksm(DisasContext *s, DisasOps *o)
 static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
 {
     int l = get_field(s, l1);
+    TCGv_i64 src;
     TCGv_i32 vl;
     MemOp mop;
 
@@ -2016,9 +2017,11 @@ static DisasJumpType op_clc(DisasContext *s, DisasOps *o)
     case 4:
     case 8:
         mop = ctz32(l + 1) | MO_TE;
-        tcg_gen_qemu_ld_tl(cc_src, o->addr1, get_mem_index(s), mop);
+        /* Do not update cc_src yet: loading cc_dst may cause an exception. */
+        src = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_tl(src, o->addr1, get_mem_index(s), mop);
         tcg_gen_qemu_ld_tl(cc_dst, o->in2, get_mem_index(s), mop);
-        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, cc_src, cc_dst);
+        gen_op_update2_cc_i64(s, CC_OP_LTUGTU_64, src, cc_dst);
         return DISAS_NEXT;
     default:
         vl = tcg_constant_i32(l);
-- 
2.41.0


