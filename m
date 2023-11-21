Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77D57F3501
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:35:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Udw-0003hK-An; Tue, 21 Nov 2023 12:34:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5Udt-0003gk-Le
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:34:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.145.221.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5Uds-0008JI-27
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:34:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700588070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJX2E52A5d3XASh09C5Ilf4OXbr2/qospmvQ6Uj8io4=;
 b=Ut3Ukuy5FE1w68AxrcRSXRli0hSuiwH4g5kk96DRJ+ttfoLbE08Ak576fahptSXoVuN4xz
 RaObVH7xrHcrC5JGTasp/OYiiXnQx/bFUDHTVa5fxAcJKO9fCXVrZHk1VM6bo7xZ4IdqOc
 zquc4aNa0oIsDeymKpIp5lGjilCMYfA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-vtMxkMHTMgmtN35he2UKaQ-1; Tue,
 21 Nov 2023 12:34:26 -0500
X-MC-Unique: vtMxkMHTMgmtN35he2UKaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C50CC1C060C9;
 Tue, 21 Nov 2023 17:34:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3D151C060AE;
 Tue, 21 Nov 2023 17:34:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, armbru@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH for-8.2 2/2] string-output-visitor: Support lists for
 non-integer types
Date: Tue, 21 Nov 2023 18:34:16 +0100
Message-ID: <20231121173416.346610-3-kwolf@redhat.com>
In-Reply-To: <20231121173416.346610-1-kwolf@redhat.com>
References: <20231121173416.346610-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=216.145.221.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

With the introduction of list-based array properties in qdev, the string
output visitor has to deal with lists of non-integer elements now ('info
qtree' prints all properties with the string output visitor).

Currently there is no explicit support for such lists, and the resulting
output is only the last element because string_output_set() always
replaces the output with the latest value. Instead of replacing the old
value, append comma separated values in list context.

The difference can be observed in 'info qtree' with a 'rocker' device
that has a 'ports' list with more than one element.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/string-output-visitor.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index 71ddc92b7b..c0cb72dbe4 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -74,11 +74,27 @@ static StringOutputVisitor *to_sov(Visitor *v)
 
 static void string_output_set(StringOutputVisitor *sov, char *string)
 {
-    if (sov->string) {
-        g_string_free(sov->string, true);
+    switch (sov->list_mode) {
+    case LM_STARTED:
+        sov->list_mode = LM_IN_PROGRESS;
+        /* fall through */
+    case LM_NONE:
+        if (sov->string) {
+            g_string_free(sov->string, true);
+        }
+        sov->string = g_string_new(string);
+        g_free(string);
+        break;
+
+    case LM_IN_PROGRESS:
+    case LM_END:
+        g_string_append(sov->string, ", ");
+        g_string_append(sov->string, string);
+        break;
+
+    default:
+        abort();
     }
-    sov->string = g_string_new(string);
-    g_free(string);
 }
 
 static void string_output_append(StringOutputVisitor *sov, int64_t a)
-- 
2.42.0


