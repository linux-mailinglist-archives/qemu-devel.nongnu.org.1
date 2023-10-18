Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB77CEB32
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzb-00087d-72; Wed, 18 Oct 2023 18:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzW-000871-0E
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzU-0002UO-9U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:13 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so50460235ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667971; x=1698272771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=AeAfFAVkwVfW1Q+ML+uYwP8ihCTBnWK18BBtrz9dLDl0N3H37IMaG2uSdZxvrqSh0Q
 h0XO1UkBzbtNFkHSMgMVO+qFQJYCc+lBYg7iiic6PwZtCtoZrhzFGLynOpu3tzOPpo90
 6KYAT0dbSBEsmFnWKn30dmSlPdoj4xEmLISymNR3RzO835C8PTMXRZlaV0vzPUvmZzn9
 9w3Zgp1InZbXBfmX12FtoC45sb2lV37wuVvoNRXYG+hYI8sS/6Zw4Vtum2lPG37hjben
 +H9Gszuo0FSfNXyYmX65qidckjgNroO8zJnF/IVdYBVTlVJcYslhyDonpNpbWgcRszzT
 gkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667971; x=1698272771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wgo3sS5iUyrU0Dzdzk24htDnmRxHdeX5tUMGq3kg/oc=;
 b=Q7EX8uWb8mlUe+UNPV5ldN0EnHsOZ6hbqeYY+9OjvbweW3YG5I0kf5WxRKPbbakD/v
 k1SuJ+s44bFuemFwWfRA1w6dky5BX1dANYM81X99Xy1DArPFrdeErmpS4nA9LdJWgC1n
 k9BrCENhh2ww/qWYZ55jRGfxYe0M9oSrqsXT0ml/K85RE9QN2t9SNcqkHuHimIe6Qgcz
 eRHIcKjDDeSrtdlR3no/m6gAnGBXhhW+w5FuOeM//tJm9Zo6HoQ3yr1rJjDiSsYn5nex
 gYVM1Kd17yF/oDUDohGGEK5CYvUQei3nw5XBcOIOn4hsKQrdFOkSb589vdewaZELvLld
 7ZHA==
X-Gm-Message-State: AOJu0YzLOIfePHSTTdUiPlK75W8vUqQyDRxM5s+gQWGw25gUy830SCcP
 9gIqaYlMj8tRJZcfQU6nYP556UPXzUjC+DI7UAI=
X-Google-Smtp-Source: AGHT+IFD0M/517RpMnOx4hNnCQEmBWKCi1Y8OfoumoQoCPSluTw997LU/goPCyh9OfAFtzi/W+sQtA==
X-Received: by 2002:a17:902:da8d:b0:1c7:495c:87df with SMTP id
 j13-20020a170902da8d00b001c7495c87dfmr885184plx.53.1697667971044; 
 Wed, 18 Oct 2023 15:26:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/29] tcg/ppc: Disable TCG_REG_TB for Power9/Power10
Date: Wed, 18 Oct 2023 15:25:41 -0700
Message-Id: <20231018222557.1562065-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

This appears to slightly improve performance on power9/10.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 6496f76e41..c31da4da9d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -83,7 +83,7 @@
 #define TCG_VEC_TMP2    TCG_REG_V1
 
 #define TCG_REG_TB     TCG_REG_R31
-#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
+#define USE_REG_TB     (TCG_TARGET_REG_BITS == 64 && !have_isa_3_00)
 
 /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
 #define SZP  ((int)sizeof(void *))
-- 
2.34.1


