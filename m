Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8177C64E3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoa4-0001sE-Nn; Thu, 12 Oct 2023 01:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoa2-0001r5-PV
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:54 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoa1-000760-1O
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:49:54 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c7373cff01so13953705ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089791; x=1697694591;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAXiVgK3SY16sTLGMXmBBZcg+fyxw8kEojOMtcTx9cc=;
 b=xTDa25GWov0WvhdlmNXfp/jMXw/YdY4nCooOHzbqlR4jOh++swXDaLLoTDihJDCnUO
 49wZtA85BDY5CDqkIbI9fozBaZQ4WLlU+vOn2VA2Kx63iVUVKikngafU9AfqZK/CLU85
 uKryHcusxjiQqC97y1jcjjjX+ZgU6d6HNTzBmBIj77lCrFyy3GHWsAYbKJKef9TSZoHD
 LBrUWLVG3aIFQWjBPXvY0MHMPesoSUc9KrAXwlJwWAe1pyr+U+nBmJyhUO9bAtDCfXhk
 RYotQ2KYBxuPv1+fZwypEYSAcyexeiFsLG+2QUU4yrfkEZVZe7SGxXyLoAstth6u48Ou
 /UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089791; x=1697694591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAXiVgK3SY16sTLGMXmBBZcg+fyxw8kEojOMtcTx9cc=;
 b=u4UtsyMqHJ6oXGLx0nZJ7Ft7DFge9LC327XfjhF59vByNmAtBfHJP74qJxLaq4bhhL
 NpHv2iUqacU+rqCB3toBOnnb1nT0MPNIJOfDpigVCvDgKpzQqFXXH+X73l3Mn8waanNP
 v/s3piw/dFYc5HmTobTFd+b5DqjO24cWO7cdBTXecf9Mk1dKG6i3dZ8MjxbkVwgcwTY3
 E7OVUaAUEkHLNmhxllCAKiOqB/5ncej1xhlTWE7kmwaiNOk2UO2tu29fkfPRHfOjYGG6
 KzcLUU8Q1mJz8n8aTaIiUcWZXRmvGZc5uD5eeRt3Hzn9/cKLAE+GzGWyHkL60aISwEZR
 NfNw==
X-Gm-Message-State: AOJu0Yz+ko6kWCZigiea8kHj5gPGrkUSFj0soN9TDPCDrKC1ZDzOHkD4
 9ncg3U3MB4aGhDFJURlwy4x6+Q==
X-Google-Smtp-Source: AGHT+IEqi7u/OywvZJ3nxOiInCGDTYQiJmXxY2nVywO8NvdVCjr1t8hgvWkR6G+mbp/vz84Zsx2D6g==
X-Received: by 2002:a17:903:230b:b0:1c5:cf7c:4d50 with SMTP id
 d11-20020a170903230b00b001c5cf7c4d50mr37839080plh.18.1697089791616; 
 Wed, 11 Oct 2023 22:49:51 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 jw10-20020a170903278a00b001c5fa48b9a0sm945114plb.33.2023.10.11.22.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:49:51 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v10 08/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Thu, 12 Oct 2023 14:48:47 +0900
Message-ID: <20231012054902.38447-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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
index 20586e0b6a..9a4124afc4 100644
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


