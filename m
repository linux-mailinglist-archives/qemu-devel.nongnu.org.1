Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED49E7BE6EA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptPZ-0005DB-DU; Mon, 09 Oct 2023 12:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptP3-0003E0-CY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:55 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qptOk-0003Xo-Ok
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:46:44 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso47937655e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 09:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696869975; x=1697474775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaWzj6TOawybEbZLkphNAwpwFijNfIuoCtyzRhLAt7Q=;
 b=iUI60xtkpw4burOise8ES76WJJV8hA6xDxAUAOYqoU+c8QvQ5+rtCCs4EK3LLNuySq
 0+nm6B+BzUJjWsl1h0sd2BVoJtKGxVHIGjx+U+llU3plLwYkWJMsu0V4wCzkgzyzvXN6
 +xzCukTAl9lUJizcmsquB9DJbaVJaHYDgXIK9ZdT4pwMrgoZsCDD9yilqG7MYjYmnHSy
 FRCP9j50egevjdHC5oMMiQ4rXgtFr7ad1MTC7vB2vXWZZNPkjRh+tsME7oXj5yepvQA1
 FycO1jWkfYlO4jRqE99F7Anz9+fUJcwS01XbtY/N49Fb+RQLdbtayAx2xzZJFmLOmkGb
 +I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696869975; x=1697474775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaWzj6TOawybEbZLkphNAwpwFijNfIuoCtyzRhLAt7Q=;
 b=axRWjrkdzc1n8MUSmIfXc9A1RO4evti6gExgPrgvfqH6mh7wH86TkNgLzBwkkYLINJ
 yU8qh+2kHZ5ZrYtlNkYVqDnLzW1WAfu2kBBsl11Ak4YqU06Sf6ForWJXX5vMQPByd2IZ
 FSzaTXIqmjGYmCkYZsXMwWSb8PkzfQdJlk50oCoMVzWEpBkyF9U9iW7tszhQYhxKY12R
 Y4ffZ22fXH9/a5saZtpwAl8VOhz1nDK9wcd4p2QGDyb2L2o/i0Gv+oz28WdCKtNtWFc3
 zTfg7dDKKWyctGXKFdpkYWuGFq4WIBhg6NHZkZ0WHJ04NHm8hczAJL3j/pBKppZt1MNo
 XSKQ==
X-Gm-Message-State: AOJu0YzcgLXJ+Gc49myj1b1koExjHw/2xPjAy0rlWA1Uv7L+Yfr3cv1+
 THDx1h4TAeJL7vV23XIDx/gapQ==
X-Google-Smtp-Source: AGHT+IFV54SZNsdcdbrjjQOtqZjj6ZFdvv1SUKNKVCOYz2G/PhmdkpaAKFWxA1tkw59KreqSPGkI+g==
X-Received: by 2002:a05:600c:2298:b0:3fb:a100:2581 with SMTP id
 24-20020a05600c229800b003fba1002581mr14279362wmf.14.1696869975132; 
 Mon, 09 Oct 2023 09:46:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a05600c219800b004013797efb6sm13936639wme.9.2023.10.09.09.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 09:46:13 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9CD81FFC7;
 Mon,  9 Oct 2023 17:41:06 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Brad Smith <brad@comstyle.com>, Radoslaw Biernacki <rad@semihalf.com>,
 David Hildenbrand <david@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Nicholas Piggin <npiggin@gmail.com>,
 Bin Meng <bin.meng@windriver.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 John Snow <jsnow@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 15/25] gdbstub: Use g_markup_printf_escaped()
Date: Mon,  9 Oct 2023 17:40:54 +0100
Message-Id: <20231009164104.369749-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164104.369749-1-alex.bennee@linaro.org>
References: <20231009164104.369749-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

g_markup_printf_escaped() is a safer alternative to simple printf() as
it automatically escapes values.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-9-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index a20169c27b..3dc847f835 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -373,28 +373,34 @@ static const char *get_feature_xml(const char *p, const char **newp,
     if (strncmp(p, "target.xml", len) == 0) {
         if (!process->target_xml) {
             GDBRegisterState *r;
-            GString *xml = g_string_new("<?xml version=\"1.0\"?>");
+            g_autoptr(GPtrArray) xml = g_ptr_array_new_with_free_func(g_free);
 
-            g_string_append(xml,
-                            "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
-                            "<target>");
+            g_ptr_array_add(
+                xml,
+                g_strdup("<?xml version=\"1.0\"?>"
+                         "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
+                         "<target>"));
 
             if (cc->gdb_arch_name) {
-                g_string_append_printf(xml,
-                                       "<architecture>%s</architecture>",
-                                       cc->gdb_arch_name(cpu));
+                g_ptr_array_add(
+                    xml,
+                    g_markup_printf_escaped("<architecture>%s</architecture>",
+                                            cc->gdb_arch_name(cpu)));
             }
-            g_string_append(xml, "<xi:include href=\"");
-            g_string_append(xml, cc->gdb_core_xml_file);
-            g_string_append(xml, "\"/>");
+            g_ptr_array_add(
+                xml,
+                g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                        cc->gdb_core_xml_file));
             for (r = cpu->gdb_regs; r; r = r->next) {
-                g_string_append(xml, "<xi:include href=\"");
-                g_string_append(xml, r->xml);
-                g_string_append(xml, "\"/>");
+                g_ptr_array_add(
+                    xml,
+                    g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                            r->xml));
             }
-            g_string_append(xml, "</target>");
+            g_ptr_array_add(xml, g_strdup("</target>"));
+            g_ptr_array_add(xml, NULL);
 
-            process->target_xml = g_string_free(xml, false);
+            process->target_xml = g_strjoinv(NULL, (void *)xml->pdata);
         }
         return process->target_xml;
     }
-- 
2.39.2


