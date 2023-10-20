Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEEE7D09B1
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkCC-0002co-81; Fri, 20 Oct 2023 03:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtkC2-0002bj-Q8
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:45:14 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtkC1-0002qP-29
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:45:14 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5841bdf1b81so127676eaf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697787908; x=1698392708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LvEO44krOC11m1g0j0FkwdjEkwOo9erBx/Axdtbc58Y=;
 b=HIiS/UdAD2NTxN/hbl+/VAtOFDipSOR2yfCU0Xw/QanMCsqY/ZIY9PU2TCt+CA4oD4
 mt937w+fWoufkXFXycoIt7/+dj2ycurUbUBobQWNSYUD3Gl/30GynASfdOAAtrpBlgMe
 1zgdc/fQRimtHqWPrjAkFOiG4fXHtRXXVHtTeGqR9VeXJjbaXevM9wRHPHySXwJmNqCU
 zWGpVISvlno+YBJg9AvbLNLfnDp+z5zZlp66hTJyZhTcGaH2yIcspJ5m1r9WZ4jhy4rQ
 frkSxRsBxhXJZJejphjCvO4+qppmauAqY3zFw6Nl/D4907JWzGfdxIRkJnDnWr2lsxyB
 VwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697787908; x=1698392708;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LvEO44krOC11m1g0j0FkwdjEkwOo9erBx/Axdtbc58Y=;
 b=AarPq6cBQHq+3bWixshbJlNLmVDNt8ppfc9APkSzKDpa6T/WuWt9qZCHttw/z0QUts
 Z3UFDcv6DKb8jzVZyr2iDbCkvmWB3h0TD7+3TJkWKW2QpNXHzLcp1ad+iLIlN+JUcFPD
 Tx/AOe3UF1B0n/hwVQeOMGe4nWEjWVXsgfKL52AB17xobNd54c9y8cz8pis/VhD5na+F
 1XzEc7QEKS3uEQ6HSBZIK22I1tuGuQ+veWmMSP5LWp7Bun7CSv3AF5qMz7XVGQMpvCsL
 qh875zq+Z9kvpSL77gAzDCS6bxX/ZOpy/qNhOtWgfuS8ApziwQVJpAk6WVLjPUJ+Fkpr
 xgSA==
X-Gm-Message-State: AOJu0YxPMlOO9Fr0kCrzfNGyvc2fjTPX2yfQG45PWtYE9tTG8ShOLs65
 cBsnVvJ3BLrzwPuxsKURIOQfJnItTnkQheIteBM=
X-Google-Smtp-Source: AGHT+IGe74ejE/7KdbcTTPc7Eac6KVsSqy5gApdtEpFRWhtYeDof/CrPRek/Kc8sote9fquKSd38JA==
X-Received: by 2002:a05:6358:729:b0:166:d4ec:f616 with SMTP id
 e41-20020a056358072900b00166d4ecf616mr945986rwj.4.1697787908084; 
 Fri, 20 Oct 2023 00:45:08 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 a6-20020aa79706000000b006b22218cb92sm919756pfg.43.2023.10.20.00.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:45:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] linux-user/riscv: change default cpu to 'max'
Date: Fri, 20 Oct 2023 04:45:01 -0300
Message-ID: <20231020074501.283063-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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


