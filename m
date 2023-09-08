Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0646798201
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUfI-0003PN-SC; Fri, 08 Sep 2023 02:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfG-0003Dq-3g
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:22 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUfC-0008CG-6P
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:08:21 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso14712615ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153296; x=1694758096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xptM3glyFYsB19H1NGctCpEGJfUDxT1CAdTxvjK2c/M=;
 b=WgXqWwaMAxwWxHIfwcSalUb10va4UMElNZ3xAkfBQ45LYFHsMrKa5U5xgcApmke6OK
 Zpa7q4dZlB5mk61blo0wNwJAapiN5IH25hxgaAYW9QT1dnxkWLz8wY2+ZQOWIT5uOVK4
 gisMnTQkwpqD4adK7Mhl1Rhp2zXJ+efAgU8NScf55G3HM78IRS6HEFQxsGnjCfalxymi
 41zhs4p5rPALaF0zjryRJgWSHg5FK6UEu1CgFnZ0BhpZikUWoQAA+RfTot9ND6xQ4gSN
 N0YaAy0vazyUSAqGA6EaUTOKodOQfAV9AagkA4graMz/LL46D3eVDPS9pXswftipjkqI
 HLdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153296; x=1694758096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xptM3glyFYsB19H1NGctCpEGJfUDxT1CAdTxvjK2c/M=;
 b=lLFImzzNJ5E0bIDnN/iHcbWPWok5Y9q6CNHEZtrmraOUub1kCsFr5dMH5phbaZhpYq
 KFQ5WS+Ef96pxrQyXopx6ClOdV1oFOZBDHPGdghxViton6hJWCZ2dk39KAXePMHemapr
 RQph6N7czy4ElDcAmzVDx873rsHRiJzLyJbx6885kqLeUqi95phCba5pYGoJc/Hi4ZsE
 fWFY/4mTaMXYIKTr08pODTb5Ueuw53rb5vS5JmBNvS8ZE26UHdhFh/0l2+dCqKUmYlns
 SM1KqzlwkCwSWGTQ4V6XtUOiIyNy/CUconHLoNuVEbSgygvfb5hZYfbKN/bO1QnWyuLc
 36Wg==
X-Gm-Message-State: AOJu0YxHxAe6WvVHeEh6+Av2qf45ax11o7t5ZM36a0G66cevtv+ZOC76
 R0+F6k1ZtB01cVT17LNW9yrybcgRp2eHfoP3
X-Google-Smtp-Source: AGHT+IGIlgaZGjYEAUEAW6UfLTM4pyozzJjM9JP1GHEuzaI2h679fPzJ5NUpmG+5nEF3K7UBzfF0OQ==
X-Received: by 2002:a17:903:184:b0:1c0:b163:2cc3 with SMTP id
 z4-20020a170903018400b001c0b1632cc3mr2018732plg.52.1694153296311; 
 Thu, 07 Sep 2023 23:08:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:08:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/65] target/riscv/cpu.c: add
 riscv_cpu_add_kvm_unavail_prop_array()
Date: Fri,  8 Sep 2023 16:04:19 +1000
Message-ID: <20230908060431.1903919-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Use a helper in riscv_cpu_add_kvm_properties() to eliminate some of its
code repetition.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230901194627.1214811-9-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d484d63bcd..8cd19a9b9c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1978,6 +1978,16 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
                         NULL, (void *)prop_name);
 }
 
+static void riscv_cpu_add_kvm_unavail_prop_array(Object *obj,
+                                                 Property *array)
+{
+    g_assert(array);
+
+    for (Property *prop = array; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+}
+
 static void riscv_cpu_add_kvm_properties(Object *obj)
 {
     Property *prop;
@@ -1986,17 +1996,9 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
     kvm_riscv_init_user_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-
-    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
-
-    for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
-    }
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_extensions);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_vendor_exts);
+    riscv_cpu_add_kvm_unavail_prop_array(obj, riscv_cpu_experimental_exts);
 
     for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
-- 
2.41.0


