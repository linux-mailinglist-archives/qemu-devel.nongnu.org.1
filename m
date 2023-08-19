Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5FD78163B
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMM-0008TP-Q1; Fri, 18 Aug 2023 21:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMK-0008SY-OW
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMI-0007MO-Ho
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:32 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so11377355ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406949; x=1693011749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TypTZmAqIsrHDgQCTA3GQ1oQT8s9Tg4Z3ciGBNGUTVA=;
 b=RTcFweoeFcCB3o6g0PECxilxkaXy7/sVahUCD4vC7GmQmRYUd1jpTkELTQv/OajolF
 /MVK1e6lbHz/TiQZUZ23xiwolYGd39j6rJSdnuf2hcQ0RyJVYbiaWDo2DT6FoeA04RHG
 N0BZWY4HBDRHhf2clEP5cw4dc9Ev7bDCitw57xSZUgbY8yCpAlCE9b8SU+CDjzvqdqm6
 AaDDi4v/nydiy+JFHRssO3APGM8PZDhrJ4A5iHS3HQz21dCFUlpy9daEHYNdW550+AHR
 KbFzHXKEyyHjk5PJRVBYc4N8m2kRO59GAHj+V4ELxOooVx92RvpAowCtegKWJFCdZBAF
 wy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406949; x=1693011749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TypTZmAqIsrHDgQCTA3GQ1oQT8s9Tg4Z3ciGBNGUTVA=;
 b=CECRJZC4fyhOfPCQedUiZwUMZz3out1GMQlgVSVgCpWW3NN9vTPdQId27Vil23QYUK
 FC6VMDLJcoXh6OfYci90kZqPNWBx2YyctFwTGJv0S748+4Dq7SoXOODeGtxLe0pOb3Hr
 ltLOied4iDzeOR60rnYwosd2Z/my+DRqtOX/Da8cnXsZRNJXvMveQBDYBiE7cAxNWlBN
 0rmizuIwLdzkazfC+cPHWb1vyDPG+EIvoL93TNyA2X/8B2N+rDMcwKboofYrfl0G2f+8
 D/FG7voTwSvUZax7sJvWwaQdhQKzeK47kLifA4mO2Pit8dwReaCjX9juhcKVRwzidpQq
 +BYA==
X-Gm-Message-State: AOJu0Yx3mfMVWRZH6OdzM7w+uq74djyy9QnaEfDm72bboq9Y9APAVjy/
 DwJhaKL2BfepJxGBo/eLMaqcgsiB3ahRSu8eq/0=
X-Google-Smtp-Source: AGHT+IGJVovzICFv3k7UwLoxgqw3ocBcoFBJJRAZBt8+V+OPlZreJLEPLCFZ5y6/KgEyNAQD3oZH2A==
X-Received: by 2002:a17:902:eccf:b0:1bb:fffd:63d8 with SMTP id
 a15-20020a170902eccf00b001bbfffd63d8mr897436plh.36.1692406949152; 
 Fri, 18 Aug 2023 18:02:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 10/18] target/arm: Use clmul_32* routines
Date: Fri, 18 Aug 2023 18:02:10 -0700
Message-Id: <20230819010218.192706-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of pmull_d.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5def86b573..ffb4b44ce4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2055,18 +2055,6 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
-static uint64_t pmull_d(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-
-    for (i = 0; i < 32; ++i) {
-        uint64_t mask = -((op1 >> i) & 1);
-        result ^= (op2 << i) & mask;
-    }
-    return result;
-}
-
 void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t sel = H4(simd_data(desc));
@@ -2075,7 +2063,7 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     uint64_t *d = vd;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = pmull_d(n[2 * i + sel], m[2 * i + sel]);
+        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
     }
 }
 #endif
-- 
2.34.1


