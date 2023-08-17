Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCD177F6E4
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTE-00088g-Go; Thu, 17 Aug 2023 08:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcSr-0007nV-Fk
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcSo-0002aQ-V5
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tIiTSKd3kcd8AZw4tpCnGOAu4rSlXDOks6SjQcNd/ag=;
 b=Wfv5H17o+8Mfy95E4+CnO79aXviv1tPc/3oOz+UyA0fSOKAG9SIwAv7jfYFwmZeWV/OlmT
 FUpihhjfi6LzHUbT4slqU42eEYtW2UAF+ztwVB1KEsi5mCdSiyAmgrNV26kOPUylsr2pZf
 dQKk09Wk2HysRzlabpNh9eMcHJvZ3Ok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-KiPpnxWxNFy7ubL1nz52lg-1; Thu, 17 Aug 2023 08:50:54 -0400
X-MC-Unique: KiPpnxWxNFy7ubL1nz52lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D5D085C6E2;
 Thu, 17 Aug 2023 12:50:53 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 733C11121314;
 Thu, 17 Aug 2023 12:50:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 01/21] block: Remove unused BlockReopenQueueEntry.perms_checked
Date: Thu, 17 Aug 2023 14:50:00 +0200
Message-ID: <20230817125020.208339-2-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This field has been unused since commit 72373e40fbc ('block:
bdrv_reopen_multiple: refresh permissions on updated graph').
Remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block.c b/block.c
index a307c151a8..6376452768 100644
--- a/block.c
+++ b/block.c
@@ -2113,7 +2113,6 @@ static int bdrv_fill_options(QDict **options, const char *filename,
 
 typedef struct BlockReopenQueueEntry {
      bool prepared;
-     bool perms_checked;
      BDRVReopenState state;
      QTAILQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
-- 
2.41.0


