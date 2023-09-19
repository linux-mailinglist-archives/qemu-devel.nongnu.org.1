Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C887A5FAB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY1M-0004Lc-Qy; Tue, 19 Sep 2023 06:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0A-00033y-Az
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY07-0001tZ-UU
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDQPuQs8SmUZSGm/U4ljhaA86sSItTw6xBOlfgSP90I=;
 b=VP9g4SOMcbGNal+eSonSeNPgZSwZCRHlnVbejKWGTttLB26VzV5esidkvezBNBMNbO+9nG
 rGMxDtkXB4611odpZLjD7BC/5Gy/ENEb5iZGxblbKKj6hXivKErT4+sTuCBp2e4vKlCrUP
 sImwJ7f0BXcqUb7JOnzpmtmc6/x4kf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-6XEECEvRPxCRll-gRbQO2Q-1; Tue, 19 Sep 2023 06:30:35 -0400
X-MC-Unique: 6XEECEvRPxCRll-gRbQO2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80BE3185A79C
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:35 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D147C40C6EBF;
 Tue, 19 Sep 2023 10:30:34 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [GIT PULL 05/12] softmmu/physmem: Bail out early in
 ram_block_discard_range() with readonly files
Date: Tue, 19 Sep 2023 12:30:22 +0200
Message-ID: <20230919103029.235736-6-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

fallocate() will fail, let's print a nicer error message.

Message-ID: <20230906120503.359863-6-david@redhat.com>
Suggested-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 88482bd32a..c520c2ac55 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3481,6 +3481,16 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * so a userfault will trigger.
              */
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+            /*
+             * fallocate() will fail with readonly files. Let's print a
+             * proper error message.
+             */
+            if (rb->flags & RAM_READONLY_FD) {
+                error_report("ram_block_discard_range: Discarding RAM"
+                             " with readonly files is not supported");
+                goto err;
+
+            }
             /*
              * We'll discard data from the actual file, even though we only
              * have a MAP_PRIVATE mapping, possibly messing with other
-- 
2.41.0


