Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CAA9EB65A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Dec 2024 17:27:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32S-0007Ua-0b; Tue, 10 Dec 2024 11:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31p-0006xP-6t
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:05 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL31n-0007SV-92
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:04 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-540218726d5so1895501e87.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847841; x=1734452641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0qyOU3LcRXKe6qOmmCQNxZ02hAR2DxZjcJ1eX1Yeyw=;
 b=EUSnm3ypj3hZJhgiClw5ZzKqJ7wobwLIavYnWwh5x6M+retpBLRZxQLrRM02Yooo6B
 6rhHVKdV5ditKaaQzQQc6gND26398MITBPeokJfaujJUWMYyved/lwfWUTEUvTXmCylW
 kNYqE4VpaJDCymGk6APGtFflvsazPHZk9t3fHO2w57C3ERuIhywslTrMI+u99XElq/ZO
 HgJ9D+KRc4vzVAQIMmF8C0lZzq6ijwuEaGM/qr18MrfWVkaScBb2cEe0IFqITgEyTTuO
 MYVMmKD+VM5BQ12ic/GsDXE1cQl678fQshpTrhGItk7D+QT3LeqcnpONQR6fH1xnrXkd
 RZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847841; x=1734452641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n0qyOU3LcRXKe6qOmmCQNxZ02hAR2DxZjcJ1eX1Yeyw=;
 b=BcsVaUIMDczfVIVD2M0OpD8J4/aWZUx6WcKyfmEP7w0w0zsWMAKzwKK7W5TqRy59kR
 QLE9ZiKDLKGbC8E0BoLVfv2tVPLGhYy6Scc5yBwUC3F4wtqzNmXvoUSc4YbwEYFwhCZm
 zMTh758VpgeDypY7CtUO9LVM/PJfwZMPge74Tw/KjMZDX0gs5ZvZcKdMPM/9uBIf0upA
 TJWV83oesaMDgYW+MyDYV1Md2ELidOVKhoMkVEo8vN8WR0St6f3uSiVJQXBFUwQ+rIKk
 R+pRblinuZ7N3419W1m+LE8V/qQL6IM68nDzt+WhhU5mutTozx4jKuRGaIVpfkyyrSWB
 jRXw==
X-Gm-Message-State: AOJu0YyzEfPo5Sx3YBQAoEMQ7hmwMcWgSa3Y2PRbX3as8M8Fy/sMm+Vm
 IF5RloovQGNkN11ZUEhCIDUxPZh8UPPHDdmQ2iPOoyR99cukPoBYQy2/TbE3KcjrFRD4cZFDA6k
 7KtuV8PAV
X-Gm-Gg: ASbGnctjeIGXA1Y1IeiGJ9TYS8N8Q3IM9GpVG5IA8DofEs//W18JV5nL9Iy6yG8y0xy
 pVpSfkfx/6hPhRRnLK+hRqLkUjFDPMI1cxr4Hi0qJorF16Wi7O3muImX1BnrLnpm88faU/67n2f
 ON/1gu/ZgbIdpxbm7Tinw5At1zL4I89bCafSTaLhGK1L8QluEEbVht1stovcltl4wBa727mk1y3
 urJhtp70Kp0+eqlb5T3ISp+WUS+sgbdAtk0GODlQ7QNxMAH7ViPZNg5wBs=
X-Google-Smtp-Source: AGHT+IG/XoWD8Uj5UlKda+AbUgSvPGQ6rrFQa0bFMZtvdPpviiNVrewKEv9yiBe0zHHJ+65sGCYYNw==
X-Received: by 2002:a05:6512:33ca:b0:540:1c6e:f040 with SMTP id
 2adb3069b0e04-5402410748cmr1749376e87.45.1733847841521; 
 Tue, 10 Dec 2024 08:24:01 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.23.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 48/69] target/arm: Introduce clear_vec
Date: Tue, 10 Dec 2024 10:17:12 -0600
Message-ID: <20241210161733.1830573-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12b.google.com
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

In a couple of places, clearing the entire vector before storing one
element is the easiest solution.  Wrap that into a helper function.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 29d55bcedd..6655468df0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -628,7 +628,16 @@ static TCGv_i32 read_fp_hreg(DisasContext *s, int reg)
     return v;
 }
 
-/* Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
+static void clear_vec(DisasContext *s, int rd)
+{
+    unsigned ofs = fp_reg_offset(s, rd, MO_64);
+    unsigned vsz = vec_full_reg_size(s);
+
+    tcg_gen_gvec_dup_imm(MO_64, ofs, vsz, vsz, 0);
+}
+
+/*
+ * Clear the bits above an N-bit vector, for N = (is_q ? 128 : 64).
  * If SVE is not enabled, then there are only 128 bits in the vector.
  */
 static void clear_vec_high(DisasContext *s, bool is_q, int rd)
@@ -4851,7 +4860,6 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         TCGv_i32 tcg_op2 = tcg_temp_new_i32();
         TCGv_i32 tcg_op3 = tcg_temp_new_i32();
         TCGv_i32 tcg_res = tcg_temp_new_i32();
-        unsigned vsz, dofs;
 
         read_vec_element_i32(s, tcg_op1, a->rn, 3, MO_32);
         read_vec_element_i32(s, tcg_op2, a->rm, 3, MO_32);
@@ -4863,9 +4871,7 @@ static bool trans_SM3SS1(DisasContext *s, arg_SM3SS1 *a)
         tcg_gen_rotri_i32(tcg_res, tcg_res, 25);
 
         /* Clear the whole register first, then store bits [127:96]. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element_i32(s, tcg_res, a->rd, 3, MO_32);
     }
     return true;
@@ -6307,7 +6313,6 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
         TCGv_i64 t2 = tcg_temp_new_i64();
-        unsigned vsz, dofs;
 
         if (acc) {
             read_vec_element(s, t0, a->rd, 0, a->esz + 1);
@@ -6317,9 +6322,7 @@ static bool do_scalar_muladd_widening_idx(DisasContext *s, arg_rrx_e *a,
         fn(t0, t1, t2);
 
         /* Clear the whole register first, then store scalar. */
-        vsz = vec_full_reg_size(s);
-        dofs = vec_full_reg_offset(s, a->rd);
-        tcg_gen_gvec_dup_imm(MO_64, dofs, vsz, vsz, 0);
+        clear_vec(s, a->rd);
         write_vec_element(s, t0, a->rd, 0, a->esz + 1);
     }
     return true;
-- 
2.43.0


