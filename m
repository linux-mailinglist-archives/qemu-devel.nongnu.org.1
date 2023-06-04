Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D734E721615
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 12:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5kzD-00016F-6Q; Sun, 04 Jun 2023 06:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kz9-00013y-QZ; Sun, 04 Jun 2023 06:29:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kz7-0005pG-AP; Sun, 04 Jun 2023 06:29:19 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-651ffcc1d3dso1957941b3a.3; 
 Sun, 04 Jun 2023 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685874554; x=1688466554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1201Fg2bb2LqSzd+MCvO7/S5DodFeX+KF00mHODbWQ0=;
 b=JqDmAc02HWaODPegK5xEYcHNquqraRyOxiI/bWn0mvbJTaY+V8+OIsbRwKC2jlY93Z
 cXBJ8tR7YhI0scO77+qDHhz3V9uFmhS7wyEu9+BwPmdwRU0/fh/DTdx3wpIF7lTOWewg
 9+EM3JVDjc3OEro3xodfm3duRJNgMZUhmQisKAu0aKyCaqoGXw8J7+mzybwmxR1wvIdY
 wBAa7pNFoolKqXIpIv86paDT2qoG12DBq2SyFBtiNm1MfnNFCpdj5JYddHVAz75PWKuP
 LEqGvxHc5xeVZJ2kKieTuji7NkaWVii5yx03yv/vlujxNfxavK77XAk+0pgStXNnaJzQ
 L1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685874554; x=1688466554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1201Fg2bb2LqSzd+MCvO7/S5DodFeX+KF00mHODbWQ0=;
 b=W2fT6ADzHbrCHPYW/OjqA3L97esAyVBXfArD5Yzyb9IxDswzF7Brsnx2vLDzguHTzt
 aoCplSwspPxhaviXYy8Vo0n5aQ+NliIwRvk/mb1wxGw35GzbohF93NDlneaOz1V3CxT5
 H2bq5Ezssv80wVqVPOVHHn5uu2TQrSpoU4xuu3zu2cW6kmF38eYB3MxFG1fyD+Ur5mx6
 UtJRb9rsvvLDk1C0AJrLcHgkwogWlRC6nzYhe0/HPxvb1VX6IF6KZA4zmNcL2eKVbqDs
 w78MLJXsCTo8D+9cj7nJaHY/MEKOX5ZfvCRXmjqLncsPl8zzVlsO4GuvI5o/CllT1Xdn
 VHwg==
X-Gm-Message-State: AC+VfDwos0F3687HEtbBuddLVBarPjpCR98vMRkhC8ca5JosyU0/Fv1Z
 91ff6z2kp4fRpsK1Dx6dPM4=
X-Google-Smtp-Source: ACHHUZ7ZsTFfhCRQhfZRt3KPQ7bfCTYuqrA3Ac0TPJN1YmpM2ScW3pHqI4/K0QSjMogwbREhNCbtUQ==
X-Received: by 2002:a17:903:11d0:b0:1ac:988e:2624 with SMTP id
 q16-20020a17090311d000b001ac988e2624mr3219396plh.37.1685874553823; 
 Sun, 04 Jun 2023 03:29:13 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 ik8-20020a170902ab0800b001ae0152d280sm4489241plb.193.2023.06.04.03.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 03:29:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 3/4] target/ppc: Remove larx/stcx. memory barrier semantics
Date: Sun,  4 Jun 2023 20:28:56 +1000
Message-Id: <20230604102858.148584-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230604102858.148584-1-npiggin@gmail.com>
References: <20230604102858.148584-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

larx and stcx. are not defined to order any memory operations.
Remove the barriers.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5195047146..77e1c5abb6 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3591,7 +3591,6 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     tcg_gen_movi_tl(cpu_reserve_size, memop_size(memop));
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
 
 #define LARX(name, memop)                  \
@@ -3835,11 +3834,6 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 
     gen_set_label(l1);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(l2);
@@ -3943,11 +3937,6 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_br(lab_over);
     gen_set_label(lab_fail);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(lab_over);
-- 
2.40.1


