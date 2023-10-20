Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C287D1942
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 00:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtyAG-0003yu-Ln; Fri, 20 Oct 2023 18:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyAE-0003yT-5O
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:18 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtyA6-0007hR-O0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 18:40:17 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9bca1d96cso10550785ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697841608; x=1698446408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRdblqbrELDE0asWl5/HSfsmSop8dDyM1YB2Q3zehig=;
 b=V5Jj2Oy/37tc85HJwWmqWUoYsXL3JnRZmrq9e9UFM8NFzKLg8He4/qIlqE+O7pn+eE
 92L053A5PvzZjMZjWULw3gUUZqJWZpydq06C2UNtXAD2pxOa+rgN9uF9XhKb3EqZUwwP
 jAu8ojTB4YlHSsxW07TWNkQtoFyhxQLoo0pEwc8F6J6UCxBtpgq9MYpRHXg7QMgjkTyf
 wnv28ULoSViUk/bh6Kff87H+ZrtNFKrrES63RDz3he23a36m7OLQRKbSOTyz1qf0b2Q4
 rbpN5aniRYWD2h61yV7JxUN9ulp7OFV60Ww2wlnlHW2IKvsn17DDML9gygMAwraEJC8y
 kOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697841608; x=1698446408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SRdblqbrELDE0asWl5/HSfsmSop8dDyM1YB2Q3zehig=;
 b=wLGR7KNf00hifzQscMzWKB0VQE6S1Ov0VSpNyAJy4wyYPgXekBkDQfqg+MjL9HvpIj
 xmY2eVo11Wuw/fwF1DK+i3kph/cVAOnl1So3bBj7zVcdImv3gXZknf++sftWpt/r24xk
 pKrrz48XcN3GVmQD11zfSS633C+VD/30B4XV/f1fK6Yf3VE6T6bPRB5YGDFmbGJM8wMW
 UTTJX1Cd0mCUfD9KMQ4mjFgXj2VL+1okfz7vX4tNJandmXJVIQy90W64i45VcCM4gf2v
 4jjY71IR080zafomZTAwiy7hZ77wjANM0o+Iue7OFWaeP46k9HuqGKUtJdY4UvBPDGhP
 sqGA==
X-Gm-Message-State: AOJu0Yz4GNlGDvbIeal58XjHIm8J8FsBxTarl/B/r60pJRi7wHbZsf4L
 CR82dAW0WvIhLRVC58ioDJEsh283WrPmyBZhkbw=
X-Google-Smtp-Source: AGHT+IE+e7QsdKOMwi8EfRuPua7X6GgG977pGRVmEKGhsR7O7vbNp8jqqZL5CuGMXsyxb0QrpEZDbw==
X-Received: by 2002:a17:902:cf4f:b0:1ca:64f:35ff with SMTP id
 e15-20020a170902cf4f00b001ca064f35ffmr2755441plg.48.1697841607696; 
 Fri, 20 Oct 2023 15:40:07 -0700 (PDT)
Received: from grind.. ([177.45.186.249]) by smtp.gmail.com with ESMTPSA id
 h1-20020a170902704100b001c61921d4d2sm1992373plt.302.2023.10.20.15.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 15:40:07 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 3/6] target/riscv/tcg: add user flag for profile support
Date: Fri, 20 Oct 2023 19:39:48 -0300
Message-ID: <20231020223951.357513-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020223951.357513-1-dbarboza@ventanamicro.com>
References: <20231020223951.357513-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

- we'll not support user profile settings for vendor CPUs. The flags
will still be exposed but users won't be able to change them. The idea
is that vendor CPUs in the future can enable profiles internally in
their cpu_init() functions, showing to the external world that the CPU
supports a certain profile. But users won't be able to enable/disable
it;

- Setting a profile to 'true' means 'enable all mandatory extensions of
this profile, setting it to 'false' means disabling all its mandatory
extensions. Disabling a profile is discouraged for regular use and will
issue an user warning. User choices for individual extensions will take
precedence, i.e. enabling a profile will not enable extensions that the
user set to 'false', and vice-versa. This will make us independent of
left-to-right ordering in the QEMU command line, i.e. the following QEMU
command lines:

-cpu rv64,zicbom=false,rva22u64=true,Zifencei=false
-cpu rv64,zicbom=false,Zifencei=false,rva22u64=true
-cpu rv64,rva22u64=true,zicbom=false,Zifencei=false

They mean the same thing: "enable all mandatory extensions of the
rva22u64 profile while keeping zicbom and Zifencei disabled".

For now we'll handle multi-letter extensions only. MISA extensions need
additional steps that we'll take care later.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 7a4400e2ba..3dd4783191 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -757,6 +757,63 @@ static void riscv_cpu_add_misa_properties(Object *cpu_obj)
     }
 }
 
+static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    RISCVCPUProfile *profile = opaque;
+    RISCVCPU *cpu = RISCV_CPU(obj);
+    bool value;
+    int i, ext_offset;
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
+    if (!value) {
+        warn_report("Disabling the '%s' profile is a debug/development "
+                    "tool, not recommended for regular use",
+                    profile->name);
+    }
+
+    profile->enabled = value;
+
+    for (i = 0; profile->ext_offsets[i] != RISCV_PROFILE_EXT_LIST_END; i++) {
+        ext_offset = profile->ext_offsets[i];
+
+        if (cpu_cfg_ext_is_user_set(ext_offset)) {
+            continue;
+        }
+
+        isa_ext_update_enabled(cpu, ext_offset, profile->enabled);
+    }
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
+    for (int i = 0; riscv_profiles[i] != NULL; i++) {
+        const RISCVCPUProfile *profile = riscv_profiles[i];
+
+        object_property_add(cpu_obj, profile->name, "bool",
+                            cpu_get_profile, cpu_set_profile,
+                            NULL, (void *)profile);
+    }
+}
+
 static bool cpu_ext_is_deprecated(const char *ext_name)
 {
     return isupper(ext_name[0]);
@@ -880,6 +937,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_multiext_prop_array(obj, riscv_cpu_deprecated_exts);
 
+    riscv_cpu_add_profiles(obj);
+
     for (Property *prop = riscv_cpu_options; prop && prop->name; prop++) {
         qdev_property_add_static(DEVICE(obj), prop);
     }
-- 
2.41.0


