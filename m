Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E872181C01D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:28:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXd-0002bB-U4; Thu, 21 Dec 2023 16:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXS-0002BO-Ff
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXQ-0008Ha-8P
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CNSrRmm/AUrcuGu0/bOJIpr2PDP9OT+2TKLQDpeMUc=;
 b=XNOf1AmgqsEl6sYrqw4YOFEa/9XxNJhs4Vz+zsVyv9kQB6hUVTAWX8G0+3evopsVEeFcNB
 pd4jaIu4nRVF4+WHAgKQElt/Wi8IpgtMJZXzCUsaLMEDkW4OSFkYwlAGKXbcz2D897WGDM
 Vx5sfDN36/Z/8epDm/Th9nOv5vReGKs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-sPK8pgZrN9WX0i9z7CGk8w-1; Thu,
 21 Dec 2023 16:24:59 -0500
X-MC-Unique: sPK8pgZrN9WX0i9z7CGk8w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6ADD3806066;
 Thu, 21 Dec 2023 21:24:58 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 039BDC1596E;
 Thu, 21 Dec 2023 21:24:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 30/33] string-output-visitor: show structs as "<omitted>"
Date: Thu, 21 Dec 2023 22:23:35 +0100
Message-ID: <20231221212339.164439-31-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

StringOutputVisitor crashes when it visits a struct because
->start_struct() is NULL.

Show "<omitted>" instead of crashing. This is necessary because the
virtio-blk-pci iothread-vq-mapping parameter that I'd like to introduce
soon is a list of IOThreadMapping structs.

This patch is a quick fix to solve the crash, but the long-term solution
is replacing StringOutputVisitor with something that can handle the full
gamut of values in QEMU.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231212134934.500289-1-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qapi/string-output-visitor.h |  6 +++---
 qapi/string-output-visitor.c         | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/qapi/string-output-visitor.h b/include/qapi/string-output-visitor.h
index 268dfe9986..b1ee473b30 100644
--- a/include/qapi/string-output-visitor.h
+++ b/include/qapi/string-output-visitor.h
@@ -26,9 +26,9 @@ typedef struct StringOutputVisitor StringOutputVisitor;
  * If everything else succeeds, pass @result to visit_complete() to
  * collect the result of the visit.
  *
- * The string output visitor does not implement support for visiting
- * QAPI structs, alternates, null, or arbitrary QTypes.  It also
- * requires a non-null list argument to visit_start_list().
+ * The string output visitor does not implement support for alternates, null,
+ * or arbitrary QTypes.  Struct fields are not shown.  It also requires a
+ * non-null list argument to visit_start_list().
  */
 Visitor *string_output_visitor_new(bool human, char **result);
 
diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index c0cb72dbe4..f0c1dea89e 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -292,6 +292,20 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
     return true;
 }
 
+static bool start_struct(Visitor *v, const char *name, void **obj,
+                         size_t size, Error **errp)
+{
+    return true;
+}
+
+static void end_struct(Visitor *v, void **obj)
+{
+    StringOutputVisitor *sov = to_sov(v);
+
+    /* TODO actually print struct fields */
+    string_output_set(sov, g_strdup("<omitted>"));
+}
+
 static bool
 start_list(Visitor *v, const char *name, GenericList **list, size_t size,
            Error **errp)
@@ -379,6 +393,8 @@ Visitor *string_output_visitor_new(bool human, char **result)
     v->visitor.type_str = print_type_str;
     v->visitor.type_number = print_type_number;
     v->visitor.type_null = print_type_null;
+    v->visitor.start_struct = start_struct;
+    v->visitor.end_struct = end_struct;
     v->visitor.start_list = start_list;
     v->visitor.next_list = next_list;
     v->visitor.end_list = end_list;
-- 
2.43.0


