Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D99281BAFD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:38:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGL5g-0005t2-7U; Thu, 21 Dec 2023 10:36:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5d-0005sM-TW
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rGL5c-0005ZW-IY
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 10:36:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703172960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mLpAPhOLexRIuQHAy6nH/DLSJaRi5up7/+uWx1QOq3Y=;
 b=IfflUSAMekZnB5gUiXAZBZlYwVIvojQ6pyAzZ8klzlPEYfgsO560Pe/CwT7YMZmof1Swba
 6jB5BNEs6UpuWc/PKGha0otQCxM5h2NRpytSoYZOvNMXN0c1pIsNk2qGkYd1m/kVaDkSD8
 uBHREls96npnf/eTS8yvAzhjYZDjXvc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-tJhHthZeM_S8h5hqvTd28g-1; Thu, 21 Dec 2023 10:35:55 -0500
X-MC-Unique: tJhHthZeM_S8h5hqvTd28g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A3B6185A784;
 Thu, 21 Dec 2023 15:35:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E907C159B0;
 Thu, 21 Dec 2023 15:35:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 2/6] fixup block: remove AioContext locking
Date: Thu, 21 Dec 2023 10:35:44 -0500
Message-ID: <20231221153548.1752005-3-stefanha@redhat.com>
In-Reply-To: <20231221153548.1752005-1-stefanha@redhat.com>
References: <20231221153548.1752005-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 migration/block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/block.c b/migration/block.c
index 2bcfcbfdf6..6ec6a1d6e6 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -311,10 +311,17 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
     block_mig_state.submitted++;
     blk_mig_unlock();
 
+    /*
+     * The migration thread does not have an AioContext. Lock the BQL so that
+     * I/O runs in the main loop AioContext (see
+     * qemu_get_current_aio_context()).
+     */
+    qemu_mutex_lock_iothread();
     bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
                             nr_sectors * BDRV_SECTOR_SIZE);
     blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
                                 0, blk_mig_read_cb, blk);
+    qemu_mutex_unlock_iothread();
 
     bmds->cur_sector = cur_sector + nr_sectors;
     return (bmds->cur_sector >= total_sectors);
-- 
2.43.0


