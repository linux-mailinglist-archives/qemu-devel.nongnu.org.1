Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B17D798D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6N-0001S6-IM; Wed, 25 Oct 2023 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6A-0000w0-Mt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5w-0006c2-Bt
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so2298475ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279567; x=1698884367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=Y/FDyUklRCxmxzLXRr2DqhqEFOg5WlDt8/lR/PFRzCxJ5w/X94pAGKW9xTpShz8OPE
 k4VK1Eu2l9KqDiB2SWW0qMcUq/iMP5EsowaAJz+zaedLa9QxP7fiRRuvy3h6p5Y+mqtl
 QHA6b1vYk6dB4LVaFQfHbJO20dl3rvpFrufl++b4NdIXQcb5cH8E0uncN1CJ3s0sU1rw
 fYQu/1AqVfdWumundhBTMIpYSKIpdjmH6YlQy7AEn9mBS/oAvbKtKGzqVu4y4IjxRDR9
 OYq9h4nQExAwt+j50+k5DQBEYyLaEqnKLfP4rHypxj/f4OzKXh9Lk7DBly8myqMehWSR
 LUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279567; x=1698884367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=G5BQ3OBAsf5PXVnOldxCRcQ2y+HB35FuEah8cdvPPqcUFeJoVK83ryHOvGdV2H53Pt
 +u2IWCrEA6TA1M6KHy1BpL/CxD5MX/DmLXb41ZR+fHs6YM1T1JXjGoJGfLMiDNC4ng57
 04ES7FUnoUxbdGH+V9qo5+9gZX8Klder4cti+2rQR8ca+tscQgxBorRuyynHH+H6WaWu
 uvDokKqpm0yhyiYP59z9sDWsduZ0InV3PNBeo5qscDUFRgXX9/BAKimZamcn//7is7/j
 7Jy+NaV4AQ/a9JGd1o+x4upd4DE1z5I0E3LXfSGT3MwBPN8Nqu/hh0SX+zSARZLRwN4G
 gM4g==
X-Gm-Message-State: AOJu0YyM0HjTnSG9+vayuIKq9OSObSvMen7LGArQ6p6VHrUw284UMzTz
 Fpj5bgkQXNAKs+20BAg012R+JpQZ0xe/mrOyCVA=
X-Google-Smtp-Source: AGHT+IHhDnfRKXhrewtjdD+Q4bHzc38hAP+gxtExKLUBvc6mdGJ1Xvg32kMXHf/FqHgpFbwCdA0tnA==
X-Received: by 2002:a17:902:d4c4:b0:1c9:cc3a:7b3 with SMTP id
 o4-20020a170902d4c400b001c9cc3a07b3mr17371059plg.54.1698279567172; 
 Wed, 25 Oct 2023 17:19:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/29] tcg/tci: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:31 -0700
Message-Id: <20231026001542.1141412-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tcg/tci.c b/tcg/tci.c
index 4640902c88..5e1c4a491d 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -228,6 +228,12 @@ static bool tci_compare32(uint32_t u0, uint32_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -270,6 +276,12 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     case TCG_COND_GTU:
         result = (u0 > u1);
         break;
+    case TCG_COND_TSTEQ:
+        result = (u0 & u1) == 0;
+        break;
+    case TCG_COND_TSTNE:
+        result = (u0 & u1) != 0;
+        break;
     default:
         g_assert_not_reached();
     }
@@ -1043,6 +1055,8 @@ static const char *str_c(TCGCond c)
         [TCG_COND_GEU] = "geu",
         [TCG_COND_LEU] = "leu",
         [TCG_COND_GTU] = "gtu",
+        [TCG_COND_TSTEQ] = "tsteq",
+        [TCG_COND_TSTNE] = "tstne",
     };
 
     assert((unsigned)c < ARRAY_SIZE(cond));
-- 
2.34.1


