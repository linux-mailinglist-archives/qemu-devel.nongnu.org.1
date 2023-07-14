Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFED2753F4C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:49:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0U-0007Bp-8I; Fri, 14 Jul 2023 11:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0S-0007Ae-DC
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:56 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0P-000751-I1
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:46:56 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbea14700bso19207085e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349612; x=1691941612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CiH9E7mBgPKZNIpdmx/tPxEyFtaNkc5RvSs8kkQDWdc=;
 b=tpB8rFstuTaj78dYKDrQspXQtsizJgJ7WV8QOo2zvitmtF1J9ZH66aMCgaSA2AkKh2
 dS6mEpwAN633lp2na70fjxlvG7zHv+ZmKDo5ByWGOvZOv2bjvaRJmJZHGEeY4rXY0eSw
 aW/Drf/wwutJP5GsWx+oM1Eh5HrJqL2Y4mbbaSGBeavhH2F90k4lIzVyIOQbxhlwZTKd
 F4Y/v4r6HIvlL1ETInKGNlW8P7jYj07omVAgRWkN7+OkHSFDAOVQdNn67Cq68TRTYeox
 RrPihxoH929hsils3WgrhsaeKNZ8K1jKQJTKy0KLl9zmwZFvIQ2U54WN8nSeNSrMfD7q
 6u0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349612; x=1691941612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiH9E7mBgPKZNIpdmx/tPxEyFtaNkc5RvSs8kkQDWdc=;
 b=AHoydbjyA6kmt7OAVpxq8+3zaW2/rF9T4z+v4qaHlzZxS6zDAqjYsiWM3R19Rx+iap
 S82kJ0M682EmOD9pczJXsN8fR0rg3PpRc8AlOyS+WzxUh2AvEaoxOKCNXWXDHa3svd6e
 30AIcrxYSvAdaW0n2Gj4yDLgzU7WR5v9A9Zb6gTIQOYsXOPBqBDR4HjeJ/PwpMOncnVY
 4wlJk+X99DJhrR77jpS39x09B2Gs4LeEPvpC9/Jmf9O05DkrktG6n5Y/JOmdpkG6ltmE
 T9oQpwabsTWGCUexUtLIA/4qmT3PCOWF0YB8kjYBOhoCxC9t9XYdzsjb9aTPKh6KEzfM
 Y3zA==
X-Gm-Message-State: ABy/qLaE5Es6y/OkSbPonaLqg/xXFGSGAwybF6wSdkvPV3NGJ2uiN6WJ
 aYyQCCHAmNO1aO5mk08BegiocA==
X-Google-Smtp-Source: APBJJlE2TTgs40N608v/WASyFwulkmykQvEbEbJAXNumzxLrbpmvqygZbMkM+QDLIcuD1LcAQyKDHQ==
X-Received: by 2002:adf:de12:0:b0:314:30ed:9b55 with SMTP id
 b18-20020adfde12000000b0031430ed9b55mr4580983wrm.15.1689349611418; 
 Fri, 14 Jul 2023 08:46:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/14] target/arm/ptw: Don't set fi->s1ptw for
 UnsuppAtomicUpdate fault
Date: Fri, 14 Jul 2023 16:46:35 +0100
Message-Id: <20230714154648.327466-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

For an Unsupported Atomic Update fault where the stage 1 translation
table descriptor update can't be done because it's to an unsupported
memory type, this is a stage 1 abort (per the Arm ARM R_VSXXT).  This
means we should not set fi->s1ptw, because this will cause the code
in the get_phys_addr_lpae() error-exit path to mark it as stage 2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


