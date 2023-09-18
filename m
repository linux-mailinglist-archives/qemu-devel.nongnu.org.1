Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F727A476A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:43:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBi3-0002dL-HZ; Mon, 18 Sep 2023 06:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBhu-0002ct-PX
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:22 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiBht-00041y-3Q
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:42:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so4088672f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033739; x=1695638539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W52OzMfh5+MNdMUtWyOMIRdFjsJUql/0VwepeW4hS+w=;
 b=qlOKRjtKIdvRvHtSeSYFjJKOBvGGIdRIE6p8o4HdJ1w8HwnqWcdeI5bmkcKtbMXaDE
 stJS8kQVUFo/ZRxOE1aV3jwM0Jn9IB27E5ZfY/op9kM5shIZo4sTKS6rAQXMzYiNXGtH
 lpjifsVgLaC8zUH6MYPga9NBPMIsXCreKQlUfPtrsPIPAXRssH8cPB/YvQryuzGYIpnD
 Yy5oFv0aOaHe8siG9ALgSH/9qYlGOFkkb1fBGzgU1AsvDCdEC4oIgCq5M2UPvnouzRFM
 TqhWJw9eQW8n0M06aCroWX7643wRMCQmuyGPkhO7BxNc95oxLNbq7kwKwcxv2ug1+kcH
 PsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033739; x=1695638539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W52OzMfh5+MNdMUtWyOMIRdFjsJUql/0VwepeW4hS+w=;
 b=bPzfF+0pOo0OHz2WOqSAtDTOIQFYq/cwtRVW2gyWIGfNVlsKsdxZAxU8iSbgw0Y0Dq
 KBsBuhWL/qjmkddNG3Js4egodIl/ZpuN/54/phLS90Pch3iVmn2fPpcJHW98bWrHk45D
 JojDQcyt/STg5SPmpGAm1l+lq67wN59JdioK93U8HUs0aD7I68ezIqLKCnN9czFg75+s
 I0tiUDDoazbtbAK/+gKVjac0p4gQgbyjtujmuePAZl/L8GsDnfA+vuMTJsUrYqaFWNcG
 2N6iesLrORV4/K1aXpIc6r/uRPW9YD0UIHP3N/YT/5i4R9IO0geSaUSLNwsWEOSpY78y
 KOUw==
X-Gm-Message-State: AOJu0YytTlSdJux1qAwi7lRQeRrYgf77IXe0V3NkjuPeCvvoZ5bX0aTe
 uB3qctEGMi0rJ4O0mLZ/GaDMZqHnn5hzB/Hst38qiQ==
X-Google-Smtp-Source: AGHT+IFemvQY3u202U4yXA9Ndn0gpzf58Cw0SkRTOzVyDOSU8Go6BbaoP+LvycBokEyi58PfaPP+bQ==
X-Received: by 2002:adf:f34b:0:b0:31f:e756:cbf9 with SMTP id
 e11-20020adff34b000000b0031fe756cbf9mr6483819wrp.22.1695033739305; 
 Mon, 18 Sep 2023 03:42:19 -0700 (PDT)
Received: from localhost.localdomain (5.red-88-29-175.dynamicip.rima-tde.net.
 [88.29.175.5]) by smtp.gmail.com with ESMTPSA id
 n9-20020adfe789000000b003180fdf5589sm7926499wrm.6.2023.09.18.03.42.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Sep 2023 03:42:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Claudio Fontana <cfontana@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alessandro Di Federico <ale@rev.ng>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] accel: Introduce cpu_exec_reset_hold()
Date: Mon, 18 Sep 2023 12:41:51 +0200
Message-ID: <20230918104153.24433-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918104153.24433-1-philmd@linaro.org>
References: <20230918104153.24433-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Introduce cpu_exec_reset_hold() which call an accelerator
specific AccelOpsClass::cpu_reset_hold() handler.

Define a stub on TCG user emulation, because CPU reset is
irrelevant there.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h      | 1 +
 include/sysemu/accel-ops.h | 1 +
 accel/tcg/user-exec-stub.c | 4 ++++
 hw/core/cpu-common.c       | 1 +
 softmmu/cpus.c             | 7 +++++++
 5 files changed, 14 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 92a4234439..7bbfa81dcd 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1011,6 +1011,7 @@ void cpu_class_init_props(DeviceClass *dc);
 void cpu_exec_initfn(CPUState *cpu);
 void cpu_exec_realizefn(CPUState *cpu, Error **errp);
 void cpu_exec_unrealizefn(CPUState *cpu);
+void cpu_exec_reset_hold(CPUState *cpu);
 
 /**
  * target_words_bigendian:
diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index 3c1fab4b1e..ef91fc28bb 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -30,6 +30,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelOpsClass *ops);
 
     bool (*cpus_are_resettable)(void);
+    void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
     void (*kick_vcpu_thread)(CPUState *cpu);
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 874e1f1a20..b1bf8bed89 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -16,6 +16,10 @@ void qemu_init_vcpu(CPUState *cpu)
 {
 }
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+}
+
 /* User mode emulation does not support record/replay yet.  */
 
 bool replay_exception(void)
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index b3b5ce6702..b50bc22fb7 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -137,6 +137,7 @@ static void cpu_common_reset_hold(Object *obj)
     cpu->crash_occurred = false;
     cpu->cflags_next_tb = -1;
 
+    cpu_exec_reset_hold(cpu);
     if (tcg_enabled()) {
         tcg_flush_jmp_cache(cpu);
         tcg_flush_softmmu_tlb(cpu);
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 0848e0dbdb..952f15868c 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -201,6 +201,13 @@ bool cpus_are_resettable(void)
     return true;
 }
 
+void cpu_exec_reset_hold(CPUState *cpu)
+{
+    if (cpus_accel->cpu_reset_hold) {
+        cpus_accel->cpu_reset_hold(cpu);
+    }
+}
+
 int64_t cpus_get_virtual_clock(void)
 {
     /*
-- 
2.41.0


