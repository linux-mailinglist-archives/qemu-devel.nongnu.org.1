Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACB7BF4DC
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:53:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YN-0005EJ-Ow; Tue, 10 Oct 2023 03:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YL-0005DL-Ls; Tue, 10 Oct 2023 03:53:18 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YK-0005J7-1O; Tue, 10 Oct 2023 03:53:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-694f3444f94so4372155b3a.2; 
 Tue, 10 Oct 2023 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924394; x=1697529194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzOvLxS1cPxCxPNwvebvFR0vfUNiwD3ZL/gAnQtCs40=;
 b=fF/Qz9wY9NzOtO4Sbz/1JY5ZTtjKLQDz+UbK0RAwCFAY/ocrsZcYJCiOmGpoNgIRH3
 VDKin8DmqKtxn1t0SMakalb1mzPJUI4gXVfGcjJGPG75l7XM/YIm8GXAnhGt0TYbVEdc
 4mL2p8bp7pICQWilYiymBx2DNaEw0GW+RJCOrTFZNgCH65Em8N0frpx4tuuraFdXy5nP
 5n1NUwXs6AEQ7w4ntYGHyv8CrlG+N8hssmNVyt3B17Wlr57fvbPFMM0J/RCCeX/rW2j0
 vy1Oym4c8larZikV5etP1DNZ2hMQHRMB9MOIbxWaPYSzAJr865DCq8sToNpY1nz+Ow/o
 0+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924394; x=1697529194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tzOvLxS1cPxCxPNwvebvFR0vfUNiwD3ZL/gAnQtCs40=;
 b=Ttuk2dFvZqYb8jGCaIoZPGIVwCyZlQlY3t7aR+Bk/lthE9lk/NYhbd+HH1kGot6Vxt
 86njsRdFsc4/s6mBy3VjWlHKtq223u3B+QFKHNy5XVmL6PNniF5uVd0IctHqJ+zaCa9P
 HkYGeMI0HPTDk1Nbu4rB18eda8uCI8YulCboPdJQrtKBh4OLWjNVrvgviNaIvmxS8Kyp
 vuPPeoafI8AO5sCa/7cU0xHK7H9UU+SR4VB7N62LUt1eOOOsEbHTpf7qO0oPPYxRvBTb
 lPzUDNUJMIztfL4DwnKMC7Iy6naJanalcuP3ifiZD2xpj0Irfq4fNNP7s4oyETtsmAr9
 Q0aw==
X-Gm-Message-State: AOJu0Yzh1vFKhuEYH+HTXtS2oq97nrjVGR9abWIyOmWYi9ETOldmzEjm
 CoXiuKxXNrqoDcIwWQuFiGInRCk+pGE=
X-Google-Smtp-Source: AGHT+IFmF1pxen0+7sYvREMdchqD21gPoFLDst0CGYa9ywv9ISYWe5gJmcVy4hruzf+jkm20A7Tebw==
X-Received: by 2002:a05:6a20:914b:b0:158:7fdf:66df with SMTP id
 x11-20020a056a20914b00b001587fdf66dfmr21927995pzc.18.1696924394072; 
 Tue, 10 Oct 2023 00:53:14 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for non-free AIX
 images
Date: Tue, 10 Oct 2023 17:52:34 +1000
Message-ID: <20231010075238.95646-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

An AIX image can be provided by setting AIX_IMAGE environment
variable when running avocado.

It's questionable whether we should carry these in upstream QEMU.
It's convenient to see how to run these things, but simple enough
to maintain in out of tree branch. I just wanted to see opinions
about it.
---
 tests/avocado/ppc_aix.py | 63 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tests/avocado/ppc_aix.py

diff --git a/tests/avocado/ppc_aix.py b/tests/avocado/ppc_aix.py
new file mode 100644
index 0000000000..b8d5d4cc38
--- /dev/null
+++ b/tests/avocado/ppc_aix.py
@@ -0,0 +1,63 @@
+# Functional test that boots AIX on ppc pseries TCG and KVM
+#
+# Copyright (c) 2023 IBM Corporation
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+from avocado.utils import archive
+from avocado_qemu import QemuSystemTest
+from avocado_qemu import wait_for_console_pattern
+
+class pseriesMachine(QemuSystemTest):
+
+    timeout = 600
+
+    def do_test_ppc64_aix_boot(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+
+        image = os.getenv('AIX_IMAGE')
+        if not image:
+            self.cancel('No AIX_IMAGE environment variable defined')
+
+        _hash = os.getenv('AIX_HASH')
+        if _hash:
+            aix_disk = self.fetch_asset(image, asset_hash=_hash)
+        else:
+            aix_disk = self.fetch_asset(image)
+
+        self.vm.set_console()
+        self.vm.add_args('-machine', 'ic-mode=xics',
+                         '-smp', '16,threads=8,cores=2',
+                         '-m', '4g',
+#                         '-device', 'spapr-vlan,netdev=net0,mac=52:54:00:49:53:14',
+#                         '-netdev', 'tap,id=net0,helper=/usr/libexec/qemu-bridge-helper,br=virbr0',
+                         '-device', 'qemu-xhci',
+                         '-device', 'virtio-scsi,id=scsi0',
+                         '-drive', f'file={aix_disk},if=none,id=drive-scsi0-0-0-0,format=qcow2,cache=none',
+                         '-device', 'scsi-hd,bus=scsi0.0,channel=0,scsi-id=0,lun=0,drive=drive-scsi0-0-0-0,id=scsi0-0-0-0,bootindex=1',
+                         '-nodefaults')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'AIX Version 7')
+
+    def test_ppc64_aix_boot_tcg(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:tcg
+        """
+        self.require_accelerator("tcg")
+        self.do_test_ppc64_aix_boot()
+
+    def test_ppc64_aix_boot_kvm(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        :avocado: tags=accel:kvm
+        """
+        self.require_accelerator("kvm")
+        self.do_test_ppc64_aix_boot()
-- 
2.42.0


