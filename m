Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFB97B2603
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwtk-0007yX-KG; Thu, 28 Sep 2023 15:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwti-0007wW-Nb
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:06 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwth-0007yW-4p
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:06 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c735473d1aso11371255ad.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930123; x=1696534923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pino+Pzpra8kDOPi8wLUPqIV+r06yGcltlj2T5gxEf8=;
 b=wdM2an+vUAPytuALdj2EXtNsEv4Um8Q4jpLk16ZgHxyMUd2wCoZtVPAOmUs+pnBDBK
 Klcb2Dkh6vO7ungXAzU1Xo6lDnmQBWgREFMR3p37p6TR7bYT6GNQpqyq01VCCfWz70uj
 N+yksgmX40emRnVDisNSpKpErAKRJmAdb5MBFFBo7Giv7x2szweSzkHd6TbwF8mo1UTj
 JdPpzHPiWXkDkKkxOdtVYMKVeia8123/M5Jc17sVudIaYsSWjrcas4OVP/rrpKvAJB4k
 YuUsaMkiMmAdIhQ4sS++tgCPATLAABj7Ht2yBugQaM2FAZbNQEGXMb5LYWohARywyQzu
 fhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930123; x=1696534923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pino+Pzpra8kDOPi8wLUPqIV+r06yGcltlj2T5gxEf8=;
 b=t6nK0a9ZKGSi+rDQKm83H5O8NxbZzMTQ8vmT02iEDEeEN6H/8dVnp2jdNMHQ9HR6xi
 FFIMHB9fPVENdrj48uVkAgAfHag4N6Cody6Hxm3o0XkARK6GK+1eW7ylwSkaI9yNaCpH
 +dzZRUsFbRxKf2EhIC08qtCiWu7tc8h6Onb+s17n+YM22YqcCMSOyLDtAQdNECjS4tPy
 Sq3xHtu2j8P+ZxMmWJDdwpZcP6O943LXS/kg+g0N1nRX3l2CxPNoD6Dzrl74XA29Tv+q
 PHQyF1cA/J5mCfyXfdMG2CBqVS1hPpdktbb8KMGW5umYI8ottvF0KJz7H/f/Uc2CzHuB
 sE0A==
X-Gm-Message-State: AOJu0Yw7Sqfcu4B/fNekLF3ulEgZKhz4lYRbuOr9kfWv+TZ422GmQ212
 Ls4GV7zpEXOO4ZqlycNHdy/8J9hw4o6dljmNZFk=
X-Google-Smtp-Source: AGHT+IF1opDIjKq5IVIHCddXJX6mRxKoXA8mx6OdtJ6Jel4ohYFfrpcCASTiu4LgO8nwebTCfOI4iA==
X-Received: by 2002:a17:903:2344:b0:1c5:6dbc:7938 with SMTP id
 c4-20020a170903234400b001c56dbc7938mr2397915plh.69.1695930122652; 
 Thu, 28 Sep 2023 12:42:02 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:42:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 5/6] accel/tcg: Always set CF_LAST_IO with CF_NOIRQ
Date: Thu, 28 Sep 2023 12:41:55 -0700
Message-Id: <20230928194156.237351-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Without this we can get see loops through cpu_io_recompile,
in which the cpu makes no progress.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 accel/tcg/tb-maint.c | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e2c494e75e..c724e8b6f1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -720,7 +720,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
             && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
-                | CF_NOIRQ | 1;
+                | CF_LAST_IO | CF_NOIRQ | 1;
         }
 #endif
         return false;
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 32ae8af61c..0c3e227409 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1083,7 +1083,8 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc)
     if (current_tb_modified) {
         /* Force execution of one insn next time.  */
         CPUState *cpu = current_cpu;
-        cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        cpu->cflags_next_tb =
+            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
         return true;
     }
     return false;
@@ -1153,7 +1154,8 @@ tb_invalidate_phys_page_range__locked(struct page_collection *pages,
     if (current_tb_modified) {
         page_collection_unlock(pages);
         /* Force execution of one insn next time.  */
-        current_cpu->cflags_next_tb = 1 | CF_NOIRQ | curr_cflags(current_cpu);
+        current_cpu->cflags_next_tb =
+            1 | CF_LAST_IO | CF_NOIRQ | curr_cflags(current_cpu);
         mmap_unlock();
         cpu_loop_exit_noexc(current_cpu);
     }
-- 
2.34.1


