Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9667E41D5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0O-0004Xo-F1; Tue, 07 Nov 2023 09:24:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzv-0004EG-Q8
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:08 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0Mzt-0007Zq-3Q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4084de32db5so49506185e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367043; x=1699971843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCUM1KTtV0lNE+xPv3unN8jBYCV0t3kSWslOuRVU4wE=;
 b=Bh2YMPwMJ9VvykRZuhJmijisaurKqngaibw903L0mlBYmKvSkBjX4iRdEsW7H56s8W
 e0qwSDwT2oLXz13nUOGTKOPqUleR6PnUgCp3hH3K2ZgBvN4nm8UWZR9zAzbMdSuCSF5T
 1/+cl+9MR1FI15gV+Zeia3LDVtwwgkuOnHS9RZcq534q1IUKvw6/A1o77/0kkyxRJH9Z
 LtivUpUCe/zkJsYbQZVhu/DE296jNxsKadj3RXuMxRdrKQ6Zwb4QKCFuejlpzLt9Vry7
 nnf3kY1TuCYrZJMF+JKkyoydXUNwuWFgDdUacM06lO6RPvPt86QMYOx6DlJZ7FN32kLR
 2wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367043; x=1699971843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCUM1KTtV0lNE+xPv3unN8jBYCV0t3kSWslOuRVU4wE=;
 b=ltdjqQmTCJoNxqvgcOTRFvxIj1G0FHZ0Y8+zss3SlP5FSrpZXKhI1T05q/LkiQFHHA
 bNf5pb7L/pQAC8iW8kXzZBPVNvV/WUYi2OPVWUQNlTw0scm/ufRMlP2SdPXUXnJYNNJn
 DFqIli6REzE1ikaTMCUmNs7bbhISvJfsAkHuR50iHqsqTgCA7Vp16FfHCZXtdB0eEkBe
 3tLxL4+lNFPoVRxfCE/oywp89Qri5KasyDFaxcVQV7hynzpr5f0yw9/P1JIa/gH1Nqh+
 2heWDTi+bPa0jSc0aq51Wvnxavaa1MN6SDyd/yNvmdDXCeXsRLkRc8Vpvf/I22ndRAQ5
 tKcA==
X-Gm-Message-State: AOJu0Yz/n092WJJGNb1HtrMysRwp+Yl17fjgkTi+SHkTEhKXdMKZis8M
 I8BvD3ahcKPYl0qUAu0gwWWoog==
X-Google-Smtp-Source: AGHT+IGNGzOHaSt6b31r5NrSrgouRNywPuUkZrufKsro3l21Cc0nuWH8a7g5Rn6/ePcjI3rCNcThDw==
X-Received: by 2002:a7b:c5cc:0:b0:404:4b6f:d705 with SMTP id
 n12-20020a7bc5cc000000b004044b6fd705mr2484239wmk.17.1699367043500; 
 Tue, 07 Nov 2023 06:24:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 e22-20020a05600c109600b0040523bef620sm6709710wmd.0.2023.11.07.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:23:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E4466575F;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 09/23] gdbstub: Introduce gdb_find_static_feature()
Date: Tue,  7 Nov 2023 14:23:40 +0000
Message-Id: <20231107142354.3151266-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This function is useful to determine the number of registers exposed to
GDB from the XML name.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231025093128.33116-3-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231106185112.2755262-10-alex.bennee@linaro.org>

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
2.39.2


