Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9DB7C6EE1
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:12:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvOy-0001bC-FS; Thu, 12 Oct 2023 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvOe-0001at-2U
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:06:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvOc-0005A2-Ej
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:06:35 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-278f0f565e2so723985a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697115993; x=1697720793;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=xxm9ErFi5qWt5O2dsqiVTjQ0VuD+hevq+9exCu4ZyRANqRkw8HUZtCpuWMfA17Ql5h
 to4nHWvMOwmivIiiIEcIU/ciaYljSymMOndMKKpSzI/0/8tln2t7+sF8rq0xS+jAXFmA
 9nLOkpkWIVM3QFd+ltb5hlcnEY31hJetr726lOfGCJ1usBjdvbkjlSXkQu/YubVsQuT4
 tQcIepNV/3Mhb70h6h2ASToAevl8W54VDvkJSp8hErKEyN4fOJToJQAO0ossiUsURGRS
 TY0SfDge7pfO9EXiAl2d/yxWx7FsynqQfITzY1oXMEdF1tGUkidffx3xfXPa/HKcXNbx
 5dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697115993; x=1697720793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mL6gDhJilLEOyOjlUN4+yPYr0AIIQV/WDXKhQVSI6e0=;
 b=gebybzmriuQjU4Y+LCstgyOmM95D81YnnNpgNf6D8v2++CWpn2nx5uHL8JhyHBz6NZ
 XP+IrOaVJi3EZvTxpCdZw+RE027JSpsd0m5ahqxxnNLNcubYpExxiLHfDnw5zb8MQrEr
 hOZkLOXMMphSQyANqQep4t6hEIpH0re1nVSE/JDs6G8Zfsyu1HvstfFBir2XOLGcMD0E
 8an1X85Kw13GRaoI3RxgtYuYqHWvqv6FVDW2jJKbgNatBKc2Y8QdKCtdrGtGMOL34KCd
 Rtq0nGQYd0C4h1wamw9PXXaYHasAZ1crPaiSWLnVGUaG0DV+i9++q0vHdqa7o8kVoDW8
 IhPw==
X-Gm-Message-State: AOJu0YwYt8rUhJOUD8TcwytXCDEotCvbRCC/tAites9gN/w14gFlNcXr
 RtISKBiz885EdOBKUOhGZKFwdQ==
X-Google-Smtp-Source: AGHT+IF+44+6o1f66tK24bkCl1zxB/Ir+Ph/DlUi0unX0/pBhzMsX/wquKKHb7L9db4K1D3C/YMCeQ==
X-Received: by 2002:a17:90a:ce8e:b0:27c:e6cf:fe8c with SMTP id
 g14-20020a17090ace8e00b0027ce6cffe8cmr7640430pju.44.1697115992848; 
 Thu, 12 Oct 2023 06:06:32 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 cm20-20020a17090afa1400b00263154aab24sm1775434pjb.57.2023.10.12.06.06.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:06:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v11 02/18] gdbstub: Introduce gdb_find_static_feature()
Date: Thu, 12 Oct 2023 22:05:56 +0900
Message-ID: <20231012130616.7941-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
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


