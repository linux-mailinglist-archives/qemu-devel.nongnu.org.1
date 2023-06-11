Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 491FD72B0EF
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Guu-00017w-SO; Sun, 11 Jun 2023 04:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Gus-00011h-SF
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8Guq-0003cE-3b
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:59:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso23716655e9.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473954; x=1689065954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VS+s8yk8BlqPwYNXE59CP7hfYn/0yx3Nq7M676cAi8E=;
 b=uEWXYuEyIKTuZjdYNZ0x9pnthDLTewvdpXEXLf3tkdQlRdRhhLkmG3uCMcAtF4aBI0
 116dEP5CvrqPbCA9+Gxd0GTO1KqGcQDD+LUdT5U3PaCehgkPqNZmv2ri9myvf1BcLFzK
 1tHPu04FAuzlOjdg8kxNg71RfXK+5tdo6ybab3m0DXi+S44sSmdzE+o4W60AWICBd5bM
 2LTsqOCxiVfV50mePfedhRMx46ogFdStZoL35Fz2zMLUraFfQ04zIdRYqoWZCIlqHV4K
 F91zhOP1lcbtZZ+bVL7Iq5hvtZaRc2+GGkptkXIEA9fv1hCUf6xyCpUshRHIj9j+3WJO
 wIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473954; x=1689065954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VS+s8yk8BlqPwYNXE59CP7hfYn/0yx3Nq7M676cAi8E=;
 b=mGZvdlOHkgoFDKVnMPCN2xRm1B24EcmnDooV32dlJT4efphfLvuDjyTpltLjIgoG62
 0Ab8Pc55xDMK7d90nHRYwDcWfTToCbp2O/9UT/fucSpQ4XTRoDUCNeRR3ONZ7KVjV7Qg
 zZdu+kHg2S9t+CWOXrzg3zBlSQDOENkzjLMscx8ninsZWiYSzL1lrMRdBoK/h1r5ARpz
 VRjgP5ACs26Z1QCYiXDkxIhIrKUskpB7KSRJRggOHDeYBgnp2thIMk7lGxPVmV0TFHtp
 5A/pjEJStC7qmbs8gqpAzgzLFc9TQH4aM0lRcdfk8gWMpi3RqLc51rqgU0KDrYBQ231U
 BFSg==
X-Gm-Message-State: AC+VfDwtEPX/q1F3WyTagjQ9M/VPbS7ZW7M/ypheAvm2/YOTDA5nkF2x
 fw0gjpYi23ScN37DxKZjZZS3vQ5IK1sm0leTXXU=
X-Google-Smtp-Source: ACHHUZ72kuZ4xOEIDbfQBc5zz08ZzHwxf5iwqZR6EWQGX+K24cFce/0nM7BwFARg6F0VRxGetOdhNQ==
X-Received: by 2002:a1c:4b14:0:b0:3f7:ec38:7b02 with SMTP id
 y20-20020a1c4b14000000b003f7ec387b02mr7323330wma.3.1686473954445; 
 Sun, 11 Jun 2023 01:59:14 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 k9-20020a7bc409000000b003f6050d35c9sm7820872wmi.20.2023.06.11.01.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:59:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 06/26] target/arm/tcg: Fix iwmmxt-related code style
Date: Sun, 11 Jun 2023 10:58:26 +0200
Message-Id: <20230611085846.21415-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In order to be able to move the iwmmxt-related code,
fix its style to avoid:

  ERROR: braces {} are necessary for all arms of this statement
  ERROR: space prohibited before that '++' (ctx:WxB)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 227 +++++++++++++++++++++++--------------
 1 file changed, 141 insertions(+), 86 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9..3238463f13 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -1441,10 +1441,11 @@ static inline int gen_iwmmxt_address(DisasContext *s, uint32_t insn,
     offset = (insn & 0xff) << ((insn >> 7) & 2);
     if (insn & (1 << 24)) {
         /* Pre indexed */
-        if (insn & (1 << 23))
+        if (insn & (1 << 23)) {
             tcg_gen_addi_i32(tmp, tmp, offset);
-        else
+        } else {
             tcg_gen_addi_i32(tmp, tmp, -offset);
+        }
         tcg_gen_mov_i32(dest, tmp);
         if (insn & (1 << 21)) {
             store_reg(s, rd, tmp);
@@ -1452,13 +1453,15 @@ static inline int gen_iwmmxt_address(DisasContext *s, uint32_t insn,
     } else if (insn & (1 << 21)) {
         /* Post indexed */
         tcg_gen_mov_i32(dest, tmp);
-        if (insn & (1 << 23))
+        if (insn & (1 << 23)) {
             tcg_gen_addi_i32(tmp, tmp, offset);
-        else
+        } else {
             tcg_gen_addi_i32(tmp, tmp, -offset);
+        }
         store_reg(s, rd, tmp);
-    } else if (!(insn & (1 << 23)))
+    } else if (!(insn & (1 << 23))) {
         return 1;
+    }
     return 0;
 }
 
@@ -1483,8 +1486,10 @@ static inline int gen_iwmmxt_shift(uint32_t insn, uint32_t mask, TCGv_i32 dest)
     return 0;
 }
 
-/* Disassemble an iwMMXt instruction.  Returns nonzero if an error occurred
-   (ie. an undefined instruction).  */
+/*
+ * Disassemble an iwMMXt instruction.
+ * Returns nonzero if an error occurred (ie. an undefined instruction).
+ */
 static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
 {
     int rd, wrd;
@@ -1570,8 +1575,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         return 0;
     }
 
-    if ((insn & 0x0f000000) != 0x0e000000)
+    if ((insn & 0x0f000000) != 0x0e000000) {
         return 1;
+    }
 
     switch (((insn >> 12) & 0xf00) | ((insn >> 4) & 0xff)) {
     case 0x000:                                                 /* WOR */
@@ -1586,8 +1592,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_cup();
         break;
     case 0x011:                                                 /* TMCR */
-        if (insn & 0xf)
+        if (insn & 0xf) {
             return 1;
+        }
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         switch (wrd) {
@@ -1627,8 +1634,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_cup();
         break;
     case 0x111:                                                 /* TMRC */
-        if (insn & 0xf)
+        if (insn & 0xf) {
             return 1;
+        }
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = iwmmxt_load_creg(wrd);
@@ -1662,10 +1670,11 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         rd0 = (insn >> 0) & 0xf;
         rd1 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 21))
+        if (insn & (1 << 21)) {
             gen_op_iwmmxt_maddsq_M0_wRn(rd1);
-        else
+        } else {
             gen_op_iwmmxt_madduq_M0_wRn(rd1);
+        }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
@@ -1718,12 +1727,14 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 22))
+        if (insn & (1 << 22)) {
             gen_op_iwmmxt_sadw_M0_wRn(rd1);
-        else
+        } else {
             gen_op_iwmmxt_sadb_M0_wRn(rd1);
-        if (!(insn & (1 << 20)))
+        }
+        if (!(insn & (1 << 20))) {
             gen_op_iwmmxt_addl_M0_wRn(wrd);
+        }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
         break;
@@ -1733,15 +1744,17 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 21)) {
-            if (insn & (1 << 20))
+            if (insn & (1 << 20)) {
                 gen_op_iwmmxt_mulshw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_mulslw_M0_wRn(rd1);
+            }
         } else {
-            if (insn & (1 << 20))
+            if (insn & (1 << 20)) {
                 gen_op_iwmmxt_muluhw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_mululw_M0_wRn(rd1);
+            }
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
@@ -1751,10 +1764,11 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
-        if (insn & (1 << 21))
+        if (insn & (1 << 21)) {
             gen_op_iwmmxt_macsw_M0_wRn(rd1);
-        else
+        } else {
             gen_op_iwmmxt_macuw_M0_wRn(rd1);
+        }
         if (!(insn & (1 << 20))) {
             iwmmxt_load_reg(cpu_V1, wrd);
             tcg_gen_add_i64(cpu_M0, cpu_M0, cpu_V1);
@@ -1790,15 +1804,17 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         if (insn & (1 << 22)) {
-            if (insn & (1 << 20))
+            if (insn & (1 << 20)) {
                 gen_op_iwmmxt_avgw1_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_avgw0_M0_wRn(rd1);
+            }
         } else {
-            if (insn & (1 << 20))
+            if (insn & (1 << 20)) {
                 gen_op_iwmmxt_avgb1_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_avgb0_M0_wRn(rd1);
+            }
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
         gen_op_iwmmxt_set_mup();
@@ -1817,8 +1833,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         break;
     case 0x601: case 0x605: case 0x609: case 0x60d:     /* TINSR */
-        if (((insn >> 6) & 3) == 3)
+        if (((insn >> 6) & 3) == 3) {
             return 1;
+        }
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = load_reg(s, rd);
@@ -1846,8 +1863,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
     case 0x107: case 0x507: case 0x907: case 0xd07:     /* TEXTRM */
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
-        if (rd == 15 || ((insn >> 22) & 3) == 3)
+        if (rd == 15 || ((insn >> 22) & 3) == 3) {
             return 1;
+        }
         gen_op_iwmmxt_movq_M0_wRn(wrd);
         tmp = tcg_temp_new_i32();
         switch ((insn >> 22) & 3) {
@@ -1877,8 +1895,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         store_reg(s, rd, tmp);
         break;
     case 0x117: case 0x517: case 0x917: case 0xd17:     /* TEXTRC */
-        if ((insn & 0x000ff008) != 0x0003f000 || ((insn >> 22) & 3) == 3)
+        if ((insn & 0x000ff008) != 0x0003f000 || ((insn >> 22) & 3) == 3) {
             return 1;
+        }
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         switch ((insn >> 22) & 3) {
         case 0:
@@ -1895,8 +1914,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_set_nzcv(tmp);
         break;
     case 0x401: case 0x405: case 0x409: case 0x40d:     /* TBCST */
-        if (((insn >> 6) & 3) == 3)
+        if (((insn >> 6) & 3) == 3) {
             return 1;
+        }
         rd = (insn >> 12) & 0xf;
         wrd = (insn >> 16) & 0xf;
         tmp = load_reg(s, rd);
@@ -1915,20 +1935,21 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         break;
     case 0x113: case 0x513: case 0x913: case 0xd13:     /* TANDC */
-        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
+        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3) {
             return 1;
+        }
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         tmp2 = tcg_temp_new_i32();
         tcg_gen_mov_i32(tmp2, tmp);
         switch ((insn >> 22) & 3) {
         case 0:
-            for (i = 0; i < 7; i ++) {
+            for (i = 0; i < 7; i++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 4);
                 tcg_gen_and_i32(tmp, tmp, tmp2);
             }
             break;
         case 1:
-            for (i = 0; i < 3; i ++) {
+            for (i = 0; i < 3; i++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 8);
                 tcg_gen_and_i32(tmp, tmp, tmp2);
             }
@@ -1961,20 +1982,21 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_set_mup();
         break;
     case 0x115: case 0x515: case 0x915: case 0xd15:     /* TORC */
-        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3)
+        if ((insn & 0x000ff00f) != 0x0003f000 || ((insn >> 22) & 3) == 3) {
             return 1;
+        }
         tmp = iwmmxt_load_creg(ARM_IWMMXT_wCASF);
         tmp2 = tcg_temp_new_i32();
         tcg_gen_mov_i32(tmp2, tmp);
         switch ((insn >> 22) & 3) {
         case 0:
-            for (i = 0; i < 7; i ++) {
+            for (i = 0; i < 7; i++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 4);
                 tcg_gen_or_i32(tmp, tmp, tmp2);
             }
             break;
         case 1:
-            for (i = 0; i < 3; i ++) {
+            for (i = 0; i < 3; i++) {
                 tcg_gen_shli_i32(tmp2, tmp2, 8);
                 tcg_gen_or_i32(tmp, tmp, tmp2);
             }
@@ -1989,8 +2011,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
     case 0x103: case 0x503: case 0x903: case 0xd03:     /* TMOVMSK */
         rd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
-        if ((insn & 0xf) != 0 || ((insn >> 22) & 3) == 3)
+        if ((insn & 0xf) != 0 || ((insn >> 22) & 3) == 3) {
             return 1;
+        }
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         tmp = tcg_temp_new_i32();
         switch ((insn >> 22) & 3) {
@@ -2014,22 +2037,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_cmpgtsb_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_cmpgtub_M0_wRn(rd1);
+            }
             break;
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_cmpgtsw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_cmpgtuw_M0_wRn(rd1);
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_cmpgtsl_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_cmpgtul_M0_wRn(rd1);
+            }
             break;
         case 3:
             return 1;
@@ -2045,22 +2071,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpacklsb_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpacklub_M0();
+            }
             break;
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpacklsw_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpackluw_M0();
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpacklsl_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpacklul_M0();
+            }
             break;
         case 3:
             return 1;
@@ -2076,22 +2105,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpackhsb_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpackhub_M0();
+            }
             break;
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpackhsw_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpackhuw_M0();
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_unpackhsl_M0();
-            else
+            } else {
                 gen_op_iwmmxt_unpackhul_M0();
+            }
             break;
         case 3:
             return 1;
@@ -2102,8 +2134,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         break;
     case 0x204: case 0x604: case 0xa04: case 0xe04:     /* WSRL */
     case 0x214: case 0x614: case 0xa14: case 0xe14:
-        if (((insn >> 22) & 3) == 0)
+        if (((insn >> 22) & 3) == 0) {
             return 1;
+        }
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
@@ -2128,8 +2161,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         break;
     case 0x004: case 0x404: case 0x804: case 0xc04:     /* WSRA */
     case 0x014: case 0x414: case 0x814: case 0xc14:
-        if (((insn >> 22) & 3) == 0)
+        if (((insn >> 22) & 3) == 0) {
             return 1;
+        }
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
@@ -2154,8 +2188,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         break;
     case 0x104: case 0x504: case 0x904: case 0xd04:     /* WSLL */
     case 0x114: case 0x514: case 0x914: case 0xd14:
-        if (((insn >> 22) & 3) == 0)
+        if (((insn >> 22) & 3) == 0) {
             return 1;
+        }
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
@@ -2180,8 +2215,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         break;
     case 0x304: case 0x704: case 0xb04: case 0xf04:     /* WROR */
     case 0x314: case 0x714: case 0xb14: case 0xf14:
-        if (((insn >> 22) & 3) == 0)
+        if (((insn >> 22) & 3) == 0) {
             return 1;
+        }
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
@@ -2218,22 +2254,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_minsb_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_minub_M0_wRn(rd1);
+            }
             break;
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_minsw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_minuw_M0_wRn(rd1);
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_minsl_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_minul_M0_wRn(rd1);
+            }
             break;
         case 3:
             return 1;
@@ -2249,22 +2288,25 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 0:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_maxsb_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_maxub_M0_wRn(rd1);
+            }
             break;
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_maxsw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_maxuw_M0_wRn(rd1);
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_maxsl_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_maxul_M0_wRn(rd1);
+            }
             break;
         case 3:
             return 1;
@@ -2387,30 +2429,34 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
     case 0x408: case 0x508: case 0x608: case 0x708:
     case 0x808: case 0x908: case 0xa08: case 0xb08:
     case 0xc08: case 0xd08: case 0xe08: case 0xf08:
-        if (!(insn & (1 << 20)) || ((insn >> 22) & 3) == 0)
+        if (!(insn & (1 << 20)) || ((insn >> 22) & 3) == 0) {
             return 1;
+        }
         wrd = (insn >> 12) & 0xf;
         rd0 = (insn >> 16) & 0xf;
         rd1 = (insn >> 0) & 0xf;
         gen_op_iwmmxt_movq_M0_wRn(rd0);
         switch ((insn >> 22) & 3) {
         case 1:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_packsw_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_packuw_M0_wRn(rd1);
+            }
             break;
         case 2:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_packsl_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_packul_M0_wRn(rd1);
+            }
             break;
         case 3:
-            if (insn & (1 << 21))
+            if (insn & (1 << 21)) {
                 gen_op_iwmmxt_packsq_M0_wRn(rd1);
-            else
+            } else {
                 gen_op_iwmmxt_packuq_M0_wRn(rd1);
+            }
             break;
         }
         gen_op_iwmmxt_movq_wRn_M0(wrd);
@@ -2424,8 +2470,9 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
         wrd = (insn >> 5) & 0xf;
         rd0 = (insn >> 12) & 0xf;
         rd1 = (insn >> 0) & 0xf;
-        if (rd0 == 0xf || rd1 == 0xf)
+        if (rd0 == 0xf || rd1 == 0xf) {
             return 1;
+        }
         gen_op_iwmmxt_movq_M0_wRn(wrd);
         tmp = load_reg(s, rd0);
         tmp2 = load_reg(s, rd1);
@@ -2437,10 +2484,12 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
             gen_helper_iwmmxt_muladdsw(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         case 0xc: case 0xd: case 0xe: case 0xf:                 /* TMIAxy */
-            if (insn & (1 << 16))
+            if (insn & (1 << 16)) {
                 tcg_gen_shri_i32(tmp, tmp, 16);
-            if (insn & (1 << 17))
+            }
+            if (insn & (1 << 17)) {
                 tcg_gen_shri_i32(tmp2, tmp2, 16);
+            }
             gen_helper_iwmmxt_muladdswl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         default:
@@ -2456,8 +2505,10 @@ static int disas_iwmmxt_insn(DisasContext *s, uint32_t insn)
     return 0;
 }
 
-/* Disassemble an XScale DSP instruction.  Returns nonzero if an error occurred
-   (ie. an undefined instruction).  */
+/*
+ * Disassemble an XScale DSP instruction.
+ * Returns nonzero if an error occurred (ie. an undefined instruction).
+ */
 static int disas_dsp_insn(DisasContext *s, uint32_t insn)
 {
     int acc, rd0, rd1, rdhi, rdlo;
@@ -2469,8 +2520,9 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         rd1 = insn & 0xf;
         acc = (insn >> 5) & 7;
 
-        if (acc != 0)
+        if (acc != 0) {
             return 1;
+        }
 
         tmp = load_reg(s, rd0);
         tmp2 = load_reg(s, rd1);
@@ -2485,10 +2537,12 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         case 0xd:                                       /* MIABT */
         case 0xe:                                       /* MIATB */
         case 0xf:                                       /* MIATT */
-            if (insn & (1 << 16))
+            if (insn & (1 << 16)) {
                 tcg_gen_shri_i32(tmp, tmp, 16);
-            if (insn & (1 << 17))
+            }
+            if (insn & (1 << 17)) {
                 tcg_gen_shri_i32(tmp2, tmp2, 16);
+            }
             gen_helper_iwmmxt_muladdswl(cpu_M0, cpu_M0, tmp, tmp2);
             break;
         default:
@@ -2505,8 +2559,9 @@ static int disas_dsp_insn(DisasContext *s, uint32_t insn)
         rdlo = (insn >> 12) & 0xf;
         acc = insn & 7;
 
-        if (acc != 0)
+        if (acc != 0) {
             return 1;
+        }
 
         if (insn & ARM_CP_RW_BIT) {                     /* MRA */
             iwmmxt_load_reg(cpu_V0, acc);
-- 
2.38.1


