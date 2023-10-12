Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D17C63F6
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn3O-0001Jo-Po; Thu, 12 Oct 2023 00:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2y-0000xl-9a
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn2m-00028P-M7
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:11:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c871a095ceso4632185ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083887; x=1697688687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ufNSG2dlvGq3D/ZExkaFCzNepKw+YSINBinPTLs4Ejo=;
 b=URpiT4sncIuXwA5R9IgoM423KbvPQL+0mamj94fduGMAc+SCsnwg6VpW1FgEVFB1O7
 ZkGN4wCvbSr6hOVFCCLeRzJQiIalpFQc8TwKcD4ztru/zoRUZlsME4Qp4mj8yddyFMY7
 P1ARSjSwUq0++OuHcDuPdyye2kTdH/pbbWTd1YeebTyuaUzDhoSulwTwcojZzw16sgmz
 P4Ja9puEGEKZhaqd7WAO7d3PXLM6sP+DZ/SRfBqJp1v9V0AmVKhmJAbialobjogTa0TR
 ew0/I8PYdiVj7VTeKCQPXVzrUjteeG8IOa+ycQxfqQIqGNu1q8REixnN96f8gAH/BNzT
 oBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083887; x=1697688687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ufNSG2dlvGq3D/ZExkaFCzNepKw+YSINBinPTLs4Ejo=;
 b=amSIQzGycYHbKELx8VRwR3+qNaspPc+BJR1nfaqaPXfnJU4rUCJWzWOlgbXj0rJHgz
 +2yCdPgIv9El8Q7pHY8f2CYzLINoSCMfocS8BBlGkxfqJHvw/DUtj2BMnUbVqoDRUnI0
 pP0G5JO58N3hTS2NPD+RpATDdatI4B38rr5+B5gokJzCGQ1Lo1K01/Jk3AzEbVDBnbUi
 3S14HgmK25zxSTwJ1WCkBgClN9P8fdH7QToqn/UyE7VCnLkxQjZR7TGjVO3N5HH0/TeS
 obcTfUN7NS0BS02lOlY3l7b12cDitehLkqxOTzt9pa4n9RTbfm2GcNm+WDkL6VwladI3
 WTNA==
X-Gm-Message-State: AOJu0YwTiVCLy41DkFfw1wIu6ClZCoLsk5tYlmn3gQMQNs9eNg2vfdGy
 mWbhnrWz8c/QVyOjNfGbhu25hW/U+uiWtg==
X-Google-Smtp-Source: AGHT+IHB8BBKhZIHhaSfFq+i2wJpWSv5KQv8uhEpPOMzKS57xZ3s0hoVwop5wbIXH1GFsMG1Giuh6w==
X-Received: by 2002:a17:903:1c1:b0:1c7:61a1:9695 with SMTP id
 e1-20020a17090301c100b001c761a19695mr22282888plh.20.1697083886733; 
 Wed, 11 Oct 2023 21:11:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:11:25 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PULL 06/54] target/riscv/cpu.c: split vendor exts from
 riscv_cpu_extensions[]
Date: Thu, 12 Oct 2023 14:10:03 +1000
Message-ID: <20231012041051.2572507-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

Our goal is to make riscv_cpu_extensions[] hold only ratified,
non-vendor extensions.

Create a new riscv_cpu_vendor_exts[] array for them, changing
riscv_cpu_add_user_properties() and riscv_cpu_add_kvm_properties()
accordingly.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20230912132423.268494-7-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index cba2c4998a..6289457514 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1863,7 +1863,10 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
     DEFINE_PROP_BOOL("zicond", RISCVCPU, cfg.ext_zicond, false),
 
-    /* Vendor-specific custom extensions */
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static Property riscv_cpu_vendor_exts[] = {
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
     DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
     DEFINE_PROP_BOOL("xtheadbs", RISCVCPU, cfg.ext_xtheadbs, false),
@@ -1972,6 +1975,10 @@ void kvm_riscv_cpu_add_kvm_properties(Object *obj)
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
     }
@@ -2016,6 +2023,10 @@ static void riscv_cpu_add_user_properties(Object *obj)
         qdev_property_add_static(dev, prop);
     }
 
+    for (prop = riscv_cpu_vendor_exts; prop && prop->name; prop++) {
+        qdev_property_add_static(dev, prop);
+    }
+
     for (prop = riscv_cpu_experimental_exts; prop && prop->name; prop++) {
         qdev_property_add_static(dev, prop);
     }
-- 
2.41.0


