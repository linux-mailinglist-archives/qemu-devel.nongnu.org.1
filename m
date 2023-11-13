Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFC97E9FDD
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 16:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Yle-0002Zl-25; Mon, 13 Nov 2023 10:22:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2Ylb-0002Pc-95
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:23 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2YlZ-0003M6-DC
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 10:22:22 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54366784377so7100264a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 07:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699888940; x=1700493740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z2PpOM4WQ+uf4xck1acJwuABeC89nz7da2f3K2pGLBg=;
 b=zZx560CPsEtb9gZnwa4WxxXrwQE9eZnw0afxDwhIYX7hb4Bnifd1rKltMUIfd2iIAo
 L+CGC+nMOUOxlszSVNoD8+V/HKBiJZrl+rUIQ8GNalDSDDCkmkuUSDPlLquKPytLwYvM
 kRzWLIeMquYgUIP/jByLi0p6YwAiG4Ewc5U2zw8EKOyllDGX5IlL3JvYLmG0KRX+Dmcc
 Yp/own6p0kHe5xSz3aH13IWvCZIcG0/xi0d5htTO8La3o+Djms9r1uKDbwoEpDQuElGz
 woDUgO4q1Jea0XTg80byqFFiu+1oa0nUf7vaC9JEoxCtxmLjxIHMiY6jWmBHXlReADEA
 Y/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699888940; x=1700493740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z2PpOM4WQ+uf4xck1acJwuABeC89nz7da2f3K2pGLBg=;
 b=DWWV318demEH1wZ9nz55dD2ZoL2ZSZhcnmhP6GBPnpnlKe5pwK6xQPiWTK9gk+Rn+z
 dLrq/yxBYYnXlmLjPbQSpqfP+M+J6v5nbLp1Na4P1h3Qsbs2r1a47IsLJWh+834n+dUM
 0pKkonKJuYfABxGzjqei5Qug5zD68QlU4MJ346R6m/WGstOnwghLX8rOO1FgzIs5mBPA
 a1mRDTzlyXHH9tBY0xcCHxde/ogUJpkrzIOmuhN46Y9rrhrTbXkL1o4xn/wgzvjcNd5g
 a8yD5WhNux785+0xrKBOvboiS++EuJtPjv6Hqd83gCG62T1PegRLiehmtSfMM+kk9wd8
 x5lQ==
X-Gm-Message-State: AOJu0YxE1kj9LkkfExzGVHPl7VK9LZ8vjfKpJ63fsp2La8ArHJYzfkbi
 f3p58pjGmj4hoMSQWMz2bmTIaA==
X-Google-Smtp-Source: AGHT+IFN0oQYvnRoNATsOZJ25LMlTXynSPofCu2en/Z0LYSJQyfcBbtJzfmWQwHuJeMUC7biyDShHw==
X-Received: by 2002:a17:906:f2c3:b0:9bd:a738:2bfe with SMTP id
 gz3-20020a170906f2c300b009bda7382bfemr5045867ejb.38.1699888940071; 
 Mon, 13 Nov 2023 07:22:20 -0800 (PST)
Received: from m1x-phil.lan ([176.164.221.204])
 by smtp.gmail.com with ESMTPSA id
 lw27-20020a170906bcdb00b009de11bcbbcasm4238875ejb.175.2023.11.13.07.22.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 07:22:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH-for-9.0 10/10] hw/xen: Have most of Xen files become
 target-agnostic
Date: Mon, 13 Nov 2023 16:21:13 +0100
Message-ID: <20231113152114.47916-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113152114.47916-1-philmd@linaro.org>
References: <20231113152114.47916-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

Previous commits re-organized the target-specific bits
from Xen files. We can now build the common files once
instead of per-target.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/xen/meson.build          |  2 +-
 hw/block/dataplane/meson.build |  2 +-
 hw/xen/meson.build             | 13 ++++---------
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/accel/xen/meson.build b/accel/xen/meson.build
index 002bdb03c6..455ad5d6be 100644
--- a/accel/xen/meson.build
+++ b/accel/xen/meson.build
@@ -1 +1 @@
-specific_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
+system_ss.add(when: 'CONFIG_XEN', if_true: files('xen-all.c'))
diff --git a/hw/block/dataplane/meson.build b/hw/block/dataplane/meson.build
index 025b3b061b..4d8bcb0bb9 100644
--- a/hw/block/dataplane/meson.build
+++ b/hw/block/dataplane/meson.build
@@ -1,2 +1,2 @@
 system_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-blk.c'))
-specific_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
+system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-block.c'))
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index d887fa9ba4..29adfadd1c 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -9,15 +9,12 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
 
 system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-operations.c',
+  'xen-hvm-common.c',
+  'xen-mapcache.c',
 ))
 
-xen_specific_ss = ss.source_set()
-xen_specific_ss.add(files(
-  'xen-mapcache.c',
-  'xen-hvm-common.c',
-))
 if have_xen_pci_passthrough
-  xen_specific_ss.add(files(
+  system_ss.add(files(
     'xen-host-pci-device.c',
     'xen_pt.c',
     'xen_pt_config_init.c',
@@ -26,7 +23,5 @@ if have_xen_pci_passthrough
     'xen_pt_msi.c',
   ))
 else
-  xen_specific_ss.add(files('xen_pt_stub.c'))
+  system_ss.add(files('xen_pt_stub.c'))
 endif
-
-specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
-- 
2.41.0


