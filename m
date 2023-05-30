Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25D716CB8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Iv-00075z-DO; Tue, 30 May 2023 14:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44IX-0006lY-EQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44IV-00054o-U5
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQnQw2s+9RRrMMBT9+0GKoH+btHmqaTjHpbiTnyDYHQ=;
 b=E2Mvg6S2aw5am6THjy1ZOFcGPOQ1NJTO+tZ9A4VGDoDcuZ09JRu5pmAtKhQhl7u6rMl2+i
 0uaqKC9QNbfSMk39jWM8bYYQbAsFGF8de5lMxXn0tNSxw4RI/mJtfe+ZuQaIMxGKgHkjD+
 koGaSF/K98IzlD+zw2wBXY6ZIIGjKNA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-29-7ZMivxOdP3Cjj00_UTBAAw-1; Tue, 30 May 2023 14:40:18 -0400
X-MC-Unique: 7ZMivxOdP3Cjj00_UTBAAw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4097385A5BA;
 Tue, 30 May 2023 18:40:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B3B1C154D1;
 Tue, 30 May 2023 18:40:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 17/20] qemu-file: Remove unused
 qemu_file_mode_is_not_valid()
Date: Tue, 30 May 2023 20:39:38 +0200
Message-Id: <20230530183941.7223-18-quintela@redhat.com>
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

It is not used after previous commit.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h |  1 -
 migration/qemu-file.c | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index f2c118f342..4d5b999fa8 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -49,7 +49,6 @@ uint64_t qemu_file_transferred(QEMUFile *f);
  */
 void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
                            bool may_free);
-bool qemu_file_mode_is_not_valid(const char *mode);
 bool qemu_file_is_writable(QEMUFile *f);
 
 #include "migration/qemu-file-types.h"
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 4f9fb1fbd0..76f10fe5c4 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -99,18 +99,6 @@ int qemu_file_shutdown(QEMUFile *f)
     return ret;
 }
 
-bool qemu_file_mode_is_not_valid(const char *mode)
-{
-    if (mode == NULL ||
-        (mode[0] != 'r' && mode[0] != 'w') ||
-        mode[1] != 'b' || mode[2] != 0) {
-        fprintf(stderr, "qemu_fopen: Argument validity check failed\n");
-        return true;
-    }
-
-    return false;
-}
-
 static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 {
     QEMUFile *f;
-- 
2.40.1


