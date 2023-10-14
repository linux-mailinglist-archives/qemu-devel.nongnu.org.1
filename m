Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49A7C9291
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVVr-0002ig-6s; Fri, 13 Oct 2023 23:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVo-0002bP-Tf
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:40:25 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVVm-0004rG-2t
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:40:24 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5aa7172bafdso970950a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254820; x=1697859620;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yIbCJ1hDjpIOPjyXYKgIxQzDCSRaHr+TweeHTG4D4I=;
 b=QEigQZUlX2kisoBv8PyG+XEaRp2WiWhipdoeC6WpR3XePEuHKD0iA6I+9NK9alVbDU
 c++s+Kxs8UByUojvxrdrZLDlfwIMmLErccbgBjGPx9HkHxfyA2J6Q2Nppvfcpi9YEbzJ
 6Y/c4jnSVc/bCVZs0NFXJgYbKITPDjFWSW94hlvGA6xauKQ7rzvi3IDsYfcyxKO7uoZg
 BvQ8e/nnB+V4uRIQPHw7ik1fRc465SC1a03064eMpbBo63LKhjoj179z3lnPl9Xvz9GK
 VmU8F9t3EnkFZEsMuEvgx66Os/bBSNv5bUUHeduwSKvuYVlu7Qc+0Gl2U9zREBgoUuXE
 LWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254820; x=1697859620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7yIbCJ1hDjpIOPjyXYKgIxQzDCSRaHr+TweeHTG4D4I=;
 b=kROZ+bTe7m93bCCBemjDsRseNaAGU+z7E7lwwEAm7dZ/FQ8yAsT2/9twhMWRE/gr4L
 ddez4CKyFaskFoLA2mpti3y1UB0pppqGLsF4RPQYzTMkCvQIbMJWEwYhGZ961a9HsYQk
 sc0ePggkJFL39uOIAGeTyMdgNGGyWWftarsxmKWRDHthhr5OxDDo2Lup1zgNkWUVZ+7J
 Zmnf4KlReu/wGeq5vkTgGZYA+Tst/qeLtDLRVpfLRR4kXiM6lbCaw45TnmdOMrEDP81l
 EFf4TsKo4qrGwD6K9Am5Rtmhia5Q96QEDUDijH6imzxSZb0b7oYi3/EVYvmFICmFKPsI
 E0Zg==
X-Gm-Message-State: AOJu0YxsJJBc8+Ac9y92HeGEOSi1S8fi16SRuVtwZBM4CCctZhbszpPL
 SiwSSxFUEBuVxih6UqhnffLzNg==
X-Google-Smtp-Source: AGHT+IFO8H9Otvks5znNwV+OFpBRE88QaP5VZWKtdbXUVVYuX+fAWcnOAvAskySJWIFIlhFx3wbLUQ==
X-Received: by 2002:a05:6a20:3c89:b0:173:3ef3:236a with SMTP id
 b9-20020a056a203c8900b001733ef3236amr10814391pzj.21.1697254820632; 
 Fri, 13 Oct 2023 20:40:20 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 jc3-20020a17090325c300b001c9bca1d705sm4616945plb.242.2023.10.13.20.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:40:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v12 08/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Sat, 14 Oct 2023 12:39:27 +0900
Message-ID: <20231014033940.15679-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Simplify GDBRegisterState by replacing num_regs and xml members with
one member that points to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 016d20831b..bd6631627e 100644
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
-            if (strcmp(s->xml, feature->xmlname) == 0) {
+            if (s->feature == feature) {
                 return;
             }
         }
@@ -553,10 +552,9 @@ void gdb_register_coprocessor(CPUState *cpu,
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


