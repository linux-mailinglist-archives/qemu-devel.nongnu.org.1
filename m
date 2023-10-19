Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A20437CF534
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:28:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQFo-0001WV-Fs; Thu, 19 Oct 2023 06:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFk-0001VW-VO
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQFj-0006xf-6Y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:27:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso476902b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697711262; x=1698316062;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtYqczR/9FARIpePQwszvNkMiVilKm99+o9RyFQkH3E=;
 b=jvvxY9kvtfAzL/LYC6QgdIJuYTxmdn1cWzZfVD2EnU0eGoiddwYZVAJRv0wD5HDS2+
 ZFCgla33ZS3a/TJci/8WIjf0nhpI6xsRQBr/Iew2hcoWbfr1239qaLm24CpS/UW1+wZk
 AaXDsbI1lFhCN+3UaxKvgVhEwkxHYolhQNlaJRwgQEkFzNU+IM4Mb05LCOv1SJxMdeBT
 jbeGRsNvEecYQygQkGNIvnbv7JzK9sR8rQaQkL0moVEtLh/NYdhqUDCX38+0S+EGsd3d
 c0L8Fbo0szRJsbHzXy6uHY7w/g51Op5v+re+K6oVSr0VdgDuEyU8/ifVYIJoWhE3Me40
 7viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711262; x=1698316062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BtYqczR/9FARIpePQwszvNkMiVilKm99+o9RyFQkH3E=;
 b=TTqh3y3Td0turz+BmjEJY1SwsjpOPmvqIyBvfty/XcoHUlnSZw9vFmqe5x1Zk7NFlD
 EY7AfhP+sz/R8d4lXo6FDb/qkJiKsnIuurRIXeRjP7DCJ/v67q/vLCgLyDrCAuCU3x/H
 JRFY6ZesV/o14hGcE+Lq3lC5CkMExb+/vSSs6ugTk1z9KE5paZpTupyhHXP7nr4S0jmg
 PYaQRsEmCFgtfdy3A3XUhiEGwIjorMs5cdxLpdlIoOGA6q+N8WKORDGjNHF3WsNgTDlv
 vSZ8+XhgayszzR2CyursSIoY6V8XPtlncylsdScjHbGSU3k0EsfCyNzTufo6V10lwEUg
 mVjQ==
X-Gm-Message-State: AOJu0Yy6tUZJGkxjMosz8CmoluAxurUSVbFZO/z59gyKZSHW8Ph9CHjN
 5Vncwbq1KQyRf9rnKOIcYjO5vsXkmTaXOg+eAsUm7Q==
X-Google-Smtp-Source: AGHT+IFPKAWxT6Gu1hQQPW/oJFn27lKSVWCpFr43TuJBga/aVzhlFksewtvgJXUKomHT64rwQQSECQ==
X-Received: by 2002:a05:6a00:2b84:b0:690:fd48:1aa4 with SMTP id
 dv4-20020a056a002b8400b00690fd481aa4mr2036670pfb.0.1697711261989; 
 Thu, 19 Oct 2023 03:27:41 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 u11-20020a655c0b000000b0059b2316be86sm2717492pgr.46.2023.10.19.03.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:27:41 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v14 08/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Thu, 19 Oct 2023 19:26:43 +0900
Message-ID: <20231019102657.129512-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019102657.129512-1-akihiko.odaki@daynix.com>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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


