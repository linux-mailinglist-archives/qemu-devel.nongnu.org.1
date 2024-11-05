Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA9B9BD1D2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 17:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8M7k-0003V6-Ny; Tue, 05 Nov 2024 11:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8M7i-0003U7-Ti
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:09:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8M7g-00005z-Fh
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 11:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730822978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uf1LcrljWrwIw9IYsfewYJKOT2mceLI7KFnpYjy8N8g=;
 b=dETZ4bmbgODrSz/U3mOGdQ/dUgdMc0H2qZYWpHEMkeFZYBW/5jDby2Zknnn7COqmV8zYk9
 iWqr6VIz2OpEqtoowqtV8MsdGvDKGKbr8Cb9yysM1hR5RuBHAII/IRCZjLqa8EBvH/Yziz
 r/E7j90xOSnZgYDYxHpJK6mdx6hQBr8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-7xbfcubSNWuBquRr0HeSWA-1; Tue,
 05 Nov 2024 11:09:35 -0500
X-MC-Unique: 7xbfcubSNWuBquRr0HeSWA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C495195608A; Tue,  5 Nov 2024 16:09:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3E9F19560A2; Tue,  5 Nov 2024 16:09:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional: Fix the ppc64_hv and the ppc_40p test for
 read-only assets
Date: Tue,  5 Nov 2024 17:09:26 +0100
Message-ID: <20241105160926.393852-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Since commit 786bc2255256, cached asset files are read-only, so now we've
got to use "read-only=true" in tests that try to use these files directly.

Fixes: 786bc22552 ("tests/functional: make cached asset files read-only")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_ppc64_hv.py | 3 ++-
 tests/functional/test_ppc_40p.py  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 1a6e4b6d07..312248bbfe 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -99,7 +99,8 @@ def do_start_alpine(self):
         self.vm.add_args("-kernel", self.vmlinuz)
         self.vm.add_args("-initrd", self.initramfs)
         self.vm.add_args("-smp", "4", "-m", "2g")
-        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,id=drive0")
+        self.vm.add_args("-drive", f"file={self.iso_path},format=raw,if=none,"
+                                    "id=drive0,read-only=true")
 
         self.vm.launch()
         wait_for_console_pattern(self, 'Welcome to Alpine Linux 3.18')
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/test_ppc_40p.py
index c64e876c1f..67bcdae53a 100755
--- a/tests/functional/test_ppc_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -46,7 +46,8 @@ def test_factory_firmware_and_netbsd(self):
 
         self.vm.set_console()
         self.vm.add_args('-bios', bios_path,
-                         '-fda', drive_path)
+                         '-drive',
+                         f"file={drive_path},format=raw,if=floppy,read-only=true")
         self.vm.launch()
         os_banner = 'NetBSD 4.0 (GENERIC) #0: Sun Dec 16 00:49:40 PST 2007'
         wait_for_console_pattern(self, os_banner)
-- 
2.47.0


