Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB8E828AFD
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:20:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNFkx-0001vc-L0; Tue, 09 Jan 2024 12:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNFkv-0001uS-5M
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:19:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbradford@rivosinc.com>)
 id 1rNFks-0004z7-AX
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:19:12 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so38334605e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 09:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704820748; x=1705425548;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/e1lo51RsK7PB7U4/L0cmcttPiaIe/swqRAqrJ0m2Y=;
 b=Dm72MFRJDqlhWA23hOyOiwEM2E77jsRq46jTMrOgBrukPksoZ1pnnQ5J/KcpxykifK
 x7wdmzBbF+OmTd15v4m2/0hpLV9kb8EW8c8EDeuIki8TLdYXyBD37gswaNs8RXG+rH1O
 8HfsLI07r1nqLPS14xNjyElFKO06XH+OFC38FxXUZbwAaXHbSaxLRvBlDENyF5ZzDTit
 h6c57g03IkioABfSzTGeRmAPPN+0uK8biyQQTCtVFpucsJBGB/WnPL4MAx+bGmm98OnS
 1571iN5PrDIII3e1YgGyOhHYQpa+auBTViEZsqUPgX3eElfJf/5XSPFcywO7qcquTeq7
 ZQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820748; x=1705425548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i/e1lo51RsK7PB7U4/L0cmcttPiaIe/swqRAqrJ0m2Y=;
 b=Gp0ZHlENsFdX9rFf3D/fzhDFHfXBN/xT7oXb0UR6xvsxMUv8Yi/TL1V4w6d/FhVgBJ
 GuzhuaReeSNbmvUtIVZ7Kq6320RGqcHsg3HjyjRCUYoVIK4rwXxJz9+EzJ5G5NPj/Ty7
 laUIIFeraWo0fw1NV2HBXBya23zK3eApL4xNjLK4qcP3VXFhQvoAdb1u3uOcOgKPs+eV
 D5zvzaPMPWKgK+4Q4IPMj2bKraexlF3Kr8MkmP/+OUA5L3bbwdj5AFWRS83e47sDXFWX
 0hT+CJoxrqLMCB49iHXwAVqj9ANdraqtwE848ODyym4dJQa4L6EU8b3MI+cGclyiY5TG
 8Ixg==
X-Gm-Message-State: AOJu0YyGqpxAAuvnfLrYqEn6HKrzv0xjNe2OAksXfm7DQKk+IZXjsTJ9
 P3AYtRImtTJlq0JIWCAQdv/Ukc3FGkO/MK3IeQGAvn6WuTTYnA==
X-Google-Smtp-Source: AGHT+IHOEKWG42EhClf9orVWPN+86A3v91QKVtH/8kicHqWT2SVcPxekIC6K166k7Sy3ViYrL7tp/g==
X-Received: by 2002:a05:600c:511e:b0:40e:5320:2582 with SMTP id
 o30-20020a05600c511e00b0040e53202582mr139929wms.107.1704820748205; 
 Tue, 09 Jan 2024 09:19:08 -0800 (PST)
Received: from rockhopper.ba.rivosinc.com (214.11.169.217.in-addr.arpa.
 [217.169.11.214]) by smtp.gmail.com with ESMTPSA id
 bg30-20020a05600c3c9e00b0040d62f89381sm4350308wmb.35.2024.01.09.09.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:19:07 -0800 (PST)
From: Rob Bradford <rbradford@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Rob Bradford <rbradford@rivosinc.com>
Subject: [PATCH 2/3] target/riscv: Add step to validate 'B' extension
Date: Tue,  9 Jan 2024 17:07:36 +0000
Message-ID: <20240109171848.32237-3-rbradford@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109171848.32237-1-rbradford@rivosinc.com>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=rbradford@rivosinc.com; helo=mail-wm1-x32c.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index fda54671d5..f10871d352 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -273,6 +273,35 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
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
@@ -309,6 +338,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         env->misa_ext_mask |= RVI | RVM | RVA | RVF | RVD;
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


