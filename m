Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6877A59C6C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Mar 2025 18:12:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trgfL-0003e8-5Z; Mon, 10 Mar 2025 13:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1trgep-0003L8-W8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:11:16 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1trgen-00016O-3x
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:11:15 -0400
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-LB6jWpV7M6ySJc6IZ8N9Xg-1; Mon,
 10 Mar 2025 13:11:08 -0400
X-MC-Unique: LB6jWpV7M6ySJc6IZ8N9Xg-1
X-Mimecast-MFC-AGG-ID: LB6jWpV7M6ySJc6IZ8N9Xg_1741626667
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B104180AF55; Mon, 10 Mar 2025 17:11:06 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.22.64.233])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 481BE1801752; Mon, 10 Mar 2025 17:11:04 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Subject: [PATCH 1/4] 9pfs: local : Introduce local_fid_fd() helper
Date: Mon, 10 Mar 2025 18:10:58 +0100
Message-ID: <20250310171101.138380-2-groug@kaod.org>
In-Reply-To: <20250310171101.138380-1-groug@kaod.org>
References: <20250310171101.138380-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: softfail client-ip=205.139.111.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Factor out duplicated code to a single helper. More users to come.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 928523afcc6c..c4366c867988 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -766,10 +766,9 @@ out:
     return err;
 }
 
-static int local_fstat(FsContext *fs_ctx, int fid_type,
-                       V9fsFidOpenState *fs, struct stat *stbuf)
+static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
 {
-    int err, fd;
+    int fd;
 
     if (fid_type == P9_FID_DIR) {
         fd = dirfd(fs->dir.stream);
@@ -777,6 +776,14 @@ static int local_fstat(FsContext *fs_ctx, int fid_type,
         fd = fs->fd;
     }
 
+    return fd;
+}
+
+static int local_fstat(FsContext *fs_ctx, int fid_type,
+                       V9fsFidOpenState *fs, struct stat *stbuf)
+{
+    int err, fd = local_fid_fd(fid_type, fs);
+
     err = fstat(fd, stbuf);
     if (err) {
         return err;
@@ -1167,13 +1174,7 @@ out:
 static int local_fsync(FsContext *ctx, int fid_type,
                        V9fsFidOpenState *fs, int datasync)
 {
-    int fd;
-
-    if (fid_type == P9_FID_DIR) {
-        fd = dirfd(fs->dir.stream);
-    } else {
-        fd = fs->fd;
-    }
+    int fd = local_fid_fd(fid_type, fs);
 
     if (datasync) {
         return qemu_fdatasync(fd);
-- 
2.48.1


