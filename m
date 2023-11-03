Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0BE7E0799
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:40:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8v-0005O7-Iw; Fri, 03 Nov 2023 13:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8o-0005M8-FB
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy8Q-0003eL-1w
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:39:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc3c51f830so19452135ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033140; x=1699637940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NhQ6Rz7YzStm0UnlSc7WpS9+YP7leMvfV4vMqg/a6gw=;
 b=gcG7y38j9DcPedewoZBelol68BtveeXXli+n+SpU7NqbaPzm6s4TmiJp1SNS1Rw48l
 txfsqcGCo+CXi610Nj16lqmrnnVq8VfjvT2unaxfV49uL5Fd2bPqmt9hpwM+o+nyuQOK
 bszfAuyLlBS8kxt+gFzt+RihVZCsvu1e4lVs8lJjoiM/UP5ceQULz7y6nRGoTFMTUvs6
 dERUvMl4SypE0dO4LWIEhpG1nuwZRLoaYFHIUJodgweGJQAUE0E5i3MB65Lr+CHbAJxy
 kqhXkpPEH02u/HzNjVmDcyKq5cs+wTDNsAvhg5TGMPhOCLSMYnv7YYP7jd0DHqlyefgR
 wINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033140; x=1699637940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NhQ6Rz7YzStm0UnlSc7WpS9+YP7leMvfV4vMqg/a6gw=;
 b=GpDy+09y/rFXue/qgSO0E76aIoHfkbZG9LM2OqT1Cb9oM/TXEnVU7h6XJ+59GFBPC6
 Fjz60EaM2IL8asiBc3fOznMsYt0q56wB/tbdl4mNsMKz1iglWOfCoTtB10MBkndify3w
 Z2l0bgrT7i91t6JZy8U4vJ1lrSXOkLO5OMnvH5Q6K+zCy1dUi8ixcLMeNRTLly+tOaQ5
 mPyVLEv5+Fq4PdPUb4qAW2YVI3APOOGnfUJzaGk+ZuHW1vsHe39bDr2imbXAVS7yklFK
 Sm5HqFmQVGgoaUxaKdW5KxggJ15mGKWHLhvpM2yRkDQWIDUJxBoC9mCfXdSCXEKfIbx2
 Bj5A==
X-Gm-Message-State: AOJu0YwM69P9mKovTiRLBftwFMmvfpG0NoHLA19WjoVTggS+T0S6Y9vd
 /1P+GcLTpqNOY3nDo9Al8NRvBqOVZT8bMdX5GYY=
X-Google-Smtp-Source: AGHT+IFEI8grCIE4F+NmpGpRZfjnUPmcyrE0ERonGY5kVIiLM7aUvf498Pspy4VVY4TUa4iFHYKRyg==
X-Received: by 2002:a17:903:24d:b0:1cc:9781:4782 with SMTP id
 j13-20020a170903024d00b001cc97814782mr4681845plh.62.1699033140262; 
 Fri, 03 Nov 2023 10:39:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 22/22] target/sparc: Remove FSR_FTT_NMASK, FSR_FTT_CEXC_NMASK
Date: Fri,  3 Nov 2023 10:38:41 -0700
Message-Id: <20231103173841.33651-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These macros are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 30bab9a7b3..9ca9fb30ff 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -202,13 +202,6 @@ enum {
 #define FSR_FTT1   (1ULL << 15)
 #define FSR_FTT0   (1ULL << 14)
 #define FSR_FTT_MASK (FSR_FTT2 | FSR_FTT1 | FSR_FTT0)
-#ifdef TARGET_SPARC64
-#define FSR_FTT_NMASK      0xfffffffffffe3fffULL
-#define FSR_FTT_CEXC_NMASK 0xfffffffffffe3fe0ULL
-#else
-#define FSR_FTT_NMASK      0xfffe3fffULL
-#define FSR_FTT_CEXC_NMASK 0xfffe3fe0ULL
-#endif
 #define FSR_FTT_IEEE_EXCP (1ULL << 14)
 #define FSR_FTT_UNIMPFPOP (3ULL << 14)
 #define FSR_FTT_SEQ_ERROR (4ULL << 14)
-- 
2.34.1


