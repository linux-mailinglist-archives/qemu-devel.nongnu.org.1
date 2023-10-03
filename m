Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60287B7016
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjEx-0008M0-GN; Tue, 03 Oct 2023 13:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEc-0008FH-0g
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEa-0007Rd-2v
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so997011b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354259; x=1696959059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwR4B33YrXE7cO5Ar0J6YeB7AwEW2b3RFRAyXSWwKx0=;
 b=i/1veZfymuRrbhTKAwwMwNs542omHIhqiAJp1a79B3uiHov5ZD6yl6hb2gd4govsx3
 ZAmsirzSD4iL8fnxV2MnPY9em+FiKLINIGK5NZ0Qtg1mAeeb0rdziCJuCu9JQUcBIPF2
 qSQGjTzCLrf5IWNk+1a5TFMequdA3oQzRtBCYG1Hs2hvjLpkEaiOfPC9Ca+qnUXhOF6x
 agN0LsezpkFhYnnVk5ffC6WYdKvHratDNqygsdogxaBbtyzCP4EiszonoKu9kmnoAPDL
 9CdeKRnarcqGjhtjGrjWjZ6zzczllYNhg/z/3d4H1mKlBK7gKjfhKhoeJbZoxfL/fKS4
 a69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354259; x=1696959059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwR4B33YrXE7cO5Ar0J6YeB7AwEW2b3RFRAyXSWwKx0=;
 b=uecL8YpSKS7UHF9m8rqMBgxMCrYued6YmLFxM7654h10krztkZY8hOTzk5Czih7vTF
 QMvdYZSzBW1zf9kL2EAcVvvvPmwDdqc5HM/TdukO4Bjzt7o7/uMD2+BNRG/GKvaHFX71
 gTOYc39m9FnV6PwuSTY5ZdxnEkOdmPyXNJknI7/C1SeQbfp4XyjccdnwIKswgyyl/uNT
 Tzs+tNu1drJmX1ip+MVFOtnRZ5zvcx9wpN4hOiohPgZnEwV9YNV1U/PBduYPEeBHioX9
 gp26iJMXAHF7YYiOheRYBYQK57qaJWQu+m3u6GpoQZHotZXc1RuCk76vSJjic6/IcVaa
 buyQ==
X-Gm-Message-State: AOJu0YzCTJTw+wbmW7HIoqcpA4B8pU4A33eTLubYm/pCdasZAzsrAjrA
 JF1OuzYWN2Sn2eoYeNIS8WUTlDYvqWmZzKnP71M=
X-Google-Smtp-Source: AGHT+IHsV6/COhGRHAdq1U0r5nxcgn74lX/U8MDo1/i2cXZqtAmx28Vpncqgzt9wKQclYdUcL8lsQw==
X-Received: by 2002:a05:6a00:3913:b0:692:af9c:d96f with SMTP id
 fh19-20020a056a00391300b00692af9cd96fmr214564pfb.1.1696354258799; 
 Tue, 03 Oct 2023 10:30:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:30:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/47] accel: Introduce accel_cpu_common_unrealize() stub
Date: Tue,  3 Oct 2023 10:30:09 -0700
Message-Id: <20231003173052.1601813-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Prepare the stub for parity with accel_cpu_common_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231003123026.99229-5-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


