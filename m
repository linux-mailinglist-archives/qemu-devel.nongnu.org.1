Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C47D88173B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 19:14:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn0Qz-00055K-MW; Wed, 20 Mar 2024 14:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rn0Qv-000541-CF
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rn0Qt-0000ql-O9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 14:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710958378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mx6Q2LgUKDHVhhD+C8LfRUbyuNAf3z39vNdeSsc5VEk=;
 b=Ater1UnzL2LVGSrpMAfyMRdoGgGafaOSo4GPcc6fW/sIHtQLo8ipo6/cnYYJ4/0oJkqmaO
 zHcQHE7YNXe4HwoPLc5urpH8J3HKaRtHfnnG6G5If+30pLPXY41j68rkKVXDT3VuWISmOx
 04qTd2b90flA83g9ky/1W6APEJELgp8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-g_UMKql_PReK6iaPoQxuGA-1; Wed, 20 Mar 2024 14:12:56 -0400
X-MC-Unique: g_UMKql_PReK6iaPoQxuGA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01E1F101A586
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 18:12:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17826111E406;
 Wed, 20 Mar 2024 18:12:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] coroutine: reserve 5,000 mappings
Date: Wed, 20 Mar 2024 14:12:32 -0400
Message-ID: <20240320181232.1464819-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrangé <berrange@redhat.com> pointed out that the coroutine
pool size heuristic is very conservative. Instead of halving
max_map_count, he suggested reserving 5,000 mappings for non-coroutine
users based on observations of guests he has access to.

Fixes: 86a637e48104 ("coroutine: cap per-thread local pool size")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/qemu-coroutine.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 2790959eaf..eb4eebefdf 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -377,12 +377,17 @@ static unsigned int get_global_pool_hard_max_size(void)
                             NULL) &&
         qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
         /*
-         * This is a conservative upper bound that avoids exceeding
-         * max_map_count. Leave half for non-coroutine users like library
-         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
-         * halve the amount again.
+         * This is an upper bound that avoids exceeding max_map_count. Leave a
+         * fixed amount for non-coroutine users like library dependencies,
+         * vhost-user, etc. Each coroutine takes up 2 VMAs so halve the
+         * remaining amount.
          */
-        return max_map_count / 4;
+        if (max_map_count > 5000) {
+            return (max_map_count - 5000) / 2;
+        } else {
+            /* Disable the global pool but threads still have local pools */
+            return 0;
+        }
     }
 #endif
 
-- 
2.44.0


