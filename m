Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC157C4B3E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTGK-0007Ub-Bz; Wed, 11 Oct 2023 03:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTGH-0007RS-Vx
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:04:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTGG-0005kR-FQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:04:05 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c60f1a2652so5442425ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007843; x=1697612643;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=fwKiUt27NXmR0GzYVCEe4Z9INqet7aZD+qgAmdTtXk2o8N8hqBQtDF9YEagGBbod8S
 xAm5/zVzbmv6XED62AgOw9BVbec3QYcfisDbL4gOEnA4F2DAUx+MBj2farqV7xfbpEzG
 bo503PVM9y+yT3eAwL8VWxHiwc+tHRh7fvOuRMRMeo0GFVArt0FS6x25LaevbrY0FC5X
 lavAdVo2suXJB1TZd8uAJfJQWj3unVyYDIY9z/x9aXBKL/mMsOjGtKntNfgJQS2my3vk
 u7KAAoRMK/FVu3QLjJxBPLUZWT4kgnbnYDBrWc5CnqVXeTgv5aHFZg6kXcaUKr1GlxrZ
 sO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007843; x=1697612643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=KH6ATyoxAZwDxv9Axt2DfXiQTremSYNhUSnUwLX6/KAQJe8Ke1C9T0UXZ4ljsmMIsr
 4OLLJERlRp2mpRzik5oNSdBUCOd3PVK1Fw4C/+V5hzs0QWUXTB/KHBCzabJQ1+PDUPbd
 pYuYm7s2RAknmRwe7GmXCw4Gqh8kc1PKvWMsY7uuenUKZMYWPPZ/0MqMgwUHoUisKARI
 ONG9egYiPGrRF1uFOZ+DBSknX5s0BWisHaJnYP0TatcYHkk1bsNPqxh52RCMRo8bfVLm
 SqmUbjQ0c39Vafk8KHfFZczuPwxHxIRM4DgcxYBAXVoYlLBjwpbxBZdeYA36FMHgj8Pl
 BfNg==
X-Gm-Message-State: AOJu0Yxx3+9modc6E/HqdMaNlVv6xE2jgt1FVhyuJi3iub9/rY15vJgr
 U/Qjs3SfMu+OW7D9+ugEhokeZA==
X-Google-Smtp-Source: AGHT+IHVkJ0yZ8uB7L4rnpKzWOhuL+sESL7XKniTz0ZQXJSNKSsZFJfZtPJZmp31B/1pThxAMz7HCg==
X-Received: by 2002:a17:902:d2c9:b0:1c6:d0a:cf01 with SMTP id
 n9-20020a170902d2c900b001c60d0acf01mr25339263plc.11.1697007843269; 
 Wed, 11 Oct 2023 00:04:03 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 x20-20020a170902ea9400b001c5076ae6absm12959047plb.126.2023.10.11.00.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:04:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 05/23] gdbstub: Introduce gdb_find_static_feature()
Date: Wed, 11 Oct 2023 16:02:51 +0900
Message-ID: <20231011070335.14398-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


