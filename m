Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF427B6FDC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:34:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEv-0008Fc-Lu; Tue, 03 Oct 2023 13:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEa-0008Ei-Bt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:00 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEX-0007RL-9f
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:00 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-694f3444f94so930431b3a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354256; x=1696959056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+B1EB2WfX7i66Q40VYy12Q9OAJLQdz1XrbP+Tnb430=;
 b=vF3DtLvvG2LC2y04X3lHojO7lTs0NNiF/qOn97UQMhj9ogiIyitlQCk6gKyN5yuzC1
 yrEmZTzLoxHda4KVyBnhcNmbXJ83NcEKaO0VadtBI3DQs+kXliT51Oebe5W4vVKgnWfJ
 t3x2m/NJ7TjydcxZ8fvjdeq3gy63w49XCX0AgWlUXg/zpfi5HGiSY8uouS+rzXzFSiuh
 v98atzrjsprM06dc/kqTMV6q6FUni4uvzU41vI0YNllX+a1kZOBxq/Sasz/UOcjRrngT
 TBeTcwlLTXYwXQXmKT8tS3FHCYcnhjvF71Mf2QgMzD/M5LcIl6vAfEEkJJg3CE4I9ITP
 98KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354256; x=1696959056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+B1EB2WfX7i66Q40VYy12Q9OAJLQdz1XrbP+Tnb430=;
 b=Bj01nAh+gOv6kIKAMvdPFLvF1NTjK2a2qaN1Y+97B+GCmFE5DMsThPItMEexuhW9iI
 D4JLt7mJ/Mr1SDl1+Lai9U3BjaORIzELDLiTruujCu3wiJg2yYDD/S6mPOozKms3158U
 YyNceGnh2SjyEq9pjHMORkXwSJz87ctV/WcFQOmEEdk3ZwpVHwMyvE+pSgMT+U5ULfCw
 BLMnelecjC2OH/RdSMxpXNIq1SlSBnW7IlhTDPGjEB2KfxuKGn8QTuG3k8uRxgIiW9xp
 b5Of0z+ugPpJzsqCwsuvEFchV3fniJ3+na1r3jfvNKbP2LjT/yIikiTZyXi9eZtAZnCt
 HmKg==
X-Gm-Message-State: AOJu0Ywx8/WX/0RJ3OfWO0IoxcBK22BHQ1RBwn/rY3KPwgRVkJOSdnHY
 dizZeCi6jTyst1Q4BMXF7GeuZH3dZMjAMT+f534=
X-Google-Smtp-Source: AGHT+IGbsUVrSdCQsRXS3bqQ2vbPPlnFhO3pEN7BfAgVGfGs+wsAq5yCljzLyPCAYlJ/MM17IaVeLQ==
X-Received: by 2002:a05:6a00:2e02:b0:68f:b5cb:ced0 with SMTP id
 fc2-20020a056a002e0200b0068fb5cbced0mr281962pfb.34.1696354255841; 
 Tue, 03 Oct 2023 10:30:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:30:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PULL 01/47] accel: Rename accel_cpu_realizefn() ->
 accel_cpu_realize()
Date: Tue,  3 Oct 2023 10:30:06 -0700
Message-Id: <20231003173052.1601813-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We use the '*fn' suffix for handlers, this is a public method.
Drop the suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Message-Id: <20231003123026.99229-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h      | 4 ++--
 accel/accel-common.c      | 2 +-
 cpu.c                     | 2 +-
 target/i386/kvm/kvm-cpu.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index e84db2e3e5..cb64a07b84 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -90,11 +90,11 @@ void accel_setup_post(MachineState *ms);
 void accel_cpu_instance_init(CPUState *cpu);
 
 /**
- * accel_cpu_realizefn:
+ * accel_cpu_realize:
  * @cpu: The CPU that needs to call accel-specific cpu realization.
  * @errp: currently unused.
  */
-bool accel_cpu_realizefn(CPUState *cpu, Error **errp);
+bool accel_cpu_realize(CPUState *cpu, Error **errp);
 
 /**
  * accel_supported_gdbstub_sstep_flags:
diff --git a/accel/accel-common.c b/accel/accel-common.c
index df72cc989a..b953855e8b 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -119,7 +119,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
-bool accel_cpu_realizefn(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
diff --git a/cpu.c b/cpu.c
index 0769b0b153..61c9760e62 100644
--- a/cpu.c
+++ b/cpu.c
@@ -136,7 +136,7 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
     /* cache the cpu class for the hotpath */
     cpu->cc = CPU_GET_CLASS(cpu);
 
-    if (!accel_cpu_realizefn(cpu, errp)) {
+    if (!accel_cpu_realize(cpu, errp)) {
         return;
     }
 
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 7237378a7d..4474689f81 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -35,7 +35,7 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
      * x86_cpu_realize():
      *  -> x86_cpu_expand_features()
      *  -> cpu_exec_realizefn():
-     *            -> accel_cpu_realizefn()
+     *            -> accel_cpu_realize()
      *               kvm_cpu_realizefn() -> host_cpu_realizefn()
      *  -> check/update ucode_rev, phys_bits, mwait
      */
-- 
2.34.1


