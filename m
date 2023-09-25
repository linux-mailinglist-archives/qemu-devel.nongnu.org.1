Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 131157AD461
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkhk9-00056f-WD; Mon, 25 Sep 2023 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhk6-00054f-GT
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qkhk4-0005Py-QR
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695633539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=WKdc4Y7/tYFbJKWsFItEtt0tfkJ6YxUAwcWYB17ABEk=;
 b=hUjuT1JLaP45IFdpqjyvu71q+4GI7A2Zus+WauOBsDGYlxaOyHQl8s+KIW+eYMj5V9zfSr
 Ua9smg3D8YhrNRuIRmJncKyX1ZzLHX8V/M6gXe77NYwqKC04tua5RVsNr29wyIAmIGg/jS
 sJmDwNjyErO63YjAU6pUx4p3FdV+r3I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-pSP0zc4xNNW1J6KRzBDZTQ-1; Mon, 25 Sep 2023 05:18:57 -0400
X-MC-Unique: pSP0zc4xNNW1J6KRzBDZTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82273803470;
 Mon, 25 Sep 2023 09:18:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D9C712026D4B;
 Mon, 25 Sep 2023 09:18:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>,
	qemu-stable@nongnu.org
Subject: [PATCH] hw/scsi/scsi-disk: Disallow block sizes smaller than 512
 [CVE-2023-42467]
Date: Mon, 25 Sep 2023 11:18:54 +0200
Message-ID: <20230925091854.49198-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

We are doing things like

    nb_sectors /= (s->qdev.blocksize / BDRV_SECTOR_SIZE);

in the code here (e.g. in scsi_disk_emulate_mode_sense()), so if
the blocksize is smaller than BDRV_SECTOR_SIZE (=512), this crashes
with a division by 0 exception. Thus disallow block sizes of 256
bytes to avoid this situation.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1813
CVE: 2023-42467
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/scsi-disk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e0d79c7966..477ee2bcd4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1628,9 +1628,10 @@ static void scsi_disk_emulate_mode_select(SCSIDiskReq *r, uint8_t *inbuf)
          * Since the existing code only checks/updates bits 8-15 of the block
          * size, restrict ourselves to the same requirement for now to ensure
          * that a block size set by a block descriptor and then read back by
-         * a subsequent SCSI command will be the same
+         * a subsequent SCSI command will be the same. Also disallow a block
+         * size of 256 since we cannot handle anything below BDRV_SECTOR_SIZE.
          */
-        if (bs && !(bs & ~0xff00) && bs != s->qdev.blocksize) {
+        if (bs && !(bs & ~0xfe00) && bs != s->qdev.blocksize) {
             s->qdev.blocksize = bs;
             trace_scsi_disk_mode_select_set_blocksize(s->qdev.blocksize);
         }
-- 
2.41.0


