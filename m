Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C848F7CEA8F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESg-0001mS-3x; Wed, 18 Oct 2023 17:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESS-00019y-Re
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-0004Ry-3f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:04 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1ea98ad294cso1059494fac.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665920; x=1698270720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9hX0qQk5CZemXO2IHvqPOvMFc4SeZE7uxuiBohTGeQ=;
 b=rP0aYlJLBYRj504qc9z1I05HOSUqpF3the29/j95i84+dNWVPpd+nidN7KD/8GZDqF
 u+Y10DWf76k5zZZ4xQCLggXvz5xg3L8o0exWMl76c2hIgBrAjwyjl4Na0YVg+GT7cuYm
 nwTZ6UDF2YSKdKvRHBvqEVPANOblpPWcMXEBKZHwrGCQEsRM2ye6/eHrXUQXzamGAOud
 1TGGdQWY11BANXk/thDDupfQPrPO8WuKliIe4omDCJrJj9qxM3GTaW95nARmq2+u/qXM
 Il+L4CgDwtEJM82aXazMpWsl/2W9XsyV8BgUMnZX7mXFLJ5bsIhNL+FHK+4DZoEgsAQC
 U7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665920; x=1698270720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9hX0qQk5CZemXO2IHvqPOvMFc4SeZE7uxuiBohTGeQ=;
 b=h2su3SH541tw8wggf7QI81oj/pE2R//N/LDbmEj8YEh0JGBL/ZX4JVXgJsiv3yzNrv
 r5wXGGVhVeKH77Ox6/0JVcib13lPTKUINbaKfs7sx3im24WD3jxaUwpw4FMj1MfuVbRe
 udmU8KsAv4B790WQqjsuDE0fs2TESJT1ZHKGbmiX+b38PhmBnxHhxYbRyc1jqX07pZGT
 2Emnyjf5XCSrIXa9IOzUZ7ybQAr7nT+5g/TSiiFXpAC29hFRFCMGZ0K1kdI0twc32GKl
 DVDSdYMICHVGlsCjv/tpVbj5kbaVatpnEmXQW95qIHLbPVBGl49n+lrPFThhvWXfu5ER
 syTQ==
X-Gm-Message-State: AOJu0YwytO9MyVCVY/IwRMLwCmbOte6iBdXxNsYFFuB1iyCAQmp9EeH5
 k1FU2xAa9XETefa2JPpl4Gs1XO2MZmc4APKNx/o=
X-Google-Smtp-Source: AGHT+IEog97UlMW0gZeFJ6RkV1S187RZItmbTzJGBNvKrCF1BkobQi2ljRKxomnaOMecRaOTPtJkaQ==
X-Received: by 2002:a05:6870:ec90:b0:1e9:db34:a573 with SMTP id
 eo16-20020a056870ec9000b001e9db34a573mr600614oab.26.1697665920325; 
 Wed, 18 Oct 2023 14:52:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 28/61] target/hppa: Drop attempted gdbstub support for hppa64
Date: Wed, 18 Oct 2023 14:51:02 -0700
Message-Id: <20231018215135.1561375-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

There is no support for hppa64 in gdb.  Any attempt to provide the
data for the larger hppa64 registers results in an error from gdb.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/gdbstub.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 48a514384f..748431097c 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,11 +21,17 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
+/*
+ * GDB 15 only supports PA1.0 via the remote protocol, and ignores
+ * any provided xml.  Which means that any attempt to provide more
+ * data results in "Remote 'g' packet reply is too long".
+ */
+
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ureg val;
+    uint32_t val;
 
     switch (n) {
     case 0:
@@ -139,24 +145,14 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         break;
     }
 
-    if (TARGET_REGISTER_BITS == 64) {
-        return gdb_get_reg64(mem_buf, val);
-    } else {
-        return gdb_get_reg32(mem_buf, val);
-    }
+    return gdb_get_reg32(mem_buf, val);
 }
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
-    target_ureg val;
-
-    if (TARGET_REGISTER_BITS == 64) {
-        val = ldq_p(mem_buf);
-    } else {
-        val = ldl_p(mem_buf);
-    }
+    uint32_t val = ldl_p(mem_buf);
 
     switch (n) {
     case 0:
@@ -166,7 +162,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gr[n] = val;
         break;
     case 32:
-        env->cr[CR_SAR] = val;
+        env->cr[CR_SAR] = val & (cpu->is_pa20 ? 63 : 31);
         break;
     case 33:
         env->iaoq_f = val;
@@ -278,5 +274,5 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     }
-    return sizeof(target_ureg);
+    return 4;
 }
-- 
2.34.1


