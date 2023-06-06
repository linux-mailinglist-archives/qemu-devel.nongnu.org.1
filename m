Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA19723E60
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIw-0007nt-PU; Tue, 06 Jun 2023 05:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIr-0007m3-Sk
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIo-0004kv-KI
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so4235476f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o1o2F5lF4g2TocJJK5gZ6RiSV+EWcylyGVmIBQkOlbc=;
 b=r56+7r9G0WC/QBaCEFCKX9EYyEqRpWiD5tD6rUxMznIHOeY1YUPxe5khug5fXLY8jO
 ICvakBTB4R2ziBXnqYLs4GXMWJ/TfOT/SoGTtMC3eh52W7WrOLgOxxLL00418W9L1SFx
 x6FYu5THgUqZx2hBC4znfgYmLO2HOQzhq8VUU+JKRWpdPuF50jDJicdQYyhebB43CzhW
 ssWl3YuGiRfEphkWzGmfQ+JLblKFopnd3HtBoCgs+pcxAcmw1WTeGtH3PI7nYwH9/sT6
 PzfLPvPXxbnWWezEDr0ORwRjbB0o7uD59+qWNfDR8kE8atmmzyBPF0yfGmHnF5jCXGc6
 TVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044914; x=1688636914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1o2F5lF4g2TocJJK5gZ6RiSV+EWcylyGVmIBQkOlbc=;
 b=mDYutqBJnM6twgpKE+3MhZFizSZR3eXXVqimdqwyoH5eJWOaOZm5ciA8i780mhrTbq
 fqPr4IsL49GOnfTsRFz6xNRZrc4psemUyuldHLdKl6UxGwEygK9V54iAforvo1R+PJqO
 rhy3l4MOXlHxDCCsdGOl9zYMF9wuaUrlhpjKTjW/Lqhced1jdK5LlwEUNxjIaab0aITg
 bvqQ55V8ZWhQDeswmvDEaHKFGly8o5DQJkQUDm2ctgaFKpa985LJMaVb72ruk0dYSz2I
 7eNj2rkTfFyvjz8DUftnptfom2F6BuTfyF5eQsx9LKQX9dlNe6gLyxYbMPDHYNNCtSq2
 RSBw==
X-Gm-Message-State: AC+VfDw+s1eHV07g6lSBWGDw+rs4nFlTe6XsugWdXV1FourLIBb3GAAC
 u0pMui0SAV8hNmu6xcRsM/2G50is8W3wXLhHb9Q=
X-Google-Smtp-Source: ACHHUZ5y+0YYfs31VL0wCidRY/Qg0PTOqDBkBT/9pwLUz2f2WBvYKnyNB9MxFQlL7UqDJwrOlDaqAg==
X-Received: by 2002:adf:dc4b:0:b0:307:5091:5b96 with SMTP id
 m11-20020adfdc4b000000b0030750915b96mr7905704wrj.22.1686044913951; 
 Tue, 06 Jun 2023 02:48:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/42] tests/tcg/aarch64: Use stz2g in mte-7.c
Date: Tue,  6 Jun 2023 10:48:09 +0100
Message-Id: <20230606094814.3581397-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We have many other instances of stg in the testsuite;
change these to provide an instance of stz2g.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/aarch64/mte-7.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/mte-7.c b/tests/tcg/aarch64/mte-7.c
index a981de62d4a..04974f9ebbd 100644
--- a/tests/tcg/aarch64/mte-7.c
+++ b/tests/tcg/aarch64/mte-7.c
@@ -19,8 +19,7 @@ int main(int ac, char **av)
     p = (void *)((unsigned long)p | (1ul << 56));
 
     /* Store tag in sequential granules. */
-    asm("stg %0, [%0]" : : "r"(p + 0x0ff0));
-    asm("stg %0, [%0]" : : "r"(p + 0x1000));
+    asm("stz2g %0, [%0]" : : "r"(p + 0x0ff0));
 
     /*
      * Perform an unaligned store with tag 1 crossing the pages.
-- 
2.34.1


