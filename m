Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2158715E18
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xwJ-0005IW-33; Tue, 30 May 2023 07:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwB-00059K-Th
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xwA-0000Al-Hj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbUoddsPNoe5gy7NMccUErl69oDqAPliQC3C6nLKXrI=;
 b=XSNkpNzy7/8jio3WMoF+UsdAz26SNPgtLtimqysc4WItuU1oi/febnZm1azFJ+Y/dD7Des
 x6Ntz8J1X+5vDJ/W9UIxGzvXXvGG+S9x0GOVBgFtCE7XxjVZ3NA9yTKjwt2ceWrFgSAhC7
 L/LWYqLvqMOyHNmlx10J6aPYtH4QnoI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-YsGwwyajN8qerjbUz63YZg-1; Tue, 30 May 2023 07:54:46 -0400
X-MC-Unique: YsGwwyajN8qerjbUz63YZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DA2C101A52C
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C62540C6EC4;
 Tue, 30 May 2023 11:54:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 10/21] migration: Remove unused qemu_file_credit_transfer()
Date: Tue, 30 May 2023 13:54:18 +0200
Message-Id: <20230530115429.1998-11-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

After this change, nothing abuses QEMUFile to account for data
transferrefd during migration.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515195709.63843-15-quintela@redhat.com>
---
 migration/qemu-file.h | 8 --------
 migration/qemu-file.c | 5 -----
 2 files changed, 13 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index e649718492..37f42315c7 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -122,14 +122,6 @@ bool qemu_file_buffer_empty(QEMUFile *file);
  */
 int coroutine_mixed_fn qemu_peek_byte(QEMUFile *f, int offset);
 void qemu_file_skip(QEMUFile *f, int size);
-/*
- * qemu_file_credit_transfer:
- *
- * Report on a number of bytes that have been transferred
- * out of band from the main file object I/O methods. This
- * accounting information tracks the total migration traffic.
- */
-void qemu_file_credit_transfer(QEMUFile *f, size_t size);
 int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 23a21e2331..72e130631d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -411,11 +411,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
     return len;
 }
 
-void qemu_file_credit_transfer(QEMUFile *f, size_t size)
-{
-    f->total_transferred += size;
-}
-
 /** Closes the file
  *
  * Returns negative error value if any error happened on previous operations or
-- 
2.40.1


