Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51608832EBE
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:16:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNK-0001gl-NX; Fri, 19 Jan 2024 13:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN8-0001cw-KY
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN5-0007aG-V7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sC1mg7x2fL1b69hJeYewTvKHdoYdK1EgellCnZKA5s=;
 b=b9Khme8vVosBQgx2NEdlqAnml7nu47Knu1aorgxjDZCagKKrWgZwq1V3JCS1hJGoeRRhvK
 M0iOiRu3iPtdCU0JbI3LCj/08muXLtCZ68tiSBDejLU8Aubr6hfdv/jTaktMz3aJwVHDsc
 gcLVYt6oKwMq5cF5l0czAVZ21cq7hDw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-DgXMf4ZdM8u35VRvKTx3Dw-1; Fri,
 19 Jan 2024 13:13:35 -0500
X-MC-Unique: DgXMf4ZdM8u35VRvKTx3Dw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DA003C11CDF;
 Fri, 19 Jan 2024 18:13:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2727494;
 Fri, 19 Jan 2024 18:13:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/14] string-output-visitor: Fix (pseudo) struct handling
Date: Fri, 19 Jan 2024 19:13:15 +0100
Message-ID: <20240119181327.236745-3-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

Commit ff32bb53 tried to get minimal struct support into the string
output visitor by just making it return "<omitted>". Unfortunately, it
forgot that the caller will still make more visitor calls for the
content of the struct.

If the struct is contained in a list, such as IOThreadVirtQueueMapping,
in the better case its fields show up as separate list entries. In the
worse case, it contains another list, and the string output visitor
doesn't support nested lists and asserts that this doesn't happen. So as
soon as the optional "vqs" field in IOThreadVirtQueueMapping is
specified, we get a crash.

This can be reproduced with the following command line:

  echo "info qtree" | ./qemu-system-x86_64 \
    -object iothread,id=t0 \
    -blockdev null-co,node-name=disk \
    -device '{"driver": "virtio-blk-pci", "drive": "disk",
              "iothread-vq-mapping": [{"iothread": "t0", "vqs": [0]}]}' \
    -monitor stdio

Fix the problem by counting the nesting level of structs and ignoring
any visitor calls for values (apart from start/end_struct) while we're
not on the top level.

Lists nested directly within lists remain unimplemented, as we don't
currently have a use case for them.

Fixes: ff32bb53476539d352653f4ed56372dced73a388
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2069
Reported-by: Aihua Liang <aliang@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240109181717.42493-1-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/string-output-visitor.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/qapi/string-output-visitor.c b/qapi/string-output-visitor.c
index f0c1dea89e..5115536b15 100644
--- a/qapi/string-output-visitor.c
+++ b/qapi/string-output-visitor.c
@@ -65,6 +65,7 @@ struct StringOutputVisitor
     } range_start, range_end;
     GList *ranges;
     void *list; /* Only needed for sanity checking the caller */
+    unsigned int struct_nesting;
 };
 
 static StringOutputVisitor *to_sov(Visitor *v)
@@ -144,6 +145,10 @@ static bool print_type_int64(Visitor *v, const char *name, int64_t *obj,
     StringOutputVisitor *sov = to_sov(v);
     GList *l;
 
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     switch (sov->list_mode) {
     case LM_NONE:
         string_output_append(sov, *obj);
@@ -231,6 +236,10 @@ static bool print_type_size(Visitor *v, const char *name, uint64_t *obj,
     uint64_t val;
     char *out, *psize;
 
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     if (!sov->human) {
         out = g_strdup_printf("%"PRIu64, *obj);
         string_output_set(sov, out);
@@ -250,6 +259,11 @@ static bool print_type_bool(Visitor *v, const char *name, bool *obj,
                             Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
+
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     string_output_set(sov, g_strdup(*obj ? "true" : "false"));
     return true;
 }
@@ -260,6 +274,10 @@ static bool print_type_str(Visitor *v, const char *name, char **obj,
     StringOutputVisitor *sov = to_sov(v);
     char *out;
 
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     if (sov->human) {
         out = *obj ? g_strdup_printf("\"%s\"", *obj) : g_strdup("<null>");
     } else {
@@ -273,6 +291,11 @@ static bool print_type_number(Visitor *v, const char *name, double *obj,
                               Error **errp)
 {
     StringOutputVisitor *sov = to_sov(v);
+
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     string_output_set(sov, g_strdup_printf("%.17g", *obj));
     return true;
 }
@@ -283,6 +306,10 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
     StringOutputVisitor *sov = to_sov(v);
     char *out;
 
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     if (sov->human) {
         out = g_strdup("<null>");
     } else {
@@ -295,6 +322,9 @@ static bool print_type_null(Visitor *v, const char *name, QNull **obj,
 static bool start_struct(Visitor *v, const char *name, void **obj,
                          size_t size, Error **errp)
 {
+    StringOutputVisitor *sov = to_sov(v);
+
+    sov->struct_nesting++;
     return true;
 }
 
@@ -302,6 +332,10 @@ static void end_struct(Visitor *v, void **obj)
 {
     StringOutputVisitor *sov = to_sov(v);
 
+    if (--sov->struct_nesting) {
+        return;
+    }
+
     /* TODO actually print struct fields */
     string_output_set(sov, g_strdup("<omitted>"));
 }
@@ -312,6 +346,10 @@ start_list(Visitor *v, const char *name, GenericList **list, size_t size,
 {
     StringOutputVisitor *sov = to_sov(v);
 
+    if (sov->struct_nesting) {
+        return true;
+    }
+
     /* we can't traverse a list in a list */
     assert(sov->list_mode == LM_NONE);
     /* We don't support visits without a list */
@@ -329,6 +367,10 @@ static GenericList *next_list(Visitor *v, GenericList *tail, size_t size)
     StringOutputVisitor *sov = to_sov(v);
     GenericList *ret = tail->next;
 
+    if (sov->struct_nesting) {
+        return ret;
+    }
+
     if (ret && !ret->next) {
         sov->list_mode = LM_END;
     }
@@ -339,6 +381,10 @@ static void end_list(Visitor *v, void **obj)
 {
     StringOutputVisitor *sov = to_sov(v);
 
+    if (sov->struct_nesting) {
+        return;
+    }
+
     assert(sov->list == obj);
     assert(sov->list_mode == LM_STARTED ||
            sov->list_mode == LM_END ||
-- 
2.43.0


