Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E3736AAE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDo-0006Dd-BQ; Tue, 20 Jun 2023 07:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDl-00069F-Br
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:25 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDi-0004KP-IT
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-987341238aeso542386466b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259301; x=1689851301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=qlRMKSDw5jp18xRy31DWRLn5VTDlPGb2+rDlWqCbfGnGzbPgBpNsLxyKv7dA+LL6IY
 vVKOapqjTl61Ylvyn9ENKLqPxcIzQnjw3XIYkPskAG1IEq8f/nIDQPHYeh3BsL6j0nql
 IIRQTwWevJOg2b4jcs/YVBVy/6DXzaBm4ewMeZbBTaFmlig7FccnOiS5afiTxU4qzjXg
 MY23qUeiQaH8RHcyazg7Z5jlDwlMs32ikjSkEBceRtzAtuXPYaC70mQoWkpMnppVHrDC
 psHN2ZKKPyQ53P5TEWDsq/1G7JCYLP1VJad0SC70GHfxE98EtXK3d+r1CtnBEEEWrByQ
 zVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259301; x=1689851301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=duccV4rL/xwJ5oi2uZ8NDmmdSQiwtNjUH+hJdf7jbKvhUhufleQ1hUZMW3jJ0h6D3j
 EUwrrdZYYDf8n1hjr1sTj99sZ95vR2FiE97eW8dfwb0GN9YB+nua/S8EDG+YHI0PwHiX
 y+HmzQOgQtflQm/tCiezltNmnwavldQxGvtYkj0sso5BjStYskIfKTNaMYM3yLsmTEvA
 A8/1XuM5Ak4AgdymkaXQTEb8cQ/6NRZZp6XwhAmB3eYvY69CCA0WTnQ/YnCkg3H45QE4
 dehg0BypYkPV6qas/lyV97ROc/GW3PxE8rECU1cX3tYgw3vtkslII9XaB3Lw/n0h4FQP
 goPA==
X-Gm-Message-State: AC+VfDy98lFzlKu9KnTPvkEaqtiTyY1j/sT2b8aj0zzoI3vlbfZSv4ia
 bZmnwSiZh4e6otIBYVIDxTJcGnpKCIjDRlieLb4HTRQC
X-Google-Smtp-Source: ACHHUZ5WND+R+u3dJYs7NREMmVfH1cKCQY+Dr++YGVqtsXo4qZxiAM+khfedC+ySjV+QoC9bWDZZvw==
X-Received: by 2002:a17:907:97cd:b0:989:5a7d:f43a with SMTP id
 js13-20020a17090797cd00b009895a7df43amr57930ejc.66.1687259301070; 
 Tue, 20 Jun 2023 04:08:21 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v3 14/37] target/ppc: Use aesdec_ISB_ISR_AK
Date: Tue, 20 Jun 2023 13:07:35 +0200
Message-Id: <20230620110758.787479-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
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

This implements the VNCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 34257e9d76..15f07fca2b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2973,13 +2973,7 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
-    }
-    *r = result;
+    aesdec_ISB_ISR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
-- 
2.34.1


