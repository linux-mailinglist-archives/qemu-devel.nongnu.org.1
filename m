Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AB37DA678
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 12:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwgdM-0006LE-RT; Sat, 28 Oct 2023 06:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgdG-0006Ii-SC
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:32 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qwgd7-0003AO-2O
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 06:33:30 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507b96095abso4117513e87.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698489199; x=1699093999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9D0IAeyBl7tCHLFuwBJ3K5ngt4JViKy0HwHpFD6M2Y=;
 b=ors6grAt5/KN4yOvC5orcw9Tjz4hrOcQQq05skR39BpOho8XecGCeKScN3FM22TI0O
 kfyiEJdtdkkjE1i/ultBBbPIJehA73sYqNOEAV6AwjpZrpCsoZtnipwb9kh8T8gZzomv
 WSIA8Fw5n89RoECzgukBcmhT4vukofUbJGJfvRjZ0RUqhGy8DBPEexcqN9F1OviN48MZ
 F479ZtpytKNQHVs/eg/FqHWv8JRFRuyjI+gbMhfCVVYZ9J/a166BBMhiMrfHwKtDr7Rm
 t7d6SX0uvbxpZ4IF3JOw/2JkJtDeCTb2ZErP531gDTrJn3+sodMZVFxowJrQMF3yzS3I
 imZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698489199; x=1699093999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9D0IAeyBl7tCHLFuwBJ3K5ngt4JViKy0HwHpFD6M2Y=;
 b=DL79Ze65JD8BOE5p0mZexZt088KD8a6ywVm94NGgk5Ix8cjhlKSiGGsYBXnhPfWKhg
 MIF+T/Tbs7/Oyb+ba1ylUMkl1FIAQG2NZStQx8YFET0LWJR+nJOURtf/Bpfq1aiiVGk9
 tJoogrDKtdZu4SKHcbiDQyNJh4GFNUuyjqznj4mAj1SFWvg1tqP53kczzM1/SUIvoJWZ
 i0d7BQawwg/W1wXkOV3DrinTLgZuJF7sZBf0u+/KBA7NOvD5afSfqVkeSaXbHIHMREe+
 tem9PkZpRLytOaahV1bFH+8VhewVXi+KmUTThWZpengbOHVFB2PoUDu680Tt4b2LxD0o
 mzSQ==
X-Gm-Message-State: AOJu0YyXaxzHW5yN/y5oGl83toLcR0kDiTQMKaJOWE6EOWBIUwr8nrDu
 mPqcfjB1sDwkNKbu0JT1TYnztA==
X-Google-Smtp-Source: AGHT+IHokqGcLvTFoksdLga3NGQV/4qCBfUzmAdJeFvPPgAzRaKcrKxpfj1+NRgacFOgSg84G/4BtA==
X-Received: by 2002:ac2:495d:0:b0:507:9787:6779 with SMTP id
 o29-20020ac2495d000000b0050797876779mr3445417lfi.3.1698489199359; 
 Sat, 28 Oct 2023 03:33:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 y15-20020a05600c2b0f00b004083996dad8sm7108076wme.18.2023.10.28.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 03:33:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 638545F798;
 Sat, 28 Oct 2023 11:33:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Brian Cain <bcain@quicinc.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alexandre Iooss <erdnaxe@crans.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Thomas Huth <thuth@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 14/17] gdbstub: Check if gdb_regs is NULL
Date: Sat, 28 Oct 2023 11:33:08 +0100
Message-Id: <20231028103311.347104-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231028103311.347104-1-alex.bennee@linaro.org>
References: <20231028103311.347104-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Fabiano Rosas <farosas@suse.de>
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


