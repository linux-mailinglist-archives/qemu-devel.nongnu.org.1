Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B251D716CAB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Gv-0001UO-3A; Tue, 30 May 2023 14:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Gi-0000ql-4H
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Gg-0004Y9-RN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/JTgQs32CuocWsEP1DFUS8PQ26IybTY4KdYejI0Ogs=;
 b=IIfFu6CnB6MDtQ1PmZn0ctcTOujRdkmuh8wkygy72t1NkzAsKIOCn4CBPeqj0came45i7o
 CampBpqJv7bp14IP3xOGIwu37EK/xhdkbnhcRSGpT/spRVkVpuK4l51iH0YX3pHDhGnpWP
 9zjXeFG6pvSIN945pFZJ3zhecibMDec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-UjYAfn7aO1WM6_DfpEBLMw-1; Tue, 30 May 2023 14:40:22 -0400
X-MC-Unique: UjYAfn7aO1WM6_DfpEBLMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E02C0811E78;
 Tue, 30 May 2023 18:40:21 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B085C154D1;
 Tue, 30 May 2023 18:40:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 19/20] qemu-file: Simplify qemu_file_shutdown()
Date: Tue, 30 May 2023 20:39:40 +0200
Message-Id: <20230530183941.7223-20-quintela@redhat.com>
In-Reply-To: <20230530183941.7223-1-quintela@redhat.com>
References: <20230530183941.7223-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 01616d159c..e4923ab3a0 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -62,8 +62,6 @@ struct QEMUFile {
  */
 int qemu_file_shutdown(QEMUFile *f)
 {
-    int ret = 0;
-
     /*
      * We must set qemufile error before the real shutdown(), otherwise
      * there can be a race window where we thought IO all went though
@@ -93,10 +91,10 @@ int qemu_file_shutdown(QEMUFile *f)
     }
 
     if (qio_channel_shutdown(f->ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL) < 0) {
-        ret = -EIO;
+        return -EIO;
     }
 
-    return ret;
+    return 0;
 }
 
 static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
-- 
2.40.1


