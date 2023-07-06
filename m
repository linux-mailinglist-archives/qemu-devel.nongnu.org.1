Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC37749E15
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHPGY-0001Mm-1h; Thu, 06 Jul 2023 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHPGU-0001LZ-Os
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1qHPGT-00065P-AD
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688650999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=gxNuxYdDlIhVaVrN8xnbRDIYNcwbV8kx4jV4ArVzs+Q=;
 b=beElX6VXl7tGxwshVGpZvnunLjNzs8NL6fdkTbf2i7S/QJQljcx6FDRinQdzQZNa9IXvHr
 LMxcnDf431I1JqCoqayikoIc6ZpCVdgJa61rmAki2gLpWo252ilouN9iGknuD1QTI2f9ia
 e2D5JprnzPufDYZRXP5zoMkOY8Nvth8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-Z6Cyu6liNeqMJWzLMbnM1A-1; Thu, 06 Jul 2023 09:43:16 -0400
X-MC-Unique: Z6Cyu6liNeqMJWzLMbnM1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 78C6380027F;
 Thu,  6 Jul 2023 13:43:16 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.42.28.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC2711121330;
 Thu,  6 Jul 2023 13:43:15 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: richard.henderson@linaro.org
Cc: pbonzini@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH] tb-maint: Document #ifdef..else..endif correctly
Date: Thu,  6 Jul 2023 14:43:09 +0100
Message-ID: <20230706134314.907591-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
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

It was hard to tell from the comments whether the code applied to user
mode (CONFIG_USER_ONLY) or system mode.  Fix the comments on the #else
and #endif directives to be clearer.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 accel/tcg/tb-maint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 9566224d18..bf99a46872 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -156,7 +156,7 @@ static PageForEachNext foreach_tb_next(PageForEachNext tb,
     return NULL;
 }
 
-#else
+#else /* !CONFIG_USER_ONLY */
 /*
  * In system mode we want L1_MAP to be based on ram offsets.
  */
@@ -722,7 +722,7 @@ static void page_unlock_tb(const TranslationBlock *tb)
         }
     }
 }
-#endif /* CONFIG_USER_ONLY */
+#endif /* !CONFIG_USER_ONLY */
 
 /* flush all the translation blocks */
 static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
-- 
2.41.0


