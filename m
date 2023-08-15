Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3868B77D3FF
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:18:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0Sm-0001Wm-LP; Tue, 15 Aug 2023 16:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0Sl-0001WI-60
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:23 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0Sh-0004x1-DE
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:21 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bcbb0c40b1so4757076a34.3
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130578; x=1692735378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CV+Q96BqDr+yYM6mYpaiFr+4tsWPyiV37nU28yNXcuM=;
 b=Axz2hn/ofjBZtjuTCFdaWxxl/q22x2NBZO3BIwHiNX4FJ3aTd4/bbQwtLXPJSpMopz
 K3pQswCrlqYibFIdjzZXGl7DRKy8EXDMDBR0Eg4irvKqNYuy7yO2KbnTdDlwt90VZe59
 zvjYp2JPrk3dZO/2IShzQGABWJ3NAQbNnGj0YnJDMogxQAP1SECZTOXUlfzR0qno8Gfs
 Ve7MmjcYyVmheahxIBFpL7vMNWnkak6nTm9Rgetu4BP2qo/Co81q4STiluymd5apazHI
 QHcRbXZjh4sMI8Pt/KPelObvCxedMGLRMT8Z18+B9MbeUElxsGQlpG5xcMWkQM9K4Yda
 9zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130578; x=1692735378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CV+Q96BqDr+yYM6mYpaiFr+4tsWPyiV37nU28yNXcuM=;
 b=OEej2jHspqL/phwNYF8S1O7XtNB6WQkhc3vaemrzpith8ifYQWnaOdelkOTg5JS0NM
 Y8sPWZyUhKG6Hxd6LXlpWLS8JgIdghdBqbzOsxgqja/WWBmwlWIJlsTcD8zzTb0WnH0r
 d2sfjH9fZYg6Ymkl+M9TsUvNEQafbzb+2E6pTuB0ctXC8bj5soe5mGhhhRlS3eF2q00u
 tnt5ckCQk6XJjxxV3pOhn/ibBZRpXPyWWToYROI+rYDZbrjnmHwxCV6GWIXjpnCru2Rm
 hIS0st92kokZw9z49BZiKa6o/LqrVYa5Dc1fPFO878eFe1KlfPgfDBDnO2puGbUHsHfp
 OEEQ==
X-Gm-Message-State: AOJu0YzHUlz3DJpSIdYf3Md8FL6qSO4+p3ZjMF42uPZO0fXWrhYPcxDv
 GsQs2zj0HgZjt/OW505SlT5ifGk9njwO5U0sdNM=
X-Google-Smtp-Source: AGHT+IFlWZHnYPoV+cnU5CMg6QSjdfeUx/zEN2Jdu2/DiN55CKQP4HmZkfMei8dzeUs/dUQJhq6pew==
X-Received: by 2002:a05:6870:15d5:b0:1bb:ac7:2e34 with SMTP id
 k21-20020a05687015d500b001bb0ac72e34mr15176523oad.40.1692130577885; 
 Tue, 15 Aug 2023 13:16:17 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:17 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 04/12] target/riscv: add DEFINE_PROP_END_OF_LIST() to
 riscv_cpu_options[]
Date: Tue, 15 Aug 2023 17:15:51 -0300
Message-ID: <20230815201559.398643-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815201559.398643-1-dbarboza@ventanamicro.com>
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
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
index 7f0852a14e..854c56b6d0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1853,6 +1853,8 @@ static Property riscv_cpu_options[] = {
 
     DEFINE_PROP_UINT16("cbom_blocksize", RISCVCPU, cfg.cbom_blocksize, 64),
     DEFINE_PROP_UINT16("cboz_blocksize", RISCVCPU, cfg.cboz_blocksize, 64),
+
+    DEFINE_PROP_END_OF_LIST(),
 };
 
 #ifndef CONFIG_USER_ONLY
@@ -1904,12 +1906,12 @@ static void riscv_cpu_add_kvm_properties(Object *obj)
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
@@ -1940,8 +1942,8 @@ static void riscv_cpu_add_user_properties(Object *obj)
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


