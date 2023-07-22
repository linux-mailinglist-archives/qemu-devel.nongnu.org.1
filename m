Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2CB75DBEE
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 13:36:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNAtP-00062j-RU; Sat, 22 Jul 2023 07:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtL-00061r-7e
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNAtG-0000hx-S0
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 07:35:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso2393260f8f.3
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 04:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690025710; x=1690630510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56N41Jk8Te2RCjYHiOR0ZCSY9ldifZTYSDR9kOo+b2U=;
 b=TDvjO372y0/2S/Tg67GpOM/VdYPdh942AdISz8v93jQqFloG1bc7fmKQhVTYVlfgP9
 LinF3hs0tJwTgc4WMeSKzuQZvDu+ymol9B+GjjFjf8x6JzYPed7GSMNlj89hf9eBvgLc
 teInbui6kOCvvEfXssoiHaM4jPwuWtAJwbE+K7AWOC3OGzUdSLTTDI9xNPVa4yZa0IqE
 kVKtP88cuzwLa0EJ+0/oLb8goi3V37ZF3ZD9WGCTdOr1hpxehGAMf7uHd7OYP1agDJ8d
 16sU62JXykq+Q673ojomUO/svoCqbxb7XLABLY9hbvE2JlhXiLfPQCSsJIy+ClTDowgS
 VAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690025710; x=1690630510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56N41Jk8Te2RCjYHiOR0ZCSY9ldifZTYSDR9kOo+b2U=;
 b=dh79XgMTUHfYmq2XL6hug/KQKcI2Mf6pvZaCb36QA8mmEiICtREWw6xrAyr3vxfSJz
 BQamiZ3ZvnGvpG5zD9DBCvKJnSIyrVIhtc7AuBq5o9ISf/KHrLg42Uv/ZIt3bsfCFVrq
 QRHuYCQUBf6oFIg4nfGGLLNYhq9QKaywMqJ3YDitGEh7zGkOjBtzuke7ljJhWQfMyjfA
 M7Dv/dttdNXEyPL/s/jVaq9WBTP74b6J2O4EcnjobVwKqefZo3OuDWlVOdGG3T8lc5zS
 J7WfGO0P6f7KrP1Q9IAhBZNZUVnRCH6mLPU+8UvvD0TpOo94mdncCrG/a/dkaS6nxtM/
 7Raw==
X-Gm-Message-State: ABy/qLYzvuDRq+hkYzN3CHWA/td3nbkLzw9mZOrLokeGWcwgM2Z0NN+K
 oeUA1I9uny7lSsq0SM/m3hr9T//1nj9/cPjflmFCTQ==
X-Google-Smtp-Source: APBJJlGQsM3JzhtfAmFjs4wlx9s2iymrBTjE7Dbyyksd0sxa6own2xSDAkEOFHfhh808XAAj1IdN2w==
X-Received: by 2002:adf:fcc2:0:b0:314:3503:15ac with SMTP id
 f2-20020adffcc2000000b00314350315acmr3900272wrs.10.1690025710117; 
 Sat, 22 Jul 2023 04:35:10 -0700 (PDT)
Received: from stoup.acentic.lan
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 y15-20020a7bcd8f000000b003fbdd5d0758sm5130938wmj.22.2023.07.22.04.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 04:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 2/3] accel/tcg: Fix sense of read-only probes in
 ldst_atomicity
Date: Sat, 22 Jul 2023 12:35:06 +0100
Message-Id: <20230722113507.78332-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722113507.78332-1-richard.henderson@linaro.org>
References: <20230722113507.78332-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

In the initial commit, cdfac37be0d, the sense of the test is incorrect,
as the -1/0 return was confusing.  In bef6f008b981, we mechanically
invert all callers while changing to false/true return, preserving the
incorrectness of the test.

Now that the return sense is sane, it's easy to see that if !write,
then the page is not modifiable (i.e. most likely read-only, with
PROT_NONE handled via SIGSEGV).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/ldst_atomicity.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 4de0a80492..de70531a7a 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -159,7 +159,7 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
+    if (!page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
         uint64_t *p = __builtin_assume_aligned(pv, 8);
         return *p;
     }
@@ -194,7 +194,7 @@ static Int128 load_atomic16_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
      * another process, because the fallback start_exclusive solution
      * provides no protection across processes.
      */
-    if (page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
+    if (!page_check_range(h2g(p), 16, PAGE_WRITE_ORG)) {
         return *p;
     }
 #endif
-- 
2.34.1


