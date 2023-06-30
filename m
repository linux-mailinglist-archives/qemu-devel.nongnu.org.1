Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0625A743921
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFB4j-0006Jh-KA; Fri, 30 Jun 2023 06:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB44-0005kV-1F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:20 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFB42-0000sT-5r
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:09:19 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b0156a1c49so1482235fac.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688119756; x=1690711756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82K5FK4e6LcUEgUtYGQlW212NlabaxdOTqWRFHkEWqI=;
 b=arnyNXaV+kGuQYXLTnvBVb2oY/z163o8ILfv7Ibg/WeAykm7S/M91igNJ7uNnZUQy4
 sKuP0RJglfVG++tYALMSiTBtE7FnSS9M25BEo+m2sNUa/fdr4FE8q+OhHeeuhAlXRha7
 M64OAskVoI169CL38LFvLA8FrFxCw3p/iITQU3Q/oapWtFOk5YeCPfg6gR2NAA6UkLIv
 LisCE0f57du5ke5WcFz5f2KS62E4GhmhZVNnfOfy4KQBjRd8YYqKyNFNt+uDtmsD5Twp
 yyg0WXlqCXupn5XI/XQQ3z0ejobJ1TvYf+l3MEFXfsxuUZf+3blRhez0vfS4nGxsCXWx
 5QgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119756; x=1690711756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82K5FK4e6LcUEgUtYGQlW212NlabaxdOTqWRFHkEWqI=;
 b=TOTSKMBFcNF6tKRXR9EDOJKIK610Y3wx3eLOxXf9/x5+1IuN3gW0mPIcD7kjfM+mVb
 OuByxq13G5if5F2HftVMOT5VEWB2BS98nV/oMAbIBMolsO7/crbbgDSp3RyS0ugtqhqe
 u00ka2XQ5J3MRqKgbOhCZwfobuAKOcDM1l560Q62ppp/uLEdl6y4ltC88b86SbLydgzg
 E2aGFmr6EBKiWfP/q4GuuCdIbYGdRo3sMdQQqq0KC1VW0ey0ZarxWf5IBOeDZxAJnGwj
 192d8EyeA8ueAsOIUnVWlcT5IvVOIBddaAVEIRAkVuG9OsNUyWV+AYEhDsxaAYBitD6V
 /YLA==
X-Gm-Message-State: ABy/qLa/PAkb9v/FAnSE+Z6qIiE5zCwxTYjkuY3wnvVEhmEH7fJ4yElB
 ZnX6kluXut6e7gGqyLVKmTmR2o9oSTNZAkftq8o=
X-Google-Smtp-Source: APBJJlH/YYUNvYWTetHi3ATGTTMD9g7wRFut65E7fy00tVkYtCnMTZXEMfppDOPcKBZYq+4KIsIeWw==
X-Received: by 2002:a05:6870:bf84:b0:18e:cdd6:971a with SMTP id
 av4-20020a056870bf8400b0018ecdd6971amr2249191oac.36.1688119756648; 
 Fri, 30 Jun 2023 03:09:16 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 eh18-20020a056870f59200b001a663e49523sm8707467oab.36.2023.06.30.03.09.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:09:16 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 17/20] target/riscv/cpu.c: create KVM mock properties
Date: Fri, 30 Jun 2023 07:08:08 -0300
Message-ID: <20230630100811.287315-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630100811.287315-1-dbarboza@ventanamicro.com>
References: <20230630100811.287315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2b.google.com
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

KVM-specific properties are being created inside target/riscv/kvm.c. But
at this moment we're gathering all the remaining properties from TCG and
adding them as is when running KVM. This creates a situation where
non-KVM properties are setting flags to 'true' due to its default
settings (e.g.  Zawrs). Users can also freely enable them via command
line.

This doesn't impact runtime per se because KVM doesn't care about these
flags, but code such as riscv_isa_string_ext() take those flags into
account. The result is that, for a KVM guest, setting non-KVM properties
will make them appear in the riscv,isa DT.

We want to keep the same API for both TCG and KVM and at the same time,
when running KVM, forbid non-KVM extensions to be enabled internally. We
accomplish both by changing riscv_cpu_add_user_properties() to add a
mock boolean property for every non-KVM extension in
riscv_cpu_extensions[]. Then, when running KVM, users are still free to
set extensions at will, but we'll error out if a non-KVM extension is
enabled. Setting such extension to 'false' will be ignored.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6cdcbaac30..9821dfeb43 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1758,6 +1758,26 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+
+#ifndef CONFIG_USER_ONLY
+static void cpu_set_cfg_unavailable(Object *obj, Visitor *v,
+                                    const char *name,
+                                    void *opaque, Error **errp)
+{
+    const char *propname = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value) {
+        error_setg(errp, "extension %s is not available with KVM",
+                   propname);
+    }
+}
+#endif
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1786,6 +1806,22 @@ static void riscv_cpu_add_user_properties(Object *obj)
             if (object_property_find(obj, prop->name)) {
                 continue;
             }
+
+            /*
+             * Set the default to disabled for every extension
+             * unknown to KVM and error out if the user attempts
+             * to enable any of them.
+             *
+             * We're giving a pass for non-bool properties since they're
+             * not related to the availability of extensions and can be
+             * safely ignored as is.
+             */
+            if (prop->info == &qdev_prop_bool) {
+                object_property_add(obj, prop->name, "bool",
+                                    NULL, cpu_set_cfg_unavailable,
+                                    NULL, (void *)prop->name);
+                continue;
+            }
         }
 #endif
         qdev_property_add_static(dev, prop);
-- 
2.41.0


