Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA8177A0E5
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 17:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUqsW-000121-Ay; Sat, 12 Aug 2023 11:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUqsT-00011l-MF
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 11:50:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUqsR-0005Mx-Nu
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 11:50:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bb84194bf3so18295245ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691855406; x=1692460206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=fqZSCiPIjXkMCQuBVNFnU5HowLv++9wRPPtY1DT3rx0=;
 b=uePRFoXbqWiE4U3cJ40Fsyp5jfe8Eqqv0kVv0W0I3JYF4Z5USx2FJFl5g56VlGvzfO
 o21Aw0rVhiFDEcUvnxrmx3thRe97Nk9zP+S9T455hyP8r8jOk/dpXMoMZTtJPxGhv5Bd
 kRayIW9jTpRhQsDCEheEA2hG4w6lfzy4NxWPePoFcvUzLpK/KW5G9fmH3LCsaaIrgti3
 +zsBAgyOHAumoTyRgf414YJOTekGAojWmo0xfC6w8conMvARsXUKm/jugPNrQ7Br2lSs
 15UWtMlPTAaTIvbkumRCjyj+S7fj7pVxRbC0qvJQq3SldgzcwgPIRU0eopEjKBqDI11Y
 cK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691855406; x=1692460206;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqZSCiPIjXkMCQuBVNFnU5HowLv++9wRPPtY1DT3rx0=;
 b=UuWjl/IyWpwD1H7r0G8b+Pj/2dApPwR25QOg2Zgo3EkP5S3bY9UENeSbVmi0fQsArt
 MxL9ZZC6sZPFxDf8lD6FgbbJM1qqICE+z16yjSJz1KyApY9ejLJGHiZXikJ6LxdZZSIM
 Ly4BOH2/ndIAVGXhk7D/GGO7XFOz0Jx8RzK3xFudXHVdAwn5nEWvGUMtRt559WDTSrk4
 CtmINSNA+nEXZKP8nfA9RTV0/ehiYI8XD8z1TtI1EX17ya/j3Qp6pnh892W+VbpWTmpL
 VgR+GOEMrQEIGU/LQB9QjYlwTI05LC0Y7DQ2SHR7eSs2dMW0IDKXf+C3tWqq0Pi8IjdT
 BTGw==
X-Gm-Message-State: AOJu0YxLjFDNQy9MOpmIa7Cvr/1BIrxmtuXL4v2tCSYQvGnocSNTQ3Jr
 iO0i/k/u6gDLYmijaPKWLvAxG9nX7nT1Folhm4Q=
X-Google-Smtp-Source: AGHT+IELL+FdGKP5QtcNiqaKqAD29NGJWDZIlku91my3lIA/u5zRqxXbTVtG8wjRtzf3ENe3/LGKLg==
X-Received: by 2002:a17:902:e551:b0:1b8:7483:d488 with SMTP id
 n17-20020a170902e55100b001b87483d488mr4416177plf.57.1691855405542; 
 Sat, 12 Aug 2023 08:50:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a229:715e:62f0:756f])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a170903244300b001b9dadf8bd2sm5981601pls.190.2023.08.12.08.50.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Aug 2023 08:50:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-8.1] tcg/i386: Output %gs prefix in tcg_out_vex_opc
Date: Sat, 12 Aug 2023 08:50:04 -0700
Message-Id: <20230812155004.326182-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Missing the segment prefix means that user-only fails
to add guest_base for some 128-bit load/store.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1763
Fixes: 098d0fc10d2 ("tcg/i386: Support 128-bit load/store")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 77482da070..a6b2eae995 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -595,6 +595,9 @@ static void tcg_out_vex_opc(TCGContext *s, int opc, int r, int v,
 {
     int tmp;
 
+    if (opc & P_GS) {
+        tcg_out8(s, 0x65);
+    }
     /* Use the two byte form if possible, which cannot encode
        VEX.W, VEX.B, VEX.X, or an m-mmmm field other than P_EXT.  */
     if ((opc & (P_EXT | P_EXT38 | P_EXT3A | P_VEXW)) == P_EXT
-- 
2.34.1


