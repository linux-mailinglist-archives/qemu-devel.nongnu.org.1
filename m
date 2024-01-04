Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501EF823B80
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:36:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFQp-0004HM-7L; Wed, 03 Jan 2024 23:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQk-0004GC-G3
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFQi-0006ir-QL
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mUcE0/zFGxgmCe2vjJ2VSUOvSJD3gtwfWIbs5TqOBCQ=;
 b=apUsX3yMcYDiFI2cxgyFB37phuy7SFPHMYnoxESGXUNOhsoeT2LrKURjeryCWDmgxIGVwH
 WewnEl8EEXtho56yeSEbGnbFxoWWQCYiDVbIzOsS6vYy+WRlVCqbWXxtxb5SVDZ853QJUJ
 b721k8ks9RBqrYs4+UsBI/o8UIbCy3E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-AkmH26GpP-ylxP9bn9CDwQ-1; Wed,
 03 Jan 2024 23:33:58 -0500
X-MC-Unique: AkmH26GpP-ylxP9bn9CDwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 575803C025BB;
 Thu,  4 Jan 2024 04:33:58 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 076E0C15968;
 Thu,  4 Jan 2024 04:33:53 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/26] migration/multifd: Simplify multifd_channel_connect() if
 else statement
Date: Thu,  4 Jan 2024 12:32:05 +0800
Message-ID: <20240104043213.431566-21-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Avihai Horon <avihaih@nvidia.com>

The else branch in multifd_channel_connect() is redundant because when
the if branch is taken the function returns.

Simplify the code by removing the else branch.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20231231093016.14204-7-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a6204fc72f..55d5fd55f8 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -847,14 +847,13 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
          * so we mustn't call multifd_send_thread until then
          */
         return multifd_tls_channel_connect(p, ioc, errp);
-
-    } else {
-        migration_ioc_register_yank(ioc);
-        p->registered_yank = true;
-        p->c = ioc;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
     }
+
+    migration_ioc_register_yank(ioc);
+    p->registered_yank = true;
+    p->c = ioc;
+    qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                       QEMU_THREAD_JOINABLE);
     return true;
 }
 
-- 
2.41.0


