Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEA07ABC85
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 02:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjqAD-0007fw-Ep; Fri, 22 Sep 2023 20:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qjqAA-0007ff-Es
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 20:06:22 -0400
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry.memverge@gmail.com>)
 id 1qjqA8-0006XP-Sl
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 20:06:22 -0400
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-59c0442a359so35829467b3.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 17:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695427578; x=1696032378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BblDtyq6+zOk7FwEfAtvrtpIxNgkfCtaoxoUkBjZCfE=;
 b=gr8V8makx68X2/mLon6OV8mi1t48RP9ShTfdeEAT/aZoXf7wv6jxdxxXAU9T5Vaamq
 nGlC663pauWYBMkUCabkxY6w1lB2IbdRDpa/3jUSWZrLgcifTKZJTg4nvsTP80fgqJNZ
 0ehTt3152UL1pKhlVWWvEcJxiKtGLErAc6es+CTJ3ZmwId+aYORIDuyRI5Zuyy17RDfI
 V+PtsgG7qQ5hCm2B1XKH0WufF2fFk3CJG3oL2WomZ5uYucGZWTClmxeSjTDwaQkI2zIX
 L7fphZ2QJeyEE+tg9kJckA+UffahnDtl9kBKOQAkSMu4QzB9e98tNsZxkYawB8i/dO4N
 6j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695427578; x=1696032378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BblDtyq6+zOk7FwEfAtvrtpIxNgkfCtaoxoUkBjZCfE=;
 b=Syo2rRMo1IOF73QRcv2rIgeyNj7ORcn+mvVb3ISB8LUtofKXoT8lJAnfnqJoZ0GJu6
 GsWFpZEnephaE9hcWg8fZuTc/vNcNw4YCPGsRE1ohkJfRDB1wigpDoc1SNPaPrw3a1Rm
 AhVRhZOf4/Qqcz5EQIRB3Pd63a9Qgdo135RlgfnhvQzz7APXM9OZfSwKzHQv0mo1Ou7d
 GHpuIQQ/IXz10nt4b7/HP/eMzD2aOzKi57qMgitkdBcoW+8ImWUjZlc2J1Xn2U3t6HxO
 g7j7YCb2lSkdy1lmXUqrBijTl1XPOebxzdub4if+nV9yVi5WCaBI7OwBOC4OcJvYJUJ4
 PXbw==
X-Gm-Message-State: AOJu0YydQNAGiybeJpM8asznnmoiu06l7/xHTF26L8kg2gTat6YhMzVQ
 gSesdNU5CWtpAZtK5bvStozIfwpFzsLihIo=
X-Google-Smtp-Source: AGHT+IE1QkKcBHxJqbhffV3fi3mCdasHAS6LUeQMM/2Scc3A+uq4eIPgDRVGvdKu+jS1jth8EFZV1Q==
X-Received: by 2002:a0d:cc0a:0:b0:59b:e622:f820 with SMTP id
 o10-20020a0dcc0a000000b0059be622f820mr1194437ywd.13.1695427578190; 
 Fri, 22 Sep 2023 17:06:18 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net.
 [173.79.56.208]) by smtp.gmail.com with ESMTPSA id
 a198-20020a0dd8cf000000b0059b3c406af3sm1168006ywe.82.2023.09.22.17.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 17:06:17 -0700 (PDT)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 Gregory Price <gregory.price@memverge.com>
Subject: [PATCH v2] cxl/vendor: update niagara to only build on linux,
 add KConfig options
Date: Fri, 22 Sep 2023 20:05:44 -0400
Message-Id: <20230923000543.598681-1-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=gourry.memverge@gmail.com; helo=mail-yw1-x1144.google.com
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

Niagara uses <sys/shm.h> which presently limits its compatibility to
linux hosts.  Change build to only build it on linux.

Add Kconfig file for skhynix directory, and make niagara depend on
CXL_MEM_DEVICE and LINUX.  Add an explicit flag for niagara.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 hw/cxl/Kconfig                    | 2 ++
 hw/cxl/vendor/Kconfig             | 1 +
 hw/cxl/vendor/skhynix/Kconfig     | 4 ++++
 hw/cxl/vendor/skhynix/meson.build | 2 +-
 4 files changed, 8 insertions(+), 1 deletion(-)
 create mode 100644 hw/cxl/vendor/Kconfig
 create mode 100644 hw/cxl/vendor/skhynix/Kconfig

diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
index dd6c54b54d..88022008c7 100644
--- a/hw/cxl/Kconfig
+++ b/hw/cxl/Kconfig
@@ -1,3 +1,5 @@
+source vendor/Kconfig
+
 config CXL
     bool
     default y if PCI_EXPRESS
diff --git a/hw/cxl/vendor/Kconfig b/hw/cxl/vendor/Kconfig
new file mode 100644
index 0000000000..aa23bb051b
--- /dev/null
+++ b/hw/cxl/vendor/Kconfig
@@ -0,0 +1 @@
+source skhynix/Kconfig
diff --git a/hw/cxl/vendor/skhynix/Kconfig b/hw/cxl/vendor/skhynix/Kconfig
new file mode 100644
index 0000000000..20942cffc2
--- /dev/null
+++ b/hw/cxl/vendor/skhynix/Kconfig
@@ -0,0 +1,4 @@
+config CXL_SKHYNIX_NIAGARA
+    bool
+    depends on CXL_MEM_DEVICE && LINUX
+    default y if CXL_VENDOR
diff --git a/hw/cxl/vendor/skhynix/meson.build b/hw/cxl/vendor/skhynix/meson.build
index 4e57db65f1..e3cb00e848 100644
--- a/hw/cxl/vendor/skhynix/meson.build
+++ b/hw/cxl/vendor/skhynix/meson.build
@@ -1 +1 @@
-system_ss.add(when: 'CONFIG_CXL_VENDOR', if_true: files('skhynix_niagara.c',))
+system_ss.add(when: 'CONFIG_CXL_SKHYNIX_NIAGARA', if_true: files('skhynix_niagara.c',))
-- 
2.39.1


