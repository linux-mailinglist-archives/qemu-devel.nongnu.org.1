Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052607C5560
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:26:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCx-0006zl-BZ; Wed, 11 Oct 2023 09:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCk-0006yc-3b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:50 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCi-0004Xa-3M
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:49 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso1161337666b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030686; x=1697635486; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vt2WyObBcXYTV0fWYbJQ/kflbk2DJaUNegSKAbPEgiM=;
 b=dUCz3A1ZFgX1nMyB2WH5QwKtHbffR+fXTYrPCHWWDW0a/L4ADy3xa+YGokmXLc/ISg
 HojO+YsJ1Qes5zOjb6ys2bNFhKta6i7/AfgLvugPHgokT9rcJbORcvKl62vdJVHm5hmK
 iKkWqhBFB9xrYtZ/vd1iEMsyyewRceiolMkwgmFrdCBn7VSJm0v1AjRO226jjN0lMJGN
 v+mKtzXTvN3LCQ1oKwIpJOf+BpZ84Swwst898NM/KdnlNq/kaIGkFCT8qUFi6oSS7XvU
 UVCPk6zTABuvW69mqkeP94H4wD0/CEHm2EU/pQAID/d1c5hn4tVvUTT2enIz3cRJzYP4
 qKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030686; x=1697635486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vt2WyObBcXYTV0fWYbJQ/kflbk2DJaUNegSKAbPEgiM=;
 b=HNowWQagG1hq25KEvfcHdQsMyAls3aqUnAKvL/yQ7mSDs7lsKFbgrK9TWNqSg3d5VH
 1ftnMzvyKHmHbswtt8XeF1EJBIyrQV1rS6NYc2SYHaf0L/Hp1hit8RdphVcDVcmy9Wbc
 G+cvhu1kz28c3NmBPceFh34VV7z29VgxYwJyKepU1FprlP0zcayhz7Kay4koPmY6+Maf
 nS5AkOCo2OfS4anEfrCaPspLyckcFiz2CvbFRddoQSBHrU6+U7YfTxD+/JsgQbMObYT3
 VVKTsgLVn3H8Z4yT6ymNMEsEN452CGxlHUYT4yME9HjaIcLc7k7xu0kTUlMKr8xB6Rb9
 xA/A==
X-Gm-Message-State: AOJu0Yxm/TO7x49J71GbTmgevg36qxzP8KX0EnHqd1w6ZNQYWGbIFOJD
 mTNEsQoHPEhutS/VVLuuI2d09aNMpj0i78f23Oc=
X-Google-Smtp-Source: AGHT+IEdKnztg6hM0RhCtHZhbJYckspGfwjXbqXEefCULT4cjRf4haR2BfxDMXbOYoM6/ex1dJk/hA==
X-Received: by 2002:a17:906:76d0:b0:9ae:43be:e5f5 with SMTP id
 q16-20020a17090676d000b009ae43bee5f5mr18677199ejn.4.1697030686453; 
 Wed, 11 Oct 2023 06:24:46 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 u25-20020a1709063b9900b0099bc2d1429csm9855908ejf.72.2023.10.11.06.24.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/ppc/ppc4xx_pci: Declare PPC4XX_PCI in Kconfig
Date: Wed, 11 Oct 2023 15:24:25 +0200
Message-ID: <20231011132427.65001-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011132427.65001-1-philmd@linaro.org>
References: <20231011132427.65001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/Kconfig | 4 ++++
 hw/ppc/Kconfig      | 2 +-
 hw/ppc/meson.build  | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index a07070eddf..a9030a433b 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -6,6 +6,10 @@ config XEN_IGD_PASSTHROUGH
     default y
     depends on XEN && PCI_I440FX
 
+config PPC4XX_PCI
+    bool
+    select PCI
+
 config RAVEN_PCI
     bool
     select PCI
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5dfbf47ef5..e4e76e87a2 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -53,7 +53,7 @@ config PPC440
 config PPC4XX
     bool
     select BITBANG_I2C
-    select PCI
+    select PPC4XX_PCI
     select PPC_UIC
 
 config SAM460EX
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..6931ba88b4 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -60,8 +60,8 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_pcix.c', 'ppc440_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
-  'ppc4xx_pci.c',
   'ppc4xx_sdram.c'))
+ppc_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
 ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
 # PReP
 ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
-- 
2.41.0


