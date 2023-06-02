Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF7B720C09
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:47:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DXk-0006GO-9J; Fri, 02 Jun 2023 18:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DXi-0006Bw-3L
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:46:46 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DXg-00068c-Jc
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:46:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f60e730bf2so26582895e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685746002; x=1688338002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gNfQtcCbE29jWLrUa/owBOh0KyyzbAKaOwkeSeQTqs=;
 b=x0c74BJVTWVGjiJ4F2FO7a6C29q9ftHFn6mbmYeE6KLovs8feonrnlIjDb55ZKNwfK
 DnGI/FsuE57JcD1/xT6oBXc2MZTOdkU1NrVZdmEJD0TkzQYjja1X/5CBOx5f/GyAabKV
 5n/ngXu/WE5qNN42eyyh96vgDD13FE05jria7SGs79VJjWjB+QaYz2aTRmiZe32BofZ+
 d/CG1n2v6ODhWWyM/NPM5MQaYhndpSfyx0KZXRm9WcH680StOnN3GlomHr+MxxLjQeaC
 VwLIwTbPGQikaf1O/D0Kcin8QHZ044aERO5/eh5ShjB2IynTCTacS3tEay4H1K8KLqLR
 ffPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685746002; x=1688338002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gNfQtcCbE29jWLrUa/owBOh0KyyzbAKaOwkeSeQTqs=;
 b=ZB/05rQSSa7DQIEeypeZhKatgRCZFnmbx4JqqVYdsL6ZDA7NNIVtfuTJ2sGoUulzBD
 sVGYgF/PfuhHmRQYkq4Q9UjnsPupIYn+UoHBCO62x+5f88Wgut+EcdKOHUOov5/u62Ov
 0skLp5y7bP9yCXvCNj0n5tka2NflGSbHD7oR09RhXzYWSLq9LRWr6xog2VBKRGkmBVYG
 0MZa8VzKOSp8+cUrCXDBRikvJMOVZLVJIjkkmZgB78pgLxsGJtLGm1K/bF//J/gsEqz3
 SzuAu2TcClvGWj9qJ31GEKRab3Ev6rrVC7jI43+KCsqHGZIUzJgCuow1A/nMTIUubrsU
 oTpQ==
X-Gm-Message-State: AC+VfDwbEd8KPDnWsnv/mNglk+PjPAX/y8Hv4bycGke76otJy2UKQZ/b
 ErUe3S9xBrQGydsBwD7P6Y7ONR9kZtLySYS2qQc=
X-Google-Smtp-Source: ACHHUZ6//j0EiiktQ0dFM6VhdZTDLzcFtMzfEvENtiC67pi0uApxcX1hCp82h1bLyrE6O5EYtcTSKA==
X-Received: by 2002:adf:ec87:0:b0:30a:e9bd:b4cf with SMTP id
 z7-20020adfec87000000b0030ae9bdb4cfmr916199wrn.52.1685746001875; 
 Fri, 02 Jun 2023 15:46:41 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a05600010c900b0030ae87bd3e3sm2791277wrx.18.2023.06.02.15.46.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:46:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] target/i386/helper: Shuffle do_cpu_init()
Date: Sat,  3 Jun 2023 00:46:28 +0200
Message-Id: <20230602224628.59546-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230602224628.59546-1-philmd@linaro.org>
References: <20230602224628.59546-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Move the #ifdef'ry inside do_cpu_init() instead of
declaring an empty stub for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


