Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A87D612A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:30:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWRT-00045P-R1; Wed, 25 Oct 2023 01:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWRR-000450-Ka
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:29 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWRQ-000125-1Y
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:29 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5a9bc2ec556so3407482a12.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211707; x=1698816507;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtYqczR/9FARIpePQwszvNkMiVilKm99+o9RyFQkH3E=;
 b=HtFHqmhwoYPJBYb0oKLwEClvMtIMlvjgy0WswkMn14ZU0YPQobmsUEqlCiNnmoHFwu
 XHYJLvB3Mahm0Gmq6Jxpk00/78m9YwEUPH0zE1nnBgbdMI19xRNtDf1U98EDMVTeMyN4
 Ja+PGZ0rIBbiHDB/1hNIYqnkbTmQzPlkhu3HhNxabqHnE9dFFZtwB3iYiZpqueLJTgYM
 9R8W4V7pQlFg/x3CuOQjG4To+5iB1OxnwyHuQ6y66r6ko9MeNcH2K8RWlQbD+pwL0SnY
 YgzayOoLZJHUhFJG0E1Z3AgQ/qhnFuyi5mfsQH+kTG355T4g16ot6n0RdiXe882yN4Bb
 EJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211707; x=1698816507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtYqczR/9FARIpePQwszvNkMiVilKm99+o9RyFQkH3E=;
 b=OrR2PnAMv8HxTnR1sr9S1ECxnuiHyYZWnPo2+tMHqvbMNGcWPl+Uq9eeGKynAX9Vjw
 M2hEU9RmKsqsyLgNMYH2+95qbiUW1rqWoSksR5Cv4nhPW0/z5XDxUZ6ZAx1LA34DE+/d
 qziSywVJbgCd31iA6zReuarjp6X03NeLdDtPdHYhdL5XsbQ17By5pa+ZcWBZFt4UV6T7
 OR5C2yb5klbsnhn7EvdgwrcZdYQ2+dbWLeNUPfi3VYIJzw316unCPLekwEvK7+Cl85z7
 /8wMVnsrdvsBi+KNPJbIHXRRdKJ5wqqNeeAeQxH0ELu9pIDXPtZe5499XeeWstDPit/y
 Dd0A==
X-Gm-Message-State: AOJu0Yw0CG9kMZzOQwAQIZlU/C8fO76SGBxmyNh7t3Z2OOF37TDxAq4b
 L75jslVWmr7hlSaAQCGTZwtTnw==
X-Google-Smtp-Source: AGHT+IG33EPi7Zq/VKV2rZEKru+TreoZDP1d5pN4EXrNngN/JmF4+28FuMYuGcDR1RbHa347m7AAhA==
X-Received: by 2002:a05:6a20:394a:b0:16b:c8f8:a53c with SMTP id
 r10-20020a056a20394a00b0016bc8f8a53cmr4336615pzg.47.1698211706888; 
 Tue, 24 Oct 2023 22:28:26 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 li11-20020a170903294b00b001c444106bcasm8266009plb.46.2023.10.24.22.28.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:28:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v15 08/19] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 25 Oct 2023 14:27:30 +0900
Message-ID: <20231025052744.20697-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52f.google.com
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
index 67c6fd2609..ebabbc00f6 100644
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
@@ -513,7 +512,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->get_reg(env, buf, reg - r->base_reg);
             }
         }
@@ -534,7 +533,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     if (cpu->gdb_regs) {
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+            if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
                 return r->set_reg(env, mem_buf, reg - r->base_reg);
             }
         }
@@ -553,7 +552,7 @@ void gdb_register_coprocessor(CPUState *cpu,
         for (i = 0; i < cpu->gdb_regs->len; i++) {
             /* Check for duplicates.  */
             s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-            if (strcmp(s->xml, feature->xmlname) == 0) {
+            if (s->feature == feature) {
                 return;
             }
         }
@@ -565,10 +564,9 @@ void gdb_register_coprocessor(CPUState *cpu,
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


