Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C55786185
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRe-0005S3-JT; Wed, 23 Aug 2023 16:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRa-0005Fb-Nf
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRY-0006Cn-Uk
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:10 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a440a8a20so3312459b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822427; x=1693427227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gIrreZ5G8/kGRX0I9xt2390vEuxRjWw6n/lcuZL2BuM=;
 b=NFzvhsQ5NGLhyR4T/PoXauTno4VzvgKLRLgNQ6l355ZnCAXhJ4m1yA0KtQ+xx2AOb1
 mTJlIyIxDtCAOlxIJ6n0f65SOZRSiO3TqLnieLfX1LQmKz3rdTKEIEr2BZtv09j9BAgG
 Rhb1pJLICioux2BpbDBVWHCA8GeUsqekRZsC1xVTgr+0Olzph9RToJ8AtH/2HieY+XQI
 rZ01bzYaW/t9iwQsYqaxLtrTP6RE84lFM7d/2V7IGBKN9+TuOblTtgH+vkjK/mk1wihF
 dfuMe4cEFKFyPdLjuVPQBZ4GHIwVJtmZ4mjRWVKAiFD85s2/PRkudWGoezXss7uT+CoQ
 gNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822427; x=1693427227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIrreZ5G8/kGRX0I9xt2390vEuxRjWw6n/lcuZL2BuM=;
 b=iaE+tm+WhUksKz0uO1hq00fwtXwYaY+A+/ZOxRn1mD9Vsxs5WMd2hAfvKWTmpq/uhb
 9q6IlpfTF1x3kBEnngAxtcck7qhRu/dwvSNlPtfw8nsJ/UEhPXl2TYiVIiAkka+4UjHC
 u2g6vIridHycfFBUNuaQQOLSyo1F3mzPUgXeLuX0zA7eyDxRZlu2moffyt21vXKuQ31H
 TMr1gh8tJ1whweou6qbDJ+FHAxTHxOw499SZLkFtaDCXR/wyx3N2bje3NHYEgpJZIpj4
 2llhAGPT3tuwqLIlT34WzkYQiwj2y3kE9TUXDR0dT4Ur/XnnWEm5bKkIegdutncrx/HS
 OTjw==
X-Gm-Message-State: AOJu0YwgDsR0bTHdT/SubT8Y+lgxZXgas7ZJEBfLXfXkEjlLNrbe781z
 UIg2Q1bgZVjoePQKVBZnP/BStcCddPxfOU7wUqc=
X-Google-Smtp-Source: AGHT+IEHoxwMsFm31NAXFFg5HDOcmm/W9JiAeSkrcayJ7Y3oZn0hVz13gvbazTK5gUB79kPAmS0GbA==
X-Received: by 2002:a05:6a00:24d2:b0:687:5c3f:d834 with SMTP id
 d18-20020a056a0024d200b006875c3fd834mr18022486pfv.11.1692822427666; 
 Wed, 23 Aug 2023 13:27:07 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/48] tcg/tcg-op: Document bswap64_i64() byte pattern
Date: Wed, 23 Aug 2023 13:23:21 -0700
Message-Id: <20230823202326.1353645-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230823145542.79633-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b56ae748b8..22c682c28e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1871,6 +1871,11 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     }
 }
 
+/*
+ * bswap64_i64: 64-bit byte swap on a 64-bit value.
+ *
+ * Byte pattern: abcdefgh -> hgfedcba
+ */
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (TCG_TARGET_REG_BITS == 32) {
-- 
2.34.1


