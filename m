Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F17DC915
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkey-0003Jh-Dq; Tue, 31 Oct 2023 05:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeh-0002C3-5y
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeP-000751-Ts
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ec/gsbC0ZU31b9WDXxljm1D+NF4ldiXb3H5sGtwKquc=;
 b=da/aEsT5Sgv2EDZ8yI1/DIIKoRnN16z1yD6Uh6rlzBFHbOV6LIcnJUIdjeiVbHpGPhs/Dr
 LRiBB5izqJKBOyGA05CuJgC79o5caNHu2BxI8BgOKidz6KZOvdefYQ0nO+UT6Bk9zEAzEA
 99TLz3ZhDA/f/mPC/fcH7oKB79mcfZM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-_GWVKVe-P4y1VOgA5jYhPg-1; Tue, 31 Oct 2023 05:03:02 -0400
X-MC-Unique: _GWVKVe-P4y1VOgA5jYhPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E57185A79B;
 Tue, 31 Oct 2023 09:03:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CC4391C060AE;
 Tue, 31 Oct 2023 09:02:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 27/38] qemu-file: Don't increment qemu_file_transferred at
 qemu_file_fill_buffer
Date: Tue, 31 Oct 2023 10:01:31 +0100
Message-ID: <20231031090142.13122-28-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231025091117.6342-2-quintela@redhat.com>
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


