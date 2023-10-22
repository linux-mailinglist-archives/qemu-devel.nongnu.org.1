Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B37D2708
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtC-00074v-Ga; Sun, 22 Oct 2023 19:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht8-00073R-9f
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:43 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht6-0006hd-N6
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:42 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1eb33c06d08so981719fac.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017379; x=1698622179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jiy4wOodRVlFspzzZethCiArH1v1AZS8FVXwpd5smRE=;
 b=DO671GJ3PT5bNiMS8ZP5iQpfcypXoF/uTWfUvGVoWcxfusm4MzmWJRjn9u1+TLkE4p
 /qtFdlhIZqfKv2buGvzoafBBlXhgyqOj5He/Q7jKZmJ6L+HYQP2KwuLQ1/59Wnc/3IOH
 gY9+auc45E8f+AgO89Y64oKI2UaAJIsXMgt6AUVWMz8URtMCxNy5X0Mnc3WPJJKakOtO
 u6bI0ujOkQUi3gbiz60Oa50sjgBFAChcXc4uLruBm2tFvG2Faal5sbw78ZOmOObbqxho
 ysyubZLe6FHksdoF8myBJOSCgz1H6UaBS5mlcqUZVmdN89V1zJIeVIszrSfwNUAKwOKC
 f1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017379; x=1698622179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jiy4wOodRVlFspzzZethCiArH1v1AZS8FVXwpd5smRE=;
 b=tenCDFCN6V8bFPUrWDYDRK0JEyfhptBq9oDWgvnH1Jzbd6eSia6eT7FwMped+zzwUm
 QF0FTsxb8Qq0BXB+z7yPmYmElZrgRLwojoi6XgUg3LRgYzBeLjaa+/bxnlPMTGLR0r0o
 Yo9AMN0HaErFuF6S+ZMIrjMEj+NTPO5won3R7Lr2P69f1URFoqFH27j5HkpfUzQAz+cu
 313jQt4aAvy9YlufpisoYKTWFqkWc4bTRNkfxAkJNJTpXqhIwEiER7VnjRqQ6hVvDrYi
 BOxyF3fGmX7EnRj8Ww8gVq/b2ztFB9SJxqunI5abffUvxW8bkRFz14C7GQkn1XRHsdX1
 NoKQ==
X-Gm-Message-State: AOJu0YwSw4Mr4c2az3F+iUDVC6wwTIZjdLnaFJD9gXLDorpxP6tJJwUX
 ky8+yZ64XNGhz6TxkXucMzNhXag5ikJT03NscgE=
X-Google-Smtp-Source: AGHT+IF3GcYmFwdD00zLw6PSrkCooT6mFNDiFM+uzMAHkpDVy8waiBpS3TNK4+L9a8bXsHgTDGeDBg==
X-Received: by 2002:a05:6870:d188:b0:1e9:c28f:45b9 with SMTP id
 a8-20020a056870d18800b001e9c28f45b9mr10483645oac.19.1698017379405; 
 Sun, 22 Oct 2023 16:29:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 06/94] target/sparc: Define features via cpu-feature.h.inc
Date: Sun, 22 Oct 2023 16:28:04 -0700
Message-Id: <20231022232932.80507-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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


