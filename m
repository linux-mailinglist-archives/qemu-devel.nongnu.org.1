Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FDF786BD5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eE-0004PO-I4; Thu, 24 Aug 2023 05:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047S-4J
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6dz-0004yj-Ih
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:53 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe61ae020bso10092715e87.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869324; x=1693474124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cvOJMWgOIR1DH7YY1zi4TyROxQHSO4tBJ9shorpuc1Y=;
 b=AJxoyxFyPueKtXYZ0IMmqlHG+cA2wTNfb3RRllFHFLPR6/v75fiuZdaYmFlWWvfzHm
 DlwBHGYdv8NNiEVJqSFkvq4gZeTlUodXhxbb03T16ufwDn0B4eaNlpZ/We8cWiErb8yN
 AIl/rZ+WuZoa3DMVrgHYYzstnAhDEXDQrqdb8TfgM8Y1z2+ihfMzDdrdexTrvG4MHYT3
 sYLNk4jjvr5Mn9CAtTivLSjG2E6+Bk0of3J7NWc+3PGs2Mp2dObC/Tlh+TStzqhDrtku
 NZkXb/QNjXY8foL7lqTnpy3XClqHcwT5Uz31lmTsH8Xvl08lrNlgFQTYziqYgk0RbwPV
 OW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869324; x=1693474124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvOJMWgOIR1DH7YY1zi4TyROxQHSO4tBJ9shorpuc1Y=;
 b=URzKsrQJm2avRPliFQoXvMBkn2c19QWGY5dBPeTRqdLIkfJ5pPXJ6EMMmbT69+x6Q0
 SOZyHGQvaW4N/Qp+WzkiG3ej6z8gKZGtbHNn/QBo51+VKiafGmDh9oMbJusNqbVKwWzR
 m/oZ1jA8yM/E052aKP0dB/VHe5obC10ob8orEhYk+aaBQDSy+dUhdoB0ntzlfhF29xKi
 wcSFIZXHZDOx8GTW6n1B794rvKAxotYXyu42jTqlZIC2BW1iMs0fvqMp6n2bRI9xFiHr
 c4TbpPr1gmyxeuuJyaos9sCqSKE0P41Pd69aGi+wXNQBNqcbxM4uM/Gks2crDZCubc+n
 83cw==
X-Gm-Message-State: AOJu0YzV9Eeu0hq0ErLMvbp68k4UQjtSellqUi4FMxdVo+GGmNeVuHae
 svvxhmzUOMAnFsFlKX2bN9+d76+yOO8bCXyr2O0=
X-Google-Smtp-Source: AGHT+IEYHBGGZbePOlkiiZ5osP0VYHlwmCWwQmoiGdeBgd29j1HKHMzrW2e51nas1qn/0nkLrFUc7g==
X-Received: by 2002:a05:6512:615:b0:4fd:d213:dfd4 with SMTP id
 b21-20020a056512061500b004fdd213dfd4mr10337277lfe.20.1692869324564; 
 Thu, 24 Aug 2023 02:28:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/35] target/arm/ptw: Don't set fi->s1ptw for
 UnsuppAtomicUpdate fault
Date: Thu, 24 Aug 2023 10:28:14 +0100
Message-Id: <20230824092836.2239644-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

For an Unsupported Atomic Update fault where the stage 1 translation
table descriptor update can't be done because it's to an unsupported
memory type, this is a stage 1 abort (per the Arm ARM R_VSXXT).  This
means we should not set fi->s1ptw, because this will cause the code
in the get_phys_addr_lpae() error-exit path to mark it as stage 2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-2-peter.maydell@linaro.org
---
 target/arm/ptw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 8f94100c61f..bafeb876ad7 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -701,7 +701,6 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
 
     if (unlikely(!host)) {
         fi->type = ARMFault_UnsuppAtomicUpdate;
-        fi->s1ptw = true;
         return 0;
     }
 
-- 
2.34.1


