Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77217081D0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6b-0004JE-7F; Thu, 18 May 2023 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6T-0004Dw-TW
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-000817-UF
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d4so19278015e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414275; x=1687006275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ushDbgyrUsE+lBS91PL1NoncrPh1O6I8HngN7CgBijs=;
 b=QmSNgZRtFbirDBInrUNSxg+okdze9CPE26DVB7MrWxy9vjZA5OTZzi5RxbqltDXKNe
 CFnd+lYm6ypi694mKMKf8Zicx87aNaMXIcJx9j+rB9iZttfqkw/8gyrQNZB1DU6n55ZQ
 ImVPaV2rv32gmYCSE6e8GHL3zFPh06FWFhsZQaA02d72KVqrmOblNh+FL4Ts7E6Qqn/p
 oacW/UrysPBXKuR/obOCIcmU6ky06Sydd99a5QTGptuIsSnlNHRbjDOQdW0waFMJ05B1
 kMDWuSkdagtp/WCl3hzsvP/FmeZ6qi78CxfCHhfRDtQMN0KNbzArQcVpt1sogU1NNx92
 XkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414275; x=1687006275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ushDbgyrUsE+lBS91PL1NoncrPh1O6I8HngN7CgBijs=;
 b=erk2+i+WAj2WMglAAjO/cvycworALm28pQ9LCmhVg178mDAoyHEt6s4wSfuxpzSH3w
 HOAjlTaF5Rrn8ayRGB/5X4AEfjnsLMIy9t1zprfH98KHAxFj/0s/M2xAjDkLsEeNpIqI
 NZaEj9tiBozEzI281XWJUQIjUSjNzCJecO0nYsnG9jaSYXRrWOINzKJA30XdztLTDp+n
 o928j8cSCuL3hTi+IqLOc40GwwTa5mNPrpsTPNivUq2AQWHZTMjgBT+Sh5523peMrt/H
 beg2S75zmm+gwvnVJ7qiPZmRpMWx6m9W3nvuKxm6WjOVmGdjSgAKNGchkGwwIw2dYVGx
 vC7g==
X-Gm-Message-State: AC+VfDxLJvCyJST/D6EwOj0i6IYblhHq7U9dk1oPg1aJggyMyuNyoEdH
 OHi7PJt8nB9b0wynK/3rdVsSOlHPYLEYODv6jM0=
X-Google-Smtp-Source: ACHHUZ5iUlwLNfmhjX7MPoVIpAw084CBNfIVK++KGKHmN8iI3EnkAWpE3FDbJjJODIc9VsdtOdS9zA==
X-Received: by 2002:a7b:c393:0:b0:3f0:7e56:82a4 with SMTP id
 s19-20020a7bc393000000b003f07e5682a4mr1496537wmj.18.1684414275276; 
 Thu, 18 May 2023 05:51:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/29] target/arm: Replace bitmask64 with MAKE_64BIT_MASK
Date: Thu, 18 May 2023 13:50:52 +0100
Message-Id: <20230518125107.146421-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Use the bitops.h macro rather than rolling our own here.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-9-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8fa08cc2518..c744477d71a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4288,13 +4288,6 @@ static uint64_t bitfield_replicate(uint64_t mask, unsigned int e)
     return mask;
 }
 
-/* Return a value with the bottom len bits set (where 0 < len <= 64) */
-static inline uint64_t bitmask64(unsigned int length)
-{
-    assert(length > 0 && length <= 64);
-    return ~0ULL >> (64 - length);
-}
-
 /* Simplified variant of pseudocode DecodeBitMasks() for the case where we
  * only require the wmask. Returns false if the imms/immr/immn are a reserved
  * value (ie should cause a guest UNDEF exception), and true if they are
@@ -4350,10 +4343,10 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
     /* Create the value of one element: s+1 set bits rotated
      * by r within the element (which is e bits wide)...
      */
-    mask = bitmask64(s + 1);
+    mask = MAKE_64BIT_MASK(0, s + 1);
     if (r) {
         mask = (mask >> r) | (mask << (e - r));
-        mask &= bitmask64(e);
+        mask &= MAKE_64BIT_MASK(0, e);
     }
     /* ...then replicate the element over the whole 64 bit value */
     mask = bitfield_replicate(mask, e);
-- 
2.34.1


