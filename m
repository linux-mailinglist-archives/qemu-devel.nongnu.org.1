Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9679D20E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3OD-0002pB-6h; Tue, 12 Sep 2023 09:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Nr-0002dH-5A
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:24:57 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qg3Nl-0003Wq-PS
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:24:50 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a76d882052so3979048b6e.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694525084; x=1695129884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvsMcO8KkAzI7CkHtZ53zjQmejmQZZMo5A4ybg1pjI0=;
 b=onpdLreClKU1L0Dz8ZyMDYW/QA+zT8aDdhB5Y4FB8CR/zLjxuuYnhroZsr2mXTMR+/
 SiJOQYY3uIcqM3dTpa6c5QEIrdj3UFRZ8+Q06RNO0QY5c6mOgmfFI2P7HipOS3i0JX97
 tbpNFNv+Wc5r2sNCyt6KqXPjTyUzs24NIM7L3J3nL3Hn0yddeE7qRAHkMSOomstJAfds
 DgRtlipbc7/ZReZ1u8PtE9wkJvPPhCSHE0ah9eQk4G4Q1s9x6f/jzPJPg7CkJUPQTnFt
 pmZfctrLWRNyB6wyPnJg8DMilq39uWjPfKY5YDn13Cj0efig7PD4OjnrAjxUgGC36sNe
 Pemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694525084; x=1695129884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WvsMcO8KkAzI7CkHtZ53zjQmejmQZZMo5A4ybg1pjI0=;
 b=vJftyIabCZ6wtRKtDFPHaNdVzZHuJwyLkiTdx/5T0z0gmuIRP+iP7MQa0HhVL0Ij4o
 mfOy6jjNc/482vUGIljA+HNeHXJDD3hOAbRXA17aoLNvS/hb5acf23NlFcAn//g1AlQg
 ul16Q9yVCwTeIHgjJ+XxOqLxb9L12SThw3clvKPjQMwG7Iv//xBrkDgc/ZoZQSyug3AD
 fDeBNbWBfz5Zcxg5QsWuiUltFJ28Q2JUvruv8N24zvtMPSv87OdVQ7s+lubnrO0tgQEz
 neu5SILrhwM29N2rRAidMSjtuCuyz1tq9+UyZevgPPLgaNvP2rBcVRNkSbp5VsFEJlC0
 TWLA==
X-Gm-Message-State: AOJu0YzjnQzxiJSuJRl5yDCsM2pfPCr6RjiJ9lwFmcPoDzdtSKurAWVx
 kxrXQDqM9HbC8pntGu61musCeDJqxj2ZuAbIbac=
X-Google-Smtp-Source: AGHT+IE4OLN59CX5OVpwU8jOfnjJU2GCp9nne/ipDTQ2G8MOWrPRmSYPiz5Szi6Ih86TmjgTrzXvfQ==
X-Received: by 2002:a54:4006:0:b0:3a7:3ea1:b597 with SMTP id
 x6-20020a544006000000b003a73ea1b597mr12683867oie.27.1694525084299; 
 Tue, 12 Sep 2023 06:24:44 -0700 (PDT)
Received: from grind.. ([177.9.182.82]) by smtp.gmail.com with ESMTPSA id
 p15-20020a0568301d4f00b006af9d8af435sm3991255oth.50.2023.09.12.06.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 06:24:44 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v10 04/20] target/riscv: add DEFINE_PROP_END_OF_LIST() to
 riscv_cpu_options[]
Date: Tue, 12 Sep 2023 10:24:07 -0300
Message-ID: <20230912132423.268494-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912132423.268494-1-dbarboza@ventanamicro.com>
References: <20230912132423.268494-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22d.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7b7c5649e7..ad6ce2c2dc 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1922,6 +1922,8 @@ static Property riscv_cpu_options[] = {
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifdef CONFIG_KVM
@@ -1971,12 +1973,12 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
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
@@ -2007,8 +2009,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


