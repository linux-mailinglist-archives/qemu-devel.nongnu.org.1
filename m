Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D425E740151
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBcw-00047x-UU; Tue, 27 Jun 2023 12:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBcm-00041G-F2
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:33:04 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qEBck-0004xp-H2
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:33:04 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1acdfbe1c78so4522901fac.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687883581; x=1690475581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcJws8yrrSZi2DTygDxgG3EvSHIUG2c06Aiuh0PHu2E=;
 b=V6hIwLUAaC0YYrDfoRYkwby8fR4p+Hk/z0vvZ1a4a2gT5yVo50lgqrFuG2p+6HGQVp
 sitY1ox8WlijeYNq4udJ3Q91X3WSxCdL0MGveNsUR8vxkk9m/5o7ZGVpTlFlPfu8+cdO
 CAXq3yqgrcuWXUEtDCBvLz21aKGyvik1RQiycXYdTTmtGV2pDp8KeHMk6h5O7jSbKg3L
 CUyIX+Ph4Tfr2BGqv9a01i4EBhTQX34/K6a2gKMb1QAof58pQNalbiqVw6OQb+6NatSp
 0nBdbg8Qa9UiyZxvLz4F/0VGxoU0UuoN4tGvoERCgHS+hflBVRFdK/dp9CVdUQH/Q894
 p8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687883581; x=1690475581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcJws8yrrSZi2DTygDxgG3EvSHIUG2c06Aiuh0PHu2E=;
 b=a5MR81MEW9WEK6ZjK9rUdmJPfK6rc7yk9xwBMDQINpOqsYvJ6jyrIb+5mM87uVD4bw
 PQb6/lJGiFAOxSaRSHNCDU6DzIskSzQwZXoGF5uvDJCeIQza+IckAau94hkcx3SmN5Fq
 tpYRau4l4PcjJDiU6EiRYt12qm6npDEKToEXsh6c2vz1Qtzfj261ulHKSuCdeyHyzzk3
 NMpvvUCLPlTsHKPC2DejybG3ze2Hc+EY84/GDD/I40BKuQYcICUwdloqCbGWHXCEp4oT
 Obp6qT9RRB3q8ONCWgETGlNUhHNFnGIbhREuS3JtNy3z9QiPkp+cIeNUsfmGPzJr2sMW
 Ud4g==
X-Gm-Message-State: AC+VfDyBHqovR0tmGQGINxrXKhq8dZAzG35dQr1GNaCGAnNtBxxbQRew
 D6b5P692OsVTrnHnauvWwZXls3QdO9/tNyAhEQc=
X-Google-Smtp-Source: ACHHUZ43R5ph6fDpZqyF8XseSPeiS8q79kKvTOIGg2kfjZp46SglYABcv0MnDU4FioYCbSgDdEqf2w==
X-Received: by 2002:a05:6870:414a:b0:19f:842:bfde with SMTP id
 r10-20020a056870414a00b0019f0842bfdemr34730059oad.36.1687883581174; 
 Tue, 27 Jun 2023 09:33:01 -0700 (PDT)
Received: from grind.. (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 gu17-20020a056870ab1100b001a3093ec23fsm5254134oab.32.2023.06.27.09.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:33:00 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v5 16/19] target/riscv/cpu.c: create KVM mock properties
Date: Tue, 27 Jun 2023 13:32:00 -0300
Message-ID: <20230627163203.49422-17-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627163203.49422-1-dbarboza@ventanamicro.com>
References: <20230627163203.49422-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
 target/riscv/cpu.c | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b65db165cc..22851b0e93 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1720,6 +1720,24 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+
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
+
 /*
  * Add CPU properties with user-facing flags.
  *
@@ -1738,9 +1756,27 @@ static void riscv_cpu_add_user_properties(Object *obj)
     riscv_cpu_add_misa_properties(obj);
 
     for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        /* Check if KVM didn't create the property already */
-        if (object_property_find(obj, prop->name)) {
-            continue;
+        if (riscv_running_kvm()) {
+            /* Check if KVM created the property already */
+            if (object_property_find(obj, prop->name)) {
+                continue;
+            }
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
 
         qdev_property_add_static(dev, prop);
-- 
2.41.0


