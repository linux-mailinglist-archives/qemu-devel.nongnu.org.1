Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0807057E1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:48:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0cS-0000S2-TN; Tue, 16 May 2023 15:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c2-0008W0-5p
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:35 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0c0-0003iP-3f
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:33 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-24df161f84bso38991a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266329; x=1686858329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3K+79nBiSc5crGCl8vbMQJ8GibyAa5XexENyD2+9r4=;
 b=ppBwYKMgiuaJj6tOojb90updO3NDRwOMNyEKFUMkcbT/HaF0UR+jEMa8lJiO2+c8QJ
 6rBy01m6i34cCT3BpSmkaOkaeI9sz2/zHsGPnR02pykNPAalxFAesDtzdJ0EnrznGhU4
 CjSBgI/RsBfJt/XLMWYbvmMd6fcQzZf2+4r7PsYhHR7yJoWbfE10Q2okmaE1ofKcZk4u
 ZijZ3opbS2il2mJWjQfRE7wu2QvUNfHazZ0WmlrAy9sVV+cVaeOHyXXk90BnuE8DpS6A
 4amGUzGFln4x1PikePC5nOyCbXVjvr55Lz6jqF7UwT994gH2JzbPSKlbyXe7x3bbrsx8
 QEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266329; x=1686858329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3K+79nBiSc5crGCl8vbMQJ8GibyAa5XexENyD2+9r4=;
 b=IQHC4WwT43aCxZjA9GKBWLjeEZ3CdqA53Nc+hlyWQwt1wtUZ/4d+002x4o8WDveQOr
 N0k4b9VHHlXxyfDSE8YQwCJ+iwjhZzlG6pL8w4Z5oDHaZ0u9sWVqfCb5agxxQEkhhEA5
 1z/pBVGgBQ9brod1s5zyiWmkgfD+3UJBUDCtHggpYcqOn4sQ33zJSOD8iN/ufKwjkE5u
 PDuG60CGqi++wHoN6RBTzVlVpeQxvsCXAoEi1mL/i/EZQWTBXtOGRa16ZwugBFZfI0Ls
 vKR5yYYQd34ciRmAR1RIWhBwnibGdjhGbU/45m/3tjd5g8VdQQh/pLSvUm8Rkl0+52Da
 9k7Q==
X-Gm-Message-State: AC+VfDw7QhDkAgxvjsKAhDg3UO15tDU2vgwRV+0qDPVPRggUXFhJdPff
 X1StRFgTG3Kwm9Bx6uVr4Q1QoZNr1V3v+4BrvBU=
X-Google-Smtp-Source: ACHHUZ4pYlHXyQk+OM2YBTPrprC74cHmZBIWSZB5TkUXwGd4FHRC0xYKgGRPg8TguZRmB+XY/CumOA==
X-Received: by 2002:a17:90a:9d87:b0:24d:f77c:71e7 with SMTP id
 k7-20020a17090a9d8700b0024df77c71e7mr36900436pjp.41.1684266329572; 
 Tue, 16 May 2023 12:45:29 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 47/80] tcg/i386: Honor 64-bit atomicity in 32-bit mode
Date: Tue, 16 May 2023 12:41:12 -0700
Message-Id: <20230516194145.1749305-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Use the fpu to perform 64-bit loads and stores.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 44 +++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 3b8528e332..0415ca2a4c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -468,6 +468,10 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct)
 #define OPC_GRP5        (0xff)
 #define OPC_GRP14       (0x73 | P_EXT | P_DATA16)
 
+#define OPC_ESCDF       (0xdf)
+#define ESCDF_FILD_m64  5
+#define ESCDF_FISTP_m64 7
+
 /* Group 1 opcode extensions for 0x80-0x83.
    These are also used as modifiers for OPC_ARITH.  */
 #define ARITH_ADD 0
@@ -2086,7 +2090,20 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             datalo = datahi;
             datahi = t;
         }
-        if (h.base == datalo || h.index == datalo) {
+        if (h.aa.atom == MO_64) {
+            /*
+             * Atomicity requires that we use use a single 8-byte load.
+             * For simplicity and code size, always use the FPU for this.
+             * Similar insns using SSE/AVX are merely larger.
+             * Load from memory in one go, then store back to the stack,
+             * from whence we can load into the correct integer regs.
+             */
+            tcg_out_modrm_sib_offset(s, OPC_ESCDF + h.seg, ESCDF_FILD_m64,
+                                     h.base, h.index, 0, h.ofs);
+            tcg_out_modrm_offset(s, OPC_ESCDF, ESCDF_FISTP_m64, TCG_REG_ESP, 0);
+            tcg_out_modrm_offset(s, movop, datalo, TCG_REG_ESP, 0);
+            tcg_out_modrm_offset(s, movop, datahi, TCG_REG_ESP, 4);
+        } else if (h.base == datalo || h.index == datalo) {
             tcg_out_modrm_sib_offset(s, OPC_LEA, datahi,
                                      h.base, h.index, 0, h.ofs);
             tcg_out_modrm_offset(s, movop + h.seg, datalo, datahi, 0);
@@ -2156,12 +2173,27 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_modrm_sib_offset(s, movop + P_REXW + h.seg, datalo,
                                      h.base, h.index, 0, h.ofs);
+            break;
+        }
+        if (use_movbe) {
+            TCGReg t = datalo;
+            datalo = datahi;
+            datahi = t;
+        }
+        if (h.aa.atom == MO_64) {
+            /*
+             * Atomicity requires that we use use one 8-byte store.
+             * For simplicity, and code size, always use the FPU for this.
+             * Similar insns using SSE/AVX are merely larger.
+             * Assemble the 8-byte quantity in required endianness
+             * on the stack, load to coproc unit, and store.
+             */
+            tcg_out_modrm_offset(s, movop, datalo, TCG_REG_ESP, 0);
+            tcg_out_modrm_offset(s, movop, datahi, TCG_REG_ESP, 4);
+            tcg_out_modrm_offset(s, OPC_ESCDF, ESCDF_FILD_m64, TCG_REG_ESP, 0);
+            tcg_out_modrm_sib_offset(s, OPC_ESCDF + h.seg, ESCDF_FISTP_m64,
+                                     h.base, h.index, 0, h.ofs);
         } else {
-            if (use_movbe) {
-                TCGReg t = datalo;
-                datalo = datahi;
-                datahi = t;
-            }
             tcg_out_modrm_sib_offset(s, movop + h.seg, datalo,
                                      h.base, h.index, 0, h.ofs);
             tcg_out_modrm_sib_offset(s, movop + h.seg, datahi,
-- 
2.34.1


