Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B4722E0C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:58:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ESD-0006Bf-PZ; Mon, 05 Jun 2023 13:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ES4-00064I-SM
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6ERz-0001Wn-CX
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:57:08 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so4675079f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987821; x=1688579821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhI/znFwSdhfbldr+0O5s0+yrpOF1eXn2lep7KpKZYc=;
 b=DFeKOM7TGS0wAcUYaY3EIjwqC3Gi6SUDTMP+KmiKycyZPLATFkppylrblqSSXGd0H5
 ilWdpuCCGr7CiLKUq2o9+EklnNFNECobjT7XY2uUUWhLkkobpe5vawQH+i3OKnPm3c37
 UcK5FVkwRRKXnFjHvnwSjnzLaUYxiJ1nC9jDJxqRNtBh73YmttPuDEQBbMkeOZqk+ud8
 wPlWJJ90xxxfLbnpUcXbnbDlnC+m1bYYjMRVd3KAN0hIlhlrleFcGDrTY4Q1MvyefhJb
 ZmnIMSMaZfkRQsVfvcv304LqkwKcRkS48vsD8hyYgrM2VAHdhK8zhbHKJUQfcyJNzKWK
 iDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987821; x=1688579821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhI/znFwSdhfbldr+0O5s0+yrpOF1eXn2lep7KpKZYc=;
 b=Mm0Lwhryni7tyNN7gprctPTHPTYDt4keyDzz9fSVvK9Wy6TE3IyHxDrj2nJKOlm6/Q
 uM+sGimYTl+HgkSMHRnS4ljBnkFbAfDnuV/8+N2CnlqNFPI3AMPpNgrKmEb9egYAzxF4
 +mWHfpgMAQ261NXunWgEN6JrXTuj4ppx6wihs/xOPjusMkuNh26wx9UHDIAioMU+jXLw
 3xHDalUaFeoL8OuFcz/mu5NNUHa3c+5FabiQinAHBri9OPIm68uT8pmqs9zlu88DYXLk
 JGLDWwg82yFOQF7dwbNvQ0Dwa2ytpXQ23WV7Efp8zFbmZPJXpSVhxTYZGo9FBsYqiL8k
 1bWg==
X-Gm-Message-State: AC+VfDz/tZcOPdMq+zMtKtbnobgxubcbnifljGAYGSTIBmRumQECgx1L
 XSDoq6gA4QImLjc9Ww4gZVCLbnTWBhWfu79bSBM=
X-Google-Smtp-Source: ACHHUZ476x0+HIFiYQaGCy2MedznzrhIucfPFGCR3toMjSSftxldMUru494pOoc6WqXM2i9MyydDDQ==
X-Received: by 2002:a5d:48cc:0:b0:307:7e22:dfc3 with SMTP id
 p12-20020a5d48cc000000b003077e22dfc3mr6598286wrs.63.1685987821752; 
 Mon, 05 Jun 2023 10:57:01 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a5d6a04000000b0030aea925fbesm10298902wru.50.2023.06.05.10.57.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Jun 2023 10:57:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/5] tcg/tcg-op-vec: Remove left over _link_error()
 definitions
Date: Mon,  5 Jun 2023 19:56:44 +0200
Message-Id: <20230605175647.88395-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230605175647.88395-1-philmd@linaro.org>
References: <20230605175647.88395-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In commit d56fea79f9 ("tcg: Move TCG_{LOW,HIGH} to tcg-internal.h")
we replaced the "_link_error" definitions with modern QEMU_ERROR()
attribute markup. We covered tcg-op.c but forgot to completely
clean tcg-op-vec.c. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op-vec.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index aeeb2435cb..4e46b74fd7 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -24,17 +24,6 @@
 #include "tcg/tcg-mo.h"
 #include "tcg-internal.h"
 
-
-/* Reduce the number of ifdefs below.  This assumes that all uses of
-   TCGV_HIGH and TCGV_LOW are properly protected by a conditional that
-   the compiler can eliminate.  */
-#if TCG_TARGET_REG_BITS == 64
-extern TCGv_i32 TCGV_LOW_link_error(TCGv_i64);
-extern TCGv_i32 TCGV_HIGH_link_error(TCGv_i64);
-#define TCGV_LOW  TCGV_LOW_link_error
-#define TCGV_HIGH TCGV_HIGH_link_error
-#endif
-
 /*
  * Vector optional opcode tracking.
  * Except for the basic logical operations (and, or, xor), and
-- 
2.38.1


