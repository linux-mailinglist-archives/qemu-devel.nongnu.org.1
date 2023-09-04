Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB67919C8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:38:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhP-0002Ds-BH; Mon, 04 Sep 2023 10:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhL-00028M-Aw
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhG-0001jm-I8
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRUv3TJYSlQSHvqP7XHSqrWNIdKcj8zXHIxZPo97yoU=;
 b=BjI7AcxYmzj0voiwm+19PFS4vioVrMTdJAtT5qv3H9zdW97isiMOX9f360BHNmYJqIL+Vo
 Rz66kbPVmvE97uD3+au81EjU67pFQL9Htv18NK9j5JT2xqeUqvHm8vV8bBAL0Vm7V2ULUh
 BO+5nLNa1CLQw5tmIPyvxaVUiU+wEBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-YMfz4o7gPCeDarZh7pBXWQ-1; Mon, 04 Sep 2023 10:36:54 -0400
X-MC-Unique: YMfz4o7gPCeDarZh7pBXWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D22E1817904;
 Mon,  4 Sep 2023 14:36:54 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2114400F54;
 Mon,  4 Sep 2023 14:36:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/14] block/iscsi: Document why we use raw malloc()
Date: Mon,  4 Sep 2023 16:36:35 +0200
Message-ID: <20230904143643.259916-7-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In block/iscsi.c we use a raw malloc() call, which is unusual
given the project standard is to use the glib memory allocation
functions. Document why we do so, to avoid it being converted
to g_malloc() by mistake.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20230727150705.2664464-1-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/iscsi.c b/block/iscsi.c
index 34f97ab646..5640c8b565 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1058,6 +1058,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *bs,
         return NULL;
     }
 
+    /* Must use malloc(): this is freed via scsi_free_scsi_task() */
     acb->task = malloc(sizeof(struct scsi_task));
     if (acb->task == NULL) {
         error_report("iSCSI: Failed to allocate task for scsi command. %s",
-- 
2.41.0


