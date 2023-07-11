Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30ED574F634
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 18:55:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGdN-0006xa-Ht; Tue, 11 Jul 2023 12:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGdM-0006xS-GP
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:54:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJGdK-0007dJ-SZ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 12:54:40 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso64852145e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 09:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689094477; x=1691686477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q0ot/AU4aAn/KFaGSe7U0g3v4djRMr4o+ZJ8G5uOSDg=;
 b=KAD5ehvCQknQ6+3Fm9/SR400+Ky3/S/ndnEykcfgVx7YaZ4IHifeb8fqxp0399Bagn
 qPMiwxw6VHrNGQQ9XANURfgV62ZFF7chkDkN+cYy1Ok4pcWHEZySRR5/O6FlQF/eJffR
 Kqcx52m2X4ROYdlEOkMz2FyIViwhRM51/mMQhCICU8PGQIJugc8C3ou+3SQ7k+27p/ki
 rM2SITN/Tw4HSksDtTdv3fw6HK6TWC7iEMyvec0rukhnUZbpZDXpinO2UlmGYNSQ3+hf
 0VtiMbgyYVKitcWoJNmg9WcppYM5JM7anca4+EcqhFnsPEtop0lea2zXDysUuq8KbiwF
 mS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094477; x=1691686477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q0ot/AU4aAn/KFaGSe7U0g3v4djRMr4o+ZJ8G5uOSDg=;
 b=bB+XzaUnOU0e+yfp9WMMo7zshi1E0eH03xpDFK8Ks6/DIh+1tXKUzrnlhann+YpPU7
 xyTAdeG01Ow6Dj8bAux+3Za7tSSgwX/3eiZVLfjny6DExRyK4dC4rcuJ6ZCRQ84BB0r6
 TEw2x8ylYcm/2J7Wmzy6BkReOXXAW5ATKEBjCjFZ/CNWSG8amYGRGzorJ5cXIrpSuYcx
 WXHaVBGYlJms8hXXWsw4oQ86pfUrbewPFKIeTePL7AhoDhvJ3CrdsAiEA30ZTHoQth0R
 1top2fC8ez3GT99jM/1OKuzdGUqv7axzs/f1uDpE25UwsHT4uT6mSu8zxeUbv/URN0mh
 PALA==
X-Gm-Message-State: ABy/qLa686sCycv9sl6bwWHF78nLS2DzFzKP5eS4xe2uAVo7JPM0JQpc
 3w20C3AxnEQzrA/dFVVVV9OFZp5A6G+9eahPofA=
X-Google-Smtp-Source: APBJJlGLYT3tGI/dnBl3JK37NgaKH+NVZKc8JgzGUdpq3BdJsY2oG1icVW/yPtbnomBvrXL4G552kQ==
X-Received: by 2002:a7b:cc84:0:b0:3fc:a5:2c3a with SMTP id
 p4-20020a7bcc84000000b003fc00a52c3amr11779820wma.41.1689094476880; 
 Tue, 11 Jul 2023 09:54:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a1cf30e000000b003fbb25da65bsm3005822wmq.30.2023.07.11.09.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 09:54:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH for-8.1] accel/tcg: Zero-pad PC in TCG CPU exec trace lines
Date: Tue, 11 Jul 2023 17:54:34 +0100
Message-Id: <20230711165434.4123674-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In commit f0a08b0913befbd we changed the type of the PC from
target_ulong to vaddr.  In doing so we inadvertently dropped the
zero-padding on the PC in trace lines (the second item inside the []
in these lines).  They used to look like this on AArch64, for
instance:

Trace 0: 0x7f2260000100 [00000000/0000000040000000/00000061/ff200000]

and now they look like this:
Trace 0: 0x7f4f50000100 [00000000/40000000/00000061/ff200000]

and if the PC happens to be somewhere low like 0x5000
then the field is shown as /5000/.

This is because TARGET_FMT_lx is a "%08x" or "%016x" specifier,
depending on TARGET_LONG_SIZE, whereas VADDR_PRIx is just PRIx64
with no width specifier.

Restore the zero-padding by adding an 016 width specifier to
this tracing and a couple of others that were similarly recently
changed to use VADDR_PRIx without a width specifier.

We can't unfortunately restore the "32-bit guests are padded to
8 hex digits and 64-bit guests to 16 hex digits" behaviour so
easily.

Fixes: f0a08b0913befbd ("accel/tcg/cpu-exec.c: Widen pc to vaddr")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I have a workflow that parses log files to get the executed
PC values; I don't suppose I'm the only one doing that...
---
 accel/tcg/cpu-exec.c      | 4 ++--
 accel/tcg/translate-all.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ba1890a373d..db1e82811fa 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -298,7 +298,7 @@ static void log_cpu_exec(vaddr pc, CPUState *cpu,
     if (qemu_log_in_addr_range(pc)) {
         qemu_log_mask(CPU_LOG_EXEC,
                       "Trace %d: %p [%08" PRIx64
-                      "/%" VADDR_PRIx "/%08x/%08x] %s\n",
+                      "/%016" VADDR_PRIx "/%08x/%08x] %s\n",
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
 
@@ -487,7 +487,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
         if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
             vaddr pc = log_pc(cpu, last_tb);
             if (qemu_log_in_addr_range(pc)) {
-                qemu_log("Stopped execution of TB chain before %p [%"
+                qemu_log("Stopped execution of TB chain before %p [%016"
                          VADDR_PRIx "] %s\n",
                          last_tb->tc.ptr, pc, lookup_symbol(pc));
             }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d3d4fbc1a41..bb225afa04f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -604,7 +604,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     if (qemu_loglevel_mask(CPU_LOG_EXEC)) {
         vaddr pc = log_pc(cpu, tb);
         if (qemu_log_in_addr_range(pc)) {
-            qemu_log("cpu_io_recompile: rewound execution of TB to %"
+            qemu_log("cpu_io_recompile: rewound execution of TB to %016"
                      VADDR_PRIx "\n", pc);
         }
     }
-- 
2.34.1


