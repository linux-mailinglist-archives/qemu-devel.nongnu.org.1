Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9B749001
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 23:41:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAFB-0005Oa-Uq; Wed, 05 Jul 2023 17:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAF8-0005MP-JG
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:58 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAF6-0001pX-Qr
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 17:40:58 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5634d8d1db0so4944048eaf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 14:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688593255; x=1691185255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYO8DN3m1MPnavyeFk10m4IptueYXgPjsm/ZWKO8tks=;
 b=jeN4pGhOCKtrFCk+iAB6NJV1Ce3dmBYny7oRivzbIFNRShqFEZBY3i3iV0p3wjsa/l
 gxULl77rZNVtIO7UK9CaG6DGe9N3hJy5GmyJOhXpRZFtfJVi7G0G5wtRdmfemSXFUBb6
 F17agkhiwbjOET0UD5szMZaJ/vAxSoY17N/yTYdPI39n5ZdX+NnnYxDbwxkWhKjbUNYn
 bvvAY2L0FCltM5GAAZArvtLAHe6YDAKA1FmMXuq3wgiLV13y7FAmW0EGum9rDRwpV2kV
 6KKdjpsdF7+yECwcIMmjtojvYI3NYF5GSUvzC39M8GJjJ1xCXlixmaAjE0xcZ1JT3fQ3
 2/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688593255; x=1691185255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYO8DN3m1MPnavyeFk10m4IptueYXgPjsm/ZWKO8tks=;
 b=OuqYLiJeaDmfj3/VWeKazryhg+Pn8kzw0EhBXXz05nAJl4UOqPG2y9yb0ZZI8AdcIp
 pDT6xgMeQvmW2ABMWwrgD2mv8svzDdCMgLtHV9pcra9I1FtLFNCOe6LDf5sv65ovY9nx
 3G5ToQehu9LTWtFuuaupb5vlEcEB4W0K5PalzptyjiGSNc3LxeZUIUeaWoIHSfEbfrKA
 Z0bpNmrooFXdp+0plGR+t7+VxMkuHWNPt71FWl5s/WKUk02gpE0Btz+Agbf1KUesPaZn
 MLzv8I77CeR9LODNb4qJvWQmxgJ9uZAreRIwSYUGVUKQY5hX3HnURM4jDszpfba/SGtk
 HmAQ==
X-Gm-Message-State: ABy/qLZ9EmCyebnhAlbIR4M7Z02e3W+JRJcQCTD2Cv27Dzbc74ckFp1o
 X9w4MVWrDFaHIkB1qrqN5Io1PeSyRJRzaoBHMEY=
X-Google-Smtp-Source: APBJJlHs+8R5ewWPpkNJE2Zjx16F4gYRI4+J9JiZ4ccV0xnY514BBNCmafhCieEWGDXrFfWyleyFVA==
X-Received: by 2002:a4a:4915:0:b0:566:66bb:940a with SMTP id
 z21-20020a4a4915000000b0056666bb940amr6372ooa.9.1688593255440; 
 Wed, 05 Jul 2023 14:40:55 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a4add01000000b0056665a16536sm70764oou.30.2023.07.05.14.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 14:40:55 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v8 17/20] target/riscv/cpu.c: create KVM mock properties
Date: Wed,  5 Jul 2023 18:39:52 -0300
Message-ID: <20230705213955.429895-18-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705213955.429895-1-dbarboza@ventanamicro.com>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2b.google.com
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
2.41.0


