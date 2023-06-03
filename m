Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E66720D51
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H6S-0000T6-VK; Fri, 02 Jun 2023 22:34:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6E-0000Jz-Bl
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:39 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H67-0004hU-IL
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:37 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5585f2f070bso1975903eaf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759670; x=1688351670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqOStWj9wy4vSlw/JP9FJsk77s8bELBPoB35SE08RZM=;
 b=WulAntH4HE494wgcKNFlm7uZR/9kx2mCN6tD/4dh5C3ACPdKg7Dw3/yaDQ8fZNWrBC
 8iLvOMXWVKEb6g2j8snAnRY9/Hmh5GKCgQrAfglN8ZpAs0jtsX1U1zVQGQTTYPiAtFni
 vOhaR1OKU3CAd4u+QX5zLDOWHGRJh9FHV0wpWG6YgDBPAr549mCeTvKN5k6al/Al6Ki9
 Pt05l+3RTE1AsWecOamac0yfGmjIwohCg6sdsxm6Em/CLO9bd/YWCKSVlZy/SmIN3spN
 IHg8LIrLnf02h8bQkauGTexDzowD8L9O/i9KXk4uiBWH4dZyfOC+SqUnib2I0iXZDCLI
 sEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759670; x=1688351670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqOStWj9wy4vSlw/JP9FJsk77s8bELBPoB35SE08RZM=;
 b=MTYeb+njlBtRLVCUX7NMeLFK0CxKh5IApaogj8ok4vWmHmIdrtPJz3/wajuTgCOE1a
 qHucmvMT/l9i+usyPU3W1Q9UlnfVaoNXZDkteB6iiI+gD+XqoBt7sG9f+MWoOV4MP6BK
 PzNXXS87QSTW9EvZDBU3CQo7K+I0gJkgW1zFnUihGizWJLpehZczSLO6hov/iJDrB6z1
 QnXEwO2yCD+xLYp04EIgaiLi6Qwoqw4VXr51cSX/Ex5qZkD4xDHgJJ1mHCnw0S2x0JIW
 hDr+2x/+5ZxA6xoDhW+aFX+qG5wwcHkZPAwPIs+ILvnMXqsTselgEk5UHkuMsickvpQV
 /C7w==
X-Gm-Message-State: AC+VfDxJdNtHksv9rZ0vosFW0et7r+PRtbFnHGQsO9f/GMmwmTNsq79i
 DjcWnHFdexe6N4nT+IMLrJadGb6/SzfJOKTiWF8=
X-Google-Smtp-Source: ACHHUZ6Zp3NpI0IFZC90XcTdO5xbFxfmBGtgdydhL6dF2odJZCEpCfhEm4TqnjD4N6s8WRk1C82TAA==
X-Received: by 2002:a05:6358:7208:b0:125:83c8:72f6 with SMTP id
 h8-20020a056358720800b0012583c872f6mr15392888rwa.0.1685759670394; 
 Fri, 02 Jun 2023 19:34:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 03/35] crypto/aes: Add constants for ShiftRows, InvShiftRows
Date: Fri,  2 Jun 2023 19:33:54 -0700
Message-Id: <20230603023426.1064431-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

These symbols will avoid the indirection through memory
when fully unrolling some new primitives.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/aes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 72c95c38fb..1309a13e91 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -108,12 +108,58 @@ const uint8_t AES_isbox[256] = {
     0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D,
 };
 
+/* AES ShiftRows, for complete unrolling. */
+enum {
+    AES_SH_0 = 0x0,
+    AES_SH_1 = 0x5,
+    AES_SH_2 = 0xa,
+    AES_SH_3 = 0xf,
+    AES_SH_4 = 0x4,
+    AES_SH_5 = 0x9,
+    AES_SH_6 = 0xe,
+    AES_SH_7 = 0x3,
+    AES_SH_8 = 0x8,
+    AES_SH_9 = 0xd,
+    AES_SH_A = 0x2,
+    AES_SH_B = 0x7,
+    AES_SH_C = 0xc,
+    AES_SH_D = 0x1,
+    AES_SH_E = 0x6,
+    AES_SH_F = 0xb,
+};
+
 const uint8_t AES_shifts[16] = {
-    0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11
+    AES_SH_0, AES_SH_1, AES_SH_2, AES_SH_3,
+    AES_SH_4, AES_SH_5, AES_SH_6, AES_SH_7,
+    AES_SH_8, AES_SH_9, AES_SH_A, AES_SH_B,
+    AES_SH_C, AES_SH_D, AES_SH_E, AES_SH_F,
+};
+
+/* AES InvShiftRows, for complete unrolling. */
+enum {
+    AES_ISH_0 = 0x0,
+    AES_ISH_1 = 0xd,
+    AES_ISH_2 = 0xa,
+    AES_ISH_3 = 0x7,
+    AES_ISH_4 = 0x4,
+    AES_ISH_5 = 0x1,
+    AES_ISH_6 = 0xe,
+    AES_ISH_7 = 0xb,
+    AES_ISH_8 = 0x8,
+    AES_ISH_9 = 0x5,
+    AES_ISH_A = 0x2,
+    AES_ISH_B = 0xf,
+    AES_ISH_C = 0xc,
+    AES_ISH_D = 0x9,
+    AES_ISH_E = 0x6,
+    AES_ISH_F = 0x3,
 };
 
 const uint8_t AES_ishifts[16] = {
-    0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3
+    AES_ISH_0, AES_ISH_1, AES_ISH_2, AES_ISH_3,
+    AES_ISH_4, AES_ISH_5, AES_ISH_6, AES_ISH_7,
+    AES_ISH_8, AES_ISH_9, AES_ISH_A, AES_ISH_B,
+    AES_ISH_C, AES_ISH_D, AES_ISH_E, AES_ISH_F,
 };
 
 /*
-- 
2.34.1


