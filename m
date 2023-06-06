Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9699723E4D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIz-0007px-Jn; Tue, 06 Jun 2023 05:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIs-0007me-By
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:38 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIp-0004lo-2n
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:38 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so5882739f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KPPDeDn6HmhkRHJXZx9s3atuThp+qwK1U/xfMKKSLsc=;
 b=l8R6o9Cf8vkeBZc6YQZVcW6OtYk+1LuB5bcKvbP9qytwlQTD0/utOc68AQTQIblxbc
 wrHdOPWiQf2YlvVB6fotTo93dJvtKFR2SnG3TCRLZ5WwkL14kYkACKf745QBLBwPs8/Y
 Czjm865grwqsbSVO3BqNVd91s8WhVxKo8CndCh6enyzSSYbiw5HGDuy1O689b8VQ1Rc3
 hzdgKkbm62eto9SiUmsZnaRAPrXMfIC6wdbVpy+icatY+OJ3nd8jc4bo3VScXSZA/EP8
 rKrtiwL9Ad5xvwoxl2uM5kj1VX+6wzfBybPVJws4+Tap2H5aRdHolCoAUMefHoaTwGRf
 t5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KPPDeDn6HmhkRHJXZx9s3atuThp+qwK1U/xfMKKSLsc=;
 b=bTmCMDZuX2FhV6W/EUHWNAxg5HA1qb1g+0Y4AOSQRMoVKPKgku9Rd1xL1ahbRorSv9
 tUVUdS6LB1a4SDdhTR14lHSYkXJMjPaP3rqLxKHWRr++59LVKLV6V2mu1+qDuQdOjqSW
 jZqK8j70VI+7MPkH7ADnZBw6wJ08Wa77Jpxv8mFmaM09rotd7f1gh97opIhZ5SwY4IE1
 hyba9JdK5uYM9j4lS2gRYAVV2oZbLZpxxleRd0zu/iyX6WaDGSaLY2xJYpYN3hi+Dm3f
 DYUbbkOGKJ2y9t8fAx8t8JbuB+DQoXPCpwZh/neIrTjHos6PENKuK7dINKGeHS9qwqVr
 F6rA==
X-Gm-Message-State: AC+VfDz+uLo9rHCfom3el3lkA3169w7Hx6Afea5nZ13oryCzKgK/9LLY
 kFZqA+pCorxASsEsyptMZp9r6wWv46XB07KffUw=
X-Google-Smtp-Source: ACHHUZ730VTuWANOlxODIAFwMUWwgHHaPojJQgDJdKUTH8cwt5BQYytWYb0pVbb7JnGxA0S+bPg35w==
X-Received: by 2002:adf:e652:0:b0:309:3a60:d791 with SMTP id
 b18-20020adfe652000000b003093a60d791mr1600121wrn.54.1686044914414; 
 Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/42] tests/tcg/multiarch: Adjust sigbus.c
Date: Tue,  6 Jun 2023 10:48:10 +0100
Message-Id: <20230606094814.3581397-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

With -cpu max and FEAT_LSE2, the __aarch64__ section will only raise
an alignment exception when the load crosses a 16-byte boundary.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-20-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/multiarch/sigbus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/multiarch/sigbus.c b/tests/tcg/multiarch/sigbus.c
index 8134c5fd568..f47c7390e76 100644
--- a/tests/tcg/multiarch/sigbus.c
+++ b/tests/tcg/multiarch/sigbus.c
@@ -6,8 +6,13 @@
 #include <endian.h>
 
 
-unsigned long long x = 0x8877665544332211ull;
-void * volatile p = (void *)&x + 1;
+char x[32] __attribute__((aligned(16))) = {
+  0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+};
+void * volatile p = (void *)&x + 15;
 
 void sigbus(int sig, siginfo_t *info, void *uc)
 {
@@ -60,9 +65,9 @@ int main()
      * We might as well validate the unaligned load worked.
      */
     if (BYTE_ORDER == LITTLE_ENDIAN) {
-        assert(tmp == 0x55443322);
+        assert(tmp == 0x13121110);
     } else {
-        assert(tmp == 0x77665544);
+        assert(tmp == 0x10111213);
     }
     return EXIT_SUCCESS;
 }
-- 
2.34.1


