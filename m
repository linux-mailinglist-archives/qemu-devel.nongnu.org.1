Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD67CA4ED
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKVh-0001RZ-Ur; Mon, 16 Oct 2023 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVa-0001Pe-Cj
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVT-0007QW-Be
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiLKIO5TbzSXhdgDp9tKmh2z6/MsAlT7rsSFH9LqfWY=;
 b=O+LPC2XSo9E0GsxvkwFhJPQ5zmPJHAxeNPOSOiZNLx5jtYjfzcdRHcaXXrTm90B/O5XQcY
 rKDG9vJi4Af02noh9Wd0sLiT8l/vhTZREE9LJ9bnD104OPFPcp6MkwpV9jRkCH+mzXsZmB
 Sw6UWIvRcAHaxWE6zfXIuLFMiL4k/EQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-157-YLwM_el-PyayI8FKVGjJfA-1; Mon, 16 Oct 2023 06:07:24 -0400
X-MC-Unique: YLwM_el-PyayI8FKVGjJfA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B1B93826D2B;
 Mon, 16 Oct 2023 10:07:24 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0008863F21;
 Mon, 16 Oct 2023 10:07:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Dmitry Frolov <frolov@swemel.ru>
Subject: [PULL 04/38] migration: fix RAMBlock add NULL check
Date: Mon, 16 Oct 2023 12:06:32 +0200
Message-ID: <20231016100706.2551-5-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Dmitry Frolov <frolov@swemel.ru>

qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o
check. Usualy return value is checked for this function.
Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231010104851.802947-1-frolov@swemel.ru>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 24d91de8b3..e8df4dc862 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4285,6 +4285,11 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
     RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
     Error *err = NULL;
 
+    if (!rb) {
+        error_report("RAM block not found");
+        return;
+    }
+
     if (migrate_ram_is_ignored(rb)) {
         return;
     }
-- 
2.41.0


