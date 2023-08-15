Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4F77D3C0
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 21:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Ay-0005BK-1S; Tue, 15 Aug 2023 15:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0Aw-00059x-6p
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:58 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qW0At-00015q-7V
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 15:57:57 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso3931879b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 12:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692129474; x=1692734274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pu9KEBeJ8el0D1W01E7RaWKVL1yngJNhhEobU208UWE=;
 b=PQS7Veyxa8xlO69A62nAoJkL51SxfZU5sICvPXZE45pZxkmLCow05I2o/JDNcX0od7
 dasyY7gRq3K2TMZILUiXTjF/BD13DdLtz7bEozaw0Z/SgWIEV9lNvKZPaTQY4sCq+GKA
 ybiHU6dgP9uVvAjfuNfuffZsijSMNm8Il3YH0EUN482mPajjOYom1EFiEBA5kFdnV2TM
 xiMGTpleBSOMUaw9C5yVIvu2iPttyooiMivIzkkNW3pyZoSCf+APUb8ovlSQ8/J7zb2x
 WV5GnvPy7nM9c0fPo4/BGge0Fo4UrxS66XJ8wPwyHhUJPbjX6+gcN6lFYdu2RbXhC9NL
 fodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692129474; x=1692734274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pu9KEBeJ8el0D1W01E7RaWKVL1yngJNhhEobU208UWE=;
 b=IlAzIehpVtTZzK+PGAJsGjsQbhbxDZWmyrTQ/YglDBkwwIi2FS5k4Z++rkb+38EROF
 TEnaOG5AlWjFynN+nFPTFmP7axnmvYzqL2Yom+gYrcy+7Lou2sgHY4Mjnk0vbUs/JUiW
 4Qg7K3fa9hV2QX9GyqRQDrGOPY3fXYLV4kp9Qyq0NVdjeZ4W3X9HFOxBLB0I6wThKWWK
 GtGpiMDr+pTpQAjdtSGfR3SJcL1YcD9phnRV9dBzQ6N+qvAbCGGnDB83i5cGgiB0V2ES
 F9HkZSM/XV+Zw6+Q316s0QtTd1Nlh1YNZMP8gFlDbcQq2wt3euP94xmAZzUFvvoqZvnF
 ORBw==
X-Gm-Message-State: AOJu0YzsceWLtKJarHbefzQhEUm9TBoS8EwRlfrF4xN5XehrS/Vve0fD
 lzATQgNdhUaeHSgM9SEE5xubQ4T1R254+3KRyF8=
X-Google-Smtp-Source: AGHT+IEG+SWmRzhBdd5c+he4JPYFCn4esQdgUKhlpOjD/tv0BnfWOvnWuaeCjPBvv5FgAdm9M8MeYA==
X-Received: by 2002:a05:6a00:2345:b0:687:14df:51a9 with SMTP id
 j5-20020a056a00234500b0068714df51a9mr13923290pfj.12.1692129473936; 
 Tue, 15 Aug 2023 12:57:53 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8d06:f27b:d26c:91c1])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00686b649cdd0sm9667699pff.86.2023.08.15.12.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 12:57:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	jniethe5@gmail.com
Subject: [PATCH v3 11/14] tcg/ppc: Use PLD in tcg_out_movi for constant pool
Date: Tue, 15 Aug 2023 12:57:38 -0700
Message-Id: <20230815195741.8325-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815195741.8325-1-richard.henderson@linaro.org>
References: <20230815195741.8325-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The prefixed instruction has a pc-relative form to use here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 1aece2cbf7..670811b636 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -101,6 +101,10 @@
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
 
+#ifndef R_PPC64_PCREL34
+#define R_PPC64_PCREL34  132
+#endif
+
 #define have_isel  (cpuinfo & CPUINFO_ISEL)
 
 #ifndef CONFIG_SOFTMMU
@@ -266,6 +270,19 @@ static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc34(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t disp = tcg_ptr_byte_diff(target, src_rx);
+
+    if (disp == sextract64(disp, 0, 34)) {
+        src_rw[0] = (src_rw[0] & ~0x3ffff) | ((disp >> 16) & 0x3ffff);
+        src_rw[1] = (src_rw[1] & ~0xffff) | (disp & 0xffff);
+        return true;
+    }
+    return false;
+}
+
 /* test if a constant matches the constraint */
 static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 {
@@ -691,6 +708,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc14(code_ptr, target);
     case R_PPC_REL24:
         return reloc_pc24(code_ptr, target);
+    case R_PPC64_PCREL34:
+        return reloc_pc34(code_ptr, target);
     case R_PPC_ADDR16:
         /*
          * We are (slightly) abusing this relocation type.  In particular,
@@ -1150,6 +1169,11 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
+    if (have_isa_3_10) {
+        tcg_out_8ls_d(s, PLD, ret, 0, 0, 1);
+        new_pool_label(s, arg, R_PPC64_PCREL34, s->code_ptr - 2, 0);
+        return;
+    }
     if (have_isa_3_00) {
         tcg_out_addpcis(s, TCG_REG_TMP2, 0);
         new_pool_label(s, arg, R_PPC_REL14, s->code_ptr, 0);
-- 
2.34.1


