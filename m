Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B0AACC469
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 12:35:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMOz2-0000K7-0v; Tue, 03 Jun 2025 06:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMOyw-0000JO-5G
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uMOyu-0007eE-JB
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 06:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748946895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=azgxffxH7xJdl7XjjxoiW1McKovwQ+m6DVsyRFqkx/w=;
 b=LAGbty7RI21bd+Uf7Ny743mnKOuY2ZduqMXVOlbEuKTtfebW7FlGnUVOTll59duk6Fw7cN
 w+0706px42VhrjS6TAAz6ADUm79SN571U9LTTe6dH2rB3Kzpq5cfI3GLoZYk8skjUdRUXs
 J+S05gLTq4WctyZUbpFqmi+2EiNlLrw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-tK6cv_6_OdStN2erWM_afA-1; Tue,
 03 Jun 2025 06:34:53 -0400
X-MC-Unique: tK6cv_6_OdStN2erWM_afA-1
X-Mimecast-MFC-AGG-ID: tK6cv_6_OdStN2erWM_afA_1748946893
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2295C1956046
 for <qemu-devel@nongnu.org>; Tue,  3 Jun 2025 10:34:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.8])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56BA61955EAD; Tue,  3 Jun 2025 10:34:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/functional: Use the 'none' machine for the VNC test
Date: Tue,  3 Jun 2025 12:34:49 +0200
Message-ID: <20250603103449.32499-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

From: Thomas Huth <thuth@redhat.com>

The VNC test currently fails if the default machine ("pc" for x86)
has not been compiled into the binary. Since we also can test VNC
when QEMU just shows the default monitor, let's avoid this problem
by simply using the "none" machine (which is always available)
here instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_vnc.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/functional/test_vnc.py b/tests/functional/test_vnc.py
index 5c0ee5f9272..f1dd1597cf1 100755
--- a/tests/functional/test_vnc.py
+++ b/tests/functional/test_vnc.py
@@ -31,6 +31,7 @@ def check_connect(port: int) -> bool:
 class Vnc(QemuSystemTest):
 
     def test_no_vnc_change_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S')
         self.vm.launch()
 
@@ -62,6 +63,7 @@ def launch_guarded(self):
                 raise excp
 
     def test_change_password_requires_a_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -74,6 +76,7 @@ def test_change_password_requires_a_password(self):
                          'Could not set password')
 
     def test_change_password(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':1,to=999,password=on')
         self.launch_guarded()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
@@ -103,6 +106,7 @@ def do_test_change_listen(self, a, b, c):
         self.assertTrue(check_connect(c))
 
     def test_change_listen(self):
+        self.set_machine('none')
         with Ports() as ports:
             a, b, c = ports.find_free_ports(3)
             self.do_test_change_listen(a, b, c)
-- 
2.49.0


