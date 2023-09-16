Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D77A32A6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3c-0005Xu-If; Sat, 16 Sep 2023 17:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3C-0005Et-7g
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:02 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd39-0000WG-MI
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:01 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68fdd5c1bbbso2359887b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900518; x=1695505318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JL8rjLVD092FwcI3216ms8eo5o4CvSUxoIR2XgkySs=;
 b=C3aVPzFSb6sKY7GjEk5FMERAPd6qWkqK5kawrH01Fm1T7S86+91RhHdBxWFuZ4SxR5
 obrmMRVkJNDLAYlkNB0w5VrPja67uZhQgi3u+o/cclrNj86KseiGVb61GjUUQUGJWIe2
 ItPVfsqHU+DS8nVyTV35FYrMP82gQm6s8ylkpyhx7ue9o+Eh4lkTYHm2K2WFKTLSFDf2
 d1l1lzCxHc/ud9QjadRN9mKCTjXpElTBe7ll+Z0Sbm0qkiNlYcNaz8/nJGxFiwHRmdMV
 jgTzgwFr5QZpsgAHytEU5pDhgV4aGV96QrXaNtLpMpqNOg+xyakCRPBve1QC0t1luRnR
 jpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900518; x=1695505318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2JL8rjLVD092FwcI3216ms8eo5o4CvSUxoIR2XgkySs=;
 b=eYM6dDBfuivKD0eHlFquwempcujmWxJk/5cR2z4ijOOx98oCsME+uOcEPjSnlUlj87
 ZCMG7lrDc+Y8peLAJL0+Iq16BQTgkyvem5Ag9qik/pHx+KiEQTMRUiswEXlEbjKRryhE
 lg2GUTqyILYg6nI1/AG84IpmpljisSL6EPBbi/ceG9nRDCUZ8yWXhJcpNkg3I7zsX7pY
 JGmCQdwZtJxB7EK/Btc1y/7LTtlY9WWXaG74060sKVXWYRsfbmv2Fx+kpSTqECP7v2D3
 /Mu6rItyPstO2ZpHvjLAWpTAo+3g0VkMPHziIxVwm2+eglsJbhMv/xcwWlYUUWRmD+X9
 3zXA==
X-Gm-Message-State: AOJu0YwqF6TAYbCr/q7HL5QUbAgs6Usd3aqeLyZn6iGOfAD3bBAwDH2T
 KhX6wsTaHbxSBuNulu2i49tnhMWeeRvOA1rPXkY=
X-Google-Smtp-Source: AGHT+IGLBbl3oBKFjOyaS5oQce75UxI3GonvyE9r23p4b9EKmV2chnTHKP0mSuKAOnty1AuXu0u1Vg==
X-Received: by 2002:a05:6a00:1a92:b0:68f:b015:ea99 with SMTP id
 e18-20020a056a001a9200b0068fb015ea99mr6962101pfv.10.1694900518167; 
 Sat, 16 Sep 2023 14:41:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 35/39] accel: Rename accel_cpu_realizefn() ->
 accel_cpu_realize()
Date: Sat, 16 Sep 2023 14:41:19 -0700
Message-Id: <20230916214123.525796-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
Message-Id: <20230915190009.68404-2-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h      | 4 ++--
 accel/accel-target.c      | 2 +-
 cpu-target.c              | 2 +-
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
diff --git a/accel/accel-target.c b/accel/accel-target.c
index df72cc989a..b953855e8b 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -119,7 +119,7 @@ void accel_cpu_instance_init(CPUState *cpu)
     }
 }
 
-bool accel_cpu_realizefn(CPUState *cpu, Error **errp)
+bool accel_cpu_realize(CPUState *cpu, Error **errp)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
diff --git a/cpu-target.c b/cpu-target.c
index 0769b0b153..61c9760e62 100644
--- a/cpu-target.c
+++ b/cpu-target.c
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


