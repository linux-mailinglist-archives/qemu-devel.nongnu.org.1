Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547917C8652
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHo8-0002oS-Rd; Fri, 13 Oct 2023 09:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHo6-0002nz-OU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:02:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHo4-0003mq-9H
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:02:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1277963a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697202137; x=1697806937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NXt4GRVCqNqLdB3FCLiLzM01NS8NIOi7cr1FVPF/4e0=;
 b=zfgfhLCWfyNaIeKfjHyOjGMz4vE2lUvtYb6zCcWGVjGGK40bPo+sVVTyECU1H26VfT
 VnbjtonZgqEPJdFBM94XgOFdq32j2DQ1bGbiO3Y8bDGunmu1xHNYJo/lndlrUku9XI4Q
 Gml3FgBbgqaKgo34gTCyRjIIycJlQWXTnUw6i6HSQMSkWzDmCy3DBbmzMWn2GUJl/gKH
 EULDWlykYwV0bJi8ndok1c7K8h3twbdtvm/pz9MePqUv7/72EMHfHRlrn+hrcKjRx5o+
 LFGxC+9SmSFJ3AQAyv8Vc0mf3hmiifZLLX+AINrNAMX+m6b26BQ419qY2+6ZJREtMCuP
 c0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697202137; x=1697806937;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXt4GRVCqNqLdB3FCLiLzM01NS8NIOi7cr1FVPF/4e0=;
 b=dcxXYwPzv17x5lZprehi863L+heWqSsuOlx6ovxSS3ovQQCmNwZqXpcnFL/TPY+OZO
 nn7wp8tWc8gXgxgnazuQAs9pczMMp9DRNorK8dmmX0uMUpD2ZyeVBjk7YKjEuqm92V07
 yIP0y7tB8Rkt10T4lboSo5dkcEn1wq3pt1q+AgAGlZP1hYA9Gofsp6j3Os04jlmSdBaM
 p6sKdTbNDUeNROQGC9OMygt8k5hnruHoZLCMchO2l3JjZmrkLzVoRcKKb/3NPi8qf2nO
 juIIAW//i7AZgfGmi++z2fF2rD71m6o9YJSgyrngchWYLMvAbFsu/irJ4H5TBspbuZw4
 kECA==
X-Gm-Message-State: AOJu0YwzdrohYuF1xejaOnAAyJPaRSvDTARSXLygzrOtwhztwbbjhbPT
 MRCPYjY3atkdFVVZDrdZDleKDYGc8jnJfeu9bNA=
X-Google-Smtp-Source: AGHT+IGcndhy5ooRlRyCwE/spVcgBuYrpCXGFSUiEgW5BxKgrfxYK8nOHHMCEz/dtnpjK+TYTIEQ9A==
X-Received: by 2002:aa7:d588:0:b0:525:6c9f:e1a3 with SMTP id
 r8-20020aa7d588000000b005256c9fe1a3mr23006574edq.20.1697202137472; 
 Fri, 13 Oct 2023 06:02:17 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 bx21-20020a0564020b5500b0053e163a1ca0sm1932929edb.1.2023.10.13.06.02.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 06:02:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/exynos4210: Get arm_boot_info declaration from
 'hw/arm/boot.h'
Date: Fri, 13 Oct 2023 15:02:14 +0200
Message-ID: <20231013130214.95742-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

struct arm_boot_info is declared in "hw/arm/boot.h".
By including the correct header we don't need to declare
it again in "target/arm/cpu-qom.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/exynos4210.h | 2 +-
 target/arm/cpu-qom.h        | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 68db19f0cb..d33fe38586 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -30,7 +30,7 @@
 #include "hw/intc/exynos4210_gic.h"
 #include "hw/intc/exynos4210_combiner.h"
 #include "hw/core/split-irq.h"
-#include "target/arm/cpu-qom.h"
+#include "hw/arm/boot.h"
 #include "qom/object.h"
 
 #define EXYNOS4210_NCPUS                    2
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 514c22ced9..d06c08a734 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -23,8 +23,6 @@
 #include "hw/core/cpu.h"
 #include "qom/object.h"
 
-struct arm_boot_info;
-
 #define TYPE_ARM_CPU "arm-cpu"
 
 OBJECT_DECLARE_CPU_TYPE(ARMCPU, ARMCPUClass, ARM_CPU)
-- 
2.41.0


