Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AABC7C5042
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:35:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXJ-0001YI-8p; Wed, 11 Oct 2023 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWXB-0001OP-3w
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:47 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX7-0005H0-3g
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:44 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-503397ee920so8441233e87.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020419; x=1697625219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+7nP3IGdaoip82hIlnEMfS+fdM67SWVcyUnWsux9qo=;
 b=YZE3CG1JnDa3kGpb+AytELYa5LUtwS9AqcFgHVg5CDW8YyRpbjsVeOffb1TgCQ0jw/
 8Mb8HeNpDllPYn6hwRA96Fk5swYzNeA8hDhVmp8VVgqwNhR4KXHnFGKkRfvFBBTj1XuJ
 FBNlthE704UQ4Wb5sJdyOth+99ljg8aPruVZz3s8SgNIomIBudIDE138NQN19LVEwTtW
 OkMLVd/DlFQ1mxGT0IiOw/SDIWeBlsVpDLK5XsJJczNv3KPTeiBc1YHNAxPJJMuoBWq9
 Hm03JsASGUH7c+mlAspCJcV7JCrtV01+0avntRvfMetMXcok0aXQMsvm4RBqnW86D38L
 wa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020419; x=1697625219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+7nP3IGdaoip82hIlnEMfS+fdM67SWVcyUnWsux9qo=;
 b=fMmXUemp5Sa+0Wr6ob7HOh/ClD09GVmq+I9Oa2cLNQRsn8Y6vddzA1h6Cj/lyJ7iZP
 u04WNsCRx4AwEa4yJWy/zmOlk024Z2FxfNIAtRx0aw+8WnyBfOh1T2/dQlINtvNwWEbQ
 VLJpwpYMfEik7iMArtRZhn4xJKoFtoLSvULnq2+f3xGQA4V/zG57QaAy7aKxRddRK/YP
 RQCtwXpQkvrKlH6M2c4W9T3GNCDBfjMy9r17Klgv9Wj3Jq/ACqRJuPFkDbn9h0ToE8di
 C+fwVSUTuObCQBtHcy2bc3HMlEq1/OwD47GXvFQVS3ZDXCx/G48O0+HjimNSugvSBKVc
 t59w==
X-Gm-Message-State: AOJu0YxG18/ya8teRn2Gb950XRoxNg3vfVzoG9mFVR+7FIP/DVL0Vniy
 tcv7vkjjYN7HYQk0lv49LoKRXw==
X-Google-Smtp-Source: AGHT+IFL/F1Q0hc7PElnnAkTEqmYjhLOk86tMppyVjLjX2mPhUOLgaysp2tC4TJ0GccoO6f9nz9mpQ==
X-Received: by 2002:a05:6512:ea5:b0:4f8:77db:1d9e with SMTP id
 bi37-20020a0565120ea500b004f877db1d9emr25721739lfb.12.1697020418927; 
 Wed, 11 Oct 2023 03:33:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c024c00b0040531f5c51asm16622591wmj.5.2023.10.11.03.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 426131FFCB;
 Wed, 11 Oct 2023 11:33:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 19/25] gdbstub: Replace gdb_regs with an array
Date: Wed, 11 Oct 2023 11:33:23 +0100
Message-Id: <20231011103329.670525-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

An array is a more appropriate data structure than a list for gdb_regs
since it is initialized only with append operation and read-only after
initialization.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230912224107.29669-13-akihiko.odaki@daynix.com>
[AJB: fixed a checkpatch violation]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-20-alex.bennee@linaro.org>

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b8347ed5a..3968369554 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -502,7 +502,7 @@ struct CPUState {
 
     CPUJumpCache *tb_jmp_cache;
 
-    struct GDBRegisterState *gdb_regs;
+    GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
     QTAILQ_ENTRY(CPUState) node;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 62608a5389..b1532118d1 100644
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
@@ -461,17 +463,23 @@ void gdb_register_coprocessor(CPUState *cpu,
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
+            if (strcmp(s->xml, xml) == 0) {
+                return;
+            }
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
@@ -480,7 +488,6 @@ void gdb_register_coprocessor(CPUState *cpu,
 
     /* Add to end of list.  */
     cpu->gdb_num_regs += num_regs;
-    *p = s;
     if (g_pos) {
         if (g_pos != s->base_reg) {
             error_report("Error: Bad gdb register numbering for '%s', "
-- 
2.39.2


