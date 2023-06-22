Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB2739D7A
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGiC-0000tD-Pc; Thu, 22 Jun 2023 05:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGiA-0000qd-DG; Thu, 22 Jun 2023 05:34:42 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGi8-0003Ug-K4; Thu, 22 Jun 2023 05:34:42 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-54f87d5f1abso3280687a12.0; 
 Thu, 22 Jun 2023 02:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426478; x=1690018478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0QAlf14eWjU3ei2UOf8F2+vrB4RaBxT5v9V0hoY2s24=;
 b=nZqJ1WuClMSqFv0qTI+7I/YU3H2jFF/2rKkKFyoS14G/9YEM4HhLU1OYvusWWiOuIm
 GkUcMrZBS2T8RdbN4GDTO3Md4r8gUBy0p9q/9O0AjBMQeGi5Jy4gLiz6zia7m51vwTkJ
 0DjlgqVZyTutkg5W+5jsjSHQ+w6D4y6yHpV4R2/BB8GyvXH/MXuONHWe3JCfdV2adPUp
 F0yC0X48TczNI8PuM4oRQIXDHQ8kazXt+7hTRSM15+pIEoV6uWtwxFoAOl0mb40OzqWH
 718onULyRQKmjenT6/7vqgwJuT6XIe1uduy04+uuNf8Fw4OApN9FpNeOs1aCiEiqnXb1
 mO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426478; x=1690018478;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0QAlf14eWjU3ei2UOf8F2+vrB4RaBxT5v9V0hoY2s24=;
 b=lnx4uRe4Y32SbMYKhasdY40+NoBEe0x8Y+/aKyMP9RL+QjhCEYPOYEkCKOIcTuYz6Q
 POuaH5Mchz8OzzXVAEhGSFUfXZrnqVnbc24nbC0bIQfuaKmlO5YP78HYFHjveuKwpV8/
 dnMU5p1mitmAqZcrJIuZhz4wgbmqxLH/7lnET3Cv4hvjT4HrizrfznbWcEr0e/9wkTtE
 pyRrOKfqu4UtyvbIyfQ+jn/WsiEBZUk57C6Hld2s8x1xfinFrSajDJSkriVyrBVpXBvB
 6XU/bPdqWIB2PvZL3b8KZ9oI10FL09441S3k1Azv8p0jCwKZcV8r4lOJSkoO9kr+VjQ5
 0C2Q==
X-Gm-Message-State: AC+VfDxsoToU3ZThOd0XC1BwHFTccHFvU8LMvHBXfQHm+iutPPW32/YH
 gw462xSTPwr2SPSAVJgMaUt6R3wdfAQ=
X-Google-Smtp-Source: ACHHUZ6mjfrI6sylfPziHox5mHVA3eeFacq9CWplh5z0e+mEt/oPOP5ci8Tl6e6z1948TflEYbLvMA==
X-Received: by 2002:a05:6a20:4308:b0:10b:f980:18d3 with SMTP id
 h8-20020a056a20430800b0010bf98018d3mr15303100pzk.1.1687426478544; 
 Thu, 22 Jun 2023 02:34:38 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 7/7] tests/avocado: Add ppc64 pseries multiprocessor boot
 tests
Date: Thu, 22 Jun 2023 19:33:57 +1000
Message-Id: <20230622093357.255649-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x536.google.com
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

Add mult-thread/core/socket Linux boot tests that ensure the right
topology comes up. Of particular note is a SMT test, which is a new
capability for TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_pseries.py | 60 +++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
index a152cf222e..ff42c770f2 100644
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/avocado/ppc_pseries.py
@@ -14,12 +14,9 @@ class pseriesMachine(QemuSystemTest):
     timeout = 90
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     panic_message = 'Kernel panic - not syncing'
+    good_message = 'VFS: Cannot open root device'
 
-    def test_ppc64_pseries(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
+    def do_test_ppc64_linux_boot(self):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os'
                       '/ppc/ppc64/vmlinuz')
@@ -31,5 +28,58 @@ def test_ppc64_pseries(self):
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
+
+    def test_ppc64_linux_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.do_test_ppc64_linux_boot()
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
+
+    def test_ppc64_linux_smp_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-smp', '4')
+        self.do_test_ppc64_linux_boot()
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_ppc64_linux_smt_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-smp', '4,threads=4')
+        self.do_test_ppc64_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+    def test_ppc64_linux_big_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
+        self.vm.add_args('-m', '512M',
+                         '-object', 'memory-backend-ram,size=256M,id=m0',
+                         '-object', 'memory-backend-ram,size=256M,id=m1')
+        self.vm.add_args('-numa', 'node,nodeid=0,memdev=m0')
+        self.vm.add_args('-numa', 'node,nodeid=1,memdev=m1')
+        self.do_test_ppc64_linux_boot()
+        console_pattern = 'CPU maps initialized for 4 threads per core'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
+        wait_for_console_pattern(self, console_pattern, self.panic_message)
+        wait_for_console_pattern(self, self.good_message, self.panic_message)
-- 
2.40.1


