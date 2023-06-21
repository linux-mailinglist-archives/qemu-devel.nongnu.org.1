Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 974377383A4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBwo8-0006n9-SS; Wed, 21 Jun 2023 08:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwno-0006db-Kx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:18 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBwnn-0000I4-1Z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 08:19:12 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51bdd67a306so598147a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 05:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687349949; x=1689941949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpguwOP2tBZG1Q3kxp3nwyx4GamestPy42HvjJG3rb4=;
 b=Z1y6dCSEYPvBp66y6CGsYtJQfyFXipJO36B9eL1TzGJa81yNYmrmbRETlgrRIhMjlU
 uOXDYzfRozIUEpjB8gFu21Z0PwYwPIWgnuG/pbY3RTQ7tuSjh8W3a1T+QAkMhu1riw15
 iRzqki5os7jDG8oQbAoIpR31sv5Gub1lBDYt0g14wf1YfMVIlsA/uhcxQfkl0JMN/yo1
 /E6sAS1FmjcMyrmoMXNjPICsdejQVdVYxv2lJhdVpKzSCfu3Bp0scQ4DyT8QJi4UNYgm
 B+QtCPGhwdNxmqQhfU4YWhJ8nssA0YzJbCAMD2++ZO3kXkLIFiVJLBJt/OdnvCbRvkzX
 bigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687349949; x=1689941949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GpguwOP2tBZG1Q3kxp3nwyx4GamestPy42HvjJG3rb4=;
 b=Jg0ISQ2K/y6YMmFxoSeahGB2imzYCM0D2a2N0X2NrNF/fX8tVbDZ0nlbWeXiPDguVF
 MQNKkBP5uywtbU6V3Q8mQ8q7OAMpdi9smXfqt5STUDOX0+2Y8JgFbc+t6K+vRNDrSlio
 lbGjmelksmxI3jzoYzlty0mC8a02cz9Oj2vqjhcBwQXDfYY27DeUUCGeFKJBDP0el2MJ
 SyhxUu+JaMVDfXERslk9TTi6G6VoOYFJyLtkrY19PHxEmsgg3iqP7qMTxtreU3r2F4Qi
 zajoTwfqSPoKB3dlTBMj7hJHzM1qvOQ+gcWo3iO/jVmuAVOcJ8TTCYRxL8KeP4N+xWW2
 zpmw==
X-Gm-Message-State: AC+VfDzkh425LnOtMR9/ItILAkgKckzJvyg+5wzcoqdxNWt9Hbpwc8kg
 z9V71I880DHe2qwiNQbo1wUVUK0kDiF2+etCW2YRrKlM
X-Google-Smtp-Source: ACHHUZ7xbIzTO1PG7JZuGT38Q3feafJEqfVTewnvr9Q9xw5DotoR58/yOZtRjJEAgHicVVr7Yfk98g==
X-Received: by 2002:a05:6402:45a:b0:51a:2013:583 with SMTP id
 p26-20020a056402045a00b0051a20130583mr9985016edw.13.1687349948668; 
 Wed, 21 Jun 2023 05:19:08 -0700 (PDT)
Received: from stoup.lan ([176.176.128.70]) by smtp.gmail.com with ESMTPSA id
 s6-20020a056402014600b0051bdf152295sm543176edu.76.2023.06.21.05.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 05:19:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 4/9] target/arm: Support 32-byte alignment in pow2_align
Date: Wed, 21 Jun 2023 14:18:57 +0200
Message-Id: <20230621121902.1392277-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621121902.1392277-1-richard.henderson@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52d.google.com
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

Now that we have removed TARGET_PAGE_BITS_MIN-6 from
TLB_FLAGS_MASK, we can test for 32-byte alignment.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 13c88ba1b9..286497ebf9 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -900,13 +900,7 @@ static inline void store_reg_from_load(DisasContext *s, int reg, TCGv_i32 var)
 MemOp pow2_align(unsigned i)
 {
     static const MemOp mop_align[] = {
-        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16,
-        /*
-         * FIXME: TARGET_PAGE_BITS_MIN affects TLB_FLAGS_MASK such
-         * that 256-bit alignment (MO_ALIGN_32) cannot be supported:
-         * see get_alignment_bits(). Enforce only 128-bit alignment for now.
-         */
-        MO_ALIGN_16
+        0, MO_ALIGN_2, MO_ALIGN_4, MO_ALIGN_8, MO_ALIGN_16, MO_ALIGN_32
     };
     g_assert(i < ARRAY_SIZE(mop_align));
     return mop_align[i];
-- 
2.34.1


