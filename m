Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEAF7A8BD8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:33:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1zy-0005My-TH; Wed, 20 Sep 2023 14:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zW-0005KA-DV
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qj1zQ-0002ul-Mo
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695234715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7+kvih7WUVKTB4fICaTU1GrKP7IsuBZJAWKDMqRyWBI=;
 b=U8SwAX2/L4DnxUV3kcoo2KRp9IQFHl1my4mEVkHRn5FGEIGdHfEljqfEF1iW4uah//9w/p
 FgCmX8Z3K/oNxcDvWv9Cu1mj9ApdMIwLoXrUbzrBtuYDNmwlVnya6vmEolediqVTwoDaJQ
 NyFQTpDBWzKtWnlghxgk4sDpiLTYNaU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-JcQHjH95P3CD4dmJL6uCEg-1; Wed, 20 Sep 2023 14:31:52 -0400
X-MC-Unique: JcQHjH95P3CD4dmJL6uCEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51E423816D80;
 Wed, 20 Sep 2023 18:31:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EA811055466;
 Wed, 20 Sep 2023 18:31:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3466821E6901; Wed, 20 Sep 2023 20:31:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 1/7] migration/rdma: Fix save_page method to fail on
 polling error
Date: Wed, 20 Sep 2023 20:31:43 +0200
Message-ID: <20230920183149.1105333-2-armbru@redhat.com>
In-Reply-To: <20230920183149.1105333-1-armbru@redhat.com>
References: <20230920183149.1105333-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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


