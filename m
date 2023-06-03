Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E1D720D66
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:39:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7j-0003Ak-Gt; Fri, 02 Jun 2023 22:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6Y-0000Yi-Rw
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:00 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6M-0004pt-SA
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:58 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2566f66190dso2373421a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759685; x=1688351685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ8F8Kb2wJ2DKdMIB35CF/n9u+q7RrVY1fodNqQRp9I=;
 b=c41H7RHtdP8dTTtMU++Ah94Krs9OQfFvZPzpV3LrEVDBoYAxSkeATbO5wQIaWrqJQL
 AwdcdXRryaeMapjssm3DABAS+qbP5b/s6Fjt0jkNmKGJ7uOuaUB+B7QHfl//l/V3lXJ2
 gPqKiuQXwjnhc2x2SEUgsxPBZoToUsu80bLUblGibJBauzZ1SchjJYobwC+fKd+eCUgj
 b7O3h1DWsxeYfvkhnYiauY4AA7PIfuCs1bFj4sWvwyBKAqlFLMBAoQDnkkIqN4BO1L7x
 lAWuZRGfaKSe65QMnr0/5TVDpNR/ZP0B8DTyc+KsXb1yoPPZyEF5QDZjqX6HCGXUe5yL
 +9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759685; x=1688351685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ8F8Kb2wJ2DKdMIB35CF/n9u+q7RrVY1fodNqQRp9I=;
 b=iu8XXdAiWJ5KyosZPgKPOWX3OcvUiLC04az7g0/17cmiIBn/m8uISx993SR8hSni0Q
 wmrlV/fsdUahnU0aLMzw38VE40+EiE6HzZxpLYuKBU+LwrZXCt1ioHuweuL80NEFpOi4
 WYqc180/CxSVKas44omODJKl+NB3eqBFHkDXFYGeAZ2AUH1YjVeb+lxmX5jX1Dw2zkeH
 vr3SLtWR/XynSfnNbqmrtBWHDY2LDNxqjbCE2TaKM1hh8OYwheT+mA1iwMWtJBQE0Eet
 hj1JoGocLUofQX11GdfNO5HveHFAZ0bxVeBXIuVlP/mmlX3PiufpmqP8jIW/gvsjQcx+
 qxdQ==
X-Gm-Message-State: AC+VfDzQkKnBkVzCdY4b2OgHtG7Wk0sm0hYEk4iLxh26yWVnFB/RD2/x
 SV3Q719UADBidO/MP8gyfP2awTRLWcHfMJ2VBKo=
X-Google-Smtp-Source: ACHHUZ7lredXQot5JooQKoqerUhUQx8VeMv1NuddohyF8K7put2QRHygQ5LNJkMaGuUId573dGCGaw==
X-Received: by 2002:a17:90a:1d6:b0:256:69e2:7b7b with SMTP id
 22-20020a17090a01d600b0025669e27b7bmr1598449pjd.7.1685759685099; 
 Fri, 02 Jun 2023 19:34:45 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 20/35] target/riscv: Use aesdec_IMC
Date: Fri,  2 Jun 2023 19:34:11 -0700
Message-Id: <20230603023426.1064431-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

This implements the AES64IM instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 08191b4b2a..64004b2329 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -270,17 +270,12 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, target_ulong rnum)
 
 target_ulong HELPER(aes64im)(target_ulong rs1)
 {
-    uint64_t RS1 = rs1;
-    uint32_t col_0 = RS1 & 0xFFFFFFFF;
-    uint32_t col_1 = RS1 >> 32;
-    target_ulong result;
+    AESState t;
 
-    col_0 = AES_INVMIXCOLUMN(col_0);
-    col_1 = AES_INVMIXCOLUMN(col_1);
-
-    result = ((uint64_t)col_1 << 32) | col_0;
-
-    return result;
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = 0;
+    aesdec_IMC(&t, &t, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(sm4ed)(target_ulong rs1, target_ulong rs2,
-- 
2.34.1


