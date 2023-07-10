Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD2C74D5C1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:37:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq6p-0000lA-UV; Mon, 10 Jul 2023 08:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6l-0000HQ-Io
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:15 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq6j-0005JE-Lg
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:35:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-666edfc50deso2798914b3a.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992512; x=1691584512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aelGlzCxicTkI9abFumFgqeiN1ZlZb4rkHDRhLOA6K8=;
 b=CqLsb4ckU7qvfPmiFqYzPEhWw5paaCuMEqc5NDVQ66aAJFTaWI0+6VkUlry+Otb07Z
 Jw3ZfVhxEa1trTUtbbiogm6yOo9a6NVH3xsS3CTuaKVMWptygUJ6b3k7gSVuAB6CN7Ns
 xAQeyN/SuXXiHS7gjNmpTpazTD3qCaSz0+09pAgWgBJu815EBfmfH6QlKhKBz8bAeEhM
 TR/5/NXnd/7AaMYGcrapKiCjsuGQ3kaHWdcUnUzv8XZhSx8m8y4hGX4iZ3VBReYOkA4J
 utXkAsSf+U/W8KEqXs7+1UAK1osf81KeI4WuB1SgfGUykpNviSjqryC8DLkrkXEejrcG
 k7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992512; x=1691584512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aelGlzCxicTkI9abFumFgqeiN1ZlZb4rkHDRhLOA6K8=;
 b=eZm3MFF4b5h9FyiZ1f7R0hmrqpVkh6lwJmpWUpUHerXQzGslqc9/MUlwfMnz/Nb2j4
 NvKGQaODDXcxk4EMgmUy44nS1Zfsg5rMzZomxTP+qqa0CFR1jY1pJgEOczKsLfdvPSlY
 4Ej8CN8FAUA0xreinitnl0vL2OayUJbGuTUCLh5w5+Jq6APIW4m5jCKy4jvswbForcYg
 mJ96/9oB9NWbqpucCxks8xZ7RYhIJpO7paj2I7lij8eiFKwQlC+LN6ebFIDPZrN5Pxnz
 BWtDLObR5ic+Hu1GKjAuQcq4n2OR+aZoC4RouTIqHneanQe5HajgVSEIsYFUC4HkzznE
 0+fg==
X-Gm-Message-State: ABy/qLaxk4jr1kDAtQYgOEg8H5BFxYIHaZH1agdyl9W5EW8Zuzm0HajS
 J85JrZylT+BvG8WyYcieHlavFO7E/uhYVA==
X-Google-Smtp-Source: APBJJlEyGgLtNYbyY4FgpjNGDLMStCX0RzfpNIYdfaFa3jNpvvZxCZDpa2P/YNi/hUdHLHamz0fHpw==
X-Received: by 2002:a05:6a00:3015:b0:67a:20d0:b9bb with SMTP id
 ay21-20020a056a00301500b0067a20d0b9bbmr23486200pfb.1.1688992511940; 
 Mon, 10 Jul 2023 05:35:11 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:35:11 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/54] target/riscv/cpu.c: create KVM mock properties
Date: Mon, 10 Jul 2023 22:32:01 +1000
Message-Id: <20230710123205.2441106-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42c.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230706101738.460804-18-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 2acf77949f..b2883ca533 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1840,6 +1840,26 @@ static Property riscv_cpu_extensions[] = {
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
@@ -1868,6 +1888,22 @@ static void riscv_cpu_add_user_properties(Object *obj)
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
2.40.1


