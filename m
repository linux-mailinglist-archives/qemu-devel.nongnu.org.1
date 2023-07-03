Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EC3745A00
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:18:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGd7-000105-4B; Mon, 03 Jul 2023 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGci-0000SM-RC; Mon, 03 Jul 2023 06:17:38 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGGcg-0000wf-Db; Mon, 03 Jul 2023 06:17:36 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a1ebb79579so2978368b6e.3; 
 Mon, 03 Jul 2023 03:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688379453; x=1690971453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2gt1lnUq8y40pcxU1eigEsqaAQ/li7F9tt52IsECqI=;
 b=WYMqy7k2rrrarWhOw2NKP8clGg3NzeI1xYnwyuY+PhLQOM4Ei0VWyhLGUgGm2Gi8YB
 l6ADfQ2pUsSlwaAEULlgaENbAAX59MfYdKwuWYfqsQqcFknoP86VubkPh1b8WDE+chqH
 nxkL5rfmvFmW2b6O5rGJAofQ/CDIof2ZHzn+eMZNVY2DDtx/Nm1jgBErm+AmjdQXtq1Q
 meQ1L90/CcgNu09XuL8XJfhRHYrL5HWiYooyOTVafeuy7UIRX6gk28QWj/t/TK5utobA
 YxySJd1Y+ZbFHUfH0UwNTQVABvw3dtaKZwKV15zUUGXlUKn03hHnMfSBZ9471HdPZrzC
 Gy6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688379453; x=1690971453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2gt1lnUq8y40pcxU1eigEsqaAQ/li7F9tt52IsECqI=;
 b=WOWzArFOuQpvShMyfnOFPowqTI+J6TYfXQbWi02xJbaPGOZlsEEd/kJ1hChwqq9jul
 ktGHpZ9NP33mAd8VXsjj2HEWrWTbZpiICP5xgoffQNCxpC4TYupsrIvoQ+WknMNkg8Ki
 MdESiVxTA1wKRaWgxYXco41Sk7Dtm1Ic08hBf6CY29IP1CEd+1257ZbIr0wL2yzeLAx6
 LvMK94dUAS5qbFkfqqp44Gi4PBNAbr1HRdwUiY4XKjYAGkmzw0St04GjH2Kl1Z/0fNNH
 lYZpyjbWswiKXmM4AQWGQuwT4N2d+oVttSpySidMOpcD8XFeOQol75PlL/orYEiXgqwN
 UdVg==
X-Gm-Message-State: AC+VfDwg8Rn4lupctgPG8G1hUHY5esPlzZgfPJ0VK/oF5+jLCEHbydHs
 iYKblGqEDNDXLX7g+9gxJG0=
X-Google-Smtp-Source: ACHHUZ6eIdVbzGqzw/cp23E8w/hdiwwJc4NdHXGXh4zKe0PbmqAOAtglKN9uHagsE5RL6nphDlw++Q==
X-Received: by 2002:aca:1a12:0:b0:3a3:613b:2787 with SMTP id
 a18-20020aca1a12000000b003a3613b2787mr8951525oia.32.1688379453014; 
 Mon, 03 Jul 2023 03:17:33 -0700 (PDT)
Received: from wheely.local0.net ([118.210.96.60])
 by smtp.gmail.com with ESMTPSA id
 o2-20020aa79782000000b006826c9e4397sm3887727pfp.48.2023.07.03.03.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:17:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH 4/4] tests/avocado: Add powernv machine test script
Date: Mon,  3 Jul 2023 20:17:00 +1000
Message-Id: <20230703101700.24064-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230703101700.24064-1-npiggin@gmail.com>
References: <20230703101700.24064-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
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

This copies ppc_pseries.py to start a set of powernv tests, including
a Linux boot test for the newly added SMT mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_powernv.py | 86 ++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 tests/avocado/ppc_powernv.py

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
new file mode 100644
index 0000000000..f72e87bc70
--- /dev/null
+++ b/tests/avocado/ppc_powernv.py
@@ -0,0 +1,86 @@
+# Test that Linux kernel boots on ppc powernv machines and check the console
+#
+# Copyright (c) 2018, 2020 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class powernvMachine(QemuSystemTest):
+
+    timeout = 90
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    panic_message = 'Kernel panic - not syncing'
+    good_message = 'VFS: Cannot open root device'
+
+    def do_test_linux_boot(self):
+        self.require_accelerator("tcg")
+        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
+                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
+                      '/ppc/ppc64/vmlinuz')
+        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+
+    def test_linux_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.do_test_linux_boot()
+        console_pattern = 'VFS: Cannot open root device'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+
+    def test_linux_smp_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_linux_boot()
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_linux_smt_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '4,threads=4')
+        self.do_test_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_linux_big_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        :avocado: tags=accel:tcg
+        """
+
+        self.vm.add_args('-smp', '8,threads=4,cores=2,sockets=1')
+        # powernv does not support NUMA
+        self.do_test_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 1 node, 8 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
-- 
2.40.1


