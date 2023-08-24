Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68057787B4A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIbZ-0007k6-NW; Thu, 24 Aug 2023 18:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbW-0007jQ-O8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:02 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbS-0005xy-KT
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:02 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6bd04558784so255170a34.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915297; x=1693520097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cOQQ6jFlXXGQngphIeWg4NctK2p/EdCZ2+8RO008qEs=;
 b=VBTyggj/IiaFThN9OOxHP7C3R/Z44r5lzdjah420gtVzKlW3yCYmp6rfcDh/GhOCYY
 Yl+orv5XfsfIsxJYnN316KlcVVqcfpVDxoLHg6XTdGA682XKB/fqoK3vvcahBCFxpffF
 NrjpRTKnPNPOum6juiz8Ln9dmw9Ho/zfFNfeo4SLoMnXqs/9CuhmWMial394aH/bHnuv
 tXmQhzHOoSvSQHbguTthJOjvKdftpNHqXuZpQ6wgKl2c1Y9OZWSspJPt9qaA1gOx3TmE
 oTHnGI8GQFvFlewavTQiyLY0Y+lydPVf3ClbYf7qXrGK7h5bw0yhbSXCgAshna4I0JKk
 HwzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915297; x=1693520097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cOQQ6jFlXXGQngphIeWg4NctK2p/EdCZ2+8RO008qEs=;
 b=lQYUWdmDxPxWEUAT3SU8RnzS6RRtEvPUrPz2/pgPFhruf0wlL8jQQC4MmY5SlngeSK
 loZXPhIX/Dg7adF1DmPKtJj1PK22PAPyqSVtuNAVMTY9T8NoR8QolY5rDsHYLb8H81lG
 maatneiUDbwZZYMC13NOLxAPDFel2G8EIp6Ne0Ant2Vumh1DYfXaefuPHjr85Pf1jWWG
 se36+TmI4Z+S6E83+DkeIdsAgrkxfplkDk1KswQ/g7PPpTqyIKt46Q5/eLoQ/WMu59Fp
 Z9SYMcM//mIDvsoAlkYRb4JsXhQidWAzN/GZ/UboQfbQWYKUba6MkGeOrdU1nUhyrne1
 4ikw==
X-Gm-Message-State: AOJu0YyzwWAi2YJZ1T+4hefBECI0vGosSNF5DhMcq5c4u/km9RQYcxi9
 KUjTnS6SpZnjoSkB905CguEP2RBn/JIu4DTGWT4=
X-Google-Smtp-Source: AGHT+IF4nXtxI2jkG4ReeZ8jgtvsJ5bdZkTRlisUOvak0O0U0vFkOP2QQ4zl1f6rEsvZQjZ66buWEA==
X-Received: by 2002:a05:6870:56ab:b0:1c0:937:455d with SMTP id
 p43-20020a05687056ab00b001c00937455dmr1253277oao.47.1692915297174; 
 Thu, 24 Aug 2023 15:14:57 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:14:56 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 04/20] target/riscv: add DEFINE_PROP_END_OF_LIST()
 to riscv_cpu_options[]
Date: Thu, 24 Aug 2023 19:14:24 -0300
Message-ID: <20230824221440.484675-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
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
---
 target/riscv/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index a51b946804..272edaadf0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1916,6 +1916,8 @@ static Property riscv_cpu_options[] = {
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -1967,12 +1969,12 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
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
@@ -2003,8 +2005,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


