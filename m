Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E773A275
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCKp2-0007uH-Bf; Thu, 22 Jun 2023 09:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKoz-0007ri-Em
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:58:01 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qCKox-0001mK-Qb
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:58:01 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1a98a7fde3fso6705134fac.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687442278; x=1690034278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpZJImvcAyIBpk7AUKC1BQCHBmPwsaCXRfzUXei/wV0=;
 b=XGF/UDWN8p+EtpFlFA69CR2E8k11jxAowSRbOvDHE+Fhb1spv0vAigOfC3U5/lvVjq
 VbTfWVMudfj57wc0esmvpq3tnls5xg0i3qrKpoxi9/Mcx55AlQzqDYtBJQNz5v9gKb79
 nFUFcM5r6TbVxbEw3JuCHtxrEq/UChGZ1cwyNOQAGRvo4xDUemcD+7hy3PnqaaFr6KM5
 xEFPdZfdcUdR93c6KklDdjxgus8hWB4gEypoxfHWiO3gwI3Cn2DLwPeTb9LsZZJDE6as
 ZjlmljupiycU//ah9JOUNkxXkYu3Dm7Hi+JXWDUqvItmRlMACJEE8V8mjghhpJhvsTwp
 0QnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687442278; x=1690034278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UpZJImvcAyIBpk7AUKC1BQCHBmPwsaCXRfzUXei/wV0=;
 b=RqvwfgQXg2H/jWop9m0++Z5X4wemfa2JOnxMBM2noc+ci8obq7wJVuy8fFoUpb59g1
 SRVTCQo8gv5tTnCFzfZyRAuTaNnRzpmXgLxpv18NUPbWgNOYZyC4zf9rVCSfv9ZVoysG
 CoIRS96SxfnnBOtr6uxIqBSrXNAL5gBwbTYlU+3EosKGZaeSvliF465GtVgLhMvdMu49
 lRH6woMprISzcOObx3f0E8NiqzyVDq1DVgoTxaWHRlEEsFM0vFi+del6ruf88IjlH2xk
 wxlxme2yyT/WLXC+QqSbGOqiyQj6BTgGIp/E7RsKnjs8jFUx/OJF7C4FG0VwmjqSLGrp
 yGIA==
X-Gm-Message-State: AC+VfDwWwwP3KWYS+UVYTCBxFLbquVSI1u9ubEL6HvFDHGj1S++UV7bD
 UvU0IHmdH4BpDCBIoB1UnINS/Vg1Rj18mw4nVfE=
X-Google-Smtp-Source: ACHHUZ66jgCJlH88IMTYwU1a7szmgYcjqBx03LT5vEZQ8y0Vt2C0VIysj/7CVvroxOiIXakkoroaXw==
X-Received: by 2002:a05:6870:3a03:b0:1a6:bafb:c1fb with SMTP id
 du3-20020a0568703a0300b001a6bafbc1fbmr13884064oab.7.1687442278512; 
 Thu, 22 Jun 2023 06:57:58 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a4aa446000000b00562f06fb5easm156677ool.11.2023.06.22.06.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 06:57:58 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v3 16/19] target/riscv/cpu.c: create KVM mock properties
Date: Thu, 22 Jun 2023 10:56:57 -0300
Message-ID: <20230622135700.105383-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622135700.105383-1-dbarboza@ventanamicro.com>
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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
mock/no-op boolean property for every non-KVM extension in
riscv_cpu_extensions[]. Then, when running KVM, users are still free to
set extensions at will, we'll treat non-KVM extensions as a no-op, and
riscv_isa_string_ext() will not report bogus extensions in the DT.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b65db165cc..f5209f0789 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1720,6 +1720,18 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+
+static void cpu_set_cfg_noop(Object *obj, Visitor *v,
+                             const char *name,
+                             void *opaque, Error **errp)
+{
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+}
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1738,9 +1750,27 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        /* Check if KVM didn't create the property already */
-        if (object_property_find(obj, prop->name)) {
-            continue;
+        if (riscv_running_kvm()) {
+            /* Check if KVM didn't create the property already */
+            if (object_property_find(obj, prop->name)) {
+                continue;
+            }
+
+            /*
+             * Set every multi-letter extension that KVM doesn't
+             * know as a no-op. This will allow users to set values
+             * to them while keeping their internal state to 'false'.
+             *
+             * We're giving a pass for non-bool properties since they're
+             * not related to the availability of extensions and can be
+             * safely ignored as is.
+             */
+            if (prop->info == &qdev_prop_bool) {
+                object_property_add(obj, prop->name, "bool",
+                                    NULL, cpu_set_cfg_noop,
+                                    NULL, NULL);
+                continue;
+            }
         }
 
         qdev_property_add_static(dev, prop);
-- 
2.41.0


