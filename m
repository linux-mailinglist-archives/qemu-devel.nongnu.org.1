Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050A97B6923
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedV-0006jx-Cy; Tue, 03 Oct 2023 08:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedT-0006iU-Fx
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnedO-0000Hg-M7
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKECN/4QzNHHbpnzkMgMB+KcjScLYh8TR0/rHvUwaB0=;
 b=hOwCQm6kGcW+i4LtZyq2pRfDJM9SGqkl+Vohf9RNglTM5uP8sxied+8pmAy6BU4gWSHmc9
 b1oVe9DE3YAJsx1ki5wloFk9hSgmi8EswHrCqSmHnPEwxUNKGd8nO3xS9bzsltizZOMpCV
 r6PGQeVlxqA3ymsF1bB4tVztwmMkY2o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-D2SQ2VarPAqnR1G0zdKpLw-1; Tue, 03 Oct 2023 08:36:16 -0400
X-MC-Unique: D2SQ2VarPAqnR1G0zdKpLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 426A2858F19;
 Tue,  3 Oct 2023 12:36:16 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6A78140E953;
 Tue,  3 Oct 2023 12:36:14 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PULL 07/13] win32: avoid discarding the exception handler
Date: Tue,  3 Oct 2023 16:35:36 +0400
Message-ID: <20231003123543.1360795-8-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Resolves:
https://gitlab.com/qemu-project/qemu/-/issues/1904

Fixes: commit d89f30b4df ("win32: wrap socket close() with an exception handler")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/qemu/compiler.h | 6 ++++++
 util/oslib-win32.c      | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 7f1bbbf05f..1109482a00 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -206,4 +206,10 @@
 #define QEMU_ANNOTATE(x)
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


