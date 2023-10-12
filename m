Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00F7C64EC
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoaa-0003EW-Dr; Thu, 12 Oct 2023 01:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoaY-00034p-9K
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoaU-0007Ob-I3
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:25 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c77449a6daso5225725ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089821; x=1697694621;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N3ims8IBzC9sPLeYdzCFWkRbDYq/1Lyx/AKJa19IQII=;
 b=py77Fn/opxCr29YEvJ2Nyz1kFccRHJ4+sz4AzumW/yAlDZGWU2aH1R61YmVPn9MLFY
 vNUDdOPx7rmgvempWpJUS/wP9XJw1gbuMJao0r+oUo+9w999OnS8Pv2Bpix5jnXCKaRP
 RvvjCESFoaU2L9gHejvz2dHEZctkqiARLySlN0B1AxhHodmbp84UeHc0B4e9xPcV8HYA
 5sqjHKVpIz5f0VR6e1nKl9xU72gfYUax5W40DetRurQWTpv8nPfCcuDL+lAOIy9oD7wF
 WEtwPCe3kkkt3YvKUMG8m0myOyMK/JhoSiWeHsPDcCNtsSn9zyc1iD3iq2VHWJG3z0Aa
 Rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089821; x=1697694621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N3ims8IBzC9sPLeYdzCFWkRbDYq/1Lyx/AKJa19IQII=;
 b=Z/4rw26ApYelOghcVhoqgj3w3ObwI6/slt7NUxVXtxdaUhHSSE0gGn0ffCjcGFzRIn
 SPqR1m7nhqUawMGpyzNz24puOAvRiQD/sgOHuYxlFxFHxluFwfHtewASeb5P+qBpPxHb
 KBE2qNOhfk0TeXotkjCJGgmlHuIvhiuqXUemCZDrrJyoxshhLZgCljdFPzCVrLfeVx+Q
 3dA/VdgGPYgeyMDoq5auJDVwFGlJMwBiuWLe5gU3bMR62Mts/vkzzBpDsvaL73qN9COU
 xDO4KOCqKGW4nFVoj+y08CprZh2yRCAk0l8ixftcgOyPSsjozwRpP862PO9UtnrR56Rr
 AzKw==
X-Gm-Message-State: AOJu0Ywj4ldHi9QJDqKnIVXLYE9DhELL2xIZovW+HXKVNBy84s76pI4I
 vmtOMbd6cMNUhMDT7xIeaWpEfQ==
X-Google-Smtp-Source: AGHT+IGYGyZVSuT+gOOO9OMo2dmQbPMR0evUP0SUUDXZyKShX5soPk5OAPgFlISl/qsFKZKY3mmsxw==
X-Received: by 2002:a17:902:d4c2:b0:1c8:a68e:7ff with SMTP id
 o2-20020a170902d4c200b001c8a68e07ffmr13806583plg.60.1697089821222; 
 Wed, 11 Oct 2023 22:50:21 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 b21-20020a170902d31500b001c72f4334afsm951190plc.20.2023.10.11.22.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:50:21 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v10 13/18] gdbstub: Add members to identify registers to
 GDBFeature
Date: Thu, 12 Oct 2023 14:48:52 +0900
Message-ID: <20231012054902.38447-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

These members will be used to help plugins to identify registers.
The added members in instances of GDBFeature dynamically generated by
CPUs will be filled in later changes.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/gdbstub.h  |  3 +++
 gdbstub/gdbstub.c       | 10 ++++++++--
 target/riscv/gdbstub.c  |  4 +---
 scripts/feature_to_c.py | 14 +++++++++++++-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 70e16be79e..229fa382bc 100644
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
 } GDBFeatureBuilder;
 
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c19f1785e4..987af2298c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -417,9 +417,10 @@ void gdb_feature_builder_init(GDBFeatureBuilder *builder, GDBFeature *feature,
 
     builder->feature = feature;
     builder->xml = g_ptr_array_new();
+    builder->regs = g_ptr_array_new();
     g_ptr_array_add(builder->xml, header);
     feature->xmlname = xmlname;
-    feature->num_regs = 0;
+    feature->name = name;
 }
 
 void gdb_feature_builder_append_tag(const GDBFeatureBuilder *builder,
@@ -448,7 +449,9 @@ int gdb_feature_builder_append_reg(const GDBFeatureBuilder *builder,
             name, bitsize, type);
     }
 
-    return builder->feature->num_regs++;
+    g_ptr_array_add(builder->regs, (void *)name);
+
+    return builder->regs->len - 1;
 }
 
 void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
@@ -463,6 +466,9 @@ void gdb_feature_builder_end(const GDBFeatureBuilder *builder)
     }
 
     g_ptr_array_free(builder->xml, TRUE);
+
+    builder->feature->num_regs = builder->regs->len;
+    builder->feature->regs = (void *)g_ptr_array_free(builder->regs, FALSE);
 }
 
 const GDBFeature *gdb_find_static_feature(const char *xmlname)
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index aa0824e119..9082b0c6e2 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -265,11 +265,9 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUState *cs)
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
 
             gdb_feature_builder_append_reg(&builder, name, bitsize,
diff --git a/scripts/feature_to_c.py b/scripts/feature_to_c.py
index e04d6b2df7..807af0e685 100755
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
2.42.0


