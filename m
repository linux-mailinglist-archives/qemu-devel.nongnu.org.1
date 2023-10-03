Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4547B6907
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qneYL-0000EY-JP; Tue, 03 Oct 2023 08:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYG-0000D3-Dd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qneYD-0007kX-L4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:31:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so8171105e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696336255; x=1696941055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gkc/bRL42O1meaWPMr7Z06ZuzQxfC9K3bpAdX8HhInA=;
 b=WFazSj61Qn4xvSTLwNPFMRya+BzaM5zv8RZUy6bQAHCveIRFUzfVVlxfsyrRqPlm73
 iDNIVlfrGhG0ILM17K5ZUlWldjMAigTBr9/c2LfSZHJc4o/R5rKLqhjtcICLTwtZw4/X
 kf/GJxCGAEA1PMEP9ekaAX1y/wflWDXy1EYKe3OnkvUQzW4Hh1rZ48kmSBNM2VRQKZSD
 uXf9+qR7ZSXJBShHHJkQrONccBVoXEyVQc5pzWchu4R81EDEUv0CXweu+wdjigz5sBrv
 FcLO/xJlsnYzj9ii7ixaInwlPQC1VaZ8aLqAr8sbJL9RYtue1WdnEaHGxQ8n74fxzM7D
 /jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696336255; x=1696941055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gkc/bRL42O1meaWPMr7Z06ZuzQxfC9K3bpAdX8HhInA=;
 b=gAmStbQbht2HgHQpSEvlzig8UrTxgmQzeBePDmsnFjQmIFrzksiB/AwxV0AfkUH+Tw
 oS1A3ZQws2CviThLkeINd7p74lTJ7z+kJgInYjlI5txmbrIFWgxZYdYZ/qxL8hOjiKR5
 YOpmj88I0yH78S0kpIf2gRsHNenshq0H6wCWhHSQs/UVdDuOIlfQIsIZgTjOGikCig9F
 lT/FeEXnyd+zUZpm+1XpMop0W8gb0G/MNi5KnYgWEvSXbByuSRBGpSVeVoXU7aKbYg7n
 +MXSwaUcx0pxJSw2WbKadsrOitntkQ22zvexlR59ITnmFS9dri5vYas6LNseQUPZttdZ
 QWKQ==
X-Gm-Message-State: AOJu0YwgHBAplzxmawZqoSD2un8L7cykSZKvZWRB9tSGi2m3nxQVV8Se
 y45SkkLmq8m4g5LF9hVgnIahlso2KU1qsaid/qfZyA==
X-Google-Smtp-Source: AGHT+IFfS3e/r6v/mLNthJlFSJF+tDApG8FXlkYKsMscRfx5bpnxKY35taTyrdcfQ0W4kLclXxkyLQ==
X-Received: by 2002:a05:600c:22c8:b0:405:3955:5872 with SMTP id
 8-20020a05600c22c800b0040539555872mr11340217wmg.18.1696336254935; 
 Tue, 03 Oct 2023 05:30:54 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a5d570c000000b00327bf4f2f16sm1480932wrv.30.2023.10.03.05.30.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 05:30:54 -0700 (PDT)
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
Subject: [PATCH v2 4/7] accel: Introduce accel_cpu_common_unrealize() stub
Date: Tue,  3 Oct 2023 14:30:22 +0200
Message-ID: <20231003123026.99229-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003123026.99229-1-philmd@linaro.org>
References: <20231003123026.99229-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Prepare the stub for parity with accel_cpu_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/accel.h | 6 ++++++
 accel/accel-common.c | 4 ++++
 cpu.c                | 4 +++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index 898159c001..446153b145 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -96,6 +96,12 @@ void accel_cpu_instance_init(CPUState *cpu);
  */
 bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
 
+/**
+ * accel_cpu_common_unrealize:
+ * @cpu: The CPU that needs to call accel-specific cpu unrealization.
+ */
+void accel_cpu_common_unrealize(CPUState *cpu);
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 53cf08a89a..e9548eac29 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -129,6 +129,10 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     return true;
 }
 
+void accel_cpu_common_unrealize(CPUState *cpu)
+{
+}
+
 int accel_supported_gdbstub_sstep_flags(void)
 {
     AccelState *accel = current_accel();
diff --git a/cpu.c b/cpu.c
index 1e2649a706..2a1eff948b 100644
--- a/cpu.c
+++ b/cpu.c
@@ -187,8 +187,10 @@ void cpu_exec_unrealizefn(CPUState *cpu)
     cpu_list_remove(cpu);
     /*
      * Now that the vCPU has been removed from the RCU list, we can call
-     * tcg_exec_unrealizefn, which may free fields using call_rcu.
+     * tcg_exec_unrealizefn and
+     * accel_cpu_common_unrealize, which may free fields using call_rcu.
      */
+    accel_cpu_common_unrealize(cpu);
     if (tcg_enabled()) {
         tcg_exec_unrealizefn(cpu);
     }
-- 
2.41.0


