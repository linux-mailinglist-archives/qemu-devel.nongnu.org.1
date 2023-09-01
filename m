Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5A4790291
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 21:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcA6V-0007pE-Se; Fri, 01 Sep 2023 15:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6T-0007oo-MH
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:49 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qcA6R-0002xR-FZ
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 15:46:49 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-573429f5874so1343296eaf.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693597606; x=1694202406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZD9FSoA3HWWEBgRcZ4qvcVAMe96asfJwEtuGAeb9z+U=;
 b=ouoNSTbNlXPagz6mcML3hInD7aziySfgx9rCByW8J9BxzSKYCtnsC9GDjy5M1g5IcI
 J5PtZE40NoJnkWAe62DYwRklg7nvgfzOnlTdec80+a7wlx38p6lwzoUXnz+r1swd4td2
 8c13NbrWaN4Mar+4QdpChX3KspuFmTRHiTb9tvXJLof7DBT6Ymmh4/uj50p2XNEuoOao
 j06INvAZW6vTf4bDZSRM0okzUC5L5AGpwEfKZDmcnwACfI/GSJ4WzvEKVAOhErtvvRrV
 P/ccvUwnRa6ZdHIR3RWfiKpRqooXe1w0UFGPwSf8udQVrFajYPJ6ligaFae3fgGuv0bH
 mOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693597606; x=1694202406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZD9FSoA3HWWEBgRcZ4qvcVAMe96asfJwEtuGAeb9z+U=;
 b=F615YrMEN9tHhtXBr+bQ7VWlwX0tW2nPIQfsV7t2yfR9VACvHyUoNroHIhmPzYeSbf
 AWIy6u6zRaKPcXbr4FFCLPnE5emp5MkaZQxQ+vgDAC941G6/Kp8E460/xItY9sUKIjRe
 XPH6nSCxbd1rFD2s0jMqvPAMT/sjDirOSheUzzYo/uElGUPWAqXNBrrQ4GvD3sEEvS9u
 YZIMR54fjhgTDPNdThIeqstHcOPnzmuqUDc8RrpA9OCXJuM47i//TC6/i0Vljs27qhhs
 liozPfM+C55pN3MYz9CIKOExzawjMo5uwrirMOHrGlIjlE9OF1wRGGKdonRk/hi8oJLH
 /Fuw==
X-Gm-Message-State: AOJu0YyIG0Gn50iI7XuYZl7Jf9UElPcbrwpNNq7J4ThO+vdj1C4WVxPq
 4h9FDJmUxBAgD57dKhRpNX3y8P3YeOx2QYSnzgk=
X-Google-Smtp-Source: AGHT+IGIVA5ciR6n+YxEWky9LbdOYjQ3EapoXb/GoMzjZE/hUc9QodjYkC8ceTjGPdqhrD2ra/SAEw==
X-Received: by 2002:a4a:250f:0:b0:56e:4bb5:3095 with SMTP id
 g15-20020a4a250f000000b0056e4bb53095mr3291202ooa.5.1693597606169; 
 Fri, 01 Sep 2023 12:46:46 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.94.15.194])
 by smtp.gmail.com with ESMTPSA id
 h187-20020a4a5ec4000000b00565d41ba4d0sm2303002oob.35.2023.09.01.12.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 12:46:45 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 04/20] target/riscv: add DEFINE_PROP_END_OF_LIST() to
 riscv_cpu_options[]
Date: Fri,  1 Sep 2023 16:46:10 -0300
Message-ID: <20230901194627.1214811-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
References: <20230901194627.1214811-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
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

Add DEFINE_PROP_END_OF_LIST() and eliminate the ARRAY_SIZE() usage when
iterating in the riscv_cpu_options[] array, making it similar to what
we already do when working with riscv_cpu_extensions[].

We also have a more sophisticated motivation behind this change. In the
future we might need to export riscv_cpu_options[] to other files, and
ARRAY_LIST() doesn't work properly in that case because the array size
isn't exposed to the header file. Here's a future sight of what we would
deal with:

./target/riscv/kvm.c:1057:5: error: nested extern declaration of 'riscv_cpu_add_misa_properties' [-Werror=nested-externs]
n file included from ../target/riscv/kvm.c:19:
home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
 473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
     |                               ^
./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \
     |                             ^~~~~~~~~~
./target/riscv/kvm.c:1059:5: note: in expansion of macro 'ADD_UNAVAIL_KVM_PROP_ARRAY'
1059 |     ADD_UNAVAIL_KVM_PROP_ARRAY(obj, riscv_cpu_extensions);
     |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
home/danielhb/work/qemu/include/qemu/osdep.h:473:31: error: invalid application of 'sizeof' to incomplete type 'const RISCVCPUMultiExtConfig[]'
 473 | #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
     |                               ^
./target/riscv/kvm.c:1047:29: note: in expansion of macro 'ARRAY_SIZE'
1047 |         for (int i = 0; i < ARRAY_SIZE(_array); i++) { \

Homogenize the present and change the future by using
DEFINE_PROP_END_OF_LIST() in riscv_cpu_options[].

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 target/riscv/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8e6d316500..8662414906 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1922,6 +1922,8 @@ static Property riscv_cpu_options[] = {
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -1973,12 +1975,12 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
+    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
         /* Check if KVM created the property already */
-        if (object_property_find(obj, riscv_cpu_options[i].name)) {
+        if (object_property_find(obj, prop->name)) {
             continue;
         }
-        qdev_property_add_static(dev, &riscv_cpu_options[i]);
+        qdev_property_add_static(dev, prop);
     }
 }
 #endif
@@ -2009,8 +2011,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
-    for (int i = 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
-        qdev_property_add_static(dev, &riscv_cpu_options[i]);
+    for (prop = riscv_cpu_options; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
     }
 }
 
-- 
2.41.0


