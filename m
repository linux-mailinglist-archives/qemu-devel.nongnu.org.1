Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ACAC2985
	for <lists+qemu-devel@lfdr.de>; Fri, 23 May 2025 20:22:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIX1P-0008CI-2W; Fri, 23 May 2025 14:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIX1K-0008BT-Lr
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uIX1I-0002ki-Oa
 for qemu-devel@nongnu.org; Fri, 23 May 2025 14:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748024481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FOmsgRdvvd/bZghzTo9aH5mrJw43v3x7fZV9Z2akBws=;
 b=J6CA2i1XHTj1lM4mWhxW5Qg0H7whY+8Zz2a/YmNyrXkATIB9jJcCUSJxnUp9xi952d8dkk
 vME4SoyMqwbCZqXJN3SSU5gZt3/96OtETsAEpAbbxNpDnNVTLP1A5XcUbfH4a5j5lBOd4D
 cCcJ4pBYX6e3Cw2F1T8aqtycUW57cO8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-5QGZFFfKN3WvJUrWZJwKqw-1; Fri,
 23 May 2025 14:21:20 -0400
X-MC-Unique: 5QGZFFfKN3WvJUrWZJwKqw-1
X-Mimecast-MFC-AGG-ID: 5QGZFFfKN3WvJUrWZJwKqw_1748024478
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FF4A18004AD; Fri, 23 May 2025 18:21:18 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.201])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6531180035C; Fri, 23 May 2025 18:21:15 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <codyprime@gmail.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH] qcow2: Forbid use of protocol: prefix on data_file
Date: Fri, 23 May 2025 13:20:32 -0500
Message-ID: <20250523182111.2575879-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Ever since CVE-2024-4467 (see commit 7ead9469 in qemu v9.1.0), we have
intentionally treated command-line arguments as local files, and not
protocol specifications (you have to specify backing files with
full-blown QMP if it is intentional to access something more
complicated).  However, that patch forgot about qcow2 data-file, which
is another place where we really should not be hard-coding protocol
names in the qcow2 metadata.

Fix this by changing the decision point on whether to allow protocols
to each driver, rather than hard-coded to true in the generic code;
qcow2 data_file is the only place where we change the former default
of true.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/block-global-state.h | 3 ++-
 block.c                            | 4 ++--
 block/crypto.c                     | 2 +-
 block/parallels.c                  | 2 +-
 block/qcow.c                       | 2 +-
 block/qcow2.c                      | 4 ++--
 block/qed.c                        | 2 +-
 block/raw-format.c                 | 2 +-
 block/vdi.c                        | 2 +-
 block/vhdx.c                       | 2 +-
 block/vmdk.c                       | 2 +-
 block/vpc.c                        | 2 +-
 12 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9be34b3c990..e53400de1cf 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -65,7 +65,8 @@ int co_wrapper bdrv_create(BlockDriver *drv, const char *filename,
                            QemuOpts *opts, Error **errp);

 int coroutine_fn GRAPH_UNLOCKED
-bdrv_co_create_file(const char *filename, QemuOpts *opts, Error **errp);
+bdrv_co_create_file(const char *filename, QemuOpts *opts,
+                    bool allow_protocol_prefix, Error **errp);

 BlockDriverState *bdrv_new(void);
 int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
diff --git a/block.c b/block.c
index f222e1a50a8..a5b5351e584 100644
--- a/block.c
+++ b/block.c
@@ -693,7 +693,7 @@ out:
 }

 int coroutine_fn bdrv_co_create_file(const char *filename, QemuOpts *opts,
-                                     Error **errp)
+                                     bool allow_protocol_prefix, Error **errp)
 {
     QemuOpts *protocol_opts;
     BlockDriver *drv;
@@ -702,7 +702,7 @@ int coroutine_fn bdrv_co_create_file(const char *filename, QemuOpts *opts,

     GLOBAL_STATE_CODE();

-    drv = bdrv_find_protocol(filename, true, errp);
+    drv = bdrv_find_protocol(filename, allow_protocol_prefix, errp);
     if (drv == NULL) {
         return -ENOENT;
     }
diff --git a/block/crypto.c b/block/crypto.c
index d4226cc68a4..5116bb6382c 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -821,7 +821,7 @@ block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
     }

     /* Create protocol layer */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/parallels.c b/block/parallels.c
index 3a375e2a8ab..7a90fb5220b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1117,7 +1117,7 @@ parallels_co_create_opts(BlockDriver *drv, const char *filename,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto done;
     }
diff --git a/block/qcow.c b/block/qcow.c
index 8a3e7591a92..f7501fa2f03 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -978,7 +978,7 @@ qcow_co_create_opts(BlockDriver *drv, const char *filename,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 66fba89b414..bcf4d920946 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3954,7 +3954,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto finish;
     }
@@ -3969,7 +3969,7 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     /* Create and open an external data file (protocol layer) */
     val = qdict_get_try_str(qdict, BLOCK_OPT_DATA_FILE);
     if (val) {
-        ret = bdrv_co_create_file(val, opts, errp);
+        ret = bdrv_co_create_file(val, opts, false, errp);
         if (ret < 0) {
             goto finish;
         }
diff --git a/block/qed.c b/block/qed.c
index 4a36fb39294..da23a83d623 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -788,7 +788,7 @@ bdrv_qed_co_create_opts(BlockDriver *drv, const char *filename,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/raw-format.c b/block/raw-format.c
index df16ac1ea25..a57c2922d55 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -463,7 +463,7 @@ static int coroutine_fn GRAPH_UNLOCKED
 raw_co_create_opts(BlockDriver *drv, const char *filename,
                    QemuOpts *opts, Error **errp)
 {
-    return bdrv_co_create_file(filename, opts, errp);
+    return bdrv_co_create_file(filename, opts, true, errp);
 }

 static int raw_open(BlockDriverState *bs, QDict *options, int flags,
diff --git a/block/vdi.c b/block/vdi.c
index 3ddc62a5690..87b874a7ef5 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -938,7 +938,7 @@ vdi_co_create_opts(BlockDriver *drv, const char *filename,
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &vdi_create_opts, true);

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto done;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index b2a4b813a0b..c16e4a00c8d 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2096,7 +2096,7 @@ vhdx_co_create_opts(BlockDriver *drv, const char *filename,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
diff --git a/block/vmdk.c b/block/vmdk.c
index 9c7ab037e14..576af241e59 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2332,7 +2332,7 @@ vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
     int ret;
     BlockBackend *blk = NULL;

-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto exit;
     }
diff --git a/block/vpc.c b/block/vpc.c
index 801ff5793f8..07e8ae0309a 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1118,7 +1118,7 @@ vpc_co_create_opts(BlockDriver *drv, const char *filename,
     }

     /* Create and open the file (protocol layer) */
-    ret = bdrv_co_create_file(filename, opts, errp);
+    ret = bdrv_co_create_file(filename, opts, true, errp);
     if (ret < 0) {
         goto fail;
     }
-- 
2.49.0


