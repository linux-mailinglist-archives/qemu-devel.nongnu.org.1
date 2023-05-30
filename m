Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9138716C7F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q442p-0001gu-AE; Tue, 30 May 2023 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442m-0001fk-OM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q442l-0000sq-At
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685471162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tx/4HjH10zbER9X9JRjNA48x+P+0ib4/FRHyZB6gfc=;
 b=EHwEDSm8u+Tx8ROMSU0gvbs6AkaSUyLcjNh7Ao10Hs5AzRZaMRk47PFBUateu46OoEp7VY
 dgRvOKIvvZt+wAh2FLxR6pCKrk2U2xzcJV3xWRnq/ZXm4QcvwX3sbk0gjJjBELTrI+dxpb
 R/ZR6vbsP/LoVExOoFwHz09oMEDt3L0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-EWIsWKq2N4-pqhJfq0ncbg-1; Tue, 30 May 2023 14:26:01 -0400
X-MC-Unique: EWIsWKq2N4-pqhJfq0ncbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECEF729AA386
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 18:26:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A5A017103;
 Tue, 30 May 2023 18:25:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PULL 21/21] migration/rdma: Check sooner if we are in postcopy for
 save_page()
Date: Tue, 30 May 2023 20:25:31 +0200
Message-Id: <20230530182531.6371-22-quintela@redhat.com>
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230509120700.78359-11-quintela@redhat.com>
---
 migration/rdma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index cf0681575d..f912a31b45 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3250,10 +3250,6 @@ static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
     RDMAContext *rdma;
     int ret;
 
-    if (migration_in_postcopy()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
-
     RCU_READ_LOCK_GUARD();
     rdma = qatomic_rcu_read(&rioc->rdmaout);
 
@@ -3322,7 +3318,7 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma()) {
+    if (!migrate_rdma() || migration_in_postcopy()) {
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
-- 
2.40.1


