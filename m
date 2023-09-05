Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 079327923A8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXNz-0006iJ-Ho; Tue, 05 Sep 2023 10:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXNx-0006dr-6s
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdXNt-0004ZK-Ge
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693925428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Ox7guk9VGy+mmMn8UxeIEK27crnlX3JBBs9y8mfFng=;
 b=crf8SzKJqq3ZqwxpiwMFuj3prQUm8c+nlt5kJ9gMnHoXX7h0t46gXbGvT2a4VN9Jn/wWT/
 dkdckxqHOhR4sspbva4dUzDCPnTzv29Dddh+nHeHFIMuKFfLTlQChZkKklJBYI+799INbg
 T6DPAshq7F6L3zBfsJdqLMrpaCHEMSo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-t-Q-cS1qO1yh8djtmeyFdw-1; Tue, 05 Sep 2023 10:50:26 -0400
X-MC-Unique: t-Q-cS1qO1yh8djtmeyFdw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A50013C0DDCC;
 Tue,  5 Sep 2023 14:50:25 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2EAB146F522;
 Tue,  5 Sep 2023 14:50:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mst@redhat.com, quintela@redhat.com, peterx@redhat.com,
 leobras@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 1/2] vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
Date: Tue,  5 Sep 2023 16:50:01 +0200
Message-ID: <20230905145002.46391-2-kwolf@redhat.com>
In-Reply-To: <20230905145002.46391-1-kwolf@redhat.com>
References: <20230905145002.46391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Migration code can run both in coroutine context (the usual case) and
non-coroutine context (at least savevm/loadvm for snapshots). This also
affects the VMState callbacks, and devices must consider this. Change
the callback definition in VMStateInfo to be explicit about it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/migration/vmstate.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index d1b8abe08d..e4db910339 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -41,9 +41,11 @@ typedef struct VMStateField VMStateField;
  */
 struct VMStateInfo {
     const char *name;
-    int (*get)(QEMUFile *f, void *pv, size_t size, const VMStateField *field);
-    int (*put)(QEMUFile *f, void *pv, size_t size, const VMStateField *field,
-               JSONWriter *vmdesc);
+    int coroutine_mixed_fn (*get)(QEMUFile *f, void *pv, size_t size,
+                                  const VMStateField *field);
+    int coroutine_mixed_fn (*put)(QEMUFile *f, void *pv, size_t size,
+                                  const VMStateField *field,
+                                  JSONWriter *vmdesc);
 };
 
 enum VMStateFlags {
-- 
2.41.0


