Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C07B52E5
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnHv2-0007SL-LG; Mon, 02 Oct 2023 08:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHux-0007Pq-6c
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnHuv-0007dH-NB
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696249253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aBVwQQh/BSvVKIUO5gjWVvcpRaD7yNUL+Nu7c7CNSw=;
 b=Yl9lPKxrc4brwxPCtCuNhEAUkKKFx4vdik0MtFaZpiXSrD9d4fAQDAiNikbXPWnVsKxU1N
 Ux66tEtd9q6OEEjCtRAIXHzXkW8wTuvt1kn8npJByHXAKIR/cu2UMWbFA1ChnIZLi8UbsI
 Sh2Lf3NnMKOXNGZkUBUcw2IBay7gBhE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-8yw2VVuMM1ypa16t_jKY8A-1; Mon, 02 Oct 2023 08:20:48 -0400
X-MC-Unique: 8yw2VVuMM1ypa16t_jKY8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C68BF29AB411;
 Mon,  2 Oct 2023 12:20:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2A0872156A27;
 Mon,  2 Oct 2023 12:20:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 12/13] migration: Remove unused qemu_file_credit_transfer()
Date: Mon,  2 Oct 2023 14:20:20 +0200
Message-ID: <20231002122021.231959-13-quintela@redhat.com>
In-Reply-To: <20231002122021.231959-1-quintela@redhat.com>
References: <20231002122021.231959-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 47015f5201..57b00c8562 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -119,14 +119,6 @@ bool qemu_file_buffer_empty(QEMUFile *file);
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
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
 void qemu_file_set_error(QEMUFile *f, int ret);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index e53ff2dd86..5c43fa34e7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -397,11 +397,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
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
2.41.0


