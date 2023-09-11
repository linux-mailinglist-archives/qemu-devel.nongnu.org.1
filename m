Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC33879A865
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 15:55:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfhMT-0005kF-0j; Mon, 11 Sep 2023 09:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMQ-0005hd-CB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:54 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfhMH-00039v-Kj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 09:53:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so4479569f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 06:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694440424; x=1695045224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BQa+831csKF+bLc07F+cF6xTN80jpivchM4xDwQv7Wg=;
 b=i7jN4E+xn3ChVmvTKzK7XyPrWahNIfoD4Wtu2UQCTtR4Oa4x2N6UfCYkoGAp5BArQD
 bVjcAfAeDxnSIGGUJ8jA6LPjdBaKdU5aLjs4r9QY24Ayxi7VRTKFtg5SP6AJs83aU8we
 86pU5I0urg49xgijpiVl9firM3XZ4Hk35ySjuhH7HEfQdzn5By6zbTT93ai4+UKAWSgx
 J4BX/B71hU+tyyC36RBmCIS0veVl53ZQ/HiLUeC7DYykd5GAWAsfNHKo1PBVvkIpj9xQ
 TketVJnYfjo1HxWUOH8PrvhRK0nn+/d2DNDgb0iS8fDT46yAJwyaRjvt2ZABHjLwZNtk
 pq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694440424; x=1695045224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BQa+831csKF+bLc07F+cF6xTN80jpivchM4xDwQv7Wg=;
 b=cUAvYUdzEIP4Jxj5/eGkMCkhKMNyNATpUFNKZZb9IUmxMMxd0/xgFdiwb+12KDJ/Lz
 2lUPc+3SpWizawNvXV5aJyaR4WNDbbe9IBdoLL0/nbgk+m1qii98ifCeQ0QtIcksKvOw
 kHAIUHRGHTBJ+7FrgLqhnKWBVvNbh7E1e0ZBxkA+87uMB3nck+1+7aGtav/gKx+ByuIG
 u5bcTKtXv/jlZJe5oAkgeCm29Hgln1m0eWE6koopKupSvYh7zu4SKkdYiwpgzIzGNQHu
 wAGow/KkKMv3/RARV6glUojKsOQxcFaz7GedmGwFYdBH8py9Hh8QDMCA6UiCBxclvfip
 yeMw==
X-Gm-Message-State: AOJu0YwPi991b8L6++REKTAIvZq1RC9hf4ocJTe+2QODGUpGIMCEZzVe
 zeuh32zeJNwl4rPHY1MOHgYJEg==
X-Google-Smtp-Source: AGHT+IF0vruuZObRlAc9HjoC+jabvKHcimNuOxSVhJZZEtLCMa8hxhzzQm90a/HuQA2ZXGRZ9JDOpg==
X-Received: by 2002:adf:e10c:0:b0:319:85e2:6972 with SMTP id
 t12-20020adfe10c000000b0031985e26972mr7262992wrz.42.1694440423833; 
 Mon, 11 Sep 2023 06:53:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm10079758wrq.49.2023.09.11.06.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 06:53:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/7] linux-user/elfload.c: Correct SME feature names reported
 in cpuinfo
Date: Mon, 11 Sep 2023 14:53:35 +0100
Message-Id: <20230911135340.1139553-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911135340.1139553-1-peter.maydell@linaro.org>
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Some of the names we use for CPU features in linux-user's dummy
/proc/cpuinfo don't match the strings in the real kernel in
arch/arm64/kernel/cpuinfo.c. Specifically, the SME related
features have an underscore in the HWCAP_FOO define name,
but (like the SVE ones) they do not have an underscore in the
string in cpuinfo. Correct the errors.

Fixes: a55b9e7226708 ("linux-user: Emulate /proc/cpuinfo on aarch64 and arm")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5b28fa3e7a..5ce009d7137 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -844,13 +844,13 @@ const char *elf_hwcap2_str(uint32_t bit)
     [__builtin_ctz(ARM_HWCAP2_A64_RPRES        )] = "rpres",
     [__builtin_ctz(ARM_HWCAP2_A64_MTE3         )] = "mte3",
     [__builtin_ctz(ARM_HWCAP2_A64_SME          )] = "sme",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "sme_i16i64",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "sme_f64f64",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "sme_i8i32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "sme_f16f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "sme_b16f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "sme_f32f32",
-    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "sme_fa64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I16I64   )] = "smei16i64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F64F64   )] = "smef64f64",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_I8I32    )] = "smei8i32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F16F32   )] = "smef16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_B16F32   )] = "smeb16f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_F32F32   )] = "smef32f32",
+    [__builtin_ctz(ARM_HWCAP2_A64_SME_FA64     )] = "smefa64",
     };
 
     return bit < ARRAY_SIZE(hwcap_str) ? hwcap_str[bit] : NULL;
-- 
2.34.1


