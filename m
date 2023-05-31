Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1B7174EB
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7X-0004ce-FQ; Wed, 31 May 2023 00:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D7B-0003CH-3U
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:14 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D75-0006v6-O0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:12 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-39a523e8209so23410b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506025; x=1688098025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=H24fyidw2Mts4UgybMsZXcSBtkvN1xbQ1AV6r3ckQ6Y=;
 b=G/pSZ3rHfbBc9FT/9EhIqO1JQHpC6oBXoh6ZpcAdeEfW8zBL8i8VI3hiSQOsxwa2SD
 jwL7aNWqW4Or9oCWX/308ICQUrRTjo1T22IyS09DovSiML2dEfC4D3WrIdsFtuWlr6Gv
 B+4D0YYx3O52gEXNKmMkAnMrAvthRA1nXPBRDnUHufqq+Gz6ZEcOFq/1+XfCgdKZJdRF
 yiclVOTDC85ImGEQ9ytv1SrmZF38B64ftsd7VRfIKZ+vynsuvYT7hA0jKfPMKzkm2x2D
 t2cs4nugi9kA+WV3rGXTh261b8bjxMpBFCg8ZwfMx/uMcs/MGV2NbX512gzD0RRM/VvN
 nxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506025; x=1688098025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H24fyidw2Mts4UgybMsZXcSBtkvN1xbQ1AV6r3ckQ6Y=;
 b=TE1qkfhuvC2fIIHdFDgDxONPscAeNNejfyLfaOyVYkUFk4CHDiwqqf4+NQMNdvedyD
 qqquoXPIUDsTkS25l64KiOFtj/CGBFBtx2epcesRjOZNxGoqmVBngCsCHRwG1mig17va
 4ngO46vXHb+8KxBCATwwlkrnJUtvhklzfTuHH1BZc6V5LSmy6nOeeezh2fcQxzQl26bV
 QSwdK/ka7a8fzPuIuGImKE/a4yUSSnlenV6gWSj9YUnALTOFgsw2wHQ8R6deLyHC2Na8
 p+HVj4S7gLRPpim0Gfq9O6LPrrGSoNZvbjsulAcfw2Nd2xX+HR5Z7d6851c1yCbWp+Vk
 xeJg==
X-Gm-Message-State: AC+VfDxm9o/ztGZkeFPp+LpOR/jwFw6sqy2rgD0O/Rb1Ns0U3WBJK5uT
 xbQ+9Fb0oatU2/Twby88vdNMfF3ivL/GDR9LQlg=
X-Google-Smtp-Source: ACHHUZ7++cWADdqLkq5tBe8zHQk/uSkBinvC5UwM9ny79mk3abx6mCCWg9huucn4F4nMW4fvPuXBkw==
X-Received: by 2002:a05:6808:2a6d:b0:397:c038:54ef with SMTP id
 fu13-20020a0568082a6d00b00397c03854efmr2459995oib.0.1685506024829; 
 Tue, 30 May 2023 21:07:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 42/48] tcg: Fix PAGE/PROT confusion
Date: Tue, 30 May 2023 21:03:24 -0700
Message-Id: <20230531040330.8950-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

The bug was hidden because they happen to have the same values.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index bef4c4756f..f8410ba5db 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -505,6 +505,14 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
     return PROT_READ | PROT_WRITE;
 }
 #elif defined(_WIN32)
+/*
+ * Local source-level compatibility with Unix.
+ * Used by tcg_region_init below.
+ */
+#define PROT_READ   1
+#define PROT_WRITE  2
+#define PROT_EXEC   4
+
 static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
     void *buf;
@@ -525,7 +533,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
     region.start_aligned = buf;
     region.total_size = size;
 
-    return PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    return PROT_READ | PROT_WRITE | PROT_EXEC;
 }
 #else
 static int alloc_code_gen_buffer_anon(size_t size, int prot,
@@ -794,10 +802,10 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * buffer -- let that one use hugepages throughout.
      * Work with the page protections set up with the initial mapping.
      */
-    need_prot = PAGE_READ | PAGE_WRITE;
+    need_prot = PROT_READ | PROT_WRITE;
 #ifndef CONFIG_TCG_INTERPRETER
     if (tcg_splitwx_diff == 0) {
-        need_prot |= PAGE_EXEC;
+        need_prot |= PROT_EXEC;
     }
 #endif
     for (size_t i = 0, n = region.n; i < n; i++) {
@@ -807,9 +815,9 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
         if (have_prot != need_prot) {
             int rc;
 
-            if (need_prot == (PAGE_READ | PAGE_WRITE | PAGE_EXEC)) {
+            if (need_prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
                 rc = qemu_mprotect_rwx(start, end - start);
-            } else if (need_prot == (PAGE_READ | PAGE_WRITE)) {
+            } else if (need_prot == (PROT_READ | PROT_WRITE)) {
                 rc = qemu_mprotect_rw(start, end - start);
             } else {
                 g_assert_not_reached();
-- 
2.34.1


