Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C637CFB40
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCP-00027B-0e; Thu, 19 Oct 2023 09:36:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBg-0001pP-Hn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:45 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBd-0001CF-Ji
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:35:44 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c509d5ab43so94425521fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722540; x=1698327340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J9OnLBnDoo/08QPEMHukIoyH0/rkRW/kfDrQtjUrlpQ=;
 b=Ntw4t4perC39Bl9AyjUv7VHDIaTlLG6kLtkNdyn4vMOf9oIXKoKBFpaUgDdTkTTBdU
 GHeP/OESnSedqMC2rqT+4oQ+yvyM0Yzbe+Aoifq1LJHpGf4s/zhOwfksfyQB3o+Mn6nx
 6Cy2kACPccPTaBeDk8l1z874FYBdgOvZdJZEld5JJw9hi41Pvl/8GCfaoCII8L5WGEvl
 uFYYtloZh4ODYUh9Zy7Y++bV5m8XzW6WdA5IKMHkHrzM/sFNxItGslRZTKy+SLkWdfDC
 KskBA3UssJHbDCH8oTxsQjOLzaaQvOSZACY7tDnv5TdpaWoq2xVVSXFqnLFfmro5WtjV
 YXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722540; x=1698327340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9OnLBnDoo/08QPEMHukIoyH0/rkRW/kfDrQtjUrlpQ=;
 b=UrkRTER+R7L2sFc7ksdKBFRE0Dy8A1SsNjj4cF/VVcnY7J25mfRkLEVB8TjBjmvF5z
 ZzIFtTBAAA/v1ncakmgeoxpHOHpNK5aUhMhS4Ur/aDVxgD6eRuo3nq7i9ytB1IM6NeTu
 4aU7bYd81ESAtfW2nm59CkQGb3RojcyqXxuM1kxheJnSGvKQxKfrOeHux74txS7fCPCS
 sV8ZVhs+OPvcQQiBuFEgr9yks44ZbseeT+dMMxchlwWyVxJdK4Yj7Wu8DZ2abr7U9XDu
 GqbGU0ikT5OUReTNC2fmWaCiQQHhiR2Chb3dycyyr0cSxBRsSFapa6LrsDQ7oXQelpCn
 eF5w==
X-Gm-Message-State: AOJu0Yz9DU9atR2rJ9YemYxDGgKgeMHpFoFqizaYLj/B9NjMVzHypWzq
 KCEp8BkL5wpWEy0AsfychuzuCqxdFSP0m9LQ4+g=
X-Google-Smtp-Source: AGHT+IHhxBzJvJpSIBv65dGeMWTlJ2lCtntQnv6LCKyQMEPXVhUAlJIbzq7gyc4yhP6RQxREskM+PQ==
X-Received: by 2002:a2e:9882:0:b0:2c5:15dc:ba99 with SMTP id
 b2-20020a2e9882000000b002c515dcba99mr1373807ljj.51.1697722539483; 
 Thu, 19 Oct 2023 06:35:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/24] hw/arm/exynos4210: Get arm_boot_info declaration from
 'hw/arm/boot.h'
Date: Thu, 19 Oct 2023 14:35:15 +0100
Message-Id: <20231019133537.2114929-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

struct arm_boot_info is declared in "hw/arm/boot.h".
By including the correct header we don't need to declare
it again in "target/arm/cpu-qom.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231013130214.95742-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/exynos4210.h | 2 +-
 target/arm/cpu-qom.h        | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 68db19f0cb7..d33fe385865 100644
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
index 514c22ced9b..d06c08a734e 100644
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
2.34.1


