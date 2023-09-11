Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4079A6DD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVA-0005kM-Lb; Mon, 11 Sep 2023 05:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV7-0005jw-O1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV5-0004dL-JR
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0bGSqhFi2N2d9mPlKeKurECUdd3dcsOGfUufbMYveo=;
 b=TFCDfvQ5xwcW+ft4lVJJDF2dFnEGUzb8ZaVltYRkSrhPFAxB+y5qR+mAgVGq2rRM8aGFXs
 RxtSAsRZpt3cJZgddWPyU18n9e9WeV+bFSyQQZiO8YDECW5C7lDXlB1ltJkjFEUAeo8YdT
 f1IGkfsOdhW0l8lnUahIPOiR6mWUOyo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-yQ25NAh5MbKcFe9tYRZp9Q-1; Mon, 11 Sep 2023 05:46:33 -0400
X-MC-Unique: yQ25NAh5MbKcFe9tYRZp9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C02E6800962;
 Mon, 11 Sep 2023 09:46:32 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 929CC40C6EBF;
 Mon, 11 Sep 2023 09:46:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 01/21] block: Remove unused
 BlockReopenQueueEntry.perms_checked
Date: Mon, 11 Sep 2023 11:46:00 +0200
Message-ID: <20230911094620.45040-2-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This field has been unused since commit 72373e40fbc ('block:
bdrv_reopen_multiple: refresh permissions on updated graph').
Remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block.c b/block.c
index 8da89aaa62..9029ddd9ff 100644
--- a/block.c
+++ b/block.c
@@ -2115,7 +2115,6 @@ static int bdrv_fill_options(QDict **options, const char *filename,
 
 typedef struct BlockReopenQueueEntry {
      bool prepared;
-     bool perms_checked;
      BDRVReopenState state;
      QTAILQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
-- 
2.41.0


