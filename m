Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B777D75A009
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 22:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMDv8-0005wt-AV; Wed, 19 Jul 2023 16:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv5-0005uI-0w
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qMDv2-0001my-Hm
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 16:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689799028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zIj6ia/VfHjmhRT5f4gk4X0quoSAGEgCZpYC++Rn3Ro=;
 b=HkAhE9d86LTyxP5YWpLbFYrz4NuF8b9ZnNhGf4hDg3Ehl+SIugEHm8VR6/AqAEAyiOqLeD
 gbjFMUr2hmT3JGJ5Iez+tcvzprSrLf5ZlE0uRyKeQfCDxUVp3hYKa9BpJcIz217NdZuXFh
 R1ccbed8EO+3govBJiWfGlFr5s0CFm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-QkErrctJPY-iXwTVGojEmg-1; Wed, 19 Jul 2023 16:37:04 -0400
X-MC-Unique: QkErrctJPY-iXwTVGojEmg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 54B80100813E;
 Wed, 19 Jul 2023 20:37:04 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4CC24CD0F5;
 Wed, 19 Jul 2023 20:37:03 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 03/14] qemu-nbd: properly report error if qemu_daemon() is
 failed
Date: Wed, 19 Jul 2023 15:27:40 -0500
Message-ID: <20230719202736.2675295-19-eblake@redhat.com>
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

From: "Denis V. Lunev" <den@openvz.org>

errno has been overwritten by dup2() just below qemu_daemon() and thus
improperly returned to the caller. Fix accordingly.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Eric Blake <eblake@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20230717145544.194786-5-den@openvz.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: reorder patch series]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 186ce9474c3..5a8ae1f7472 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -932,14 +932,17 @@ int main(int argc, char **argv)
             error_report("Failed to fork: %s", strerror(errno));
             exit(EXIT_FAILURE);
         } else if (pid == 0) {
+            int saved_errno;
+
             close(stderr_fd[0]);

             ret = qemu_daemon(1, 0);
+            saved_errno = errno;    /* dup2 will overwrite error below */

             /* Temporarily redirect stderr to the parent's pipe...  */
             dup2(stderr_fd[1], STDERR_FILENO);
             if (ret < 0) {
-                error_report("Failed to daemonize: %s", strerror(errno));
+                error_report("Failed to daemonize: %s", strerror(saved_errno));
                 exit(EXIT_FAILURE);
             }

-- 
2.41.0


