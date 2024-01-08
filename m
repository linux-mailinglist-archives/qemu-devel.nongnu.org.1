Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59944827767
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIU-0002uV-1b; Mon, 08 Jan 2024 13:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIO-0002tc-UD
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIJ-0002iY-KH
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wgcYKi/r2SMKw7I36yuqhU6jb49Ixy2qK4rbw/X/tiI=;
 b=DMTi8lzlrvgohzNLktxK74C6wPWspTFZcevrcs65JOuezNK0mRd5G4ZhU/rQ3czGtQFvZj
 NFPdJ+LAUGETL8dObm0ZgPWjsGcsT9EP9xRTlLRF/qhkUKAjXksaLDt7p+oAQFTXRXRaW1
 P3GDXEJU60K8AXWOuHRt8UDOQgXltyk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-l6d7cwIdPK-cL0GA6XzqhQ-1; Mon,
 08 Jan 2024 13:24:13 -0500
X-MC-Unique: l6d7cwIdPK-cL0GA6XzqhQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4EFE29AB3E1;
 Mon,  8 Jan 2024 18:24:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B20A63C2E;
 Mon,  8 Jan 2024 18:24:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/29] block: adapt to new import path for qobject data type
 headers
Date: Mon,  8 Jan 2024 18:23:40 +0000
Message-ID: <20240108182405.1135436-5-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block.c                              |  8 ++++----
 block/blkdebug.c                     |  6 +++---
 block/blkio.c                        |  2 +-
 block/blklogwrites.c                 |  4 ++--
 block/blkverify.c                    |  4 ++--
 block/copy-before-write.c            |  2 +-
 block/copy-on-read.c                 |  2 +-
 block/curl.c                         |  4 ++--
 block/file-posix.c                   |  4 ++--
 block/file-win32.c                   |  4 ++--
 block/gluster.c                      |  4 ++--
 block/iscsi.c                        |  4 ++--
 block/monitor/block-hmp-cmds.c       |  4 ++--
 block/nbd.c                          |  2 +-
 block/nfs.c                          |  4 ++--
 block/null.c                         |  4 ++--
 block/nvme.c                         |  4 ++--
 block/parallels.c                    |  2 +-
 block/qapi-sysemu.c                  |  2 +-
 block/qapi.c                         | 10 +++++-----
 block/qcow.c                         |  4 ++--
 block/qcow2.c                        |  4 ++--
 block/qed.c                          |  2 +-
 block/quorum.c                       |  8 ++++----
 block/rbd.c                          |  8 ++++----
 block/replication.c                  |  2 +-
 block/snapshot.c                     |  6 +++---
 block/ssh.c                          |  4 ++--
 block/stream.c                       |  2 +-
 block/vhdx.c                         |  2 +-
 block/vmdk.c                         |  4 ++--
 block/vpc.c                          |  2 +-
 block/vvfat.c                        |  4 ++--
 blockdev.c                           | 10 +++++-----
 blockjob.c                           |  2 +-
 qemu-img.c                           |  4 ++--
 qemu-io-cmds.c                       |  2 +-
 qemu-io.c                            |  4 ++--
 qemu-nbd.c                           |  4 ++--
 storage-daemon/qemu-storage-daemon.c |  4 ++--
 40 files changed, 81 insertions(+), 81 deletions(-)

diff --git a/block.c b/block.c
index a097772238..72bb9d7350 100644
--- a/block.c
+++ b/block.c
@@ -36,10 +36,10 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qnull.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qnull.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "sysemu/block-backend.h"
diff --git a/block/blkdebug.c b/block/blkdebug.c
index 9da8c9eddc..7f173f6336 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -33,9 +33,9 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "sysemu/qtest.h"
 
diff --git a/block/blkio.c b/block/blkio.c
index 0a0a6c0f5f..5473dac76b 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -16,7 +16,7 @@
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "exec/memory.h" /* for ram_block_discard_disable() */
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 7207b2e757..81452503fa 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -14,8 +14,8 @@
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/blkverify.c b/block/blkverify.c
index ec45d8335e..b6ced14985 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -12,8 +12,8 @@
 #include "qemu/sockets.h" /* for EINPROGRESS on Windows */
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 0842a1a6df..9275f5c237 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qjson.h"
 
 #include "sysemu/block-backend.h"
 #include "qemu/cutils.h"
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index c36f253d16..accf1402f0 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -25,7 +25,7 @@
 #include "block/block_int.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "block/copy-on-read.h"
 
 
diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef..bdca9b0c91 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -29,8 +29,8 @@
 #include "qemu/option.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "crypto/secret.h"
 #include <curl/curl.h>
 #include "qemu/cutils.h"
diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..70bec5442f 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -36,8 +36,8 @@
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
 #include "block/raw-aio.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 
 #include "scsi/pr-manager.h"
 #include "scsi/constants.h"
diff --git a/block/file-win32.c b/block/file-win32.c
index 48b790d917..90309574d2 100644
--- a/block/file-win32.c
+++ b/block/file-win32.c
@@ -33,8 +33,8 @@
 #include "trace.h"
 #include "block/thread-pool.h"
 #include "qemu/iov.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include <windows.h>
 #include <winioctl.h>
 
diff --git a/block/gluster.c b/block/gluster.c
index cc74af06dc..e2a11baec9 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -15,8 +15,8 @@
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qemu/uri.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index 2ff14b7472..a3d52517d8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -44,8 +44,8 @@
 #include "sysemu/replay.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "crypto/secret.h"
 #include "scsi/utils.h"
 #include "trace.h"
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdbb5cb141..51eea4e7c9 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -41,9 +41,9 @@
 #include "sysemu/blockdev.h"
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-block-export.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/sockets.h"
diff --git a/block/nbd.c b/block/nbd.c
index b9d4f935e0..679988b351 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -37,7 +37,7 @@
 #include "qemu/main-loop.h"
 
 #include "qapi/qapi-visit-sockets.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qapi/clone-visitor.h"
 
 #include "block/qdict.h"
diff --git a/block/nfs.c b/block/nfs.c
index f737e19cd3..a96205841e 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -42,8 +42,8 @@
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include <nfsc/libnfs.h>
diff --git a/block/null.c b/block/null.c
index 4808704ffd..7313622275 100644
--- a/block/null.c
+++ b/block/null.c
@@ -12,8 +12,8 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "block/block-io.h"
diff --git a/block/nvme.c b/block/nvme.c
index 0a0a0a6b36..1c2e198238 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -14,8 +14,8 @@
 #include "qemu/osdep.h"
 #include <linux/vfio.h>
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/defer-call.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
diff --git a/block/parallels.c b/block/parallels.c
index 9205a0864f..402e8b58fd 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -36,7 +36,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qemu/bswap.h"
diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
index e4282631d2..8949f09488 100644
--- a/block/qapi-sysemu.c
+++ b/block/qapi-sysemu.c
@@ -35,7 +35,7 @@
 #include "block/block_int.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 
diff --git a/block/qapi.c b/block/qapi.c
index 9e806fa230..65eae459b2 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -33,11 +33,11 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qbool.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qbool.h"
+#include "qobject/qdict.h"
+#include "qobject/qlist.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qemu/qemu-print.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/qcow.c b/block/qcow.c
index c6d0e15f1e..6df5397707 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -34,8 +34,8 @@
 #include "qemu/cutils.h"
 #include "qemu/memalign.h"
 #include <zlib.h>
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "crypto/block.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 9bee66fff5..93b807efa9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -32,8 +32,8 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "trace.h"
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
diff --git a/block/qed.c b/block/qed.c
index bc2f0a61c0..adc34121c5 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -24,7 +24,7 @@
 #include "trace.h"
 #include "qed.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/quorum.c b/block/quorum.c
index db8fe891c4..02cf5e197c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -23,10 +23,10 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qlist.h"
+#include "qobject/qstring.h"
 #include "crypto/hash.h"
 
 #define HASH_LENGTH 32
diff --git a/block/rbd.c b/block/rbd.c
index 84bb2fa5d7..ae5918c0df 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -24,10 +24,10 @@
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/replication.c b/block/replication.c
index ca6bd0a720..d0af79207e 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -21,7 +21,7 @@
 #include "block/block_backup.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "block/replication.h"
 
 typedef enum {
diff --git a/block/snapshot.c b/block/snapshot.c
index 8694fc0a3e..a877305a0f 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -27,9 +27,9 @@
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
+#include "qobject/qstring.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
 
diff --git a/block/ssh.c b/block/ssh.c
index 2748253d4a..e6f31c17cf 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -40,8 +40,8 @@
 #include "qemu/uri.h"
 #include "qapi/qapi-visit-sockets.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 #include "trace.h"
diff --git a/block/stream.c b/block/stream.c
index 048c2d282f..4084a54bb7 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -16,7 +16,7 @@
 #include "block/block_int.h"
 #include "block/blockjob_int.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/ratelimit.h"
 #include "sysemu/block-backend.h"
 #include "block/copy-on-read.h"
diff --git a/block/vhdx.c b/block/vhdx.c
index 5aa1a13506..b76e14ece0 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -29,7 +29,7 @@
 #include "vhdx.h"
 #include "migration/blocker.h"
 #include "qemu/uuid.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/vmdk.c b/block/vmdk.c
index bf78e12383..6283f337d3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -27,8 +27,8 @@
 #include "qapi/error.h"
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qdict.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/vpc.c b/block/vpc.c
index d95a204612..e8e3d9f698 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -34,7 +34,7 @@
 #include "qemu/bswap.h"
 #include "qemu/uuid.h"
 #include "qemu/memalign.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-visit-block-core.h"
 
diff --git a/block/vvfat.c b/block/vvfat.c
index 9d050ba3ae..417585575b 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -34,8 +34,8 @@
 #include "qemu/option.h"
 #include "qemu/bswap.h"
 #include "migration/blocker.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
diff --git a/blockdev.c b/blockdev.c
index 3a5e7222ec..90dd8eced4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -46,12 +46,12 @@
 #include "qapi/qapi-commands-block.h"
 #include "qapi/qapi-commands-transaction.h"
 #include "qapi/qapi-visit-block-core.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
+#include "qobject/qstring.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qerror.h"
+#include "qobject/qlist.h"
 #include "qapi/qobject-output-visitor.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/iothread.h"
diff --git a/blockjob.c b/blockjob.c
index d5f29e14af..c4a7efa1db 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -32,7 +32,7 @@
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block-core.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/main-loop.h"
 #include "qemu/timer.h"
 
diff --git a/qemu-img.c b/qemu-img.c
index 7668f86769..3cee4e4d23 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -32,8 +32,8 @@
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-output-visitor.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/config-file.h"
 #include "qemu/option.h"
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index f5d7202a13..fa64cc1894 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -10,7 +10,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu-io.h"
 #include "sysemu/block-backend.h"
 #include "block/block.h"
diff --git a/qemu-io.c b/qemu-io.c
index 6cb1e00385..3e30da48cb 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -27,8 +27,8 @@
 #include "qemu/readline.h"
 #include "qemu/log.h"
 #include "qemu/sockets.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qdict.h"
 #include "qom/object_interfaces.h"
 #include "sysemu/block-backend.h"
 #include "block/block_int.h"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index bac0b5e3ec..25b7987e8c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -37,8 +37,8 @@
 #include "qemu/log.h"
 #include "qemu/systemd.h"
 #include "block/snapshot.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qom/object_interfaces.h"
 #include "io/channel-socket.h"
 #include "io/net-listener.h"
diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index 0e9354faa6..9d5e84674d 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -38,8 +38,8 @@
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qapi-visit-block-export.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 
 #include "qemu/help-texts.h"
-- 
2.43.0


