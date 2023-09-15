Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBC97A26D1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:01:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhE3s-0006Ua-5J; Fri, 15 Sep 2023 15:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3j-0006L0-72
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:56 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhE3d-0007cx-RJ
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 15:00:52 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9aa0495f9cfso775997966b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804448; x=1695409248; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oOpx/VA/+gwdtEbnTetIr2FQsXveadRswnAsnH4GXos=;
 b=T5WE8C4vlwgDcx4Ksk2YfPYahMDkzzf8R18h0z3+Y9S0iZsEOin7R9QRGlogT4hKI9
 MlkhNKsMCoM358ZWvUEOwVYQXa4oXQQgaGvAKebkmv4YDxIA1gL7WNzmhdpc115g4bVE
 S4Bn9ksR5OsX7HAZLkhq/WFfWjW7tz/1nsPtKd23sXEV/+B2H5bfd+zRIqwcEkDfVwC2
 oRk60ibugg8HFH8du0ZBsu8AH/vGbXdMp/V73K7u118uLdFZGFR0sgO+c/A140pzS6Jq
 hfBTcbIrgaWCFX6lU4t7pwMN05CiyKbXL3WrSqR2jLzD/r7kkjRc2ZTQp7BcjspAcidV
 PJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804448; x=1695409248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oOpx/VA/+gwdtEbnTetIr2FQsXveadRswnAsnH4GXos=;
 b=qbkuZpEn/G5+D4robAls3HyqfV9BS42krPA8UVblwpIY1KMB9SX3pDD9ErXeoQEkgt
 HzM1BnbcQ9RALqFWvIN+ccFkH1K7Q+y1pkIpGYatQERQBrrL5AiL7jCvrUtGDNOL5xer
 2cQ1NuAYnWEApOXlXQAIARS92HjhlizVZ+h4JfjCTdEjj740GjAsdIRtt29nAbDMdkT4
 E0qME5XrbMps2vzxr3wf/80Bu2mc4LtxtLwKYGqBw4opsVoIVEtLmBgTTA395II0EBY0
 CeswzXwkuYubWzZfHseo36Jfsuz05HWdOorEFn/xC9cPVLTBNuoUwFsYmuD3HggJUAuo
 NGEg==
X-Gm-Message-State: AOJu0YxruCXpUy08ey8r+YsLWPZ/JW0ix3VbGzLkZC+zFmMPP5+2KZP6
 C9nqqKeBOxII4CABb7aMzmMyWjKXIlUuzS8rz/I=
X-Google-Smtp-Source: AGHT+IELleuQSkuMS3U2vjtSOoyli3O0jtH4oH1By3hb7PvHE0MO+UI88qPm19yIOTSyq5wf6F29XQ==
X-Received: by 2002:a17:907:3f91:b0:9a5:b247:3ab with SMTP id
 hr17-20020a1709073f9100b009a5b24703abmr9362665ejc.19.1694804445231; 
 Fri, 15 Sep 2023 12:00:45 -0700 (PDT)
Received: from m1x-phil.lan (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr.
 [176.171.209.234]) by smtp.gmail.com with ESMTPSA id
 mf13-20020a170906cb8d00b0099caf5bed64sm2735321ejb.57.2023.09.15.12.00.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 Sep 2023 12:00:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Marcelo Tosatti <mtosatti@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH 5/5] accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
Date: Fri, 15 Sep 2023 21:00:08 +0200
Message-ID: <20230915190009.68404-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915190009.68404-1-philmd@linaro.org>
References: <20230915190009.68404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

We don't need to expose these TCG-specific methods to the
whole code base. Register them as AccelClass handlers, they
will be called by the generic accel_cpu_[un]realize() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/internal.h   | 3 +++
 include/exec/cpu-all.h | 2 --
 accel/tcg/tcg-all.c    | 2 ++
 cpu.c                  | 8 --------
 4 files changed, 5 insertions(+), 10 deletions(-)

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
index 03dfd67e9e..6942a9766a 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -227,6 +227,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->realize_cpu = tcg_exec_realizefn;
+    ac->unrealize_cpu = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/cpu.c b/cpu.c
index b928bbed50..1a8e730bed 100644
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
 
@@ -190,9 +185,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      * accel_cpu_unrealize, which may free fields using call_rcu.
      */
     accel_cpu_unrealize(cpu);
-    if (tcg_enabled()) {
-        tcg_exec_unrealizefn(cpu);
-    }
 }
 
 /*
-- 
2.41.0


