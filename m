Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB34A92969
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Apr 2025 20:42:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5UBY-00042v-D4; Thu, 17 Apr 2025 14:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBV-00041x-1t
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5UBT-0002qt-Ln
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 14:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744915318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NfqoMro0GIz5LImw8hVnGM/j3vZZ3MGIlfImJYmZAIM=;
 b=CqFifwEyjG4VAJ2OAsoybQf6NK1BDollG5K05Ivx4qFAILS7hxsi3MinS5lwbgjoLCOXss
 TE544kSXj0gbe7UqrXvZEfye8KteAs6VcyGvzMl0qYGGbrHBBbYHjSjJaQp3n2qKuz+EnP
 qDCUoS2c1l6jj6hpGhezRyQxCY5Yucs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-3uGYGDo4MVKNvXSZO8uZ_g-1; Thu,
 17 Apr 2025 14:41:55 -0400
X-MC-Unique: 3uGYGDo4MVKNvXSZO8uZ_g-1
X-Mimecast-MFC-AGG-ID: 3uGYGDo4MVKNvXSZO8uZ_g_1744915314
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F54719560AF; Thu, 17 Apr 2025 18:41:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.121])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0B331955E96; Thu, 17 Apr 2025 18:41:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 02/11] file-posix: Handle zero block status hint better
Date: Thu, 17 Apr 2025 13:39:07 -0500
Message-ID: <20250417184133.105746-15-eblake@redhat.com>
In-Reply-To: <20250417184133.105746-13-eblake@redhat.com>
References: <20250417184133.105746-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Although the previous patch to change 'bool want_zero' into an enum
made no semantic change, it is now time to differentiate.  When the
caller specifically wants to know what parts of the file read as zero,
we need to use lseek and actually reporting holes, rather than
short-circuiting and advertising full allocation.

This change will be utilized in later patches to let mirroring
optimize for the case when the destination already reads as zeroes.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/file-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 30129ec9b37..8f3e7a8304f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -3217,7 +3217,8 @@ static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
         return ret;
     }

-    if (mode != BDRV_BSTAT_PRECISE) {
+    if (mode == BDRV_BSTAT_ALLOCATED) {
+        /* There is no backing file - all bytes are allocated in this file.  */
         *pnum = bytes;
         *map = offset;
         *file = bs;
-- 
2.49.0


