Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CAE772765
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT11o-0000FF-VB; Mon, 07 Aug 2023 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10z-00007g-Ub
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT10x-0005RU-2j
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:21 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fe4b95c371so16784395e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417717; x=1692022517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mTF0rpR5T9/+RGJwHtQl5zTiqKLJXEt3Fbl4hFG5dDw=;
 b=Kmnnw5f6J1PD5PC8Gkwbux13uGZIYn7v57Sy74U+sqM17YqR+Hs6bjf1diPoqv5QaR
 HZpN08etf2GPFvfCgJ1banmEscT/8QPya9FCSUee4xlt3GNdXtjP6VU6zRzabRDWTWUL
 rm8wa/JTA8IWd+IYBSQQE9yURgXWzQfJn/0X7t5D0lu7fBr0kDO9EAT04spiaAAOcxJb
 NQKPy/CdXZfGmVZtwB3sxe7EvI6FQAUUVGkxOMGEFy58Sv0rK1xgV4qJdHkFWLaXDFKZ
 PFABke3Yne31pkA8RSM9TVvvAjn0OGJShU2OFDC72AQ1+Dd2CZ820GHofWD5JsS3b3qk
 ONWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417717; x=1692022517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mTF0rpR5T9/+RGJwHtQl5zTiqKLJXEt3Fbl4hFG5dDw=;
 b=VxapGYaabmvHsdIOfIGbWKgMJVK25MwWnpqKKKFNP7iDlqvHCDqXevtNRDvsZXnO3d
 NpeUcF3F9FtAWTpTrnzdTiphQXv2pW3rsnfSzbic/khXxwLGMj3AKKQCpQBt0mQ1YzSi
 jqO7EkGn3hRdxtDO38rPysIr24WMNfxpBUt281qhuVLMtiB/AQ+IbeS+CO51dbeCvzjN
 Hr5u9mW6lQz6c69zrfU7dielkJaatLTKFdo1EeGXfzRONVIVb5jaX1yUes2nG5PpB5yh
 5UolADB0zwNRhrHnG0XkjONIyZxmgTACKPi+/+lR8wrLssFjZ8yLZLkvvXcRVSM78qi3
 vpeQ==
X-Gm-Message-State: AOJu0YzMzoGPI0ZkchbJcZ7oGvjY5SV5Z6IM/x3xAds9qrVhfPSMf+4H
 gJ7B1PlYtb2trfft6WXH7bJPBqZa7+FL3vckPyw=
X-Google-Smtp-Source: AGHT+IHDhP6kL82ZAaEDUbCRhyDeVxyDJ0XZQykVAh6jWOo+S1ZbI5g/dauN+zjh/Aei01UZwUhDzA==
X-Received: by 2002:a05:600c:1d05:b0:3fb:e1d0:6417 with SMTP id
 l5-20020a05600c1d0500b003fbe1d06417mr5437826wms.19.1691417717623; 
 Mon, 07 Aug 2023 07:15:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 02/15] target/arm/ptw: Don't report GPC faults on stage 1
 ptw as stage2 faults
Date: Mon,  7 Aug 2023 15:15:01 +0100
Message-Id: <20230807141514.19075-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In S1_ptw_translate() we set up the ARMMMUFaultInfo if the attempt to
translate the page descriptor address into a physical address fails.
This used to only be possible if we are doing a stage 2 ptw for that
descriptor address, and so the code always sets fi->stage2 and
fi->s1ptw to true.  However, with FEAT_RME it is also possible for
the lookup of the page descriptor address to fail because of a
Granule Protection Check fault.  These should not be reported as
stage 2, otherwise arm_deliver_fault() will incorrectly set
HPFAR_EL2.  Similarly the s1ptw bit should only be set for stage 2
faults on stage 1 translation table walks, i.e.  not for GPC faults.

Add a comment to the the other place where we might detect a
stage2-fault-on-stage-1-ptw, in arm_casq_ptw(), noting why we know in
that case that it must really be a stage 2 fault and not a GPC fault.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index bafeb876ad7..eb57ebd897b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -600,8 +600,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
         fi->type = ARMFault_GPCFOnWalk;
     }
     fi->s2addr = addr;
-    fi->stage2 = true;
-    fi->s1ptw = true;
+    fi->stage2 = regime_is_stage2(s2_mmu_idx);
+    fi->s1ptw = fi->stage2;
     fi->s1ns = !is_secure;
     return false;
 }
@@ -719,6 +719,12 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
         env->tlb_fi = NULL;
 
         if (unlikely(flags & TLB_INVALID_MASK)) {
+            /*
+             * We know this must be a stage 2 fault because the granule
+             * protection table does not separately track read and write
+             * permission, so all GPC faults are caught in S1_ptw_translate():
+             * we only get here for "readable but not writeable".
+             */
             assert(fi->type != ARMFault_None);
             fi->s2addr = ptw->out_virt;
             fi->stage2 = true;
-- 
2.34.1


