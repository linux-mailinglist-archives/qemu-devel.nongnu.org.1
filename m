Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037472E1CA
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:37:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UV-0005Xi-7l; Tue, 13 Jun 2023 05:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UT-0005X7-Bf
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:05 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UR-0005aL-Fq
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:39:05 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-977ed383b8aso853475266b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649141; x=1689241141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ozRwFUKWRP9SpYUuH4++21vufDHRVG5o5zoM8NlA8A=;
 b=EqmIHAlOkhSVXOi34f3WHCE3KVNRFobnObL15ntex6WmrhLzofdoibUznIGGpU5JCN
 c4QN6CF8MclNTUYCWHeIPpWEeuGrWUWCRWBqsMCxucOhPLXXU3K7cIWg/O4wOtLRA0H3
 yIOFNPMi66wAwt1S0b/QMogRq/ISbTaWWmdESgq3o+JzBKs7REV/gcIAEGuVHeX3ekQo
 BUcYnaNt09ye6kMZVuYRcmDtFG/aGiYloOricp+hoa7K7j7z619/SFdDT6Up0TfZOrFD
 vMj2TuW1cJFUpa65KKSwR0/6t4EvRryajf5saQNG2RXbIQuifA6rwxqN8uI2X1OaLxTd
 mWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649141; x=1689241141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ozRwFUKWRP9SpYUuH4++21vufDHRVG5o5zoM8NlA8A=;
 b=gT3g+rW7VqTTqy+z9jAnHnTj8L0NvtdtDfjQ5uWyzQmZx0s38hl6x/gnuTRcCkim1B
 iWgOFUFixfQBbpveU0c348sbz1V0hATL80KDM36tYwO0Hyp6Im95o0PAir3C2FLgelF1
 +Rj70Wiyvh6FjpSnXTZjTz5QbDYtMVhrQCKl5gs39MS1MiBrkuDFATXwDAbc9M+kfPl6
 ge3NkOWeh97ucYhhaDAkpiiwJnQwtK+yPIcTpOQa+139WYdaeZ64Kzk8OSox+v/KAzhF
 5VT24AAZr5BrAbmZnWFYRMUCJn48nEIjbomft/d9BwTFu0M7hybAyaf7CIf0apLGbWVd
 XTQA==
X-Gm-Message-State: AC+VfDyOGbohGDLzJtSSVyZWMx29xwEKusun9tI6lL6XBGeoZIAcGhpA
 ZlOK3zSeeDO9+omKYV99PiDCzX0NsqTX3adUtLwFAQ==
X-Google-Smtp-Source: ACHHUZ4sb8R3Ya4+u09794yTtf9NVfaBWUJg+fupkzPj+Kxu6bvCy7rVEUkdcggSQSKI7wGsR3gfbA==
X-Received: by 2002:a17:907:94ca:b0:979:dad9:4e9 with SMTP id
 dn10-20020a17090794ca00b00979dad904e9mr11591549ejc.50.1686649141524; 
 Tue, 13 Jun 2023 02:39:01 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a17090627cd00b0096f6647b5e8sm6386417ejc.64.2023.06.13.02.39.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:39:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/17] target/i386/helper: Shuffle do_cpu_init()
Date: Tue, 13 Jun 2023 11:38:13 +0200
Message-Id: <20230613093822.63750-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

Move the #ifdef'ry inside do_cpu_init() instead of
declaring an empty stub for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230602224628.59546-3-philmd@linaro.org>
---
 target/i386/helper.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index 792c8eb45e..89aa696c6d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -580,9 +580,9 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
     return 1;
 }
 
-#if !defined(CONFIG_USER_ONLY)
 void do_cpu_init(X86CPU *cpu)
 {
+#if !defined(CONFIG_USER_ONLY)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
@@ -601,19 +601,15 @@ void do_cpu_init(X86CPU *cpu)
         kvm_arch_do_init_vcpu(cpu);
     }
     apic_init_reset(cpu->apic_state);
+#endif /* CONFIG_USER_ONLY */
 }
 
+#ifndef CONFIG_USER_ONLY
+
 void do_cpu_sipi(X86CPU *cpu)
 {
     apic_sipi(cpu->apic_state);
 }
-#else
-void do_cpu_init(X86CPU *cpu)
-{
-}
-#endif
-
-#ifndef CONFIG_USER_ONLY
 
 void cpu_load_efer(CPUX86State *env, uint64_t val)
 {
-- 
2.38.1


