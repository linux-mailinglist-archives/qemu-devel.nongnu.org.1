Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4CB4142A
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 07:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfnE-0006MJ-7r; Wed, 03 Sep 2025 01:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmr-0006H0-Rv
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmq-0006Za-33
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKbaHAEvTwJqmExIXUlbRePoGgZFad/G/AMh5OouNuw=;
 b=fdR1UXXrPRmvodTUoLAqOFJTR1BmXXlfv4tofi1LXE6m4BEcsuZAnGt6UbfpRo3A3FUkxv
 H/gCBfFtihQEzY3WMZpzvMw6dU0tRTpxQ8zrJVxow1qrl0lMZ0MPZ03om+U1DFXA/ae7gG
 vwabL8exzdEGTnY1OLxLT+Hq/uiVR9E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-VzUXuVKpPcCIWbvZCsmxyg-1; Wed,
 03 Sep 2025 01:11:56 -0400
X-MC-Unique: VzUXuVKpPcCIWbvZCsmxyg-1
X-Mimecast-MFC-AGG-ID: VzUXuVKpPcCIWbvZCsmxyg_1756876316
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F07131800581; Wed,  3 Sep 2025 05:11:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44B8F19560A2; Wed,  3 Sep 2025 05:11:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 11/18] python: backport 'Remove deprecated get_event_loop
 calls'
Date: Wed,  3 Sep 2025 01:11:17 -0400
Message-ID: <20250903051125.3020805-12-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This method was deprecated in 3.12 because it ordinarily should not be
used from coroutines; if there is not a currently running event loop,
this automatically creates a new event loop - which is usually not what
you want from code that would ever run in the bottom half.

In our case, we do want this behavior in two places:

(1) The synchronous shim, for convenience: this allows fully sync
programs to use QEMUMonitorProtocol() without needing to set up an event
loop beforehand. This is intentional to fully box in the async
complexities into the legacy sync shim.

(2) The qmp_tui shell; instead of relying on asyncio.run to create and
run an asyncio program, we need to be able to pass the current asyncio
loop to urwid setup functions. For convenience, again, we create one if
one is not present to simplify the creation of the TUI appliance.

The remaining user of get_event_loop() was in fact one of the erroneous
users that should not have been using this function: if there's no
running event loop inside of a coroutine, you're in big trouble :)

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit aa1ff9907603a3033296027e1bd021133df86ef1
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/legacy.py  | 9 ++++++++-
 python/qemu/qmp/qmp_tui.py | 7 ++++++-
 python/tests/protocol.py   | 2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index c8d0a29b56f..735d42971e9 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -86,7 +86,14 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-        self._aloop = asyncio.get_event_loop()
+
+        try:
+            self._aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running loop; since this is a sync shim likely to be
+            # used in fully sync programs, create one if neccessary.
+            self._aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self._address = address
         self._timeout: Optional[float] = None
 
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 53ea6c59a71..12bdc17c99e 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -388,7 +388,12 @@ def run(self, debug: bool = False) -> None:
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
 
-        self.aloop = asyncio.get_event_loop()
+        try:
+            self.aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running asyncio event loop. Create one if necessary.
+            self.aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index c254c77b176..e565802516d 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -227,7 +227,7 @@ def async_test(async_test_method):
         Decorator; adds SetUp and TearDown to async tests.
         """
         async def _wrapper(self, *args, **kwargs):
-            loop = asyncio.get_event_loop()
+            loop = asyncio.get_running_loop()
             loop.set_debug(True)
 
             await self._asyncSetUp()
-- 
2.50.1


