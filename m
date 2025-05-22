Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0832FAC0C47
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 15:09:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI5et-0000Q4-3s; Thu, 22 May 2025 09:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI5eq-0000PA-Jg
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:08:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uI5en-0005ZQ-0E
 for qemu-devel@nongnu.org; Thu, 22 May 2025 09:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747919299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=B6VW/3oe11OxDbvvgFMEn9ha9blcsNfYgl5BIMQuc9k=;
 b=FDEcaw3goOWf93hqFddbA0T5MCtg9ENh4A9JbBgma38pmlqFMcKaBMRxBL2Mi1eeLdupKE
 zSnH8sQU+IkyUrudwbOe0HYJ0KLfpJqZL856+3evn9dQT7eh6rOxc+ZwXo+WYI1Chm7Zqh
 Vrfu/NypFYy5yTe/APshKI+3Q4hw9fM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-feZuLH9bPE-UdENrDDZEvA-1; Thu,
 22 May 2025 09:08:16 -0400
X-MC-Unique: feZuLH9bPE-UdENrDDZEvA-1
X-Mimecast-MFC-AGG-ID: feZuLH9bPE-UdENrDDZEvA_1747919295
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 371B21800368; Thu, 22 May 2025 13:08:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.45.226.76])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F7011800879; Thu, 22 May 2025 13:08:11 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 bmarzins@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2] file-posix: Probe paths and retry SG_IO on potential path
 errors
Date: Thu, 22 May 2025 15:08:03 +0200
Message-ID: <20250522130803.34738-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When scsi-block is used on a host multipath device, it runs into the
problem that the kernel dm-mpath doesn't know anything about SCSI or
SG_IO and therefore can't decide if a SG_IO request returned an error
and needs to be retried on a different path. Instead of getting working
failover, an error is returned to scsi-block and handled according to
the configured error policy. Obviously, this is not what users want,
they want working failover.

QEMU can parse the SG_IO result and determine whether this could have
been a path error, but just retrying the same request could just send it
to the same failing path again and result in the same error.

With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
block devices (queued in the device mapper tree for Linux 6.16), we can
tell the kernel to probe all paths and tell us if any usable paths
remained. If so, we can now retry the SG_IO ioctl and expect it to be
sent to a working path.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
v2:
- Add a comment to explain retry scenarios [Stefan]
- Handle -EAGAIN returned for suspended devices [Ben]

 block/file-posix.c | 115 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ec95b74869..569f4ca472 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -41,6 +41,7 @@
 
 #include "scsi/pr-manager.h"
 #include "scsi/constants.h"
+#include "scsi/utils.h"
 
 #if defined(__APPLE__) && (__MACH__)
 #include <sys/ioctl.h>
@@ -72,6 +73,7 @@
 #include <linux/blkzoned.h>
 #endif
 #include <linux/cdrom.h>
+#include <linux/dm-ioctl.h>
 #include <linux/fd.h>
 #include <linux/fs.h>
 #include <linux/hdreg.h>
@@ -138,6 +140,22 @@
 #define RAW_LOCK_PERM_BASE             100
 #define RAW_LOCK_SHARED_BASE           200
 
+/*
+ * Multiple retries are mostly meant for two separate scenarios:
+ *
+ * - DM_MPATH_PROBE_PATHS returns success, but before SG_IO completes, another
+ *   path goes down.
+ *
+ * - DM_MPATH_PROBE_PATHS failed all paths in the current path group, so we have
+ *   to send another SG_IO to switch to another path group to probe the paths in
+ *   it.
+ *
+ * Even if each path is in a separate path group (path_grouping_policy set to
+ * failover), it's rare to have more than eight path groups - and even then
+ * pretty unlikely that only bad path groups would be chosen in eight retries.
+ */
+#define SG_IO_MAX_RETRIES 8
+
 typedef struct BDRVRawState {
     int fd;
     bool use_lock;
@@ -165,6 +183,7 @@ typedef struct BDRVRawState {
     bool use_linux_aio:1;
     bool has_laio_fdsync:1;
     bool use_linux_io_uring:1;
+    bool use_mpath:1;
     int page_cache_inconsistent; /* errno from fdatasync failure */
     bool has_fallocate;
     bool needs_alignment;
@@ -4264,15 +4283,105 @@ hdev_open_Mac_error:
     /* Since this does ioctl the device must be already opened */
     bs->sg = hdev_is_sg(bs);
 
+    /* sg devices aren't even block devices and can't use dm-mpath */
+    s->use_mpath = !bs->sg;
+
     return ret;
 }
 
 #if defined(__linux__)
+#if defined(DM_MPATH_PROBE_PATHS)
+static bool sgio_path_error(int ret, sg_io_hdr_t *io_hdr)
+{
+    if (ret < 0) {
+        switch (ret) {
+        case -ENODEV:
+            return true;
+        case -EAGAIN:
+            /*
+             * The device is probably suspended. This happens while the dm table
+             * is reloaded, e.g. because a path is added or removed. This is an
+             * operation that should complete within 1ms, so just wait a bit and
+             * retry.
+             *
+             * If the device was suspended for another reason, we'll wait and
+             * retry SG_IO_MAX_RETRIES times. This is a tolerable delay before
+             * we return an error and potentially stop the VM.
+             */
+            qemu_co_sleep_ns(QEMU_CLOCK_REALTIME, 1000000);
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    if (io_hdr->host_status != SCSI_HOST_OK) {
+        return true;
+    }
+
+    switch (io_hdr->status) {
+    case GOOD:
+    case CONDITION_GOOD:
+    case INTERMEDIATE_GOOD:
+    case INTERMEDIATE_C_GOOD:
+    case RESERVATION_CONFLICT:
+    case COMMAND_TERMINATED:
+        return false;
+    case CHECK_CONDITION:
+        return !scsi_sense_buf_is_guest_recoverable(io_hdr->sbp,
+                                                    io_hdr->mx_sb_len);
+    default:
+        return true;
+    }
+}
+
+static bool coroutine_fn hdev_co_ioctl_sgio_retry(RawPosixAIOData *acb, int ret)
+{
+    BDRVRawState *s = acb->bs->opaque;
+    RawPosixAIOData probe_acb;
+
+    if (!s->use_mpath) {
+        return false;
+    }
+
+    if (!sgio_path_error(ret, acb->ioctl.buf)) {
+        return false;
+    }
+
+    probe_acb = (RawPosixAIOData) {
+        .bs         = acb->bs,
+        .aio_type   = QEMU_AIO_IOCTL,
+        .aio_fildes = s->fd,
+        .aio_offset = 0,
+        .ioctl      = {
+            .buf        = NULL,
+            .cmd        = DM_MPATH_PROBE_PATHS,
+        },
+    };
+
+    ret = raw_thread_pool_submit(handle_aiocb_ioctl, &probe_acb);
+    if (ret == -ENOTTY) {
+        s->use_mpath = false;
+    } else if (ret == -EAGAIN) {
+        /* The device might be suspended for a table reload, worth retrying */
+        return true;
+    }
+
+    return ret == 0;
+}
+#else
+static bool coroutine_fn hdev_co_ioctl_sgio_retry(RawPosixAIOData *acb, int ret)
+{
+    return false;
+}
+#endif /* DM_MPATH_PROBE_PATHS */
+
 static int coroutine_fn
 hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
 {
     BDRVRawState *s = bs->opaque;
     RawPosixAIOData acb;
+    int retries = SG_IO_MAX_RETRIES;
     int ret;
 
     ret = fd_open(bs);
@@ -4300,7 +4409,11 @@ hdev_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
         },
     };
 
-    return raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
+    do {
+        ret = raw_thread_pool_submit(handle_aiocb_ioctl, &acb);
+    } while (req == SG_IO && retries-- && hdev_co_ioctl_sgio_retry(&acb, ret));
+
+    return ret;
 }
 #endif /* linux */
 
-- 
2.49.0


