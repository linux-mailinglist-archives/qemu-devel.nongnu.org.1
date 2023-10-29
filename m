Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D47DACDD
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 15:53:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx77t-0007cY-A4; Sun, 29 Oct 2023 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77q-0007ZS-Bm
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qx77l-00059F-2U
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 10:50:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40790b0a224so26962225e9.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 07:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698591043; x=1699195843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K3iMnzMdyIhqWBXr+FnuiLrqQWudWeq1Fvu4ovgLDXk=;
 b=ygOiKp6vKy8cUe8PPGSGI8H6GxB5nyAi3PAd9DbfZ2J8ReSqQ7Nelam+BWK1gkOm9Q
 HvvvCAM+9A48Llr9Z8g/TVAhr/MH79RJIIj5cKG9+K1sb14NXvXvMz6vwnw+xnAigpSE
 U/Qv5HV3WSxDesMk91g/cNuRvG/nsBnz0EBMwjy8X6ZLQ0nmesv6eAYRgijfrfQzPY4N
 DHt9lANI/LWe/rtDcHY/VaIXjpJEHX6MQGA5VXe5vj1lXhMfVlnAAo40bVDWKD1tnre1
 d6EXeLzz+iWz/9Ha65L3mBAJ+Ss+eLUPhnoFp+5i9N31XiWjnb2sHOL79keWVonuerX4
 9h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698591043; x=1699195843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K3iMnzMdyIhqWBXr+FnuiLrqQWudWeq1Fvu4ovgLDXk=;
 b=TH8ufBunZPw8QG13Y/rfXx/wbjwQZt6XTUpkHmvgqZlVThRjyKB7IuxtHzyGW1jyMs
 /wr9PXVueJFMI74eyBNyDnx2U+4mpFhNOTJ51LlGI2KXEr3seSG4BMjRWDEvR4W9jNnr
 K35c++hcrPtnUI9UVBhp136H2XCFN6V2I4bgNE0LjOPD3Yd9Ps4LKq6+0PHdXBRn15z6
 /4AYSnHyekNk/jrbZyEuef7uikD9l4508+FBwui8rLxw5pfevzK2/oefBTAYIpMRs5Yk
 ZI81VtHVegh1YdhbEbXDDm3cd16hXMwHwiq6WvqW1wdAcv+EjVjdHgFMOy2I9n5XuxgS
 6J0Q==
X-Gm-Message-State: AOJu0YyG+CL8SByZln8QveAg0Q9hkxAHwNZ6a5J5DVvB7Z46ZT/6klRR
 Om97/NZEaYy0w9vbg+E0zg29KQ==
X-Google-Smtp-Source: AGHT+IHwCoHxbBAvEzs0kZ6IzVtU1k8eQXz6/GIcHzG7un/WsD/JEIKeMQDpdpVMDnf0DqqGQgV9bQ==
X-Received: by 2002:a05:600c:4692:b0:409:2c35:7b3e with SMTP id
 p18-20020a05600c469200b004092c357b3emr5571808wmo.8.1698591043349; 
 Sun, 29 Oct 2023 07:50:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d12-20020a05600c3acc00b004068495910csm10002077wms.23.2023.10.29.07.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 07:50:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C1515F7A2;
 Sun, 29 Oct 2023 14:50:35 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kyle Evans <kevans@freebsd.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Brian Cain <bcain@quicinc.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 16/19] gdbstub: Check if gdb_regs is NULL
Date: Sun, 29 Oct 2023 14:50:30 +0000
Message-Id: <20231029145033.592566-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231029145033.592566-1-alex.bennee@linaro.org>
References: <20231029145033.592566-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

cpu->gdb_regs may be NULL if no coprocessor is registered.

Fixes: 73c392c26b ("gdbstub: Replace gdb_regs with an array")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231019101030.128431-2-akihiko.odaki@daynix.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231028103311.347104-15-alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 1e96a71c0c..29540a0284 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -385,12 +385,14 @@ static const char *get_feature_xml(const char *p, const char **newp,
                 xml,
                 g_markup_printf_escaped("<xi:include href=\"%s\"/>",
                                         cc->gdb_core_xml_file));
-            for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-                r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-                g_ptr_array_add(
-                    xml,
-                    g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                            r->xml));
+            if (cpu->gdb_regs) {
+                for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+                    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+                    g_ptr_array_add(
+                        xml,
+                        g_markup_printf_escaped("<xi:include href=\"%s\"/>",
+                                                r->xml));
+                }
             }
             g_ptr_array_add(xml, g_strdup("</target>"));
             g_ptr_array_add(xml, NULL);
@@ -430,10 +432,12 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
         return cc->gdb_read_register(cpu, buf, reg);
     }
 
-    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
-            return r->get_reg(env, buf, reg - r->base_reg);
+    if (cpu->gdb_regs) {
+        for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+            r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+                return r->get_reg(env, buf, reg - r->base_reg);
+            }
         }
     }
     return 0;
@@ -449,10 +453,12 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
         return cc->gdb_write_register(cpu, mem_buf, reg);
     }
 
-    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
-        r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
-            return r->set_reg(env, mem_buf, reg - r->base_reg);
+    if (cpu->gdb_regs) {
+        for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+            r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+            if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+                return r->set_reg(env, mem_buf, reg - r->base_reg);
+            }
         }
     }
     return 0;
-- 
2.39.2


