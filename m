Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278967804DD
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 05:41:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWqJ0-0002It-9G; Thu, 17 Aug 2023 23:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIy-000296-DF
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qWqIw-0005wp-9Z
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 23:37:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68859ba3a93so416062b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 20:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1692329861; x=1692934661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0NKU7+8PklMhREX7m71J4SwqfKAYJNSndr2MPpqcWYU=;
 b=Uc0aabkF/0hsyehNznkB1eKwToMMOGLI74sBVuio8OaLkMPo7wPYJYH5aUEd9BvEbh
 OBNqdanJcPD7PJQ7ZoBNk2GeRFJVKhNFxdS1exKDq3MWSmfA5vvzM/tCl6Qwavx+yOc9
 9MZDx7CbRPzpX29HPNPeZZS/2eEQSpCaculharnjTxZhiO6nbCKghVBXshSkragBfMIF
 qYNWF3P68CGkykkxjvGr5i8EqbhZCdAy81+nPET6yo4UOJuH8lMIJtZawnOxR8AjLzm9
 2poA9GVBHkpqG5ow2lDXbSp4k3+hBGBglx49EH0q5B6fieGlclVl9yw05EWuWsxBu/VT
 klqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692329861; x=1692934661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0NKU7+8PklMhREX7m71J4SwqfKAYJNSndr2MPpqcWYU=;
 b=IRAXYNJCRR22io7eBtDdRpxbK6cmgk65CKekKPJ37xNbAlcLG7/BgFmN7C/NNj2MX0
 8ns5IdJQ38XTybGPYn/OTsBnVUKyODg6pwNas4kJKC1FjdaOh65BX9AeFkbZJHMp8Pfw
 kP/dr+EYNGcUUX7t8iRop/QTmcBvXm9lREISg/vGO8l2wzGCCnSnYePnkj6rgSR02i0O
 uBbg9GQZcWxWEviVvcgpIwlBIf/bUcCVJZh8IEPlThS0Ijwg/ES+c5wVIwQnimTnGMlO
 XpKyobHYeT4kXKX8f6EHJZkzFTpYYQdva8VO4G2wD0imZd1KHLjKR8G5uXeqgg2P5xwp
 VSaw==
X-Gm-Message-State: AOJu0YyDRZsO+8xOPOeBX4DTqfVGoMO7Z0YATV6BYhu2inhuc95f9ai8
 QhtIrIYP/gDPjMDNysni38jk+w==
X-Google-Smtp-Source: AGHT+IFVRtoffXLx7z0xgsKceN+MELgoynnggstgfx3OP5VGUXl0ucDLedfJ0qFMCRF8+OJaA4TftQ==
X-Received: by 2002:a05:6a20:5506:b0:141:d54e:a907 with SMTP id
 ko6-20020a056a20550600b00141d54ea907mr1374711pzb.19.1692329861195; 
 Thu, 17 Aug 2023 20:37:41 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa781d8000000b00686a80f431dsm484135pfn.126.2023.08.17.20.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 20:37:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 15/26] gdbstub: Simplify XML lookup
Date: Fri, 18 Aug 2023 12:36:34 +0900
Message-ID: <20230818033648.8326-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230818033648.8326-1-akihiko.odaki@daynix.com>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
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

Now we know all instances of GDBFeature that is used in CPU so we can
traverse them to find XML. This removes the need for a CPU-specific
lookup function for dynamic XMLs.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 gdbstub/gdbstub.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 031ad89c7d..4648a56088 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -354,8 +354,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
     size_t len;
-    int i;
-    const char *name;
+    GDBRegisterState *r;
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
@@ -364,7 +363,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
         len++;
     *newp = p + len;
 
-    name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
         /* Generate the XML description for this CPU.  */
         if (!process->target_xml) {
@@ -398,21 +396,15 @@ static const char *get_feature_xml(const char *p, const char **newp,
         }
         return process->target_xml;
     }
-    if (cc->gdb_get_dynamic_xml) {
-        char *xmlname = g_strndup(p, len);
-        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname);
-
-        g_free(xmlname);
-        if (xml) {
-            return xml;
-        }
+    if (strncmp(p, cc->gdb_core_feature->xmlname, len) == 0) {
+        return cc->gdb_core_feature->xml;
     }
-    for (i = 0; ; i++) {
-        name = gdb_static_features[i].xmlname;
-        if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
-            break;
+    for (r = cpu->gdb_regs; r; r = r->next) {
+        if (strncmp(p, r->feature->xmlname, len) == 0) {
+            return r->feature->xml;
+        }
     }
-    return name ? gdb_static_features[i].xml : NULL;
+    return NULL;
 }
 
 void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
-- 
2.41.0


