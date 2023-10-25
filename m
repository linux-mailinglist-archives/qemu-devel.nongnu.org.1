Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC957D6661
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZvn-0002Kf-Ev; Wed, 25 Oct 2023 05:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvS-00025q-N7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvZvO-0006v1-DO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698225096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O21Y5JBD4Qn/juLOzFAIN7an4fxxIJcQRjWlWCPTDPU=;
 b=LSYr0VgJPETjp+Wk1iRCGqbMCjv9AG2aEjiNWAsVixpCPoUtUPF2fJnW88pUfsyJEy3xKG
 SZXhwFCEy81Joq+9CaTe3U3HnIuUPg7m6MK/EFLxWuCVcCymZcuhg0UaD4SG1oyLCJJNxE
 pmMs2BASP8uOYVXiA7Kb+maKte4wLFw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-PBlZ98rYORKUSASDc92wOQ-1; Wed,
 25 Oct 2023 05:11:23 -0400
X-MC-Unique: PBlZ98rYORKUSASDc92wOQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AAF803826D2A;
 Wed, 25 Oct 2023 09:11:22 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C6FF503B;
 Wed, 25 Oct 2023 09:11:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 01/12] qemu-file: Don't increment qemu_file_transferred at
 qemu_file_fill_buffer
Date: Wed, 25 Oct 2023 11:11:06 +0200
Message-ID: <20231025091117.6342-2-quintela@redhat.com>
In-Reply-To: <20231025091117.6342-1-quintela@redhat.com>
References: <20231025091117.6342-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We only call qemu_file_transferred_* on the sending side. Remove the
increment at qemu_file_fill_buffer() and add asserts to
qemu_file_transferred* functions.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 3fb25148d1..6814c562e6 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -337,7 +337,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
 
     if (len > 0) {
         f->buf_size += len;
-        f->total_transferred += len;
     } else if (len == 0) {
         qemu_file_set_error_obj(f, -EIO, local_error);
     } else {
@@ -627,6 +626,8 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
     uint64_t ret = f->total_transferred;
     int i;
 
+    g_assert(qemu_file_is_writable(f));
+
     for (i = 0; i < f->iovcnt; i++) {
         ret += f->iov[i].iov_len;
     }
@@ -636,6 +637,7 @@ uint64_t qemu_file_transferred_noflush(QEMUFile *f)
 
 uint64_t qemu_file_transferred(QEMUFile *f)
 {
+    g_assert(qemu_file_is_writable(f));
     qemu_fflush(f);
     return f->total_transferred;
 }
-- 
2.41.0


