Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395F7D9BB8
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0C-0007GP-Ff; Fri, 27 Oct 2023 10:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0A-0007EA-2J
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO06-00088G-Vb
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:39:52 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40839652b97so15697895e9.3
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417589; x=1699022389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5nN8931Ig5rZThrt4B3zV/ATHc+m9uFhmxFhGMca0VQ=;
 b=b44j88mQgO7rZGMrEIYj4TZkVsFNyfu7EJritdJ6748mFPb1heoyaG5x1XPXf1pE8i
 paFcer6foke6J2zNTtsCsiA+R+yk14zTSLMVgzA6ONBZVhA1W+vFvL5u2zh2ZhVMW6xt
 2LW73LKQa0U+uiYvJEPWOacTnIrweQxxSArlBQxV9NNWBi99hLVVOJriOE4g386aUPg7
 Z8pXH6NQ8oezvnVsU9QQj86BpFE2e9xuT2Pmeh9ZZQwBJNPQwEv3JvvCU6Gbbc2vYR+Z
 vWKtGVY+LKS2q48wB1RQyhXLBsO2HNq2R9UTFTu+QqK/HF6YU8eCBX3Zp41Wh/TKOOiE
 OShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417589; x=1699022389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5nN8931Ig5rZThrt4B3zV/ATHc+m9uFhmxFhGMca0VQ=;
 b=b9+g1Gmdf+rc1midgOcln8WXs5G38B7XO1sUgp8UN4Az1RB10+HyICRM3HjqOT4Z6g
 OO5tku4Q4eUMV5xfmt7thH8sdXAYDV7TOlUOKqXsp15JWhqIuaygH6XEYczGZOY08toH
 JRvYDLiefUz4pgwBtgHkkZQ8RgND5niN64ue/hOXo6liDUIL3gr3slAV6X/2OfDZR02t
 WnREkh/f2KZ7qYZ59BDkv0kWJMlGw+owzh5DcY6zlOHx6V5zVPmKrRjnNG1jLr10gckk
 eO/5t9MRhuw0jaXlHAv2+RuuOVXejYeZA0Hcr81ynLPtZDhLKNTy/Fcd0CgeOqh0BjeG
 X8nQ==
X-Gm-Message-State: AOJu0YztpJr+vYfLRUEYJuZ4cM+38F13wkm8SL91kdx3nmXPrsbtiagG
 BEh51kxfQQUfRW0yGorBXdiCKfbRf61C0SSAtFs=
X-Google-Smtp-Source: AGHT+IFS/tHcEiJobyH38BY47OwvkOtMrwAkGap3jW9yxLlV6TSdYKYeoZikzKRSD+PU7dcyhbP6AQ==
X-Received: by 2002:a5d:6d85:0:b0:31f:f326:766b with SMTP id
 l5-20020a5d6d85000000b0031ff326766bmr2602391wrs.6.1698417589747; 
 Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
Date: Fri, 27 Oct 2023 15:39:13 +0100
Message-Id: <20231027143942.3413881-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

"hw/arm/boot.h" is only required on the source file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@amd.com>
Message-id: 20231025065316.56817-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-r40.h | 1 -
 hw/arm/bananapi_m2u.c          | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 72710d3edce..6e1ac9d4c13 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -21,7 +21,6 @@
 #define HW_ARM_ALLWINNER_R40_H
 
 #include "qom/object.h"
-#include "hw/arm/boot.h"
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 74121d89660..a7c7a9f96d7 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -26,6 +26,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
+#include "hw/arm/boot.h"
 
 static struct arm_boot_info bpim2u_binfo;
 
-- 
2.34.1


