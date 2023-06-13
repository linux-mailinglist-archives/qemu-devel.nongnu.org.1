Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA78872E680
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 17:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95TY-0006FB-Hp; Tue, 13 Jun 2023 10:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TS-0006Bo-7D
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TQ-0007Zs-Pq
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6yZ98f+/mqkbFcKCuQfUUgo2LiE0FyqRaP8zx8asoo=;
 b=MDZ4+kJdlT/y60n6AgRhpxK06/4A/cGhvk+NMwDY3ZWD0RVYEyiYxFhX2Vp7w09AIfvN5+
 9FiERQq/DHmWGnYzPiM6+DqkA/PuIsOXzYUuuxoW2fPZz1B3GMdu1m09vcmYpoMbXNi86x
 XED6fZeK3nB65SaXfEn43eKUXeUfkXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-63-Ue2hunVINAGtY5YKyhkc3Q-1; Tue, 13 Jun 2023 10:58:16 -0400
X-MC-Unique: Ue2hunVINAGtY5YKyhkc3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2E0E803DBF;
 Tue, 13 Jun 2023 14:58:15 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C395E40C6F5E;
 Tue, 13 Jun 2023 14:58:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 13/18] migration: Simplify decompress_data_with_multi_threads()
Date: Tue, 13 Jun 2023 16:57:52 +0200
Message-Id: <20230613145757.10131-14-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Doing a break to do another break is just confused.  Just call return
when we know we want to return.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram-compress.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/ram-compress.c b/migration/ram-compress.c
index 5e1bb82fcd..cf3a6c238d 100644
--- a/migration/ram-compress.c
+++ b/migration/ram-compress.c
@@ -498,14 +498,10 @@ void decompress_data_with_multi_threads(QEMUFile *f, void *host, int len)
                 decomp_param[idx].len = len;
                 qemu_cond_signal(&decomp_param[idx].cond);
                 qemu_mutex_unlock(&decomp_param[idx].mutex);
-                break;
+                return;
             }
         }
-        if (idx < thread_count) {
-            break;
-        } else {
-            qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
-        }
+        qemu_cond_wait(&decomp_done_cond, &decomp_done_lock);
     }
 }
 
-- 
2.40.1


