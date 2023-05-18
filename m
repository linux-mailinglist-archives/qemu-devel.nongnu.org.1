Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871467085E5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgN1-0007eU-Ks; Thu, 18 May 2023 12:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMs-0007a5-AV
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMp-0006Oy-VD
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f417ea5252so15823155e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426838; x=1687018838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ayogSVxfSVQQQYdBMAOZ/LyoRWO3sdpvhi1wrumi/gQ=;
 b=rdB9tHepLa5T84QRfVWA+TvRBaMa0nNcNZspgXLRiaT+Seqe1WXZJfI2cVg1+rvF3D
 ZyvJAOjhY0/wmt8XeVF5BghlF6sZXB4b1vWY/jw5Mjx/FUf72rPDKBr0v6mb2qmXbXcj
 Ea15BZOrFOfuC3NpKvU9YrzkTfEnQoG7x5mxBxVKDMO6ybkWEXPyNrkoGzNRTkssKCV3
 EaO92MK0PsiKSDJd+X+hJYxy1XCjLs99uaS6ClwAvjPGxbr+HgHXDzT93iE0u0WBZTDe
 LMUtXLam5+FeWJ8s0t8pvl1/SBx5eCbP1HJfBf/GT8pZ5QI4glBepwjjlUY9e1eCrRRi
 mXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426838; x=1687018838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ayogSVxfSVQQQYdBMAOZ/LyoRWO3sdpvhi1wrumi/gQ=;
 b=f+Im7QH3y2TFd73dcToTyYcdL1xdnFrRxo4gpmXXG5OFEcU7KumSU1c/4J3XDZ2NrL
 IScqoFi2kIMZtRKJ+NVwFqj0FEx6/6NPQAlMl60Kf0A/+sO6KblrQMqqCXkDmrquJZ0n
 AHyOCpKLGhmW7OlqroMA4XqZmZM5s9EkmEvQa3OOSLg4+0P95x9gIQOq5jB9xWyV88IR
 IE6KaA6nKewCe+/0FZ1q/ujO9KEY4Z2N85N6dlQgF+WqevVnvzGCOMC9U/6ZoHl5f0gU
 HEWNu8vBASLCZTtg5+tEOxHCOVDTNu3lF9ArcrqcRrUzhwFuH68XCnXs5CWxf83HnOi0
 H1ZA==
X-Gm-Message-State: AC+VfDzzlQZzAG27kRFRtQD7VFgYgDmaIwnCEPq4Y0hly3kJTOv7NOb5
 C/dU+cZHxUV+/DRCNm8zuwHkIg==
X-Google-Smtp-Source: ACHHUZ6zJuqITLf763wgz0CVaqG2ZnvEU4wi+Z2UYemlS2423c3xMSdM1jU+jHB3rHn/sNzTnqLcsg==
X-Received: by 2002:a1c:7906:0:b0:3f4:253b:92b3 with SMTP id
 l6-20020a1c7906000000b003f4253b92b3mr1857874wme.18.1684426838667; 
 Thu, 18 May 2023 09:20:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c22c200b003f4e8530696sm2472658wmg.46.2023.05.18.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE6341FFC2;
 Thu, 18 May 2023 17:20:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 7/8] python/qemu: allow avocado to set logging name space
Date: Thu, 18 May 2023 17:20:33 +0100
Message-Id: <20230518162034.1277885-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since the update to the latest version Avocado only automatically
collects logging under the avocado name space. Tweak the QEMUMachine
class to allow avocado to bring logging under its name space. This
also allows useful tricks like:

  ./avocado --show avocado.qemu.machine run path/to/test

if you want to quickly get the machine invocation out of a test
without searching deeply through the logs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 python/qemu/machine/machine.py         | 42 ++++++++++++++------------
 tests/avocado/avocado_qemu/__init__.py |  3 +-
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e57c254484..402b9a0df9 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -49,10 +49,6 @@
 
 from . import console_socket
 
-
-LOG = logging.getLogger(__name__)
-
-
 class QEMUMachineError(Exception):
     """
     Exception called when an error in QEMUMachine happens.
@@ -131,6 +127,7 @@ def __init__(self,
                  drain_console: bool = False,
                  console_log: Optional[str] = None,
                  log_dir: Optional[str] = None,
+                 log_namespace: Optional[str] = None,
                  qmp_timer: Optional[float] = 30):
         '''
         Initialize a QEMUMachine
@@ -164,6 +161,11 @@ def __init__(self,
         self._sock_dir = sock_dir
         self._log_dir = log_dir
 
+        if log_namespace:
+            self.log = logging.getLogger(log_namespace)
+        else:
+            self.log = logging.getLogger(__name__)
+
         self._monitor_address = monitor_address
 
         self._console_log_path = console_log
@@ -382,11 +384,11 @@ def _post_shutdown(self) -> None:
         Called to cleanup the VM instance after the process has exited.
         May also be called after a failed launch.
         """
-        LOG.debug("Cleaning up after VM process")
+        self.log.debug("Cleaning up after VM process")
         try:
             self._close_qmp_connection()
         except Exception as err:  # pylint: disable=broad-except
-            LOG.warning(
+            self.log.warning(
                 "Exception closing QMP connection: %s",
                 str(err) if str(err) else type(err).__name__
             )
@@ -414,7 +416,7 @@ def _post_shutdown(self) -> None:
                 command = ' '.join(self._qemu_full_args)
             else:
                 command = ''
-            LOG.warning(msg, -int(exitcode), command)
+            self.log.warning(msg, -int(exitcode), command)
 
         self._quit_issued = False
         self._user_killed = False
@@ -458,7 +460,7 @@ def _launch(self) -> None:
         Launch the VM and establish a QMP connection
         """
         self._pre_launch()
-        LOG.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
+        self.log.debug('VM launch command: %r', ' '.join(self._qemu_full_args))
 
         # Cleaning up of this subprocess is guaranteed by _do_shutdown.
         # pylint: disable=consider-using-with
@@ -507,7 +509,7 @@ def _early_cleanup(self) -> None:
         # for QEMU to exit, while QEMU is waiting for the socket to
         # become writable.
         if self._console_socket is not None:
-            LOG.debug("Closing console socket")
+            self.log.debug("Closing console socket")
             self._console_socket.close()
             self._console_socket = None
 
@@ -518,7 +520,7 @@ def _hard_shutdown(self) -> None:
         :raise subprocess.Timeout: When timeout is exceeds 60 seconds
             waiting for the QEMU process to terminate.
         """
-        LOG.debug("Performing hard shutdown")
+        self.log.debug("Performing hard shutdown")
         self._early_cleanup()
         self._subp.kill()
         self._subp.wait(timeout=60)
@@ -535,17 +537,17 @@ def _soft_shutdown(self, timeout: Optional[int]) -> None:
         :raise subprocess.TimeoutExpired: When timeout is exceeded waiting for
             the QEMU process to terminate.
         """
-        LOG.debug("Attempting graceful termination")
+        self.log.debug("Attempting graceful termination")
 
         self._early_cleanup()
 
         if self._quit_issued:
-            LOG.debug(
+            self.log.debug(
                 "Anticipating QEMU termination due to prior 'quit' command, "
                 "or explicit call to wait()"
             )
         else:
-            LOG.debug("Politely asking QEMU to terminate")
+            self.log.debug("Politely asking QEMU to terminate")
 
         if self._qmp_connection:
             try:
@@ -557,14 +559,14 @@ def _soft_shutdown(self, timeout: Optional[int]) -> None:
                 # Regardless, we want to quiesce the connection.
                 self._close_qmp_connection()
         elif not self._quit_issued:
-            LOG.debug(
+            self.log.debug(
                 "Not anticipating QEMU quit and no QMP connection present, "
                 "issuing SIGTERM"
             )
             self._subp.terminate()
 
         # May raise subprocess.TimeoutExpired
-        LOG.debug(
+        self.log.debug(
             "Waiting (timeout=%s) for QEMU process (pid=%s) to terminate",
             timeout, self._subp.pid
         )
@@ -586,9 +588,9 @@ def _do_shutdown(self, timeout: Optional[int]) -> None:
             self._soft_shutdown(timeout)
         except Exception as exc:
             if isinstance(exc, subprocess.TimeoutExpired):
-                LOG.debug("Timed out waiting for QEMU process to exit")
-            LOG.debug("Graceful shutdown failed", exc_info=True)
-            LOG.debug("Falling back to hard shutdown")
+                self.log.debug("Timed out waiting for QEMU process to exit")
+            self.log.debug("Graceful shutdown failed", exc_info=True)
+            self.log.debug("Falling back to hard shutdown")
             self._hard_shutdown()
             raise AbnormalShutdown("Could not perform graceful shutdown") \
                 from exc
@@ -611,9 +613,9 @@ def shutdown(self,
         if not self._launched:
             return
 
-        LOG.debug("Shutting down VM appliance; timeout=%s", timeout)
+        self.log.debug("Shutting down VM appliance; timeout=%s", timeout)
         if hard:
-            LOG.debug("Caller requests immediate termination of QEMU process.")
+            self.log.debug("Caller requests immediate termination of QEMU process.")
 
         try:
             if hard:
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index b19f797b7b..d925573299 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -322,7 +322,8 @@ def require_multiprocess(self):
     def _new_vm(self, name, *args):
         self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
         vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
-                         sock_dir=self._sd.name, log_dir=self.logdir)
+                         sock_dir=self._sd.name, log_dir=self.logdir,
+                         log_namespace="avocado.qemu.machine")
         self.log.debug('QEMUMachine "%s" created', name)
         self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
         self.log.debug('QEMUMachine "%s" log_dir: %s', name, vm.log_dir)
-- 
2.39.2


