Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBEF736CB8
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb1z-0002he-2K; Tue, 20 Jun 2023 09:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBb1u-0002fr-Ag
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:04:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBb1s-0006rk-Ry
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687266256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lq7Ws+6N6X35uoKMgSVWmcImJ1QheW9aZBUfubNT+gU=;
 b=GBo66HnEXaRLs4Tffdx3TX/rHi6P3f/6yG5l7TQXSTraOgS/UJtym3YmMNgXaf75hJrVOy
 dxuQ5nVQXRUNa2COXSxH9kmtWpBtaNTGTcOYxrw/MKl/AUqAqb0XjHp9hInYMSM2CNYX0m
 1mqSPnxyjOUYszzFWTAc04/XgB7zeQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-424-qS-6i6dENg2DQfwh01eyhA-1; Tue, 20 Jun 2023 09:04:12 -0400
X-MC-Unique: qS-6i6dENg2DQfwh01eyhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F00B6805BFB;
 Tue, 20 Jun 2023 13:03:59 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED2C72166B26;
 Tue, 20 Jun 2023 13:03:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH v1 1/4] softmmu/physmem: Warn with ram_block_discard_range()
 on MAP_PRIVATE file mapping
Date: Tue, 20 Jun 2023 15:03:51 +0200
Message-Id: <20230620130354.322180-2-david@redhat.com>
In-Reply-To: <20230620130354.322180-1-david@redhat.com>
References: <20230620130354.322180-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ram_block_discard_range() cannot possibly do the right thing in
MAP_PRIVATE file mappings in the general case.

To achieve the documented semantics, we also have to punch a hole into
the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
of such a file.

For example, using VM templating -- see commit b17fbbe55cba ("migration:
allow private destination ram with x-ignore-shared") -- in combination with
any mechanism that relies on discarding of RAM is problematic. This
includes:
* Postcopy live migration
* virtio-balloon inflation/deflation or free-page-reporting
* virtio-mem

So at least warn that there is something possibly dangerous is going on
when using ram_block_discard_range() in these cases.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 6bdd944fe8..27c7219c82 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3451,6 +3451,24 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
              * so a userfault will trigger.
              */
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
+            /*
+             * We'll discard data from the actual file, even though we only
+             * have a MAP_PRIVATE mapping, possibly messing with other
+             * MAP_PRIVATE/MAP_SHARED mappings. There is no easy way to
+             * change that behavior whithout violating the promised
+             * semantics of ram_block_discard_range().
+             *
+             * Only warn, because it work as long as nobody else uses that
+             * file.
+             */
+            if (!qemu_ram_is_shared(rb)) {
+                warn_report_once("ram_block_discard_range: Discarding RAM"
+                                 " in private file mappings is possibly"
+                                 " dangerous, because it will modify the"
+                                 " underlying file and will affect other"
+                                 " users of the file");
+            }
+
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                             start, length);
             if (ret) {
-- 
2.40.1


