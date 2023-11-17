Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 431FB7EF7E3
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 20:33:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r44ZB-0000Ri-Lr; Fri, 17 Nov 2023 14:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r44Z6-0000Qw-4e
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 14:31:44 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r44Z2-0001rX-M6
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 14:31:43 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c34e87b571so2198929b3a.3
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 11:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700249497; x=1700854297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RLNNd4SWSgpRfjedhc5CjQOr3QqelXpuW4mfn1Gp0TE=;
 b=wG/eda6FYOT2HoJmSEL1DEBQb581KgEO2wJIn2A2M6NVj2qgCVAFW7axM2LU93ap10
 CCpN1Rd9mFkFaIM5MzS1ltbm9uJ++USn5vNMP4cowmh1LJnE4IGWRgxNLL6A4y2oYxtX
 NAq8mOukN/gS+GVN75kC7EUc3T5prRbdiJkhobWmMNnIgEjWctQ5fMBZ7EMbtqIr0faB
 9njnq6dwaWe2RdqA/z5L6cUU+L5y9gpzzqCG/QLWowupgSFQs9JPOievAync5lY9SawH
 A8GR+V9s+Os6TbYYX8f8HOxfB8bQ6OyhXk5d9NKuCtsRjwhRs3U1lyS8mnnnJGUGanhT
 pKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700249497; x=1700854297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLNNd4SWSgpRfjedhc5CjQOr3QqelXpuW4mfn1Gp0TE=;
 b=pVOIRJPlUr463xMGFsPXceTyXyt9AbHcMjZfMtiIdfDT3Sh2/MiMzuC/2YfB9RwGaC
 XwkdtK1nfEyprO7+xt67ItDDfXdq9JqNB74+LjJUQxAc3gwzYhU6e8RjcuwXNTFWLnO5
 1ZTsOmeahsIErIzAjz+1/0Sj4Ex3wS5BPYLlqbb+tuvQOlOmrUT9CJXjRI0czA8ulzUO
 z0DCiQYJL+2EuXOoQMZAx6GDoOZFMsgCnjoqH5/ST+jIVIVUAKOXXnsvJTD2IxdIx90p
 D3cvp7IOTac8K2yCCH5y/BJueXfXFAHsTPff6SOMZRH42mBj1X6wbxe4+NpfcoZkJtL+
 mWCA==
X-Gm-Message-State: AOJu0Yyj6gIOkmCxDjQPQxDF1vAZXW/OnkKRr+hPRRVgUbQ8g/fkXdkO
 G5Y/n/7Zcq2n06LR0vwSzfnWal6VHtwatKO8NHo=
X-Google-Smtp-Source: AGHT+IGeonmq61UE42khbVIuOniPTx9+QiHa5XqQ/Bxsk6gGyAg/YWBU7VtbiZsV+SXfoxLvjA/uxg==
X-Received: by 2002:a05:6a00:438b:b0:6bc:ce7a:6f39 with SMTP id
 bt11-20020a056a00438b00b006bcce7a6f39mr540402pfb.32.1700249497577; 
 Fri, 17 Nov 2023 11:31:37 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v26-20020aa7851a000000b006be0bd6a4d8sm1757086pfn.36.2023.11.17.11.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:31:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-stable@nongnu.org
Subject: [PATCH for-8.2] target/arm: Fix SME FMOPA (16-bit), BFMOPA
Date: Fri, 17 Nov 2023 11:31:35 -0800
Message-Id: <20231117193135.1180657-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Perform the loop increment unconditionally, not nested
within the predication.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1985
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sme_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 296826ffe6..1ee2690ceb 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1037,10 +1037,9 @@ void HELPER(sme_fmopa_h)(void *vza, void *vzn, void *vzm, void *vpn,
 
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = f16_dotadd(*a, n, m, &fpst_std, &fpst_odd);
-
-                        col += 4;
-                        pcol >>= 4;
                     }
+                    col += 4;
+                    pcol >>= 4;
                 } while (col & 15);
             }
             row += 4;
@@ -1073,10 +1072,9 @@ void HELPER(sme_bfmopa)(void *vza, void *vzn, void *vzm, void *vpn,
 
                         m = f16mop_adj_pair(m, pcol, 0);
                         *a = bfdotadd(*a, n, m);
-
-                        col += 4;
-                        pcol >>= 4;
                     }
+                    col += 4;
+                    pcol >>= 4;
                 } while (col & 15);
             }
             row += 4;
-- 
2.34.1


