Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E343284F3FC
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Feb 2024 11:59:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYObY-0001za-2F; Fri, 09 Feb 2024 05:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObV-0001kh-6N
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:33 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYObT-0000IV-FZ
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:59:32 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-218eea4f1a7so374978fac.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476368; x=1708081168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/TrPW9N8SpOBte0FLoX35VEFjsJt0FpqJtvdStcogcw=;
 b=lb2op6uCnnBpeorp68a8ATB8mlYW0S425GtDxqxDzZVcPgCtZesJyUPjp4vb3C/vlr
 B9V+CRfmjaIQz/whWKiF/jbuuFE6fxHmizSd02gUlTPxYoVskoxLSVw6R479ZqPQWBaV
 6tmv/8p8o9lRfKOggZTnZWIR3tZBqVnCKUZintuvTNyRwCPvfGOluhIVJC+GKiGmk8EO
 yWai4NIa3pfdkJlLuIHPheIiR18v0gdipM5JRgfq9PXyBPmoHLRVAMCTWWjgC3WVNxI7
 Zjs1y7SEtBrNlFHLMg5WiP2kaA0wEUB6KkWTFEKP2veQunFyi3qc+9x3ZinA4Tf9YX52
 /F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476368; x=1708081168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/TrPW9N8SpOBte0FLoX35VEFjsJt0FpqJtvdStcogcw=;
 b=oLvZH7jcqsNISC7qZYsHixkQAJegwHkBp2hyu9myyqj44ZGpTwCKJSD9CBIf1JHSDD
 tTQyr4Nx4sCLFLmSeFlCDNZoFYVaylMVDSuE6qm8PZGc8qxN0x1J2+Pxt73oYtXD8D/w
 GPGlLMhy3zcE+8gX292bIpplO8jhkaVTPdk/NTC7WqfRgc8QdTBDtJRl6QtjXEKILeOF
 hAgcHUWoAVuh3f0Sq/sWqwBBMSINhOZsUmwSdkPxkW/2nDU1MZJ+BzCFjL2GSoYKoUcM
 R/5s4ABCrSUW4qAA8FehxTOdyoNJRsoG9O9p20ZP5AuZSgHeBtHhO0m8GfpsA00RpvVj
 kjQA==
X-Gm-Message-State: AOJu0YylACkSTK0K8c4lb1OnpunSPXkMzPxve99aO8eQ0JPIS3JBM0L2
 BProsRNlN0XngSJkBDkGlsrqL27TW40uTWCcVfZgXsxXeo45k7AD3jrfjni9C1//8g==
X-Google-Smtp-Source: AGHT+IHimu/VxYnnhdlV+tEcrAh0KQURB9ds+U07OTj/pOkKbs82mxAuTDfggu6uu5ytW2XJDm8eTw==
X-Received: by 2002:a05:6870:8193:b0:218:43e6:716 with SMTP id
 k19-20020a056870819300b0021843e60716mr1150115oae.33.1707476368191; 
 Fri, 09 Feb 2024 02:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVc5XA04sn5J3tgKnhGnhFS1s8YyCQb3MDIYjoX+LuHGJNBwysjgj4mXBbzVsIp2zCaLfssA3BjKUDE8bR7oPB7xzbVSLyI9ThpMZljJgo4oFFHWHwW9FIIKsB3leIToutgUX+U3ZSPnnUQXQb4nR32lSrqYFpoVBKk/rpnwVDo09A=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.59.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:59:27 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Vladimir Isaev <vladimir.isaev@syntacore.com>
Subject: [PULL 19/61] target/riscv/cpu.c: move 'mimpid' to
 riscv_cpu_properties[]
Date: Fri,  9 Feb 2024 20:57:31 +1000
Message-ID: <20240209105813.3590056-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209105813.3590056-1-alistair.francis@wdc.com>
References: <20240209105813.3590056-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=alistair23@gmail.com; helo=mail-oa1-x2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Keep all class properties in riscv_cpu_properties[].

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Tested-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
tested-by tags added, rebased with Alistair's riscv-to-apply.next.
Message-ID: <20240112140201.127083-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 68 ++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a14d7da11d..1a6524f01f 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2020,6 +2020,41 @@ static const PropertyInfo prop_mvendorid = {
     .set = prop_mvendorid_set,
 };
 
+static void prop_mimpid_set(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    uint64_t prev_val = cpu->cfg.mimpid;
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    if (!dynamic_cpu && prev_val != value) {
+        error_setg(errp, "Unable to change %s mimpid (0x%" PRIu64 ")",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mimpid = value;
+}
+
+static void prop_mimpid_get(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static const PropertyInfo prop_mimpid = {
+    .name = "mimpid",
+    .get = prop_mimpid_get,
+    .set = prop_mimpid_set,
+};
+
 /*
  * RVA22U64 defines some 'named features' or 'synthetic extensions'
  * that are cache related: Za64rs, Zic64b, Ziccif, Ziccrse, Ziccamoa
@@ -2107,6 +2142,7 @@ static Property riscv_cpu_properties[] = {
     {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
 
      {.name = "mvendorid", .info = &prop_mvendorid},
+     {.name = "mimpid", .info = &prop_mimpid},
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
@@ -2188,35 +2224,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
 };
 #endif
 
-static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    bool dynamic_cpu = riscv_cpu_is_dynamic(obj);
-    RISCVCPU *cpu = RISCV_CPU(obj);
-    uint64_t prev_val = cpu->cfg.mimpid;
-    uint64_t value;
-
-    if (!visit_type_uint64(v, name, &value, errp)) {
-        return;
-    }
-
-    if (!dynamic_cpu && prev_val != value) {
-        error_setg(errp, "Unable to change %s mimpid (0x%" PRIu64 ")",
-                   object_get_typename(obj), prev_val);
-        return;
-    }
-
-    cpu->cfg.mimpid = value;
-}
-
-static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    uint64_t value = RISCV_CPU(obj)->cfg.mimpid;
-
-    visit_type_uint64(v, name, &value, errp);
-}
-
 static void cpu_set_marchid(Object *obj, Visitor *v, const char *name,
                             void *opaque, Error **errp)
 {
@@ -2298,9 +2305,6 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     cc->gdb_arch_name = riscv_gdb_arch_name;
     cc->gdb_get_dynamic_xml = riscv_gdb_get_dynamic_xml;
 
-    object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
-                              cpu_set_mimpid, NULL, NULL);
-
     object_class_property_add(c, "marchid", "uint64", cpu_get_marchid,
                               cpu_set_marchid, NULL, NULL);
 
-- 
2.43.0


