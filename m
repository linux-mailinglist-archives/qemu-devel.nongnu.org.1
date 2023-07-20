Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C575AF27
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTL6-0005mb-Sd; Thu, 20 Jul 2023 09:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTKz-0005l8-IH
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qMTKw-00064A-Hz
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689858293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qazoxsrJ4HHHfE3vWiM+JSDOo35GlxAWRvEti0riv3w=;
 b=Ouww1Qk+4wPPEC3NG7VOZz1Q4+4RWi14/SeG78aVwGhJEQ6AfTRl2cLH3Np/aRTfQ8lptw
 UgesCXqzwgSxPrK4k191DKYLUVZnoEiGfBa0fHQtP/7hm8md+eJ1gZFe7TqCtqeIqNMOC0
 /ubfLRw4u63gO7g1VylP4icpy4vnSb0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-sZpHHWxGM3-2WjRCSwtJwg-1; Thu, 20 Jul 2023 09:04:50 -0400
X-MC-Unique: sZpHHWxGM3-2WjRCSwtJwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31BC29A9D47;
 Thu, 20 Jul 2023 13:04:49 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.126])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A60E1121315;
 Thu, 20 Jul 2023 13:04:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Berrange <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 2/4] python/console_socket: accept existing FD in initializer
Date: Thu, 20 Jul 2023 09:04:46 -0400
Message-ID: <20230720130448.921356-3-jsnow@redhat.com>
In-Reply-To: <20230720130448.921356-1-jsnow@redhat.com>
References: <20230720130448.921356-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Useful if we want to use ConsoleSocket() for a socket created by
socketpair().

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/console_socket.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machine/console_socket.py
index 4e28ba9bb2..42bfa12411 100644
--- a/python/qemu/machine/console_socket.py
+++ b/python/qemu/machine/console_socket.py
@@ -17,7 +17,7 @@
 import socket
 import threading
 import time
-from typing import Deque, Optional
+from typing import Deque, Optional, Union
 
 
 class ConsoleSocket(socket.socket):
@@ -30,13 +30,16 @@ class ConsoleSocket(socket.socket):
     Optionally a file path can be passed in and we will also
     dump the characters to this file for debugging purposes.
     """
-    def __init__(self, address: str, file: Optional[str] = None,
+    def __init__(self, address: Union[str, int], file: Optional[str] = None,
                  drain: bool = False):
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
         self._buffer: Deque[int] = deque()
-        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
-        self.connect(address)
+        if isinstance(address, str):
+            socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
+            self.connect(address)
+        else:
+            socket.socket.__init__(self, fileno=address)
         self._logfile = None
         if file:
             # pylint: disable=consider-using-with
-- 
2.41.0


