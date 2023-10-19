Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ACB7CF4CC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPzJ-0005jC-Di; Thu, 19 Oct 2023 06:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzH-0005iz-Ig
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:43 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzF-0007RN-SW
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:10:43 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so54266335ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697710240; x=1698315040;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y9a4WcM7W3w4Ibv1QcOl1jK0U40rkzZ0nUtw12AhXXI=;
 b=xqL+u/CxqOyKqzPhLnljPHF6SBqU/kp4UZ3Sb0A1R1KetYj9FbDMEvQoM3MEYNijpE
 7SroCwUjK+9eLSsDNpgY5aVPIYhCK+mg2ZeSlHa/U11wQS3RGzWXny4hzj5Xlr9fep7A
 hzh4lqiB5eCv/A0/f8fp/WOWXfik0HjoXf1aG4/T8U17L2HwK0H8FE5+8zZuTiEzcf/6
 dItgh+ww9nL7Cef0Tt6MNVwimFWnwPYCLKBnaKCsCYqm/1iorSIdNg5R8qHEd4/XTJ1j
 vYaaPYnqzLOpXfOtVWaKAf9FqXYJaqYGXWKJLw5IFFwI2paLGOu5dcWvpYHava2fmG2T
 i5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710240; x=1698315040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y9a4WcM7W3w4Ibv1QcOl1jK0U40rkzZ0nUtw12AhXXI=;
 b=OvYStGiI34GGUHt/TvUu+/Aav8o4+RyYg49hTNNQZIdrHRRSuU/+moLA7xifwhDdM4
 DCC0Vh8GvwSmZ/LXhyI2YplDY9rUh8Yf6oXx4wg3crkJBG+7vH/oueblqnvtJfIOJpmx
 tCJKIBASVdID0R9VAkXP8cPRzOCG7g9RYt7S+OutgbuSOPB45xfPUzCkPix+gcKb8keM
 Hg/x8RjlJ8e2SZbNAnvZq4NH3Fr55Rl7XoGqR9IlKJnYaWqqFtAwbO9kYSD9UNj7Rc4a
 6bS4PLANCeL8GR/s/LHJkgnUQB8axVOc9ul0Ou9twIco5qpzC7MVpXMi1VyY1wXaFt4d
 OsAg==
X-Gm-Message-State: AOJu0YxhH1is+5GdpOTpISY25pa1ey5kOZVDWYJpVuE4HgcYWvojZ569
 aBwYEA7QvrpiXMETKR9W2dBI1A==
X-Google-Smtp-Source: AGHT+IEtKxAniWbyH0tsxaR17xS08mN4wnZQ+2+Mi8jYnjDuxVCWXmzzDAdRY11Z0BZjylyotGlkrg==
X-Received: by 2002:a17:902:ed01:b0:1ca:3d9c:a752 with SMTP id
 b1-20020a170902ed0100b001ca3d9ca752mr1989457pld.12.1697710240233; 
 Thu, 19 Oct 2023 03:10:40 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s15-20020a170902ea0f00b001a5fccab02dsm1534033plg.177.2023.10.19.03.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:10:39 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 1/6] gdbstub: Check if gdb_regs is NULL
Date: Thu, 19 Oct 2023 19:10:23 +0900
Message-ID: <20231019101030.128431-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019101030.128431-1-akihiko.odaki@daynix.com>
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

cpu->gdb_regs may be NULL if no coprocessor is registered.

Fixes: 73c392c26b ("gdbstub: Replace gdb_regs with an array")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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
2.42.0


