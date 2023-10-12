Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E007C64E2
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoZe-0001im-8h; Thu, 12 Oct 2023 01:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoZb-0001iY-Ht
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoZa-000704-0Z
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:27 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6969b391791so470006b3a.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089763; x=1697694563;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=1qFpSSF9+odl0DEsaLXVRREyH9nB31uiP2YDkF99dBR+Dl+KsjiyA2+j7iuRCLstpO
 2IwVY5ECxosdShc0D3EhwVOVgKTbY5goyEIl2NzvWVe8qJOoqHda/ORHBDbYfNuCPBTa
 AEcmkNhN55VTVu5jW/oFl7OFpGXjVb4SljJXBSvo70but0l38+BTcknvd2KUCV4zDG3o
 cNuGrEnFIlUxAaieahMdU0iA4PtFi31wEEpLiSDFUFJZahEE6b67tBAdoV2G5Ein9fmI
 WRZEHow65ccl053kG6EOzpA+7SXBQaJhxdZG4OqdqbZ6fhL9i+WhWJojINnZ8capqNB9
 j9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089763; x=1697694563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=ooehO27toUeqJQ9qddg0YsHCLKtNggBy9ajVl32lfb9xgbJXYDAqxjyMAzMM0arhVw
 LB2fhNXgV8cOOBk5mnBwvVRh9iyFxmajNRRX4NLtHXi10BsV6NTILh5Bh5mUaoDwrLMm
 4SQDx7IAZgiD0dLSS3ZnFSHqP3G3FMgL0btmXsOQ/GIVx48/GFBe+JPbD/h4+Atj7hwW
 kLARERtpGjidM15R4DJmdus5AZIdHDSvhdq1xWlnmXDQ6sgvT2O2bqTuWegD7KIFHSpF
 B+QaKhggWrahbJ+ZB4ksxd0ewIDXYUgyjrgY/py4okvlWJqBnvuzMqb77oHI8pxrevY8
 SRBQ==
X-Gm-Message-State: AOJu0Yz09gHyNfIgzQjZppdcQkBn88K2JIGUU428fqOhwCs6QwRjh3pt
 Qs52NTWXW+gKrJxVbM3UiN5rmg==
X-Google-Smtp-Source: AGHT+IH2V+KR30B5MxlNdmqV3wpyeKD4KDP1+zVo1qCBJzAlDhTySHdPHzmtiWPSb0MadHBA6pFoeg==
X-Received: by 2002:a05:6a00:2316:b0:690:c5cf:91f5 with SMTP id
 h22-20020a056a00231600b00690c5cf91f5mr24825569pfh.18.1697089763470; 
 Wed, 11 Oct 2023 22:49:23 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 c12-20020aa78e0c000000b006933866fd21sm11096311pfr.117.2023.10.11.22.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:49:23 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v10 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Thu, 12 Oct 2023 14:48:41 +0900
Message-ID: <20231012054902.38447-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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
 include/exec/gdbstub.h |  2 ++
 gdbstub/gdbstub.c      | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index a43aa34dad..071021415a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -44,6 +44,8 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index b1532118d1..44c9167542 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -420,6 +420,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
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


