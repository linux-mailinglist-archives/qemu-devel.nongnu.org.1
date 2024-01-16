Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A2682ED0B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:51:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzm-0002Sj-MP; Tue, 16 Jan 2024 05:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzX-0002JO-Qy
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzU-0007EL-8x
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:22 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so7399295f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402099; x=1706006899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mmnElBcj2nv+DJIgdzdX1VCBq8raG4h1+S9z6Fi+w4=;
 b=jWVd058tKD+c4IgBss4yw8f5ep6rQ7BrUzwzG1/bOkCBhKQBH2Z+yy57HCOHKn6Oev
 gIEp2l2Ft6X946rgoJHt4v4b0Av/ydPglYI+Wcr3DiSXN3RdJoWqLci25oIx5KszEAL3
 QomBAhqbMjQNpNpIVfSiD+GR/UKl2pV6nKcU90RM1L8Y91r4/DBxCraQVKYi7a88+RZR
 T1gWT/5pQkep4BAmnyAjX50bKg2wf4m0COPr64kFEpKX72eLEUpyOry/G/hVDySLPq88
 +x5z6sgUjYX6xUZmXRzgiKAtaSWLBtxPQPQIhhDAdmW9Tpze0latj6yNrafsMfVfNKDU
 c1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402099; x=1706006899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2mmnElBcj2nv+DJIgdzdX1VCBq8raG4h1+S9z6Fi+w4=;
 b=A5h8djfWdWpjLAYgX3H0seXAsm4nlvwCv80Ef6CGrCaoyAunGbJ0ZBnPzTJBPKwD11
 3DRRJT5SDK9qzBVjIKLtETmI90Tt/jMKnNPtPVPAtNLI5MlDZ4kdNwGHtCGxyfr2Vi/m
 kaE2fslG2HXjxFOz82Z12yCzdhyfvg87/hEJWLNdIBgLg9TcF6mfGMnQZUN26/Ap9ArE
 QImtS/BUbC42aMgSrCN3E0s9WI1+ONtxNlycqU0tOI+1ydiPl9S3fdi44E4Ojj74U7BR
 igncwCGbhqN/t8NXWeS/SPbjd9wsJVhRBZVLgxwyvcolveBVFfrH2qtbXS7jr2tf0rw5
 M4GA==
X-Gm-Message-State: AOJu0YwK2eKJb1wH0/B5OmCcMPgHZUn3Fu31f3ST9zU0OeqGMV0Hh6Ni
 H+MURfBWru5jy4Tw1oXme2YKEfdSD1SnXA==
X-Google-Smtp-Source: AGHT+IH2cLCFvKOJDtd+iYRA2MeFtg+9YVHWorN3mW+11bCLhbRlxGsc6bc02oiVjdt8moVuCVDoVA==
X-Received: by 2002:a5d:548d:0:b0:337:56e4:d928 with SMTP id
 h13-20020a5d548d000000b0033756e4d928mr3337318wrv.31.1705402098759; 
 Tue, 16 Jan 2024 02:48:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l6-20020a5d6d86000000b0033788e357e1sm14345300wrs.108.2024.01.16.02.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3775E5F8F3;
 Tue, 16 Jan 2024 10:48:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/22] gdbstub: Use GDBFeature for GDBRegisterState
Date: Tue, 16 Jan 2024 10:47:56 +0000
Message-Id: <20240116104809.250076-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Simplify GDBRegisterState by replacing num_regs and xml members with
one member that points to GDBFeature.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240103173349.398526-31-alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-5-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 068180c83c7..a80729436b6 100644
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
2.39.2


