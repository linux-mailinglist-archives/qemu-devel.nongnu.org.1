Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B05E72E1CB
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UQ-0005Ud-J2; Tue, 13 Jun 2023 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UO-0005Tq-Um
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:00 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UN-0005Zh-3e
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51879362bbfso503033a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649136; x=1689241136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myeX5Dw6+waNCZWCgIspsiK+vpR5MfiXN6PuO0NeKtA=;
 b=aayT79RNVZJvyM4TSEwqccDtz37EF6lAxwjzp1q2y3xw1LoNPZcm/ZjxNYiqz83rlR
 v0sKG07t4QVa1JQEbIdQtNNWUVPloFdxfjjNa9NlrvSqhgh0xWFGOy0ejiQvx0LjkZ9z
 XagIMvddP1J6VeYnhNq4j0PTyJE7Nn9UFFyy1c2cqpRRrWRotb6FwMg3wN+XSbN/2C0J
 0y8R7FyQWACGJPfDDX0UlEYXU70HbWaUYyTtXmeitCHHJkm/1qzn/PUU/QCH70Sv7oZm
 V0pisw+drAkf5nGnzypyY3fxhkWsMPEZgojIt4AkYvyewVpga1SHwj+e99Rzwuz37l43
 +r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649136; x=1689241136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myeX5Dw6+waNCZWCgIspsiK+vpR5MfiXN6PuO0NeKtA=;
 b=HPEH7dq4DaHyDVNACJaPBDd7QSXw2MBBK9I1/4Jzcroil4oCLySlU/NJEhetnY4meh
 AOMb4fKdh2BXIHt2L2TJcfsBne3E3JmUiksgwWKxEE8glIVJ+8oiuA7cOsazCIRpqYTg
 J6ec6QIAgGhDzL7f9z6yBmRVz1DYn8GUtf5UpssgCW4cHKxYcMYVR0vIoDeOQ2xqaDd/
 1SiFDqepBxY7gBOnOkbyCPQ0UsmZZh0p4WNyUfy2qaCBnYlTi4IOW87T6usp+TTXF0nU
 oe6xQoB2xhrAxFYm4pOyLHVdnvV+7lbWu0GF4VSSkiJvpTcbwIj/ZXRYEgjbOfXiqA5E
 IWzw==
X-Gm-Message-State: AC+VfDwUkU5WASqse/il/SpBLmYCgmmDZFDu4caRSaZKdOONfBLL4m0w
 p2iSkYNCDuu9nqazPlH1Dv95WQ3HL458+qdVN4DY+w==
X-Google-Smtp-Source: ACHHUZ5wFMPB2YC+sIYRs276IG3XjUKzH9apySZk4abbO2zCKYg+e/1RkF8jO61QIgvgNTL0UjcVVw==
X-Received: by 2002:a17:907:5cc:b0:96a:9467:1dc7 with SMTP id
 wg12-20020a17090705cc00b0096a94671dc7mr10626009ejb.25.1686649135979; 
 Tue, 13 Jun 2023 02:38:55 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a1709067ad600b00973ca837a68sm6381930ejo.217.2023.06.13.02.38.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/17] target/i386/helper: Remove do_cpu_sipi() stub for
 user-mode emulation
Date: Tue, 13 Jun 2023 11:38:12 +0200
Message-Id: <20230613093822.63750-8-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Since commit  604664726f ("target/i386: Restrict cpu_exec_interrupt()
handler to sysemu"), do_cpu_sipi() isn't called anymore on user
emulation. Remove the now pointless stub.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602224628.59546-2-philmd@linaro.org>
---
 target/i386/cpu.h    | 3 ++-
 target/i386/helper.c | 3 ---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 7201a71de8..cd047e0410 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2285,7 +2285,6 @@ static inline void cpu_get_tb_cpu_state(CPUX86State *env, target_ulong *pc,
 }
 
 void do_cpu_init(X86CPU *cpu);
-void do_cpu_sipi(X86CPU *cpu);
 
 #define MCE_INJECT_BROADCAST    1
 #define MCE_INJECT_UNCOND_AO    2
@@ -2419,6 +2418,8 @@ void x86_cpu_set_default_version(X86CPUVersion version);
 
 #ifndef CONFIG_USER_ONLY
 
+void do_cpu_sipi(X86CPU *cpu);
+
 #define APIC_DEFAULT_ADDRESS 0xfee00000
 #define APIC_SPACE_SIZE      0x100000
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 36bf2107e7..792c8eb45e 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -611,9 +611,6 @@ void do_cpu_sipi(X86CPU *cpu)
 void do_cpu_init(X86CPU *cpu)
 {
 }
-void do_cpu_sipi(X86CPU *cpu)
-{
-}
 #endif
 
 #ifndef CONFIG_USER_ONLY
-- 
2.38.1


