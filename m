Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BB715DFB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xw9-00058o-JW; Tue, 30 May 2023 07:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw7-00057X-BM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw4-00009C-Vk
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yNW9PNobDLu6GJDLCHZ/9WJVueQuyiQfsgeTSMQ289c=;
 b=XOgEnhg+oKBs9/V1JXGV8xAad06HChVTtTaHAuIUc6xgrhmkUxBbJ9RMI4Nh2qzyxq6ZBT
 p2Zq2Y0xs2m9amM4zXgqRGlangEdc2tquMxbZerVSLgo7aX3MoCn4m1gaI4v20gzy/uwVr
 CY+PMv866u2yJmgjvo7p22X7DRABwpk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-L7XMConjMESZDLX9jYfCXw-1; Tue, 30 May 2023 07:54:42 -0400
X-MC-Unique: L7XMConjMESZDLX9jYfCXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD524101A53A
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:54:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC4540C6EC4;
 Tue, 30 May 2023 11:54:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PULL 07/21] migration/RDMA: It is accounting for zero/normal pages
 in two places
Date: Tue, 30 May 2023 13:54:15 +0200
Message-Id: <20230530115429.1998-8-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Remove the one in control_save_page().

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515195709.63843-12-quintela@redhat.com>
---
 migration/ram.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 88a6c82e63..40b8f9630d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1162,13 +1162,6 @@ static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
     if (ret == RAM_SAVE_CONTROL_DELAYED) {
         return true;
     }
-
-    if (bytes_xmit > 0) {
-        stat64_add(&mig_stats.normal_pages, 1);
-    } else if (bytes_xmit == 0) {
-        stat64_add(&mig_stats.zero_pages, 1);
-    }
-
     return true;
 }
 
-- 
2.40.1


