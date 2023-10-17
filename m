Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408437CBAD6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK4-0008Pl-3U; Tue, 17 Oct 2023 02:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK1-0008OR-To
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:53 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK0-0003pd-55
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:53 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-564af0ac494so3493991a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523171; x=1698127971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=iCmgv6Hlx/rSWoKvz4LywCJ44ZlF/zYmmf5Y9KT6+rvgekTjhptCF+em2iQqq+Ewj/
 Tjmlpzp/eTOGrAIlk4u/52QO1FzeM8w2uv5ZxNsES7qC2OnCtijs9VhGRtFZRUVY0CvV
 IXGdPdusjuqo2R8z3Be/bGMKcEqnF9xfrmS0kZgI7S2SwlsjRKZKclCiSbng9WODcG8O
 N4S67bKAP6ktFQL2lYsBLT+OTC0jVnlRbuqiem1ZTi+FVicC9Zn5H6int6gHpiMuqvB2
 kUppoQohGBlcewIIRlQyCRsHUMMIJiUXx9KFkDDR0GTuOU+CbhOHdZd4wKACkevhi1p0
 jG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523171; x=1698127971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=M1E7uAQhWXSAj8UuXFxfAOTh1eOUK8lhyuYyDHH/48CTVUbg+n7zNq9r7VITtrWlG0
 6WHVEcPH893nEWOxXZl3Z/DxYWHSz8JJOzaKXZu1TDrCL1YBfM/JRtS2cFPh6xL2e4oP
 +pt0dneDJqanuBFAm80vQ1/UfTzJN9rHf/udsoxPPGshhVcHbtPbd1mZg+QWsNmKe3Py
 VZYP+4BWrbK5/LZUCum85OvZUc0NUHaYWTWFVJQMEZoOMlB22lxwdVyfTQViUSRdjLlH
 7XUg9a73iMXuMnILEmOzDQqORn3XI40dfrAd/mdRXpYfzZb2gtEwls/dbA6UIbw6r5bC
 eDtg==
X-Gm-Message-State: AOJu0Yz8x8/V5T3cAsaBv/bbSB0Kh4jBrP7v5gvjDm77t3CUB5AdKs3n
 OXtNoAZbYTpmNxetqfcODFSDWbPuK8RNjon33MU=
X-Google-Smtp-Source: AGHT+IELfMFLFlTxW9/y2PDGfKale1jy8IAy9ZD0yAEiVuh945qSHast6qfOvCXoMqGVLaxldO/q9Q==
X-Received: by 2002:a05:6a20:1448:b0:16c:b514:a4c2 with SMTP id
 a8-20020a056a20144800b0016cb514a4c2mr1431254pzi.16.1697523170789; 
 Mon, 16 Oct 2023 23:12:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 06/90] target/sparc: Define features via cpu-feature.h.inc
Date: Mon, 16 Oct 2023 23:11:20 -0700
Message-Id: <20231017061244.681584-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Manage feature bits automatically.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h             | 32 +++++++++++++-------------------
 target/sparc/cpu-feature.h.inc | 19 +++++++++++++++++++
 2 files changed, 32 insertions(+), 19 deletions(-)
 create mode 100644 target/sparc/cpu-feature.h.inc

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 9fc5c401d2..aaecbf0876 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -291,25 +291,19 @@ struct sparc_def_t {
     uint32_t maxtl;
 };
 
-#define CPU_FEATURE_FLOAT        (1 << 0)
-#define CPU_FEATURE_FLOAT128     (1 << 1)
-#define CPU_FEATURE_SWAP         (1 << 2)
-#define CPU_FEATURE_MUL          (1 << 3)
-#define CPU_FEATURE_DIV          (1 << 4)
-#define CPU_FEATURE_FLUSH        (1 << 5)
-#define CPU_FEATURE_FSQRT        (1 << 6)
-#define CPU_FEATURE_FMUL         (1 << 7)
-#define CPU_FEATURE_VIS1         (1 << 8)
-#define CPU_FEATURE_VIS2         (1 << 9)
-#define CPU_FEATURE_FSMULD       (1 << 10)
-#define CPU_FEATURE_HYPV         (1 << 11)
-#define CPU_FEATURE_CMT          (1 << 12)
-#define CPU_FEATURE_GL           (1 << 13)
-#define CPU_FEATURE_TA0_SHUTDOWN (1 << 14) /* Shutdown on "ta 0x0" */
-#define CPU_FEATURE_ASR17        (1 << 15)
-#define CPU_FEATURE_CACHE_CTRL   (1 << 16)
-#define CPU_FEATURE_POWERDOWN    (1 << 17)
-#define CPU_FEATURE_CASA         (1 << 18)
+#define FEATURE(X)  CPU_FEATURE_BIT_##X,
+enum {
+#include "cpu-feature.h.inc"
+};
+
+#undef FEATURE
+#define FEATURE(X)  CPU_FEATURE_##X = 1u << CPU_FEATURE_BIT_##X,
+
+enum {
+#include "cpu-feature.h.inc"
+};
+
+#undef FEATURE
 
 #ifndef TARGET_SPARC64
 #define CPU_DEFAULT_FEATURES (CPU_FEATURE_FLOAT | CPU_FEATURE_SWAP |  \
diff --git a/target/sparc/cpu-feature.h.inc b/target/sparc/cpu-feature.h.inc
new file mode 100644
index 0000000000..d35fe90c92
--- /dev/null
+++ b/target/sparc/cpu-feature.h.inc
@@ -0,0 +1,19 @@
+FEATURE(FLOAT)
+FEATURE(FLOAT128)
+FEATURE(SWAP)
+FEATURE(MUL)
+FEATURE(DIV)
+FEATURE(FLUSH)
+FEATURE(FSQRT)
+FEATURE(FMUL)
+FEATURE(VIS1)
+FEATURE(VIS2)
+FEATURE(FSMULD)
+FEATURE(HYPV)
+FEATURE(CMT)
+FEATURE(GL)
+FEATURE(TA0_SHUTDOWN) /* Shutdown on "ta 0x0" */
+FEATURE(ASR17)
+FEATURE(CACHE_CTRL)
+FEATURE(POWERDOWN)
+FEATURE(CASA)
-- 
2.34.1


