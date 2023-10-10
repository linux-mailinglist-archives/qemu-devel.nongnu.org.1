Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF727BF4E4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YK-00052q-2n; Tue, 10 Oct 2023 03:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YE-0004il-FB; Tue, 10 Oct 2023 03:53:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YC-0005I0-6k; Tue, 10 Oct 2023 03:53:09 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-690f7d73a3aso4748069b3a.0; 
 Tue, 10 Oct 2023 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924386; x=1697529186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W3kMfoAJbHxcTO8KNkuAf+XxPC/1KqJfhYW246npcGE=;
 b=GU5u+p8vic5m0ep7BYxbgSqDlDbtMA4k5515YixbqVNmvzPWuk3lerkbZ5HQftS5rX
 KSGkZddNpAL4HyAEeQIDHFWKtYN4qlIxjjBcM+G3ivBSm2591uAB4+AKC9E3vKSVRQDg
 JGiqAuNE1XtkMRZJN9TC166Gg8OyqXqjFFq8IFJ58drJqOgok2alg9XC+wvW66f23XQ2
 /hMpVhsVxrccCh2JAX1JSsjrwu1RFav7r0LM/LYsz4zgzcMFchSvq183Zx4maxgK/0Hc
 WKvmszCJQ1Tw7XLy2nl/lcCzQ+CT8eclaloySZwwp3yDjBENDtJ3ng+83037dKpsSUWO
 Ux6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924386; x=1697529186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W3kMfoAJbHxcTO8KNkuAf+XxPC/1KqJfhYW246npcGE=;
 b=t9ocHdEtg9iLp+ZDmiJKliOIAlmqhpT4ieAZNMj2cs0/MwfS3Yfe8nQzEMEiY/uXrl
 KlY2CmuPbEGvXTVOcAkDhcyW7S/HHMXegvI7ZMU3TdD9wook4ycMzQeeU2MrEl2E+v2f
 h8iGcdZkb9XLzW5E0ikGwAYBuIaaAhYryAS5vQxnGU27+/9PehlfZLVajk2WCgXwPlBF
 kzzr8Is3bz13NP+IfRt6cCnCRKz5n94sqy8TufjIizmOq0BY2kJnta2DoF0mGyiTSGMH
 OL63ggZD8WiTpUTNiDjM1tWqgSedTpVdZVDaavD2AoM8halSx7cFOMBSJGIggSpKz2d4
 Dr5w==
X-Gm-Message-State: AOJu0YxB617PpoL0cywUbJyTdHfccN6Kxw/Zn09IDlZ2qNBr7hKnma8L
 YxaqEWVTZfk/NAOi2AzEgKDp8Q8JIKs=
X-Google-Smtp-Source: AGHT+IEFAYiiyt+LyeG8F5lUAvXnd0BejZd32fdJfUearp06e4w4kAo1uiHGOfARLkHwacpI33yA5A==
X-Received: by 2002:a05:6a20:430e:b0:16b:8498:d9bc with SMTP id
 h14-20020a056a20430e00b0016b8498d9bcmr12958320pzk.62.1696924386438; 
 Tue, 10 Oct 2023 00:53:06 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
Date: Tue, 10 Oct 2023 17:52:32 +1000
Message-ID: <20231010075238.95646-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
using Guenter Roeck's rootfs images for Linux testing, and a gitlab
repository with kernel images that I built since there are very few
sources of modern BookE images now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 9434304cd3..dc3346ef49 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1355,6 +1355,59 @@ def test_ppc64_e500(self):
         tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
         self.do_test_advcal_2018('19', tar_hash, 'uImage')
 
+    def test_ppc64_e6500(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:ppce500
+        :avocado: tags=cpu:e6500
+        :avocado: tags=accel:tcg
+        """
+        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/corenet64_vmlinux?ref_type=heads&inline=false')
+        kernel_hash = '01051590b083fec66cb3b9e2e553e95d4cf47691'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/master/rootfs/ppc64/rootfs.cpio.gz')
+        initrd_hash = '798acffc036c3b1ae6cacf95c869bba2'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
+                                       algorithm="md5")
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-smp', '2',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
+    def test_ppc32_mpc85xx(self):
+        """
+        :avocado: tags=arch:ppc
+        :avocado: tags=machine:ppce500
+        :avocado: tags=cpu:mpc8568
+        :avocado: tags=accel:tcg
+        """
+        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/mpc85xx_vmlinux?ref_type=heads&inline=false')
+        kernel_hash = '726f7f574a491282454850b48546b3827593142b'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/master/rootfs/ppc/rootfs.cpio.gz')
+        initrd_hash = '4d30fa93b742c493e8cf2140e49bbd9a'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash,
+                                       algorithm="md5")
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        # Wait for VM to shut down gracefully
+        self.vm.wait()
+
     def do_test_ppc64_powernv(self, proc):
         self.require_accelerator("tcg")
         images_url = ('https://github.com/open-power/op-build/releases/download/v2.7/')
-- 
2.42.0


