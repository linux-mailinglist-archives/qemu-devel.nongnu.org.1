Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1462D7C5E7E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfwA-0005Pf-FW; Wed, 11 Oct 2023 16:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfw3-0005OT-UM
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfw0-0003CJ-DA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2nWMXP3oPeoJgr5juTsatg7IVNwzncGL9zS6ISTx9tI=;
 b=eBYU7bliEmE3g3i83HoxBJdqzhchTr8Z4XzSjrPk/n9Bl1hxu6TcQRx8DcFVPjzvjTk7DU
 MubeKo2axf49JM0xYeRzLX4WXkhvV0Am9jxaP7WBV1h+Ze0L01SYWE4TdJT5LQ8Yy8urN2
 cLxonuCnx3joIimHV/JfXsGPoxwtTB4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-A45FMQTLNei6IKweNc_jSw-1; Wed, 11 Oct 2023 16:35:44 -0400
X-MC-Unique: A45FMQTLNei6IKweNc_jSw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5291C09A4D;
 Wed, 11 Oct 2023 20:35:44 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48DE0492B06;
 Wed, 11 Oct 2023 20:35:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 10/13] migration/rdma: Check sooner if we are in postcopy
 for save_page()
Date: Wed, 11 Oct 2023 22:35:24 +0200
Message-ID: <20231011203527.9061-11-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-1-quintela@redhat.com>
References: <20231011203527.9061-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/rdma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index d3bba05262..932d4eda9b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3240,10 +3240,6 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
     RDMAContext *rdma;
     int ret;
 
-    if (migration_in_postcopy()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
-
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
 
@@ -3317,7 +3313,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma()) {
+    if (!migrate_rdma() || migration_in_postcopy()) {
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
-- 
2.41.0


