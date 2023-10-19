Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6597D03E9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:24:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaSl-0001ne-MF; Thu, 19 Oct 2023 17:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSj-0001li-He
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaSh-0007Tu-DY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:21:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32db188e254so118275f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750505; x=1698355305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Uqmm3m3Xcd+zvR1iddhK9/QmBkavMbkqN5KlvzSqTU=;
 b=MIYkml7KYZkx+3w0lu61gbISPbSCcVu4sRqYo3dFOWzbYR9stkZOBK2UQvel7iqelg
 3HYtEw0Uzsxjd10iOC3HkdCoznK5Za4pnFUkou35iN5mvMGpY2jvd83oK/cxZCtkPgVi
 QaU2W8AglAaHa74tpJsUmsQl42CztsUNzZYvPs1ofy0YILHTvy8oSNd3p3zspDEm8YA5
 pIEah1qSbRx+bkYopjeRBLCCRiSJsB/8JtrpmHZwBlH9LU0y2aHadSQR5mBtN30wEUTc
 Imhnj52R7+pszYqO65rpFQerd/5hE8jkbRw3GjNJ0UFFs0kK4xwPEHbiNO+NetaPxPgv
 qUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750505; x=1698355305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Uqmm3m3Xcd+zvR1iddhK9/QmBkavMbkqN5KlvzSqTU=;
 b=Kj8vvpTraetxX2+2jLNTGfuMenyzT3+qFm/ysdvQV84yvmFFqsnhNxjEtZHIRL9oxG
 BNJRXVEuJmS+KaTQGEUGiR3YdFbfckkMegUYyBty0pWz+tpRYoosuYIzVJmQKBNveCVX
 ikn3Rb+1A5KDBOFaOdGkUPtOTRFB8DN3QFQ10/EcAAmo14+UqqZqq3Fqxu56VqbHjJmf
 HD9ZiCmZxXYLWanE4J9Y94lfiE5DqW3DT37r9TtFKLkMYMEPYRzRP0gOOuKvVcvJ33TX
 IfSZgF3mnC4USrbqnbHnL8Ap0OtR6gjcOU8QK03Gz5y04tCJiD99jp+oJUVfqGyUfXVf
 BluA==
X-Gm-Message-State: AOJu0YxgaMkF3bS4ZooFDskIgAHz+Y6LKvdeoyMM4HZ+uH79C9PlD6a2
 amv855FMY1Wq0W2g7p4ZSAqd8r0okn3SFxSaD6Cuzg==
X-Google-Smtp-Source: AGHT+IEwzKkX8LFhEZI+vqOUmzVPnLCvzfQ69bkpApCv1HI6EZjTraOgZ4t0LQmsTLBw16Lsh3mCzw==
X-Received: by 2002:a05:6000:71e:b0:32d:a68d:3fb6 with SMTP id
 bs30-20020a056000071e00b0032da68d3fb6mr2535775wrb.50.1697750505383; 
 Thu, 19 Oct 2023 14:21:45 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b00318147fd2d3sm222792wrw.41.2023.10.19.14.21.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:21:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 31/46] hw/i386/amd_iommu: Do not use SysBus API to map local
 MMIO region
Date: Thu, 19 Oct 2023 23:17:56 +0200
Message-ID: <20231019211814.30576-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
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

There is no point in exposing an internal MMIO region via
SysBus and directly mapping it in the very same device.

Just map it without using the SysBus API.

Transformation done using the following coccinelle script:

  @@
  expression sbdev;
  expression index;
  expression addr;
  expression subregion;
  @@
  -    sysbus_init_mmio(sbdev, subregion);
       ... when != sbdev
  -    sysbus_mmio_map(sbdev, index, addr);
  +    memory_region_add_subregion(get_system_memory(), addr, subregion);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231018141151.87466-2-philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 8d0f2f99dd..7965415b47 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1579,9 +1579,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     /* set up MMIO */
     memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
                           AMDVI_MMIO_SIZE);
-
-    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
-    sysbus_mmio_map(SYS_BUS_DEVICE(s), 0, AMDVI_BASE_ADDR);
+    memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
+                                &s->mmio);
     pci_setup_iommu(bus, amdvi_host_dma_iommu, s);
     amdvi_init(s);
 }
-- 
2.41.0


