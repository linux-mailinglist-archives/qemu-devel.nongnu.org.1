Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E2720D65
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7q-0004AI-10; Fri, 02 Jun 2023 22:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6y-0000ss-8K
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:25 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6Y-0004wk-IH
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:23 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-75d461874f4so645485a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759697; x=1688351697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QGMX7Kmh8esce5VLR2nbZ8lMlpbn5/iajAqYWdVT+94=;
 b=VEgbogGyphWwR5fRNqSKXpk3Y7XLQ6U5LzHpBL1tIAM2pk/QCVdHy66gevHb0EtcA7
 Wp1kYJr6xOHPKSFhAYg8ZZnWUhCR4qqh2C/EZniyNQI9trGJ5Luxarr3+wxAODz7rO1t
 0YtWfWnPGOLoibk+wj9koxMOvxcdjUH12aOPboP9nYTu5I9fwNDCbXqCAVM7u/i2zBN7
 kKcj5yiF/G2WWpLo3KvWxEVp4AP2RDMkIRb6vdyu/P/PPhuZBJwv95JKsRv5g7jZKJjn
 HBcMMjWK2WWWDEk6l7Kcn4A4a4toAzPldH5sC+X+WNTu24kcfckSUTQkyMt9Avuq6uza
 izog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759697; x=1688351697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QGMX7Kmh8esce5VLR2nbZ8lMlpbn5/iajAqYWdVT+94=;
 b=VuQ8u73jMQmT0ZJDDhpryXnqqEfwP0Bz5lpQUiXoAXohp/TQcVnuhbndueVw9+dQK/
 Rwi/CLC5CsrEQWmBPdToCJXlNozxNHSwn4qss3MsqwbUcjb2JAPr1yzoI5ZL5JnTE3sO
 GhEJdb8Z5McMd5QP90bfbV6meIggBKz+whny9A/wFflfy+EIz6idPyuvAhwF0JPhriYo
 kwYXlue+J+Z7ISu+KACdFz70fYtP9dabQ7dz332dkTbJH03l220IpoCMdyOleuAjjIn/
 dNDf47QMga/4pwE95pa9S72UmN5s3kVJPYOygwwpdFIP6waOwon6Gwxbrstmoa5jKKvl
 6h3g==
X-Gm-Message-State: AC+VfDzZjo3HRfKrWQUQ9GbpxS3bDwIiJZPe67+UUnsdU2Hv/sZXabbY
 ndM/Lv+H2gedEoJ0p6FPjARFypnUyXSTkVxmHno=
X-Google-Smtp-Source: ACHHUZ5q5d9Twhi5lqybwORdng92xbp6OulV8u/ald9G05JjSlw0eQctLhbadIcilRMQiXIcO2PtZg==
X-Received: by 2002:a05:620a:3956:b0:75b:23a0:decf with SMTP id
 qs22-20020a05620a395600b0075b23a0decfmr17215772qkn.77.1685759696862; 
 Fri, 02 Jun 2023 19:34:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 32/35] crypto: Remove AES_shifts, AES_ishifts
Date: Fri,  2 Jun 2023 19:34:23 -0700
Message-Id: <20230603023426.1064431-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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

These arrays are no longer used, replaced by AES_SH_*, AES_ISH_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h |  4 ----
 crypto/aes.c         | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 24b073d569..aa8b54065d 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -30,10 +30,6 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
 
-/* AES ShiftRows and InvShiftRows */
-extern const uint8_t AES_shifts[16];
-extern const uint8_t AES_ishifts[16];
-
 /* AES MixColumns, for use with rot32. */
 extern const uint32_t AES_mc_rot[256];
 
diff --git a/crypto/aes.c b/crypto/aes.c
index c0e4bc5580..4438d4dcdc 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -131,13 +131,6 @@ enum {
     AES_SH_F = 0xb,
 };
 
-const uint8_t AES_shifts[16] = {
-    AES_SH_0, AES_SH_1, AES_SH_2, AES_SH_3,
-    AES_SH_4, AES_SH_5, AES_SH_6, AES_SH_7,
-    AES_SH_8, AES_SH_9, AES_SH_A, AES_SH_B,
-    AES_SH_C, AES_SH_D, AES_SH_E, AES_SH_F,
-};
-
 /* AES InvShiftRows, for complete unrolling. */
 enum {
     AES_ISH_0 = 0x0,
@@ -158,13 +151,6 @@ enum {
     AES_ISH_F = 0x3,
 };
 
-const uint8_t AES_ishifts[16] = {
-    AES_ISH_0, AES_ISH_1, AES_ISH_2, AES_ISH_3,
-    AES_ISH_4, AES_ISH_5, AES_ISH_6, AES_ISH_7,
-    AES_ISH_8, AES_ISH_9, AES_ISH_A, AES_ISH_B,
-    AES_ISH_C, AES_ISH_D, AES_ISH_E, AES_ISH_F,
-};
-
 /*
  * MixColumns lookup table, for use with rot32.
  * From Arm ARM pseudocode.
-- 
2.34.1


