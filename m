Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8367DEA60
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:47:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMcp-0001RD-UD; Wed, 01 Nov 2023 21:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbD-0006bA-Em
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:20 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMbB-00023U-Pt
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:34:19 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso489857b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888856; x=1699493656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEHEJ2kNz1FEsr2Q2Yw9HpdWutXT14QU70zWCzMgwBQ=;
 b=j/p+mxCEGV9oqdr/6ho6Ewc2YCBepZ3/NunLPIlneM8bnlSIvsHy13GugZrE2q68AO
 eo1mmglA/ad6s9i5ZqaP7Q3C+mm8B6vfqHe+wC2bY+hXweoxVAFlRNZZ8crOwKgvOVf9
 WmzLuIRCThEDU6gdbBC8B4obgTDVKENVNYiFJNi7GLpsyVNYEyFun+gLsh9ddiLV0wzD
 +EAqJVBccXLo5rCTFzTjhnEvqJ9D0vMAmQnrP+BOMKZ+1VN8KRYn1RNpFFgWfV6VLJeV
 69mhjcXBFnSS7CY9QeHqlY3cGxZ64gsejm8PQ9r2EsDvFUwYl56cNc5KiHa0NTF17pvY
 dSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888856; x=1699493656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEHEJ2kNz1FEsr2Q2Yw9HpdWutXT14QU70zWCzMgwBQ=;
 b=ZP6agwbVceU0/b94N9gSVLv0AlXFdN2ux8lXAz1rIA4cKWvINCEtjju7zMILIlTDEb
 Z4+Cw0MBsc6BDOOSaTx52ezs/PQ6JR4uoBcGwaV3P618YX/p4FA7reEzibDCQ+R4AYQA
 uF6pWTb/iHyloLFB8+CCtRdqSmk1631RunftKJ6V/4BaQVz8jSP9XTP5gbfmllPuU2NY
 /b2v+CpUXq6USF/USB23tS7v2mJpzn00d2X0loJN5ghoRpZFkmwZZJjcUkvOpVbMdSQr
 xbwdccgi3Ctk4/iZKmTS86Y3Z/eIdo38n0D90oTwJsPBXknKU4P3eOnJMSsfWVGlRbL0
 570g==
X-Gm-Message-State: AOJu0YwOpp6oIjbRp/Ea5k8vMEaHYwLRxtRoIKc3CYUmtp3RUlVu9JEu
 uYU4x+HYd2Uj5tIbr/Ew243K/tZeFYv/HQHUEpg=
X-Google-Smtp-Source: AGHT+IFHcgaYc1MV6orI1Y6WxZUWXTUnQ98OAVEedh83f1sAJSaztbL/Nw1eEA/g8JvM3nR2nvwSjA==
X-Received: by 2002:a05:6a20:d404:b0:15c:cb69:8e64 with SMTP id
 il4-20020a056a20d40400b0015ccb698e64mr14751463pzb.25.1698888856039; 
 Wed, 01 Nov 2023 18:34:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 t2-20020a1709027fc200b001a98f844e60sm1918125plb.263.2023.11.01.18.34.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:34:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 68/88] target/hppa: Implement MIXH, MIXW
Date: Wed,  1 Nov 2023 18:29:56 -0700
Message-Id: <20231102013016.369010-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  5 ++++
 target/hppa/translate.c  | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 87db726d9e..22ec07f892 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -233,6 +233,11 @@ hsub            000010 ..... ..... 00000001 11 0 .....  @rrr
 hsub_ss         000010 ..... ..... 00000001 01 0 .....  @rrr
 hsub_us         000010 ..... ..... 00000001 00 0 .....  @rrr
 
+mixh_l          111110 ..... ..... 1 00 00100000 .....  @rrr
+mixh_r          111110 ..... ..... 1 10 00100000 .....  @rrr
+mixw_l          111110 ..... ..... 1 00 00000000 .....  @rrr
+mixw_r          111110 ..... ..... 1 10 00000000 .....  @rrr
+
 ####
 # Index Mem
 ####
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc68d5a263..47ca71e2a3 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2891,6 +2891,61 @@ static bool trans_hsub_us(DisasContext *ctx, arg_rrr *a)
     return do_multimedia(ctx, a, gen_helper_hsub_us);
 }
 
+static void gen_mixh_l(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    uint64_t mask = 0xffff0000ffff0000ull;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(tmp, r2, mask);
+    tcg_gen_andi_i64(dst, r1, mask);
+    tcg_gen_shri_i64(tmp, tmp, 16);
+    tcg_gen_or_i64(dst, dst, tmp);
+}
+
+static bool trans_mixh_l(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixh_l);
+}
+
+static void gen_mixh_r(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    uint64_t mask = 0x0000ffff0000ffffull;
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_andi_i64(tmp, r1, mask);
+    tcg_gen_andi_i64(dst, r2, mask);
+    tcg_gen_shli_i64(tmp, tmp, 16);
+    tcg_gen_or_i64(dst, dst, tmp);
+}
+
+static bool trans_mixh_r(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixh_r);
+}
+
+static void gen_mixw_l(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    tcg_gen_shri_i64(tmp, r2, 32);
+    tcg_gen_deposit_i64(dst, r1, tmp, 0, 32);
+}
+
+static bool trans_mixw_l(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixw_l);
+}
+
+static void gen_mixw_r(TCGv_i64 dst, TCGv_i64 r1, TCGv_i64 r2)
+{
+    tcg_gen_deposit_i64(dst, r2, r1, 32, 32);
+}
+
+static bool trans_mixw_r(DisasContext *ctx, arg_rrr *a)
+{
+    return do_multimedia(ctx, a, gen_mixw_r);
+}
+
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
     if (!ctx->is_pa20 && a->size > MO_32) {
-- 
2.34.1


