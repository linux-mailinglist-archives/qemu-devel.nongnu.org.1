Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8657E2C5B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:52:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04h9-00068v-LD; Mon, 06 Nov 2023 13:51:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04h4-000642-CA
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:26 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r04gz-0000yo-Lg
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:51:26 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5720a321aso64224871fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296679; x=1699901479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKIvEGRPtMkzzApfKX598M5fxDLEODeKT+ruNJk2aYQ=;
 b=QdzrJI+2tPBFPphVtIQeFt1woYqlXwxbcZOJ2wMIszE7gJnUpe9OGI0iGWM2XrLl17
 HadXkbgwmnAG0jEBP1+EvDCxZEhy8RaTmvtpx4IK2kt15SiuSTlMEgMZxUDsuvO+O8iH
 7sppZ0lzRh7cCxrpqoc8CbIMoxmF9YabwgyNj/4EOEgO2UiaenUThZuUBUSdwk+izUMP
 k0zSDuyc6g1Fk+ymcqP+hNRraABelNld3uNr0zpdib3p8CA2VrhvT0kZT4nGx9dz5aY9
 uiDNs/hXjZKUh2uYwMCjnkMZyPoQdotohQDvhc65q+URMdTKuzWQ8bdkPPkhoq/4i4og
 nbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296679; x=1699901479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKIvEGRPtMkzzApfKX598M5fxDLEODeKT+ruNJk2aYQ=;
 b=lYP9oSVsCYHOgVDg/M+fkYaD/RbY6jNtugFdqYYwUnNt5h+aHjmfYl+xuDpnLOjra8
 9y3UybMKhb0SZtCu90HXAu6md4QI0FJpjXf4WjsU47I7STEDWk7ErEuvz/WCpFG6YsRl
 NztQcT9oKdblVuDuzPHkgV7jsymizrNxAtrcEk81t4m3mgoTFlI9kYx1V8VndAvikyQr
 IEuk+p3kk6ZcDG9NQhl3yORjxDDOAoUztbHDcOsDPc8nKv3mm+nJHyeAA+drpABt5NC6
 LmWTERxBAhg/I1xzPvnGGsrHe0jLOEDdkkFHedFeGVqqqPyX3DadGU3mSn2OYbNkXLkA
 epcg==
X-Gm-Message-State: AOJu0Yw46wM5M+7OO5EQq+DalTKlRhuSgXRrkPJ42i7U+biQ9mdWuP4I
 8F8NC6G306MARAis2dqOOKcdWQ==
X-Google-Smtp-Source: AGHT+IHQSMlfAEVt1Xby1/uh2es9ZmyRNcThXTqLneWJ54cmT/apOr73Ixb+NfKnzTnzg4nRRvTxPg==
X-Received: by 2002:a05:651c:1249:b0:2c4:feef:852 with SMTP id
 h9-20020a05651c124900b002c4feef0852mr22669392ljh.32.1699296679715; 
 Mon, 06 Nov 2023 10:51:19 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q24-20020a7bce98000000b0040648217f4fsm12793752wmj.39.2023.11.06.10.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 10:51:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 465616575C;
 Mon,  6 Nov 2023 18:51:13 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 09/22] gdbstub: Introduce gdb_find_static_feature()
Date: Mon,  6 Nov 2023 18:50:59 +0000
Message-Id: <20231106185112.2755262-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231106185112.2755262-1-alex.bennee@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Message-Id: <20231103195956.1998255-10-alex.bennee@linaro.org>
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
2.39.2


