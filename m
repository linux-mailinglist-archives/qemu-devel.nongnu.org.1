Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF577F2C25
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:55:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJg-0003R9-Qr; Tue, 21 Nov 2023 06:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJc-0003OY-7X
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJa-0004Hr-PY
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5U/U6h9vjsb1p1rSaKlfb5FTQwoOb61k678GR2Ee94=;
 b=Hm4YQxfm1Hdcf94aI8bBZ+CkCOEGCooKoGdpan3xntRIayKZoHWzdvDV/eu6BH3D22mKTj
 d1JF3FdK7G7TD5ismjZit1CMuPGfexX3LhEmvhqRHem7nCwKIC29qWTNYbzggnyQ+pIBsq
 WBROBn/jkkZXP45OjL+Wh7fCu679q9s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-LRawtiKJPbKCzTiDmrQ06A-1; Tue,
 21 Nov 2023 06:53:11 -0500
X-MC-Unique: LRawtiKJPbKCzTiDmrQ06A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C38752825E8F;
 Tue, 21 Nov 2023 11:53:10 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32EAF492BFC;
 Tue, 21 Nov 2023 11:53:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 4/9] stream: Fix AioContext locking during bdrv_graph_wrlock()
Date: Tue, 21 Nov 2023 12:52:57 +0100
Message-ID: <20231121115302.52214-5-kwolf@redhat.com>
In-Reply-To: <20231121115302.52214-1-kwolf@redhat.com>
References: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In stream_prepare(), we need to temporarily drop the AioContext lock
that job_prepare_locked() took for us while calling the graph write lock
functions which can poll.

All block nodes related to this block job are in the same AioContext, so
we can pass any of them to bdrv_graph_wrlock()/ bdrv_graph_wrunlock().
Unfortunately, the one that we picked is base, which can be NULL - and
in this case the AioContext lock is not released and deadlocks can
occur.

Fix this by passing s->target_bs, which is never NULL.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231115172012.112727-4-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index e3aa696289..01fe7c0f16 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -99,9 +99,9 @@ static int stream_prepare(Job *job)
             }
         }
 
-        bdrv_graph_wrlock(base);
+        bdrv_graph_wrlock(s->target_bs);
         bdrv_set_backing_hd_drained(unfiltered_bs, base, &local_err);
-        bdrv_graph_wrunlock(base);
+        bdrv_graph_wrunlock(s->target_bs);
 
         /*
          * This call will do I/O, so the graph can change again from here on.
-- 
2.42.0


