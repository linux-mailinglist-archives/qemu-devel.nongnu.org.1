Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C7716C6D
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q442m-0001e9-F3; Tue, 30 May 2023 14:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442g-0001Zv-QY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442e-0000ld-AQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fv3QM7Mnbic0ejea/6Xy0Y25ENFBbzElnOBcnKRS2AQ=;
 b=Nh9jQJFKB0gTHgUCWvmRE2TOmdZsTdR71tIWXDRZ/O/vI6v2O4d1L95xT7B0KehWFo6/l0
 VXxyHsW2cCuEgaUKN5Mw7uS1kUFnGuVhqaOgiNQSzdp/ialuPmxOJCfYPnLp9CnUhXMstg
 2lq8XZTUfH9LMzHmC90GlJdfdxnbGSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-8EnJ10HhO4-atbiUn72gYw-1; Tue, 30 May 2023 14:25:46 -0400
X-MC-Unique: 8EnJ10HhO4-atbiUn72gYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AADE811E7C
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:25:45 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F327421C5;
 Tue, 30 May 2023 18:25:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 09/21] migration/rdma: Don't use imaginary transfers
Date: Tue, 30 May 2023 20:25:19 +0200
Message-Id: <20230530182531.6371-10-quintela@redhat.com>
In-Reply-To: <20230530182531.6371-1-quintela@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

RDMA protocol is completely asynchronous, so in qemu_rdma_save_page()
they "invent" that a byte has been transferred.  And then they call
qemu_file_credit_transfer() and ram_transferred_add() with that byte.
Just remove that calls as nothing has been sent.

Reviewed-by: Leonardo Bras <leobras@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230515195709.63843-14-quintela@redhat.com>
---
 migration/qemu-file.c | 5 +----
 migration/ram.c       | 1 -
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index acc282654a..23a21e2331 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -346,13 +346,10 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
 
         if (ret != RAM_SAVE_CONTROL_DELAYED &&
             ret != RAM_SAVE_CONTROL_NOT_SUPP) {
-            if (bytes_sent && *bytes_sent > 0) {
-                qemu_file_credit_transfer(f, *bytes_sent);
-            } else if (ret < 0) {
+            if (ret < 0) {
                 qemu_file_set_error(f, ret);
             }
         }
-
         return ret;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 40b8f9630d..da0dfd7072 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1155,7 +1155,6 @@ static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
     }
 
     if (bytes_xmit) {
-        ram_transferred_add(bytes_xmit);
         *pages = 1;
     }
 
-- 
2.40.1


