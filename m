Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760E7C4B2B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTHS-0001SP-JU; Wed, 11 Oct 2023 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHN-0001K3-CD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:15 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHG-0005zy-AW
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:12 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c5bf7871dcso49130675ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007903; x=1697612703;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QGK8Ihlsb00qVW80GmcwlKwwhTUXa7TZjGRxpSWPCY=;
 b=m5GR59PfM0XbzALzFsb/0h07UmhmfxzlNuCV9709FCJ5r4aAoQ+EXMCEMl3tJDXF5V
 vPxh48oSafKwxG7DRJjU//CklZTDloUf1CyjLTE6zSL1C3/nj2p79kEu3mMWR4hCdX1x
 CgXGg2JcdXqzjym2d3V8WeQ4JA25RqDrsrX8hHksqrv+ja8HiCWEFuc+KE+TMZLzj853
 UPSJpT/LUzgc+faTB8mnKiF40+wrG3V3Gy+h48mKfwPjc/g/SvoDumglRy/Yx6MqPJtt
 lNQWPbvqB8PBoHlaLX/CfIMH2a/aQ1UMvhDveUQ8JIUZ1LksrXCITTfk6b1Us1ZszlyC
 YLyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007903; x=1697612703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3QGK8Ihlsb00qVW80GmcwlKwwhTUXa7TZjGRxpSWPCY=;
 b=t9FKCrk+6hBHxkvGHqhriE4hB3EOEQFImutm58V268Cj+uMOSnHWk+3QRQ57w7WgTw
 nWX3S7p8NsTzO3NmVALptuiyy1nWawuAZnkj1+oohlgi2eHiAdW3qoP45yFnEAOIf0vp
 qOWHtFb8jMGd5grRiOWtiG4osP4IJNdxI51NXCBIicUIreljHQ7VaRnUtmoIIjfv6z92
 wlTUZduKTARwVM5BfwtBYUUMjTB806y9d3nGvkJuSzpMTPDzQ7t5ZOj/nLqS5hsGcUQW
 El2wUcDU5V2FyKvXvmGwOzWkZnPx3rVQvhG1UbUIu/jvhUJV96wnZaXBFcnolPTqs+ZO
 1unQ==
X-Gm-Message-State: AOJu0Yyw2dxqWswzYL6GGY2dN2TOkthm1QLl7i1CLPXwd6ZmHuyCUL9i
 mAt3JShqw6KMY9+65DcqaCPaNw==
X-Google-Smtp-Source: AGHT+IEYUI+gt79KRLMjK+SvyHr4V8KclqE74UTqnYzVoG4kCTGnLZtI8dCWP4N1UjspSnLJX6mQxA==
X-Received: by 2002:a17:902:ed54:b0:1b8:76ce:9dab with SMTP id
 y20-20020a170902ed5400b001b876ce9dabmr16869618plb.41.1697007903498; 
 Wed, 11 Oct 2023 00:05:03 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 d3-20020a170902c18300b001a5fccab02dsm13107661pld.177.2023.10.11.00.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:05:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 17/23] gdbstub: Expose functions to read registers
Date: Wed, 11 Oct 2023 16:03:03 +0900
Message-ID: <20231011070335.14398-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
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

gdb_find_feature() and gdb_find_feature_register() find registers.
gdb_read_register() actually reads registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h |  5 +++++
 gdbstub/gdbstub.c      | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index b2b2675f6f..d73abfbd44 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -71,6 +71,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 987af2298c..a3fc65ec86 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -484,7 +484,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
     g_assert_not_reached();
 }
 
-static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
+int gdb_find_feature(CPUState *cpu, const char *name)
+{
+    GDBRegisterState *r;
+
+    for (guint i = 0; i < cpu->gdb_regs->len; i++) {
+        r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
+        if (!strcmp(name, r->feature->name)) {
+            return i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name)
+{
+    GDBRegisterState *r;
+
+    r = &g_array_index(cpu->gdb_regs, GDBRegisterState, feature);
+
+    for (int i = 0; i < r->feature->num_regs; i++) {
+        if (r->feature->regs[i] && !strcmp(name, r->feature->regs[i])) {
+            return r->base_reg + i;
+        }
+    }
+
+    return -1;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.42.0


