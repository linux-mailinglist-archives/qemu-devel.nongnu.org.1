Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8167C715F66
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3ySz-0001Ts-CT; Tue, 30 May 2023 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySp-0001MT-SE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3ySk-0000fy-0A
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685449707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M56eFowLFlHdg/kgdTQ9K+fHVrYtrKWrwr5Szf0KV1A=;
 b=RF0mKLiSoNj3uNSxEKSKxNcaUpTX86Way6lWtiG3JXnongvFFzR5tSZiCG7mfDNxVXIRum
 /41ccqOoyvYf729p25E0pwqmDg5lRl0Kj3UA7Yxp5lAyNyvprDpRLyrcQoZuwK+npWUAFZ
 FrXJHdjUTLLrBpJBUhuJi4qTludstO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-fFGMcCe_OdKQ3UXrDHhH-g-1; Tue, 30 May 2023 08:28:23 -0400
X-MC-Unique: fFGMcCe_OdKQ3UXrDHhH-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1ED1F101A52C;
 Tue, 30 May 2023 12:28:23 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 904C840CFD45;
 Tue, 30 May 2023 12:28:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 04/16] qemu-file: Don't call qemu_fflush() for read only files
Date: Tue, 30 May 2023 14:28:01 +0200
Message-Id: <20230530122813.2674-5-quintela@redhat.com>
In-Reply-To: <20230530122813.2674-1-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

This was the only caller for read only files.  So change the test for
an assert in qemu_fflush().

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7a5c1a5e32..38984504ba 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -272,9 +272,7 @@ static void qemu_iovec_release_ram(QEMUFile *f)
  */
 void qemu_fflush(QEMUFile *f)
 {
-    if (!qemu_file_is_writable(f)) {
-        return;
-    }
+    g_assert(qemu_file_is_writable(f));
 
     if (qemu_file_get_error(f)) {
         return;
@@ -363,7 +361,9 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 int qemu_fclose(QEMUFile *f)
 {
     int ret, ret2;
-    qemu_fflush(f);
+    if (qemu_file_is_writable(f)) {
+        qemu_fflush(f);
+    }
     ret = qemu_file_get_error(f);
 
     ret2 = qio_channel_close(f->ioc, NULL);
-- 
2.40.1


