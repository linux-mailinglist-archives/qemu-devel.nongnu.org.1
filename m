Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45FAC83DF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 00:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKlKv-0005b5-NL; Thu, 29 May 2025 18:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKt-0005aF-6T
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uKlKr-0002aj-DZ
 for qemu-devel@nongnu.org; Thu, 29 May 2025 18:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748556168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=trLlnZ7xN6wN3xsvXNehE4gJcK9/Aq7r+pfz0MLrc2g=;
 b=NnlLouhr8k8hrDnBu/CHfQAxVGhz2uXP1pMLSLRIFrNpVjTYQQWV3FL/Owudszn9LQoc64
 MYcoWvRo+crzbX1px7oqS/lHqHMybNchytE1BXNGZKsU26eAhiTc/h6UOCMsUYcsWeOrV7
 2WYZp0eAAPDtiuVd2soQpoVq8MCkJ7w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-29m3TvenMRCflAEIbsfPVw-1; Thu,
 29 May 2025 18:02:46 -0400
X-MC-Unique: 29m3TvenMRCflAEIbsfPVw-1
X-Mimecast-MFC-AGG-ID: 29m3TvenMRCflAEIbsfPVw_1748556165
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B88E1800447; Thu, 29 May 2025 22:02:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.48])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E0BD619560A7; Thu, 29 May 2025 22:02:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 6/6] iotests: Filter out ZFS in several tests
Date: Thu, 29 May 2025 17:02:13 -0500
Message-ID: <20250529220228.1187563-14-eblake@redhat.com>
In-Reply-To: <20250529220228.1187563-8-eblake@redhat.com>
References: <20250529220228.1187563-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fiona reported that ZFS makes sparse file testing awkward, since:
- it has asynchronous allocation (not even 'fsync $file' makes du see
  the desired size; it takes the slower 'fsync -f $file' which is not
  appropriate for the tests)
- for tests of fully allocated files, ZFS with compression enabled
  still reports smaller disk usage

Add a new _require_disk_usage that quickly probes whether an attempt
to create a sparse 5M file shows as less than 1M usage, while the same
file with -o preallocation=full shows as more than 4M usage without
sync, which should filter out ZFS behavior.  Then use it in various
affected tests.

This does not add the new filter on all tests that Fiona is seeing ZFS
failures on, but only those where I could quickly spot that there is
at least one place where the test depends on the output of 'du -b' or
'stat -c %b'.

Reported-by: Fiona Ebner <f.ebner@proxmox.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250523163041.2548675-8-eblake@redhat.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/common.rc                | 30 +++++++++++++++++++++
 tests/qemu-iotests/106                      |  1 +
 tests/qemu-iotests/175                      |  1 +
 tests/qemu-iotests/221                      |  1 +
 tests/qemu-iotests/253                      |  1 +
 tests/qemu-iotests/308                      |  1 +
 tests/qemu-iotests/tests/mirror-sparse      |  1 +
 tests/qemu-iotests/tests/write-zeroes-unmap |  1 +
 8 files changed, 37 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 237f746af88..e977cb4eb61 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -996,6 +996,36 @@ _require_large_file()
     rm "$FILENAME"
 }

+# Check whether disk_usage can be reliably used.
+_require_disk_usage()
+{
+    local unusable=false
+    # ZFS triggers known failures on this front; it does not immediately
+    # allocate files, and then aggressively compresses writes even when full
+    # allocation was requested.
+    if [ -z "$TEST_IMG_FILE" ]; then
+        FILENAME="$TEST_IMG"
+    else
+        FILENAME="$TEST_IMG_FILE"
+    fi
+    if [ -e "FILENAME" ]; then
+        echo "unwilling to overwrite existing file"
+        exit 1
+    fi
+    $QEMU_IMG create -f raw "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -gt $((1024*1024)) ]; then
+        unusable=true
+    fi
+    $QEMU_IMG create -f raw -o preallocation=full "$FILENAME" 5M > /dev/null
+    if [ $(disk_usage "$FILENAME") -lt $((4*1024*1024)) ]; then
+        unusable=true
+    fi
+    rm -f "$FILENAME"
+    if $unusable; then
+        _notrun "file system on $TEST_DIR does not handle sparse files nicely"
+    fi
+}
+
 # Check that a set of devices is available in the QEMU binary
 #
 _require_devices()
diff --git a/tests/qemu-iotests/106 b/tests/qemu-iotests/106
index ae0fc466910..55548439aad 100755
--- a/tests/qemu-iotests/106
+++ b/tests/qemu-iotests/106
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt raw
 _supported_proto file fuse
 _supported_os Linux
+_require_disk_usage

 # in kB
 CREATION_SIZE=128
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
index f74f053b719..bbbf550a5af 100755
--- a/tests/qemu-iotests/175
+++ b/tests/qemu-iotests/175
@@ -77,6 +77,7 @@ _supported_os Linux

 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage

 size=$((1 * 1024 * 1024))

diff --git a/tests/qemu-iotests/221 b/tests/qemu-iotests/221
index c463fd4b113..eba00b80adb 100755
--- a/tests/qemu-iotests/221
+++ b/tests/qemu-iotests/221
@@ -41,6 +41,7 @@ _supported_os Linux

 _default_cache_mode writeback
 _supported_cache_modes writeback writethrough unsafe
+_require_disk_usage

 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/253 b/tests/qemu-iotests/253
index 35039d20a89..6da85e6a113 100755
--- a/tests/qemu-iotests/253
+++ b/tests/qemu-iotests/253
@@ -41,6 +41,7 @@ _supported_os Linux

 _default_cache_mode none
 _supported_cache_modes none directsync
+_require_disk_usage

 echo
 echo "=== Check mapping of unaligned raw image ==="
diff --git a/tests/qemu-iotests/308 b/tests/qemu-iotests/308
index 437a9014da5..6eced3aefb9 100755
--- a/tests/qemu-iotests/308
+++ b/tests/qemu-iotests/308
@@ -51,6 +51,7 @@ _unsupported_fmt vpc

 _supported_proto file # We create the FUSE export manually
 _supported_os Linux # We need /dev/urandom
+_require_disk_usage

 # $1: Export ID
 # $2: Options (beyond the node-name and ID)
diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
index 11418c08713..cfcaa600ab4 100755
--- a/tests/qemu-iotests/tests/mirror-sparse
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -40,6 +40,7 @@ cd ..
 _supported_fmt qcow2 raw  # Format of the source. dst is always raw file
 _supported_proto file
 _supported_os Linux
+_require_disk_usage

 echo
 echo "=== Initial image setup ==="
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
index 7cfeeaf8391..f90fb8e8d27 100755
--- a/tests/qemu-iotests/tests/write-zeroes-unmap
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -32,6 +32,7 @@ cd ..
 _supported_fmt raw
 _supported_proto file
 _supported_os Linux
+_require_disk_usage

 create_test_image() {
     _make_test_img -f $IMGFMT 1m
-- 
2.49.0


