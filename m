Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426447DD681
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyc-0004Ph-M8; Tue, 31 Oct 2023 15:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyO-0004Jl-LK
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxk-00068Q-02
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=byv0+w1mnnRBl6h60GOGF4/WzdTryQ3xYIFbjWyku1I=;
 b=dB0e3efvsPpN1Q65pcq9zsHt+r5ph2p4MAbI7BToJSdmfZkaEWuE4Fv/UpTeHUIlhxYwL1
 5NIutfaVACp66RwqeXSBIR/B5kOXnvczjvLL8dYlvQr3vdd7H/kIL+akRfnroab8oksLwq
 oe1aG8csjNxe1sL81Qjh4fCtXDCSSPA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-tqozEThhOKuB3fwVdTQrEA-1; Tue,
 31 Oct 2023 14:59:28 -0400
X-MC-Unique: tqozEThhOKuB3fwVdTQrEA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0189E3C02B62;
 Tue, 31 Oct 2023 18:59:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 643E325C0;
 Tue, 31 Oct 2023 18:59:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/27] block: Fix locking in media change monitor commands
Date: Tue, 31 Oct 2023 19:59:00 +0100
Message-ID: <20231031185918.346940-10-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

blk_insert_bs() requires that the caller holds the AioContext lock for
the node to be inserted. Since commit c066e808e11, neglecting to do so
causes a crash when the child has to be moved to a different AioContext
to attach it to the BlockBackend.

This fixes qmp_blockdev_insert_anon_medium(), which is called for the
QMP commands 'blockdev-insert-medium' and 'blockdev-change-medium', to
correctly take the lock.

Cc: qemu-stable@nongnu.org
Fixes: https://issues.redhat.com/browse/RHEL-3922
Fixes: c066e808e11a5c181b625537b6c78e0de27a4801
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231013153302.39234-2-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi-sysemu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index 3f614cbc04..1618cd225a 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -237,6 +237,7 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
                                             BlockDriverState *bs, Error **errp)
 {
     Error *local_err = NULL;
+    AioContext *ctx;
     bool has_device;
     int ret;
 
@@ -258,7 +259,11 @@ static void qmp_blockdev_insert_anon_medium(BlockBackend *blk,
         return;
     }
 
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
     ret = blk_insert_bs(blk, bs, errp);
+    aio_context_release(ctx);
+
     if (ret < 0) {
         return;
     }
-- 
2.41.0


