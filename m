Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC79DEBAF
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Nov 2024 18:33:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qD-0003Vo-Ew; Fri, 29 Nov 2024 12:31:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q9-0003VI-Ut
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q7-0000nn-MV
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0Di8ZAFCBGObr+wNkVuD3jewkVg90AD2fktAHWIvcM=;
 b=aAUVWFCljWkB1Xd4Sv2yKgN+x9qV7dg7oLCIHjt+C2dyJ89/UI97aU+nvOByIVP0JkcTBj
 L6ObuGAxHsgqsGLiE33VERzAqjskqHucFHFy4sT+CmTzjVNFb0GPMA+VX4QrX9HCXMT2r1
 X47gD2aT4sDn+CxBut2eUZUAqKvyP5I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-JF0OAD7WNuGU764ibqKGag-1; Fri,
 29 Nov 2024 12:31:27 -0500
X-MC-Unique: JF0OAD7WNuGU764ibqKGag-1
X-Mimecast-MFC-AGG-ID: JF0OAD7WNuGU764ibqKGag
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 653631954197; Fri, 29 Nov 2024 17:31:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 79B251955F2D; Fri, 29 Nov 2024 17:31:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 01/22] tests/functional: increase timeouts for arm sx1 test
Date: Fri, 29 Nov 2024 17:30:59 +0000
Message-ID: <20241129173120.761728-2-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
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

When under high load the test VM does not complete running in the
default 30 second timeout. Double it to give more headroom.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_arm_sx1.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index 2d86405831..2292317946 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -44,7 +44,7 @@ def test_arm_sx1_initrd(self):
         self.vm.add_args('-no-reboot')
         self.launch_kernel(zimage_path,
                            initrd=initrd_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
     def test_arm_sx1_sd(self):
         self.set_machine('sx1')
@@ -55,7 +55,7 @@ def test_arm_sx1_sd(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
     def test_arm_sx1_flash(self):
         self.set_machine('sx1')
@@ -66,7 +66,7 @@ def test_arm_sx1_flash(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait()
+        self.vm.wait(timeout=60)
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.46.0


