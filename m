Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB98832902
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:41:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnAW-0002it-Hn; Fri, 19 Jan 2024 06:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAS-0002bj-LV
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQnAO-0001gd-KH
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:36:12 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso5963765e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664167; x=1706268967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEVuIq2fAugiO07WlgkO+R3+5CVkxIv0WR9Gtc3uhxc=;
 b=crG/ilcE51nUFWJXGdgDdvo4UpscOiNrOgxcA1fkKxfx5saDy0xuCs6O7pAdkk3A+e
 bBVB0gIYGAfj2FmH9kO7LxMRaa9Hk/9wdthUAs4pDdIdmZY3jM8GJD3fcvmagDlBt1aK
 V5X4Pw8BPKg91p6x4qMybO2hmG+hr1YIyL9zkSZxAq3olLE+0M5HhuxAj/dSWengmCqZ
 R4p1A+SJDojWwhq+akJizpqmpB5bO+KLZOPq5PPoByapklbGQ4RvUXupX5lDjoPs2cvI
 jDElsE0jOKOJ4a1bug1yBTcT+zZVxF4uRso3M87n4bqa/R6j5buv0n9/pIGmqpuGsjQG
 HMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664167; x=1706268967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEVuIq2fAugiO07WlgkO+R3+5CVkxIv0WR9Gtc3uhxc=;
 b=DT7IA2RsKzRX1a/Z8bMxomtFKx0f7Eq4hmako+5NH+l1rxuZ2B15H54wm4f+zKjDoi
 yTx2mNOPDwnxbDhC4F4NVS2npGH7aGYj8ld2AP2jx7V74W3TZCB8Qb3E6hb7h9zoLK0m
 9wpFpB/isDsLBGeKGVMWQVNWneaqlQy12gvU+lM2kUo+VB/MvWdm3nanoqjpR1oFJpE5
 m5QIOCrw7MvNJPluAVaMwymgGbGCKqaTlYJSMzzrtZQMoWiQGMfKP/khP9xfjBt5PGIc
 j1z8+68TBchFoR7eG4dPDV21hgA+4xs6X04+EXU0kNSyMfaHo4mMk3dIyL7Die0mHhPn
 UxRw==
X-Gm-Message-State: AOJu0YyPcFYrvkpK+CUbCZYCPed7m65rsNp+f/4B3bltKS3pQdVqARHe
 xBs7qUXGe1aCcLCfSrcZhcXL+5J3JqVKTzbc5HQc4mPSiqR7rPoTgHn+DVQOfhvlmf66UtFc2wW
 L5WSwBg==
X-Google-Smtp-Source: AGHT+IGk73VyAAH8vhB2p4faFlo56F0IQbH6saPb7JJA9vFjsDJ5QPpP0L1VYrNP2VjEFBtPF5VVnA==
X-Received: by 2002:a5d:49cc:0:b0:339:2248:3e30 with SMTP id
 t12-20020a5d49cc000000b0033922483e30mr342492wrs.138.1705664167141; 
 Fri, 19 Jan 2024 03:36:07 -0800 (PST)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 p1-20020adfe601000000b00337bf461385sm6296931wrm.26.2024.01.19.03.36.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jan 2024 03:36:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/36] target/arm: Ensure icount is enabled when emulating
 INST_RETIRED
Date: Fri, 19 Jan 2024 12:34:42 +0100
Message-ID: <20240119113507.31951-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240119113507.31951-1-philmd@linaro.org>
References: <20240119113507.31951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

pmu_init() register its event checking the pm_event::supported()
handler. For INST_RETIRED, the event is only registered and the
bit enabled in the PMU Common Event Identification register when
icount is enabled as ICOUNT_PRECISE.

PMU events are TCG-only, hardware accelerators handle them
directly. Unfortunately we register the events in non-TCG builds,
leading to linking error such:

  ld: Undefined symbols:
    _icount_to_ns, referenced from:
      _instructions_ns_per in target_arm_helper.c.o
  clang: error: linker command failed with exit code 1 (use -v to see invocation)

As a kludge, give a hint to the compiler by asserting the
pm_event::get_count() and pm_event::ns_per_count() handler will
only be called under this icount mode.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231208113529.74067-5-philmd@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 49665bb763..e068d35383 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -954,11 +954,13 @@ static bool instructions_supported(CPUARMState *env)
 
 static uint64_t instructions_get_count(CPUARMState *env)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return (uint64_t)icount_get_raw();
 }
 
 static int64_t instructions_ns_per(uint64_t icount)
 {
+    assert(icount_enabled() == ICOUNT_PRECISE);
     return icount_to_ns((int64_t)icount);
 }
 #endif
-- 
2.41.0


