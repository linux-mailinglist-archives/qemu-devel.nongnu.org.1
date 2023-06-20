Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B5736C2B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaiy-0001gV-26; Tue, 20 Jun 2023 08:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBaiv-0001db-Ct
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:41 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBait-00025c-OF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:44:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51a4088c4ebso4436531a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687265078; x=1689857078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BdnIrBC/vjhypfMOEhRm01STyDVGWe2QDHvXiznUOKk=;
 b=nE23sk6EjFskLemAecIy5s3AkK0bM1a3RTtNUVDFqeCOPU8aT7lWOwpGAj4+CpVPtI
 MelbzFxixiZ2FQmmbjwn8/L0hWgKcqo1bsXrchUoCNWDnHa3v4vVYWm3eiHyPK7d/TeQ
 nPPzlL8gUBdklLbZGJxBVpcpv4l6+uzZ4nT+Zbu7v8nawUXVAvXeQiqZAmSRnfkjVnGy
 8oeGegZtixiIPn2Y5wZH4e8ScimbcIupZAL9KjZgOBvxO8uvKAxp6e8FgRqAGQmcrxs1
 sSdbUf4q18vRAGWfjR/ZRnpnE/78+N0aGGlJxSpEczvpkDtyilWvQk8Asitx+NoNvz3k
 Cqew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687265078; x=1689857078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BdnIrBC/vjhypfMOEhRm01STyDVGWe2QDHvXiznUOKk=;
 b=kEOcRkPkJGx5/CxIaYrXNJhpunDnKXjaKtLTteGHJrYei0YvLCZVOhDkWJdpI4aE+T
 M05PSp1ch4Tg8dDazEyacj3n0rN1tSm02Noef+zRGvC0yBB1Hm8yw6cW29ndiSwC/Kf1
 pvCmmNU2LGlgwHRKbUihVtGv5NmhoSwAYWVuImVJwPWW+NsX1E0KXyCkcptrQWGic+1V
 S9RaKCVGKRphmdl6sXlEnsy06MYD17nl0WMkoKnewc2nqcEXw+jUlQ4Po9ycil1UUxmN
 4HdtTolETpzM3qpedMTx86n99JK2mafG5HIleQqCzPPy21LPvl/O3PmI5syTH8QW3tsm
 sxLA==
X-Gm-Message-State: AC+VfDwGFcduw/oYE8zwYsa0ugtQvXCLDr4X16/GCUm0UBbMQvTtbFsr
 WnBSyhQNhW6iyjcd049CNI/q64YpBoaAbO1jfpTouGAX
X-Google-Smtp-Source: ACHHUZ5vzMO3nQ3F1wgwtW767Qyojk9PU81x7lnHJFL2p5jXYRxvFCkOpbzaCC5pwoiVFWaw67WfBw==
X-Received: by 2002:a05:6402:4c9:b0:51a:327d:f065 with SMTP id
 n9-20020a05640204c900b0051a327df065mr8368216edw.13.1687265077979; 
 Tue, 20 Jun 2023 05:44:37 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 w9-20020aa7dcc9000000b0051a313a66e8sm1142541edu.45.2023.06.20.05.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:44:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v5 17/20] target/arm: Add GPC syndrome
Date: Tue, 20 Jun 2023 14:44:15 +0200
Message-Id: <20230620124418.805717-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
References: <20230620124418.805717-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x536.google.com
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

The function takes the fields as filled in by
the Arm ARM pseudocode for TakeGPCException.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d27d1bc31f..62254d0e51 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -50,6 +50,7 @@ enum arm_exception_class {
     EC_SVEACCESSTRAP          = 0x19,
     EC_ERETTRAP               = 0x1a,
     EC_SMETRAP                = 0x1d,
+    EC_GPC                    = 0x1e,
     EC_INSNABORT              = 0x20,
     EC_INSNABORT_SAME_EL      = 0x21,
     EC_PCALIGNMENT            = 0x22,
@@ -247,6 +248,15 @@ static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
         (cv << 24) | (cond << 20) | rm;
 }
 
+static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc,
+                               int cm, int s1ptw, int wnr, int fsc)
+{
+    /* TODO: FEAT_NV2 adds VNCR */
+    return (EC_GPC << ARM_EL_EC_SHIFT) | ARM_EL_IL | (s2ptw << 21)
+            | (ind << 20) | (gpcsc << 14) | (cm << 8) | (s1ptw << 7)
+            | (wnr << 6) | fsc;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-- 
2.34.1


