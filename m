Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E507DA8FC
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG3-0004w1-8K; Sat, 28 Oct 2023 15:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFs-0004oH-1o
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:56 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFq-0004Ay-FI
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:55 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-581de3e691dso1845428eaf.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522352; x=1699127152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=tDQ4HbnlE9V0M/8o6p/OttI1+kn23kt+fv31QguUy5t663k/dPU1aKWiwk4jfQ1pp1
 7KUvcxoWlgHj6rboxozdb9ynfDennqhKw83F8qhyJYimx35Zou59GUaklibWesvkAxTp
 5Xd6laoCwYbLLZ/0r3VbnYYp+rOqg+ZcViBJioHe4hR5F/g4PXSFYSttVI4XKZQntTwH
 SAdcPAuinjfzO+57itS2t+CPZYp4q9NSy/iooaG1wXSXiMZc4vgIYzqsXOkFgNFbWjIN
 ek771W6sTsxWboDRMX91ScqFZwcDC/U6Xsl+fyzn42dUCi9/j7ENIaWxJwftw6MhLysa
 lGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522352; x=1699127152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEO6SLhS+OilG+TaX+qmXlK9OgBRNvjKZJDuVMclfD4=;
 b=CsX+6klj+KSfCXfI9Ij6Knb/YW3Ipc4bKyDqf1iEXMQ/eNV6dRn1WbKFOXeXsFgUYO
 miHRGwZxPMpOx4S7jKIAtUN4jML7m20jQvZkpdgPSO2qONFcXvGyF09GAgEyRVduGrax
 JhrlAk2FOQX2sTaTsWql2usKy9KGEIrZpnzqM6tZatSGYBzc5A8Fu0lA2Z0WsjFP2Ns2
 tgGOS8szM2w9jjp1ANEjwVkH9cOLkVZ92lqiX4SRXTWfKGHQGq8xSHeBN5lr5C26Nikd
 +O1vKeFP8BlovOU12KDws0nLGWyouxoEJeYdpn1s1F8LV1avQlXbEYARSWtzXfY6XAdU
 c+YQ==
X-Gm-Message-State: AOJu0YzeqCPWRJzFMqdurQ399kla+vHMtI4jZF2wuYPKbwXK0IvPq1Ds
 /fpYlhGB/aYbrkaak/VH5k4oG/x2eV37w3Lpxeg=
X-Google-Smtp-Source: AGHT+IFdT80eJ5wwn3fv3h1rbsglMluN1RSYlwWyRgaFMvZm1h1aBjTofz/eVGPCCIRFwgNuvgUUkQ==
X-Received: by 2002:a05:6359:6b82:b0:168:d0d4:d8e6 with SMTP id
 ta2-20020a0563596b8200b00168d0d4d8e6mr6362041rwb.16.1698522351761; 
 Sat, 28 Oct 2023 12:45:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 31/35] tcg/tci: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:18 -0700
Message-Id: <20231028194522.245170-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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


