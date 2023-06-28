Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D91741AF9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:33:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEcm9-0004bE-R7; Wed, 28 Jun 2023 17:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEcly-0004FY-A0
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:23 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEclw-00007m-Gf
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:32:22 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b5f362f4beso119711a34.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687987939; x=1690579939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0YCVJ1UigptFIkjyPY8sDv0telv70VOtYorhAbbPEGo=;
 b=Hau3bi8WVht8EZB7OoCNa4S4dOg7Syga2AZ8APkC/4GepVCDM9BWaJdVpYOoUAfacy
 66G1c35vrdMKTxOCQm2WEXchToWYiJNkWxg8gHsyXfDMzKMuFblawN5SLieghINVuHq/
 fpYpDZjEQnphHORhGxGw6DXtgXXXekt7RIH7onncqfdPuvRJOL1KMXRq6AD/TyXhGX1z
 lW84k4bVWvYGm/cuAJu2uFVlLG6xbQ6nkjyx5MAVzaPq4IuEF38/UYGM1hZidzejyOVu
 4U6pLvC2Zs3igRjtmWLHqTExwF9ySzWwEnnh/71h16VWPQEjqra5/W5+cVQv63V2u5dn
 ENDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687987939; x=1690579939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0YCVJ1UigptFIkjyPY8sDv0telv70VOtYorhAbbPEGo=;
 b=ai8iTRzoKbVjXza2gp92v/f83PUXjKmpTUoAmEZtgeeGvpP1tKQA3Bk5a3sT58qYcK
 giE4YKhu3VJoDGC9L4R22BdXwF8dkE+03XcjLjWMTa8HUxEf7lIlCsEVEFcGNFvGrg/T
 bB/swjhcNMMQHcSbywIWo2ID06v3ak9/6rcWLP3XEoZ/iNUrSfN5kY2pbKGgMjdO8Y0J
 XcjAoBY7ejtj7g/YxkAf58xeaN9Zr1tut040gm3Fbc+NtMsYkCoS0gi+Jqb/gHD2GjmM
 uMr0xBIxunuqHRMifrmu3DUcq0S2X3p74yBSLVUFeJanPvaHdnhveFsioknVSMW589W+
 CEpw==
X-Gm-Message-State: AC+VfDzWGmLFe9Eao4beWw6T7Lrp7EqvTs6QGkSs5UhvYhcahoKbIqBa
 atmYFiNBpT5G7avrNGVeLcBvUY5uXx0xyt4Zn0o=
X-Google-Smtp-Source: ACHHUZ7yWDl5IsrS04HBd8G8GmebqhmeScgTV6fBxGD/pW4OQHib3HLc14LRoTqfb+MaQypqIAx00A==
X-Received: by 2002:a05:6871:810:b0:1b0:7b57:c70f with SMTP id
 q16-20020a056871081000b001b07b57c70fmr3917489oap.58.1687987938844; 
 Wed, 28 Jun 2023 14:32:18 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a4a4511000000b0056084a91c74sm832892ooa.24.2023.06.28.14.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:32:18 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v6 17/20] target/riscv/cpu.c: create KVM mock properties
Date: Wed, 28 Jun 2023 18:30:30 -0300
Message-ID: <20230628213033.170315-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628213033.170315-1-dbarboza@ventanamicro.com>
References: <20230628213033.170315-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
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
---
 target/riscv/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 79c8ffe6b7..6d7a0bc4ae 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1731,6 +1731,26 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1759,6 +1779,22 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


