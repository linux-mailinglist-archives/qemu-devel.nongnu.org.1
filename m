Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E99B78EE18
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhIA-0000X9-UJ; Thu, 31 Aug 2023 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhFG-00032r-TF
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhFB-0005Oo-Hi
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:57:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso7061175e9.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486668; x=1694091468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RGsHEuyFoG4D07fPwCyTopmI6+5DcT12Nv/vCGRvwBA=;
 b=jAK3cfG84TIOtj2LAh5tqKi6QMHrpgt/Y4R4eOj8QbIhIiKsSL1lfi+rKbgpN6iZjk
 dV2D+Jz7Y49hBx/OP0UsgNA0Fyh7GDJ63mnIruQmLrMZrRlCQ2qaqd3ozYkt28UQQgjr
 1P3B5wkR9XRv+h09TZc04anoAnDb8p6Ub1jD/+X/BrNRnE5hR3D7L3Ks54AICYoj01ys
 Jup516hQV0zQMzLSEH5uVhBMasEEdy+fs/u6xCTB5FZwtogwRLFh04waMXbXAX7dyrBm
 RVXtLbGMjLo3qmYXbSUXKljPEYbAeH10Aj5iqBV/xAeLnHC7F1TbvjFpbHELXxSKhZf8
 5UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486668; x=1694091468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RGsHEuyFoG4D07fPwCyTopmI6+5DcT12Nv/vCGRvwBA=;
 b=B3CNLd1dYpDV41vcYYTdK6n+Wul1dJchrU2KzVUuLXwX/aWqOghRjnTCFweNiyVQt2
 7tu4JMX17BU58kBOkj5RoI3voNVHRlmaHS1jZLxCLcaVMtF6SC94ug3GpK40y0VBsV7e
 k+yVQ4YvjYalvoPALnHYIPUqn2uITJ/i08NK1elmNZaqZmTHDlRZr4CoblsnvHgSb69K
 R1Jjqjmyga00eabkqCZm0Hd3iHe9MMMrtwVrAtsTB6QbH/IN6AxhpA8j5OkkOm90cN30
 e+ybMoMHLCb9fPelKt0tpG1qC7ItGPW6W530RSWpAtfVVIUheMJTQXDqjAKn0Gcgk6Jy
 wL/A==
X-Gm-Message-State: AOJu0Yytbrx1qZH7KEFWOde6g96KEszEteTWLD+wD4yoZKFHtO7zcKpd
 FSaGa4MwCL7oNLbVMrR5Fl9BUgjPKzlW0vipwYs=
X-Google-Smtp-Source: AGHT+IFchwuM8PgXwtvVitQFOAlj/Yyd7/TFYBsqNV6SL8Vm89km1iz/gH6nwnik6/HLFLRvC7+C4Q==
X-Received: by 2002:a05:600c:ac4:b0:3fe:1b4e:c484 with SMTP id
 c4-20020a05600c0ac400b003fe1b4ec484mr4008814wmr.5.1693486667797; 
 Thu, 31 Aug 2023 05:57:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a5d4f89000000b0031c5b380291sm2184139wru.110.2023.08.31.05.57.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:57:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PULL 10/41] target/translate: Include missing 'exec/cpu_ldst.h'
 header
Date: Thu, 31 Aug 2023 14:56:12 +0200
Message-ID: <20230831125646.67855-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

All these files access the CPU LD/ST API declared in "exec/cpu_ldst.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230828221314.18435-4-philmd@linaro.org>
---
 target/avr/helper.c                  | 1 +
 target/i386/tcg/fpu_helper.c         | 1 +
 target/i386/tcg/sysemu/excp_helper.c | 1 +
 target/loongarch/cpu.c               | 1 +
 target/mips/tcg/ldst_helper.c        | 1 +
 target/mips/tcg/msa_helper.c         | 1 +
 target/riscv/op_helper.c             | 1 +
 target/riscv/vector_helper.c         | 1 +
 8 files changed, 8 insertions(+)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index e6e7d51487..fdc9884ea0 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "hw/core/tcg-cpu-ops.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
 #include "exec/helper-proto.h"
 
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 6f3741b635..4430d3d380 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -21,6 +21,7 @@
 #include <math.h>
 #include "cpu.h"
 #include "tcg-cpu.h"
+#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "fpu/softfloat-macros.h"
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index b5f0abffa3..226689a4f2 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "tcg/helper-tcg.h"
 
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 27fc6e1f33..65f9320e34 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
+#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index c1a8380e34..97056d00a2 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -24,6 +24,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/memop.h"
 #include "internal.h"
 
diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 29b31d70fe..c8597b9e30 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "fpu/softfloat.h"
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 9cdb9cdd06..7e2f1908ee 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -23,6 +23,7 @@
 #include "internals.h"
 #include "qemu/main-loop.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 
 /* Exceptions processing helpers */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index bf7e0029a1..bc9e151aa9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/memop.h"
 #include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg-gvec-desc.h"
-- 
2.41.0


