Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C353C77A834
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 17:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVDQa-0001Ui-5i; Sun, 13 Aug 2023 11:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVDQS-0001UR-UT
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:54:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVDQJ-000357-GP
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:54:39 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc8045e09dso21928495ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691942067; x=1692546867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oMtp5cKAKiBFXlWN8P5tcieCRda+DasFw5ToSvYX0dQ=;
 b=q8RZIzZy6psu/fxTyi6di6B9hKkoM1zMG0WqJzZdlPPEz+b29dy7955pnkXHaqZUhL
 l3x1IQfLOsJzV7dU//RkpcvdvnMnLGsRf8AVEjmdBdxiQYn0Dg+flamFnYJYHavGVQyO
 7tA908VLUtySKaLpnnduB4JUUSyyJts1JRpEBwIhBDhAo/ih+jyUJbkviBFHpcdXajWZ
 ISqUzcVlKUdtlnPTCtzg6/8Kl/jvF365MRXVs/xLxzNPJ7Mc8emcSKEjHEAk+veMZtC0
 HnGUWR985wctxQu0ycg8Q6YekzKkdHBoOVb7kj6m6Kjeh718unN/MP9J12zzV2bXLk5N
 mNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691942067; x=1692546867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMtp5cKAKiBFXlWN8P5tcieCRda+DasFw5ToSvYX0dQ=;
 b=j95rErvCIqqxtRfubaIbWtCcMxEPE4gbR6SRxFc9XY0cx1tkr3l69BFfxrDCBrNVdz
 R2dQFlDnMXQ4/+3Si0gKWmm1CcqoDfNoobRurrZh7wBicqdMarvXuQepeXD57Zy4eJaL
 ITjJnsxAFR22Gjm8iv298UcEW6MR8vTLKEaKUalKfsauz+gQID1+zYBrt66OvOHuACiK
 m/DXiPwNzO/EN8pdhBfil209+HoagJ5JaqlAVitJC+lrpVEtkJrNi99kB2fPBWpvb7fk
 DX0Ec6d4tfAYGVxZ5SwyxIxCr4OIWgf4t/s8dd9zX2OD/ReEGncP/T/DdambXiUg9SyD
 Q2Rg==
X-Gm-Message-State: AOJu0YzY1+bhRdn3JyxTZyGDZT2DoT4I/Ty1dAQiVNCZfemfoVPIHYlt
 6tYH2hnK+9WGQiYfJnAbqsdwyk+Fi/w0iI7GA8U=
X-Google-Smtp-Source: AGHT+IEz2OZ3q03Y+FfmN7kNd8VAVyVhY/N+Yug7dKNLkolDpzVLRCW9LuZ/ehJYKYKpUnkslOCw4A==
X-Received: by 2002:a17:902:ce82:b0:1b8:c580:5fb9 with SMTP id
 f2-20020a170902ce8200b001b8c5805fb9mr5732455plg.14.1691942067476; 
 Sun, 13 Aug 2023 08:54:27 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:8022:692c:81e3:39db])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902744900b001b7e63cfa19sm7587127plt.234.2023.08.13.08.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 08:54:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH for-8.2] target/m68k: Use tcg_gen_deposit_i32 in
 gen_partset_reg
Date: Sun, 13 Aug 2023 08:54:25 -0700
Message-Id: <20230813155425.341598-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 37954d11a6..15b3701b8f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -697,19 +697,12 @@ static inline int ext_opsize(int ext, int pos)
  */
 static void gen_partset_reg(int opsize, TCGv reg, TCGv val)
 {
-    TCGv tmp;
     switch (opsize) {
     case OS_BYTE:
-        tcg_gen_andi_i32(reg, reg, 0xffffff00);
-        tmp = tcg_temp_new();
-        tcg_gen_ext8u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, reg, val, 0, 8);
         break;
     case OS_WORD:
-        tcg_gen_andi_i32(reg, reg, 0xffff0000);
-        tmp = tcg_temp_new();
-        tcg_gen_ext16u_i32(tmp, val);
-        tcg_gen_or_i32(reg, reg, tmp);
+        tcg_gen_deposit_i32(reg, reg, val, 0, 16);
         break;
     case OS_LONG:
     case OS_SINGLE:
-- 
2.34.1


