Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D916716CBF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44GI-0000Te-Rc; Tue, 30 May 2023 14:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44GG-0000S7-59
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44GD-00048r-QL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1YwXG5f3ncM0Xjakg0KJOZwETAUNV4nQ2cRcIhH4H40=;
 b=i+adfJ8j1WV3mWlJkacf31hICis/j2JTlTXx6U63+hrVnus3Ko+yQCSefNNBVWL2RvR2Je
 fOsgRAMa4Bek/u/nZTOuAbS5ql6S/gkWNF0SbQmBhWDLpT0TB9lPALTfZ78FBDWNW6mEBl
 hlbWwEtz3usIBe2PH2vpWPmc9PxZb6I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-zz3q8jZyPWiVSY2cKzSYgg-1; Tue, 30 May 2023 14:39:53 -0400
X-MC-Unique: zz3q8jZyPWiVSY2cKzSYgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01FE929AA386;
 Tue, 30 May 2023 18:39:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69404C154D1;
 Tue, 30 May 2023 18:39:51 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 04/20] qemu-file: We only call qemu_file_transferred_* on
 the sending side
Date: Tue, 30 May 2023 20:39:25 +0200
Message-Id: <20230530183941.7223-5-quintela@redhat.com>
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

Remove the increase in qemu_file_fill_buffer() and add asserts to
qemu_file_transferred* functions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 7a5c1a5e32..be3dab85cb 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -342,7 +342,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 
     if (len > 0) {
         f->buf_size += len;
-        f->total_transferred += len;
     } else if (len == 0) {
         qemu_file_set_error_obj(f, -EIO, local_error);
     } else {
@@ -632,6 +631,8 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
     uint64_t ret = f->total_transferred;
     int i;
 
+    g_assert(qemu_file_is_writable(f));
+
     for (i = 0; i < f->iovcnt; i++) {
         ret += f->iov[i].iov_len;
     }
@@ -641,6 +642,7 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
 
 uint64_t qemu_file_transferred(QEMUFile *f)
 {
+    g_assert(qemu_file_is_writable(f));
     qemu_fflush(f);
     return f->total_transferred;
 }
-- 
2.40.1


