Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5581B7F9ECA
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:39:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZwY-0003x1-A2; Mon, 27 Nov 2023 06:38:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwX-0003wU-4v
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:25 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r7ZwI-0005Jm-CJ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 06:38:23 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso3110119b3a.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 03:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1701085088; x=1701689888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFIiKbikcqzRdI/piBFTJ1Oi22cwo4vdUZE7XSpcBYM=;
 b=kzr/ecxw4nXAxdhDJVnAx9qv67J25qEFYlWoKJY5jKKxIgHy7W6wF/7u6nnh/ulP0Q
 V/Nm+f7nd9pmFTOgP7JiWUltC4LepYAqfKRTGtVA4Ip8xC7ap8UWeP1Hnp+CgSYnz1zf
 fuGq9zpyDxyNSWWoonEYC+Q3VcDLAV7bETYEKULNbyydAXLzaz6tY3hcdZNTIc4FqCA3
 LbH7lyYkNywJ9IkAtrvHRMwrwHA82T1RoCkoWcc3lEDDf5W290xXzqax0Q2/7lL5B/kI
 raNosJ3Ktwns+tSuJzxw+qyj6ch6FRAagVLlkKf696CjYCPYqZAy1zUqSMRi07u2mXae
 ULWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701085088; x=1701689888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFIiKbikcqzRdI/piBFTJ1Oi22cwo4vdUZE7XSpcBYM=;
 b=KplJx5MaDEew63yjhri6xwQaFZDHD4N85AMLAXh6Ap1O6UKXbJzIDxafpPyptkTt8k
 R0E/rU8r2N+g2FG9d84HVojpaSPcjn37weZ/QfH6GLuoPgh1hq/HM//aTrVS0T86xJvl
 bsIpyYq24YKRavwg0q0YftAwLb9vUEtQHmX14z+3eRqDdRwhoh6a0H/MU8cByBY+huH1
 wf3j8QZ5nPIR2LVFr3VmEo/1znlYHxKNlVkQSbeO0/sD2DmbLFwv5IZKBcrak7gAY2r0
 jzxxdW8A9+ZKTjxMfc3tgT+3ZuwqOvRTmJBXAMLRhb6m/s6o4b1+c23564B3p7T0rBVi
 HUQw==
X-Gm-Message-State: AOJu0YwmxU5RD0I2T6wJL9JoF623VuM5+qRelF77febxAvPcUo4mjA8S
 O/xuBkVRNG/bSPjQS0mKexTltrWM+0gK7oV3NSU=
X-Google-Smtp-Source: AGHT+IEJOsY0Ijav334YjzFjvVmEm0ItSdN6jcFbWMkUAm/F85jAFNAPaRBqYOSeCY4oH4z/ILmqMA==
X-Received: by 2002:a05:6a00:1d24:b0:6cb:aa0a:6fcc with SMTP id
 a36-20020a056a001d2400b006cbaa0a6fccmr11988718pfx.1.1701085087676; 
 Mon, 27 Nov 2023 03:38:07 -0800 (PST)
Received: from grind.. ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a63e94f000000b00578b40a4903sm7618323pgj.22.2023.11.27.03.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 03:38:07 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-9.0 v2 3/8] target/riscv/cpu.c: finalize satp_mode earlier
Date: Mon, 27 Nov 2023 08:37:47 -0300
Message-ID: <20231127113752.1290265-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
References: <20231127113752.1290265-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Profiles will need to validate satp_mode during their own finalize
methods. This will occur inside riscv_tcg_cpu_finalize_features() for
TCG. Given that satp_mode does not have any pre-req from the accelerator
finalize() method, it's safe to finalize it earlier.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 29a9f77702..a395c77bda 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1056,6 +1056,14 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
 
+#ifndef CONFIG_USER_ONLY
+    riscv_cpu_satp_mode_finalize(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+#endif
+
     /*
      * KVM accel does not have a specialized finalize()
      * callback because its extensions are validated
@@ -1068,14 +1076,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
             return;
         }
     }
-
-#ifndef CONFIG_USER_ONLY
-    riscv_cpu_satp_mode_finalize(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-        return;
-    }
-#endif
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
-- 
2.41.0


