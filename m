Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5618179C766
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxMT-00018J-8Q; Tue, 12 Sep 2023 02:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMM-0000ul-Oh
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxMK-0007as-FN
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:58:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-273d10d3df3so3305444a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694501929; x=1695106729;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YR6f2ljT/PkMnpwGwuqVmtD8rXDReW0mqLVfL5y4OQE=;
 b=OM+of/Y48FEkCqJOufpI9t1/OzCNnJdKc3O13Eqc3MP++EFysxbREvC0onTvkP8HEk
 1Zra+OC+fUy1+faCeFIXigP56MQ3HvGBxZXB0PL855XPJYidwbpMErzbt3oXaqY3QCRQ
 fR5Ytlzomxdbale4OKwLYI/bL9ea/i6d4A1kSFOqyR2hkRQZFcW8ZjHI0Q3WefSZ5F1H
 ryN2/fgehZjn1LfySy0liPd/4JjCd/s1f7fNmanzEhORKLxY/CY/hqq9s7D2qVTr7ymC
 j9zoqSdHTVTQpsDRyIOjLf79qNzF8W9RidZOAUW2k6qNUXf87w+LlGzwaakQ5FBepj3r
 VhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694501929; x=1695106729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YR6f2ljT/PkMnpwGwuqVmtD8rXDReW0mqLVfL5y4OQE=;
 b=SCuK62SxWyM/cRl8HFfNq4bVjN0zglLlNg0u9EcQ8dm/8dxKyHC8iKApENk9aka0BF
 VUEXJdlCfL7mDKXnXMxnSwjqxpyvj/KnMlOy69HdKItVxtviCFTjmCcO3zc1y3DR2YPf
 mUHd49r+lOU3DDK83dvNIGv9VmOUsP6VSGHMuHNjJFCeh7PrM3vpvfbKIiJ34ZNDqUXp
 7ojZhfwgZQ4A6+EdIv2KWUlPCVoCAbdu0XZaNOnMHO8jPfnZNiCjbB/+YABBPzQZhpiR
 WsCPudq0vwIY/Kq6skoXPGfQQZJ4adIe44Q4FUP67isbT5IldZOoFyDO74c7izwtcikc
 ZY6w==
X-Gm-Message-State: AOJu0YxhXJLJJjV09fBNcp7gtq/Lzuz+DaIFqR8uktx2Qhv7LC4oaNE2
 aT9WVjfZfEXTHQeFbCJKsPUEhA==
X-Google-Smtp-Source: AGHT+IF9TOgQPUhoOgxLskBgRqjhDi4h3eqOseqbEVO+VnHesztNvq+S0N4PgK4b1DJ9DyTzhXr8Jw==
X-Received: by 2002:a17:90b:1488:b0:268:ac99:4bb4 with SMTP id
 js8-20020a17090b148800b00268ac994bb4mr9709232pjb.46.1694501929190; 
 Mon, 11 Sep 2023 23:58:49 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a17090a2ac800b002696aeb72e5sm9315058pjg.2.2023.09.11.23.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 23:58:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v2 11/11] gdbstub: Replace gdb_regs with an array
Date: Tue, 12 Sep 2023 15:58:06 +0900
Message-ID: <20230912065811.27796-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912065811.27796-1-akihiko.odaki@daynix.com>
References: <20230912065811.27796-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1034.google.com
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

An array is a more appropriate data structure than a list for gdb_regs
since it is initialized only with append operation and read-only after
initialization.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/core/cpu.h |  2 +-
 gdbstub/gdbstub.c     | 34 ++++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 4f5c7eb04e..c84c631242 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -375,7 +375,7 @@ struct CPUState {
 
     CPUJumpCache *tb_jmp_cache;
 
-    struct GDBRegisterState *gdb_regs;
+    GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
     QTAILQ_ENTRY(CPUState) node;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 177dce9ba2..9810d15278 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -51,7 +51,6 @@ typedef struct GDBRegisterState {
     gdb_get_reg_cb get_reg;
     gdb_set_reg_cb set_reg;
     const char *xml;
-    struct GDBRegisterState *next;
 } GDBRegisterState;
 
 GDBState gdbserver_state;
@@ -386,7 +385,8 @@ static const char *get_feature_xml(const char *p, const char **newp,
                 xml,
                 g_markup_printf_escaped("<xi:include href=\"%s\"/>",
                                         cc->gdb_core_xml_file));
-            for (r = cpu->gdb_regs; r; r = r->next) {
+            for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+                r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
                 g_ptr_array_add(
                     xml,
                     g_markup_printf_escaped("<xi:include href=\"%s\"/>",
@@ -430,7 +430,8 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
         return cc->gdb_read_register(cpu, buf, reg);
     }
 
-    for (r = cpu->gdb_regs; r; r = r->next) {
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
         if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
             return r->get_reg(env, buf, reg - r->base_reg);
         }
@@ -448,7 +449,8 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
         return cc->gdb_write_register(cpu, mem_buf, reg);
     }
 
-    for (r = cpu->gdb_regs; r; r = r->next) {
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
         if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
             return r->set_reg(env, mem_buf, reg - r->base_reg);
         }
@@ -461,17 +463,22 @@ void gdb_register_coprocessor(CPUState *cpu,
                               int num_regs, const char *xml, int g_pos)
 {
     GDBRegisterState *s;
-    GDBRegisterState **p;
-
-    p = &cpu->gdb_regs;
-    while (*p) {
-        /* Check for duplicates.  */
-        if (strcmp((*p)->xml, xml) == 0)
-            return;
-        p = &(*p)->next;
+    guint i;
+
+    if (cpu->gdb_regs) {
+        for (i = 0; i < cpu->gdb_regs->len; i++) {
+            /* Check for duplicates.  */
+            s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+            if (strcmp(s->xml, xml) == 0)
+                return;
+        }
+    } else {
+        cpu->gdb_regs = g_array_new(false, false, sizeof(GDBRegisterState));
+        i = 0;
     }
 
-    s = g_new0(GDBRegisterState, 1);
+    g_array_set_size(cpu->gdb_regs, i + 1);
+    s = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
     s->base_reg = cpu->gdb_num_regs;
     s->num_regs = num_regs;
     s->get_reg = get_reg;
@@ -480,7 +487,6 @@ void gdb_register_coprocessor(CPUState *cpu,
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += num_regs;
-    *p = s;
     if (g_pos) {
         if (g_pos != s->base_reg) {
             error_report("Error: Bad gdb register numbering for '%s', "
-- 
2.42.0


