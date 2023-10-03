Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AF77B7000
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFC-0008WB-2r; Tue, 03 Oct 2023 13:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEs-0008GR-80
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:19 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEe-0007SL-6R
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:17 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so35795a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354262; x=1696959062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LWn66eoabmhWCZGd9Txn8+MRXv5U5+kD2rG/XLHDpk=;
 b=AIGBpeWOJ+e/iw0+zCjg4nUr12v0oMzGjK21A96vthZS8zA64QU3OAaex137Obwl4m
 UtPeLbe2adjC/XnNA97k+4I/e/Z/VTOtvpugHAkN9FAPBKl2Z0RiU/1U5qSjJu8YYVEq
 XPwpDiUKP5xm4Ha++YlgCmYqUSEEAJboZ59vhZLl+0IleBo6Ls5NJ2O/EYbCpMuNzkX3
 i6jfDnVzIfjgvUuQ+HBUzh+YOtooR6i2DQwZuygyjF/LO6VqghzKHJB0C2ZNeEoDgoxT
 KcqawWSK2E2hau6pQtvPS4kcjVi+EYKfIuFakRtyjicmpCIX6KfVdXdTBeHDPB5hAaua
 mtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354262; x=1696959062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+LWn66eoabmhWCZGd9Txn8+MRXv5U5+kD2rG/XLHDpk=;
 b=p9Ycn6TP8iwoptiAmEISPAlbdjloiU/Fz1+Ue4Eg9Dv5j+bQnoX0aqtMRnYnGsdGCR
 ZBjPb6lC+P9PX4lOWwBc7vaz7ctGGc32JSoIrFjR9PxyCpaf+uWL1EK4zZNEPa+E8XGH
 PWpdtMSUNXaC3UbCiYKwpBAVKO+6lrdK0mAuTkDFD9W8ainDFLzt/SuwI2liZnNWas2y
 7GSOTjtp8vT3N53YXOhVV3BzGFdGKBb1Zp76GSfEaY9eymx/iQ6Ylh1zwRcRJN/B4e8X
 rZwBY01jIsY1KKlCEHD0NFB7+541O1VAT56pdG2sQc5NS5uWj7m//ia6bHCxZ3U0JspM
 6+3w==
X-Gm-Message-State: AOJu0YzetSUIxuqbOPCIzBtZ4CIbxQ+Iqw+IlS7Bt334HqZQioZkO8/j
 jHC4Y43gNKsrCwmpnJZ1c+0jG98YeChda+aLdJ0=
X-Google-Smtp-Source: AGHT+IGZva5m40MMlLD+GtBItyyhs9FfxJV5Upcprzmtmum3oQOZm7gSZnGyQkN16jRZGsayhIFEgA==
X-Received: by 2002:a05:6a20:748c:b0:125:3445:8af0 with SMTP id
 p12-20020a056a20748c00b0012534458af0mr5170744pzd.7.1696354261830; 
 Tue, 03 Oct 2023 10:31:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PULL 07/47] accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
Date: Tue,  3 Oct 2023 10:30:12 -0700
Message-Id: <20231003173052.1601813-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We don't need to expose these TCG-specific methods to the
whole code base. Register them as AccelClass handlers, they
will be called by the generic accel_cpu_[un]realize() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Message-Id: <20231003123026.99229-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal.h   | 3 +++
 include/exec/cpu-all.h | 2 --
 accel/tcg/tcg-all.c    | 2 ++
 cpu.c                  | 9 ---------
 4 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/accel/tcg/internal.h b/accel/tcg/internal.h
index e8cbbde581..57ab397df1 100644
--- a/accel/tcg/internal.h
+++ b/accel/tcg/internal.h
@@ -80,6 +80,9 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
+void tcg_exec_unrealizefn(CPUState *cpu);
+
 /* Return the current PC from CPU, which may be cached in TB. */
 static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 1e5c530ee1..230525ebf7 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -422,8 +422,6 @@ void dump_exec_info(GString *buf);
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
-void tcg_exec_unrealizefn(CPUState *cpu);
 
 /**
  * cpu_set_cpustate_pointers(cpu)
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 03dfd67e9e..8ab873a5ab 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -227,6 +227,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->cpu_common_realize = tcg_exec_realizefn;
+    ac->cpu_common_unrealize = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/cpu.c b/cpu.c
index 2a1eff948b..658d179582 100644
--- a/cpu.c
+++ b/cpu.c
@@ -140,11 +140,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         return;
     }
 
-    /* NB: errp parameter is unused currently */
-    if (tcg_enabled()) {
-        tcg_exec_realizefn(cpu, errp);
-    }
-
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
@@ -187,13 +182,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
-     * tcg_exec_unrealizefn and
      * accel_cpu_common_unrealize, which may free fields using call_rcu.
      */
     accel_cpu_common_unrealize(cpu);
-    if (tcg_enabled()) {
-        tcg_exec_unrealizefn(cpu);
-    }
 }
 
 /*
-- 
2.34.1


