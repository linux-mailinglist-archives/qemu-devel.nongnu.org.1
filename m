Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867347D1AE1
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4aq-00077V-37; Sat, 21 Oct 2023 01:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4an-00076b-2R
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:09 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4al-0008Lo-Ee
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:08 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e10507a4d6so1163526fac.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866325; x=1698471125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=ij8rdQOAwfQjGACFLc3zle9MFKSnmk3bnbPrIn1OhKNuSr5rqYljagaFgiwpIWo2fJ
 O7nnxNHJqkm9p05GOCD27q3MTAIZsT6sSyGIIBFDigO9GgZJb5izelSUiG44bBcUvoLI
 aW31tJ4igWzdIAMBkIAZ3ohfd7hQTWw+iNHPgWNlaf2GDi3vYw0NlA6TOSvZF8u0BtvQ
 32zNOr2kjk2gNap+PuamzGt9XOaMQTJ7cEp36aXcYIfrFPIAP7r26poOh4lywyJi9Wr7
 nKneAYgm7DrG8+/pQT/L1la088RmLQXqHFNMaaBTXeM2QstwA7/v0VMGsGV6aYnhdOms
 Hwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866325; x=1698471125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tQ1zFkOdaQ00+kG6T0oOcQWDrsqZkAPXDw5MzbWcocE=;
 b=iIxAGPkcJpM6Xo3ojLk+3fFC61vdjgZ8PRZty665uBu2F69TL9LowKKEsGAxUVkoS0
 kB7/zD+3i30KtH2aYUcQG69gxMFXTY+vNQkDdEu/SrDoEiflV1wOpRQuBKolH2xa/c6p
 jdnE1ew989f97yPuBO+DuWmgqSsvh9idWxZQVV96f1qr4ExHQ2XMBAncazS8V0dIDmNC
 Sj80pBQ00eTjL/BsndbRe2XdnFRvYn+S86Oh0hLoRn9bY1siH7UEd8Ou8tnk4VY44MOc
 oDVmJfz1NRh1qzKskS9qWNfYUPTC/rufrWxavgtmTzs8eyRgPvb7IU9PkS/eA186zjxW
 MkjA==
X-Gm-Message-State: AOJu0Yzw5CAAudy1hqfPOBcU90ursSYvQqvyEqX7Cu/QJ9m726Lg5PLn
 NA7vgLI55LcGN1lwKs/B5mwdKzWb2qoUCkmlaDg=
X-Google-Smtp-Source: AGHT+IGRuNbqVj3G6E3/y5DwGkPPEyd4mCr7yJStV+5BZobEfpSAVcYO8YYVkEYFOI38Fip4Jc9rTQ==
X-Received: by 2002:a05:6870:9d8e:b0:1ea:d76b:1457 with SMTP id
 pv14-20020a0568709d8e00b001ead76b1457mr5184006oab.7.1697866325070; 
 Fri, 20 Oct 2023 22:32:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 06/90] target/sparc: Define features via cpu-feature.h.inc
Date: Fri, 20 Oct 2023 22:30:34 -0700
Message-Id: <20231021053158.278135-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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


