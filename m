Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28227790AE2
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfIr-0003pJ-C5; Sun, 03 Sep 2023 01:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHb-0002nK-1y
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHS-0001ja-BX
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-26d50a832a9so131201a91.3
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717453; x=1694322253;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9d6aW7COZ2ZoNdM064WJALRoTYWHhNAcAt6IyieBwY=;
 b=NH+OtUxKGZ3DfReJ1ej2SFmUpSPs3+GXstNi0StLPhDvoiP3hgLqp03PuTrHQyEj3R
 oT20d2yTD+hygRcep17peaK8ovYQUBppMyrcpFwZKjvr/Nx6r+ssxoaOPiut2ccTy2uv
 YmU1pO0KIqCgqUs993KLuYNew/3gPcRnPH6/ViJ/tAq9CFVsJzzaPM+bM+BkP3NU/8WH
 pDzi8Z+mlzgmGrrpV0VZYKpFegtAQJxVzaohtbB9W/u1dCyv24uyKP2LN93WpRZQj2iW
 PYzfj5jbXieCv01yyj/rp7CwramZWb/UzSl0g5G1R0oneyVQNzUJXWLSGntuSQg2VDH/
 Wz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717453; x=1694322253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9d6aW7COZ2ZoNdM064WJALRoTYWHhNAcAt6IyieBwY=;
 b=hT5hoITYxuyjVGrOm1gsFDEff1Z1KLeXVrhV9sRuV6naYrGkYXGMIKsl58iMVtyEZd
 0wlocZgTb9gY+DypiHhOEjBLPig49RKFo+yv7XhGuNOIDtHAvCahINDxipFBrOPh+y2D
 1MqjRs8+7ZWmhyHbp9nJ9QwVaBt0YJ7+SXaL+7XH1+EmhTYThRVIK1wrSdxaO4RRxCWy
 FsmaZipP2IrrYTzV0SWnABsWF8BtT3zSB3CFR2Ww58bvic2oXNg/vNNEWuUcr8oHzJSi
 nziMyPbsXHbT//MnXdX4HgHW6qO/ACu7SeXr4cQ04WSjJeWMypTNObZaAU+u74LwvSG5
 /fDg==
X-Gm-Message-State: AOJu0Yz9uJhGYlrw/i4u1moxzpQ6i1ECBRJMksjPEKVn1DXUKt6Ultff
 f8t7e8XSI7KV7uCmUZQA8CnHy5VBvlsscZjmR5A=
X-Google-Smtp-Source: AGHT+IHQz57dp6MhAh9h6wrCza5dHQYyC+n6rjRkwGMLiiK4Y3rv+FrCr5q3jdX5MBFSA3P/hoVfMg==
X-Received: by 2002:a17:902:e850:b0:1c0:c174:3695 with SMTP id
 t16-20020a170902e85000b001c0c1743695mr6400600plg.13.1693717452886; 
 Sat, 02 Sep 2023 22:04:12 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:12 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/18] gdbstub: Use GDBFeature for GDBRegisterState
Date: Sun,  3 Sep 2023 14:03:17 +0900
Message-ID: <20230903050338.35256-10-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
index b641e87fd1..1c5cbc0472 100644
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
     struct GDBRegisterState *next;
 } GDBRegisterState;
 
@@ -389,7 +388,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                 g_ptr_array_add(
                     a,
                     g_markup_printf_escaped("<xi:include href=\"%s\"/>",
-                                            r->xml));
+                                            r->feature->xmlname));
             }
             g_ptr_array_add(a, g_strdup("</target>"));
             g_ptr_array_add(a, NULL);
@@ -497,7 +496,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->get_reg(env, buf, reg - r->base_reg);
         }
     }
@@ -515,7 +514,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
     }
 
     for (r = cpu->gdb_regs; r; r = r->next) {
-        if (r->base_reg <= reg && reg < r->base_reg + r->num_regs) {
+        if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
             return r->set_reg(env, mem_buf, reg - r->base_reg);
         }
     }
@@ -538,17 +537,16 @@ void gdb_register_coprocessor(CPUState *cpu,
     p = &cpu->gdb_regs;
     while (*p) {
         /* Check for duplicates.  */
-        if (strcmp((*p)->xml, feature->xmlname) == 0)
+        if ((*p)->feature == feature)
             return;
         p = &(*p)->next;
     }
 
     s = g_new0(GDBRegisterState, 1);
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


