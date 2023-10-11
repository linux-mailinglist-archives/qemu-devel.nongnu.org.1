Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FF07C4B28
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:06:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTGo-00080X-AZ; Wed, 11 Oct 2023 03:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTGl-0007wE-7b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:04:35 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTGj-0005qO-1U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:04:34 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57bca5b9b0aso3606484eaf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007871; x=1697612671;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlYmSExF9OA8PmNERjADq51WxQfZ83JfKJQYueZPenE=;
 b=qdsUTn/+vA04aQ6Xk8yfRTLQIj/tG/XgfT5dnClRckLzQZC3aLwiM6lnMTwwhMGpS+
 MwGJRGgNdYyx8bGfwUz26yzbdWttQTrey3qwzjSx8f35snjf095LCyex4/kpkq9DZ6G+
 I3Oi/qudS55UY7ATXiLg3Dcr82+bosOW1cffSCFNjtxQZhXBuNkO2TMdc7ek+yEoCJKt
 gwO0KRtxKn+wdecNEfPzdAzGNfL8oqqH5j4Z/65Cezcna9C6NWrYKU+6kKyswAmXAITL
 gIHAOVHrcm+u8qxfSvvbiNwYULGmtj0pTcbNk87OYhK8CVViMuib4zJoWofE+GdzoByH
 uCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007871; x=1697612671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlYmSExF9OA8PmNERjADq51WxQfZ83JfKJQYueZPenE=;
 b=Ez6NxmH7ByuIMMntCcmM4QmOFsG+bDR7vFKyjzQPzBtumhzLPVbmSYJAy0lzDmhQg0
 6aqzQmc/1X9/WorlJM+qmZUVp5DuA1tqTZLG5JgYkz/kDAbLgVgjWJL8cJ0jJAf/1Zee
 D63wWigwa5c3W3zkKbKONJCfBYpRKQqeVbE0BO2d0VZeWUL5YrQCIfcVXR7vvdIOFCHl
 z1Sv44An7FwMVPKfzQ8fiKUzMw7lyZCNWMm7TjqEhMVr8XLrG9muOaV4zLC6hz8GNHQk
 PyHYfyXqpiQx7BWdDNz3cVAQJOf7bCsoCB67xICqR4tYUwzpTBLdP/NyUsjhMrK1CKHz
 ETAg==
X-Gm-Message-State: AOJu0Ywa3gv/5Ot44DxKH7+hB50vcA5UIpQDAerKe9NVFGQZQJOMOzmL
 64aESnJhIziaYVD3jkWj3/VZBJdbc/095YRzTRQ=
X-Google-Smtp-Source: AGHT+IHtZqxJcQ5Q0j1W/dIdHSz/CtIG6SOhfYQTuIT78ZmLscGJnKefJwrVoMLj2ovASToQM0Vgsg==
X-Received: by 2002:a05:6358:7e07:b0:134:c650:cc0a with SMTP id
 o7-20020a0563587e0700b00134c650cc0amr24131232rwm.15.1697007870741; 
 Wed, 11 Oct 2023 00:04:30 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 q15-20020a62ae0f000000b00690c4577101sm9673982pff.140.2023.10.11.00.04.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:04:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 11/23] gdbstub: Use GDBFeature for GDBRegisterState
Date: Wed, 11 Oct 2023 16:02:57 +0900
Message-ID: <20231011070335.14398-12-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc36.google.com
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


