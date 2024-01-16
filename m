Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D08482ED0F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:51:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgzs-0002Vg-En; Tue, 16 Jan 2024 05:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgza-0002Jw-Fb
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:29 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPgzX-0007Eq-FL
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:48:25 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337be1326e3so193619f8f.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402100; x=1706006900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WXlu1ODmIM2n8n9HtvywmjBvYQfBPf/Umqu0tSyPVxc=;
 b=KUlDkGEDeOwSlO8JJ+v34cwd12J0LHSLlhlXWMfL5B+MOwhDMcdbIaQXQHMRdYEsou
 zzezUKmJiLk8oW0KODeqiQuFniyL0nxyGWGmIGV2KpqhknLWp/VOrJiYEOiuihnVew5V
 wcKhkZEHWoAINNmpr70M6XJtlzumbwVCxD+Z5C1XdVTp7kiKZSu05yx7t7kTpLvZn3ob
 k1bC753XRi+kbMYVX6bDbkORnl8syeupR0YaDckD9JH8zSaBjiVPqbOurTaSfr0IdvtL
 sNaZsGjT9kxNCBkKk17NuVoI69ULhAwox3xOH96K2dBlsUhhTCy0G2DQGaArhnItOjtb
 3odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402100; x=1706006900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXlu1ODmIM2n8n9HtvywmjBvYQfBPf/Umqu0tSyPVxc=;
 b=UzK2nsdk3t2rYnTQOKwAEfvjm56peR3q4/K+cv5mYaLTK5sAIk0l+hQZY/lO5ilxwp
 +bK2hTbW/R/geB32M8AJSxKaBcva+v1/vRhLJpJ94+vgQdSvlqvFU1JUR8Uuaw67Xurm
 hSDqNv1VaFAktF31/21U+KOlwZx0vHKbX8noOpXtt5fVwJh3hboHwEQMvnxlaZfDOHNj
 X48kxJaktE6p4xgiVbpN/MtUy4VGmX5r4S2nzVDgIp05+xyg/MXFXu2JN0ui9FHUAXqU
 2ng74xSljijotC5SgkmJPd+VGAnzNavttZmTGZoDnqzZdzCIj3av7qM0dQpbCBe7y0w8
 l/xw==
X-Gm-Message-State: AOJu0Yz/wvo2uYhZ/iS5RcAcszrPvv1M4LfNL5/6qM+qSQ1YovZreEh0
 YezXvCX5le6gQzwKEShbPwGhld/4Nyq8dAomohW2LrYdTro=
X-Google-Smtp-Source: AGHT+IHei2Msy+m76CpfxmmC26Vg44YsN+gW+2wtPal0fRwciHPSr+IVTWT0JlOxUx1tEZ04Vl/m4w==
X-Received: by 2002:a5d:488b:0:b0:337:afb7:1acb with SMTP id
 g11-20020a5d488b000000b00337afb71acbmr821540wrq.114.1705402100525; 
 Tue, 16 Jan 2024 02:48:20 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 f3-20020adff983000000b00337bc2176f6sm1089128wrr.81.2024.01.16.02.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:48:17 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D1EA65F8F9;
 Tue, 16 Jan 2024 10:48:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 14/22] gdbstub: Add members to identify registers to GDBFeature
Date: Tue, 16 Jan 2024 10:48:01 +0000
Message-Id: <20240116104809.250076-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

These members will be used to help plugins to identify registers.
The added members in instances of GDBFeature dynamically generated by
CPUs will be filled in later changes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-36-alex.bennee@linaro.org>
Message-Id: <20231213-gdb-v17-10-777047380591@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 82a8afa237f..da9ddfe54c5 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -13,12 +13,15 @@
 typedef struct GDBFeature {
     const char *xmlname;
     const char *xml;
+    const char *name;
+    const char * const *regs;
     int num_regs;
 } GDBFeature;
 
 typedef struct GDBFeatureBuilder {
     GDBFeature *feature;
     GPtrArray *xml;
+    GPtrArray *regs;
     int base_reg;
 } GDBFeatureBuilder;
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 801eba9a0b0..420ab2a3766 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -419,9 +419,10 @@ void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
     builder->feature = feature;
     builder->xml = g_ptr_array_new();
     g_ptr_array_add(builder->xml, header);
+    builder->regs = g_ptr_array_new();
     builder->base_reg = base_reg;
     feature->xmlname = xmlname;
-    feature->num_regs = 0;
+    feature->name = name;
 }
 
 void gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
@@ -440,10 +441,12 @@ void gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
                                     const char *type,
                                     const char *group)
 {
-    if (builder->feature->num_regs < regnum) {
-        builder->feature->num_regs = regnum;
+    if (builder->regs->len <= regnum) {
+        g_ptr_array_set_size(builder->regs, regnum + 1);
     }
 
+    builder->regs->pdata[regnum] = (gpointer *)name;
+
     if (group) {
         gdb_feature_builder_append_tag(
             builder,
@@ -469,6 +472,9 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
     }
 
     g_ptr_array_free(builder->xml, TRUE);
+
+    builder->feature->num_regs = builder->regs->len;
+    builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
 }
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 68d0fdc1fd6..d9b52ffd09b 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -266,11 +266,9 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs, int base_reg)
         }
         predicate = csr_ops[i].predicate;
         if (predicate && (predicate(env, i) == RISCV_EXCP_NONE)) {
-            g_autofree char *dynamic_name = NULL;
             name = csr_ops[i].name;
             if (!name) {
-                dynamic_name = g_strdup_printf("csr%03x", i);
-                name = dynamic_name;
+                name = g_strdup_printf("csr%03x", i);
             }
 
             gdb_feature_builder_append_reg(&builder, name, bitsize, i,
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index e04d6b2df7f..807af0e685c 100644
--- a/scripts/feature_to_c.py
+++ b/scripts/feature_to_c.py
@@ -50,7 +50,9 @@ def writeliteral(indent, bytes):
         sys.stderr.write(f'unexpected start tag: {element.tag}\n')
         exit(1)
 
+    feature_name = element.attrib['name']
     regnum = 0
+    regnames = []
     regnums = []
     tags = ['feature']
     for event, element in events:
@@ -67,6 +69,7 @@ def writeliteral(indent, bytes):
                 if 'regnum' in element.attrib:
                     regnum = int(element.attrib['regnum'])
 
+                regnames.append(element.attrib['name'])
                 regnums.append(regnum)
                 regnum += 1
 
@@ -85,6 +88,15 @@ def writeliteral(indent, bytes):
     writeliteral(8, bytes(os.path.basename(input), 'utf-8'))
     sys.stdout.write(',\n')
     writeliteral(8, read)
-    sys.stdout.write(f',\n        {num_regs},\n    }},\n')
+    sys.stdout.write(',\n')
+    writeliteral(8, bytes(feature_name, 'utf-8'))
+    sys.stdout.write(',\n        (const char * const []) {\n')
+
+    for index, regname in enumerate(regnames):
+        sys.stdout.write(f'            [{regnums[index] - base_reg}] =\n')
+        writeliteral(16, bytes(regname, 'utf-8'))
+        sys.stdout.write(',\n')
+
+    sys.stdout.write(f'        }},\n        {num_regs},\n    }},\n')
 
 sys.stdout.write('    { NULL }\n};\n')
-- 
2.39.2


