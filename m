Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C86F07D66E2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaG9-0006Iv-Ju; Wed, 25 Oct 2023 05:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaG6-0005xH-B5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:02 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaG4-0002TH-AJ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:33:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c77449a6daso46408915ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226379; x=1698831179;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6j0l4pFqSQGnzpTGvGolk8sQRFNuK5/112JHoxpOOo=;
 b=uQZvnBneB1+GhBIg2N9z5ggeIyPdQJj/E0tYxjfC2ZvFzISD/ItyJ4kCncRv2TViRv
 2velPMwz/a0AGWxFgl5t45IkAijJ8jCpUE26c15sYyjuaE4sOTBZrhyUOD6AYeAooa3b
 WNJn5qcUnACfgnvDV7VRAvOxgoJv6eoyR4qZLJg1HpLn/pX00dgDz1bwKfARoDFlsySR
 AtWxHCTf2KeNK5iCZHI1JPnN+3yFCR1OvCdNcbHhC10tv0T9+CrpzPLBcRVR6hfPzxXJ
 6hh2cdkJonY74cRs2LY8ZWq5gArfiHb2L+phCo2B6smA6/6/2Ot49Za68cEYHb5Xxdxc
 EE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226379; x=1698831179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r6j0l4pFqSQGnzpTGvGolk8sQRFNuK5/112JHoxpOOo=;
 b=FD6DUt9R3hI2tNguDjUIvy7YBedmbG3uD1yz6IkRnCobDOwoFZgOcuZk/5dIqwASqb
 7ZbBoUFbrOD55T1Qtb7NEa8J7YMzatLTGBMruW4eAcO5/zf3ljFpRF08abQBt1vQNdq9
 4unTcZY6JXa+/whYV3aYJf/1/gYUZrr9BkXS79QOsNURIqJkuZAwPo8NWkIU7EymY4BU
 6I0Lcz2dW+Rz0F4uC8gVNycgsagM8TbAwF68XwozBEhgHUxvEpoq7i3eR3cbA86Ut7BW
 IOIbDp0aqwkVbJAanRNNtzJFfiM3n9XkvkP0DjQouv7SQZw1l8JQx0z4r1pbzUGg6oVQ
 BNoA==
X-Gm-Message-State: AOJu0YwqPMlnFnhI9RrBGC+rujUU90YGl3sJKGSjYxe9Vle6Q6CDMQzT
 QNbG516G2HiD3RUZ2tN4BxJIkQ==
X-Google-Smtp-Source: AGHT+IEoSASe6u+iSj7aEsnEzhyctdXyhCqFNTt88TpQA8CG2JhxSLbqy5/IiqosZCl4U/dx5wJQYA==
X-Received: by 2002:a17:903:1210:b0:1c7:245a:7fea with SMTP id
 l16-20020a170903121000b001c7245a7feamr18558667plh.58.1698226378732; 
 Wed, 25 Oct 2023 02:32:58 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 jh10-20020a170903328a00b001c736370245sm8772350plb.54.2023.10.25.02.32.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:32:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v16 14/18] gdbstub: Expose functions to read registers
Date: Wed, 25 Oct 2023 18:31:14 +0900
Message-ID: <20231025093128.33116-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
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

gdb_find_feature() and gdb_find_feature_register() find registers.
gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h | 29 +++++++++++++++++++++++++++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c..12336cb600 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,35 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * gdb_find_feature() - Find a feature associated with a CPU.
+ * @cpu: The CPU associated with the feature.
+ * @name: The feature's name.
+ *
+ * Return: The feature's number.
+ */
+int gdb_find_feature(CPUState *cpu, const char *name);
+
+/**
+ * gdb_find_feature_register() - Find a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @feature: The feature's number returned by gdb_find_feature().
+ * @name: The register's name.
+ *
+ * Return: The register's number.
+ */
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+/**
+ * gdb_read_register() - Read a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the read register will be appended to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * Return: The number of read bytes.
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 7d7d887817..ad62cb3f7a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.42.0


