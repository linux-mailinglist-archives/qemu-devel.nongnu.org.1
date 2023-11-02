Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4526E7DEEAA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 10:13:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyTl0-0005WA-Ug; Thu, 02 Nov 2023 05:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyTkz-0005W1-Li
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyTky-0004EQ-5P
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 05:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698916370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XzS/FN6c50cnObI8qPsXKPTRQkU1eC3Pp3jJQFFfTZI=;
 b=gYwg1I8bbsEEk2ysitybBltW3N7U5gkikQKmmz8c1HQwdmz9EB4QQpcm9pzO0UMQRSOp1+
 Ljx8BVJ2cnKV4nA+Ocs2C3+9j29P7AZpBe4J/8eIZTCm9iU7lS/sCa/TdI2wQuR/8W9Z+D
 /P8xLh/NyefzOayCMEW5B5iBbcv1m1o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-zkAwNJnGMr2FkeqHWZAchQ-1; Thu, 02 Nov 2023 05:12:47 -0400
X-MC-Unique: zkAwNJnGMr2FkeqHWZAchQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5557185A58B;
 Thu,  2 Nov 2023 09:12:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22F2C40C6EBF;
 Thu,  2 Nov 2023 09:12:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH] migration: Unlock mutex in error case
Date: Thu,  2 Nov 2023 10:12:45 +0100
Message-ID: <20231102091245.42045-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We were not unlocking bitmap mutex on the error case.
Coverity discovered the problem.

Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error paths")
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/ram.c b/migration/ram.c
index 34724e8fe8..8c4df60f29 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3040,6 +3040,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
         ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
         if (ret < 0) {
             qemu_file_set_error(f, ret);
+            qemu_mutex_unlock(&rs->bitmap_mutex);
             goto out;
         }
 
-- 
2.41.0


