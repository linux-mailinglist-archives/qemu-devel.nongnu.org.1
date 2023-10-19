Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFB07D01BA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXmF-0001gI-Ip; Thu, 19 Oct 2023 14:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm2-0001CF-Lz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:34 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtXm0-000702-Ky
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:29:34 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso43195b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697740171; x=1698344971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/9nFH074W8LbHLqCjcMRWprK189i8aGWQz4eNu3oG1o=;
 b=zh0kQBnkOyd5FEa6nqlPKJapwabOdbaN7nICILgOu35v+V0ZQk+R5zYI1i6T7tJYKO
 PJvzWxNKoKhZlA2DHugI3fbfppOEt+vgEFyDgqhAB1n3LnqQNfccSmXSl1j/hzEzclb2
 OzehKDxLroEhFLfUsvj8JsnobGbIQdjXQxJYlxldDd7QfrxS45Q+02RKwm65JzteAaaj
 Xtogt7YiUE1cegFR846WpSS0cKr91iz7omLESsbAEd5KpGx5M1PUw+2DL1LipFEfQ4TB
 L0RZxCF9JWhQemtfoyE5fUvh0fRhHdvff5qYQEPVLPsvWkU0oaQ6jyDikrI245cnT1uA
 WljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740171; x=1698344971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/9nFH074W8LbHLqCjcMRWprK189i8aGWQz4eNu3oG1o=;
 b=rKSqwmCM8NdfE2onWkkbRCensXepn8POspXG1plqtCoNZh/9k0aBDAS07wN/7SjvR1
 bMMc/jGk96rSGl5qoMHy1euxwjhwqJ9wAEJyYdsXqkQi8APXdH1qw+L8Re+IcrLrxCOf
 sfPfG5L6MWoVxRiPrfljJ471PkRJ+E53brOdc0glPU5WHn/PCgmG2JLP8ebAWbA06DH8
 8KykXZdE1p+OzUth6Klmr2t9yjOfkMlbCD6HCzYjyW8vKdHpN/pXUXJWrNAzyrQyeFV4
 vSdFcloj8PFM/8ucHuTYZm/fhE9iLSaAEb7SqfwLszSRPboiMe3ybtik4WLFMrLMO19s
 31WQ==
X-Gm-Message-State: AOJu0YxJ6FWDv45A2HJ9jtPzMpTmSN886RA4RzOsRVJCkqOZS1+jGnrG
 qdR/UPwmCnQv+IQ4uhKSBmQQdTU8L6YuIgy3VKM=
X-Google-Smtp-Source: AGHT+IHBfsBXA1oTdpttybBhhNOYfVmbo+/C+zQGSxnCvLSvPwoKTXnp935TLvsF+iijr85eFf40zw==
X-Received: by 2002:a05:6a20:3951:b0:15d:8366:65be with SMTP id
 r17-20020a056a20395100b0015d836665bemr4069051pzg.9.1697740170928; 
 Thu, 19 Oct 2023 11:29:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e1-20020a630f01000000b005b856fab5e9sm72216pgl.18.2023.10.19.11.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:29:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-arm@nongnu.org, laurent@vivier.eu,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com
Subject: [PATCH 3/7] target/i386: Use tcg_gen_ext_tl
Date: Thu, 19 Oct 2023 11:29:17 -0700
Message-Id: <20231019182921.1772928-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019182921.1772928-1-richard.henderson@linaro.org>
References: <20231019182921.1772928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/i386/tcg/translate.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 0c81e066de..d420ed8f0a 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -701,33 +701,11 @@ static inline void gen_op_movl_T0_Dshift(DisasContext *s, MemOp ot)
 
 static TCGv gen_ext_tl(TCGv dst, TCGv src, MemOp size, bool sign)
 {
-    switch (size) {
-    case MO_8:
-        if (sign) {
-            tcg_gen_ext8s_tl(dst, src);
-        } else {
-            tcg_gen_ext8u_tl(dst, src);
-        }
-        return dst;
-    case MO_16:
-        if (sign) {
-            tcg_gen_ext16s_tl(dst, src);
-        } else {
-            tcg_gen_ext16u_tl(dst, src);
-        }
-        return dst;
-#ifdef TARGET_X86_64
-    case MO_32:
-        if (sign) {
-            tcg_gen_ext32s_tl(dst, src);
-        } else {
-            tcg_gen_ext32u_tl(dst, src);
-        }
-        return dst;
-#endif
-    default:
+    if (memop_size(size) == TARGET_LONG_BITS) {
         return src;
     }
+    tcg_gen_ext_tl(dst, src, size | (sign ? MO_SIGN : 0));
+    return dst;
 }
 
 static void gen_extu(MemOp ot, TCGv reg)
-- 
2.34.1


