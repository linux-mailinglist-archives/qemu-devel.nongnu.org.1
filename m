Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C570BC5D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144I-0005cZ-Vg; Mon, 22 May 2023 07:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143n-0005GP-Mn
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143m-0007dw-Ax
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DwgFh/do0f62HJt3XKCIMv7RGuZHX3F/7ZyHMN+YpBE=;
 b=Djrcf1U5p6mGNjnv63Gf4sOJlmZ1TPDxkU7Z1/gXcMny9MhoQmCsFsyKbdJiSuFKzT+WdS
 c9lTcVbdFlKoK852RyDhhZCUIY9rvshhfJrs3W7oqEztvjWl5qnA+MG1AIBtzHsC9zilmK
 XxZEdBrxbKQNIpCmaeLZV+UvM6cSphM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-SxZ3qJ4qOIG-crKdY-6iNw-1; Mon, 22 May 2023 07:50:40 -0400
X-MC-Unique: SxZ3qJ4qOIG-crKdY-6iNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EABD62A59543;
 Mon, 22 May 2023 11:50:39 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEBA62166B26;
 Mon, 22 May 2023 11:50:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
Subject: [PULL 20/20] memory: stricter checks prior to unsetting engaged_in_io
Date: Mon, 22 May 2023 13:50:14 +0200
Message-Id: <20230522115014.1110840-21-thuth@redhat.com>
In-Reply-To: <20230522115014.1110840-1-thuth@redhat.com>
References: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alexander Bulekov <alxndr@bu.edu>

engaged_in_io could be unset by an MR with re-entrancy checks disabled.
Ensure that only MRs that can set the engaged_in_io flag can unset it.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20230516084002.3813836-1-alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 softmmu/memory.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 342c121514..9ee4131d75 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -534,6 +534,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     unsigned access_size;
     unsigned i;
     MemTxResult r = MEMTX_OK;
+    bool reentrancy_guard_applied = false;
 
     if (!access_size_min) {
         access_size_min = 1;
@@ -552,6 +553,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
             return MEMTX_ACCESS_ERROR;
         }
         mr->dev->mem_reentrancy_guard.engaged_in_io = true;
+        reentrancy_guard_applied = true;
     }
 
     /* FIXME: support unaligned access? */
@@ -568,7 +570,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
                         access_mask, attrs);
         }
     }
-    if (mr->dev) {
+    if (mr->dev && reentrancy_guard_applied) {
         mr->dev->mem_reentrancy_guard.engaged_in_io = false;
     }
     return r;
-- 
2.31.1


