Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9072ED90
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 23:03:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9B6x-00021k-5X; Tue, 13 Jun 2023 16:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6v-00021a-VM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:29 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q9B6u-0006gx-Co
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 16:59:29 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39c7f5706f0so3753080b6e.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686689967; x=1689281967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLGO//MY4I5Oc61K3sYPrsApC28gAwnypQlxx+aTI6U=;
 b=BuUDnV2/qLNu+TAJKF2icXMpNp4zm9hhydfScStUVor0OORd6eo1VXO8SrKnfgjD6H
 jrEvYxmMdKalp1idZMZTEwsUErW9tuivxduEcFAqLitg1QOpIFKqNOwWHfaQ1iXCm/mp
 ZxjdcaQ7ZNvGqxvMsu/dH35c3gxQIR8Lv6XOWoQWwWpiIBPfCINcXWfC757CFp0BVnqQ
 Y4urPmzjUI15VncqL1LMvfsP6WCzSXKrRZrv4QiTyaiVnmkW+kRU/mtU03Wso1JAibnG
 MGHeK97ZZ2TgG3rN3qCaAbnfqukYggiI3eUPP8GhFFnGntayuHPKL7BmM7IadRXHyUbS
 kADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686689967; x=1689281967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLGO//MY4I5Oc61K3sYPrsApC28gAwnypQlxx+aTI6U=;
 b=KlsTE6ne8d2Xk5Mof3hlKngFHmlQ4TFF0nbOa1BICrungyEMeuxKC2kXO8qr1aKU1b
 mNUxC7+MtxzYQbbbleVu9+cZpbGAMi5c4wQCVb967wfQwauin2qHxObpHJhK/ol2CbeY
 KHRNa7K9oLxmslFrfuEEv/CdMhXTafFM7aokpPfp9V3D11c/FnqR5THUwT3oiCpG1cE0
 fknm/sGzHLqWdFaW/KbnDi5XJoK34Ajc7mj5s0KGK/nt45TqbM+h0W2qMELlFJ+xmn+P
 9LZCvYpOXbcqNmCkVZFlF/yRUhZl4YeXJk4uWIJNZWuEitPgJxwXdZCqUReavj+9z6f+
 kbEw==
X-Gm-Message-State: AC+VfDyItS/+P45Q1JFCE1+ngLVJTbt0gLCQF6FfTS16mhyNNl6eqdY2
 B/e8+6nX1BEhTfmkclYpMBGU1dzQbheJVDhVvWA=
X-Google-Smtp-Source: ACHHUZ5XO23URy6JkJef5jIw0lVQz+4a3jtpJ04nHAYmxWUaVnsufOGuqkG+HiH5p718Hlr0oV7rkw==
X-Received: by 2002:a05:6808:1c8:b0:39c:5d03:6a5a with SMTP id
 x8-20020a05680801c800b0039c5d036a5amr8050479oic.7.1686689966895; 
 Tue, 13 Jun 2023 13:59:26 -0700 (PDT)
Received: from grind.. ([177.170.117.210]) by smtp.gmail.com with ESMTPSA id
 q82-20020acaf255000000b003982a8a1e3fsm5619514oih.51.2023.06.13.13.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 13:59:26 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 04/18] target/riscv/cpu.c: restrict 'mimpid' value
Date: Tue, 13 Jun 2023 17:58:43 -0300
Message-Id: <20230613205857.495165-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613205857.495165-1-dbarboza@ventanamicro.com>
References: <20230613205857.495165-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
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

Following the same logic used with 'mvendorid' let's also restrict
'mimpid' for named CPUs. Generic CPUs keep setting the value freely.

Note that we're getting rid of the default RISCV_CPU_MARCHID value. The
reason is that this is not a good default since it's dynamic, changing
with with every QEMU version, regardless of whether the actual
implementation of the CPU changed from one QEMU version to the other.
Named CPU should set it to a meaningful value instead and generic CPUs
can set whatever they want.

This is the error thrown for an invalid 'mimpid' value for the veyron-v1
CPU:

$ ./qemu-system-riscv64 -M virt -nographic -cpu veyron-v1,mimpid=2
qemu-system-riscv64: can't apply global veyron-v1-riscv-cpu.mimpid=2:
    Unable to change veyron-v1-riscv-cpu mimpid (0x111)

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6a9a6d34eb..39c550682a 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -42,7 +42,6 @@
 #define RISCV_CPU_MARCHID   ((QEMU_VERSION_MAJOR << 16) | \
                              (QEMU_VERSION_MINOR << 8)  | \
                              (QEMU_VERSION_MICRO))
-#define RISCV_CPU_MIMPID    RISCV_CPU_MARCHID
 
 static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
 
@@ -1735,7 +1734,6 @@ static Property riscv_cpu_properties[] = {
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
 
     DEFINE_PROP_UINT64("marchid", RISCVCPU, cfg.marchid, RISCV_CPU_MARCHID),
-    DEFINE_PROP_UINT64("mimpid", RISCVCPU, cfg.mimpid, RISCV_CPU_MIMPID),
 
 #ifndef CONFIG_USER_ONLY
     DEFINE_PROP_UINT64("resetvec", RISCVCPU, env.resetvec, DEFAULT_RSTVEC),
@@ -1854,6 +1852,35 @@ static void cpu_get_mvendorid(Object *obj, Visitor *v, const char *name,
     visit_type_bool(v, name, &value, errp);
 }
 
+static void cpu_set_mimpid(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
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
+        error_setg(errp, "Unable to change %s mimpid (0x%lx)",
+                   object_get_typename(obj), prev_val);
+        return;
+    }
+
+    cpu->cfg.mimpid = value;
+}
+
+static void cpu_get_mimpid(Object *obj, Visitor *v, const char *name,
+                           void *opaque, Error **errp)
+{
+    bool value = RISCV_CPU(obj)->cfg.mimpid;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
 static void riscv_cpu_class_init(ObjectClass *c, void *data)
 {
     RISCVCPUClass *mcc = RISCV_CPU_CLASS(c);
@@ -1888,6 +1915,9 @@ static void riscv_cpu_class_init(ObjectClass *c, void *data)
     object_class_property_add(c, "mvendorid", "uint32", cpu_get_mvendorid,
                               cpu_set_mvendorid, NULL, NULL);
 
+    object_class_property_add(c, "mimpid", "uint64", cpu_get_mimpid,
+                              cpu_set_mimpid, NULL, NULL);
+
     device_class_set_props(dc, riscv_cpu_properties);
 }
 
-- 
2.40.1


