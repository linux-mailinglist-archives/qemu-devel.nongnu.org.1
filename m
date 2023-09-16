Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB837A2E82
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQGL-0003IS-9M; Sat, 16 Sep 2023 04:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGJ-0003I9-FO
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:43 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGH-000613-Fr
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:02:43 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9ddso2422927b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694851358; x=1695456158;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Is0bjJtCP1Idi9BRAvC0U7JHxowGP/S7yosEU5rXTI=;
 b=2oeufpc16qpzrwJV50y7Ie2O0NXlfFfWJRspqZAWAy7iklbEsvIAHJDD85obu5xJgP
 K6yMv/Om8D5ltjcYZd3W5qKNcxPAjlZM9c3EdbG+XbTW0cFuBGLhQzYZGaWodT+blSGI
 tvbjgGS5J1FlDiuLnIsVIpDVmxX+E3iAPkpUby8gIfJ1fRmg4wWSoErdtGSILMc/PHzH
 OvddjbgqBGPEzo6hk3T6yINXdJfXAZEIAx3yYjaGaA24sLRVufU2U+daWBLN4NV9uYHc
 fbj4/5U+76iOum3qE0SjwRewHiAHrgp0MEyb+rg7pbzjbD3oScfbOz++wqAb8+/0slpy
 1uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694851358; x=1695456158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Is0bjJtCP1Idi9BRAvC0U7JHxowGP/S7yosEU5rXTI=;
 b=bTanDnRRUNCxynEQHmMaiQIM+V/sZHkGG173o1gxXKekA8LyD34zAeFdByHJOtwb10
 hIJYyFcGt4aCJ/vkb3PhM26SwgaoqavWkufhur5fwlv92vRe62ersB/SQpLF0nHYV95w
 rAarfZTGsTNgMxAMu28mjV6nbLedzKk6UHlSg4wczmPiVPqOpGmc9Q+Ljk2FGnicS+n1
 FChp25Hm3gAb/BqxtgCtc1LSQIMxHv6HN/VJc5vOJlOO6OndJpONH9MJ37R0X+u8EAph
 etZ3POT3SB/verNj/lfYJDprh6B6yCeir/Vxjyi+GO6K35zmVKhmWkBrosyB/k1XoEFu
 5ZMg==
X-Gm-Message-State: AOJu0YxQcmr5n61QIdhT8TI8bOe7Zu/k1gMOpyP7jPzFpiV3+KZtP9w3
 5EFO/4iUI3xjHY+XK33U8n8hIA==
X-Google-Smtp-Source: AGHT+IGZCZPNUBKwAaNwWj80WXb/lVnGh8iioHv/3Z5uBZsGfpWRqXtfoG8FPMKaUSLqzBIaojGC8A==
X-Received: by 2002:aa7:88d6:0:b0:68e:4653:2a2b with SMTP id
 k22-20020aa788d6000000b0068e46532a2bmr4349083pff.24.1694851357943; 
 Sat, 16 Sep 2023 01:02:37 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0068a46cd4120sm4029484pfa.199.2023.09.16.01.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:02:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 08/19] gdbstub: Use GDBFeature for GDBRegisterState
Date: Sat, 16 Sep 2023 17:01:25 +0900
Message-ID: <20230916080149.129989-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916080149.129989-1-akihiko.odaki@daynix.com>
References: <20230916080149.129989-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
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

Simplify GDBRegisterState by replacing num_regs and xml members with
one member that points to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 61783ffa48..b3f6f0dd2d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -47,10 +47,9 @@
 
 typedef struct GDBRegisterState {
     int base_reg;
-    int num_regs;
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
-    const char *xml;
+    const GDBFeature *feature;
 } GDBRegisterState;
 
 GDBState gdbserver_state;
@@ -390,7 +389,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                 g_ptr_array_add(
                     xml,
                     g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                            r->xml));
+                                            r->feature->xmlname));
             }
             g_ptr_array_add(xml, g_strdup("</target>"));
             g_ptr_array_add(xml, NULL);
@@ -504,7 +503,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
         r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->get_reg(env, buf, reg - r->base_reg);
         }
     }
@@ -523,7 +522,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 
     for (guint i = 0; i < cpu->gdb_regs->len; i++) {
         r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->set_reg(env, mem_buf, reg - r->base_reg);
         }
     }
@@ -541,7 +540,7 @@ void gdb_register_coprocessor(CPUState *cpu,
         for (i = 0; i < cpu->gdb_regs->len; i++) {
             /* Check for duplicates.  */
             s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (strcmp(s->xml, feature->xmlname) == 0)
+            if (s->feature == feature)
                 return;
         }
     } else {
@@ -552,10 +551,9 @@ void gdb_register_coprocessor(CPUState *cpu,
     g_array_set_size(cpu->gdb_regs, i + 1);
     s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
     s->base_reg = cpu->gdb_num_regs;
-    s->num_regs = feature->num_regs;
     s->get_reg = get_reg;
     s->set_reg = set_reg;
-    s->xml = feature->xml;
+    s->feature = feature;
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += feature->num_regs;
-- 
2.42.0


