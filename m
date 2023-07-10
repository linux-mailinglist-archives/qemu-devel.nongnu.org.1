Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F3E74D2D1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:06:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInln-0001WM-R2; Mon, 10 Jul 2023 06:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInlm-0001WA-6U
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:05:26 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInlg-0001yd-RT
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:05:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-314172bac25so4089510f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688983518; x=1691575518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwQW/gq4UyCSctLiWA3Tu8H5hFtvtJMWJauTX+1QKic=;
 b=nIEtX0DT4DxlLF/T9WiXr0t/fiCC83PfonPEivviNBajMMSFQYtHORSX5DOEYyx1lM
 r9RtwSW5X+mBm1eJg6Ue4phP8Cre9I53ihOumVerO7Ic2PudqGHR3iQ5caXDEKnScOqf
 Z5NK4shvFNzSuVHFRjy/mcY4c5Ahs6skhQWliRkn1AWlqKD3NWsQ8yB/A/MyFI9C0CQt
 USYOsIV8QKLIfo+rRBlBilTBBPNLbwrSZvHMYg+hVCAZE/x+2d1Atsfqijp2gAVnxTsH
 wV88mzAPtB9irh3APc2jzEmGBHoO4heFKihjw+FG19Q5nKOdWZdZ89YQqRyw5RWJSMJ2
 wOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688983518; x=1691575518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iwQW/gq4UyCSctLiWA3Tu8H5hFtvtJMWJauTX+1QKic=;
 b=leoegoYW5DvNDyZrkbVSE2o/ZfW7SmJnr48YFdfQFYKwDym1tB6l3AddhhocyVxKQa
 SxTGyoUVQ/bvfUmkZy9nlBJB480DpV+Y30gNZ3LtFgPNB4XWDYAnqUcBQaRFwBzdSe5y
 qKU14W5SLh0QtXq4MWGC67Mwa3uik3ygALuZeNTMaKSdo912hY0/O2hK3guFfM4Kv+se
 HR/MngvzTTE9xU2HM9KtT+0eOKr4OSSnDuXtJiuR+OiviZntfSDYoC67LHKIbCrIBoTf
 /LzGGhzvKrhq1xLqE6r6O3Bvo4g/gznqUgR/gBGhAheIPU99JYNQP2UtF9lLt2TiCEbR
 J8Qg==
X-Gm-Message-State: ABy/qLa7Opjici4unT9Vjy/1541inQYaPDCE3vII672kuh5r3TOZZvk3
 qw/02SyQKqNoRuwVwVJeLG9bHQ==
X-Google-Smtp-Source: APBJJlFgmnuVGGYprIqilGwRnnvZUg9pNcclM9BN/EjJEYLu9++IhtVl+8GSprsDv81PuDCZGHJSBA==
X-Received: by 2002:a5d:6501:0:b0:313:e456:e64a with SMTP id
 x1-20020a5d6501000000b00313e456e64amr10155707wru.21.1688983518162; 
 Mon, 10 Jul 2023 03:05:18 -0700 (PDT)
Received: from localhost.localdomain (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 f17-20020adfe911000000b0031416362e23sm11295659wrm.3.2023.07.10.03.05.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 03:05:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: 
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 6/6] hw/virtio/meson: Rename softmmu_virtio_ss[] ->
 system_virtio_ss[]
Date: Mon, 10 Jul 2023 12:05:10 +0200
Message-Id: <20230710100510.84862-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
References: <20230710094931.84402-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Similarly to commit de6cd7599b ("meson: Replace softmmu_ss
-> system_ss"), rename the virtio source set common to all
system emulation as 'system_virtio_ss[]'. This is clearer
because softmmu can be used for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/meson.build | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index 900864c1be..7a36eabb39 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -1,28 +1,28 @@
-softmmu_virtio_ss = ss.source_set()
-softmmu_virtio_ss.add(files('virtio-bus.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
-softmmu_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
+system_virtio_ss = ss.source_set()
+system_virtio_ss.add(files('virtio-bus.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_PCI', if_true: files('virtio-pci.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_MMIO', if_true: files('virtio-mmio.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-crypto.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VSOCK_COMMON', if_true: files('vhost-vsock-common.c'))
+system_virtio_ss.add(when: 'CONFIG_VIRTIO_IOMMU', if_true: files('virtio-iommu.c'))
+system_virtio_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev.c'))
 
 specific_virtio_ss = ss.source_set()
 specific_virtio_ss.add(files('virtio.c'))
 specific_virtio_ss.add(files('virtio-config-io.c', 'virtio-qmp.c'))
 
 if have_vhost
-  softmmu_virtio_ss.add(files('vhost.c'))
+  system_virtio_ss.add(files('vhost.c'))
   specific_virtio_ss.add(files('vhost-backend.c', 'vhost-iova-tree.c'))
   if have_vhost_user
     specific_virtio_ss.add(files('vhost-user.c'))
   endif
   if have_vhost_vdpa
-    softmmu_virtio_ss.add(files('vhost-vdpa.c'))
+    system_virtio_ss.add(files('vhost-vdpa.c'))
     specific_virtio_ss.add(files('vhost-shadow-virtqueue.c'))
   endif
 else
-  softmmu_virtio_ss.add(files('vhost-stub.c'))
+  system_virtio_ss.add(files('vhost-stub.c'))
 endif
 
 specific_virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-balloon.c'))
@@ -65,7 +65,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_VDPA_DEV', if_true: files('vdpa-dev-pci.c'
 
 specific_virtio_ss.add_all(when: 'CONFIG_VIRTIO_PCI', if_true: virtio_pci_ss)
 
-system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: softmmu_virtio_ss)
+system_ss.add_all(when: 'CONFIG_VIRTIO', if_true: system_virtio_ss)
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('vhost-stub.c'))
 system_ss.add(when: 'CONFIG_VIRTIO', if_false: files('virtio-stub.c'))
 system_ss.add(when: 'CONFIG_ALL', if_true: files('vhost-stub.c'))
-- 
2.38.1


