Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04197CF549
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:29:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQGo-0003RI-N4; Thu, 19 Oct 2023 06:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQGM-0002UN-0F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:28:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtQGG-00075J-Mt
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:28:20 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so30885275ad.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697711295; x=1698316095;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=neA3tVfjCWiMkdVl5m0Guhwhbyf7MLdXa9fQiEmZPfM=;
 b=wqrxRiN6/Y9pHo+hDQZDXC8UnwmU+AgRzzKl/0rUgVYNl/evEzmPezhdSBZ/664eIt
 t/3SGXvj2ibvETsWNDVpguN4NKEPO3lh+Mijm9TnYCil5Mr4tnuXdze4Ak47qdkhF2op
 Bf2c4F0jY2W3pTr/mVJLdBaQHTfFGQosseNMO4nFUF6FW7DTFGHP8XFagKXx6wZwtgY7
 TAOO9QRybOAe9/gzIaqD7Ewfxl/PBHDynLKGy6c2TzoH7ErtZg7KR2cIUlKjEnq8fSS3
 fNJIZB8RnDF2ViTMOqqrTpCoq/TYGKuqaHu8+OAGWR6nfVdkrz2anw2RRTZdIJyiH7j0
 NnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697711295; x=1698316095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=neA3tVfjCWiMkdVl5m0Guhwhbyf7MLdXa9fQiEmZPfM=;
 b=P+dlz50tikc9YIAixu+EvHHM/UjnJBxSB9uJ49n21UFcqO+JLWPXp5blPBbG4igaky
 qQMtLguQN/SG51vNCaNZDF4YFQiMqDgzt9kC7tzsAWXc8lLZEBGT7ynx/PQ4B4hwsT89
 4SI6IZiDotepT4RpTnqzCJVEOMKwhK1IzX1uVqrAP+HcsnUr81SfK3rcZTDBJF5Td0GA
 LFFVqpSkmaX8xZLobbMbXmYvsM60si5j67gUP2iyP8speh6WTmQaDkBtdZFlx1y1X44j
 QZ8HNJlwqwTWD0TnnVb/tZiULKdUxLWICFKAz97DDltAVmvG91YcCU8ftCkxzHfTeg5M
 wQQQ==
X-Gm-Message-State: AOJu0YxAYkbA1ulaHBM24FDbKKqhxj3qZ0ddRJVGTkfVMb7CCg8xqEQp
 TmI2xZwqXObT1FBoBKw7fjQSbQ==
X-Google-Smtp-Source: AGHT+IEe2o4hRidgC8/PrYAH9KcpLh2FciOd38Uh5dJBIGeiX4Z6TEaqkda+CP+fYDZKwa74KGdO/A==
X-Received: by 2002:a17:903:5c7:b0:1b8:2ba0:c9c0 with SMTP id
 kf7-20020a17090305c700b001b82ba0c9c0mr1749840plb.59.1697711295583; 
 Thu, 19 Oct 2023 03:28:15 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 w12-20020a170902d3cc00b001c61e628e9dsm1588076plb.77.2023.10.19.03.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:28:15 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v14 14/18] gdbstub: Expose functions to read registers
Date: Thu, 19 Oct 2023 19:26:49 +0900
Message-ID: <20231019102657.129512-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019102657.129512-1-akihiko.odaki@daynix.com>
References: <20231019102657.129512-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index 346151d0f2..308b5c266a 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -74,6 +74,11 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+int gdb_find_feature(CPUState *cpu, const char *name);
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index fade023559..0b64b93960 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,36 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
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


