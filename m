Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD61DA5CC26
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 18:30:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3PG-00016u-2O; Tue, 11 Mar 2025 13:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3PC-00015j-Lj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:38 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P4-0004wv-Ov
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:38 -0400
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-tEqOHbBBPsy-O2DmC7_JMA-1; Tue,
 11 Mar 2025 13:28:27 -0400
X-MC-Unique: tEqOHbBBPsy-O2DmC7_JMA-1
X-Mimecast-MFC-AGG-ID: tEqOHbBBPsy-O2DmC7_JMA_1741714106
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F23B1955BC9; Tue, 11 Mar 2025 17:28:26 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E0A61955BCB; Tue, 11 Mar 2025 17:28:23 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 4/6] 9pfs: Introduce futimens file op
Date: Tue, 11 Mar 2025 18:28:07 +0100
Message-ID: <20250311172809.250913-5-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add an futimens operation to the fs driver and use if when a fid has
a valid file descriptor. This is required to support more cases where
the client wants to do an action on an unlinked file which it still
has an open file decriptor for.

Only 9P2000.L was considered.

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>

v2: - moved v9fs_co_futimens() near v9fs_co_utimensat() in coth.h
    - similar change in file-op-9p.h
---
 fsdev/file-op-9p.h |  2 ++
 hw/9pfs/9p-local.c |  9 +++++++++
 hw/9pfs/9p-synth.c |  8 ++++++++
 hw/9pfs/9p-util.h  |  1 +
 hw/9pfs/9p.c       |  6 +++++-
 hw/9pfs/cofs.c     | 19 +++++++++++++++++++
 hw/9pfs/coth.h     |  2 ++
 7 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 26ba1438c0ed..b9dae8c84c23 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -129,6 +129,8 @@ struct FileOperations {
     int (*chown)(FsContext *, V9fsPath *, FsCred *);
     int (*mknod)(FsContext *, V9fsPath *, const char *, FsCred *);
     int (*utimensat)(FsContext *, V9fsPath *, const struct timespec *);
+    int (*futimens)(FsContext *ctx, int fid_type, V9fsFidOpenState *fs,
+                    const struct timespec *times);
     int (*remove)(FsContext *, const char *);
     int (*symlink)(FsContext *, const char *, V9fsPath *,
                    const char *, FsCred *);
diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 0b33da8d2a46..31e216227cb9 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1100,6 +1100,14 @@ out:
     return ret;
 }
 
+static int local_futimens(FsContext *s, int fid_type, V9fsFidOpenState *fs,
+                          const struct timespec *times)
+{
+    int fd = local_fid_fd(fid_type, fs);
+
+    return qemu_futimens(fd, times);
+}
+
 static int local_unlinkat_common(FsContext *ctx, int dirfd, const char *name,
                                  int flags)
 {
@@ -1626,4 +1634,5 @@ FileOperations local_ops = {
     .unlinkat = local_unlinkat,
     .has_valid_file_handle = local_has_valid_file_handle,
     .ftruncate = local_ftruncate,
+    .futimens = local_futimens,
 };
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 3d28afc4d03d..9cd188422421 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -424,6 +424,13 @@ static int synth_utimensat(FsContext *fs_ctx, V9fsPath *path,
     return 0;
 }
 
+static int synth_futimens(FsContext *fs_ctx, int fid_type, V9fsFidOpenState *fs,
+                          const struct timespec *buf)
+{
+    errno = ENOSYS;
+    return -1;
+}
+
 static int synth_remove(FsContext *ctx, const char *path)
 {
     errno = EPERM;
@@ -664,4 +671,5 @@ FileOperations synth_ops = {
     .unlinkat     = synth_unlinkat,
     .has_valid_file_handle = synth_has_valid_file_handle,
     .ftruncate    = synth_ftruncate,
+    .futimens     = synth_futimens,
 };
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 7bc4ec8e85cc..a1924fe3f05a 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -103,6 +103,7 @@ static inline int errno_to_dotl(int err) {
 #define qemu_renameat   renameat
 #define qemu_utimensat  utimensat
 #define qemu_unlinkat   unlinkat
+#define qemu_futimens   futimens
 
 static inline void close_preserve_errno(int fd)
 {
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 4616bd763012..501c5a4cdff2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1708,7 +1708,11 @@ static void coroutine_fn v9fs_setattr(void *opaque)
         } else {
             times[1].tv_nsec = UTIME_OMIT;
         }
-        err = v9fs_co_utimensat(pdu, &fidp->path, times);
+        if (fid_has_valid_handle(pdu->s, fidp)) {
+            err = v9fs_co_futimens(pdu, fidp, times);
+        } else {
+            err = v9fs_co_utimensat(pdu, &fidp->path, times);
+        }
         if (err < 0) {
             goto out;
         }
diff --git a/hw/9pfs/cofs.c b/hw/9pfs/cofs.c
index 893466fb1a44..12fa8c9fe9cd 100644
--- a/hw/9pfs/cofs.c
+++ b/hw/9pfs/cofs.c
@@ -139,6 +139,25 @@ int coroutine_fn v9fs_co_utimensat(V9fsPDU *pdu, V9fsPath *path,
     return err;
 }
 
+int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
+                                  struct timespec times[2])
+{
+    int err;
+    V9fsState *s = pdu->s;
+
+    if (v9fs_request_cancelled(pdu)) {
+        return -EINTR;
+    }
+    v9fs_co_run_in_worker(
+        {
+            err = s->ops->futimens(&s->ctx, fidp->fid_type, &fidp->fs, times);
+            if (err < 0) {
+                err = -errno;
+            }
+        });
+    return err;
+}
+
 int coroutine_fn v9fs_co_chown(V9fsPDU *pdu, V9fsPath *path, uid_t uid,
                                gid_t gid)
 {
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 62e922dc12e3..7906fa7782d8 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -71,6 +71,8 @@ int coroutine_fn v9fs_co_statfs(V9fsPDU *, V9fsPath *, struct statfs *);
 int coroutine_fn v9fs_co_lstat(V9fsPDU *, V9fsPath *, struct stat *);
 int coroutine_fn v9fs_co_chmod(V9fsPDU *, V9fsPath *, mode_t);
 int coroutine_fn v9fs_co_utimensat(V9fsPDU *, V9fsPath *, struct timespec [2]);
+int coroutine_fn v9fs_co_futimens(V9fsPDU *pdu, V9fsFidState *fidp,
+                                  struct timespec times[2]);
 int coroutine_fn v9fs_co_chown(V9fsPDU *, V9fsPath *, uid_t, gid_t);
 int coroutine_fn v9fs_co_truncate(V9fsPDU *, V9fsPath *, off_t);
 int coroutine_fn v9fs_co_ftruncate(V9fsPDU *pdu, V9fsFidState *fidp,
-- 
2.48.1


