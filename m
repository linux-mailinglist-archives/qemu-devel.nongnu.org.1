Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04C7A4B30
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 16:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiFSW-00035g-Id; Mon, 18 Sep 2023 10:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFSF-0002vf-Gx
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qiFS0-0002aN-4M
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 10:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695048131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yYvmrlPLuBNVSwKQ7adAQsn1lGE6cQOL8Y59t899Zak=;
 b=Pdrci5KGBnD9XikPpNowVIDV0GuVvKy7+DgMxgo/EVHkPolf5fDGdmn6oKHH1AOdrPTVW6
 13gC7bxx/+69VInMFkd4lt90fbdrNKuDW/sgBtmBDNdXPuYbqPwenY/2Ot263+BHJYDgEj
 +xxLW8yWjkfO2aOjsgpEJWfKTq6FR9Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-j2wMl4t_PM2dn-GAjzsmtw-1; Mon, 18 Sep 2023 10:42:09 -0400
X-MC-Unique: j2wMl4t_PM2dn-GAjzsmtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5058B3800BA5
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DB0E1C646
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 14:42:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 11BF921E6915; Mon, 18 Sep 2023 16:42:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com,
	peterx@redhat.com,
	leobras@redhat.com
Subject: [PATCH 14/52] migration/rdma: Use bool for two RDMAContext flags
Date: Mon, 18 Sep 2023 16:41:28 +0200
Message-ID: <20230918144206.560120-15-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

@error_reported and @received_error are flags.  The latter is even
assigned bool true.  Change them from int to bool.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/rdma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 97715dbd78..c02a1c83b2 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -91,7 +91,7 @@ static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
             if (!rdma->error_reported) { \
                 error_report("RDMA is in an error state waiting migration" \
                                 " to abort!"); \
-                rdma->error_reported = 1; \
+                rdma->error_reported = true; \
             } \
             return rdma->error_state; \
         } \
@@ -365,8 +365,8 @@ typedef struct RDMAContext {
      * and remember the error state.
      */
     int error_state;
-    int error_reported;
-    int received_error;
+    bool error_reported;
+    bool received_error;
 
     /*
      * Description of ram blocks used throughout the code.
-- 
2.41.0


