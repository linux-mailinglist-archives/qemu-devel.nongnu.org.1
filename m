Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0797D7942
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:21:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2w-0007FC-EW; Wed, 25 Oct 2023 20:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2o-00073c-Mq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:14 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004qW-ND
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso2036525ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279353; x=1698884153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jiy4wOodRVlFspzzZethCiArH1v1AZS8FVXwpd5smRE=;
 b=LoKDTtOb7oiBE1o2QxLJuDXqJm8fB9ywcjqWaVOObOnpOyAOoUunP6fEI35P8vp4fh
 AgDnjhCH8r1I2Hk9cIiM+R2oq/sHCQcPP7rLF05EnEDok8+YziuFvcrrLvMyy/5grmAW
 n+pUt/Xv9NR4tkSuiEOHyBLnRSyQ4dMRcjIBteaIlV+IhQKObsqRDQt60Vuu/8Ovahg0
 TmVJD+9l+vkbzLEIPb+AK0zSRzyWnHS/lmUZoy3KjGJXH3ssnsPY5Xw19GoVxLGWYlw6
 +IytOFZSXAffbo3+TcYJ0DdOytLM6Ydcz74GVpk7KXYHfvuHgWQGPJKYmwynx7a3DfIL
 FAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279353; x=1698884153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jiy4wOodRVlFspzzZethCiArH1v1AZS8FVXwpd5smRE=;
 b=Vkk4y6tguY2Qhu5ABfoqL9mpkEBjmC6DbR1lMnxFSIYo1FwYZpRSNDslddQthPcSUH
 RukLJMjMUdqw9V2JlV5rJBFG3lSWzsVVNKyyk8itTntNr6oZzp2f8DDsrhZEGPBa8cMg
 bexqFuMBbjKLAl/9iIOR9XssoJXhBuxdKLssrrOINMkRk8sENr23bfBN+iXRaVitZN/h
 T3Hsz/sWxu2xvgazvRSOPXRHPRdmjINJuuvKn/Xy1onknsXnYMaAyzeQMXAqqFgAZ2Tc
 u5D16FgU2aaaHSwWoGRBvu9h5XbxcYZgw7p8f8LWKqmbYMJzPkpNpBxyHd9Y601qTrh9
 3JMw==
X-Gm-Message-State: AOJu0YzSwYaf4J4Sw1WyE5mkv3gbbB08dl2JDnTjoBFIMoPA/kJ2Y0jt
 /fd6MCM9ByNlafSOU+6LGW+bTh48g2MWDONtAH0=
X-Google-Smtp-Source: AGHT+IEfVkOGCfmCxgPIddWLX3GH9PcNZ3l0rt8uN+doWi8BnektMZoBuTSv3ByoE4mVsQIeTSb8jA==
X-Received: by 2002:a17:903:404d:b0:1ca:7af1:8a85 with SMTP id
 n13-20020a170903404d00b001ca7af18a85mr12583429pla.57.1698279353326; 
 Wed, 25 Oct 2023 17:15:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 06/94] target/sparc: Define features via cpu-feature.h.inc
Date: Wed, 25 Oct 2023 17:13:50 -0700
Message-Id: <20231026001542.1141412-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


