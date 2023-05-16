Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612D705300
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 18:02:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyx6x-0003hL-N9; Tue, 16 May 2023 12:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f91ce58cb2eba96192bdbd730e7a0952873f6c05@lizzy.crudebyte.com>)
 id 1pyx6o-0003VX-T7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:01:07 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f91ce58cb2eba96192bdbd730e7a0952873f6c05@lizzy.crudebyte.com>)
 id 1pyx6n-0005Cz-7c
 for qemu-devel@nongnu.org; Tue, 16 May 2023 12:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=ZJHoujVIp3sRkQlKqLa6nZjxbiJBRyfjnlp5F8WFlXM=; b=LTvs5
 Myc3zHldKijzcnyfoDdeZZanqJwSUr63yroarz+VNKMr2AmXOQHdpK638WYwDVgWhczOvRDkM+D8j
 sLgMjwPLUZhdwuJe4ZY7nRuCfnIe9Phv+LSQ717dqEvzQlsbYUxXoV0VfIddJRd1FN6PUBiTQD/Pg
 wfVdvfWIeqHkxO/EmNupmhMVcXz8O747NelvhXiA66Q91m1JFlB5AuDBSjK9A44bfQNFYh0Hkpv3V
 f/WKXQqbMEwHzzNQHWeJ5JRqw+hIxicaIjezf12kADG1pKXU311LR7aJGa6xNDadl0S1NixHrvwXZ
 8XJtd4iYyROnSq806mP901eRyAE1w==;
Message-Id: <f91ce58cb2eba96192bdbd730e7a0952873f6c05.1684250463.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1684250463.git.qemu_oss@crudebyte.com>
References: <cover.1684250463.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 May 2023 17:21:04 +0200
Subject: [PULL 2/4] tests/9p: fix potential leak in v9fs_rreaddir()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=f91ce58cb2eba96192bdbd730e7a0952873f6c05@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Free allocated directory entries in v9fs_rreaddir() if argument
`entries` was passed as NULL, to avoid a memory leak. It is
explicitly allowed by design for `entries` to be NULL. [1]

[1] https://lore.kernel.org/all/1690923.g4PEXVpXuU@silver

Reported-by: Coverity (CID 1487558)
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <E1psh5T-0002XN-1C@lizzy.crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index e4a368e036..b8adc8d4b9 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -594,6 +594,8 @@ void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
 {
     uint32_t local_count;
     struct V9fsDirent *e = NULL;
+    /* only used to avoid a leak if entries was NULL */
+    struct V9fsDirent *unused_entries = NULL;
     uint16_t slen;
     uint32_t n = 0;
 
@@ -612,6 +614,8 @@ void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
             e = g_new(struct V9fsDirent, 1);
             if (entries) {
                 *entries = e;
+            } else {
+                unused_entries = e;
             }
         } else {
             e = e->next = g_new(struct V9fsDirent, 1);
@@ -628,6 +632,7 @@ void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
         *nentries = n;
     }
 
+    v9fs_free_dirents(unused_entries);
     v9fs_req_free(req);
 }
 
-- 
2.30.2


