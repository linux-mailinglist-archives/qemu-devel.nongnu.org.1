Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A02487D54F6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJ4E-000547-RC; Tue, 24 Oct 2023 11:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3t-0004tt-Tf
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvJ3f-0000nq-6b
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698160256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XvDfH0PSZt4OKoh0ko0G1PVRyhq4Hc1s8bEPUj35c/g=;
 b=hYDui7mAGACkGq23TFdqSaWB4QhJyKA0I6153eEfQggT4YQLFKwcTEAujUGyTeqnJOGvkw
 dO86TgPkWvS3pyQUYa2OVHNz8SHNH9ey0nGTQO02JS3MpUxVs3k2vUnx/NBQLZ9wql/Owx
 xqbY0E5PUlPnYHWxWWc1USZqJzXaEoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-7o8rkw-7OD6A0a8j8vS47A-1; Tue, 24 Oct 2023 11:10:52 -0400
X-MC-Unique: 7o8rkw-7OD6A0a8j8vS47A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6BA71019C83;
 Tue, 24 Oct 2023 15:10:51 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE5582026D4C;
 Tue, 24 Oct 2023 15:10:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 03/12] qemu_file: total_transferred is not used anymore
Date: Tue, 24 Oct 2023 17:10:33 +0200
Message-ID: <20231024151042.90349-4-quintela@redhat.com>
In-Reply-To: <20231024151042.90349-1-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 384985f534..641ab703cc 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -41,9 +41,6 @@ struct QEMUFile {
     QIOChannel *ioc;
     bool is_writable;
 
-    /* The sum of bytes transferred on the wire */
-    uint64_t total_transferred;
-
     int buf_index;
     int buf_size; /* 0 when writing */
     uint8_t buf[IO_BUF_SIZE];
@@ -282,7 +279,6 @@ void qemu_fflush(QEMUFile *f)
             qemu_file_set_error_obj(f, -EIO, local_error);
         } else {
             uint64_t size = iov_size(f->iov, f->iovcnt);
-            f->total_transferred += size;
             stat64_add(&mig_stats.qemu_file_transferred, size);
         }
 
-- 
2.41.0


