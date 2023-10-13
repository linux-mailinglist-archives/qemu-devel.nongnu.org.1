Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 493A77C863C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHjH-0004Nr-Mg; Fri, 13 Oct 2023 08:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHj9-0004Mh-7p
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHj7-0002ee-CZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:57:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so3852066a12.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201831; x=1697806631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yYXPRc/xEWiPRWLkGZcxqQvValoM9UBry2nkc5FvzM=;
 b=SJiBlll7cxNYFVHVlldeMQRzkpD6odpAXKkzpfGBYqfIn9lln1O0b9a31e6ZVEl/RI
 jC6CFh/j0YlCHqwts7kTVcoCvQwzkyGSQ3BPL3kn/8LgoLGIkpjsN/KZ+kG72s2R3W0s
 BW1K5JCRUe2FyUhZUn/W8qwb9kPBN/tRx7gsba61FZc+cFfKv9Zh5pw1NQkGoCbTZKCE
 cxK9ef2GU7epKs23aWxb0zny6zUNn0aKs50ATfBB/dtaoRO2oBOunYy0O8WvSxvlYwiu
 KWIDkeKjNN+WAgwLWuPPoe192sgiLweJj/vwNqf8F16BBlBOgjUzCTZxXJ8mdGWNZEoD
 bW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201831; x=1697806631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8yYXPRc/xEWiPRWLkGZcxqQvValoM9UBry2nkc5FvzM=;
 b=O/7JdOz0SOHjbluD/nP68UIfnz4PS8+I7Px5Jh7GIDDYxVb/iY18tnLoYOieOSV27/
 sq/o0RL8iyw0+lzziiTg9OR2LWEPqBYfB74Y2Y/B9fJKjaO+r5VzX+R2GeR1W3aBpGO8
 Zjim56iT+v3lBdR9FYjgPguNotDlr3kCt4XXt2Q7y/pM/bcAA940a2Q1UVVect9fqE+f
 xVBxbtfkOcfkSkRaWr4V04CPNn2uNlgsI/OZnmlkeYjHn5yE2l8gUXKcEvqYIGDHorC0
 hqnJ6f4gXtGZUtLY6XQreb5zqSWclFckP/tdAI6xE6qrsbTCbPWV8YGQaDPHFlbLO1nA
 2g2A==
X-Gm-Message-State: AOJu0YxFGYtKO9XRJCc6vMxktf5xxrjAOsHnotiDZGiHOi+rR3KDJLmF
 kUWuvXDdVM8xup3vUyPBonGuV+khVWo77g46xHc=
X-Google-Smtp-Source: AGHT+IECYqAE9bzPbfKcjSRvaNnh9mg6UhX2AHxgiZxp9tS+MBe1lvhsz30q6+N09Wu+lCH7F/SHUA==
X-Received: by 2002:a17:907:7711:b0:9ae:82b4:e309 with SMTP id
 kw17-20020a170907771100b009ae82b4e309mr24106310ejc.0.1697201831561; 
 Fri, 13 Oct 2023 05:57:11 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170906560500b009b8dbdd5203sm12337668ejq.107.2023.10.13.05.57.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] target/ppc: Move powerpc_mmu_t definition to 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:29 +0200
Message-ID: <20231013125630.95116-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013125630.95116-1-philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The powerpc_mmu_t definition is only used by target/ppc/, no need
to expose it. Restrict it by moving it to "target/ppc/cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/cpu-qom.h | 43 -------------------------------------------
 target/ppc/cpu.h     | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index b2e42c2996..5bdca472be 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -36,49 +36,6 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 
 #define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
 
-/*****************************************************************************/
-/* MMU model                                                                 */
-typedef enum powerpc_mmu_t powerpc_mmu_t;
-enum powerpc_mmu_t {
-    POWERPC_MMU_UNKNOWN    = 0x00000000,
-    /* Standard 32 bits PowerPC MMU                            */
-    POWERPC_MMU_32B        = 0x00000001,
-    /* PowerPC 6xx MMU with software TLB                       */
-    POWERPC_MMU_SOFT_6xx   = 0x00000002,
-    /*
-     * PowerPC 74xx MMU with software TLB (this has been
-     * disabled, see git history for more information.
-     * keywords: tlbld tlbli TLBMISS PTEHI PTELO)
-     */
-    POWERPC_MMU_SOFT_74xx  = 0x00000003,
-    /* PowerPC 4xx MMU with software TLB                       */
-    POWERPC_MMU_SOFT_4xx   = 0x00000004,
-    /* PowerPC MMU in real mode only                           */
-    POWERPC_MMU_REAL       = 0x00000006,
-    /* Freescale MPC8xx MMU model                              */
-    POWERPC_MMU_MPC8xx     = 0x00000007,
-    /* BookE MMU model                                         */
-    POWERPC_MMU_BOOKE      = 0x00000008,
-    /* BookE 2.06 MMU model                                    */
-    POWERPC_MMU_BOOKE206   = 0x00000009,
-#define POWERPC_MMU_64       0x00010000
-    /* 64 bits PowerPC MMU                                     */
-    POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
-    /* Architecture 2.03 and later (has LPCR) */
-    POWERPC_MMU_2_03       = POWERPC_MMU_64 | 0x00000002,
-    /* Architecture 2.06 variant                               */
-    POWERPC_MMU_2_06       = POWERPC_MMU_64 | 0x00000003,
-    /* Architecture 2.07 variant                               */
-    POWERPC_MMU_2_07       = POWERPC_MMU_64 | 0x00000004,
-    /* Architecture 3.00 variant                               */
-    POWERPC_MMU_3_00       = POWERPC_MMU_64 | 0x00000005,
-};
-
-static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
-{
-    return mmu_model & POWERPC_MMU_64;
-}
-
 /*****************************************************************************/
 /* Input pins model                                                          */
 typedef enum powerpc_input_t powerpc_input_t;
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d8cf4c03bf..c2cd069095 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -217,6 +217,48 @@ typedef enum powerpc_excp_t {
     POWERPC_EXCP_POWER10,
 } powerpc_excp_t;
 
+/*****************************************************************************/
+/* MMU model                                                                 */
+typedef enum powerpc_mmu_t {
+    POWERPC_MMU_UNKNOWN    = 0x00000000,
+    /* Standard 32 bits PowerPC MMU                            */
+    POWERPC_MMU_32B        = 0x00000001,
+    /* PowerPC 6xx MMU with software TLB                       */
+    POWERPC_MMU_SOFT_6xx   = 0x00000002,
+    /*
+     * PowerPC 74xx MMU with software TLB (this has been
+     * disabled, see git history for more information.
+     * keywords: tlbld tlbli TLBMISS PTEHI PTELO)
+     */
+    POWERPC_MMU_SOFT_74xx  = 0x00000003,
+    /* PowerPC 4xx MMU with software TLB                       */
+    POWERPC_MMU_SOFT_4xx   = 0x00000004,
+    /* PowerPC MMU in real mode only                           */
+    POWERPC_MMU_REAL       = 0x00000006,
+    /* Freescale MPC8xx MMU model                              */
+    POWERPC_MMU_MPC8xx     = 0x00000007,
+    /* BookE MMU model                                         */
+    POWERPC_MMU_BOOKE      = 0x00000008,
+    /* BookE 2.06 MMU model                                    */
+    POWERPC_MMU_BOOKE206   = 0x00000009,
+#define POWERPC_MMU_64       0x00010000
+    /* 64 bits PowerPC MMU                                     */
+    POWERPC_MMU_64B        = POWERPC_MMU_64 | 0x00000001,
+    /* Architecture 2.03 and later (has LPCR) */
+    POWERPC_MMU_2_03       = POWERPC_MMU_64 | 0x00000002,
+    /* Architecture 2.06 variant                               */
+    POWERPC_MMU_2_06       = POWERPC_MMU_64 | 0x00000003,
+    /* Architecture 2.07 variant                               */
+    POWERPC_MMU_2_07       = POWERPC_MMU_64 | 0x00000004,
+    /* Architecture 3.00 variant                               */
+    POWERPC_MMU_3_00       = POWERPC_MMU_64 | 0x00000005,
+} powerpc_mmu_t;
+
+static inline bool mmu_is_64bit(powerpc_mmu_t mmu_model)
+{
+    return mmu_model & POWERPC_MMU_64;
+}
+
 #define PPC_INPUT(env) ((env)->bus_model)
 
 /*****************************************************************************/
-- 
2.41.0


