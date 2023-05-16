Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC97057BE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yq-0006kR-6H; Tue, 16 May 2023 15:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yo-0006jn-T2
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:14 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yn-0002sa-G1
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:14 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so8218438b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266132; x=1686858132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QMQeFWwqcUFumXr1WKfxiG/Sk++Gp7SwpIzlewGlEA=;
 b=OXKcHHf+ipX6PzfByHE3D/+Kx9npd4tYhTXklF066RPQp4CWW1hTGQWTU9uv6GlItL
 pr/UAYa5fO60wHJ0QZlYTWPyd23E9E6s4DKk/fn9d8H371DBOtN064zWvBwL12lB/5a4
 1v5lKxHSin7cejEyHlb4cWHuTkau/Y9ppRayDSLaWjKMMQCixlRlXI2sUQEZJwH98g9U
 iBjEHC5VgxKXfwGF8s+el8JAnEgkmyDcWMFe/euiSBS0pFH+l8iBcfWwcIogc2T8JNTM
 MZMONxMRtCcS84C3qTe+hLna98Tz6Ry2ieq78kFW/AoAyw9sj1KF2P6vLk9F+YkqZ+K5
 mpiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266132; x=1686858132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QMQeFWwqcUFumXr1WKfxiG/Sk++Gp7SwpIzlewGlEA=;
 b=S76SdYtJgHBB4PPQ5fY6MBBneFnVUl4kNepf1Cc+VcEWYzG/1vqD0f2Cvz6chCpHmd
 sSnzm0nFca/0B9PfjupDcnUBbTqqAnZvTu6OPukFzAE+f68Ro1Dt5nLEBgkajYEOlXW1
 mzwe22R1lC62O3cz7Sjy8exXLPx78BGcxKlfAECpThQIJUcRrGJuV+4QLF7APJzYtwpu
 FtYwUNPmWKVyzC+Cs0Eyaqtu1apfBHaIXlr/baHCEI+DCpGACOspYCT6W38j8x8ir+VW
 jIhScitrAoLvD/+ptIBXdoh7k034sQjtw+t5d2Y8/nTHWPJLL3tjqV0ntYHKHAy0Iezs
 ZAtQ==
X-Gm-Message-State: AC+VfDw4Km+tqsj3g2N3KxcwHgnyP6Prt0mU7Uj5qvcKlz6SqV95iiw1
 5DnJdvFWmIwMhs/4pDO0xpyHHQHw+fHwpXh/vWs=
X-Google-Smtp-Source: ACHHUZ6ikFrxawroLwxkvv9Mj0tyEKIGtjTvJjSonogIYknc2nB+8fPyv09SdXOPHuWbMtAnaq8wjg==
X-Received: by 2002:a05:6a00:15c6:b0:635:d9e1:8e1e with SMTP id
 o6-20020a056a0015c600b00635d9e18e1emr54936991pfu.11.1684266132290; 
 Tue, 16 May 2023 12:42:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 28/80] accel/tcg: Remove helper_unaligned_{ld,st}
Date: Tue, 16 May 2023 12:40:53 -0700
Message-Id: <20230516194145.1749305-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

These functions are now unused.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-ldst.h |  6 ------
 accel/tcg/user-exec.c  | 10 ----------
 2 files changed, 16 deletions(-)

diff --git a/include/tcg/tcg-ldst.h b/include/tcg/tcg-ldst.h
index 64f48e6990..7dd57013e9 100644
--- a/include/tcg/tcg-ldst.h
+++ b/include/tcg/tcg-ldst.h
@@ -60,10 +60,4 @@ void helper_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 void helper_st16_mmu(CPUArchState *env, target_ulong addr, Int128 val,
                      MemOpIdx oi, uintptr_t retaddr);
 
-#ifdef CONFIG_USER_ONLY
-
-G_NORETURN void helper_unaligned_ld(CPUArchState *env, target_ulong addr);
-G_NORETURN void helper_unaligned_st(CPUArchState *env, target_ulong addr);
-
-#endif /* CONFIG_USER_ONLY */
 #endif /* TCG_LDST_H */
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 8f86254eb4..7b824dcde8 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -889,16 +889,6 @@ void page_reset_target_data(target_ulong start, target_ulong last) { }
 
 /* The softmmu versions of these helpers are in cputlb.c.  */
 
-void helper_unaligned_ld(CPUArchState *env, target_ulong addr)
-{
-    cpu_loop_exit_sigbus(env_cpu(env), addr, MMU_DATA_LOAD, GETPC());
-}
-
-void helper_unaligned_st(CPUArchState *env, target_ulong addr)
-{
-    cpu_loop_exit_sigbus(env_cpu(env), addr, MMU_DATA_STORE, GETPC());
-}
-
 static void *cpu_mmu_lookup(CPUArchState *env, abi_ptr addr,
                             MemOp mop, uintptr_t ra, MMUAccessType type)
 {
-- 
2.34.1


