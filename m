Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A8B7D611F
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWR2-0003yt-Kc; Wed, 25 Oct 2023 01:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWQy-0003we-Bq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:01 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWQw-0000yB-Pm
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:00 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3967744a12.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211677; x=1698816477;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmquHc4fVmtSSJQpb3DzKUGsBKKZi/AhuKxsiBAYgxY=;
 b=Rmizg1AdjHIGRysfS3kGhEQEL2uUym/KZUkPQpxmlxpHW+aQ5xpM4DEOsTEQ1XYDi8
 B5WEGaMs+sfF5GxWOLy/Zu+7ibc5lZbvFLGRzQm5wfso36/Op9L7VtKk7XS7Wr51EkkN
 wyTdJ1NOTKNMkVkSXWRy9I2Y47ULvvTbSGLPzqL1QQqUmLA8kaA3BvlVliOpnmRL15t7
 2raOUhMxWECL4b07nVcG2F/fEQj1IoWATz5oN2ambtlKBPzyBSXFC9+gjn2X1Cuwrpx8
 U7aRf+vUx5rlVhdqACk6CKOK6zK7TM6P6BT2qL3Y38FRbC4MPSw3rBkwllvKeGOQffkV
 FFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211677; x=1698816477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmquHc4fVmtSSJQpb3DzKUGsBKKZi/AhuKxsiBAYgxY=;
 b=pFhim4/i3isu7diVo0kgOm6cNOCLje0ivOj8xRDAdzQtQEFLSNAYOR14yOkBn/MBqm
 gVL60aLfDARhOmWOqDNRDRbgq4TPnYTauFLAcxG+x4CIUA4/q/uXQdA4NNdouzzzk7SD
 ShsEBuF0kMdejTsdfnZ0Jnlgfh5ptX9z8sRN7YZgboRqammaa1pOBZ5Ift+pFooL9rcL
 ayxZOx/5rqQ2qZqwr1stEv7Czo/8BSDsfGKFGH2rLRSUuUo5tpp3Pi4JDHBMl6YhKxLR
 iHI5wAAtLHVnKckStdaGi15u1wuKos3KYbsIqW2HfDjSasyr5f/GUzZtukHdkyv8cYwn
 omuA==
X-Gm-Message-State: AOJu0YzXeZSodRI2VYuz2XVyPKfJc45T/bK8+w5nEcl4bmnq3P4gOfkG
 ExCBz/xMYoNopJoeNaUpa1r/ug==
X-Google-Smtp-Source: AGHT+IEUWk6QPlXr4RKAxd5YvNwdrr7COjlT+5JV/VPzAjezg6v7JHWjDD3MnjrOJx0UcNLxorZazw==
X-Received: by 2002:a05:6a20:7f8d:b0:161:7a0c:3c37 with SMTP id
 d13-20020a056a207f8d00b001617a0c3c37mr5837588pzj.5.1698211677267; 
 Tue, 24 Oct 2023 22:27:57 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 d18-20020a17090ad3d200b0027d219d3ac6sm9952974pjw.47.2023.10.24.22.27.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:27:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v15 02/19] gdbstub: Introduce gdb_find_static_feature()
Date: Wed, 25 Oct 2023 14:27:24 +0900
Message-ID: <20231025052744.20697-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
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

This function is useful to determine the number of registers exposed to
GDB from the XML name.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/gdbstub.h |  8 ++++++++
 gdbstub/gdbstub.c      | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index a43aa34dad..7fe00506c7 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -44,6 +44,14 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+/**
+ * gdb_find_static_feature() - Find a static feature.
+ * @xmlname: The name of the XML.
+ *
+ * Return: The static feature.
+ */
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 29540a0284..ae24c4848f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -422,6 +422,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return NULL;
 }
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname)
+{
+    const GDBFeature *feature;
+
+    for (feature = gdb_static_features; feature->xmlname; feature++) {
+        if (!strcmp(feature->xmlname, xmlname)) {
+            return feature;
+        }
+    }
+
+    g_assert_not_reached();
+}
+
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-- 
2.42.0


