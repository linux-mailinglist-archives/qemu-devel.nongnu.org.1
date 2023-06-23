Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B36173B746
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfx9-0001ku-IB; Fri, 23 Jun 2023 08:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfx0-0001UO-1p
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:42 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCfwx-0000eZ-TG
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:31:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f90b8ace97so7463235e9.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687523498; x=1690115498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zo+TDk0MLXDiYXwRgnqOrXa14FzuNS7D0FCpuSZpwmQ=;
 b=uzxaRgaOC1OS/IcXHXTBGURJZxLadI9DseEGJFHYcLrBa9/eaIltuNN1UUluLMSuoV
 kxUNyNTpwlT5tnAxs46KALKuAALf3Frip2rvGTAQkbGWcMyJDkROk4zRslzDNgxlrCX2
 uhDWFjVX+u8HFilcqMZZEqnZLX7JIbLhhiOG5BpTrEJHAJei/o8YVHxOnA9/wl+X5h+a
 TIc46HlCyqOLf8ciyL33gn9+ARzTuk1VCWHaxpV/AdrJjIBsNC0IuSpzwkhGGl/iB7EK
 POjUrYARFbSjkhiHCr5SFkQRgXAjNPnSdfJSPAUUiN7wabfU3jc9OrTXLfmmfaASv+Mq
 3SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523498; x=1690115498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zo+TDk0MLXDiYXwRgnqOrXa14FzuNS7D0FCpuSZpwmQ=;
 b=ZAiXV0ncdI0JTbS3Qz0Mt/ZKT2yvMI3fu1ZM1JCsGyh0Dqrr/zt+ZAsImuvo4x/jhw
 Dda0VCBYa7pLd0Wh0rblzqbBCG0kzPa6VNp4PZe3obkmLrHMOPeV4S/0HKNgWqjjfA6/
 zDEp4+6xWNR/xCn2ASFPyAaqBeFsEDf0xqRQKrMgsoJatDg7NdQ+uPiOzvpf/63GZ7SQ
 OY1G1962JrDRyXbkwzHC8Tgk8uhnKwFlq4Qxzh5zbir+NrvQFWxRIutWPpEDJT2z5IhJ
 0AB/X5l/IRR+wOcMNMQXoA0zZMgSGDPsM1TeFzjA0LcwsPhOOYiRFtyz38STBTT0ZPJM
 ycpg==
X-Gm-Message-State: AC+VfDxhVLnjmLKV5tm+aiAU/pWYTx1pSzUDc6alC4Lw9Hf4/ov3wA7N
 ydTFc3qc+KGZrZ0adFtw9eY8qrF42i3ewjcLcNU=
X-Google-Smtp-Source: ACHHUZ45+gMMCKyna+LUWy0WqzbbLwBhL+u8S9kVxKutXpfRoJAGdxiBqrp4nQWLsoDkOu9BH0+EKw==
X-Received: by 2002:a05:600c:2113:b0:3fa:7dec:c4bb with SMTP id
 u19-20020a05600c211300b003fa7decc4bbmr937355wml.5.1687523498511; 
 Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a1c4c07000000b003f819dfa0ddsm2232622wmf.28.2023.06.23.05.31.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:31:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/26] target/arm: SCR_EL3.NS may be RES1
Date: Fri, 23 Jun 2023 13:31:12 +0100
Message-Id: <20230623123135.1788191-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230623123135.1788191-1-peter.maydell@linaro.org>
References: <20230623123135.1788191-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

With RME, SEL2 must also be present to support secure state.
The NS bit is RES1 if SEL2 is not present.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230620124418.805717-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d2f0d9226ec..9132d4de6a4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1855,6 +1855,9 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
         }
         if (cpu_isar_feature(aa64_sel2, cpu)) {
             valid_mask |= SCR_EEL2;
+        } else if (cpu_isar_feature(aa64_rme, cpu)) {
+            /* With RME and without SEL2, NS is RES1 (R_GSWWH, I_DJJQJ). */
+            value |= SCR_NS;
         }
         if (cpu_isar_feature(aa64_mte, cpu)) {
             valid_mask |= SCR_ATA;
-- 
2.34.1


