Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE481DE3F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:31:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdXN-000579-B7; Mon, 25 Dec 2023 00:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXL-00056v-PS
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:59 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdXJ-0007L6-QP
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:59 -0500
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bb85a202c2so2365394b6e.2
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482076; x=1704086876;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=atVUFHIuvcwN+GlL1DnypsI1Up3UkYdIbJbv6i2R2a0=;
 b=EWwxI5iZjxNE6chep/cY5b8hl1xQbN3m1x7Ktw60COUxkJfTmCf4ZM+7xtORpDGH9c
 h88dmpCS9go0RwXiDKGKbCrpveU4xQzBFGY70AVbCvY8A3fEQ6eTYJkrLh7+ACFIdBuG
 lABCJQtC/znyO7mTjFxS31US74/RyZSbOPDooe2V3VMMIk0P9SjWkrlkoZtcQtrKbw4r
 13rzDwl4YWLZHcrH+EVZworR/7Yq6+pMLaFzMcndUMV5iugqQc9dxHMUsqw0AzCKjgNq
 sSfxLy5WDlubjz2SGqTai0N+8AX8nSemWslk0XjMPWZatoUWz4zqxljnvvKWj/9qZ6MK
 BP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482076; x=1704086876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=atVUFHIuvcwN+GlL1DnypsI1Up3UkYdIbJbv6i2R2a0=;
 b=khtAwjVA7e3rm2gv/RGSHEPC83X5wSck37D7qK4pWuDm1PqdOSgzckYq/94q/YGPcs
 u6UQ/60aztLLtEZU/p8P7tW9X2pGQgCXs5+1aNL1AST+RvRssOpRVN3XzKsMXV2q3nw/
 /xosWBpAKmmawzk9hNeUuIgxRDcsWCvhlfbHf9v8RaAb+YD9u2WPoDVTzA9GiCcm64PT
 WmY0dxT5LKOEfJ3xfYP3wHu4r7ulm5zWuy8nbASryRiBJZJRQUdQAumqqxkxzgJyownd
 6UvQE5pR55PDGQtL785/jH3H0PGRkbi8xgT7qAJThMdWpf0DrhWmc0rjTNkvayQVxpx/
 GFKA==
X-Gm-Message-State: AOJu0Yywstgps1JBygGcPdGZmiiNxfGTJlcFK2gZlH/Zf/q8zD4/Zde7
 Bf536ct9BbNeFUp9UgwcKg5k7GQuQV2JH3wY9R9/QOqxTb5kNQ==
X-Google-Smtp-Source: AGHT+IGhOIlc7NrZseOWuTTNmpCyFI3Lv5YDabZxV6h7inHycVHNLqC4wJN8KY8UgT70MogvDQtT1A==
X-Received: by 2002:a05:6808:124b:b0:3b8:b063:9b6d with SMTP id
 o11-20020a056808124b00b003b8b0639b6dmr6052761oiv.95.1703482076109; 
 Sun, 24 Dec 2023 21:27:56 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:55 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 09/10] tests: Add detached LUKS header case
Date: Mon, 25 Dec 2023 13:26:59 +0800
Message-Id: <1c201f745c591a163d45119bf25b077bd4898343.1703481380.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703481378.git.yong.huang@smartx.com>
References: <cover.1703481378.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::234;
 envelope-from=yong.huang@smartx.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 tests/qemu-iotests/tests/luks-detached-header | 214 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 2 files changed, 219 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

diff --git a/tests/qemu-iotests/tests/luks-detached-header b/tests/qemu-iotests/tests/luks-detached-header
new file mode 100755
index 0000000000..cf305bfa47
--- /dev/null
+++ b/tests/qemu-iotests/tests/luks-detached-header
@@ -0,0 +1,214 @@
+#!/usr/bin/env python3
+# group: rw auto
+#
+# Test detached LUKS header
+#
+# Copyright (C) 2024 SmartX Inc.
+#
+# Authors:
+#     Hyman Huang <yong.huang@smartx.com>
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
+
+import os
+import iotests
+from iotests import imgfmt, qemu_img_create, img_info_log, qemu_img_info, QMPTestCase
+
+
+image_size = 128 * 1024 * 1024
+
+luks_img = os.path.join(iotests.test_dir, 'luks.img')
+detached_header_img1 = os.path.join(iotests.test_dir, 'detached_header.img1')
+detached_header_img2 = os.path.join(iotests.test_dir, 'detached_header.img2')
+detached_payload_raw_img = os.path.join(iotests.test_dir, 'detached_payload_raw.img')
+detached_payload_qcow2_img = os.path.join(iotests.test_dir, 'detached_payload_qcow2.img')
+
+secret_obj = 'secret,id=sec0,data=foo'
+luks_opts = 'key-secret=sec0'
+
+
+class TestDetachedLUKSHeader(QMPTestCase):
+    def setUp(self) -> None:
+        self.vm = iotests.VM()
+        self.vm.add_object(secret_obj)
+        self.vm.launch()
+
+        # 1. Create the normal LUKS disk with 128M size
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': luks_img,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file', filename=luks_img,
+                         node_name='luks-1-storage')
+        result = self.vm.blockdev_create({ 'driver': imgfmt,
+                                           'file': 'luks-1-storage',
+                                           'key-secret': 'sec0',
+                                           'size': image_size,
+                                           'iter-time': 10 })
+        # None is expected
+        self.assertEqual(result, None)
+
+        # 2. Create the LUKS disk with detached header (raw)
+
+        # Create detached LUKS header
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': detached_header_img1,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img1,
+                         node_name='luks-2-header-storage')
+
+        # Create detached LUKS raw payload
+        self.vm.blockdev_create({ 'driver': 'file',
+                                  'filename': detached_payload_raw_img,
+                                  'size': 0 })
+        self.vm.qmp_log('blockdev-add', driver='file',
+                         filename=detached_payload_raw_img,
+                         node_name='luks-2-payload-storage')
+
+        # Format LUKS disk with detached header
+        result = self.vm.blockdev_create({ 'driver': imgfmt,
+                                           'header': 'luks-2-header-storage',
+                                           'file': 'luks-2-payload-storage',
+                                           'key-secret': 'sec0',
+                                           'preallocation': 'full',
+                                           'size': image_size,
+                                           'iter-time': 10 })
+        self.assertEqual(result, None)
+
+        self.vm.shutdown()
+
+        # 3. Create the LUKS disk with detached header (qcow2)
+
+        # Create detached LUKS header using qemu-img
+        res = qemu_img_create('-f', 'luks', '--object', secret_obj, '-o', luks_opts,
+                              '-o', "detached-mode=true", detached_header_img2)
+        assert res.returncode == 0
+
+        # Create detached LUKS qcow2 payload
+        res = qemu_img_create('-f', 'qcow2', detached_payload_qcow2_img, str(image_size))
+        assert res.returncode == 0
+
+    def tearDown(self) -> None:
+        os.remove(luks_img)
+        os.remove(detached_header_img1)
+        os.remove(detached_header_img2)
+        os.remove(detached_payload_raw_img)
+        os.remove(detached_payload_qcow2_img)
+
+        # Check if there was any qemu-io run that failed
+        if 'Pattern verification failed' in self.vm.get_log():
+            print('ERROR: Pattern verification failed:')
+            print(self.vm.get_log())
+            self.fail('qemu-io pattern verification failed')
+
+    def test_img_creation(self) -> None:
+        # Check if the images created above are expected
+
+        data = qemu_img_info(luks_img)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], False)
+
+        data = qemu_img_info(detached_header_img1)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], True)
+
+        data = qemu_img_info(detached_header_img2)['format-specific']
+        self.assertEqual(data['type'], imgfmt)
+        self.assertEqual(data['data']['detached-header'], True)
+
+        # Check if preallocation works
+        size = qemu_img_info(detached_payload_raw_img)['actual-size']
+        self.assertGreaterEqual(size, image_size)
+
+    def test_detached_luks_header(self) -> None:
+        self.vm.launch()
+
+        # 1. Add the disk created above
+
+        # Add normal LUKS disk
+        self.vm.qmp_log('blockdev-add', driver='file', filename=luks_img,
+                         node_name='luks-1-storage')
+        result = self.vm.qmp_log('blockdev-add', driver='luks', file='luks-1-storage',
+                                  key_secret='sec0', node_name='luks-1-format')
+
+        # Expected result{ "return": {} }
+        self.assert_qmp(result, 'return', {})
+
+        # Add detached LUKS header with raw payload
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img1,
+                         node_name='luks-header1-storage')
+
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_payload_raw_img,
+                         node_name='luks-2-payload-raw-storage')
+
+        result = self.vm.qmp_log('blockdev-add', driver=imgfmt,
+                                  header='luks-header1-storage',
+                                  file='luks-2-payload-raw-storage',
+                                  key_secret='sec0',
+                                  node_name='luks-2-payload-raw-format')
+        self.assert_qmp(result, 'return', {})
+
+        # Add detached LUKS header with qcow2 payload
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_header_img2,
+                         node_name='luks-header2-storage')
+
+        self.vm.qmp_log('blockdev-add', driver='file', filename=detached_payload_qcow2_img,
+                         node_name='luks-3-payload-qcow2-storage')
+
+        result = self.vm.qmp_log('blockdev-add', driver=imgfmt,
+                                  header='luks-header2-storage',
+                                  file='luks-3-payload-qcow2-storage',
+                                  key_secret='sec0',
+                                  node_name='luks-3-payload-qcow2-format')
+        self.assert_qmp(result, 'return', {})
+
+        # 2. Do I/O test
+
+        # Do some I/O to the image to see whether it still works
+        # (Pattern verification will be checked by tearDown())
+
+        # Normal LUKS disk
+        result = self.vm.qmp_log('human-monitor-command',
+                                  command_line='qemu-io luks-1-format "write -P 40 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp_log('human-monitor-command',
+                                 command_line='qemu-io luks-1-format "read -P 40 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        # Detached LUKS header with raw payload
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-2-payload-raw-format "write -P 41 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-2-payload-raw-format "read -P 41 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        # Detached LUKS header with qcow2 payload
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-3-payload-qcow2-format "write -P 42 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        result = self.vm.qmp('human-monitor-command',
+                             command_line='qemu-io luks-3-payload-qcow2-format "read -P 42 0 64k"')
+        self.assert_qmp(result, 'return', '')
+
+        self.vm.shutdown()
+
+
+if __name__ == '__main__':
+    # Test image creation and I/O
+    iotests.main(supported_fmts=['luks'],
+                 supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/luks-detached-header.out b/tests/qemu-iotests/tests/luks-detached-header.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/luks-detached-header.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
-- 
2.39.1


