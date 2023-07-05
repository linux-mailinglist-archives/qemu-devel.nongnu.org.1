Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2987483C5
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1Hn-0004ip-Gy; Wed, 05 Jul 2023 08:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1Hk-0004fr-Uu; Wed, 05 Jul 2023 08:07:04 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qH1Hj-0003Ye-0k; Wed, 05 Jul 2023 08:07:04 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6686c74183cso4989429b3a.1; 
 Wed, 05 Jul 2023 05:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688558820; x=1691150820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZObi7tNXlw5mTv75gagExeFYwXpgpLNO47lfD1FSzo=;
 b=fTN/JdjeEq/qlEXBfdQr2fI4/TfZqJ1VZgESPZLBsJj2B+p36Zqs/YexWB3bF5mupX
 BZQzaCm7hemvxXFUUZLSauoDN410xTCA7i7ItLrTuoP/MH55l13dgbUhIFZPf4WQEoan
 5oM2zd3cpvABxM7ip+pB+jg9+Vz75gF023qzcH+wvKtJd0m8/ZCfXkHEmoJcGzYSUN8C
 hYkK19VRVrv1QN94Kpt28ohzTivnkcjS2iRTnl+zt3rJSTKlasoJtASt7W11W2ote1mC
 xQLOrVjcuSKiPffRSzTJy01twY6gK+4rpOOS85iJIfKNYAXs9SyGF9yiGtXwyF25GYIg
 HgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688558820; x=1691150820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ZObi7tNXlw5mTv75gagExeFYwXpgpLNO47lfD1FSzo=;
 b=Y7JPFNVWrkv9Sv0g30xXXz/js+s0H3SlhjsQKPCFNZhIcHoM/Kw/yF2BCTQO/Qse8Y
 lWncHOd0l5lDA6TBzcEcCN05FHle0cWLQAM7uwvHTIMPTs5omRzB+Q17OiQJo47PQyjx
 k8ixPPS2h0NPaBimzBH7HoekDq1VHiKZzHGPjVPse4N+MXk1BqtlXg9yTVzarzuend6R
 T42mihQpIyS6D/HV4H73L91kY8CPM0h5lxEgBoftund0G0fRk5w8gYUbJv8k4cXvHZsz
 1inNHqVIH5DucOyAg5x2JR9iglwCgLFPLgyxl93j1w1pVOyHXIsK8ZMI0H/6cG3ws9T6
 g3aQ==
X-Gm-Message-State: ABy/qLYlLvPNoGC8+QFZn/ZT3PU5IgiwP+YxdOX66TWZF8jmovTY5/v9
 Dgra9B3QyxiQ91BmRvQt7us=
X-Google-Smtp-Source: APBJJlGHfnzIZOlquN/X/Cnb9o8HJ2mGx/7lk3b6CXtnQHKmCRL6QNf0s8Rg04t0Y8LhjOpos+U4/Q==
X-Received: by 2002:a05:6a00:1341:b0:674:6dd4:8337 with SMTP id
 k1-20020a056a00134100b006746dd48337mr23437778pfu.12.1688558819685; 
 Wed, 05 Jul 2023 05:06:59 -0700 (PDT)
Received: from wheely.local0.net ([61.68.2.145])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a00271000b0067459e92801sm15764843pfv.64.2023.07.05.05.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 05:06:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] tests/avocado: Add powernv machine test script
Date: Wed,  5 Jul 2023 22:06:31 +1000
Message-Id: <20230705120631.27670-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705120631.27670-1-npiggin@gmail.com>
References: <20230705120631.27670-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
I didn't add the powernv10 support yet as Cedric suggested, and kept the
same vmlinuz because it's common with the pseries tests. We should do
that in later tests though. Might be time to update default to power10
soon if the model is becoming more complete...

Thanks,
Nick

 tests/avocado/ppc_powernv.py | 87 ++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 tests/avocado/ppc_powernv.py

diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
new file mode 100644
index 0000000000..d0e5c07bde
--- /dev/null
+++ b/tests/avocado/ppc_powernv.py
@@ -0,0 +1,87 @@
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
+        self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
+
+        # powernv does not support NUMA
+        self.do_test_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
-- 
2.40.1


