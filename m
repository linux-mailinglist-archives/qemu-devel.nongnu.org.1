Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A006C752C02
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eL-0000J9-Un; Thu, 13 Jul 2023 17:14:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eI-0000IL-Kg
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eG-00017G-QU
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc0609cd6so11285645e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282890; x=1691874890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mkMN+Ym75aKqSSlyQfMGwZmblrlERSKZPoX/RaUMIgw=;
 b=s87Fh+WvZVFOS0o7bh6N3wcnQi+96xnWjFhEsza75Sc8obbGlJDhVMDMaaGjIR4d0d
 1bPtdF8+N4ZcNoYYKQOS+Moff3/Zb4kkr9hfh/gF2nogqeDjlB/qe//bwz/yUfn2Fyd+
 bpYORJDXpHknejCOOYRbijtsV5F6LBoGwANrRi/2v6wMx3+NDxUt4h1D8AmO9yv0CDSM
 Z45ORZA99nFhO+Q67TFVPXwpvKktGtol1sa/q08yjJcyutRqdKQXEKkb2eAfRZ/sLfAd
 Yq24eEgrV8tqWPnFHx7QUxIocpbTWappxdVC7DhVCSue7wMKkKUR7wEKKpaQUxhQRTP0
 TPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282890; x=1691874890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkMN+Ym75aKqSSlyQfMGwZmblrlERSKZPoX/RaUMIgw=;
 b=Rk7sY4uzW3uclpTXNdF0TB3lynJG50+TUhn0extOJTgFCNQf9Tzyfh7Pz1M7TUjy/V
 3L4QmzcBHUDgvKkXE2/98tVLcnQ2yZQWroZbrK9TkmX3X6a3wdGLm1qgcL3K37riuNsl
 SJ3jutvqw0IyM9kMUGyzIfHr0oGMejXbBEdoM75cxnYWnbTr+sZptrQt86dwH86Pe8vw
 h5lO22i7SsfdiAr50EbhlW5bEB5RoGnV+V57t4Srpe2iKxdVsZ0Lm3Lm4GrqrjOymFID
 R9auSLWhIy4lPw3CO8VkwX9ZxaITRS+A4+04l61ZGg6ACOkB/k+l2gse9kmmATq4pYii
 zQtA==
X-Gm-Message-State: ABy/qLYEosOF8FbgOWvzPUDeDrhmUjWTAnagbIqPjn5BpjSCtuVpkHNe
 1AxWZBElyX1+pRIxyqvuAGMqzl5T8SHiwId0h2rhYKlo
X-Google-Smtp-Source: APBJJlGSaZzuSv8M+8eZxLd6ZnHTom3X20k0xa3baNlfNwjY39lnK4aMtdhWicbQTcep1qpwHfs4rQ==
X-Received: by 2002:a5d:4d02:0:b0:314:17cc:31d0 with SMTP id
 z2-20020a5d4d02000000b0031417cc31d0mr2185561wrt.34.1689282890235; 
 Thu, 13 Jul 2023 14:14:50 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 08/18] target/ppc: Use clmul_16* routines
Date: Thu, 13 Jul 2023 22:14:25 +0100
Message-Id: <20230713211435.13505-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Use generic routines for 16-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 3bf0f5dbe5..98d6310f59 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1435,6 +1435,15 @@ void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     r->s128 = int128_xor(e, o);
 }
 
+void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    Int128 ia = a->s128;
+    Int128 ib = b->s128;
+    Int128 e = clmul_16x4_even(ia, ib);
+    Int128 o = clmul_16x4_odd(ia, ib);
+    r->s128 = int128_xor(e, o);
+}
+
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
@@ -1455,7 +1464,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1


