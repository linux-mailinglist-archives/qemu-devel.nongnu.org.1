Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE0D82A42F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:47:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhM3-00034p-3C; Wed, 10 Jan 2024 17:47:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLu-0002d9-GE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:47:15 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhLn-0003q4-0U
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:47:11 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-783137d8049so430515885a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926826; x=1705531626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTBa5jnTmGPw5Fiyw2n1vRD4BYHoTuI+qXkHnySYH1Q=;
 b=q6PDwtMaTNwqQLbyr3qCzvVrJZOehoFEkK16IgQdxMCI8gXiEoyvqt1JR99APEwRuy
 Da+ey0pMXp8p3Hi7H6WzD8bWt0u8tGO18MeQHS1G20VcOwaRtTiGtyO3BgBKpfwUaZv6
 TrMhE+nRwFvxC0GurCrdjf0yuWs17XDF71c678IX14jmFR/BXMnqXo1K22WCwZcR44BY
 LYPy6sT91SytcnQQHckTWQhydJKyv4GGAvWl/Z8Nxe6P+N+e1fX9+eKoFXpQIZBLxnB3
 u0dbyKly/DfvW1T4BcZ6kAiwoAVoPPm1pk55q7itcxvZCZBZTQ5n3da1KRNqPjnz9Hzs
 GqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926826; x=1705531626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qTBa5jnTmGPw5Fiyw2n1vRD4BYHoTuI+qXkHnySYH1Q=;
 b=tOTEK0yFrwbfFGDadwUCKvaxI7QaH4p44D3dXPjydbSULaYFgdmlkALlxc4tw+WSdY
 s/Y5nIm+FV4duTP5HscTZwVFqESUSJhc8kG+UR0JaoudyvWfj0sPMfkUtAazVw6MgDyV
 49MG/EKSr9zBo5ejNPnDU8YYYzl9S8qUWscTqhhtAwG2n6Xbva6j2c3xrnYfg2kzsjrg
 9Ya8sXJhtKJN6BmblPYevbAdcLbqNad/ASgn5/5McXNxcCkQ5MUQVPeV+f2waqAqrYD5
 wCvZfRuwXsNDrtrjhpHNVsEIouOcvt7s5096628yXlrzLkOetB+fW0juvfXq/gRIpik3
 PbYQ==
X-Gm-Message-State: AOJu0Yy6vbcJro4ZiNm7TCqfJF6TlxalmVyOLoOuTZXK8ypjBCfgYeXd
 1CrTqgPIIthVhjm71mEo589hxYjccjn5sXPZG6HUj2YJvDKnbiZR
X-Google-Smtp-Source: AGHT+IH2uWFGXiOxQWKTmtm4URgOb86k8ExMZnh6mLUs2Y8uAYiXUqeKSKfa52TpOBnzXTute/EUMg==
X-Received: by 2002:a05:622a:216:b0:429:7dbd:1e50 with SMTP id
 b22-20020a05622a021600b004297dbd1e50mr246941qtx.110.1704926825914; 
 Wed, 10 Jan 2024 14:47:05 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:47:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 38/38] tcg/tci: Support TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:44:08 +1100
Message-Id: <20240110224408.10444-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x729.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.h |  2 +-
 tcg/tci.c            | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 609b2f4e4a..a076f401d2 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -117,7 +117,7 @@
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /* Number of registers available. */
 #define TCG_TARGET_NB_REGS 16
diff --git a/tcg/tci.c b/tcg/tci.c
index 3cc851b7bd..39adcb7d82 100644
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
@@ -1041,6 +1053,8 @@ static const char *str_c(TCGCond c)
         [TCG_COND_GEU] = "geu",
         [TCG_COND_LEU] = "leu",
         [TCG_COND_GTU] = "gtu",
+        [TCG_COND_TSTEQ] = "tsteq",
+        [TCG_COND_TSTNE] = "tstne",
     };
 
     assert((unsigned)c < ARRAY_SIZE(cond));
-- 
2.34.1


