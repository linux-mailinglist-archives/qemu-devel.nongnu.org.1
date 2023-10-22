Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 498087D2137
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW5-0000Vz-Tt; Sun, 22 Oct 2023 02:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVz-0000OX-1A
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:43 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVv-0001Us-8A
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:42 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b3ec45d6e9so1515876b6e.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954438; x=1698559238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=qW+39a1ugRe+Xa9In7JE6U4kNvp2x1fOntzxXcGfFno1fQ4aR2qKtszcp2hIc89vn+
 WoGEQTss4EcE9RPK/tYj03Q8TlerR1XBP656V5YC6IhkFVNiooPdEnvyBAXjOfd0wYJ6
 Ralyj/Wq/D9NMgIXutGMfMwwOnxjiGt5XJuHxt6HqsI1biOifDHVE6SLWQrDe22Lnj9Z
 MEHUrukXxyhbMnd8bKTPquBJDPkn+3dAa5ykB43+6NljcQZkFU5oqsB4bvDKRSmNxnZA
 bBEV26UvdW92RgjC+j5raPb8CPC86GW7iOW0poNO9zkLxpbngmNoD2w5630Ov3x/rv04
 XiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954438; x=1698559238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=Q7k0yvu55yeEyVoiDIiW5EKoWA9ripMCBtf8yBBzYPlZKipzyxWXAOP/zxyNfWroWp
 v+zs29VvMk6dyeBzeXpBRZ75C2yixyDiLrBAuabuK+cf+krq1AtIPE2Wexp/5GwSE22G
 bloATXRVCPv5c6ZDOC0hkDt98DclAHeGu3CBjYrmaBx67xQ3j+EPF95Wx/GK8pYtA1l5
 DX5xrxkxunk6HZ6MhP0iXoFvhxek/5nTcntu35hh4JJsEnc2ABBqVKQB6Dqbq7LbrUuc
 Wwe9vt5fgQX0wfbaeW2lObn2mQXJNORrCkZpXAH2XeMf9yJWRPIDwsHWmv3Vohq4FEZ8
 J0mQ==
X-Gm-Message-State: AOJu0YzpvfW7XQNowLYTY4FFNZ9lpY0of287oA7nAVpDnBMdLfTTYSwb
 G96EKeLTPUjr42IyEjGpf3ACvZ7wL2KkNKQddwY=
X-Google-Smtp-Source: AGHT+IGLrFelT3MRPHy5qMiurpAvX9IJvdAjCsDeLkBpPF7GhrQAQX14OrQpnEvRZcwr97EW+XACDw==
X-Received: by 2002:a05:6808:ecb:b0:3b2:ee79:c0fd with SMTP id
 q11-20020a0568080ecb00b003b2ee79c0fdmr7554968oiv.1.1697954438056; 
 Sat, 21 Oct 2023 23:00:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 06/90] target/sparc: Define features via cpu-feature.h.inc
Date: Sat, 21 Oct 2023 22:59:07 -0700
Message-Id: <20231022060031.490251-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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


