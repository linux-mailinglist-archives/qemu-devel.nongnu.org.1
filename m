Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2817EE664
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:07:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gkS-0002Qt-B7; Thu, 16 Nov 2023 13:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkL-0002N7-VO
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gkJ-00041p-TD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ra4XEUokCcONqX8wh+QJ8w5EDL5357lCKuH5c1e79Mw=;
 b=PGUcVUll8Lfddu4XFcnaqI2qyc3PTm4o6xheT6zM8HhZlZyQl2Uecqp9sFg847OpZc8JUq
 Y4XGSsvmOF7AEgpcTkpzHQ83FVUmf2Jdbtid8RyYbFLh3F2xbZzkuviirFhdgBI6pfqMqM
 tkGWtYpxKequyM1h/0JIjLSQhvvmR3Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-kXddjnycMOCAiL5UdEHRxA-1; Thu, 16 Nov 2023 13:05:39 -0500
X-MC-Unique: kXddjnycMOCAiL5UdEHRxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A6CE101A529;
 Thu, 16 Nov 2023 18:05:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 478171121306;
 Thu, 16 Nov 2023 18:05:38 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/10] tests/avocado: Replace assertRegexpMatches() for Python
 3.12 compatibility
Date: Thu, 16 Nov 2023 19:05:26 +0100
Message-ID: <20231116180534.566469-3-thuth@redhat.com>
In-Reply-To: <20231116180534.566469-1-thuth@redhat.com>
References: <20231116180534.566469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

assertRegexpMatches() has been removed in Python 3.12 and should be replaced by
assertRegex(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231114144832.71612-1-philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing.rst   | 2 +-
 tests/avocado/version.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 87ed30af22..22218dbedb 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1016,7 +1016,7 @@ class.  Here's a simple usage example:
           self.vm.launch()
           res = self.vm.cmd('human-monitor-command',
                             command_line='info version')
-          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
 
 To execute your test, run:
 
diff --git a/tests/avocado/version.py b/tests/avocado/version.py
index 93ffdf3d97..c6139568a1 100644
--- a/tests/avocado/version.py
+++ b/tests/avocado/version.py
@@ -22,4 +22,4 @@ def test_qmp_human_info_version(self):
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
                           command_line='info version')
-        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+        self.assertRegex(res, r'^(\d+\.\d+\.\d)')
-- 
2.41.0


