Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 818A37A21FC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhARW-0003P5-Jh; Fri, 15 Sep 2023 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARH-0003F0-J9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qhARF-00029o-LW
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:08:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so1485615f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694790536; x=1695395336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcvLekfgkgzF278cqTU4MlqaFKkEi2GbfnC328zBuE0=;
 b=wtYI5RmU0grbK63HB4S1Uxo0NrXI+c/Xu0ig2rWdRkoNjvZkSQ7RqU2PNqRS1+Tn2N
 +NQz0QLq06Y4UZBrKie10r/rvtYTdfHcpVtWfSrgFnBSJaNlCh3rPBYAUHNgeoE0V1C3
 V6vNxg3vdfyy0QKSG3PggGP/lt/T9ZKURIH/e7yovRW4630CL/phJE+Cqm+eZzUP7tLL
 styrDqGnRSXKcYK0UH9Jb81Vk3CLNiC74LJYyzrrtg1yjRD2TTZY8MLWvSVfXwnw3Bi+
 UgqydRx/8FSx133hYP4p9oQG8JvsVLOQs8wdnOwuga4sZq8Nnu37pH55hI+RTp4tEpQE
 IC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694790536; x=1695395336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CcvLekfgkgzF278cqTU4MlqaFKkEi2GbfnC328zBuE0=;
 b=XviFIel2H9cxkfZPgfB9TwDVcD7JxxGYv0jvlTjlBM1nDKR4g7sUoDiJQQuBTqVVYA
 Bwh+w8YS7NGJ0VPQONf+KltR2Z2X/6Tw6/jNsY0mZC8827fWqz/kobGtLpS5V5R86Yyg
 BQXnAHaI07JiM/Gnr4sJsQldIfqkyNhVgtu+cpBW0OyviTzF8Sgow+MLWjBnjCACGqby
 ynxpUm+fzrc3LyWObeBis5GOop5UKHXG1EuZqy6iViaCDbatj5ibJukGT/cDgS0dsAa5
 yH9dqQmuzI3YbI0kKOQUPYT6UTLlOn/AJeVU1e4euFmiIhAmJsNUM/kJepMjKFnwy7v0
 iyxQ==
X-Gm-Message-State: AOJu0YwOwhKH1iOMS7DbO4Ks4SubVWuY9U6OiPh7pZy60jF25uipNw4J
 yDKalMruicMHi1sIWSJp+g5VMA==
X-Google-Smtp-Source: AGHT+IHAMgmkhhVXx9Lsz0fFeLAWoEvyzUejoZ9RnEtilThpFZHDu99e/kJQiYvO/Rooy5NGx++ciw==
X-Received: by 2002:a5d:6585:0:b0:317:dd94:d38b with SMTP id
 q5-20020a5d6585000000b00317dd94d38bmr4283710wru.10.1694790535961; 
 Fri, 15 Sep 2023 08:08:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z25-20020a1c4c19000000b003fe29f6b61bsm4832634wmf.46.2023.09.15.08.08.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 08:08:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C44E81FFBB;
 Fri, 15 Sep 2023 16:08:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 8/9] tests/avocado: Fix console data loss
Date: Fri, 15 Sep 2023 16:08:48 +0100
Message-Id: <20230915150849.595896-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
References: <20230915150849.595896-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Message-Id: <20230912131340.405619-1-npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230914155422.426639-9-alex.bennee@linaro.org>

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
2.39.2


