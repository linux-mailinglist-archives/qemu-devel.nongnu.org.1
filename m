Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD1A5868F
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 18:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKsZ-0002vb-RX; Sun, 09 Mar 2025 13:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrn-0001yu-2m
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKrk-00058S-5M
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:55:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so36524365e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542902; x=1742147702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IABtyuGuVRM49DjEhoPGLaTRjqWLJwaeBvNPvFeGyOQ=;
 b=wKyMfiEtoqItWCVlGhrGiqjcU78Xg9cF6ZaAe1RxW2Qtf5zyQAi5hrQ9392HCaH4ka
 YRUtWUoaEpmMh9vUWtDVtF5o2IyA175FgPv0T2vcd10LDq6dVWgEbtpc36rY/qrujBEN
 u7XqaHf4E4enzrF4PlIIec8UT2bF/oN6da0Tixd+ul3fCVkD926oWI6tWB+qKXG9gV7E
 j6R/SvclmGynwUBgrW/wU/U4ao1vKWTrGzQKJ/WyGXNfedKvHh7DK5gj2pt9xNabVwfh
 H6x2qAcKV78zuDa0pUeWhXsmlaVC6iYbYDosSstwGHxATekJ+5CbwfpR3uvhkO3xbY1i
 8Amg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542902; x=1742147702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IABtyuGuVRM49DjEhoPGLaTRjqWLJwaeBvNPvFeGyOQ=;
 b=UfLGA6Mk5yEGMkLkwLBhY8iaefpuZtGHrnjVuYkYovyTm5Ws2Tta3poyi3fzHCgOA2
 9ZlSrcq85PlTfw6qM3OyDoqrxfoybeJjTzG++mJZv5zvFZCCc7g+v0zHLiOYfJmbtn+l
 Gc01VF67SrsyC3oMKZffQDbvBCIoS3HGOGVXK/BeoCkB/J45PRLljcpE0keZFUwVy5n6
 c/XBSQTSzpsaKvlgDXloAVFjpX8VPxcUHWmUG/cSv5jiw7PdaeG3aaG7gzfSmZaq1yuc
 YM68tmY2DDER2GPIsOhyNYrE35ABD2iRvFgRPI6NbeHLbjkFWjDTwQLGsdexL/K0rIUD
 1z+w==
X-Gm-Message-State: AOJu0Yy1ibNsOGl8RXJL5/98+xul/1b/XgrZTksUIuqAndXMerJjABu/
 6VoNFssZTiZvY+MmRMfrI+T1e0l+dyjHBsYDma6aJzoz2E29szGS5MQoDAojntCt3HYgvT9Rq9A
 gf/s=
X-Gm-Gg: ASbGncuDqLlEubje0II8/A1GzqrSYawSU5jaX/pxEdxPWHemQIqLUE+l84UX8vTz3Mo
 9CeUI5Jxie5qRtnG0cNV4MyEHiRohI2lnBLUO/iYjoA5TozgxGV/s/iJHl6YeIsCjk9IOyi5Kax
 ZgyT0dkKBg+kXUMELXmsTKYaSEH3tf/F+lvn8bh+VSt6R5qWBOBTD8nqR4FIfH9gU8jgS2U34pe
 a5m0SQyOJzqsrkxkKEGXcIjNwAm+vxIgyvbTSVgRPks/VCU7PJ0iYh1PbaMOH7VRALYaPHiSnAh
 KWDahlO4JuzGOf6lZqn+zXFoughzUWxQ+8KRUhFe3/irCLYLrMB4ovUn48i4rxlsgd+hrKiCFzl
 eZhgmyA+75N1HQWWs4TI=
X-Google-Smtp-Source: AGHT+IFR4jODhKyF4/JcWo9U0/EnXTBrEh2/sViYytPjBi2QggEIMwrC7W13ZrTXbJkPFYLdJ1SnhA==
X-Received: by 2002:a05:600c:1d1c:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-43cefed7916mr20919105e9.16.1741542901519; 
 Sun, 09 Mar 2025 10:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf3bf0e48sm22920265e9.20.2025.03.09.10.55.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:55:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/38] target/xtensa: Move has_work() from CPUClass to
 SysemuCPUOps
Date: Sun,  9 Mar 2025 18:52:05 +0100
Message-ID: <20250309175207.43828-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move has_work() from CPUClass to SysemuCPUOps, simplifying
xtensa_cpu_has_work() by directly using CPU env.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250125170125.32855-24-philmd@linaro.org>
---
 target/xtensa/cpu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index f9e298ace45..7663b62d01e 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -63,16 +63,14 @@ static void xtensa_restore_state_to_opc(CPUState *cs,
     cpu->env.pc = data[0];
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool xtensa_cpu_has_work(CPUState *cs)
 {
-#ifndef CONFIG_USER_ONLY
-    XtensaCPU *cpu = XTENSA_CPU(cs);
+    CPUXtensaState *env = cpu_env(cs);
 
-    return !cpu->env.runstall && cpu->env.pending_irq_level;
-#else
-    return true;
-#endif
+    return !env->runstall && env->pending_irq_level;
 }
+#endif /* !CONFIG_USER_ONLY */
 
 static int xtensa_cpu_mmu_index(CPUState *cs, bool ifetch)
 {
@@ -226,6 +224,7 @@ static const VMStateDescription vmstate_xtensa_cpu = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps xtensa_sysemu_ops = {
+    .has_work = xtensa_cpu_has_work,
     .get_phys_page_debug = xtensa_cpu_get_phys_page_debug,
 };
 #endif
@@ -263,7 +262,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->has_work = xtensa_cpu_has_work;
     cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
-- 
2.47.1


