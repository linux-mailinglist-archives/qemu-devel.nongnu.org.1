Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124B716D73
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44oN-0007iM-Tq; Tue, 30 May 2023 15:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o8-00072Q-Ad
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:00 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o3-0004kB-JE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d1e96c082so3562625b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474094; x=1688066094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2XXJkmc8pjiqw5ujX/J89qzMIqZ1uAbhAJfcXpJrUA=;
 b=NPPk/hAr7cnyFdjzNWR541gJAO2DUHDZ5vwW7YiJ4Z9qrT1+8bpKsQfQjIsBqB4cDy
 cd5wcE5vNWyxE9PyBjfwuyVrPVMTiGsP/QrReEvaxcpZKAjzIfbW/1irBch+G3XNeDLV
 pOHPBTxjhgd+tDgCopnD1Xb+FVnYEayOnYL5lhqsO56iqbrR1cWVYCT95/Tm+bUGG54C
 iamMmigErlctfeB9I/Lh6V+NvNh+ldRUzVxR73bNP3MntqB59hGF5zQdZbvQaQWerFgU
 i3BGdD2i1kWvSJC3BVgdS0FjCb4AQaMeCOCUXRSEkAvFaBOFkIntPbd8mEaobfDsZASU
 wYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474094; x=1688066094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H2XXJkmc8pjiqw5ujX/J89qzMIqZ1uAbhAJfcXpJrUA=;
 b=OgQa97LVL2qiCl2BaApVThCV9yVkPbUAFZPyMjUmk/Gkp3ihNuJn1ozTBWnOVgREkx
 u65I9ZPz/cyaoWOrjVuFT5DXt2yKmDQbEWdTAeWPoYxCVuGXBmReHrTkuAb4pGZRXlSR
 FYKq3dlSpgwwN90uv6Hml0tIfZ36XOF+zq5XQW4QndvvhIVvwtI+8JFqzWEyjCBqIFPd
 v348Svp/fsLZusFs1saRoh0x/gPP2GqwAjbphu7xz2RSmAMQwWwirYkQUnqJUwECmnQm
 wGc2ghA8L1DKS/M5pYN/vm1w6MZzQgxUA9QMax4yyXKRBKS4tNvNeoEC0nhKm3Mp/5GL
 h57w==
X-Gm-Message-State: AC+VfDx/sWEVh1WJLjgfqZKXdcSicMCUAVyWEdy+AJsujPOXm9/sjriK
 R7vCruxTsQJu+V8OhC0E/GqHRwlDUYCAKvW8710=
X-Google-Smtp-Source: ACHHUZ6Zc06NcS/XFByXBYiKBmC71hlMFoJrp5U/Q2yjnIoiDuxQop7Gsa1Kg2wdpb6yOoe8tYawiA==
X-Received: by 2002:a05:6a21:100f:b0:10b:8024:d253 with SMTP id
 nk15-20020a056a21100f00b0010b8024d253mr2861081pzb.26.1685474094331; 
 Tue, 30 May 2023 12:14:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 18/20] tests/tcg/aarch64: Use stz2g in mte-7.c
Date: Tue, 30 May 2023 12:14:36 -0700
Message-Id: <20230530191438.411344-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

We have many other instances of stg in the testsuite;
change these to provide an instance of stz2g.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/aarch64/mte-7.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/tcg/aarch64/mte-7.c b/tests/tcg/aarch64/mte-7.c
index a981de62d4..04974f9ebb 100644
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


