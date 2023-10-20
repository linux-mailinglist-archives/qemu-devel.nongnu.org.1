Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D3D7D1762
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwP5-00023p-8a; Fri, 20 Oct 2023 16:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP3-000234-01
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:29 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwP1-0001E6-Ee
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:47:28 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso1114471b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834846; x=1698439646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5v0gDw2hca7aeL8Edx367HZb46Y2K4iTJAYsw/i0ri0=;
 b=OrRLJ9LsKsAbcd+zobt+lUH1GAWYJe+V5y059G4e8S8wykP3tW80Sc+47Vff/L/AIw
 CHNFhFEVDu193ECCWp3hs1aHUcBR40J9Nkldmt1/JFm8wqDyWVOObpZ5dyjeHfYbxB2E
 +D28kdn1KX2cj3C6uwbNB+5yTMyS4wnI2gHrVFgzBz4j6gPoy9vFkyfcTlfMvBHnnSGk
 IuOJa3PKfIfIZWAHWzb90qRA5JntQZYDxY++4T331TEa/HBTRGf+BRY+AHGe4tONzZe+
 g+8os+0wAmwcJYcsvplveOKAAi6d/sAQAoLCXVIriLBdsE1rHU/xnRyN66KIwKahDfoi
 OXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834846; x=1698439646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5v0gDw2hca7aeL8Edx367HZb46Y2K4iTJAYsw/i0ri0=;
 b=Ws2xFwYbwgDyC3rdq+IMCLS9jfRgfPlFRItV6R9xBz4y7fC86kPdVUrXkYCxC0Ixyy
 +LoRM8lG5XTrkiaeWAwAfDaG9PRfBwKkITqbqeLzYiOjuH7ywXOCrfmA6yq6ttkM8EiE
 LU9AQ3M6lSlfFUjgNFvVMk9Fbl48dMDh2sXwkz2gMevjmrefG7vufOY5grx8En1Y262r
 b6YUrQsUa/FhJs2EWLVy2qy7tvqM9BEGfue4CQMpTu4ma/Ba4LIQelibgryBCYl72/JC
 JsL0agXpz+0x9vP1/83lQZeDVJyz9qNcRM17/LVgPdTk4SW+kO5jNcHY+As1TNEA9IOW
 94mA==
X-Gm-Message-State: AOJu0YxO9j+xGz/UDqRHhDx9lvkMRWZg2Bo0vpXxNATiwqpmofATCUlX
 1GGRl/h7lnkT5Se3dqoCt8QhdItgP8w4V4hDJNg=
X-Google-Smtp-Source: AGHT+IGG13zfi/60RwvpJFt/pNk9ik4faDTA19rsxv4kQ+dQfULk6JQm6uXBT+e4g4+NWr7a3Aa+7g==
X-Received: by 2002:a05:6a21:3b4a:b0:14c:d494:77c3 with SMTP id
 zy10-20020a056a213b4a00b0014cd49477c3mr2963136pzb.33.1697834846222; 
 Fri, 20 Oct 2023 13:47:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u7-20020aa78487000000b00694fee1011asm1946775pfn.208.2023.10.20.13.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:47:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 61/65] target/hppa: Return zero for r0 from load_gpr
Date: Fri, 20 Oct 2023 13:43:27 -0700
Message-Id: <20231020204331.139847-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9b60924057..ce2aff8c4e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,7 @@ static void cond_free(DisasCond *cond)
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_i64 t = tcg_temp_new_i64();
-        tcg_gen_movi_i64(t, 0);
-        return t;
+        return ctx->zero;
     } else {
         return cpu_gr[reg];
     }
-- 
2.34.1


