Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3296759FF8
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv9-0005xU-4E; Wed, 19 Jul 2023 16:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv6-0005vS-LX
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv4-0001nd-Ax
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0+3VktJojW0nG88wPYa4HziBJCTmpIA6XhRPIN8Sqg=;
 b=HucW7DBha3jRaP8Lc3DnIsqlG7wM4dnyI3/sdcqvo6aGyS4EkgXU4ppBYz71z9zTw+D2Qh
 ml5ByfuTsNYlrFbxuRdurbMFQaUxD8Z3VCU77LATtEFGf5DoKwjWiiQR4jowPSO4wP9rLg
 kuwhsTodGuThGXH3W/Bktc7szl1abUA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-Zhke2vMbM9Go6hr4xLLPaQ-1; Wed, 19 Jul 2023 16:37:05 -0400
X-MC-Unique: Zhke2vMbM9Go6hr4xLLPaQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F7CF185A78F;
 Wed, 19 Jul 2023 20:37:05 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C3F54CD0F5;
 Wed, 19 Jul 2023 20:37:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 05/14] qemu-nbd: handle dup2() error when qemu-nbd finished
 setup process
Date: Wed, 19 Jul 2023 15:27:42 -0500
Message-ID: <20230719202736.2675295-21-eblake@redhat.com>
In-Reply-To: <20230719202736.2675295-16-eblake@redhat.com>
References: <20230719202736.2675295-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

From: "Denis V. Lunev" <den@openvz.org>

Fail on error, we are in trouble.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230717145544.194786-6-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: avoid intermediate variable]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index f27613cb572..e30c9ac1793 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -323,7 +323,11 @@ static void *nbd_client_thread(void *arg)
                 opts->device, srcpath);
     } else {
         /* Close stderr so that the qemu-nbd process exits.  */
-        dup2(STDOUT_FILENO, STDERR_FILENO);
+        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+            error_report("Could not set stderr to /dev/null: %s",
+                         strerror(errno));
+            exit(EXIT_FAILURE);
+        }
     }

     if (nbd_client(fd) < 0) {
@@ -1171,7 +1175,11 @@ int main(int argc, char **argv)
     }

     if (fork_process) {
-        dup2(STDOUT_FILENO, STDERR_FILENO);
+        if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
+            error_report("Could not set stderr to /dev/null: %s",
+                         strerror(errno));
+            exit(EXIT_FAILURE);
+        }
     }

     state = RUNNING;
-- 
2.41.0


