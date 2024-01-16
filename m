Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D1B82ED12
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:51:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzq-0002Ug-Pw; Tue, 16 Jan 2024 05:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzf-0002Mj-Ks
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:31 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzb-0007GX-IN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-337bcf021a4so198246f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402104; x=1706006904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f7sYh7/yJg46pVUox/Ns3YAJxBRGUXkGB3xeVM8MLRA=;
 b=RbHQneGwKA0o6RMtnpS3gOoPxT5QJEHdGKytX2Pg7wkIhBp1Yw3itiEJUixMrDzogS
 tL8JGhc4Z5IGvM60kDPBMDKwcECVMP6PQDImT0/IgOPWJ5WbRRlxZ6Vaf4o9mv9R80CD
 C4m4kJKknTwQ0eTr244MmDfh61gMm/2gpapJeaTXuQy6QDuxWXX08ZThcj18H2CUhJlM
 +azfly+Ui3IU1pnWRnXQuAZH5eebumlZ3ImEdZ3izIOL8HNIOtodGKxnp3ni0dq0FTE2
 bnvF2dTSxPSucGJdaRPXzRRwaJZ8rw49xAqIblwMFL9pHNZFYEifbSdCA9NCxUacZuch
 G93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402104; x=1706006904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f7sYh7/yJg46pVUox/Ns3YAJxBRGUXkGB3xeVM8MLRA=;
 b=wIhSSNsw6Rie9yKHiDpguwZQKFaMXm/mg8eVz8IE5nZs6GkwixvgmOQcwp2eR+//CM
 y6OzCRpD2jipLVOQgpHTs7m3r75rtj0qozZzjJO1mZE4/d02KBOuLPmXqDIA6LYwXtR1
 2/qxZ8LIQctWuLxgy4dA6PSusON9b6pRucvE6dXBUOCWgo+fVVlNSt9LD544HhUaZ/Xr
 cbCzc65ci73mFAZrGyYlS7cjTiFTjdi1Oyu+FGcB1rxQRsA8wnl6MboIdQxEd64SjSoj
 vvgPMNauwmhbLGQf+XHljXFi9lM5xaWWgAkfohkLiYOgaGbKbTrxch8t+pHO0PAHRw/1
 1Wiw==
X-Gm-Message-State: AOJu0YzgKT5NFMYAg9abbRYs7077sDJ5xOpOwJ/CQzSo8TT/8ogRQO4Z
 tpjStBcRgNOW2q7qPnZX6CrLqAmNHaOG5TKUG4x4QD7MwZo=
X-Google-Smtp-Source: AGHT+IEZwxF1UH4qontd+jqwQzdBVxI0o63uip1ADN22ZQOpBpQkeayBzUqtQgPAuyp/ZmnfV2qpSA==
X-Received: by 2002:a5d:43d0:0:b0:337:4913:2a1b with SMTP id
 v16-20020a5d43d0000000b0033749132a1bmr4477140wrr.118.1705402104661; 
 Tue, 16 Jan 2024 02:48:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 v3-20020adfedc3000000b00337bcbd0968sm937770wro.104.2024.01.16.02.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:20 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0FFD65F8FE;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/22] gdbstub: expose api to find registers
Date: Tue, 16 Jan 2024 10:48:03 +0000
Message-Id: <20240116104809.250076-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Expose an internal API to QEMU to return all the registers for a vCPU.
The list containing the details required to called gdb_read_register().

Based-on: <20231025093128.33116-15-akihiko.odaki@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-38-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index da9ddfe54c5..7bddea8259e 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -111,6 +111,53 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder);
  */
 const GDBFeature *gdb_find_static_feature(const char *xmlname);
 
+/**
+ * gdb_find_feature() - Find a feature associated with a CPU.
+ * @cpu: The CPU associated with the feature.
+ * @name: The feature's name.
+ *
+ * Return: The feature's number.
+ */
+int gdb_find_feature(CPUState *cpu, const char *name);
+
+/**
+ * gdb_find_feature_register() - Find a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @feature: The feature's number returned by gdb_find_feature().
+ * @name: The register's name.
+ *
+ * Return: The register's number.
+ */
+int gdb_find_feature_register(CPUState *cpu, int feature, const char *name);
+
+/**
+ * gdb_read_register() - Read a register associated with a CPU.
+ * @cpu: The CPU associated with the register.
+ * @buf: The buffer that the read register will be appended to.
+ * @reg: The register's number returned by gdb_find_feature_register().
+ *
+ * Return: The number of read bytes.
+ */
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+
+/**
+ * typedef GDBRegDesc - a register description from gdbstub
+ */
+typedef struct {
+    int gdb_reg;
+    const char *name;
+    const char *feature_name;
+} GDBRegDesc;
+
+/**
+ * gdb_get_register_list() - Return list of all registers for CPU
+ * @cpu: The CPU being searched
+ *
+ * Returns a GArray of GDBRegDesc, caller frees array but not the
+ * const strings.
+ */
+GArray *gdb_get_register_list(CPUState *cpu);
+
 void gdb_set_stop_cpu(CPUState *cpu);
 
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 420ab2a3766..b0230138246 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -490,7 +490,61 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
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
+GArray *gdb_get_register_list(CPUState *cpu)
+{
+    GArray *results = g_array_new(true, true, sizeof(GDBRegDesc));
+
+    /* registers are only available once the CPU is initialised */
+    if (!cpu->gdb_regs) {
+        return results;
+    }
+
+    for (int f = 0; f < cpu->gdb_regs->len; f++) {
+        GDBRegisterState *r = &g_array_index(cpu->gdb_regs, GDBRegisterState, f);
+        for (int i = 0; i < r->feature->num_regs; i++) {
+            const char *name = r->feature->regs[i];
+            GDBRegDesc desc = {
+                r->base_reg + i,
+                name,
+                r->feature->name
+            };
+            g_array_append_val(results, desc);
+        }
+    }
+
+    return results;
+}
+
+int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
     GDBRegisterState *r;
-- 
2.39.2


