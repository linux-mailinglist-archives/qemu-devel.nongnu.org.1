Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA5670DBF1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ql5-0002P1-1w; Tue, 23 May 2023 08:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql3-0002OS-Df
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1Ql0-0008QE-PE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:04:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f607839b89so13828295e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684843489; x=1687435489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CXmvCi8lTzgvgYiHwHs7/x5DBl5UXEByr1AFvDiIAo=;
 b=OS3lzeLTnpH/aYUTfXiTSb0ZAjNBmr7IEIWWNV8Uh3IkjgAWpW0/riGxLXJ9I4O1J2
 vMGKWY5m98ySsYoZQ9adK4vDRBMehxz+yK+uEaGIyhS+EYSBkIDyqKg9N3B9UJ1Lzgiv
 +hrj/mXdSF4VoQkxRigjpw5unaL/dvRP3mDwoGUv2pMJ/qwMKBH3ZvHYjtv2zXfTrfcF
 rsYxgUdivHzn/DGq3OEAxzzoMeYj4LYuI/NCraZlQUL/jJ2a0A1ngKLmw95JUk0OfV74
 6J+JZJloddo8Kv5v4KFHcEGXLeB/0HrYrZLQtPuEiDIlKkj36KSMqnOP23KDMgjNpBXM
 Du3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684843489; x=1687435489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CXmvCi8lTzgvgYiHwHs7/x5DBl5UXEByr1AFvDiIAo=;
 b=cDoTXRCspQV/wh7bnB4/aKNZZyJKj2igzRN6drsKn6NujhjN+gbNw0obCnBkZECbTS
 0uelOy48fJOt4m0mfw1niDuRKzgshfHoZnTuF00jSX7pCPdImmc5mlN9YmUt0zR6Xd/K
 SSEjtDbBs6O6eU4oYpLJNvz+GZzUPdvoXQUONgu27ksSlnCDtNvYbiyS+QQKocX2Is6+
 zpu8O5jFXVS2Pf190hpyO7L6GWEuIGLYRYm+mUMRRYexpL+CdmyIDCWE2TDcpyB2dP2N
 DcYCzVRYhqEezI+KtOcCg0NrtF66iN9jZS4NniJn1koqY0fbRmtpL7macVGOAvFLIpCJ
 uDoA==
X-Gm-Message-State: AC+VfDziqObIADYvCTwgTfD2K1JNaz59fnJJe0eWnqnjXZ2GCf5uTP01
 D3qTLoysEVvpVgN2Pss0fgmqHC2KQ0IEHICvhVI=
X-Google-Smtp-Source: ACHHUZ4C87Sy0Pc+31i+2bKb7l8J1EGQvfkgTXICDXawGcH7cPZ1hV8YOjYPs1S/6+rTKzqcOcNCTw==
X-Received: by 2002:a7b:c044:0:b0:3f4:e853:6a1 with SMTP id
 u4-20020a7bc044000000b003f4e85306a1mr9465077wmc.38.1684843489467; 
 Tue, 23 May 2023 05:04:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b003079c402762sm10848778wrm.19.2023.05.23.05.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:04:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/6] tests/decodetree/check.sh: Exit failure for all failures
Date: Tue, 23 May 2023 13:04:42 +0100
Message-Id: <20230523120447.728365-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523120447.728365-1-peter.maydell@linaro.org>
References: <20230523120447.728365-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

The check.sh script doesn't set its exit status to 1 for failures in
the succ_* (should-pass) tests, only for the err_* (should-error)
tests.  This means that even on a test failure meson will report that
the test suite passed.  Set the exit status for all failures.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
In an ideal world we'd tell meson how to run each test, so that
we got per-test pass/fail/log information, I suppose.
---
 tests/decode/check.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/decode/check.sh b/tests/decode/check.sh
index 95445a01155..4b5a47fbbf2 100755
--- a/tests/decode/check.sh
+++ b/tests/decode/check.sh
@@ -18,6 +18,7 @@ done
 for i in succ_*.decode; do
     if ! $PYTHON $DECODETREE $i > /dev/null 2> /dev/null; then
         echo FAIL:$i 1>&2
+        E=1
     fi
 done
 
-- 
2.34.1


