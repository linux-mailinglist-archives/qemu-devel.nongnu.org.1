Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7439879DC09
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:43:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4l-0002ew-O8; Tue, 12 Sep 2023 18:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4h-0002dc-Gp
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:39 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4e-0001A2-IN
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bf7423ef3eso46668135ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558495; x=1695163295;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gn8CX4mhnvAoaMxtFet23WVmn0SlXVQfcTqFqfgAkrg=;
 b=OMUCAXSq6aerb+TiWYLYmL7Ox1kSN/legeB8q1R9b2w3rMtknCAzFUwpHeEaXpk+rj
 L2Lnel5j9R09XvF2fWO7b6dwwRlYkpPaMhkgrqMTrUdqCWLAFqMVNszemv0PDUYiyv/8
 vGZTlPAkjOEMAiSMIl+XCRVpW8qryeEu3l1qCcnPFMv8mB3T9MqAEJTU7fdCnGh7RwBc
 j4MF20mmJTtFWSHt17LDNc1ttGbFAvMOPyhDsCvhypmiK1A/V1n9pBp/rjrEPPgIu/yb
 MCWDhFT7OmX2d5l93r1J5Fs3k2zamt6vWVgFqQk8C//MMdyJLiavBQ/9ZddJmQc9HpXE
 pxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558495; x=1695163295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gn8CX4mhnvAoaMxtFet23WVmn0SlXVQfcTqFqfgAkrg=;
 b=l+va7I7VBrMCmcXNiZjjKmGI7kT5AXRbMOD8khwJTv/wZXK85+tOaTjQSG7z/8jZbK
 HtfKI0DpodZ0YTc9/P+NvrOtj/4pJF/5W1E048ReB48yxrN/TARJbh3nNVl5F2vsQQ3X
 S2JlBDaT4WywWFpe79xCk6uAMBGs3Qku/OrqdaPFHOELHaXTNZ6OnlT0ToqOr5Odiby0
 B5V+N8O0ewGe+4XPRREEwjeQJgLTYyC/toM9CQSuw1gfMRqDMtviU2nyP4s2SZ3pkyHD
 vHEBrArex5BPkZM/Ffzk1kkDpnD9rkW+kJmgvBbzo6ezGPmC4bzqE6FfWjODlqKN3biL
 nH2Q==
X-Gm-Message-State: AOJu0YxX6SOcOB00ErX2GqAJyAn0F5Fk+40W1NvoCFDoI6S6MDVTT9Cy
 FOgYt99zEOiNtrKvGOWDI5ayZg==
X-Google-Smtp-Source: AGHT+IGja6aIdv0yGUrDK2hXaSSBZ1pgxLxyVv1dkHY31QL4kmcgGvyPbgibZXbiRQ4f/8yz7AL8Nw==
X-Received: by 2002:a17:902:d34d:b0:1c3:4361:ca1e with SMTP id
 l13-20020a170902d34d00b001c34361ca1emr1155754plk.38.1694558495389; 
 Tue, 12 Sep 2023 15:41:35 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:35 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 08/12] gdbstub: Use g_markup_printf_escaped()
Date: Wed, 13 Sep 2023 07:40:57 +0900
Message-ID: <20230912224107.29669-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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


