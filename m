Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2F716D03
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:01:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zv-0000uC-AL; Tue, 30 May 2023 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZY-0000mk-5X
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:56 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZV-0000sR-RI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-25691a1b2b8so1444225a91.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473192; x=1688065192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoEMis0kyhsJX42FKpROxvOgsZYA3JLlv/upAz9v6bQ=;
 b=FuRfhdA23q6j+ztqHZ5fEgV/Q/UMqZtdhatuMjGEHCPNxb61vt+n5X6lkrgENeUQGb
 lfyD+pVEHF8Dm4ef2Q1UUUMuMR/NCBOZpK+EOWsqMyC474VwZLUFpVjbqUXlwOa/sQ8C
 TL/C4MWBA4302oVHU8IpG3lKlk4g0RimJW1tBihes9SdBSaIuOXpoWDayiYx7ETFxxWR
 v82uVqyMKr1pJTDSm1CTRK7u5iKFe2Ccc7vWbHnSHGydAtdsLgk0r2LePjLGKEFAido5
 PEfmHXSaN9q80eIwRjTSIxvD9L9RqCS0e6j0wxD6xins8GVUwOdQ+iph2iV8r15JXzz1
 Aw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473192; x=1688065192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoEMis0kyhsJX42FKpROxvOgsZYA3JLlv/upAz9v6bQ=;
 b=DN2GgckLszi4fz8uOAWS1b4eEvq2WV/jmNCoKDQFdI8ZHkiZ1/NdSGmxVR7mJpEB7W
 mo6LKLkSSq8sej9qjC8dzVAwb2WVvjg5uZ5TWsusOPpqKRqtki4km9KQqNzmIIJaQA2D
 5DJtWMCqUzEg/rRaSLH6DYy3k+m/4QTgdgHE99izp0SgkAD3sve+elqSCRaI4uCJr+Hp
 ptXa0Xy7OCVT0TbyfLEPb8gWQfyHeuKvUVNrKB6RTajsauJ/hNvHIiArUcLwN29BhT+T
 ek7T/MqWt/kmmjYknsEO2tB9gU+9rG7Vmfsk2Ml0fqXmU6C1N6vGrjTfNmRDhAchhZKd
 M6EQ==
X-Gm-Message-State: AC+VfDxKeIkVY/4E39jvzMbF0TlW8405xYQmFEhh+t5dqlzAfcFfp8w9
 C+ZvMHCv8b4LIUSvcRYo/5v6mPMgSymUgm/KyPY=
X-Google-Smtp-Source: ACHHUZ6Zd/kcCaQBcU4lyNodp9zeuhxBjj04WRbt/AKehMjFtXXFuP43KMbQC2c5SKyXWtqeRKitSw==
X-Received: by 2002:a17:90a:d588:b0:256:831b:8f45 with SMTP id
 v8-20020a17090ad58800b00256831b8f45mr3664739pju.16.1685473192516; 
 Tue, 30 May 2023 11:59:52 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/27] accel/tcg: Fix check for page writeability in
 load_atomic16_or_exit
Date: Tue, 30 May 2023 11:59:24 -0700
Message-Id: <20230530185949.410208-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

PAGE_WRITE is current writability, as modified by TB protection;
PAGE_WRITE_ORG is the original page writability.

Fixes: cdfac37be0d ("accel/tcg: Honor atomicity of loads")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 0f6b3f8ab6..35ce6d6368 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -156,7 +156,7 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(pv), 8, PAGE_WRITE)) {
+    if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
         uint64_t *p = __builtin_assume_aligned(pv, 8);
         return *p;
     }
@@ -191,7 +191,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (!page_check_range(h2g(p), 16, PAGE_WRITE)) {
+    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


