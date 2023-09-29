Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAB67B2E64
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:52:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9DM-0004w8-FI; Fri, 29 Sep 2023 04:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9DD-0004vm-Dp
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9D7-0005ai-ME
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trHYAZUJZwtXGg9UDoRzU7sOQBIeaFjkI1WIg2w0pQc=;
 b=RXGcr+2k2NVAckw9p/fSA7CV/0BMDIn8wwgB/YhkKOdEtgZ75zz6K+KfPL1g448vQQG/i2
 L0fJBNe7Vb2Cfsc5Niz0eXPR1684k0W8AkcFX9l25Cg4KX/2UfoJW6zSh4Y17Qz3dQ41yb
 GHjkTe9J3UJmJTz+JFNqrL4Densl90Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-A3md13wnM7Gv3PNvLCtOsw-1; Fri, 29 Sep 2023 04:50:54 -0400
X-MC-Unique: A3md13wnM7Gv3PNvLCtOsw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 699F03C025C7;
 Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47939492B16;
 Fri, 29 Sep 2023 08:50:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 52C2221E6905; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PULL 01/56] migration/rdma: Fix save_page method to fail on polling
 error
Date: Fri, 29 Sep 2023 10:49:58 +0200
Message-ID: <20230929085053.2789105-2-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_rdma_save_page() reports polling error with error_report(), then
succeeds anyway.  This is because the variable holding the polling
status *shadows* the variable the function returns.  The latter
remains zero.

Broken since day one, and duplicated more recently.

Fixes: 2da776db4846 (rdma: core logic)
Fixes: b390afd8c50b (migration/rdma: Fix out of order wrid)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Message-ID: <20230921121312.1301864-2-armbru@redhat.com>
---
 migration/rdma.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index a2a3db35b1..3915d1d7c9 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3282,7 +3282,8 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
      */
     while (1) {
         uint64_t wr_id, wr_id_in;
-        int ret = qemu_rdma_poll(rdma, rdma->recv_cq, &wr_id_in, NULL);
+        ret = qemu_rdma_poll(rdma, rdma->recv_cq, &wr_id_in, NULL);
+
         if (ret < 0) {
             error_report("rdma migration: polling error! %d", ret);
             goto err;
@@ -3297,7 +3298,8 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
 
     while (1) {
         uint64_t wr_id, wr_id_in;
-        int ret = qemu_rdma_poll(rdma, rdma->send_cq, &wr_id_in, NULL);
+        ret = qemu_rdma_poll(rdma, rdma->send_cq, &wr_id_in, NULL);
+
         if (ret < 0) {
             error_report("rdma migration: polling error! %d", ret);
             goto err;
-- 
2.41.0


