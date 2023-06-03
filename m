Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A332720D69
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7i-0002xV-TG; Fri, 02 Jun 2023 22:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6b-0000aM-Ji
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:02 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6P-0004rf-Bm
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:01 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6af74ca9f4aso2703161a34.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759687; x=1688351687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQJo2C3OKYrLdgG+Avv/itkRaFPUqHtuD2xcYh5Lh3Y=;
 b=OdXJUkKlmbPfOIMb4syHFC9vqCA+CKjZqxnq3kv6h4Z5znXuxTl126Ci6RAxADj7Ew
 vkAKmgkAx1asIQSc+sWpnSJyrguLuzoq2M2P8MjPCjz9mzUCQuE1MUs7ULJbf6eRNyBv
 lmfBmvYwzRUA2pcuWHXY0k0H28CqCA/HZJlt3r9C+ncfxRVgnmgu6igPSiaO+lbfnVJU
 QuN4Dlls9KZWNvu01cbpxJa+IG8xPXYQjTsJIMkn93y43HCNqLp0WjKAl1Y0tT0hOWvt
 vF74OPKA+qKn3L/9M8cp7BU+6H69Db6DO73cKKyLeA2yKjqtfLIV4Kwn9mPWht73ysu4
 ciog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759687; x=1688351687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQJo2C3OKYrLdgG+Avv/itkRaFPUqHtuD2xcYh5Lh3Y=;
 b=c1kIw73+SXKYDcL/2ekUkWYXRVlP/gcx20VQk3aC8P+g1ZVBUCRTPookHwhHKGP43M
 ckBcdAcHqNUJgC94BTJuYmKg14w+/EAl1N3k3FpsRrDwkq+GPqMnC7j1Zrr0i48e48XZ
 WTbj/U85VGqC6l7igur80QM6zHKpDU3/e2Xyuc7+XyAG4s/vrDTpczx4YtzvHBQE7NdH
 ZKxU9G/Dl3e/+1jL6IVgLRjWAnREwQVaEaHZdwZDSg+PuPj+0tZ0C+xS/gUW3j/UsLuT
 mJRkCESW9amOXY8Mn0pDbIHw1hSzWxo8WfpCVSaT86SXpugliepcAPUZwxtC7VjDG+tU
 uuiA==
X-Gm-Message-State: AC+VfDzYW69FPt9RF71+9TQyW4WnbxIzfhyMitnmIV1NJxOhDCjimE58
 GKKDgLL8dJ4vOoL3RUIHbG3IRK4Yp/4aCTheuy0=
X-Google-Smtp-Source: ACHHUZ6K+lWlDOTAeUEFtcOfA/A5VTgW5oUjvsptqbKaf2TQ6hiujjzcb/bRVyarCSiq3fRSb1wVzQ==
X-Received: by 2002:a05:6358:4315:b0:123:3ea3:2bd2 with SMTP id
 r21-20020a056358431500b001233ea32bd2mr11882291rwc.32.1685759687666; 
 Fri, 02 Jun 2023 19:34:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 22/35] target/i386: Use aesenc_SB_SR_MC_AK
Date: Fri,  2 Jun 2023 19:34:13 -0700
Message-Id: <20230603023426.1064431-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

This implements the AESENC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/ops_sse.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/target/i386/ops_sse.h b/target/i386/ops_sse.h
index 0187651140..c7a2c586f4 100644
--- a/target/i386/ops_sse.h
+++ b/target/i386/ops_sse.h
@@ -2190,16 +2190,12 @@ void glue(helper_aesdeclast, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 
 void glue(helper_aesenc, SUFFIX)(CPUX86State *env, Reg *d, Reg *v, Reg *s)
 {
-    int i;
-    Reg st = *v;
-    Reg rk = *s;
+    for (int i = 0; i < SHIFT; i++) {
+        AESState *ad = (AESState *)&d->ZMM_X(i);
+        AESState *st = (AESState *)&v->ZMM_X(i);
+        AESState *rk = (AESState *)&s->ZMM_X(i);
 
-    for (i = 0 ; i < 2 << SHIFT ; i++) {
-        int j = i & 3;
-        d->L(i) = rk.L(i) ^ bswap32(AES_Te0[st.B(AES_shifts[4 * j + 0])] ^
-                                    AES_Te1[st.B(AES_shifts[4 * j + 1])] ^
-                                    AES_Te2[st.B(AES_shifts[4 * j + 2])] ^
-                                    AES_Te3[st.B(AES_shifts[4 * j + 3])]);
+        aesenc_SB_SR_MC_AK(ad, st, rk, false);
     }
 }
 
-- 
2.34.1


