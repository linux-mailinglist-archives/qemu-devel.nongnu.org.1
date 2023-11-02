Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4A7DEA51
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:44:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYp-0006ax-Nt; Wed, 01 Nov 2023 21:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXu-0005ny-K1
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:19 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXs-0001f3-WB
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:54 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2b1af964dso269345b6e.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888652; x=1699493452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=gSYb3sGU6m6M81RMqcA0q4UVhaFwBGR4KMKlU0NT/aCp1J3OsbFHdwqhWw3DaNS8Mo
 7qjMQs6EX2qLXZ5Gi+9HtnhEIu8/8UyXWfj2zMw6g0H8kB58H1rRvZR+rANdsXPAHlX1
 PbydtCv+dFM+X3OUujpTwlRgko8UlmDyZ2CNWckKzTjb+1MxwYPUPbMXxxbUPxTKdvPi
 wJ51kpLnQM78woQio+q9gOhs0iew6+P4BbFJtHak2NKa9wCq+O96NnWP8SXR2/sYCeYu
 V0cXZGIO8UdKjOmyjwK4S2IBLaZWOlEHIDAOzPQ9nKtMzjlUjqLZ74nB7VXHS6yCxq9Z
 Ujpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888652; x=1699493452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=Cc5yBSM19sa5gstztDIMjmbMSyVCvP9dgDIj6JIHpxyYVuWX3hyqLhTGcgSCrzK/tv
 1/T73HVBcUR9AA6ktstuHJheFWbZ4FQgXOVoethfUVROxIWEzeZh8eKZzaeSWXhoexj3
 lqagbwJBKEvg8FkbCZbDnMlHOdFH7try5zMsXXsGAOdMTiufjPybI0Dh3SS6dCBYaW5e
 Ca+pp+Jtl6YNw7IxfFkgQ/ukCQt+eNSJekRkJN/uIson1TfQxrHU3yKBqUVW3Wna7rvf
 5R0TqlknvAE6zCRHBXhoFLm1ypig3latYpqXG6kcV1P2H6RrCWQ+ufEacqV+UDA4nrPS
 F2vg==
X-Gm-Message-State: AOJu0YwEbXgaYiYMdouTtd8qFaYRedspLDKZTz4/r/TMaVhyYfVm/nGf
 4rd5H3gQaX32vpGK/Ws2WGDGgwAF0YH3PRSoRrk=
X-Google-Smtp-Source: AGHT+IH5a0w1LORBZ6dfTsdRbmdPTvTM+syFzOvIqkBCc7l/SeS8LKvpI4yYPEuPEx+pVKgFZs2Gag==
X-Received: by 2002:a05:6808:44:b0:3ad:ffa4:e003 with SMTP id
 v4-20020a056808004400b003adffa4e003mr19039829oic.33.1698888651965; 
 Wed, 01 Nov 2023 18:30:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 38/88] target/hppa: Drop attempted gdbstub support for
 hppa64
Date: Wed,  1 Nov 2023 18:29:26 -0700
Message-Id: <20231102013016.369010-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There is no support for hppa64 in gdb.  Any attempt to provide the
data for the larger hppa64 registers results in an error from gdb.
Mask CR_SAR writes to the width of the register: 5 or 6 bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/gdbstub.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 48a514384f..4a965b38d7 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,11 +21,16 @@
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
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-    target_ureg val;
+    CPUHPPAState *env = cpu_env(cs);
+    uint32_t val;
 
     switch (n) {
     case 0:
@@ -139,24 +144,13 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
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
-    HPPACPU *cpu = HPPA_CPU(cs);
-    CPUHPPAState *env = &cpu->env;
-    target_ureg val;
-
-    if (TARGET_REGISTER_BITS == 64) {
-        val = ldq_p(mem_buf);
-    } else {
-        val = ldl_p(mem_buf);
-    }
+    CPUHPPAState *env = cpu_env(cs);
+    uint32_t val = ldl_p(mem_buf);
 
     switch (n) {
     case 0:
@@ -166,7 +160,7 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gr[n] = val;
         break;
     case 32:
-        env->cr[CR_SAR] = val;
+        env->cr[CR_SAR] = val & (hppa_is_pa20(env) ? 63 : 31);
         break;
     case 33:
         env->iaoq_f = val;
@@ -278,5 +272,5 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         }
         break;
     }
-    return sizeof(target_ureg);
+    return 4;
 }
-- 
2.34.1


