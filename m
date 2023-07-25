Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FEC761C94
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVY-0004bw-L2; Tue, 25 Jul 2023 10:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVW-0004Ir-6A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJVU-0001Ft-Af
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fd0f000f1cso36772965e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297163; x=1690901963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wx51puJDtBC7dYR0MEeEvjQpQ/NCjXemSL1PA8RzYqg=;
 b=RSDdW74qn2bmpSFkU/VAVeYYbLHVqt6F7bmPrYXt5dZ2Y1rL84xmMGfeJajWjNuP6M
 740FrR/sxKsVGVVFvNhWUhEuzv2S6Kbq6al9x7IV0kj9EROIsVQEzwurWnBlALfUfPhw
 0554HdBabu9FwlLT45ufOZ5nU3oqaojm0/iG0YHzPYLwGfjngUOchy4vuu32LJqFUBRx
 OTQJKhaTBNOzIR8/KLF+X+wl4zpN5+DDq2SY+cUYccWNaW6k47MUPIo7oaum+DNfcRfa
 51O229/y2w16W0tGijOrkEQyNb7SxOBNf+xcoiAGunXPT0/1W5f9I2DbrCaLCERYWWX7
 WZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297163; x=1690901963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wx51puJDtBC7dYR0MEeEvjQpQ/NCjXemSL1PA8RzYqg=;
 b=VGRvCEGyr7tH32dcEBv7NxNRxSBaFmL1ATtv2iv9Dcu3ioKSESrYSSGXjkE+V+499Q
 VCPT2YZ9bOS4lznQZKJ5jkKlUiFs/WWtwNTOEbJd9wslM2h+0jJoZarq5XWHkV7i3zPV
 eGyIZPVyc9ZAvEIqHpuG05bBZ/LOPzbjrdaNC0WgG6ByeVr8d9HWFGAkTMwL2SHVslpL
 oF+FvTkQg96VeDiMjHD5S5O72nN2S6/7/6MBacotXuhDOVOyI+eiAHEprMlff6B8lQi+
 TuG2XfSnweZLbU8PiHnf8PsSJZYqmyPSwZb1NImVhpx2sM4KjvfdVTtZ6WjLFy30E5ex
 o4NA==
X-Gm-Message-State: ABy/qLaUPlFj/i0KOvCkDdk+BMvkW4rBykmFXQEmFsJBLLMtBjgpiKmt
 PXNbNh2s24RVGzQlf0fJoRU6nXi8AzSlNHFyhLA=
X-Google-Smtp-Source: APBJJlEL8UGPa9KyyEqduQdiIJyG6//w7RIg1feI16CGLvLXYEONGZnMKzrbm3jXZie6HNTlMn+j9A==
X-Received: by 2002:a1c:7914:0:b0:3f6:d90:3db with SMTP id
 l20-20020a1c7914000000b003f60d9003dbmr2286273wme.3.1690297162799; 
 Tue, 25 Jul 2023 07:59:22 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 x3-20020adfdd83000000b00314398e4dd4sm16683079wrl.54.2023.07.25.07.59.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/10] target/sparc: Handle FPRS correctly on big-endian hosts
Date: Tue, 25 Jul 2023 16:58:28 +0200
Message-Id: <20230725145829.37782-10-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

In CPUSparcState we define the fprs field as uint64_t.  However we
then refer to it in translate.c via a TCGv_i32 which we set up with
tcg_global_mem_new_ptr().  This means that on a big-endian host when
the guest does something to writo te the FPRS register this value
ends up in the wrong half of the uint64_t, and the QEMU C code that
refers to env->fprs sees the wrong value.  The effect of this is that
guest code that enables the FPU crashes with spurious FPU Disabled
exceptions.  In particular, this is why
 tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
times out on an s390 host.

There are multiple ways we could fix this; since there are actually
only three bits in the FPRS register and the code in translate.c
would be a bit painful to convert to dealing with a TCGv_i64, change
the type of the CPU state struct field to match what translate.c is
expecting.

(None of the other fields referenced by the r32[] array in
sparc_tcg_init() have the wrong type.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20230717103544.637453-1-peter.maydell@linaro.org>
---
 target/sparc/cpu.h     | 2 +-
 target/sparc/cpu.c     | 4 ++--
 target/sparc/machine.c | 3 ++-
 target/sparc/monitor.c | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 95d2d0da71..98044572f2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -521,7 +521,7 @@ struct CPUArchState {
     uint64_t igregs[8]; /* interrupt general registers */
     uint64_t mgregs[8]; /* mmu general registers */
     uint64_t glregs[8 * MAXTL_MAX];
-    uint64_t fprs;
+    uint32_t fprs;
     uint64_t tick_cmpr, stick_cmpr;
     CPUTimer *tick, *stick;
 #define TICK_NPT_MASK        0x8000000000000000ULL
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index e329a7aece..130ab8f578 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -673,8 +673,8 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
                  "cleanwin: %d cwp: %d\n",
                  env->cansave, env->canrestore, env->otherwin, env->wstate,
                  env->cleanwin, env->nwindows - 1 - env->cwp);
-    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: "
-                 TARGET_FMT_lx "\n", env->fsr, env->y, env->fprs);
+    qemu_fprintf(f, "fsr: " TARGET_FMT_lx " y: " TARGET_FMT_lx " fprs: %016x\n",
+                 env->fsr, env->y, env->fprs);
 
 #else
     qemu_fprintf(f, "psr: %08x (icc: ", cpu_get_psr(env));
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 44b9e7d75d..274e1217df 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -168,7 +168,8 @@ const VMStateDescription vmstate_sparc_cpu = {
         VMSTATE_UINT64_ARRAY(env.bgregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.igregs, SPARCCPU, 8),
         VMSTATE_UINT64_ARRAY(env.mgregs, SPARCCPU, 8),
-        VMSTATE_UINT64(env.fprs, SPARCCPU),
+        VMSTATE_UNUSED(4), /* was unused high half of uint64_t fprs */
+        VMSTATE_UINT32(env.fprs, SPARCCPU),
         VMSTATE_UINT64(env.tick_cmpr, SPARCCPU),
         VMSTATE_UINT64(env.stick_cmpr, SPARCCPU),
         VMSTATE_CPU_TIMER(env.tick, SPARCCPU),
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 318413686a..73f15aa272 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -154,7 +154,7 @@ const MonitorDef monitor_defs[] = {
     { "otherwin", offsetof(CPUSPARCState, otherwin) },
     { "wstate", offsetof(CPUSPARCState, wstate) },
     { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { "fprs", offsetof(CPUSPARCState, fprs) },
+    { "fprs", offsetof(CPUSPARCState, fprs), NULL, MD_I32 },
 #endif
     { NULL },
 };
-- 
2.38.1


