Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAF4A2F30A
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 17:19:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWNa-0006aZ-WF; Mon, 10 Feb 2025 11:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNR-0006U7-Qx
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1thWNP-00012D-TW
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:11:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739203875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x5zLuQrHVGbOmvU8jjmcpxMxUJDwC9esChLaBL+yZwE=;
 b=DbnG8cp7+mW6WDO2YSINpf4ImYmVu1OrIvOMEStqpITJJ8l4JhADw1FgPSs9KO8RRECfPz
 7LPf3B+GuS/DIebIu0PDFMNFl8RPwY+WiBQw2Gwld84G0QZjPRIweXf+cUrdVGgCfcIRkZ
 YsH5zQwnLBZa+nmUR6TI7tJm3kqIhJY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-YkR4w-KaM3aiEJS_fRlHqw-1; Mon,
 10 Feb 2025 11:11:13 -0500
X-MC-Unique: YkR4w-KaM3aiEJS_fRlHqw-1
X-Mimecast-MFC-AGG-ID: YkR4w-KaM3aiEJS_fRlHqw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C23041801A16; Mon, 10 Feb 2025 16:11:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.225.156])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B2E8195608D; Mon, 10 Feb 2025 16:11:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 11/25] block: Inactivate external snapshot overlays when
 necessary
Date: Mon, 10 Feb 2025 17:10:20 +0100
Message-ID: <20250210161034.76494-12-kwolf@redhat.com>
In-Reply-To: <20250210161034.76494-1-kwolf@redhat.com>
References: <20250210161034.76494-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Putting an active block node on top of an inactive one is strictly
speaking an invalid configuration and the next patch will turn it into a
hard error.

However, taking a snapshot while disk images are inactive after
completing migration has an important use case: After migrating to a
file, taking an external snapshot is what is needed to take a full VM
snapshot.

In order for this to keep working after the later patches, change
creating a snapshot such that it automatically inactivates an overlay
that is added on top of an already inactive node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20250204211407.381505-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/blockdev.c b/blockdev.c
index 218024497b..eb2517f1dd 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1497,6 +1497,22 @@ static void external_snapshot_action(TransactionAction *action,
         return;
     }
 
+    /*
+     * Older QEMU versions have allowed adding an active parent node to an
+     * inactive child node. This is unsafe in the general case, but there is an
+     * important use case, which is taking a VM snapshot with migration to file
+     * and then adding an external snapshot while the VM is still stopped and
+     * images are inactive. Requiring the user to explicitly create the overlay
+     * as inactive would break compatibility, so just do it automatically here
+     * to keep this working.
+     */
+    if (bdrv_is_inactive(state->old_bs) && !bdrv_is_inactive(state->new_bs)) {
+        ret = bdrv_inactivate(state->new_bs, errp);
+        if (ret < 0) {
+            return;
+        }
+    }
+
     ret = bdrv_append(state->new_bs, state->old_bs, errp);
     if (ret < 0) {
         return;
-- 
2.48.1


