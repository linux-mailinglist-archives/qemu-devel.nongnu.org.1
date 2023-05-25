Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75013710C54
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:49:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AOF-0000mL-G5; Thu, 25 May 2023 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANu-0008Df-VH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANl-00023l-C3
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l+5eTEddy5m/B3qiIVSnDCZHfxa2jnmIFFql7WKp7Qk=;
 b=FSf2C9z+stiUMcesJ1Q6h9ucqkvRi5mfQ7zm8mM/g3gXq4uody642z74w41Hsqj6GHSVuX
 yl+s8+zm40eoW9J5fHCyzLR1l3zhNf9UAzgWv2/9iSL6fLYCt0am1eNprN90UEMQkFLhIy
 aJ6OIrmxAyV9TXmGBR3CfsV9txd7na8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-Bqf8-gHuN0-6KytvLm87kQ-1; Thu, 25 May 2023 08:47:38 -0400
X-MC-Unique: Bqf8-gHuN0-6KytvLm87kQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19BB4101AA6D;
 Thu, 25 May 2023 12:47:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3BD8162;
 Thu, 25 May 2023 12:47:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 12/12] iotests: Test blockdev-create in iothread
Date: Thu, 25 May 2023 14:47:13 +0200
Message-Id: <20230525124713.401149-13-kwolf@redhat.com>
In-Reply-To: <20230525124713.401149-1-kwolf@redhat.com>
References: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If blockdev-create references an existing node in an iothread (e.g. as
it's 'file' child), then suddenly all of the image creation code must
run in that AioContext, too. Test that this actually works.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-create     | 67 +++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-create.out |  4 ++
 2 files changed, 71 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/iothreads-create
 create mode 100644 tests/qemu-iotests/tests/iothreads-create.out

diff --git a/tests/qemu-iotests/tests/iothreads-create b/tests/qemu-iotests/tests/iothreads-create
new file mode 100755
index 0000000000..0c862d73f2
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-create
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Copyright (C) 2023 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+
+import asyncio
+import iotests
+
+iotests.script_initialize(supported_fmts=['qcow2', 'qcow', 'qed', 'vdi',
+                                          'vmdk', 'parallels'])
+iotests.verify_virtio_scsi_pci_or_ccw()
+
+with iotests.FilePath('disk.img') as img_path, \
+     iotests.VM() as vm:
+
+    iotests.qemu_img_create('-f', 'raw', img_path, '0')
+
+    vm.add_object('iothread,id=iothread0')
+    vm.add_blockdev(f'file,node-name=img-file,read-only=on,'
+                    f'filename={img_path}')
+    vm.add_device('virtio-scsi,iothread=iothread0')
+    vm.add_device('scsi-hd,drive=img-file,share-rw=on')
+
+    vm.launch()
+
+    iotests.log(vm.qmp(
+        'blockdev-reopen',
+        options=[{
+            'driver': 'file',
+            'filename': img_path,
+            'node-name': 'img-file',
+            'read-only': False,
+        }],
+    ))
+    iotests.log(vm.qmp(
+        'blockdev-create',
+        job_id='job0',
+        options={
+            'driver': iotests.imgfmt,
+            'file': 'img-file',
+            'size': 1024 * 1024,
+        },
+    ))
+
+    # Should succeed and not time out
+    try:
+        vm.run_job('job0', wait=5.0)
+        vm.shutdown()
+    except asyncio.TimeoutError:
+        # VM may be stuck, kill it
+        vm.kill()
+        raise
diff --git a/tests/qemu-iotests/tests/iothreads-create.out b/tests/qemu-iotests/tests/iothreads-create.out
new file mode 100644
index 0000000000..5c974ff77e
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-create.out
@@ -0,0 +1,4 @@
+{"return": {}}
+{"return": {}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
-- 
2.40.1


