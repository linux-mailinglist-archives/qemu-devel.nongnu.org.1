Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A17A2E7A
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQGh-00043F-TE; Sat, 16 Sep 2023 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGf-0003vs-GB
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:03:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qhQGd-0006CK-SH
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:03:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-577f6205f42so2151346a12.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 01:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694851382; x=1695456182;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EJB9NYY0WJP2DG5WyP6qLUa7eNIynRr75aERnm1lLVY=;
 b=tpPh0kZ0DaKdpuZkirxZ5cYHgzExt/y8AY7Sg85iGUNk1ups71COwkSulRR7DVZJKb
 ZE61O1uRDwCV2KtR2K0G5tC0Le1SI1rN0cp+QL6yXWnjKVc0g7UU3uIEEQS40llZF2WR
 v7au6WuayMOLKIWAeIPtcjvtGN3b+6Tv5DUtLlSun8PePuM0P+t8RnL4c1t5RcciONdi
 kt9Gh9Am8bpiQ12X8jkRytp4M+rODclSFRfgyR3VBlbprZT1AieHX4GjzMAuYyVPlZha
 KqELgrY1Fs9l+ZgWhozkAX9iNfq4Q0XHQBBcvz5Mi3GzFJ3Bxh4MkMAe6LfYU0hV3Npg
 WY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694851382; x=1695456182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EJB9NYY0WJP2DG5WyP6qLUa7eNIynRr75aERnm1lLVY=;
 b=k9xW7VCazneqX07YLCVeb0jKBPHCnluE2nMeNjUz4DsXQPcBOeYsSh/vcCV6Eh+RjO
 m/a3f6ZobraURManZ3/WDgmIyc7mtr8oYvEix8zuaBwoYb+mTPO7vueN8rRwen6RUZtD
 +9lkTicPImdaovPEscadCdUuBK0d1pJb8ww6YiXJM1IsCR2X/RpY3hh7J0dAq1TEF5Hi
 qcD5rq7iN0FqKrQR4r8nM8DlgfIZZsmpIwHpqXWmAzs1o9IBoUow9QD8hfY8PvrPGevp
 3sEdnMfIrD6O+Q1rCB4O+EbQNHoGVLw+nAzaglUkPLoA8K6mk8qN9W/XrIQVRqPGTufE
 Fqjg==
X-Gm-Message-State: AOJu0YzKpZCF5TkLbGl7vjhjoZs9EKHrEVbQpyrO7ZMJAJbxnu1c1qo4
 E2recmBac92AxBbGhu/IaWPLUKeJRaQVr9huOW0=
X-Google-Smtp-Source: AGHT+IF3RPreAgSiJDaAIfs2imYhzJJa9X6frj0p7+YWsp+7qFQQRJR5zD0IcW+UxanRyQxRDO+P7A==
X-Received: by 2002:a05:6a20:ce89:b0:104:ad71:f080 with SMTP id
 if9-20020a056a20ce8900b00104ad71f080mr3733107pzb.34.1694851382485; 
 Sat, 16 Sep 2023 01:03:02 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b0068a46cd4120sm4029484pfa.199.2023.09.16.01.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 01:03:02 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v8 14/19] gdbstub: Expose functions to read registers
Date: Sat, 16 Sep 2023 17:01:31 +0900
Message-ID: <20230916080149.129989-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230916080149.129989-1-akihiko.odaki@daynix.com>
References: <20230916080149.129989-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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
index c6dd5fcd51..8667f44fc6 100644
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


