Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D47E32FD
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:33:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Brp-0002l2-S3; Mon, 06 Nov 2023 21:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrX-0002iz-GL
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:44 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrU-0002Vn-DU
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:43 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc938f9612so29696205ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324235; x=1699929035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/oKXVAuf4kx6zxmDIUZq9qmQKojvKe+yEaAi8XPodfs=;
 b=Q64c/sNQShh2JyMgCcSNKxOl0wZP9jbfjTLcxe/iTgrGUTa3fqGKn0y77CqlZDo1JE
 p1AiwvJHJDEPGV5bUoPOSpnTsnnee3eoURL6VJuFLQB12eJnjoiW5v0fe6Mft04kCZCv
 omQH3QtuPauelH/d1XxwDePBEqCQeGgITidt98KFnKRhbdCEIBwK5/l2PEP26eVmXsyJ
 IMgQL8uIbpp+CszqQQdToE4b/Y3/mjTLAD8qHCyomqCkKDZWT5yCGwXv8cGN675zBZ6C
 ikvCfGBvdSRWFUpX/NBd1lEljIKLB8SUXTjMLf9RyK+mdznf1XP22K1Ncj66JAdoSQCv
 cQPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324235; x=1699929035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/oKXVAuf4kx6zxmDIUZq9qmQKojvKe+yEaAi8XPodfs=;
 b=YOiHt+0S06nzD+zDoSHLNY3CVW5+lLOyLUaWHa2M+m4lB828xyjcjcPfZt1UNA8g5X
 0uGffGdyxusRwR7muqz5TyV8Q9mYtGCVHqZXmJsnxkQZ3lvKuWsX7kEf8XGy0pxNkjTd
 n8BAPoIm5yu5HdUMDarxjBkyi1Vntsi8bPg4YQGpngfhylJ6jHFwlyLlspjGgYhMgQkt
 mrFkt+UMvZ5qGdF4WjuSm+lXR3da3ff3LHUeESAp2VcfzFFNg0jCpGYnurNcLg2ftOfu
 +7l5bpiPIecJbAEsvX+9HG+npDms55f9MJaYiFyF2M+6EPHh4GYzC+g52LNS16BYnhac
 eJaQ==
X-Gm-Message-State: AOJu0YxVjxplj4Q3Ty3CGaCBFJ0gof3kBqcKJ19wj8LJDUi7OD8slylE
 iGz1KOQQ7WuRuWBX1S+oeRfzEho6fdWdHg==
X-Google-Smtp-Source: AGHT+IF8T3gD2u7J3efDrqD9g4Hi5Qr1MhmsiCRXWKzlyN6IyXgs4jBuwg6aaTBNH+O10BqUca+Vpg==
X-Received: by 2002:a17:903:2349:b0:1cc:6e42:1413 with SMTP id
 c9-20020a170903234900b001cc6e421413mr20597555plh.57.1699324235159; 
 Mon, 06 Nov 2023 18:30:35 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:34 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/49] linux-user/riscv: change default cpu to 'max'
Date: Tue,  7 Nov 2023 12:29:07 +1000
Message-ID: <20231107022946.1055027-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Commit f57d5f8004 deprecated the 'any' CPU type but failed to change the
default CPU for linux-user. The result is that all linux-users
invocations that doesn't specify a different CPU started to show a
deprecation warning:

$ ./build/qemu-riscv64  ./foo-novect.out
qemu-riscv64: warning: The 'any' CPU is deprecated and will be removed in the future.

Change the default CPU for RISC-V linux-user from 'any' to 'max'.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Fixes: f57d5f8004 ("target/riscv: deprecate the 'any' CPU type")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20231020074501.283063-1-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/riscv/target_elf.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 9dd65652ee..dedd5956f3 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -9,7 +9,6 @@
 #define RISCV_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
-    /* TYPE_RISCV_CPU_ANY */
-    return "any";
+    return "max";
 }
 #endif
-- 
2.41.0


