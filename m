Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8897EE030
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3awo-0006hK-Gt; Thu, 16 Nov 2023 06:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3awk-0006gp-EL; Thu, 16 Nov 2023 06:54:10 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r3awi-0007ec-Ow; Thu, 16 Nov 2023 06:54:10 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso551352b3a.0; 
 Thu, 16 Nov 2023 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700135646; x=1700740446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CDWoSHE0j1N1eAwMlXB/CsHQVHc/NREvoWLU+Iu7ryM=;
 b=Rz14px5XpgvYWpE5N63U5YM5hJ4WX83R1I2G4Fqkqj2oQ4YdW4enbl5G2khFgt7TW1
 rZThhMsKCuvjwefxWWmTp71erzfUzngPQylMDEYpKkWO1aqkYH06leRXi7KI6JljmWjF
 tlbN4uvpavqYjZD/PvrO40roZeWADz4qg27Eq3gKaAzoqCi/h9ZyAXaD18BBomo2uVVa
 JJoNIU7hqI6mJciaEcUrQcZKgLEEcPzJFekYT/WCiYbSXGmh6CaHrpC9E7XXkdRef8N2
 dT8J05MG6cLjTzHYFynfIyBRSdDV+EGSR6v2eChTEYT8QJYiqgqhOY3CYdhaPEBRjxDt
 PNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700135646; x=1700740446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDWoSHE0j1N1eAwMlXB/CsHQVHc/NREvoWLU+Iu7ryM=;
 b=Md9G1hE89urlaHqU4yUbNgHzA5SVuQFnMXNOgPb6R8GjWtQNLdYgbtlL1cxl+46O8G
 vJEQARNCvXYfvUXBP/K5Jkb4n/3Tuum3Jujl9KPvQQhcssNOXTHxxYSrdGCm6X7hhZrS
 h20+rNrvI7tFJmnz0zn3vvDw9tsTDexFNRFBT2G58mj/RbOFnQljOtX/HrWNqobU8YL5
 li9A5e7AMARbQKPDiyDZtMXLOn4glWZwz7++8c4FPY0prIigq7C//M7rifXxQ4N0XV/i
 IouzbQnkYps+tWpYxwEL1wsBgecThOBtuCcru2GTSkGVPuqxTcRIfYsTGCSvfefnJfKD
 xwXg==
X-Gm-Message-State: AOJu0YzVnSfuHFWVyV9lmT7ThMMY7Gam8ggvlz3mYqhcKnC94Vi5xBL7
 W/TWF83K+X0yx3qik20Xa9g+CEGf9pI=
X-Google-Smtp-Source: AGHT+IGzE0K7Q6r/Jt7kZxeh4svCSSEIXz4g0ueBLZV8KUy+cqPzL13fUEJ9vsztaBFLm3CbHunIzw==
X-Received: by 2002:a05:6a20:7da2:b0:14e:2208:d62f with SMTP id
 v34-20020a056a207da200b0014e2208d62fmr2638073pzj.22.1700135645614; 
 Thu, 16 Nov 2023 03:54:05 -0800 (PST)
Received: from wheely.local0.net ([210.84.53.86])
 by smtp.gmail.com with ESMTPSA id
 n19-20020a62e513000000b006c60b150383sm4507960pff.12.2023.11.16.03.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 03:54:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>, "John Snow" <jsnow@redhat.com>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/3] tests/avocado: reverse_debugging drain console to prevent
 hang
Date: Thu, 16 Nov 2023 21:53:52 +1000
Message-ID: <20231116115354.228678-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Like replay_linux.py, reverse_debugging.py starts the vm with console
set but does not interact with it (e.g., with wait_for_console_pattern).
In this situation, the console should have a drainer attached so the
socket does not fill. replay_linux.py has a drainer, but it is missing
from reverse_debugging.py.

Per analysis in Link: this can cause the console socket/pipe to fill and
QEMU get stuck in qemu_chr_write_buffer, leading to strange test case
failures (ppc64 fails because it prints a lot to console in early bios).
Attaching a drainer prevents this.

Note, this commit does not fix bugs introduced by the commits referenced
in the first two Fixes: tags, but together those commits conspire to
irritate the problem and cause test case failure, which this commit
fixes.

Link: https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
Fixes: 1d4796cd0083 ("python/machine: use socketpair() for console connections")
Fixes: 761a13b23946 ("tests/avocado: ppc64 reverse debugging tests for pseries and powernv")
Fixes: be52eca30978 ("tests/acceptance: add reverse debugging test")
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index fc47874eda..128d85bc0e 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -12,6 +12,7 @@
 
 from avocado import skipIf
 from avocado_qemu import BUILD_DIR
+from avocado.utils import datadrainer
 from avocado.utils import gdb
 from avocado.utils import process
 from avocado.utils.network.ports import find_free_port
@@ -52,6 +53,10 @@ def run_vm(self, record, shift, args, replay_path, image_path, port):
         if args:
             vm.add_args(*args)
         vm.launch()
+        console_drainer = datadrainer.LineLogger(vm.console_socket.fileno(),
+                                    logger=self.log.getChild('console'),
+                                    stop_check=(lambda : not vm.is_running()))
+        console_drainer.start()
         return vm
 
     @staticmethod
-- 
2.42.0


