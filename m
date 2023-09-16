Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E977A32BE
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3t-0007Lv-W8; Sat, 16 Sep 2023 17:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3D-0005Ex-8f
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:04 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3A-0000WX-Cg
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:02 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6c0bbbbad81so2053961a34.3
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900519; x=1695505319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHcFvVjiu81dG+FC6IAxYA+pdBiv307/mnWZeRBLY1I=;
 b=nG90b1h+iK2jk5y+hu4e5nfAoDE9CIWBovFbE+bC4vbwUiQog7j1y7+7eNL6HOEl3j
 ILlaOC7nsIhM8PmzPKJFPeR2+aRDZs+sZvZteD1gmYzcVSBoYKBL9ESIR1jfQCzseAiB
 8ngtuO1T8/PLVijQZvXng89iVMJVnJXzs3StbvFHjG244Cjtw6pamKG7K12+mXO8ghaZ
 IEP6mr2Ps1iDYRXyUTphbhOL/GjG9LHR5fCm/5OGb4EJw0yBv8rZ+UkZtJmo+ZOEwQYh
 m7X1AFqwyz3mrN+QZNr0biceOXwZ1lQ4kgI8KUHGbge+TVh5mLNkYjJJG3gEkhKVJJWO
 r5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900519; x=1695505319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHcFvVjiu81dG+FC6IAxYA+pdBiv307/mnWZeRBLY1I=;
 b=WIXTJsg2UARb7LxUaVrl1OoPRNPvtu4PHayPzN+lGWmQoHuQw1gFnk4uSvT3Mh0s+x
 RkOmVuRMqgflOap+3ui/cY0rz/06jJGOSp9PjtBORsivfXwIwpvncWTUEsaviRwB2kRI
 8YozzFEbMRDN1ztpq960HmooWQJuREVM5xMrguyw9I5Zx+KGs4u4IKBgDGKSKavz2IwY
 KhdSV/CwWANLn0JF3tnePd0MYA3ouckOejhNVAHnFjR1dwl1Xu9rNLYofSWNbqD2Hjp1
 ki7i7TjxjrCW75Igl4e2Chy9FIPaRuP+cwtpQlYxKRPuSnejzsSpr6wIezLdUQ0Mxj94
 gJsw==
X-Gm-Message-State: AOJu0YyRBsmI2no/kXA1k1HmFZaEe4sTSLY8Fyf+kA8Eof7Aqujbfkpn
 cdKTFGB5KLP2fN6kpQMExJ1TAxFTyZ40cPEifqk=
X-Google-Smtp-Source: AGHT+IGp5LYINqAaNccd3XIeGRRfXDTn405pFfVxSJor8r7/j2mnBPkf/ht++B969c1gK4ONrXszgQ==
X-Received: by 2002:a05:6358:899:b0:13f:183b:f049 with SMTP id
 m25-20020a056358089900b0013f183bf049mr5566313rwj.1.1694900519017; 
 Sat, 16 Sep 2023 14:41:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 36/39] accel: Introduce accel_cpu_unrealize() stub
Date: Sat, 16 Sep 2023 14:41:20 -0700
Message-Id: <20230916214123.525796-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

Prepare the stub for parity with accel_cpu_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230915190009.68404-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/accel.h | 6 ++++++
 accel/accel-target.c | 4 ++++
 cpu-target.c         | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index cb64a07b84..7b02cb40e5 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -96,6 +96,12 @@ void accel_cpu_instance_init(CPUState *cpu);
  */
 bool accel_cpu_realize(CPUState *cpu, Error **errp);
 
+/**
+ * accel_cpu_unrealize:
+ * @cpu: The CPU that needs to call accel-specific cpu unrealization.
+ */
+void accel_cpu_unrealize(CPUState *cpu);
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/accel/accel-target.c b/accel/accel-target.c
index b953855e8b..cc3a45e663 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -129,6 +129,10 @@ bool accel_cpu_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+void accel_cpu_unrealize(CPUState *cpu)
+{
+}
+
 int accel_supported_gdbstub_sstep_flags(void)
 {
     AccelState *accel = current_accel();
diff --git a/cpu-target.c b/cpu-target.c
index 61c9760e62..b928bbed50 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -187,8 +187,9 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
-     * tcg_exec_unrealizefn, which may free fields using call_rcu.
+     * accel_cpu_unrealize, which may free fields using call_rcu.
      */
+    accel_cpu_unrealize(cpu);
     if (tcg_enabled()) {
         tcg_exec_unrealizefn(cpu);
     }
-- 
2.34.1


