Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BAB7D1752
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM0-0007wL-Lw; Fri, 20 Oct 2023 16:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLl-0007lu-8a
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:09 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLh-0008EV-8j
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso1218027b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834638; x=1698439438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=TpMVXKfGaKEaDH6VFA+Vv4ks6+LaEGg3C2JeHcCwJPsbo/0JP0/YvZOg3zXvf0MVG4
 DPyH6tssDXF5B9BOBNL8MmQnoemL9ilgZLN2tMookuisAxrc6qay7/+gZWcRZZEpJo1p
 9VKfwXScwTjUxsmRreu16jC4Ki+EH+HHGdyqEyBk9B6thWPGUITclaXXPhV6ZdYkAM2y
 zKr03RAT7UK7TiP1VLywFohThBgGnn7SLGyQD+I0ctqwDYXZosDVp9wgxWN8ypwp0dtr
 fQL5/k2XJxCHAaYBs9Sto1iGyaE+m4MGFKG1F4m9eaUXnPUL3JJGnvpQ3tNhnPXPMR9o
 XbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834638; x=1698439438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=D0oXCps+ml1rMhlsPvAl7M2z1U1jGOjNyUcI3rqHbX6Sqj25EsCNfrEPQjGeMkl3VO
 it9x7Xp985iSdDl2YsPN6XtJE6yooroJgoy6zqqTxyt3Bf3e9CbTXu1OS2/WT12yQNnb
 d9IJMGiJgAegHFK+6NLr9uV7kFFjJaUazHKJipsQAc8AaH/DbdfCug4trXD+RSFAs+G1
 uPknCZ0b0UW4mz8iH6zUYGK00UENnOjIlTGo3+tP5MGsJF+wOw14Vk2hB9yE8v4hnNEA
 peAivPw1rvDye/yF96LR1NWTaMaVFuj8h/K1cXPES1BkWG6USbZAveXgUt7hAb9WNao3
 E82Q==
X-Gm-Message-State: AOJu0YwXvLu5eAtmynHtTQ6CkvrUKaf2VSnDxAZ1MKVPIzp7WMEAP5MU
 QfCkb6w8eWFW1KZCJrLkKASbSW5S+aasdGzHb5Q=
X-Google-Smtp-Source: AGHT+IFkCHfsiIGJL1VO1KrPzgOMlehNMxV2i6uFxPVpEKbcrLZTg12WSlHq1IjSmGdqr2CNtaAkFQ==
X-Received: by 2002:a05:6a00:24c6:b0:690:1c1b:aefd with SMTP id
 d6-20020a056a0024c600b006901c1baefdmr3062144pfv.5.1697834638209; 
 Fri, 20 Oct 2023 13:43:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 28/65] target/hppa: Drop attempted gdbstub support for
 hppa64
Date: Fri, 20 Oct 2023 13:42:54 -0700
Message-Id: <20231020204331.139847-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


