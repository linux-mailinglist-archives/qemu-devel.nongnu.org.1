Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C87F679D1E2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3EE-0006yX-GR; Tue, 12 Sep 2023 09:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qg3E9-0006yB-3b; Tue, 12 Sep 2023 09:14:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qg3E5-0006ik-2p; Tue, 12 Sep 2023 09:14:48 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c34c9cc9b9so39573475ad.3; 
 Tue, 12 Sep 2023 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694524482; x=1695129282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=G6yuAJS5GmI5vQpHQarybv4/5z8/23z/YR3kujX2t/o=;
 b=l9QrLJlVLhiHyz5gZctsaDjRxJt47fW8lyxrgEUTdbESVtXH7gu6gwRjPKPnl50cTL
 srkXpH8cqRQl9a0o8pee7z7DcEbktP5YR/B9ZRRa0br7hQLZTF6vuGE43jkMHBg+BEj9
 bDPbnntnW3Sc3M3VRJGBdDimStFdjexxkF7oQnPqyuBjHUPUQWW6AvyEvUt8F/0Fj8XE
 pgcFr9S8SDH3FolrIlRWAB1VOYLYvFkixEoDCqw5Dt0UcszJF8VZqFoE7+FTzMS0ud2c
 n21H06NkbUcE/h5e2QBeNdMGErZAhoOHw2qIdypKuhVKd/ulwSjpzub6J67tDG6gM3dh
 iq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694524482; x=1695129282;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6yuAJS5GmI5vQpHQarybv4/5z8/23z/YR3kujX2t/o=;
 b=CuU49y89PH9Q2xBSN5LVYa+aGHTp1CXOpEgBKQ5sRv9t1sKPlJfLEW4xb7VVnMXPjn
 O6rEKMj5d5icoSnxGPhDYY6wiGCcnR5pvmM9gUeKCM6nON+0zXXbgFW2AQoRRehJYr4t
 jThN9VS1LKwM35/SkIr4QQgSvjVraIvDh8LIio/nHZPtzAHmwWJ/eMY36Vbtb1ztNsHI
 /fZHKaaapS8BRpRy9JNWJFscijiRTxuxz5qHK8pjWGj+wLqj6pLQsxzXvcuiPRsq1x9B
 TABLWnXORiJR3/3gGVhm8PA+V17PnfCRSt+l7EBFUotDV9UNZDYlOgM8hqS8j0Fhr5lq
 DLNA==
X-Gm-Message-State: AOJu0YwVufRTEK7hckbkXW6wmUu+8KuR0+o1ehX4frB/R4wtIXQYrdL0
 T6Fly4sxJTC51e+lUFDAcsU=
X-Google-Smtp-Source: AGHT+IHbJNyAyTwQeHUq357UlepdYN6eTh88paaEPbEm+gUO3JeHNvIDdvxwlZ1fXxO2Rp7ENovs6g==
X-Received: by 2002:a17:902:c947:b0:1c3:52ed:18f9 with SMTP id
 i7-20020a170902c94700b001c352ed18f9mr13037706pla.62.1694524482313; 
 Tue, 12 Sep 2023 06:14:42 -0700 (PDT)
Received: from wheely.local0.net ([193.114.103.68])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a170902e74900b001c3721897fcsm8351025plf.277.2023.09.12.06.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:14:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: John Snow <jsnow@redhat.com>,
	Cleber Rosa <crosa@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH] tests/avocado: Fix console data loss
Date: Tue, 12 Sep 2023 23:13:40 +1000
Message-Id: <20230912131340.405619-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Occasionally some avocado tests will fail waiting for console line
despite the machine running correctly. Console data goes missing, as can
be seen in the console log. This is due to _console_interaction calling
makefile() on the console socket each time it is invoked, which must be
losing old buffer contents when going out of scope.

It is not enough to makefile() with buffered=0. That helps significantly
but data loss is still possible. My guess is that readline() has a line
buffer even when the file is in unbuffered mode, that can eat data.

Fix this by providing a console file that persists for the life of the
console.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
was flakey for me due to this bug. I don't know why that in particular,
3 calls to wait_for_console_pattern probably helps.

I didn't pinpoint when the bug was introduced because the original
was probably not buggy because it was only run once at the end of the
test. At some point after it was moved to common code, something would
have started to call it more than once which is where potential for bug
is introduced.

Thanks,
Nick

 python/qemu/machine/machine.py         | 19 +++++++++++++++++++
 tests/avocado/avocado_qemu/__init__.py |  2 +-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index c16a0b6fed..35d5a672db 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -191,6 +191,7 @@ def __init__(self,
             self.sock_dir, f"{self._name}.con"
         )
         self._console_socket: Optional[socket.socket] = None
+        self._console_file: Optional[socket.SocketIO] = None
         self._remove_files: List[str] = []
         self._user_killed = False
         self._quit_issued = False
@@ -509,6 +510,11 @@ def _early_cleanup(self) -> None:
         # If we keep the console socket open, we may deadlock waiting
         # for QEMU to exit, while QEMU is waiting for the socket to
         # become writable.
+        if self._console_file is not None:
+            LOG.debug("Closing console file")
+            self._console_file.close()
+            self._console_file = None
+
         if self._console_socket is not None:
             LOG.debug("Closing console socket")
             self._console_socket.close()
@@ -874,12 +880,25 @@ def console_socket(self) -> socket.socket:
         Returns a socket connected to the console
         """
         if self._console_socket is None:
+            LOG.debug("Opening console socket")
             self._console_socket = console_socket.ConsoleSocket(
                 self._console_address,
                 file=self._console_log_path,
                 drain=self._drain_console)
         return self._console_socket
 
+    @property
+    def console_file(self) -> socket.SocketIO:
+        """
+        Returns a file associated with the console socket
+        """
+        if self._console_file is None:
+            LOG.debug("Opening console file")
+            self._console_file = self.console_socket.makefile(mode='rb',
+                                                              buffering=0,
+                                                              encoding='utf-8')
+        return self._console_file
+
     @property
     def temp_dir(self) -> str:
         """
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 33090903f1..0172a359b7 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -137,7 +137,7 @@ def _console_interaction(test, success_message, failure_message,
     assert not keep_sending or send_string
     if vm is None:
         vm = test.vm
-    console = vm.console_socket.makefile(mode='rb', encoding='utf-8')
+    console = vm.console_file
     console_logger = logging.getLogger('console')
     while True:
         if send_string:
-- 
2.40.1


