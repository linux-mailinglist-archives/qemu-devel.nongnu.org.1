Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF6E790ADA
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 07:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcfHd-0002nl-Ge; Sun, 03 Sep 2023 01:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHb-0002nL-2C
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qcfHU-0001jw-9r
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 01:04:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68c3ec0578bso216921b3a.2
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693717455; x=1694322255;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1mkn/V0r0Jr6wdvuAVRS6mHE3ZGJk5Q/W9mTLEXS8s=;
 b=rnOW/y6H5lsfCfZp8T5q+nHfzK9nS8OYyg5a1DC24cRv+6z6RU2QQUiEKTSCwl/v1w
 HiVmt0zV0PVYLrDabOIADJJaKsm6gpuXlxLLqths4TuwQsJAq0wCb2oAMRNKvf7v1tmj
 DwB4y1jWiRkZEsp6uxb62bo6DjjwWlJYODQec/gI/DBk7/sSHhJQoKXEP6LH0WoLpTiR
 KVRBqZ3ndotD4TOLfqUoSvyDBKdrkGVD9Y9WeZU3SVXD3yZh7RGLKIsoAN4t5yyZ6TCT
 1qYQgwW9RDinSONWU2HrkHBn8xvz8Pmc8LY4kpMCtPXFetwETPNWvRaxd4OoEHOs44Nh
 rrkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693717455; x=1694322255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1mkn/V0r0Jr6wdvuAVRS6mHE3ZGJk5Q/W9mTLEXS8s=;
 b=ItJHlXnzUkOAshwqAg7395glyiYycs7pdnQfPzDLjd7CkGeweY7c8EdN2hHKPBjBV4
 MOC/mTlGaBk3lY+Cs7oYjU/zEV4f9/oN0dLPhKJCuyMNfg3lKVeyAsTkBzXWIpMnQkdw
 1QDGqVrXVSZUTzmLWGPXs5seOiHHWBMs7IONGNA7GZ/MMAGrEUus34pGmUeLk7iSa0UK
 1LM9CH3T7h/Wh/f6cZU9LdYccP3GIerC3HOXJkb1ej3VISOJ8CX4E5oobhnsdHbzdxva
 03mkFyIIhENOoVDYTf9DTkGt5FI2dbrvhgfR5hTup348gyHhwRqKl8Joi9aqXMYwzUxI
 JjoQ==
X-Gm-Message-State: AOJu0Yy3B6Suh6cmy8xIZDCmkJIFBln3gMG311en+qg4W41ZGI2ARIAU
 EmJHYCWp89B0rFe2lvaHESSf3A==
X-Google-Smtp-Source: AGHT+IFhY55JmrVCxloPw5/LgKml0LZDeSI1ZtmfEBlzPzJAKK5o9BNrT26NBAT4qF1UfXQb7l109g==
X-Received: by 2002:a17:903:244c:b0:1c3:2df4:8791 with SMTP id
 l12-20020a170903244c00b001c32df48791mr1382538pls.27.1693717454915; 
 Sat, 02 Sep 2023 22:04:14 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 l11-20020a170902f68b00b001b8af7f632asm5324835plg.176.2023.09.02.22.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 22:04:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 10/18] gdbstub: Simplify XML lookup
Date: Sun,  3 Sep 2023 14:03:18 +0900
Message-ID: <20230903050338.35256-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230903050338.35256-1-akihiko.odaki@daynix.com>
References: <20230903050338.35256-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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
index 1c5cbc0472..6c8816e3ad 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -352,8 +352,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
                                    GDBProcess *process)
 {
     size_t len;
-    int i;
-    const char *name;
+    GDBRegisterState *r;
     CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
@@ -362,7 +361,6 @@ static const char *get_feature_xml(const char *p, const char **newp,
         len++;
     *newp = p + len;
 
-    name = NULL;
     if (strncmp(p, "target.xml", len) == 0) {
         /* Generate the XML description for this CPU.  */
         if (!process->target_xml) {
@@ -396,21 +394,15 @@ static const char *get_feature_xml(const char *p, const char **newp,
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
2.42.0


