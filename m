Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3D79C772
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMV-0001I0-RD; Tue, 12 Sep 2023 02:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMA-0000kl-Rl
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:45 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxM8-0007Wt-Aa
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:42 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-57767b2058cso1089383a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501919; x=1695106719;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn8CX4mhnvAoaMxtFet23WVmn0SlXVQfcTqFqfgAkrg=;
 b=CxGcXoADwVWvMgcpuxQoZxGVhVMkx1W4YqrAXXNmB0Gk5koijWZbnha6tqOoKz8Q3C
 HUuOb36Dm4VALV6xvsVww1lbKQkboIg9uM7cfTkKWU+5oB8WqFaFaKzKFdiaOHR54gM9
 gwCBxvi0Lopapvm8q0rW2p0HnbC+MOp8PG8W/QfzELn9QxK+TQbBnLXOhW+HPf+lxnW2
 /SmR6/rK4rhk/LTgEz+cQZyNZefvzlxK10yNb0xaKCKpOpdgsuDnoNbySb8HjSA9NTiC
 ZE8J+jGXfo8gyuB3ZQw4PbiDea+DVvxk1MxAHY9NnB/EH79w8G+lp5YkxecNvV8DPTUh
 ueBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501919; x=1695106719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn8CX4mhnvAoaMxtFet23WVmn0SlXVQfcTqFqfgAkrg=;
 b=odiAnt7vwcBPDKRZUVbEqoIkWHDADDlsoix5kBUuPR+oCxLCDjvp1CHWrWQuaW2qyy
 L04foI5HSA81Mcb85B4it3G+r9/Mq6CjFJyMPgPYAiQQyBLVGKZmgfktByLzEh4VKJAc
 JB7cTGEspj2K9PbBt6MV+WoKlBubxk6UF9tMPckM9vsAtaF34RJz2ntrI+xPfiaibg+W
 E0Vg2copqe9TpEYYy1OcZAZFI1UzKth1sBetZX/7o61sVIjTYSdd6QCUgTqfUzld/7zU
 oZ/7um7pXJnYI/8PudQqe+F+Rj2rxVb7LQv9OwPSL7U5001ka9EscTCWZi0PPdpDWI+a
 xsKw==
X-Gm-Message-State: AOJu0YxgfvpjR3YOMTaCeTncmjm4YLeYceb3Nh/AdIC20a9ynEoSoa9A
 gicTLaHuPdKqmJA5cSMhS/J5FQ==
X-Google-Smtp-Source: AGHT+IFMCf+fNdIvi+z60eVgXBq9cAFmn0zd+RTFXAkFx4wehH6RabH76HHB/RfBWQVf7UtaSsSmAQ==
X-Received: by 2002:a17:90a:db4a:b0:263:e423:5939 with SMTP id
 u10-20020a17090adb4a00b00263e4235939mr10481477pjx.28.1694501918945; 
 Mon, 11 Sep 2023 23:58:38 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/11] gdbstub: Use g_markup_printf_escaped()
Date: Tue, 12 Sep 2023 15:58:02 +0900
Message-ID: <20230912065811.27796-8-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

g_markup_printf_escaped() is a safer alternative to simple printf() as
it automatically escapes values.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9db4af41c1..a4f2bf3723 100644
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
2.42.0


