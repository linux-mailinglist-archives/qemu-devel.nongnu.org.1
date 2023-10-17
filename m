Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D17CCBDB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 21:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspSq-00068d-RF; Tue, 17 Oct 2023 15:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSO-0005iZ-KX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:25 -0400
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspSK-0001rw-8L
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 15:10:20 -0400
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3575c10421aso23026135ab.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697569815; x=1698174615;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWdQ6aLWe6UH15pXNv0GlBymb4HpIAegdj+DNQlxeF0=;
 b=ZcbDGhp2sl+h+YEt3oHFMTjFJlSwLNt77j8ivi1AyPTB07nwVaMKrWGn4Iw9gORh+T
 eHEOlTmWuizElk8VQJ6EQglQVKOGHnEvVhS+lMwgNdFugJQPzoh8Dslui0SCKBxkwX0v
 i3pLiRb2PzPLJoUQNraYz0RM0Nyu4xkvW8ZHgGJdDJ7XabWcH9tY6TETiEd6Y4+5lA+H
 qXJOOJEf+mBfIES7EOFvuUtlSQZWpwD/UQG1IuJoihD21jur5GtHbKpJ9Fmnech+9Sit
 gZQ0qGP3MZXsJ+4eDnLQSCTePJDusVXKmy6a3xIv788TJ4NGVVbfguhVXT6e7NOXzQUq
 MAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697569815; x=1698174615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DWdQ6aLWe6UH15pXNv0GlBymb4HpIAegdj+DNQlxeF0=;
 b=V+5LIcEBV8tBLAFZlHyh2KSpawSoT5PJa/b5NQVDxuKTFH7TW8lUZqePiaYgjZ9IJC
 KsnHs2Yyr78SLE8nZyawoS6AZopKguo5/2pZEqXlbNcZebIDS+Y1UFpe3HH6JoowJYW/
 SURnxXUOaoSBa3LasCQpPRlYx2QEqjUYSchODLgSARFhd5foFa1G5egFAmi9/PnaLaC9
 5N6Cz2a3xp9AnToCmks6Y0Xd5MWngMjucZTp46nDJCQC2GmKnu2L7zwmbW029BnmHJs+
 DBRfCWAwCYYRYz6148mJa7DX82LZ5PFeMIZqT7EqT8TU0kPPO23PLGpN8tIb6MnhyKd9
 zMpA==
X-Gm-Message-State: AOJu0YzlkfsFzkjBuUvOjO61bKzOZh8bKVWBKkCrF6LOPBKPczuVb5is
 uASHJIbaZ7obbQ+dWaMt0gcrn2zYX1efgkRhVJkJOg==
X-Google-Smtp-Source: AGHT+IFT0oKUHzKSsj24krKgq8nvSNtS46E18VQTWF1lYy7sPZuhaXZ+iFghG/c3NQhM+1GFUwBvdQ==
X-Received: by 2002:a05:6e02:164f:b0:34f:68fe:630 with SMTP id
 v15-20020a056e02164f00b0034f68fe0630mr4191004ilu.25.1697569814948; 
 Tue, 17 Oct 2023 12:10:14 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 e10-20020aa7980a000000b00690c52267easm1821258pfl.40.2023.10.17.12.10.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 12:10:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v13 08/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 18 Oct 2023 04:09:18 +0900
Message-ID: <20231017190931.16211-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017190931.16211-1-akihiko.odaki@daynix.com>
References: <20231017190931.16211-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::135;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-il1-x135.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index fd945822cf..556391cbf3 100644
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
@@ -391,7 +390,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                     g_ptr_array_add(
                         xml,
                         g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                                r->xml));
+                                                r->feature->xmlname));
                 }
             }
             g_ptr_array_add(xml, g_strdup("</target>"));
@@ -507,7 +506,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->get_reg(env, buf, reg - r->base_reg);
             }
         }
@@ -528,7 +527,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->set_reg(env, mem_buf, reg - r->base_reg);
             }
         }
@@ -547,7 +546,7 @@ void gdb_register_coprocessor(CPUState *cpu,
         for (i = 0; i < cpu->gdb_regs->len; i++) {
             /* Check for duplicates.  */
             s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (strcmp(s->xml, feature->xmlname) == 0) {
+            if (s->feature == feature) {
                 return;
             }
         }
@@ -559,10 +558,9 @@ void gdb_register_coprocessor(CPUState *cpu,
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


