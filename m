Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207C57EE662
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkT-0002RK-4H; Thu, 16 Nov 2023 13:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkN-0002On-SL
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkL-00042N-AY
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkLOx5YuLoi1SO1djyzQQvQR+C5F8GgJGgGKA1Lui/0=;
 b=ZVAhbOrhOiaW7T6zWt1d0fZnbNZIdh8JWc6bcG50LSCU7dFB5d1/kJpUE0Xtn25q2HLtS/
 9ZhtssH3W7awBVUGIfrlwXhow+nLLI/yDdL6RDD22rFNfkI4yo5vqSS59DFON2j/rcXoKR
 dLYOLUVTaQbVUnSbpx4Yjomuvys2FDY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-e7t5s_XoOR6JHPIEJx-DbQ-1; Thu, 16 Nov 2023 13:05:43 -0500
X-MC-Unique: e7t5s_XoOR6JHPIEJx-DbQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CFF67101A54C
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 18:05:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8BCD1121306;
 Thu, 16 Nov 2023 18:05:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 05/10] tests/avocado/multiprocess: Add asset hashes to silence
 warnings
Date: Thu, 16 Nov 2023 19:05:29 +0100
Message-ID: <20231116180534.566469-6-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The multiprocess test is currently succeeding with an annoying warning:

 (1/2) tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64:
       WARN: Test passed but there were warnings during execution. Check
       the log for details

In the log, you can find an entry like:

 WARNI| No hash provided. Cannot check the asset file integrity.

Add the proper asset hashes to avoid those warnings.

Message-ID: <20231115145852.494052-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/multiprocess.py | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/avocado/multiprocess.py b/tests/avocado/multiprocess.py
index 9112a4cacc..ee7490ae08 100644
--- a/tests/avocado/multiprocess.py
+++ b/tests/avocado/multiprocess.py
@@ -18,8 +18,8 @@ class Multiprocess(QemuSystemTest):
     """
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
-    def do_test(self, kernel_url, initrd_url, kernel_command_line,
-                machine_type):
+    def do_test(self, kernel_url, kernel_hash, initrd_url, initrd_hash,
+                kernel_command_line, machine_type):
         """Main test method"""
         self.require_accelerator('kvm')
         self.require_multiprocess()
@@ -30,8 +30,8 @@ def do_test(self, kernel_url, initrd_url, kernel_command_line,
         os.set_inheritable(proxy_sock.fileno(), True)
         os.set_inheritable(remote_sock.fileno(), True)
 
-        kernel_path = self.fetch_asset(kernel_url)
-        initrd_path = self.fetch_asset(initrd_url)
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
 
         # Create remote process
         remote_vm = self.get_vm()
@@ -72,13 +72,16 @@ def test_multiprocess_x86_64(self):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/31/Everything/x86_64/os/images'
                       '/pxeboot/vmlinuz')
+        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
         initrd_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/31/Everything/x86_64/os/images'
                       '/pxeboot/initrd.img')
+        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyS0 rdinit=/bin/bash')
         machine_type = 'pc'
-        self.do_test(kernel_url, initrd_url, kernel_command_line, machine_type)
+        self.do_test(kernel_url, kernel_hash, initrd_url, initrd_hash,
+                     kernel_command_line, machine_type)
 
     def test_multiprocess_aarch64(self):
         """
@@ -87,10 +90,13 @@ def test_multiprocess_aarch64(self):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/31/Everything/aarch64/os/images'
                       '/pxeboot/vmlinuz')
+        kernel_hash = '3505f2751e2833c681de78cee8dda1e49cabd2e8'
         initrd_url = ('https://archives.fedoraproject.org/pub/archive/fedora'
                       '/linux/releases/31/Everything/aarch64/os/images'
                       '/pxeboot/initrd.img')
+        initrd_hash = '519a1962daf17d67fc3a9c89d45affcb399607db'
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'rdinit=/bin/bash console=ttyAMA0')
         machine_type = 'virt,gic-version=3'
-        self.do_test(kernel_url, initrd_url, kernel_command_line, machine_type)
+        self.do_test(kernel_url, kernel_hash, initrd_url, initrd_hash,
+                     kernel_command_line, machine_type)
-- 
2.41.0


