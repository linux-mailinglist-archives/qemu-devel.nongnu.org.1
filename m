Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACC790ADC
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfHL-0002hK-Lf; Sun, 03 Sep 2023 01:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfH5-0002eQ-61
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfH3-0001fN-1f
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:03:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso191420b3a.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717427; x=1694322227;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lw7Jjevm76t1b4aaQ2RV2BTXISRyyjv5BLiurbwW13k=;
 b=z0LumQVFzA++yNZv1BKX+JG1nnh0SYMVGTsONWVixF33ax2rzLJqMb+igvJDdSQdsG
 JtyCMmHMqu7prZKo58+HFd8NdLHtjbV+9TmKV7lK+Lda3uuloeNga1HMiBaxQreIB5IG
 uq6ZfliZVAZ1lZkUN7RWe5F6lIGTRdo8ZfQ3Oo+74UZhBZ5ElK/zjVHE71QWYrZac83i
 aTMNf4m98r+E0HGWjLv3CBcZxjoUFvcSNlPmGgZC7s4rMhNtjUaJdDmn5X4WtD1NdLmQ
 C0ZGsZUrohWiyg4/94FIrnZkna3wC1AQwA49qjXaqGRVBfU0cHFdcbw0iXXTzk3rAPkS
 pmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717427; x=1694322227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lw7Jjevm76t1b4aaQ2RV2BTXISRyyjv5BLiurbwW13k=;
 b=eaHXxVdZcrUMo/sFBErjPecyslnFgIJeCWgtPC0xMKOn1/jn9WIRzD3XC1jXuulGX+
 O7wOfSe3zstDpKQo0ghP3mJGmOpqPr15EnLoYZ6/gLKyHY3or7kZk4Gu77EDVe4+MIfV
 mblgeMw7JeDBfXumDDdwtRkZURGRueKS9razUywqRS8GB2O60/bp63YrbLZqjUSsx60j
 Zg0wAcpuTRm7NnEUfY1eBw8rHsvYuTTS7Wc+hlrMmgFm1Qbeu1Ay9DLPkgoB5N3DrPyV
 OjQGZrP56y9q5cuY2JQZEZsgDM0jCe+f8SP2SNRwaCONLJIk2Q6RRO+uXsvivFM10L+0
 HzEw==
X-Gm-Message-State: AOJu0YywzNaP7HAHUWtrREp/m84jrOCBCC7oQ3ZqaWdCpMq3bfRYN0Eq
 CQZVRmyLtY7DNNC/LuzmnGHHmg==
X-Google-Smtp-Source: AGHT+IFkcssti6m3qr6YNcadbMCspN4TS2ZxMk/fFoyfdY2HTfuY2yqwM4uHuE5c3x+q3hA6+Bj+xQ==
X-Received: by 2002:a05:6a20:3cab:b0:131:1943:c858 with SMTP id
 b43-20020a056a203cab00b001311943c858mr7118905pzj.14.1693717427732; 
 Sat, 02 Sep 2023 22:03:47 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:03:47 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Sun,  3 Sep 2023 14:03:10 +0900
Message-ID: <20230903050338.35256-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
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
index 7dc097fcf6..3091e7a706 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -34,6 +34,8 @@ void gdb_register_coprocessor(CPUState *cpu,
  */
 int gdbserver_start(const char *port_or_device);
 
+const GDBFeature *gdb_find_static_feature(const char *xmlname);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 61c811f42b..a03d9baa12 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -414,6 +414,19 @@ static const char *get_feature_xml(const char *p, const char **newp,
     return name ? gdb_static_features[i].xml : NULL;
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


