Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9116D716CBE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Gu-0001Tk-Bt; Tue, 30 May 2023 14:40:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Ge-0000lG-51
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44Gc-0004Uj-Ma
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXOXVgb0my3abuDMefNxroRWrPUx0QI6neZKfEX1Xlg=;
 b=iG9ji9cs4GBiFIiVIANN2IRJV/6LebX20iIOUnVNq1R9o6ebrGY3OVYA5Gn5TEeLElYy79
 SMhKvRAEVEdzgjm0q7oC+3V3hnsMiOHv+kIBTAMmQQWXyG4UTegH5797dT2uJHWWJrP0J8
 9Jx55BP1JXsftI67D0qAOM4vfZUQiUY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-U2SA0Hr6PrO5S6eTOPuzLg-1; Tue, 30 May 2023 14:40:20 -0400
X-MC-Unique: U2SA0Hr6PrO5S6eTOPuzLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1577C802A55;
 Tue, 30 May 2023 18:40:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85C36C154D1;
 Tue, 30 May 2023 18:40:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 18/20] qemu_file: Make qemu_file_is_writable() static
Date: Tue, 30 May 2023 20:39:39 +0200
Message-Id: <20230530183941.7223-19-quintela@redhat.com>
In-Reply-To: <20230530183941.7223-1-quintela@redhat.com>
References: <20230530183941.7223-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

It is not used outside of qemu_file, and it shouldn't.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 1 -
 migration/qemu-file.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 4d5b999fa8..e3dba9f385 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -49,7 +49,6 @@ uint64_t qemu_file_transferred(QEMUFile *f);
  */
 void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
                            bool may_free);
-bool qemu_file_is_writable(QEMUFile *f);
 
 #include "migration/qemu-file-types.h"
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 76f10fe5c4..01616d159c 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -208,7 +208,7 @@ void qemu_file_set_error(QEMUFile *f, int ret)
     qemu_file_set_error_obj(f, ret, NULL);
 }
 
-bool qemu_file_is_writable(QEMUFile *f)
+static bool qemu_file_is_writable(QEMUFile *f)
 {
     return f->is_writable;
 }
-- 
2.40.1


