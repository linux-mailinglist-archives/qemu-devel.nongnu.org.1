Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA982B29F
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 17:17:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxjk-0006wi-HP; Thu, 11 Jan 2024 11:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNxjh-0006s2-KL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:16:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNxjf-0005WX-UD
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 11:16:53 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e6275e9beso2296295e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704989810; x=1705594610;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rmtj7VR3QACBvsppTX7iiIn7vor5KVmAe+fOMphCBqE=;
 b=A95LPq50u+Jh0F9uvnEGM1KzgEouH4/NvVzABrAVYRTUSsZvY+x/uxxMCeMxwax9pB
 yoJMl9P+OInxPAzfIyawio94m9UKBdgxdPOyyQjszmBsLqLWEnoS4xOgZPpD/rnhWaZV
 jFFGYogaj2X0JFWCqacleFgtqzB8SnqF+Z1/0i9T2fTrZpPxGk0zl9qKmicPn+gRId0P
 C+uzON9Qy9aFmJ+RA2dRYYkuMdWCYCWYG15vknUNJecEtpLhD5oGRdFg7gGsuCPaip/H
 wUrDmXD7dNKY4PvrpBzfvKP7d2e59yYpvM2sIv8S7PiX8R1nKuCEZssMKfZmpdRyOVGR
 46Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704989810; x=1705594610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rmtj7VR3QACBvsppTX7iiIn7vor5KVmAe+fOMphCBqE=;
 b=QJ7L3vIDosYfnFvj42oAi7cQaE77L8gX8GJgehyMHeZmavFwaxaLilDUKYx5LdJgbd
 aFHXCBVZZpYQg8VSkrwczgzbp19prrgSaRhxejhc8haNyIK+A4Ej7pnIXW6kC1MEavEM
 4PakHGRg1o8gaLmQ7X39sMXlU899TGwbh3pRc4/JEySqiQuqakx32QzwAva2xInCWu51
 1hyXpqhjooE4VW8v+dGnWIQK5b4aiInhwzvUg9ele58AifpxDQC3RBPZm1E1zOfuJ9Gx
 1mEfICPFwvooiHZ6mpEcU7RXKYEcSk9VKd/onqRWLw2YCh1X44MatzIHQ+ZJciKnu8rN
 YsnA==
X-Gm-Message-State: AOJu0YwC1FxsIPpQ4y48hrGDoQktU03UUi1tPf+dWu06g2oqeqIsRqrk
 G0j6HEF+uzGcBVT2sKTsSPnQbiDDAZIropInPkeW1zH3XZbfMQ==
X-Google-Smtp-Source: AGHT+IHZpOtvn58I+SfApDCi0aNKlKb0AyZ/mDtbUagqwdgfaTAYK8J9ro1OLd482VUgjCSiRDBHcQ==
X-Received: by 2002:a05:600c:4f43:b0:40e:6194:ccfa with SMTP id
 m3-20020a05600c4f4300b0040e6194ccfamr509838wmq.6.1704989809607; 
 Thu, 11 Jan 2024 08:16:49 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 f18-20020adffcd2000000b0033642a9a1eesm1553183wrs.21.2024.01.11.08.16.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 08:16:48 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v2 2/2] target/riscv: Add step to validate 'B' extension
Date: Thu, 11 Jan 2024 16:16:44 +0000
Message-ID: <20240111161644.33630-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111161644.33630-1-rbradford@rivosinc.com>
References: <20240111161644.33630-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

If the B extension is enabled warn if the user has disabled any of the
required extensions that are part of the 'B' extension. Conversely
enable the extensions that make up the 'B' extension if it is enabled.

Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 5396c6c3eb..b5ba78240e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -442,6 +442,35 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
     }
 }
 
+static void riscv_cpu_validate_b(RISCVCPU *cpu)
+{
+    const char *warn_msg = "RVB mandates disabled extension %s";
+
+    if (!cpu->cfg.ext_zba) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zba))) {
+            cpu->cfg.ext_zba = true;
+        } else {
+            warn_report(warn_msg, "zba");
+        }
+    }
+
+    if (!cpu->cfg.ext_zbb) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbb))) {
+            cpu->cfg.ext_zbb = true;
+        } else {
+            warn_report(warn_msg, "zbb");
+        }
+    }
+
+    if (!cpu->cfg.ext_zbs) {
+        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zbs))) {
+            cpu->cfg.ext_zbs = true;
+        } else {
+            warn_report(warn_msg, "zbs");
+        }
+    }
+}
+
 /*
  * Check consistency between chosen extensions while setting
  * cpu->cfg accordingly.
@@ -455,6 +484,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         riscv_cpu_validate_g(cpu);
     }
 
+    if (riscv_has_ext(env, RVB)) {
+        riscv_cpu_validate_b(cpu);
+    }
+
     if (riscv_has_ext(env, RVI) && riscv_has_ext(env, RVE)) {
         error_setg(errp,
                    "I and E extensions are incompatible");
-- 
2.43.0


