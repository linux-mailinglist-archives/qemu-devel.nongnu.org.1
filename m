Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCB97A7A4B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivGJ-0005di-1z; Wed, 20 Sep 2023 07:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGG-0005d6-Sd
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:52 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qivGF-0002CI-5g
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:20:52 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c0e8345c1eso4471065a34.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1695208849; x=1695813649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VkbHu3ro5dFtNXMh6G6f1KNKstsUOQ9pg5TPerqopg=;
 b=pebfWqcYf5Wg5Y8k9RgrtbQxHKLrgWwb4K7OYWJDKbDMdWmh9+y+sll1WfaHW+h80k
 w8onVMd90IkROEiURSTNMVoKi6lkrbIEBhDIqmJVSS0QHWrxdU66mw9Ns5G7Ka1tr35f
 nPDckj8iuNMLFvyjfdTEBmKfIHzAE8pAqufzT0sfrJT+XRodgIwHkihh9NxGc1qEJfZc
 SJ7yZ9IMmjBUpBOPObnNiC+oEOGlg7NShGogRZ+WXubJhx5w3GoZieYZiy+rOvFL7MhI
 msMkR12zDtOgbHK+05e4I23inPNQYPkWn/tK6jY7Dl9cMqagCmFwowY6JhP440k1iRbg
 IkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695208849; x=1695813649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/VkbHu3ro5dFtNXMh6G6f1KNKstsUOQ9pg5TPerqopg=;
 b=rEY5sIUrZUFKO1ssfJdAs2pyMfdzANJguSytLGIIIKQlUhqEXnOBRxtZuURGqcD1kA
 P0o3HiiTjDfS/xWSmCo6zfG5Bvu6YTcaUgpMfShSk3fPo2SxXY+nyxzkm+YHrW9tWwv2
 ZY2fZoXuTauBARiqX7EL94f+uizLOm3fihWBfFAZ1MQfvwwlKvA0k1jF/q2MMT4RL4OY
 sA36koDMz8Pegqldj0ub895Gyq+JLr8ssYSz4LKrgpAiYSBRGwPpI7CpVPHxyvQKzvGo
 H3M4dIkFYmTMJLiCz0EhI+9x0mBsDpuxJvZWzqLldAluTAc1snNVHU5MRRElkYxo4XJ2
 Jpww==
X-Gm-Message-State: AOJu0Ywn83g8U64yDI16a7rO/TrG+p2wRVGh3hKl1WTHrl3V8MxaijQE
 CcmdQiv1HlogCZKX7Zhfwvpk2bRvY+blIj6yxDw=
X-Google-Smtp-Source: AGHT+IHgCTC6zStbb7GVnCyU5OgVdnU3gJLw9wEYkRO97AmNE9uimk1DiDRRFrijQn1GbQytW1/Y5A==
X-Received: by 2002:a9d:4f04:0:b0:6bd:b40:8912 with SMTP id
 d4-20020a9d4f04000000b006bd0b408912mr2097412otl.35.1695208849562; 
 Wed, 20 Sep 2023 04:20:49 -0700 (PDT)
Received: from grind.. ([2804:7f0:bcc0:bdf2:b7ba:a476:c0e3:fb59])
 by smtp.gmail.com with ESMTPSA id
 q4-20020a9d7c84000000b006b45be2fdc2sm5863955otn.65.2023.09.20.04.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 04:20:49 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 philmd@linaro.org, ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 07/19] target/riscv/cpu.c: mark extensions arrays as 'const'
Date: Wed, 20 Sep 2023 08:20:08 -0300
Message-ID: <20230920112020.651006-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920112020.651006-1-dbarboza@ventanamicro.com>
References: <20230920112020.651006-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We'll need to export these arrays to the accelerator classes in the next
patches. Mark them as 'const' now because they should not be modified at
runtime.

Note that 'riscv_cpu_options' will also be exported, but can't be marked
as 'const', because the properties are changed via
qdev_property_add_static().

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f8368ce274..048a2dbc77 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1407,7 +1407,7 @@ typedef struct RISCVCPUMultiExtConfig {
     {.name = _name, .offset = CPU_CFG_OFFSET(_prop), \
      .enabled = _defval}
 
-static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     /* Defaults for standard extensions */
     MULTI_EXT_CFG_BOOL("sscofpmf", ext_sscofpmf, false),
     MULTI_EXT_CFG_BOOL("Zifencei", ext_ifencei, true),
@@ -1469,7 +1469,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
     MULTI_EXT_CFG_BOOL("xtheadba", ext_xtheadba, false),
     MULTI_EXT_CFG_BOOL("xtheadbb", ext_xtheadbb, false),
     MULTI_EXT_CFG_BOOL("xtheadbs", ext_xtheadbs, false),
@@ -1487,7 +1487,7 @@ static RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[] = {
 };
 
 /* These are experimental so mark with 'x-' */
-static RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
+static const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     /* ePMP 0.9.3 */
     MULTI_EXT_CFG_BOOL("x-epmp", epmp, false),
     MULTI_EXT_CFG_BOOL("x-smaia", ext_smaia, false),
@@ -1558,7 +1558,7 @@ static void cpu_get_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
 }
 
 static void cpu_add_multi_ext_prop(Object *cpu_obj,
-                                   RISCVCPUMultiExtConfig *multi_cfg)
+                                   const RISCVCPUMultiExtConfig *multi_cfg)
 {
     object_property_add(cpu_obj, multi_cfg->name, "bool",
                         cpu_get_multi_ext_cfg,
@@ -1575,11 +1575,13 @@ static void cpu_add_multi_ext_prop(Object *cpu_obj,
 }
 
 static void riscv_cpu_add_multiext_prop_array(Object *obj,
-                                              RISCVCPUMultiExtConfig *array)
+                                        const RISCVCPUMultiExtConfig *array)
 {
+    const RISCVCPUMultiExtConfig *prop;
+
     g_assert(array);
 
-    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
+    for (prop = array; prop && prop->name; prop++) {
         cpu_add_multi_ext_prop(obj, prop);
     }
 }
@@ -1620,11 +1622,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 }
 
 static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
-                                                 RISCVCPUMultiExtConfig *array)
+                                        const RISCVCPUMultiExtConfig *array)
 {
+    const RISCVCPUMultiExtConfig *prop;
+
     g_assert(array);
 
-    for (RISCVCPUMultiExtConfig *prop = array; prop && prop->name; prop++) {
+    for (prop = array; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 }
@@ -1687,7 +1691,7 @@ static void riscv_init_max_cpu_extensions(Object *obj)
 {
     RISCVCPU *cpu = RISCV_CPU(obj);
     CPURISCVState *env = &cpu->env;
-    RISCVCPUMultiExtConfig *prop;
+    const RISCVCPUMultiExtConfig *prop;
 
     /* Enable RVG, RVJ and RVV that are disabled by default */
     set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
-- 
2.41.0


