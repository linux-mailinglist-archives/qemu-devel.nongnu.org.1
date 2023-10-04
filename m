Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A17B8D9B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 21:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo7pF-0004iz-IJ; Wed, 04 Oct 2023 15:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pE-0004ht-3I
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qo7pA-00058v-JU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 15:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696448784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTZZv+B4GQU8V204gzdoSm/m/cM8SbdIuVk0hYYZBR8=;
 b=Qc7sd/R5vBTVr+gTNkJ4SdHZEQazR8TW//8WHET8kWfx+jnWmO6dIjXAmocxQTe4A/GEtP
 x51zKTsPTlQES+p70yY6zZNKf805E4UlxuFPM/9vskAjBS+biXVniC4VxpPlauonGuImyS
 d/tkN8rFVVJw0Qe6HLBiyHkw8HRqLSQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-r49WVZUMPKebRhYbeWxxqA-1; Wed, 04 Oct 2023 15:46:21 -0400
X-MC-Unique: r49WVZUMPKebRhYbeWxxqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A20F881D786;
 Wed,  4 Oct 2023 19:46:19 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C152F1054FC1;
 Wed,  4 Oct 2023 19:46:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 4/9] python/console_socket: accept existing FD in initializer
Date: Wed,  4 Oct 2023 15:46:08 -0400
Message-ID: <20231004194613.2900323-5-jsnow@redhat.com>
In-Reply-To: <20231004194613.2900323-1-jsnow@redhat.com>
References: <20231004194613.2900323-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230928044943.849073-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/console_socket.py | 29 +++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/python/qemu/machine/console_socket.py b/python/qemu/machine/console_socket.py
index 4e28ba9bb23..0a4e09ffc73 100644
--- a/python/qemu/machine/console_socket.py
+++ b/python/qemu/machine/console_socket.py
@@ -24,19 +24,32 @@ class ConsoleSocket(socket.socket):
     """
     ConsoleSocket represents a socket attached to a char device.
 
-    Optionally (if drain==True), drains the socket and places the bytes
-    into an in memory buffer for later processing.
-
-    Optionally a file path can be passed in and we will also
-    dump the characters to this file for debugging purposes.
+    :param address: An AF_UNIX path or address.
+    :param sock_fd: Optionally, an existing socket file descriptor.
+                    One of address or sock_fd must be specified.
+    :param file: Optionally, a filename to log to.
+    :param drain: Optionally, drains the socket and places the bytes
+                  into an in memory buffer for later processing.
     """
-    def __init__(self, address: str, file: Optional[str] = None,
+    def __init__(self,
+                 address: Optional[str] = None,
+                 sock_fd: Optional[int] = None,
+                 file: Optional[str] = None,
                  drain: bool = False):
+        if address is None and sock_fd is None:
+            raise ValueError("one of 'address' or 'sock_fd' must be specified")
+        if address is not None and sock_fd is not None:
+            raise ValueError("can't specify both 'address' and 'sock_fd'")
+
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
         self._buffer: Deque[int] = deque()
-        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
-        self.connect(address)
+        if address is not None:
+            socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
+            self.connect(address)
+        else:
+            assert sock_fd is not None
+            socket.socket.__init__(self, fileno=sock_fd)
         self._logfile = None
         if file:
             # pylint: disable=consider-using-with
-- 
2.41.0


