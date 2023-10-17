Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E77CCBF0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:13:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspTU-0008MT-1u; Tue, 17 Oct 2023 15:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSv-000707-Hu
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:53 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSt-00026A-OY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:53 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5892832f8daso5491189a12.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569850; x=1698174650;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0FE0ZMA+9znH6XCbDgXSH/AnzIDJlT/zVV7CkMNJtw=;
 b=UbvUMc9b/xek5GSjYAXWaFbsmtv/MIuTUpL3HJrs5OTabENWGnvqvtknBzIIP5d+Cm
 EkS5IJlPRq55yeRxO0MH1EHX8tXusKCVcaAjyivnjg+qq6sW4KXAgOeoFHJzdpFBVATA
 JmpE2+XWD/gy+gJODnGvAEJpC0mPKxPDUXacUDCTqYK9fywE4AHpLRhH1ZNEwnGH/3IP
 Ij8e81xBWY6NHsGjv+in7OkBB4cMJeVcxXu97dFeKddDnSBYdweoPkuvsfuvVQKI9ago
 dseebAc7xzpIRgNvuhsKLeioAWfktDCsyssvAhwh/9z/HWl8sJ64M9zGKRMjZBRjYZx3
 uxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569850; x=1698174650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0FE0ZMA+9znH6XCbDgXSH/AnzIDJlT/zVV7CkMNJtw=;
 b=QX93esMVGleicQa8Dkx+d2Va0HtywYuPsv3biZDw4fa9pXL/AX+pUfUGzu8frlCcSt
 qY1ZJ7LClHwNtp08jcOUd8lUY8V1hQaU1KslXGTPcw43EnyhPWCfSQIbOGesacClZuro
 KQd5SZK/BjoSyaqufB4U0213PDowaNrICafI9Vf0lMMMXV/SuSGhcESNgJI6ckvT0KcQ
 KLUDT9PLoqciJdt1FqhvNegN4Y98H/jn6z/yM2v62rSHYMx0eCr6xtkk2hTOCsyEun2/
 sdz6nivbDAwtfM+ztG2ZqH2+0ur9ezvz9qlNArUX5LNgk0cFRPGHrPyGZoep84E5mcv0
 CtAw==
X-Gm-Message-State: AOJu0YxdIIqbpLRN53zJcrReICjpO8sk1fo8xuc2ye6HstHSHrnDQ+uK
 jiGjiG9v4FBBuqCPWyRJK8jF7A==
X-Google-Smtp-Source: AGHT+IG4Ws+tnjgBT3CkAmXBMSPerW49RBHy/2J/GRxSlAzEYoKK+WhEktOGESXYSAyDh4q7CMEY+w==
X-Received: by 2002:a17:90a:ec14:b0:274:dd15:87bf with SMTP id
 l20-20020a17090aec1400b00274dd1587bfmr4043588pjy.20.1697569850129; 
 Tue, 17 Oct 2023 12:10:50 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 nr9-20020a17090b240900b002792b7182dcsm6838490pjb.49.2023.10.17.12.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:10:49 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v13 14/18] gdbstub: Expose functions to read registers
Date: Wed, 18 Oct 2023 04:09:24 +0900
Message-ID: <20231017190931.16211-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
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
 include/exec/gdbstub.h |  5 +++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 229fa382bc..b85f700c5f 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -71,6 +71,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f8c7f427d7..d216353b9f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -484,7 +484,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
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


