Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF079DC0B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgC4s-0002hf-5u; Tue, 12 Sep 2023 18:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4q-0002hS-7I
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:48 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgC4n-0001C1-Uf
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:41:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf092a16c9so54347925ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694558505; x=1695163305;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YR6f2ljT/PkMnpwGwuqVmtD8rXDReW0mqLVfL5y4OQE=;
 b=dYpnyL3EKYuoIMesORAX1Fe7qywVke/hXOqbAL4/H3EiMmeuso1LNCyQE7n1pVSv3r
 kJtLmE8rZbxLH+6/Aj1F+2L3/vgvjP06/DtfnZDB8vDnBTDiggekFpYnX6jL9YTd2Pv1
 ccJZH1cK54xpJ0VEIEKpR954T10GAmG+8CVC3I9b7ydnYT3dThe3dMfxazUSqnKuERvE
 IHvB0qMzO690xe6TaK4v3HI5qZYo6eBImzC4dLwgQLLgHcHWvNMw2ToXeZMBYezfZOXM
 039Zh4CRln0/J1WEvGxHrhyZuK3EdMea5dwQjf2OSdfHOZEz+mWmfmb7j6CMoOnRYTlI
 3r4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694558505; x=1695163305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YR6f2ljT/PkMnpwGwuqVmtD8rXDReW0mqLVfL5y4OQE=;
 b=rSc8j0rDB025fSN61P2STMqtMwyHcQ+T/7UanRfnhh23hDKbAGnzWNVA3OGKwMBvxe
 O7XZnvBG2IzmGrK7rtCpokdsF9WC/zu8IPsLpogNdtFK6rh55BZlzyZXIHUDwg+Q7Brp
 32TWSQXwY/lrf12tKS958MXZ7rb1+drgzCgD/EEAYZ5Jk2wrx1z8TFHZhFv9WfWn8K5U
 ZnRZ+OmOP42s6lnFm85WmIQ2Eazur5TGA0ytWcTHCzBHYRKaigluFyFlfBLGHhuhHoK3
 lC3EHOLdivPvTe7RT6aRmffqecosVpdoNKS9EcZJScUUGYFhAKceJu7TdPFO2z0g0hnr
 H6QA==
X-Gm-Message-State: AOJu0YxGDJfBNq19JCZnYhreJLDsU3igBArYCJakQQZKcSWsR6V2M5A3
 8+nD5n/d4VDQVQpe1i3ajWy1FYmEyLZkrD7He8g=
X-Google-Smtp-Source: AGHT+IEkxlzDGnz/EG6d9BmGQ6SyQ01bzEjHa/3aGrapWlGs32zIhZyK/A7uGTy4DKsdCMALiLDcAA==
X-Received: by 2002:a17:902:7c8a:b0:1c3:2532:ac6a with SMTP id
 y10-20020a1709027c8a00b001c32532ac6amr1017475pll.33.1694558504919; 
 Tue, 12 Sep 2023 15:41:44 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a170902d34d00b001bbbc655ca1sm8996977plk.219.2023.09.12.15.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:41:44 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v3 12/12] gdbstub: Replace gdb_regs with an array
Date: Wed, 13 Sep 2023 07:41:01 +0900
Message-ID: <20230912224107.29669-13-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912224107.29669-1-akihiko.odaki@daynix.com>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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


