Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75F57804D3
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:39:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJI-0003nN-7M; Thu, 17 Aug 2023 23:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJG-0003mF-6T
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:02 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqJE-00066e-1S
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:38:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68891000f34so428105b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329878; x=1692934678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWyWaLweKmGxIGHtAp4XoO86TF1nl2ACwaT8pP7W7x8=;
 b=1TQg2pJwmniMCfFPIrdZxOllYs3nKQ6OWX0L1cffpDbAzdSrFNqxYFSqjavKU1z0nA
 mXkLpFuyQ7mp31CMKflU30QhdroI69hqW/fkVd4lNZKS89uOd3zNgVRPBPaVo+Yzxjpa
 2j3YIAQa0EnjzpIgNeoSkQjkPS4uGASl53BZRTbwoH8vRcTZud9AeT2R3Ta1X9BBSZu/
 CrvbEkkIT9RJh61ch6q/vVoc/+KSeqMNoHOpGZnbXL5EOQ9FEvLBDKVlNiDbEzGPF/ld
 dLpZ9tm0ws1iLKytAfuxsLami/lmbAraiEcbxjd8mMsQqbQXNUjTPLGZVnnDFp5PpBnq
 /K3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329878; x=1692934678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZWyWaLweKmGxIGHtAp4XoO86TF1nl2ACwaT8pP7W7x8=;
 b=Wjt64qAj3WROJehNN+Bi+8tjLT1YnEaKglANX6NRnlDjEzfLqw5d/a6mL//9uNPkZO
 hm7kbvKBqUQEMEtquHaAh6XIXSEy1/AyMhdkz8pdwTT+pGVdp7VVf+ozX5zbeU4QfzT2
 xjjeA8CWVVFi99slkr6BuclsxxIFftCXSf+y9Zj5dEbfGyHsC1mnqVR5224GyKHGOPmT
 HV49dD1Nui7Epw2KlI+isnx+g5mG++MbTXr0GOa0t+V1aHI8JfxZ8mX+Sh0S/5Rau0g+
 7tqcq1yUYRnOvKqxnUg2d5xFTIhh+c1vxMEuiPUouLHZ8Qx+wdOvWmG05E2XkB6xRWeE
 EwHQ==
X-Gm-Message-State: AOJu0YxLzCx4xlxMok1tSG0FBEs1PJmZopnuOK4yJz50hNl7LSApS6ux
 wPwSdqaYuM3spuvTUUwcihkkhA==
X-Google-Smtp-Source: AGHT+IGz6axrCnWnU6zkx5BkPxP7/1NgyAPqg4epmaUv6bFNeGh6lmH1Sefk2wL/H5BLeVo8A/MJ3g==
X-Received: by 2002:a05:6a20:42a7:b0:12f:c0c1:d70 with SMTP id
 o39-20020a056a2042a700b0012fc0c10d70mr2043087pzj.40.1692329878632; 
 Thu, 17 Aug 2023 20:37:58 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 21/26] gdbstub: Expose functions to read registers
Date: Fri, 18 Aug 2023 12:36:40 +0900
Message-ID: <20230818033648.8326-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

gdb_foreach_feature() enumerates features that are useful to identify
registers. gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  6 ++++++
 gdbstub/gdbstub.c      | 20 +++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 5cba2933d2..1208fafa33 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -59,6 +59,12 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+void gdb_foreach_feature(CPUState *cpu,
+                         void (* callback)(void *, const GDBFeature *, int),
+                         void *opaque);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 55819f4aba..41fad40b6c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -481,7 +481,25 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+void gdb_foreach_feature(CPUState *cpu,
+                         void (* callback)(void *, const GDBFeature *, int),
+                         void *opaque)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+    GDBRegisterState *r;
+
+    if (!cc->gdb_core_feature) {
+        return;
+    }
+
+    callback(opaque, cc->gdb_core_feature, 0);
+
+    for (r = cpu->gdb_regs; r; r = r->next) {
+        callback(opaque, r->feature, r->base_reg);
+    }
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUArchState *env = cpu->env_ptr;
-- 
2.41.0


