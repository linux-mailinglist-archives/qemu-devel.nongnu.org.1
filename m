Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CA7E2027
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:39:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxQx-0001Kt-9d; Mon, 06 Nov 2023 06:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQT-000127-8t
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:49 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxQQ-0004KE-Cs
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:05:48 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32dcd3e5f3fso2648056f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268745; x=1699873545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TEM4y15WADC11ywrbeYDwNqe54vVpabH+nFuXXR9vo=;
 b=DDcTivuoAhQfj6RSh7yuR+7K2AVdOWgiSRdgQmx7FHUn6x1zjVndhc/DZ5JguQjKSv
 Zvm0vYst6JDUfzK8vte64voW1t4XR27Y/KQmk/uF8v4+BqztEWRyy1K9IYhKwUwLZafd
 gp4O97zNJz17/D79eT5mq44TvCzLUtt8WGshgY+1hiJplCe+Z/SjpNBTcPyI/VizUyOI
 azAlqlnFQ8UQIGf/H5fgEQtRO83SCdZpedowVPMVWeulvnM7XN2CwdmFRKYRz0KfpjKi
 9Ox+iOaXwobN6/nD2b6/6LXIvMkVjHeJ4QMtP7lwSxPClbGTKErtHQZXfX3aPjwfJP9Q
 XxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268745; x=1699873545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9TEM4y15WADC11ywrbeYDwNqe54vVpabH+nFuXXR9vo=;
 b=ZntkFLW4DCCZ+LnUcpYvjHwE10T0tj4QDlm6ogaU+VYAcPcxn2vulSh6wt/CSI3ljT
 Q5FBZiCMo/LQex0whaXrCXt/LZ5SL/1D5ZllXi0d5FjxcRSfsNo8sdkGgTJ+iQ5cAiQE
 893Og9ygDQY96bKJKWK8QbRWRGTmB4x55gQhl7FMSkFDuONARIZLI19bFyFX2CXnD8+D
 6IflnIA+uJur4uOmf3iv+8nIbYTd2Nr5WjHwTBCjkRRIBBvh/kYitHJXYD2UyjZ/XeXv
 t+63kiZzILHH2upnfCYpZIu1SwfVxiHOegdw+zEM9qMIdXix3wlGh8X4CGUn+eQpTGgH
 PYGg==
X-Gm-Message-State: AOJu0YzrAZVPCauKx1J5JWp/KiF1hedJuOpljcNbAboNnoT/b0WKiUMs
 BbsWMzutS4zuzejeMPU1Y3FEb6h5zxCs014CNb8=
X-Google-Smtp-Source: AGHT+IGOZ/6VrX2QMc3mxuvaPC+0EbE+IDekhwAIoTOTC+UFQrQ0DCYUI0TONme61tWRfDpdV25NAA==
X-Received: by 2002:a05:6000:1c0f:b0:32f:ba72:e80b with SMTP id
 ba15-20020a0560001c0f00b0032fba72e80bmr6504480wrb.54.1699268744791; 
 Mon, 06 Nov 2023 03:05:44 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adffb0c000000b0032fc5f5abafsm6040847wrr.96.2023.11.06.03.05.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:05:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 18/60] target/riscv: Move TYPE_RISCV_CPU_BASE definition to
 'cpu.h'
Date: Mon,  6 Nov 2023 12:02:50 +0100
Message-ID: <20231106110336.358-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

TYPE_RISCV_CPU_BASE depends on the TARGET_RISCV32/TARGET_RISCV64
definitions which are target specific. Such target specific
definition taints "cpu-qom.h".

Since "cpu-qom.h" must be target agnostic, remove its target
specific definition uses by moving TYPE_RISCV_CPU_BASE to
"target/riscv/cpu.h".

"target/riscv/cpu-qom.h" is now fully target agnostic.
Add a comment clarifying that in the header.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-12-philmd@linaro.org>
---
 target/riscv/cpu-qom.h | 8 +-------
 target/riscv/cpu.h     | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
index b78169093f..76efb614a6 100644
--- a/target/riscv/cpu-qom.h
+++ b/target/riscv/cpu-qom.h
@@ -1,5 +1,5 @@
 /*
- * QEMU RISC-V CPU QOM header
+ * QEMU RISC-V CPU QOM header (target agnostic)
  *
  * Copyright (c) 2023 Ventana Micro Systems Inc.
  *
@@ -44,12 +44,6 @@
 #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
 #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
 
-#if defined(TARGET_RISCV32)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
-#elif defined(TARGET_RISCV64)
-# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
-#endif
-
 typedef struct CPUArchState CPURISCVState;
 
 OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 144cc94cce..d832696418 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -34,6 +34,12 @@
 
 #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
 
+#if defined(TARGET_RISCV32)
+# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
+#elif defined(TARGET_RISCV64)
+# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
+#endif
+
 #define TCG_GUEST_DEFAULT_MO 0
 
 /*
-- 
2.41.0


