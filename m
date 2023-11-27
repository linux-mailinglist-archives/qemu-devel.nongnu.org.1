Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 881957FA78E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f5z-0007Q6-ED; Mon, 27 Nov 2023 12:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5x-0007PX-63
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:29 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f5v-0004cW-DA
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:28 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b31232bf0so36333965e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104906; x=1701709706; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EExjjsQKHG4G/S0rA+HN9RE1Zx7xegOtzNg+8uLL5Ts=;
 b=hq6fvtv1SK0VBy7Fusz3pDg5T3lp1xjf6jBXHXnue4YQvZkFP5AYLhlDrts8SHV75M
 mBAArYibyVZUUkkkdX2U8qaM3zQuOCf08hmrvCaboenyY9u6RtMCJBdpugeWRaUKQmog
 2FGg4gi9Y9UwWRa22oJ5rjrT98F/nxABa5v7te/TaLQEInPKaunvrmCIioLqdRHM3f5o
 v7/NOTUqkAuYOmw9BGGp6TvxO1J5zZ9XHfulfy3IOlRd7kdZyObsW8Gw97ViS4pNPktq
 JyaDm5ojbkh/SJXSGDUnYfcJ8qawBCCxUJHo8qnQgtnuEfoVOiIb1cQKgN8tYz/y+ctV
 udbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104906; x=1701709706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EExjjsQKHG4G/S0rA+HN9RE1Zx7xegOtzNg+8uLL5Ts=;
 b=gIS4frkWrqGOG2HYWPtqMbBLXx9aJ0uNOCNuCHsFDzwPDdRfUWMchwPnVT+yD52Pap
 Tj3U52PGigy3zb2yknE/gpBdGuo4VxdRq3rfZOMy+kJIzuPTs0mVFBBUnCIzM8ZTvPdO
 F+tFb78Wfc4YJpuzenVChMbW5Oy3S74Uq1NRBUKm0vmIw/IsKA7NjDP5jGJ7858BdHxa
 uOWwsxJcDgh3jLLyU0bj+Bt4n6BtxxVTTC6Sc02a2ywolvjg1yisQ9kv84p1WQcAezWq
 cux6nogDXhVAJ4EIKBMQs3F0CTQj1tcT7bmN+tBWPGYiol1k7EPjPcz2cA6xs8YL/3lv
 s2Uw==
X-Gm-Message-State: AOJu0YwfjRavi+1M1LMQb72ZY7KGLJDVfQmIGvSUkMvcdJpzr3nuS4Ns
 SW9V3UcwCd8GE+MRJQjy1tjEsd+RNucyOaS9Adw=
X-Google-Smtp-Source: AGHT+IGrkzCb6cqK4LFhDn7anN1mQBj3I2Twky5WOJXBLkRQPJOCodKD1DPWbr/D2kvyBN8HLwIuFQ==
X-Received: by 2002:a05:600c:35d3:b0:40b:3d8a:ed34 with SMTP id
 r19-20020a05600c35d300b0040b3d8aed34mr7516386wmq.13.1701104905978; 
 Mon, 27 Nov 2023 09:08:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] target/arm: Set IL bit for pauth, SVE access,
 BTI trap syndromes
Date: Mon, 27 Nov 2023 17:08:11 +0000
Message-Id: <20231127170823.589863-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The syndrome register value always has an IL field at bit 25, which
is 0 for a trap on a 16 bit instruction, and 1 for a trap on a 32
bit instruction (or for exceptions which aren't traps on a known
instruction, like PC alignment faults). This means that our
syn_*() functions should always either take an is_16bit argument to
determine whether to set the IL bit, or else unconditionally set it.

We missed setting the IL bit for the syndrome for three kinds of trap:
 * an SVE access exception
 * a pointer authentication check failure
 * a BTI (branch target identification) check failure

All of these traps are AArch64 only, and so the instruction causing
the trap is always 64 bit. This means we can unconditionally set
the IL bit in the syn_*() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231120150121.3458408-1-peter.maydell@linaro.org
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/syndrome.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 5d34755508d..95454b5b3bb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -216,7 +216,7 @@ static inline uint32_t syn_simd_access_trap(int cv, int cond, bool is_16bit)
 
 static inline uint32_t syn_sve_access_trap(void)
 {
-    return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
+    return (EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 /*
@@ -242,12 +242,12 @@ static inline uint32_t syn_pacfail(bool data, int keynumber)
 
 static inline uint32_t syn_pactrap(void)
 {
-    return EC_PACTRAP << ARM_EL_EC_SHIFT;
+    return (EC_PACTRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL;
 }
 
 static inline uint32_t syn_btitrap(int btype)
 {
-    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | btype;
+    return (EC_BTITRAP << ARM_EL_EC_SHIFT) | ARM_EL_IL | btype;
 }
 
 static inline uint32_t syn_bxjtrap(int cv, int cond, int rm)
-- 
2.34.1


