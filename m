Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AB7E339D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:09:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPW-0001Vo-AH; Mon, 06 Nov 2023 22:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COZ-0007BB-LD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hc-Db
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1cc3bb4c307so42474025ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326275; x=1699931075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=a9uIP3ClBPShUd++U2175qMh3S76t18hp8KqdmVLv2SZ+BY5CAKa5m0n4XkPNSFNhK
 VfczhZXBNqqdSm4fZbtxcFSM3ScLqbC/zLvd82QP/7KhKzzfU57WKa8vd3MTEjukUYHH
 trbkq7uOD0d4BAiLHbN9ZojNLTyn1c+ZmRrRhUEsGOv3XA99EcdOEDAE4N2r1hR3sGjU
 1HFIeeobxx2hqo2oMvTSM7g8WpSR8xXp3owVY0AL5yEKa5KyYkp9ArIwL2e4uhOHRnbC
 GAya/Vup9/9rFBFBwQCmsOHkmtSMDp17y5QUfrryiqwvZfbNlcatmbDysp3Y40DKgfni
 UVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326275; x=1699931075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDB1iCB7dFrTdi+sskzC1+DL914HNFrtvGBOgbigGUk=;
 b=vqtH32jj0dV0MfwScIoxwAOPde+nc/P4p0typd6YOzmupszG196ov1X778LdZw8lBd
 YieWxcx9gngdrkPT3YrBr8yfSGG1jq/nmdz9QEiosqIFx9ueRqmx+dKM0oQoUsBOiJGO
 PK8fK6vKjWNHZPtTgutDOUib4EgviEZ/w1FLTtwRpVZquL5xzPu8QMLv6hiMIotlDqHJ
 qo0ZzdIXUSiC01RWlm2JMyvHeLDdm+erP3NZNbjdVyvk03fXL9fFGB4PZodBkPp0iLrg
 QkzWD9DntLpw1Aec3QvvxPH5lUI1thZO8bCGmBlY9nloVSX/jHtuTrxiiaC1wpheE3H9
 R/4A==
X-Gm-Message-State: AOJu0Yx4gM5+jKBnV0VoiuKIFqKhV2r832xeC5VHUWkXtOgdQpnyxPJY
 lq8MY88FOcsvX/4w1cH/QAwWPAYAqTWgEJO2mQQ=
X-Google-Smtp-Source: AGHT+IHfXpMWNhFtKLuRYOLx0WoFTLBDSq8osYa8Vbr3HO6godq4wRWj94qdCA09wRKGb6FWopHRtA==
X-Received: by 2002:a17:903:2015:b0:1cc:5db8:7ebb with SMTP id
 s21-20020a170903201500b001cc5db87ebbmr15507786pla.9.1699326275077; 
 Mon, 06 Nov 2023 19:04:35 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/85] target/hppa: Drop attempted gdbstub support for hppa64
Date: Mon,  6 Nov 2023 19:03:18 -0800
Message-Id: <20231107030407.8979-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


