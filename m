Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 581347169A9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42I1-0006mD-5M; Tue, 30 May 2023 12:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HI-0006ST-8H
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HG-0008Ea-EF
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tyzEuTfsOP1f01W0nbf8/VHn4VVJZIJjxKyB0bXOb4=;
 b=hhxrthfpMk293tOmo0GECq1ra+fJ1q5u7/H3Uh6CnPy4aMLoZ+pSjtEIWwlWuZW76ROo46
 NsUKPwq4o9Dwn+5G+ohEiBenHEHXJA7Jqn25xeynSOjD8tTTBS/ctXWZk1gqfugtPMGXit
 58dNZP82BSNupVgGN7VU3d3H2AJ29ng=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-WHAF-ZOnMZSOB4LAM4onCw-1; Tue, 30 May 2023 12:32:50 -0400
X-MC-Unique: WHAF-ZOnMZSOB4LAM4onCw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE2BB85A5AA;
 Tue, 30 May 2023 16:32:49 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E1BCC154D2;
 Tue, 30 May 2023 16:32:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 03/32] block: Take main AioContext lock when calling bdrv_open()
Date: Tue, 30 May 2023 18:32:10 +0200
Message-Id: <20230530163239.576632-4-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The function documentation already says that all callers must hold the
main AioContext lock, but not all of them do. This can cause assertion
failures when functions called by bdrv_open() try to drop the lock. Fix
a few more callers to take the lock before calling bdrv_open().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-4-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                          |  3 +++
 block/block-backend.c            |  2 ++
 block/qapi-sysemu.c              |  3 +++
 blockdev.c                       | 29 +++++++++++++++++++++++------
 qemu-nbd.c                       |  4 ++++
 tests/unit/test-block-iothread.c |  3 +++
 6 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/block.c b/block.c
index 6ac47112fe..79bc9c01de 100644
--- a/block.c
+++ b/block.c
@@ -7037,6 +7037,8 @@ void bdrv_img_create(const char *filename, const char *fmt,
         return;
     }
 
+    aio_context_acquire(qemu_get_aio_context());
+
     /* Create parameter list */
     create_opts = qemu_opts_append(create_opts, drv->create_opts);
     create_opts = qemu_opts_append(create_opts, proto_drv->create_opts);
@@ -7186,6 +7188,7 @@ out:
     qemu_opts_del(opts);
     qemu_opts_free(create_opts);
     error_propagate(errp, local_err);
+    aio_context_release(qemu_get_aio_context());
 }
 
 AioContext *bdrv_get_aio_context(BlockDriverState *bs)
diff --git a/block/block-backend.c b/block/block-backend.c
index 26447664ab..1d89fabd35 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -452,7 +452,9 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
     }
 
     blk = blk_new(qemu_get_aio_context(), perm, shared);
+    aio_context_acquire(qemu_get_aio_context());
     bs = bdrv_open(filename, reference, options, flags, errp);
+    aio_context_release(qemu_get_aio_context());
     if (!bs) {
         blk_unref(blk);
         return NULL;
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index cec3c1afb4..ef07151892 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -362,7 +362,10 @@ void qmp_blockdev_change_medium(const char *device,
         qdict_put_str(options, "driver", format);
     }
 
+    aio_context_acquire(qemu_get_aio_context());
     medium_bs = bdrv_open(filename, NULL, options, bdrv_flags, errp);
+    aio_context_release(qemu_get_aio_context());
+
     if (!medium_bs) {
         goto fail;
     }
diff --git a/blockdev.c b/blockdev.c
index 5d56b79df4..db2725fe74 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -662,6 +662,7 @@ err_no_opts:
 /* Takes the ownership of bs_opts */
 BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
 {
+    BlockDriverState *bs;
     int bdrv_flags = 0;
 
     GLOBAL_STATE_CODE();
@@ -676,7 +677,11 @@ BlockDriverState *bds_tree_init(QDict *bs_opts, Error **errp)
         bdrv_flags |= BDRV_O_INACTIVE;
     }
 
-    return bdrv_open(NULL, NULL, bs_opts, bdrv_flags, errp);
+    aio_context_acquire(qemu_get_aio_context());
+    bs = bdrv_open(NULL, NULL, bs_opts, bdrv_flags, errp);
+    aio_context_release(qemu_get_aio_context());
+
+    return bs;
 }
 
 void blockdev_close_all_bdrv_states(void)
@@ -1480,14 +1485,20 @@ static void external_snapshot_action(TransactionAction *action,
         }
         qdict_put_str(options, "driver", format);
     }
+    aio_context_release(aio_context);
 
+    aio_context_acquire(qemu_get_aio_context());
     state->new_bs = bdrv_open(new_image_file, snapshot_ref, options, flags,
                               errp);
+    aio_context_release(qemu_get_aio_context());
+
     /* We will manually add the backing_hd field to the bs later */
     if (!state->new_bs) {
-        goto out;
+        return;
     }
 
+    aio_context_acquire(aio_context);
+
     /*
      * Allow attaching a backing file to an overlay that's already in use only
      * if the parents don't assume that they are already seeing a valid image.
@@ -1732,15 +1743,18 @@ static void drive_backup_action(DriveBackup *backup,
     if (format) {
         qdict_put_str(options, "driver", format);
     }
+    aio_context_release(aio_context);
 
+    aio_context_acquire(qemu_get_aio_context());
     target_bs = bdrv_open(backup->target, NULL, options, flags, errp);
+    aio_context_release(qemu_get_aio_context());
+
     if (!target_bs) {
-        goto out;
+        return;
     }
 
     /* Honor bdrv_try_change_aio_context() context acquisition requirements. */
     old_context = bdrv_get_aio_context(target_bs);
-    aio_context_release(aio_context);
     aio_context_acquire(old_context);
 
     ret = bdrv_try_change_aio_context(target_bs, aio_context, NULL, errp);
@@ -3066,13 +3080,17 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     if (format) {
         qdict_put_str(options, "driver", format);
     }
+    aio_context_release(aio_context);
 
     /* Mirroring takes care of copy-on-write using the source's backing
      * file.
      */
+    aio_context_acquire(qemu_get_aio_context());
     target_bs = bdrv_open(arg->target, NULL, options, flags, errp);
+    aio_context_release(qemu_get_aio_context());
+
     if (!target_bs) {
-        goto out;
+        return;
     }
 
     zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
@@ -3082,7 +3100,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
 
     /* Honor bdrv_try_change_aio_context() context acquisition requirements. */
     old_context = bdrv_get_aio_context(target_bs);
-    aio_context_release(aio_context);
     aio_context_acquire(old_context);
 
     ret = bdrv_try_change_aio_context(target_bs, aio_context, NULL, errp);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 6ff45308a9..4276163564 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -1071,7 +1071,11 @@ int main(int argc, char **argv)
         qdict_put_str(raw_opts, "driver", "raw");
         qdict_put_str(raw_opts, "file", bs->node_name);
         qdict_put_int(raw_opts, "offset", dev_offset);
+
+        aio_context_acquire(qemu_get_aio_context());
         bs = bdrv_open(NULL, NULL, raw_opts, flags, &error_fatal);
+        aio_context_release(qemu_get_aio_context());
+
         blk_remove_bs(blk);
         blk_insert_bs(blk, bs, &error_fatal);
         bdrv_unref(bs);
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 3a5e1eb2c4..1b40e65bad 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -833,8 +833,11 @@ static void test_attach_second_node(void)
     qdict_put_str(options, "driver", "raw");
     qdict_put_str(options, "file", "base");
 
+    /* FIXME raw_open() should take ctx's lock internally */
     aio_context_acquire(ctx);
+    aio_context_acquire(main_ctx);
     filter = bdrv_open(NULL, NULL, options, BDRV_O_RDWR, &error_abort);
+    aio_context_release(main_ctx);
     aio_context_release(ctx);
 
     g_assert(blk_get_aio_context(blk) == ctx);
-- 
2.40.1


