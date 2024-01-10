Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D989682A421
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhKe-0004xu-SZ; Wed, 10 Jan 2024 17:45:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhK7-0004l2-Eh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:25 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhK5-0002ve-Mo
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:23 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78333a8d428so114928885a.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926719; x=1705531519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq7I5R53pVNdI93EJRMub3T9kBHS1RS5Ymgrbh0dENY=;
 b=WqBUN6MacR6Ims/gcjGWLdoJyRQ1j5wpnXy5rwXxHVYkOmG2moa6H1lPqqWIKlRdrj
 3dOIP3Z0gnufbGRNSgdacF8O8wvDeL0Ww7aoNuuCOwVLslHcMo06ztGy9t8eb6RGwmSK
 9LehmR6XW2L5/T1bkpY1E1m/b8pq2coYmowW+mUT6UcpfBznRG2rsQzKE5gRB9OgPLW3
 jwedtrkrphDCeJnzdXcFdqqmofwK4bEEkCKYKniKDtyAs0FCgv/1cPe/IEno8kq6c9qy
 qVmPDdzP+MLYwir3NHFEB1qOyLNP0Vu4JqNLLOhxOJVjk/+X7SCV1UcT8X2PWrr9FV8F
 ijKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926719; x=1705531519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iq7I5R53pVNdI93EJRMub3T9kBHS1RS5Ymgrbh0dENY=;
 b=B7fgJCKpmOdGeX4ADdJR2Q0vzTMmC0lDKsNhkQ/QnHSMTOKxyjxH3vFihMLwaQyoXY
 QINQ7lpQmPV7er6QC3Mvw9Ij+ffLhW2GuGLxvYwnUIs3vz/CH016zRej/i4xf5i6SQjt
 gjo+YJLO2SfWd8zpjQkmq6aN4JXYOEfG1m/lFYoKH/FFLFca6/YnAqVywVyPeqSIP4oh
 XoHajX6L6GoWva0kbLzBFaUud5yxIngguAT7Nwomu8Wu7FMzX0RnMJi7EDzfqmX1hMtN
 c79iRV4JN0UwCxFeBAW2jAV5/LPer3mdVMthxCyOTrrTHIRAwI3G1WBE41UmMGLSvzqo
 dAvw==
X-Gm-Message-State: AOJu0Yzu4ukBjZW74Pd3mH+XSXoclQYIZiJKQhBH0wpBGNmpLr1Dbku5
 u6EIeDYtphrGwPRgaIrGuBF/7Kn7PS9sQDI+UzzE3dsPZxLplzJ3
X-Google-Smtp-Source: AGHT+IGhztKYVqkBD6b0OGFu6QWkGu1Ht4Wc/aQyMwFBGjS9+QwkQQDtbJpPuT0Gl6jdhPfxwW1/sg==
X-Received: by 2002:a05:620a:1130:b0:783:376c:7b41 with SMTP id
 p16-20020a05620a113000b00783376c7b41mr1170635qkk.45.1704926719510; 
 Wed, 10 Jan 2024 14:45:19 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 09/38] target/alpha: Use TCG_COND_TST{EQ,NE} for BLB{C,S}
Date: Thu, 11 Jan 2024 09:43:39 +1100
Message-Id: <20240110224408.10444-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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
Message-Id: <20231028194522.245170-33-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108205247.83234-2-philmd@linaro.org>
---
 target/alpha/translate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 89e630a7cc..49e6a7b62d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -482,10 +482,10 @@ static DisasJumpType gen_bcond_internal(DisasContext *ctx, TCGCond cond,
 }
 
 static DisasJumpType gen_bcond(DisasContext *ctx, TCGCond cond, int ra,
-                               int32_t disp, int mask)
+                               int32_t disp)
 {
     return gen_bcond_internal(ctx, cond, load_gpr(ctx, ra),
-                              mask, disp);
+                              is_tst_cond(cond), disp);
 }
 
 /* Fold -0.0 for comparison with COND.  */
@@ -2820,35 +2820,35 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
         break;
     case 0x38:
         /* BLBC */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTEQ, ra, disp21);
         break;
     case 0x39:
         /* BEQ */
-        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_EQ, ra, disp21);
         break;
     case 0x3A:
         /* BLT */
-        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LT, ra, disp21);
         break;
     case 0x3B:
         /* BLE */
-        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_LE, ra, disp21);
         break;
     case 0x3C:
         /* BLBS */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 1);
+        ret = gen_bcond(ctx, TCG_COND_TSTNE, ra, disp21);
         break;
     case 0x3D:
         /* BNE */
-        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_NE, ra, disp21);
         break;
     case 0x3E:
         /* BGE */
-        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GE, ra, disp21);
         break;
     case 0x3F:
         /* BGT */
-        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21, 0);
+        ret = gen_bcond(ctx, TCG_COND_GT, ra, disp21);
         break;
     invalid_opc:
         ret = gen_invalid(ctx);
-- 
2.34.1


