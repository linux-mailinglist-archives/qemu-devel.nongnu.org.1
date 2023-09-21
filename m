Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D1A7A94AA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:23:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJdv-0006LA-B8; Thu, 21 Sep 2023 09:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJdJ-0005r1-Oh
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:22:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJdI-0003pI-3P
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfNxVgNpRH4D92+qQc1/DlhdvElkkvzgQCLXKMX0L98=;
 b=B1tnnTSE3PYVUWgDUWN2ClUn2e/fAX42jwda2KejNTtpWkoUBM5MW3e2Ms6R/szkA9lyFe
 UIA+mShwJWG5cruZhclH7+K+KDlCcjmariefwTz06h55Rzzh+rUkFFS0lhiFXaHY+daG++
 l+ILy3VRBjkf4x5WfREQycn3kUpsuWI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-xdN0rCWLNfSurkC_jiAUDQ-1; Thu, 21 Sep 2023 08:13:16 -0400
X-MC-Unique: xdN0rCWLNfSurkC_jiAUDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0774D85A5BA;
 Thu, 21 Sep 2023 12:13:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4A8C40C2070;
 Thu, 21 Sep 2023 12:13:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B0BB21E690B; Thu, 21 Sep 2023 14:13:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v3 5/7] block/vdi: Clean up local variable shadowing
Date: Thu, 21 Sep 2023 14:13:10 +0200
Message-ID: <20230921121312.1301864-6-armbru@redhat.com>
In-Reply-To: <20230921121312.1301864-1-armbru@redhat.com>
References: <20230921121312.1301864-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Tracked down with -Wshadow=local.
Clean up: delete inner declarations when they are actually redundant,
else rename variables.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6c35309e04..934e1b849b 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -634,7 +634,6 @@ vdi_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
         bmap_entry = le32_to_cpu(s->bmap[block_index]);
         if (!VDI_IS_ALLOCATED(bmap_entry)) {
             /* Allocate new block and write to it. */
-            uint64_t data_offset;
             qemu_co_rwlock_upgrade(&s->bmap_lock);
             bmap_entry = le32_to_cpu(s->bmap[block_index]);
             if (VDI_IS_ALLOCATED(bmap_entry)) {
@@ -700,7 +699,7 @@ nonallocating_write:
         /* One or more new blocks were allocated. */
         VdiHeader *header;
         uint8_t *base;
-        uint64_t offset;
+        uint64_t bmap_offset;
         uint32_t n_sectors;
 
         g_free(block);
@@ -723,11 +722,11 @@ nonallocating_write:
         bmap_first /= (SECTOR_SIZE / sizeof(uint32_t));
         bmap_last /= (SECTOR_SIZE / sizeof(uint32_t));
         n_sectors = bmap_last - bmap_first + 1;
-        offset = s->bmap_sector + bmap_first;
+        bmap_offset = s->bmap_sector + bmap_first;
         base = ((uint8_t *)&s->bmap[0]) + bmap_first * SECTOR_SIZE;
         logout("will write %u block map sectors starting from entry %u\n",
                n_sectors, bmap_first);
-        ret = bdrv_co_pwrite(bs->file, offset * SECTOR_SIZE,
+        ret = bdrv_co_pwrite(bs->file, bmap_offset * SECTOR_SIZE,
                              n_sectors * SECTOR_SIZE, base, 0);
     }
 
-- 
2.41.0


