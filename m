Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934837C6ED8
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:11:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvPP-0002A4-0b; Thu, 12 Oct 2023 09:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPF-0001xh-A2
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:14 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvP4-0005Dv-09
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:12 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-577e62e2adfso637875a12.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697116021; x=1697720821;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAXiVgK3SY16sTLGMXmBBZcg+fyxw8kEojOMtcTx9cc=;
 b=Cn6dKjf/6F0a4Sy+yj0AAgDNEbF7zHZRfdb+ukgWfLpADxggnLS/HxX5SMvjiuT6fz
 ih8bzrQINPO1GptzNwtMlTaIkHi+6lC9+niR9yQb5wcZDgSwVCAgL4InYkbwPU3l2XXR
 Z+QKLUGsQufZ77i2bVQ1dPnoRf6bxCuPvi0TU74jiDUbNQ/+RdRbqXaWc2OId23XhioE
 oiei/2/iw3YoQkCZSuxzmbwKhyzQ2WP3EZVKQ19VBmvmDwRJDSOCioff2MvFpOy6FOXK
 aZHyYRbq/9VeaKZ9wDzii5AOgbUzek1B5piFvZ43JiDH/Pypj0MjOtN05ACx7cxgJbCp
 uXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116021; x=1697720821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAXiVgK3SY16sTLGMXmBBZcg+fyxw8kEojOMtcTx9cc=;
 b=gBtQxdz/SmdKs3X4UaF6GQbwRAS7HTy+GjlLqUrMJcjdeeJVIEf0PenM9rmcGI7h6o
 dM0aSnahCsTsJ2nenBKAkxWFGTkYSollM0AWlukGZWi/NsWErTtgqXxtxUmvFSvnEoM5
 xWZ5KqFEtKtHsdPYEf+TZUlF/D+SAv5Z1eIZFzZxMMUJhKGuG5NNLhc77s+Mokp6Wymd
 1eq84Lh7RhBKcYXalOa3lIqHt14RBCjGHZM6kqKuZhuOi0AxYYKJOEMm5PSM4+Lf+9Kk
 7APwLYZtSqSuSW5n5oeGaVhr4Jv1hxhSfbAfUNFrlom5QhtX7cFNJLqKg3NCTjXh1/w0
 q+iA==
X-Gm-Message-State: AOJu0YxtgCUhkiPbjl4PLjwFfviPD1+OZyqYbeR4bmOwyH6fHfsV6uvS
 X9eSEdKk83NtbrWlb2ISXlPCkw==
X-Google-Smtp-Source: AGHT+IEi44GwCZFOEBOJZppp8peAcGIWm876Ol91x0FZcw/WNSr01k+Awo07c1h9rYja8GFaPsuOVA==
X-Received: by 2002:a17:90b:3642:b0:27d:dc9:c67d with SMTP id
 nh2-20020a17090b364200b0027d0dc9c67dmr3735729pjb.36.1697116020695; 
 Thu, 12 Oct 2023 06:07:00 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 mv21-20020a17090b199500b00276e8e4f1fbsm1814678pjb.1.2023.10.12.06.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:07:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v11 08/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Thu, 12 Oct 2023 22:06:02 +0900
Message-ID: <20231012130616.7941-9-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::52b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52b.google.com
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


