Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE875867F
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:06:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrX-0002Xm-Ip; Tue, 18 Jul 2023 17:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrJ-0002Wi-VN
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:50 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrI-0007HM-9s
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:49 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b9b89627c3so3331959a34.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714226; x=1692306226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4Kup0f8lEPvJpAjqgttySpBZ7bPx6PupXRLjZCryf4=;
 b=WZH/ug6O6wZebYRBEIs02gc04ITElfovBAANLekvf42Wrtv1D+qHjUYQdWKEM75KOW
 J/gb+KoYf6jR91k4edJQCc7BF16apCgkMPPtR+9rk7sPJ5Si+vmjNrlr665Oti/IU5KH
 HxenhTueXquMDpqc2WP8eFtTXbUbUkc2XMmPetWxgC49BvJbwhHHjWRJajYh/49UGqcl
 dPkI2uIRKJfk0yC1ZhxsB1WmhMmce2BOIQzkafOMrMYJBLGiAJJCJ/JpoEFqCaDb1Wo/
 vQuHz043kRXBC+5cvdIkFJojchnnfHOpYTu7b0E11Y5OlI4dbYJFHiYaXks4hKDGqdeQ
 tqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714226; x=1692306226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N4Kup0f8lEPvJpAjqgttySpBZ7bPx6PupXRLjZCryf4=;
 b=HUqcc7gBXYbHlikxRjzx6CaASjCA4vOrWTdY2q9DGMgvcM0c39C/ObIold3e4a1PPv
 uCrkw/K/N4PiPTZhDBLc8dj/fkwBYRCtQeLbvKOssVthaHCPsTEgMFnloUd7fdt8cDVi
 80PggCmZBPyY99v3jDZamr7QGvImW7vWRS1RMEURZhyIF03AFEjx/7qHghM4LiWTGhlb
 MB3+8jf+xUHvkoGHTbV7bnth0qHekItWRumscZmE2eTbX4xzlfaQ5SaNN2dI+S4BkoIt
 WVq34l84uPsT+/tfZpLLCd/Dywquyd3rQMKm1G6fmWNUcfLJEZlYS0fNnEUDsuf9ukC3
 mUvA==
X-Gm-Message-State: ABy/qLZm4NVyhOGy9HbpeNQ452ck0HJxs483TzQr1UlCCbXlGa4gSm/b
 jwSp2zL/jAJVCtgAxDWwKY+xa/nGk5q6dzIXGSLnPA==
X-Google-Smtp-Source: APBJJlEMueFYaZiZOfQTE9rwZV+JBKzubL//uCX5rGxxRiSvMEd1k0vyz5rWgfuNg5XE50jvylC4lA==
X-Received: by 2002:a9d:6c0f:0:b0:6b7:cb42:8e17 with SMTP id
 f15-20020a9d6c0f000000b006b7cb428e17mr688309otq.4.1689714226484; 
 Tue, 18 Jul 2023 14:03:46 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:46 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 04/11] target/riscv/cpu.c: del
 DEFINE_PROP_END_OF_LIST() from riscv_cpu_extensions
Date: Tue, 18 Jul 2023 18:03:22 -0300
Message-ID: <20230718210329.200404-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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

This last blank element is used by the 'for' loop to check if a property
has a valid name.

Remove it and use ARRAY_SIZE() instead like riscv_cpu_options is already
using. All future arrays will also do the same and we'll able to
encapsulate more repetitions in macros later on.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/cpu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 1b6d546522..918acb9e6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1836,8 +1836,6 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("x-zfbfmin", RISCVCPU, cfg.ext_zfbfmin, false),
     DEFINE_PROP_BOOL("x-zvfbfmin", RISCVCPU, cfg.ext_zvfbfmin, false),
     DEFINE_PROP_BOOL("x-zvfbfwma", RISCVCPU, cfg.ext_zvfbfwma, false),
-
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static Property riscv_cpu_options[] = {
@@ -1892,14 +1890,13 @@ static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *prop_name)
 
 static void riscv_cpu_add_kvm_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
     kvm_riscv_init_user_properties(obj);
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, riscv_cpu_extensions[i].name);
     }
 
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
@@ -1920,7 +1917,6 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
  */
 static void riscv_cpu_add_user_properties(Object *obj)
 {
-    Property *prop;
     DeviceState *dev = DEVICE(obj);
 
 #ifndef CONFIG_USER_ONLY
@@ -1934,8 +1930,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
 
     riscv_cpu_add_misa_properties(obj);
 
-    for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
-        qdev_property_add_static(dev, prop);
+    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_extensions); i++) {
+        qdev_property_add_static(dev, &riscv_cpu_extensions[i]);
     }
 
     for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
-- 
2.41.0


