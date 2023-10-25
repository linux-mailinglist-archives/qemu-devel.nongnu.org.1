Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A47D66DC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:33:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaFH-0002Fy-CN; Wed, 25 Oct 2023 05:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaEv-0001mc-Jp
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:50 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvaEu-0002Bi-1b
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:31:49 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so3543829a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698226307; x=1698831107;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmquHc4fVmtSSJQpb3DzKUGsBKKZi/AhuKxsiBAYgxY=;
 b=NGsX15M9dkjKgLloypgWesCYGZCLwtN89250LHovMft2fFiFF2H+RS8DOFtvcNQQmu
 9TZ8QA01MH/Q7R8uFmKcy22y8bj6jErchyppIiQn5qqVVVnbC+l+eos9VX5Mdj7gBLV5
 JsW4S+PGqvCLo0VDUFGexRDeo0IPqut1rEX3RdxEDMXVXEW1VtZOuNLMmtaG8QQiOo0O
 necLZ/Txg4TddFmESBTcblBpJsHQyU4srjwHuY8cJqky3D7+CgFbrN6ESmRFdEN8MCDW
 mZFYOKAxrJvxAd0Y4DigIArXz8nRdW44zsWoWpNghDyY4nV4lXMTfiF0MH9HKqo5E5k5
 Pe1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698226307; x=1698831107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmquHc4fVmtSSJQpb3DzKUGsBKKZi/AhuKxsiBAYgxY=;
 b=uWe+eKqT4qrn2scTSzm2e+beAEX8rAz53m5P47hmIKD6kLirf037D870XE//3fcv+1
 21NTLNbxLxC4U4lbc4yxipEjD0j7AWMV9I/Qk5szcjqOlL74vi9pTbRLBRv3niLMN1y4
 i3e71SVULXfvVaY7voBHlCKN5VQ5IJmtgpH6OvYjreI+iDXGKN74qcfJwvjFxqwmqFnD
 uyI+tsa/thl8Ycm9UIU3l6n8GiTSzztEJE3JF5GpKScEbOPd6hcSmTPjD1ZYjeR0NHV/
 v45z8HJKNlYuYMR7E83SBg00Hcfw7zOSp1hFpFztfUOURr9br9nkOOdQYjmNzQsEJtVY
 MgsQ==
X-Gm-Message-State: AOJu0Yx4HUQjRf27ogpGRPI5fauw+ysbgNLSK706iN7jebVy9nH0z2lo
 CszOgTGb0ntTSgGWabEUriMwjw==
X-Google-Smtp-Source: AGHT+IE0wPq2K7X9cDn3TwEEUJLfzCVu35dJusX3AIf7qe8wUpVTwrGTllakO6HJE6ofnEvK0j4B6Q==
X-Received: by 2002:a17:90a:4985:b0:27d:7666:9596 with SMTP id
 d5-20020a17090a498500b0027d76669596mr11593294pjh.11.1698226306832; 
 Wed, 25 Oct 2023 02:31:46 -0700 (PDT)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 b12-20020a17090acc0c00b0027d12b1e29dsm10103577pju.25.2023.10.25.02.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:31:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v16 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Wed, 25 Oct 2023 18:31:02 +0900
Message-ID: <20231025093128.33116-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025093128.33116-1-akihiko.odaki@daynix.com>
References: <20231025093128.33116-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::534;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x534.google.com
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


