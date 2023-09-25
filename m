Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1ED7AD71C
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjwS-00047Z-Hm; Mon, 25 Sep 2023 07:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qkjwQ-00047L-UB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qkjwL-0003zA-S3
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695641988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ftuf/qMfutehdCM+flcS0RdoI8ExhkhhkgfqaBZ1dUA=;
 b=c6R88Gx5rXkNI6Lm8oJuJt05IKGyayWvithRr7G5s+ysJwsVzam1TWpRVTmF97JN1V+6MT
 kjrCzEb+bD2wGc1Z6bRdhwDdYry2+gMKMA/urWQY6n9Dyf6I/Nv3jk84NqvNYIwHS+bpk3
 5Uql93nbsIcuZaW+tBp5aTt4cMN5KY8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-_9nIGdt9PoyiqDWuDH4zTg-1; Mon, 25 Sep 2023 07:39:46 -0400
X-MC-Unique: _9nIGdt9PoyiqDWuDH4zTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76C363C23FC4;
 Mon, 25 Sep 2023 11:39:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E4FB1005B90;
 Mon, 25 Sep 2023 11:39:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] win32: avoid discarding the exception handler
Date: Mon, 25 Sep 2023 15:39:42 +0400
Message-ID: <20230925113942.267924-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

In all likelihood, the compiler with lto doesn't see the function being
used, from assembly macro __try1. Help it by marking the function has
being used.

Fixes:
https://gitlab.com/qemu-project/qemu/-/issues/1904

Fixes: commit d89f30b4df ("win32: wrap socket close() with an exception handler")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/compiler.h | 6 ++++++
 util/oslib-win32.c      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index a309f90c76..5c7f63f351 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -197,4 +197,10 @@
 #define BUILTIN_SUBCLL_BROKEN
 #endif
 
+#if __has_attribute(used)
+# define QEMU_USED __attribute__((used))
+#else
+# define QEMU_USED
+#endif
+
 #endif /* COMPILER_H */
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 19a0ea7fbe..55b0189dc3 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -479,7 +479,7 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
     return ret;
 }
 
-EXCEPTION_DISPOSITION
+QEMU_USED EXCEPTION_DISPOSITION
 win32_close_exception_handler(struct _EXCEPTION_RECORD *exception_record,
                               void *registration, struct _CONTEXT *context,
                               void *dispatcher)
-- 
2.41.0


