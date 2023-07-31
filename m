Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CFE76A25A
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa29-0000uQ-GE; Mon, 31 Jul 2023 17:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa27-0000tV-Dn
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:27 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa23-0006Pz-EN
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:26 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686efdeabaeso3263740b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837341; x=1691442141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xc1zrCJDVG+lPGuHxCdmlX/jD7CzCST/l+CtotajKSU=;
 b=uco0uNy5Sro7JsUIGt3LE4fx6Xu3QVpUOrYN9Lp3XDd7t+PRuwfkNTWorP/2hQMNYd
 ZV5Ehq1Wr3bhUIEw0zMANihsr3uFf9xhyEYU3BOKhMUngRtwHV4uXnr3i6AIrPgb66Ay
 SBIDDL4ObX7dBliUcTqzGvauwNkHXuOsuWwmW2OSSdVwnYmDGGMPXDJAcKlsVsp4DBtl
 2dtMorR7oi1/hhlwsIOOJGGoB+9NJLA/OkYwRc4zp71HmBaWsQFYOv4ALkwxoDpJeqU0
 FiA8nrps5rmCXCBchCU1wQ4V3s+gjX8wpPAxnqjJP2jCvwwdQis5cenR/lqgvuYUmkKA
 PugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837341; x=1691442141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xc1zrCJDVG+lPGuHxCdmlX/jD7CzCST/l+CtotajKSU=;
 b=XS10taf9A58NrVHN51h/6KSQaSOgqaNQbZp3avhVZGKkwHpCw/Kr3ciQPSAoEYfZ3T
 Q9rgTI+GrfPyqc7OkWPvI4b59YBPmA7jKLoBBi1uelL6YdCdi0nrEcnFflTXzy7W5Bip
 3WVegZrPKa/JKY3NMGvSNqBgD93ieNg3LVRlEs58t5xWNCok0cnuOzXfphmqD3IKD4qt
 ksDFVBRl8HvbkKFH0Pwfe3w1XPz4lRVZeNaklbG75y8eQGKSU3eA2g4zof4aW5d/d9mW
 v+ho7DcMwkxjySo5SHBrqDbrgrzpse8iXJPmg1Muh1CyWw1ilX6VWMsd4qlrtmyh/q+R
 y5Zw==
X-Gm-Message-State: ABy/qLZ2SjaJ6hcaas7ZU0AbL0KGkcBsKYO5TJj7UQuMS79qfsyaSkNC
 fpP50QDW9UB3sAdTw+Ni+Jk7x/IqzVb/IwY9v50=
X-Google-Smtp-Source: APBJJlE39Vh2KZ1xZkJoON/8DK0ffs7JUZjXGR1rH+is/nAV0Vp8KkSHFml2JEsWl8mOcuIX0FyPqw==
X-Received: by 2002:a17:902:9b89:b0:1b8:b47e:a881 with SMTP id
 y9-20020a1709029b8900b001b8b47ea881mr8368929plp.49.1690837341035; 
 Mon, 31 Jul 2023 14:02:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, qemu-stable@nongnu.org,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>,
 John Reiser <jreiser@BitWagon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Date: Mon, 31 Jul 2023 14:02:10 -0700
Message-Id: <20230731210211.137353-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

From: Helge Deller <deller@gmx.de>

Commit 7f4f0d9ea870 ("linux-user/arm: Implement __kernel_cmpxchg with host
atomics") switched to use qatomic_cmpxchg() to swap a word with the memory
content, but missed to endianess-swap the oldval and newval values when
emulating an armeb CPU, which expects words to be stored in big endian in
the guest memory.

The bug can be verified with qemu >= v7.0 on any little-endian host, when
starting the armeb binary of the upx program, which just hangs without
this patch.

Cc: qemu-stable@nongnu.org
Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Reported-by: John Reiser <jreiser@BitWagon.com>
Closes: https://github.com/upx/upx/issues/687
Message-Id: <ZMQVnqY+F+5sTNFd@p100>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index a992423257..b404117ff3 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -117,8 +117,9 @@ static void arm_kernel_cmpxchg32_helper(CPUARMState *env)
 {
     uint32_t oldval, newval, val, addr, cpsr, *host_addr;
 
-    oldval = env->regs[0];
-    newval = env->regs[1];
+    /* Swap if host != guest endianness, for the host cmpxchg below */
+    oldval = tswap32(env->regs[0]);
+    newval = tswap32(env->regs[1]);
     addr = env->regs[2];
 
     mmap_lock();
@@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
         return;
     }
 
+    /* Swap if host != guest endianness, for the host cmpxchg below */
+    oldval = tswap64(oldval);
+    newval = tswap64(newval);
+
 #ifdef CONFIG_ATOMIC64
     val = qatomic_cmpxchg__nocheck(host_addr, oldval, newval);
     cpsr = (val == oldval) * CPSR_C;
-- 
2.34.1


