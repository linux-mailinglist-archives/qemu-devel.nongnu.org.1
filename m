Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2BF7B2E97
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9De-0005C2-Ex; Fri, 29 Sep 2023 04:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DQ-000507-Ng
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DA-0005bl-LT
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u+gXFHyiOssKuws26aj3snZMvL7ARvGkD3IT5khP5Gs=;
 b=IRmI0hMbijL9PGvPcLbqExV4cHXf0wofA0Frn+Yhh6PBq0U3Rsgrz00pFwRJly/OwXEvh7
 Uqz4wSt3KlFVzTq7aV5LfYzfR2H+hLOTI3bAxf0XklCKGNsXyv3ry+o20pfH3P0CmWrXOM
 CDAHnh/8wPw4Ie8P8Mtj3rrMVzkYIdE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-687-6k7aB4tCOci4Zb3cCu60Lw-1; Fri, 29 Sep 2023 04:50:56 -0400
X-MC-Unique: 6k7aB4tCOci4Zb3cCu60Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED0F03806737;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1AE0C15BB8;
 Fri, 29 Sep 2023 08:50:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7512621E6916; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PULL 13/56] target/tricore: Clean up local variable shadowing
Date: Fri, 29 Sep 2023 10:50:10 +0200
Message-ID: <20230929085053.2789105-14-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  target/tricore/translate.c:5016:18: warning: declaration of ‘temp’ shadows a previous local [-Wshadow=compatible-local]
   5016 |             TCGv temp = tcg_constant_i32(const9);
        |                  ^~~~
  target/tricore/translate.c:4958:10: note: shadowed declaration is here
   4958 |     TCGv temp;
        |          ^~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904161235.84651-7-philmd@linaro.org>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 target/tricore/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6ae5ccbf72..9ca211b2a8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -4962,8 +4962,6 @@ static void decode_rc_logical_shift(DisasContext *ctx)
     const9 = MASK_OP_RC_CONST9(ctx->opcode);
     op2 = MASK_OP_RC_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-
     switch (op2) {
     case OPC2_32_RC_AND:
         tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
@@ -4972,10 +4970,12 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
         break;
     case OPC2_32_RC_NAND:
+        temp = tcg_temp_new();
         tcg_gen_movi_tl(temp, const9);
         tcg_gen_nand_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_NOR:
+        temp = tcg_temp_new();
         tcg_gen_movi_tl(temp, const9);
         tcg_gen_nor_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
@@ -5013,7 +5013,7 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         break;
     case OPC2_32_RC_SHUFFLE:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
-            TCGv temp = tcg_constant_i32(const9);
+            temp = tcg_constant_i32(const9);
             gen_helper_shuffle(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
-- 
2.41.0


