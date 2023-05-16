Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1BC7056B1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:05:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzxJ-00023d-Ic; Tue, 16 May 2023 15:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxG-00022F-UX
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxF-0001Er-58
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biE+IrOQwzQ1Xq0Ccvz0hh2N38Cghy4v9sBjAOwHiFA=;
 b=crA7W2e8W2SCdXbdgJJ9P0p7gLYRBdvl4K51OlemSVBvnMRIadgYW4CEyO3yPKJ2nBfSAH
 YTagOGwXvYrFs6ZOf3eBzho3+GK4ZpKWznLvEDS6d8guxq3O/Ar2wAanIJTR4MKRcEKpjz
 VATUZJiClIGEYAMHZrK5mfG18YaLgr0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-l2Cce6lmMQ6XCObNFfTjyg-1; Tue, 16 May 2023 15:03:18 -0400
X-MC-Unique: l2Cce6lmMQ6XCObNFfTjyg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1951854CA7;
 Tue, 16 May 2023 19:03:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAD3A4021D9;
 Tue, 16 May 2023 19:03:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 eesposit@redhat.com, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v6 09/20] block: add blk_in_drain() API
Date: Tue, 16 May 2023 15:02:27 -0400
Message-Id: <20230516190238.8401-10-stefanha@redhat.com>
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

The BlockBackend quiesce_counter is greater than zero during drained
sections. Add an API to check whether the BlockBackend is in a drained
section.

The next patch will use this API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/sysemu/block-backend-global-state.h | 1 +
 block/block-backend.c                       | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index fa83f9389c..184e667ebd 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -81,6 +81,7 @@ void blk_activate(BlockBackend *blk, Error **errp);
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
 void blk_aio_cancel(BlockAIOCB *acb);
 int blk_commit_all(void);
+bool blk_in_drain(BlockBackend *blk);
 void blk_drain(BlockBackend *blk);
 void blk_drain_all(void);
 void blk_set_on_error(BlockBackend *blk, BlockdevOnError on_read_error,
diff --git a/block/block-backend.c b/block/block-backend.c
index 68087437ac..3a5949ecce 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1270,6 +1270,13 @@ blk_check_byte_request(BlockBackend *blk, int64_t offset, int64_t bytes)
     return 0;
 }
 
+/* Are we currently in a drained section? */
+bool blk_in_drain(BlockBackend *blk)
+{
+    GLOBAL_STATE_CODE(); /* change to IO_OR_GS_CODE(), if necessary */
+    return qatomic_read(&blk->quiesce_counter);
+}
+
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 {
-- 
2.40.1


