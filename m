Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D752B3CC24
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 17:43:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNN6-0008Lf-Px; Sat, 30 Aug 2025 11:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urzxt-0000Oj-EU
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urzxn-0001lQ-Sw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756477221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=j9IQAvW8opib1V9jETMDj/YCxXvGlH4G0ej7TZA/uQY=;
 b=Ye77LbQDO1k/Zi0GDvd+L2E+ykfqwBH+rbGs5cRopacATeQEYHYC/rrE6RGoRlXLWgfOOW
 rvEO2BzEZ0SaxEw0SVrfJ5bGnrTCtsQGYooKgqSxV1eSqseGx30WswN9HQXNJCDUe3IGUN
 ljcsLepd5bk+dQiLEk19XUlZPQcxdZ0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-ZDOOn-qwNcWbZbUR6YJMWQ-1; Fri,
 29 Aug 2025 10:20:19 -0400
X-MC-Unique: ZDOOn-qwNcWbZbUR6YJMWQ-1
X-Mimecast-MFC-AGG-ID: ZDOOn-qwNcWbZbUR6YJMWQ_1756477219
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB9C7195609D
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 14:20:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F1C919560BC; Fri, 29 Aug 2025 14:20:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional/m68k: Avoid ResourceWarning in the nextcube
 test
Date: Fri, 29 Aug 2025 16:20:00 +0200
Message-ID: <20250829142000.62320-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since commit c3fd296cf7b1 ("functional: always enable all python
warnings") we enabled more warnings for the functional tests. This
triggers now a warning in the nextcube test:

 tests/functional/m68k/test_nextcube.py:47: ResourceWarning:
  unclosed file <_io.BufferedReader name='tests/functional/m68k/test_nextcube.NextCubeMachine.test_bootrom_framebuffer_size/scratch/dump.ppm'>
   width, height = Image.open(screenshot_path).size

Use a proper "with" context to avoid it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/m68k/test_nextcube.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/functional/m68k/test_nextcube.py b/tests/functional/m68k/test_nextcube.py
index 13c72bd136a..c1610e58456 100755
--- a/tests/functional/m68k/test_nextcube.py
+++ b/tests/functional/m68k/test_nextcube.py
@@ -44,7 +44,8 @@ def test_bootrom_framebuffer_size(self):
         self.check_bootrom_framebuffer(screenshot_path)
 
         from PIL import Image
-        width, height = Image.open(screenshot_path).size
+        with Image.open(screenshot_path) as image:
+                width, height = image.size
         self.assertEqual(width, 1120)
         self.assertEqual(height, 832)
 
-- 
2.51.0


