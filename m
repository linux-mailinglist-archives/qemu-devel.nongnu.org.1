Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9977F2A51
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Nw4-0004KN-Jm; Tue, 21 Nov 2023 05:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nw0-0004Hq-Tb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Nvy-0007Ei-Kb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:24:48 -0500
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c875207626so35993311fa.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 02:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700562285; x=1701167085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A5nZHFs8XfXA4eqiIcDiwItWSy8HHd+ABkoJYVnAfcE=;
 b=ZiEA5xMWL+V/DagdSUqluHyhViSQw9buv09cAZ6uIcm7b0JgldBDf+Cc0M2u9m9URy
 W+IepTKsSUk/EbnAw8BWzeEkRaCkEwyzeDLSHSaSLMT4tLS1ckDohqAc+gwpbvHwVxuS
 B2Cuvq3K6BhkkdV/bPXp4pG0KwtjCeo4ndRTklJVJu3vSgGisUML0DGgswSZ4ydvA6ir
 L57uu3U1jLPQPLPNttJqwhbB7Mf4QHlGur5Bxk9JAILAQHVFOzVIf91VzSVImeJVTqRG
 UxLnr7kQdmSWeeaKtUrCZXWD/9k8nQs6HAryd8iR1ck+bLJUn4PSVg5Gu7bC4mQzu5Z3
 212g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700562285; x=1701167085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A5nZHFs8XfXA4eqiIcDiwItWSy8HHd+ABkoJYVnAfcE=;
 b=Xt4zUZXYCQrIH870xU4o8w7a9d5i7LmEz/d1mljiNIhCP92zQ/+BoLzsFGhnC8COC6
 rTVR8WmpASCxp1nMcAKJjRCuNTCkKT4uLO0o50LrNjGC80CJJeNWKchuSgv0lvDaRCIz
 J6lp+pnnCznIVvpWcJyHJ3KoPgaZkZ+VKzLU636pRqgfQZ0pn9KT3EbZUlbzG0+gfI59
 Wg5uVANgKP169FsiSeOn9qhD4qCA0Eydy3BC1Q9gah0NBOYzZYK7x4FNEp/fOOJ8QIwy
 KYQ7eGAcKXb6n8h/ef3sZ5aTlIt9X7Sz6wDyUafRLvDRg1jKl2t/SEZTCLM/cTken30/
 weTg==
X-Gm-Message-State: AOJu0YxwkD79iR7nmB0N4iWC/eTPT+VjILhtCILJxo4JGtvT3fLFihc1
 Qrx5NSvKS2JuLrbaSAN5IQrCQnHtaRSPijlvkAc=
X-Google-Smtp-Source: AGHT+IFdotlzajEFXNGHKkcbuBHZhVggup+Jq+o3QbLTyB3ngPdKWTuWKaRiDUMEgJAJ6PlOQ1NQMA==
X-Received: by 2002:a2e:9015:0:b0:2c8:3613:d071 with SMTP id
 h21-20020a2e9015000000b002c83613d071mr6949584ljg.36.1700562284935; 
 Tue, 21 Nov 2023 02:24:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a05600c181900b00405442edc69sm20450835wmp.14.2023.11.21.02.24.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 02:24:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 3/8] target/arm: Fix SME FMOPA (16-bit), BFMOPA
Date: Tue, 21 Nov 2023 10:24:36 +0000
Message-Id: <20231121102441.3872902-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121102441.3872902-1-peter.maydell@linaro.org>
References: <20231121102441.3872902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

Perform the loop increment unconditionally, not nested
within the predication.

Cc: qemu-stable@nongnu.org
Fixes: 3916841ac75 ("target/arm: Implement FMOPA, FMOPS (widening)")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1985
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231117193135.1180657-1-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 296826ffe6a..1ee2690ceb5 100644
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


