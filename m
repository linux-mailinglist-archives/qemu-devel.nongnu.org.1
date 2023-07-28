Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7C767432
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPRN9-0007Ni-Bk; Fri, 28 Jul 2023 13:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPRN8-0007NS-0g
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:35:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPRN6-0004vf-Bg
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 13:35:25 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-26837895fbbso1714338a91.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 10:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690565722; x=1691170522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ACJP/cSQlj33yExohwZEBzfmCkDyB3Wg5IYx7mUDA/A=;
 b=nzcLBorQHRlrUvpNb70CrsOL29VHZpRdyqTelcftm+lsOGRE8P3p/D/WvQOyNGbQPc
 1oQRXZyrsoAAD4By3dXBpepFN5pLR2vv/56VJI7e2gFtMlg5FKYCTLbfZGGwiXA15lJk
 zlChX0ZPI6SJ4CT+q+AOvnOIfnBWAJWoUsPuJnPBiOui7jtmFQ29x7cVDFayGng4CoSr
 kg9q6KUPg0u27L7vwXBkcDrIkorIxq+Z2S3Iy9c3iN+U0fAG/QXsuAlHatUGtXtPsTGe
 sZUrNM1N7xFkM8eVrAczbHDKD6pngQh5YQDzvX0xLM0FMtUSsmwdUePKv5OmvO6YyVjF
 sXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690565722; x=1691170522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACJP/cSQlj33yExohwZEBzfmCkDyB3Wg5IYx7mUDA/A=;
 b=CiHQjcE+rBP2fJRd6nLtjOSw5T117Icx0rtAmw46ACHvioqhR785j6mKh3IhIQ5nyl
 RgtxI9CyD50jGZ5QQOnbM9FpWbdZGBTgGmBVPKAUw9mmnsQsvgOKaADdWDfHgGvgo4D6
 8cRvlR39OOFElfDBAevTA0vyNV1k33v3HQnwsibwMMolM8BUCMDGeKNyKJiNt/TvLhR1
 hL44aua8xrGRZ96vQvKI4myBp/BV8cfUK1N9DATzdAL6dNEGZ1OMW/4Sd+IjVBK0T5S8
 pfsirCLE+GK6QV/kIQOcFtcDgytiSZ8h7F7OeQ3UuR8uqVyZQhsLZBpcBSGFregq8ydW
 Dldw==
X-Gm-Message-State: ABy/qLYMhXubq7r+XZmTvKPzMeh41DCYHQ1SqEU4s3XosDO9HGkffKgs
 x1U37JmEH5MicgW+mjOPsZWqMO9GeLgfsU+gO/8=
X-Google-Smtp-Source: APBJJlHbVP+e3LWoi08ZKSOPJNqJdwBhOsE+v/43Jk5DzEVxcmC0UAOCWmWihO4d9dM3ticvZWT9Jg==
X-Received: by 2002:a17:90a:8c0e:b0:262:fbb0:8737 with SMTP id
 a14-20020a17090a8c0e00b00262fbb08737mr2385640pjo.33.1690565722646; 
 Fri, 28 Jul 2023 10:35:22 -0700 (PDT)
Received: from stoup.. ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 co4-20020a17090afe8400b00267e299f71dsm2821211pjb.7.2023.07.28.10.35.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 10:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 david@gibson.dropbear.id.au, clg@kaod.org
Subject: [PATCH] target/ppc: Disable goto_tb with architectural singlestep
Date: Fri, 28 Jul 2023 10:35:20 -0700
Message-Id: <20230728173520.486025-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The change to use translator_use_goto_tb went too far, as the
CF_SINGLE_STEP flag managed by the translator only handles
gdb single stepping and not the architectural single stepping
modeled in DisasContext.singlestep_enabled.

Fixes: 6e9cc373ec5 ("target/ppc: Use translator_use_goto_tb")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1795
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e6a0709066..74796ec7ba 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4175,6 +4175,9 @@ static void pmu_count_insns(DisasContext *ctx)
 
 static inline bool use_goto_tb(DisasContext *ctx, target_ulong dest)
 {
+    if (unlikely(ctx->singlestep_enabled)) {
+        return false;
+    }
     return translator_use_goto_tb(&ctx->base, dest);
 }
 
-- 
2.34.1


