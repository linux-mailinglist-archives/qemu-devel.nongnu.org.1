Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8CB736614
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWhC-0003tS-EO; Tue, 20 Jun 2023 04:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh8-0003r1-1k
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:34 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh5-0006AV-CH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:33 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-514ab6cb529so10479517a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249590; x=1689841590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qAxKzsGv/w4NXHL6fX7FdhMDg3IBfNx3EYgkWhvKP4=;
 b=VGKG0O8pre/I4yNWijrwPgO2j5w1xtE3IEQZEJTUX0yqxN7eDT69EPObvmYPnQvqu+
 OvT/MO1foRohWSTXKFTq6jnQt/4jgeacmQeO8FT7VI8yaOc0MSVq1GuiTyM5KQgQtR99
 utZNGwqfSdcOpsyVANFPlNQdqf3jhy1nhOfWvfFwRsv6XOm0fZyR0qGXzx0AY02s80A7
 Obc4352r/r21RPQl942YK8YAyGzj5YHR0b5bvhm4huo1fdYiHD86Tg0rAU2QQAN43gkb
 T9Psg0VejMOHG/5Em+9/jaxQkSSKOT6qxP7A99lokkqBdQA4kpXbBoynxRKjJTIUy3Sy
 7Xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249590; x=1689841590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qAxKzsGv/w4NXHL6fX7FdhMDg3IBfNx3EYgkWhvKP4=;
 b=ZfLux42emQcVvDigDL2iS3Lx9LoHVOR2HEVCl7f9vsT11BACD7N0KWfywnSevgAJA1
 w09wuWFpp1S5wf2b++vpFuHRX/4a1Hag7LEm7sSZmZ7xbdDdI+x1Tt787I7XtO2Jn5Vj
 S56Qk3qQQpzGUUt27s7LQIAzGGqbvr0QZoanoqPVXvGtkFG8qAmcaUF0czknqGKi5i6X
 1FVFedXlRZPKFvl43X4oF0EC3JXQrv3eQhmaoCJreVAsWIvE7QOmZNiGURAmrFicFBL3
 3E4wXeO5gpcUd8J11riLXcltDgXoBle7xU7Oqw13nhspstY+GkKQvUSWa82nFPBcMt+g
 k+fw==
X-Gm-Message-State: AC+VfDwVdi/FPTS1vVTLmZUTawVA4PXwW9uLNmnIeM4KEuwvHGp2ikxo
 T97hRgkXTEncVYcX03rP99AZGvxGqFecr2Yn+0Ejc/Sr
X-Google-Smtp-Source: ACHHUZ5asGYWLPOtR/jkuoalGwnmnhf+e0wJ/MUkSeuO5y+OPKrqEmTxMWB1gFka5bPJF4dN4xi95A==
X-Received: by 2002:a17:907:7ba0:b0:989:4b:e69e with SMTP id
 ne32-20020a1709077ba000b00989004be69emr2430933ejc.4.1687249589975; 
 Tue, 20 Jun 2023 01:26:29 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/16] exec/cpu-defs: Check for SOFTMMU instead of !USER_ONLY
Date: Tue, 20 Jun 2023 10:26:10 +0200
Message-Id: <20230620082611.770620-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We want to check the softmmu tlb availability, not
if we are targetting system emulation. Besides, this
code could be used by user emulation in the future.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230605230216.17202-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-defs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 0d418a0384..4cb77c8dec 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -60,7 +60,7 @@
  */
 #define NB_MMU_MODES 16
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 #include "exec/tlb-common.h"
 
 /* use a fully associative victim tlb of 8 entries */
@@ -89,9 +89,9 @@
 #  endif
 # endif
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
 /*
  * The full TLB entry, which is not accessed by generated TCG code,
  * so the layout is not as critical as that of CPUTLBEntry. This is
@@ -133,9 +133,9 @@ typedef struct CPUTLBEntryFull {
     TARGET_PAGE_ENTRY_EXTRA
 #endif
 } CPUTLBEntryFull;
-#endif  /* !CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 
-#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
+#if defined(CONFIG_SOFTMMU) && defined(CONFIG_TCG)
 /*
  * Data elements that are per MMU mode, minus the bits accessed by
  * the TCG fast path.
@@ -201,7 +201,7 @@ typedef struct CPUTLB {
 
 typedef struct CPUTLB { } CPUTLB;
 
-#endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
+#endif /* CONFIG_SOFTMMU && CONFIG_TCG */
 
 /*
  * This structure must be placed in ArchCPU immediately
-- 
2.34.1


