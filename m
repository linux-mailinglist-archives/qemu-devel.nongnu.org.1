Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E297D7BB901
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:24:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qokmU-00064y-Dh; Fri, 06 Oct 2023 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmH-0005x2-En
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:02 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qokmD-0003BT-9p
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:22:00 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c88b467ef8so10894565ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696598515; x=1697203315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NJuHZOqU1ESRxMo2wNeFNr0U6gZOZRqM9wqvjboqRM=;
 b=UsXpwSPqIWxhteb24oGbRTqX3cD2y2rR58JxoxBRhOvG965/FSHtd/lnXBCsWctRwj
 JsZJibJ9ep9Nm7e7ieix1MgXvN/gLFXyqk9HUSbbQZlgpqoEpBCEWFHSyqSSiEzYpVFF
 nn7LRbuv6FS/4Fe5B2lxkvOXECsWpi3IIbw6U+P7M2xrI/o7qWznGyjDRrgTCyboXbB+
 1Ars6GdPd0A+FrH5ZTk/rY/D/pS8xbGooXuDa4ewyBLI23khGeuHyGqQrpE4nrWlneGI
 TZ8PjV1O+CdwgISBkA4QsXc5fuGi5pkVqD+ybiXVI5qxKLtai4VYv8rt7Igp56d84yPn
 PTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696598515; x=1697203315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NJuHZOqU1ESRxMo2wNeFNr0U6gZOZRqM9wqvjboqRM=;
 b=odDpMs8A+fBL0TsVNfDMfhZdUONVbxydoLHAUrUciZOo4OoLSSyn0ehKJC8KAdWrVc
 fb71Qae84xPt5EVpUMIp7P0ZU2Vh8UDURe1oZpYCLLe8IQoZ38pUxtF40VzVYV8J/aFR
 B19HhRLX+NB8spy3+Wf3yi7kEFfFxVn9Ofsj01JETNkZfvujA4+WQRZKTLDnOzNr4BIC
 tmsMiYtTcFb5O6vXxWgF40yT1UfJFterNOUss9QwKW8B8vgaXG3Wt767Z0rb+F8vNUOu
 i2ykHepenD39BYlL4TfaX2kb/L4mSqzNJJEPG06YFobr0q2aLGpT0BMdUvUYMbtkz5wD
 sCVg==
X-Gm-Message-State: AOJu0YyBdXIMxeCMxE4Q7Cv6XuXJunXXMvDO9FY7ox9r/zpBsWKik0gm
 OAuk7dv1LxiFYDzjShnGEHicgD+r4VXR0OJZH2A=
X-Google-Smtp-Source: AGHT+IGWmLWlXYZASmli0LYVKzV0l8agCyUsELJk0/PCba+Zxb4TtJGucMcJh+WV2ri+eGH5Sl4Rcw==
X-Received: by 2002:a17:902:d342:b0:1c5:b1cc:fe0e with SMTP id
 l2-20020a170902d34200b001c5b1ccfe0emr7513060plk.53.1696598515592; 
 Fri, 06 Oct 2023 06:21:55 -0700 (PDT)
Received: from grind.. ([177.94.42.196]) by smtp.gmail.com with ESMTPSA id
 c12-20020a170902c1cc00b001c60a548331sm3796669plc.304.2023.10.06.06.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 06:21:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 05/10] target/riscv/tcg: add user flag for profile support
Date: Fri,  6 Oct 2023 10:21:29 -0300
Message-ID: <20231006132134.1135297-6-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
References: <20231006132134.1135297-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
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

The TCG emulation implements all the extensions described in the
RVA22U64 profile, both mandatory and optional. The mandatory extensions
will be enabled via the profile flag. We'll leave the optional
extensions to be enabled by hand.

Given that this is the first profile we're implementing in TCG we'll
need some ground work first:

- all profiles declared in riscv_profiles[] will be exposed to users.
  TCG is the main accelerator we're considering when adding profile
  support in QEMU, so for now it's safe to assume that all profiles in
  riscv_profiles[] will be relevant to TCG;

- the set() callback for the profile user property will set the
  'user_set' flag for each profile that users enable/disable in the
  command line;

- we'll not support user profile settings for vendor CPUs. The flags
  will still be exposed but users won't be able to change them. The idea
  is that vendor CPUs in the future can enable profiles internally in
  their cpu_init() functions, showing to the external world that the CPU
  supports a certain profile. But users won't be able to enable/disable
  it.

For now we'll just expose the user flags for all profiles. Next patch
will introduce the 'commit profile' logic.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 46 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 731192bafc..a8ea869e6e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -740,6 +740,50 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
+static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    RISCVCPUProfile *profile = opaque;
+    bool value;
+
+    if (object_dynamic_cast(obj, TYPE_RISCV_DYNAMIC_CPU) == NULL) {
+        error_setg(errp, "Profile %s only available for generic CPUs",
+                   profile->name);
+        return;
+    }
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+
+    profile->user_set = true;
+    profile->enabled = value;
+}
+
+static void cpu_get_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    RISCVCPUProfile *profile = opaque;
+    bool value = profile->enabled;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void riscv_cpu_add_profiles(Object *cpu_obj)
+{
+    for (int i = 0;; i++) {
+        const RISCVCPUProfile *profile = riscv_profiles[i];
+
+        if (!profile) {
+            break;
+        }
+
+        object_property_add(cpu_obj, profile->name, "bool",
+                            cpu_get_profile, cpu_set_profile,
+                            NULL, (void *)profile);
+    }
+}
+
 static void cpu_set_multi_ext_cfg(Object *obj, Visitor *v, const char *name,
                                   void *opaque, Error **errp)
 {
@@ -834,6 +878,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_vendor_exts);
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_experimental_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


