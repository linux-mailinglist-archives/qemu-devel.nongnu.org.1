Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A37EB2B0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ubG-0007Zk-0x; Tue, 14 Nov 2023 09:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uaf-0005vY-IX
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:35 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uac-0008QL-AZ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:40:31 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9e623356e59so626970566b.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972829; x=1700577629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=85224ACu16xcahxMJd73na2pr08geUP2BaqK8DQk41g=;
 b=B4hc9vTee9sMf3O9bj8e9LTD5nUPdAn+KpWQ6bP/RGLCp5XSc5a3OvLxUFY7tMxUjz
 N3EOVmC8FjiIzw3QwwgatIR4akxeplMc+OwiHqY3bmxlaWtvk6iJcFmX7Et1i3uMqgkv
 pIIVh9BxAnKLmTkMSreVe7SdJNRFhRcg6FpElBAvQ2J3N8BP3uWRoF1CDuA/HW1o9NU5
 Ny49uBppdO0ut+7JSEYkmagqQiFr8LjMI0AfRcA9aFuyrPppCVIwDJFQ8memp6BAjdqy
 KgmadK7JvKHkNdBGRz8/JBVR4FZaYn3gTVE0weBVR11n+iG9zrhQCVe7pl/vK4m/Nj6l
 6uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972829; x=1700577629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85224ACu16xcahxMJd73na2pr08geUP2BaqK8DQk41g=;
 b=LRoP5XQv/Njy9/BB434GfelqW4hDATRtGIHzcL2o6k8Fhbno5ImJ6MxJ7GIS5ccEJP
 XxDY+LG2j0upHqXKxljGu6QRIP2HukHcrWk46MhVUCzyw5Fb6o7/xvi2ZrDNWVu/xiOW
 LAvmnkjZpYxZbnA9HUCdTeiMnhC/baMVvdKlgypxHliOAII2Iazqua5kjbXH8ogyBViW
 phTryL1wX2UGHYvetKVs90S/4AiozeJ18sJB5lTKsajk8BR8QhoVSbjEEy1QBBOA7Asp
 jOzMy9VRjbieAz10Gwaqhs3VYhh1azKetsibFuptuhQTuUrpMsJP7gsUMQnYgNLlPTuL
 QXxQ==
X-Gm-Message-State: AOJu0YxCkCt7UVW5mF8x5wrm6Apys4Vluu3lGrC3gCXXFUBtLxBYL1Ep
 4pEIlsnM0EfjZWVKTe9V5HnU10w3va6xuAw2c2g=
X-Google-Smtp-Source: AGHT+IE4fe4f8bleIo+ydEdJnHpXElyEFzfSvfuN7IjKmK4sPC2Xb+6oIBNsyuQ4jtW9IDSYhgY52Q==
X-Received: by 2002:a17:907:969f:b0:9eb:af0e:39da with SMTP id
 hd31-20020a170907969f00b009ebaf0e39damr3096379ejc.46.1699972828864; 
 Tue, 14 Nov 2023 06:40:28 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 t25-20020a1709066bd900b0099c53c4407dsm5561943ejs.78.2023.11.14.06.40.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:40:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: David Woodhouse <dwmw@amazon.co.uk>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH-for-9.0 v2 19/19] hw/xen: Have most of Xen files become
 target-agnostic
Date: Tue, 14 Nov 2023 15:38:15 +0100
Message-ID: <20231114143816.71079-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114143816.71079-1-philmd@linaro.org>
References: <20231114143816.71079-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Only 4 files call libxen API (thus its CPPFLAGS):
- xen-hvm-common.c,
- xen_pt.c, xen_pt_graphics.c, xen_pt_msi.c

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Reworked since v1 so dropping David's R-b tag.
---
 accel/xen/meson.build          |  2 +-
 hw/block/dataplane/meson.build |  2 +-
 hw/xen/meson.build             | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 13 deletions(-)

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
index d887fa9ba4..403cab49cf 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -7,26 +7,25 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
   'xen_pvdev.c',
 ))
 
-system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+system_ss.add(when: ['CONFIG_XEN'], if_true: files(
   'xen-operations.c',
-))
-
-xen_specific_ss = ss.source_set()
-xen_specific_ss.add(files(
   'xen-mapcache.c',
+))
+system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-hvm-common.c',
 ))
+
 if have_xen_pci_passthrough
-  xen_specific_ss.add(files(
+  system_ss.add(when: ['CONFIG_XEN'], if_true: files(
     'xen-host-pci-device.c',
-    'xen_pt.c',
     'xen_pt_config_init.c',
-    'xen_pt_graphics.c',
     'xen_pt_load_rom.c',
+  ))
+  system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
+    'xen_pt.c',
+    'xen_pt_graphics.c',
     'xen_pt_msi.c',
   ))
 else
-  xen_specific_ss.add(files('xen_pt_stub.c'))
+  system_ss.add(when: ['CONFIG_XEN'], if_true: files('xen_pt_stub.c'))
 endif
-
-specific_ss.add_all(when: ['CONFIG_XEN', xen], if_true: xen_specific_ss)
-- 
2.41.0


