Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B12800D1F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:26:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94SU-0008Sy-EW; Fri, 01 Dec 2023 09:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r94SS-0008Rg-0O
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:25:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r94SP-0006mk-NX
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701440728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqupLJmn2EpuzQJEY5E59UNe8+R5Rpy60gPLwapqpBg=;
 b=SK0Dz1NonOSxddCv4/gyw9kUDiRdPaILq68EXt/TPZHuRdN220nuhUrh7Zi1AdM6ybZZhz
 9rSEdgiy2UiMySynDdPyZw5TYfqstY7LAm41ut9BlS/MBTYLm1NBCnuvCup3Ke93dPFVDf
 ku1E0FaZbI+JwbOm2K+NbSnMkjhlt2U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-apz819leMXiDxLLrzy2_1A-1; Fri,
 01 Dec 2023 09:25:25 -0500
X-MC-Unique: apz819leMXiDxLLrzy2_1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 286091C05AF1;
 Fri,  1 Dec 2023 14:25:25 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FA711C060AE;
 Fri,  1 Dec 2023 14:25:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] block: Fix crash when loading snapshot on inactive node
Date: Fri,  1 Dec 2023 15:25:18 +0100
Message-ID: <20231201142520.32255-2-kwolf@redhat.com>
In-Reply-To: <20231201142520.32255-1-kwolf@redhat.com>
References: <20231201142520.32255-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

bdrv_is_read_only() only checks if the node is configured to be
read-only eventually, but even if it returns false, writing to the node
may not be permitted at the moment (because it's inactive).

bdrv_is_writable() checks that the node can be written to right now, and
this is what the snapshot operations really need.

Change bdrv_can_snapshot() to use bdrv_is_writable() to fix crashes like
the following:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: ../block/io.c:1990: int bdrv_co_write_req_prepare(BdrvChild *, int64_t, int64_t, BdrvTrackedRequest *, int): Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.

The resulting error message after this patch isn't perfect yet, but at
least it doesn't crash any more:

$ ./qemu-system-x86_64 -hda /tmp/test.qcow2 -loadvm foo -incoming defer
qemu-system-x86_64: Device 'ide0-hd0' is writable but does not support snapshots

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/snapshot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/snapshot.c b/block/snapshot.c
index ec8cf4810b..c4d40e80dd 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -196,8 +196,10 @@ bdrv_snapshot_fallback(BlockDriverState *bs)
 int bdrv_can_snapshot(BlockDriverState *bs)
 {
     BlockDriver *drv = bs->drv;
+
     GLOBAL_STATE_CODE();
-    if (!drv || !bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
+
+    if (!drv || !bdrv_is_inserted(bs) || !bdrv_is_writable(bs)) {
         return 0;
     }
 
-- 
2.43.0


