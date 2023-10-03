Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 632CB7B6906
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:31:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYF-00007p-Iu; Tue, 03 Oct 2023 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneY1-0008QB-4U
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneXu-0007h2-IP
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:30:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-406589e5765so8507395e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336236; x=1696941036; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqFGd5F05ZVpX+rAUXHuXXrGJSE30XMuMRRy/YP47Yw=;
 b=CQjapap7b5Xqe/zibWsYoe/Ap4RX4Ra11E5kYthsh8PjPzw3Bc0UqpYrEn2cm4kEL1
 epQoCgj9RO48O45N3I060Ik0YuY+eeVQqRCm4paXZDv8cF4nvDyP2Z74BTkXhbY7Z6A7
 HndZCIYBrUgFmN3PnSnyRMf1tMMZ3njBaW+cQVf/LJrYsS/P3z+YVxTbtnWKfQr8XXPD
 vljm8BZ/Jl9y8JLmqb+6sVwu/iqK78v7eHxVRmfP+stFJMtxbfY0iuGXOiyElZj9zVl9
 rCJNvKwwYsaPK1SfgClziH6M+g0wbGlRznl2ZDKKaIHWxIFFByJ6NC+GPx1JXbI7B1Id
 ct3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336236; x=1696941036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqFGd5F05ZVpX+rAUXHuXXrGJSE30XMuMRRy/YP47Yw=;
 b=n2U5o5dIthqUs0+MITGVzLhTImmuzZ6Bknula/3SkK3Jk1c7BE4Tg0TDB79HnDD5Y/
 3FLqDXtGPWgvFxQmhH12PEWdB/Jrvzdd0qUHG8TTpntPIFTkEP85gX9iJkNhEr7XGCGQ
 jWYOBxpxZWZr5ov+qhEPo0ANQ2thUx0wjFeKFdwZWTBfYtDs7nkOWc2HAvY9scFRUuAG
 oIkcOkeLguX2KEcjFAzZbo7pM67ulH7tI+mvixmqCChLIFRcbE31x886p0NjL86Q7et+
 9vpOpUETcxRU2B9rffTI84q+X5RtsaHzaxaR9PsNWzIV3BOZp/3kqlxZJXvnuB92WQyw
 Z6KA==
X-Gm-Message-State: AOJu0YyePxW1DJJnWSbPXRmkdt4fjTgNgsx5Z7lFcLVdLT/QCvsrpfYY
 pfRQsnrnuldCQosr5CfAWWlTldr8o9F+9Rkcz9Uzjw==
X-Google-Smtp-Source: AGHT+IHlCemvbL7m1K7IS5TqiHcr5lgRDPenb1BNclDOxWgfEhUSel/BooBOcvOiYSYcDzQ5Hhk7WQ==
X-Received: by 2002:a05:600c:210a:b0:3fe:e7b2:c97f with SMTP id
 u10-20020a05600c210a00b003fee7b2c97fmr12100982wml.36.1696336235719; 
 Tue, 03 Oct 2023 05:30:35 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b004065d72ab19sm9405951wms.0.2023.10.03.05.30.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:30:35 -0700 (PDT)
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
Subject: [PATCH v2 1/7] accel: Rename accel_cpu_realizefn() ->
 accel_cpu_realize()
Date: Tue,  3 Oct 2023 14:30:19 +0200
Message-ID: <20231003123026.99229-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We use the '*fn' suffix for handlers, this is a public method.
Drop the suffix.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
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
2.41.0


