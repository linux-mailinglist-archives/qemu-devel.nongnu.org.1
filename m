Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D3A091B5
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 14:20:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEtr-0004dF-V5; Fri, 10 Jan 2025 08:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEtj-0004b9-Td
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEti-0004gq-24
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:17:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so15578935e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515076; x=1737119876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0LXmx1ZIyt0Pm1eKNy2RLsZFZZ8Gan/a2febN7NevY=;
 b=jgJ87Eqqy68t5zxHOmuH6UkKZVQ3q0zeJO8/nttRbM1e/puMz1yLEIFJVvLjZAi7F5
 AfUyZoKYS244AVMW6TvrAlbH9/nhqrEEzCWqnCl6hNnrmVcq/w1cqgEI/kBDapGFG6j+
 1G06kOq75UfG0oybrinVF/4BE6J9bEvlw8YiEjvJJUJMvYmoFlN6SrmlZNfS68hrHKCS
 wlGqwwLXjDwJMeGO18HvnrzGiIgBvp0wDB9Juy9RRye2VP6LRTWnivoHyrokKCdjfotJ
 YXKVJ8wEfSYUUHW60VWcdK9IP4PEUpxBv3tRPG4xysMcgpOAFajDSPw94GS5y4aFPATG
 nRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515076; x=1737119876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0LXmx1ZIyt0Pm1eKNy2RLsZFZZ8Gan/a2febN7NevY=;
 b=tfg0hyKXGA/vEDvouVfTpfqnyS+jPMppEYWRB5jYrHMSuyJkRDWo8c8lWM4RY2N26U
 Ho2Pat5g1IsIgYTOiP7QFMZGENhRIZopc1EBxOwHaxXKPdznp25F4mWm28ucAzyy+R9I
 2t/rDFTuZ/JFsKjzMHXo82Ude3QOYqU0xArGVmTXxSM4tpLvloi8UfwkEzvBrP0l6Kdl
 Jg7ZHSrETvkji748phfuFffUgeISh2Rt/RBstdT9ef9oUbjUvp95o6CEikq30Hg01FoT
 +XLRcFCEIIXbZ+x74URr5ktkRhPMisJHE7gsXc0rH/ju8Z1SuBJSj9JvowUEYc4FMIp3
 ZxQA==
X-Gm-Message-State: AOJu0YxOVoNqDyQvqv+LCKaDjcgckbACYZXUee9Y6Vzg8xFAL1FdIv6J
 fzd4tsnlNJpLkfm6iob8dRQWo1YYPHYZTkhAMvimud3WjAncjHASdgh+pzKsBsw=
X-Gm-Gg: ASbGncuS+qrRuYLDKd8Mv1zoMGhMaDfce8WA29kL7pnatL21evB9ZxgGARQWjQyNzIy
 YQ2xzWbw2oKUXWJmzwJSxcnhGBommmlJsoKPN0Ut3S8fHAOmFnyzVjK4zXcZqO7Ut88P7FNBse0
 GclvK8Le0elRc01V476iS3g/hphAdMVTOtN5Z1/WoaNy+otjHlq4A9ZoD61XHlsWCyunhsZUxLd
 A3DMFjdnOnnwfsn/i6zoPjq/lAb7Wc0W+k2/T0RGylN9r2GvBTB/rc=
X-Google-Smtp-Source: AGHT+IFuYXxTQQE1yAoJ6B7CZ8jf8jClMr2b02mWDNAfQPHG9yTb4VxRJXq3ZkFhGZ42IEGHq7tNyw==
X-Received: by 2002:a5d:6d8a:0:b0:386:4034:f9a8 with SMTP id
 ffacd0b85a97d-38a8733693fmr10287530f8f.38.1736515075816; 
 Fri, 10 Jan 2025 05:17:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fb99sm52776155e9.3.2025.01.10.05.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:17:54 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2FAF95F9CC;
 Fri, 10 Jan 2025 13:17:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 01/32] tests/functional: update the arm tuxrun tests
Date: Fri, 10 Jan 2025 13:17:23 +0000
Message-Id: <20250110131754.2769814-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Now there are new up to date images available we should update to them.

Cc: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-2-alex.bennee@linaro.org>

diff --git a/tests/functional/test_arm_tuxrun.py b/tests/functional/test_arm_tuxrun.py
index 944f0756e1..4ac85f48ac 100755
--- a/tests/functional/test_arm_tuxrun.py
+++ b/tests/functional/test_arm_tuxrun.py
@@ -17,14 +17,14 @@
 class TuxRunArmTest(TuxRunBaselineTest):
 
     ASSET_ARMV5_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/armv5/zImage',
-        'c95af2f27647c12265d75e9df44c22ff5228c59855f54aaa70f41ec2842e3a4d')
+        'https://storage.tuxboot.com/buildroot/20241119/armv5/zImage',
+        '3931a3908dbcf0ec0fe292d035ffc4dfed95f797dedd4a59ccfcf7a46e6f92d4')
     ASSET_ARMV5_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/armv5/rootfs.ext4.zst',
-        '17177afa74e7294da0642861f08c88ca3c836764299a54bf6d1ce276cb9712a5')
+        'https://storage.tuxboot.com/buildroot/20241119/armv5/rootfs.ext4.zst',
+        '60ff78b68c7021df378e4fc2d66d3b016484d1acc7e07fb8920c1d8e30f4571f')
     ASSET_ARMV5_DTB = Asset(
-        'https://storage.tuxboot.com/20230331/armv5/versatile-pb.dtb',
-        '0bc0c0b0858cefd3c32b385c0d66d97142ded29472a496f4f490e42fc7615b25')
+        'https://storage.tuxboot.com/buildroot/20241119/armv5/versatile-pb.dtb',
+        '50988e69ef3f3b08bfb9146e8fe414129990029e8dfbed444953b7e14809530a')
 
     def test_armv5(self):
         self.set_machine('versatilepb')
@@ -37,11 +37,11 @@ def test_armv5(self):
                            drive="virtio-blk-pci")
 
     ASSET_ARMV7_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/armv7/zImage',
-        '4c7a22e9f15875bec06bd2a29d822496571eb297d4f22694099ffcdb19077572')
+        'https://storage.tuxboot.com/buildroot/20241119/armv7/zImage',
+        '1377bc3d90de5ce57ab17cd67429fe8b15c2e9964248c775c682b67e6299b991')
     ASSET_ARMV7_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/armv7/rootfs.ext4.zst',
-        'ab1fbbeaddda1ffdd45c9405a28cd5370c20f23a7cbc809cc90dc9f243a8eb5a')
+        'https://storage.tuxboot.com/buildroot/20241119/armv7/rootfs.ext4.zst',
+        'ed2cbc69bd6b3fbd5cafb5ee961393c7cfbe726446f14301c67d6b1f28bfdb51')
 
     def test_armv7(self):
         self.set_machine('virt')
@@ -52,11 +52,11 @@ def test_armv7(self):
                            rootfs_asset=self.ASSET_ARMV7_ROOTFS)
 
     ASSET_ARMV7BE_KERNEL = Asset(
-        'https://storage.tuxboot.com/20230331/armv7be/zImage',
-        '7facc62082b57af12015b08f7fdbaf2f123ba07a478367853ae12b219afc9f2f')
+        'https://storage.tuxboot.com/buildroot/20241119/armv7be/zImage',
+        'a244e6da99f1bbd254827ec7681bd4aac9eb1aa05aaebc6b15e5d289ebb683f3')
     ASSET_ARMV7BE_ROOTFS = Asset(
-        'https://storage.tuxboot.com/20230331/armv7be/rootfs.ext4.zst',
-        '42ed46dd2d59986206c5b1f6cf35eab58fe3fd20c96b41aaa16b32f3f90a9835')
+        'https://storage.tuxboot.com/buildroot/20241119/armv7be/rootfs.ext4.zst',
+        'd4f9c57860a512163f30ecc69b2174d1a1bdeb853a43dc49a09cfcfe84e428ea')
 
     def test_armv7be(self):
         self.set_machine('virt')
-- 
2.39.5


