Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9897A09DB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgofz-0001hn-Qr; Thu, 14 Sep 2023 11:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgoft-0001VA-A6
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgofl-00088P-VH
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:54:36 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-402d499580dso11976005e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694706868; x=1695311668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq8NmlF/vcFodf5p9FXdk6/zlLfm5raaYFWHiGtXyA8=;
 b=jCzCbeZtub8O++9prSZ3QgpCZ/PF/ajpHTGmuuKIR959ZzDGngVy3aQLyYRuED8Y0X
 p910tFDcQm0b2yfIVNfKo2jj+bm/Y7fz/C5WnBtKnoVIZDqxreMPqLfAzzceZC7PY4uf
 1fyAXAFtWcyY2oOpWTQRk83ueP662Ah0DZo0p6ClfdRmaLZQh5GDxBfFkRT8ZxO2i4tS
 LNJd41BLEToIf7/f+jB28yecxH23gGNlA/W03ObF8o9dMocBve4YiEgyX2bYFApqdEli
 xNwAe7qwRU/CgrvYX3eqQKIrb+R8WZFjkzMFor/ItlElnbRGv3crwsrtItzUXN1ZmMq3
 FPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694706868; x=1695311668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq8NmlF/vcFodf5p9FXdk6/zlLfm5raaYFWHiGtXyA8=;
 b=mK2PDYhkbxsmdE0pm1IpsEqdSxGpkjyq2XsCsB43JHW9exBUW7WLsu1MHNNAUpJjeF
 Gjx4eBnnjz5lbH3EmaDHX1A4Pj2/QJv54V0mdmq6688oY6/jjhkVTWPWkT9gWbwghy9l
 A/Jfddee7r8aoa7Q0MbIqBpo9p0LrZ+FzjDhFrplJTxm4M0UIXwbCe4/+sVJuvLp0t8d
 dc7BJDHFHk2UW5pUkZkw5zBRGEbac7C2GlA6vj2CevJhyIyqabo7NRKawSTEItckv6Ug
 Rfd5Z9vivmiy/Uz4aPePMMrWNe5dQYfE8bBDmuB6W63j/BPSSqwv2CWWnQ01s+YrVb1j
 RDpQ==
X-Gm-Message-State: AOJu0YxRxmcQQ2HRyaAq6lHrO/9HuJREUy7t/LXe6PM9YzB3CY4o8Ybz
 VELkfKPirp8+/ZTPEdtwfe0UIw==
X-Google-Smtp-Source: AGHT+IEYSX/Ft/B0fQUXPozpfU4/99hj5m7eMOiwCkpTA8cQHn/mnVfi3Il/+7U3W8VvO4egSVyhkw==
X-Received: by 2002:a05:600c:210f:b0:403:be16:baa with SMTP id
 u15-20020a05600c210f00b00403be160baamr4972026wml.29.1694706867810; 
 Thu, 14 Sep 2023 08:54:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a7bc397000000b00403bbe69629sm2299139wmj.31.2023.09.14.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 08:54:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F3A11FFC3;
 Thu, 14 Sep 2023 16:54:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 8/9] tests/avocado: Fix console data loss
Date: Thu, 14 Sep 2023 16:54:21 +0100
Message-Id: <20230914155422.426639-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230914155422.426639-1-alex.bennee@linaro.org>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
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
2.39.2


