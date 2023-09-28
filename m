Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 563287B1E3B
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlqwp-0003gt-8E; Thu, 28 Sep 2023 09:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwP-0003Q4-30
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qlqwL-00088V-Ff
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695907224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNq1asJOBFR4V42YaVHEqOMsMLZtarjdgQ01mI52VO0=;
 b=MxVvujTn4LcVYmVkXyAQX7S5rYRtRNuAUhIBNpJyWiCNEboSzjU2gzLWpzku63R3CILI1B
 3jwEPOoKd8qtgoh0QFCUl2biEHlkUBnwp26zTth7NVrhMwnBhxOL7SEGeUXDW5h2R/JUaZ
 PbkteeXIwxKfolllDfyeB6R/bK231f4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-694-cPKnmjnJM9uqspseYHoElQ-1; Thu, 28 Sep 2023 09:20:21 -0400
X-MC-Unique: cPKnmjnJM9uqspseYHoElQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F420B185A79C;
 Thu, 28 Sep 2023 13:20:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0217492B05;
 Thu, 28 Sep 2023 13:20:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8C6321E6906; Thu, 28 Sep 2023 15:20:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de, lizhijian@fujitsu.com, eblake@redhat.com
Subject: [PATCH v2 03/53] migration/rdma: Clean up rdma_delete_block()'s
 return type
Date: Thu, 28 Sep 2023 15:19:29 +0200
Message-ID: <20230928132019.2544702-4-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-1-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

rdma_delete_block() always returns 0, which its only caller ignores.
Return void instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/rdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 934771496c..d448c3e538 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -668,7 +668,7 @@ static int qemu_rdma_init_ram_blocks(RDMAContext *rdma)
  * Note: If used outside of cleanup, the caller must ensure that the destination
  * block structures are also updated
  */
-static int rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
+static void rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
 {
     RDMALocalBlocks *local = &rdma->local_ram_blocks;
     RDMALocalBlock *old = local->block;
@@ -754,8 +754,6 @@ static int rdma_delete_block(RDMAContext *rdma, RDMALocalBlock *block)
                                 &local->block[x]);
         }
     }
-
-    return 0;
 }
 
 /*
-- 
2.41.0


