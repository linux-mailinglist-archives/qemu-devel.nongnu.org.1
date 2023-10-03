Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143C7B6910
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:32:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYy-0001IV-0I; Tue, 03 Oct 2023 08:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYd-0000tH-Q5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYW-0007mg-Ua
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:23 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32157c8e4c7so913898f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336274; x=1696941074; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YCJq244pl4+8992N+SUfSZJnXy6q+2iGjPbprJxjpgU=;
 b=kYm7nGryxgvS+7f6kjDbCqKJ9aC6sz4BmDYIPgotRv0Fu3X3wymqeuUnQiXEgqpEJl
 0ARJi3vOd4Xl0FjFc019DhYZfa3IjbpIBG12kTiWhC62DSBiR/owDwwjPV6jmkwqxgoD
 PoPUv3n8AMX5QzW+fsncSR0qgFwJDWDadD5DisXN15PVY0xohKtX1g/vt0rGU1sKWiel
 Y2y6sahoVg0X0VWlHSgopzBpXBnV0xZmIKgKPfUJNf2hWhEgkczcXI0Ssh+qlKnUzXbU
 AZ2s5pypAH8b2ozm8KMsgk5tSiJcHaieXXJXnL6PTCa5azuHs411xsIgh8SKIda37Wwf
 PSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336274; x=1696941074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YCJq244pl4+8992N+SUfSZJnXy6q+2iGjPbprJxjpgU=;
 b=NxNzyspLQ96XfEw041UcIyOoZYjbsoZ+m3ipaoVTd6uWukcMHgd6o9R2aHY3ZblRrH
 uXqkJ90khfrEaCTtrhkTjVZwUlG7f+pFCAGXt1qbCSbV5yNHf0BbwouoEZmR+446VGyF
 lZCC5FH89BgbZ4fcRSTdT3RL/MLQHnNEL+57v47WuLLE0QoHDCx/UK0Q78KGqBOIkJ64
 K6fwCRfn62Cjkia8jAOTFl2Wm30mDZoWhH56h4wm4TlGsHavIsIwihwlm6YxaQA55x6A
 Ap8wL/jmhB5OAkZZ1qqIB03RrxGY8/EQArP/XS831nhV6uRqQaaseV1uXnIkgG1C5Htz
 QNhA==
X-Gm-Message-State: AOJu0YzEzHC3G5wOE3x0AuK0OYHqRF3lZ2NcrBP+55atGGvFp6Eho+yC
 pP9EZje4dK5sFlMEtUMpFhpwhCFZZb5AgPTnmRnZ8g==
X-Google-Smtp-Source: AGHT+IFOv9460imGFEIgqRm0UvkQ7r6CSfyL7aih3gY5LLipvr1UBoZ7dIbBHQMj6JPYXiQgRbHH4Q==
X-Received: by 2002:adf:e852:0:b0:323:2038:944 with SMTP id
 d18-20020adfe852000000b0032320380944mr13304917wrn.58.1696336274319; 
 Tue, 03 Oct 2023 05:31:14 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a5d464e000000b0031f8a59dbeasm1478930wrs.62.2023.10.03.05.31.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:31:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 7/7] accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
Date: Tue,  3 Oct 2023 14:30:25 +0200
Message-ID: <20231003123026.99229-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
Reviewed-by: Claudio Fontana <cfontana@suse.de>
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
2.41.0


