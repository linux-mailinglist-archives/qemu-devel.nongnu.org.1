Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC873A6D4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNc5-0000hM-Hq; Thu, 22 Jun 2023 12:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNc3-0000aw-TK
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNc2-0001KZ-AC
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687453009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RC26ZXvpIri6vHXLfG4jnz3zBcpECA8/T8I9HfCGWhY=;
 b=dbiraHi3W+0i6eNIA7ERn7PHVivtaK8LDcWC6ujtuJ7Yp8My+DIULsyhkwDMnlWPGS57VL
 RG87fw+HYUeUL5eHqOxBBb+KhiZL/YJoldBk4+hNI2+Mbjnn1RJXzHAHJKHL5YEpgue6nm
 4bVO/DkEL90EpWeTWrKBwjaxZwwFNf0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-FHu7E3RoMoyFvpxSjAD5-g-1; Thu, 22 Jun 2023 12:56:47 -0400
X-MC-Unique: FHu7E3RoMoyFvpxSjAD5-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD1D797DE50;
 Thu, 22 Jun 2023 16:56:40 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0DD2C00049;
 Thu, 22 Jun 2023 16:56:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PULL 28/30] qemu-file: Simplify qemu_file_shutdown()
Date: Thu, 22 Jun 2023 18:55:25 +0200
Message-Id: <20230622165527.2417-29-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20230530183941.7223-20-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9a89e17924..4c577bdff8 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -65,8 +65,6 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
-    int ret = 0;
-
     /*
      * We must set qemufile error before the real shutdown(), otherwise
      * there can be a race window where we thought IO all went though
@@ -96,10 +94,10 @@ int qemu_file_shutdown(QEMUFile *f)
     }
 
     if (qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL) < 0) {
-        ret = -EIO;
+        return -EIO;
     }
 
-    return ret;
+    return 0;
 }
 
 bool qemu_file_mode_is_not_valid(const char *mode)
-- 
2.40.1


