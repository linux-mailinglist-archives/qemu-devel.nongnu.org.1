Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0F7937EA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 11:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdogS-0004qm-2G; Wed, 06 Sep 2023 05:18:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofK-0003lC-A6
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:40 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qdofH-0005pH-Sq
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 05:17:37 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bf58009a8dso2574375a34.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1693991854; x=1694596654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6NNHPAb3IB56FNbWTDGypgBzW5eAMUGFB8t2hQ5DMHo=;
 b=GGm5vp2xfllx1sj/XE/yQycQm87TKhxX+SiCZKCcIqYk3/TET3cxJTN3pWlN2IwpF6
 DeZ3cwWsVegO4LZgTbU00U9mbvdnqel4AiuBu5e1tVWhsCtEC0r5FwiD2zJ926OZcUJ/
 1JqX7k6efH20fJ705pixhJvMXDQTyFe9OjeZ8Kjr1z5/QTzNB2KEA7hGRNQNL5XpHf5u
 K+G+DmYG+MfZmpCkhI/XsPFH4RTXduvM9wTrG4KRlU0BlpyqndvJh9Kjqug+R/phPIlq
 KVrkVJiGxXG/QFRoVAPcqfu7qmwgujiSBxkjFbcBnkfSXLfR07GTMG+1ZGQ9s7sOazn7
 AYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693991854; x=1694596654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NNHPAb3IB56FNbWTDGypgBzW5eAMUGFB8t2hQ5DMHo=;
 b=JQEqJAtFeiNl3/JR7dwffpAD8MqfrfejiwnicgiU0rwFB1MgDmMXLln60uQ/NHc4Et
 Nh9vGA8h1GSAsrumuKh+rdRyNU9mJ9knCWMEBi42KgJjNMQy7b1caPKEBHZmyz/8PiLs
 5umz0ZQDJy2cgF/uwaBrSWRwKo/jMpXIlsbXx3ozbr/3c9mGamur5DD3faaX/s+qOMTp
 TCSq/wfAobvYKRrYguSasOa/Lte6t/GDv+1ks3tlcPhn7tyHi7x0yfZ+q3b6i6qMI26Y
 5pTlWnqow3O0HELcjOkAzR3xDvCVdibPxpA/NzBu2VffVeU+flkZIoqspGcMjEsmiezb
 +4yA==
X-Gm-Message-State: AOJu0YxKrT2oRJlVJQ0nlQ1O+NGrSJmHR+E/2WEXfGZyW8b24SVWHakH
 I9FGwNGIQy4Zl5Mp3atIQzYXyfOfyLvIzSA0I54=
X-Google-Smtp-Source: AGHT+IGitieUBxwymMohfinobpxVBN8WHs6MZgskInBOsZMAesggv3WsjlIKwpeH3niLu/kp4hrXDQ==
X-Received: by 2002:a9d:73ce:0:b0:6bf:ef0:c69 with SMTP id
 m14-20020a9d73ce000000b006bf0ef00c69mr16099691otk.34.1693991854421; 
 Wed, 06 Sep 2023 02:17:34 -0700 (PDT)
Received: from grind.. ([177.94.15.194]) by smtp.gmail.com with ESMTPSA id
 n21-20020a9d6f15000000b006b75242d6c3sm6229228otq.38.2023.09.06.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 02:17:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, philmd@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 12/19] target/riscv: move KVM only files to kvm subdir
Date: Wed,  6 Sep 2023 06:16:39 -0300
Message-ID: <20230906091647.1667171-13-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
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

Move the files to a 'kvm' dir to promote more code separation between
accelerators and making our lives easier supporting build options such
as --disable-tcg.

Rename kvm.c to kvm-cpu.c to keep it in line with its TCG counterpart.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 hw/intc/riscv_aplic.c                 | 2 +-
 hw/riscv/virt.c                       | 2 +-
 target/riscv/cpu.c                    | 2 +-
 target/riscv/{kvm.c => kvm/kvm-cpu.c} | 0
 target/riscv/{ => kvm}/kvm_riscv.h    | 0
 target/riscv/kvm/meson.build          | 1 +
 target/riscv/meson.build              | 2 +-
 7 files changed, 5 insertions(+), 4 deletions(-)
 rename target/riscv/{kvm.c => kvm/kvm-cpu.c} (100%)
 rename target/riscv/{ => kvm}/kvm_riscv.h (100%)
 create mode 100644 target/riscv/kvm/meson.build

diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
index 99aae8ccbe..c677b5cfbb 100644
--- a/hw/intc/riscv_aplic.c
+++ b/hw/intc/riscv_aplic.c
@@ -32,7 +32,7 @@
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
-#include "kvm_riscv.h"
+#include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 
 #define APLIC_MAX_IDC                  (1UL << 14)
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3b259b9305..6d9542f0a2 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -35,7 +35,7 @@
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
-#include "kvm_riscv.h"
+#include "kvm/kvm_riscv.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index c8a19be1af..51567c2f12 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -33,7 +33,7 @@
 #include "fpu/softfloat-helpers.h"
 #include "sysemu/kvm.h"
 #include "sysemu/tcg.h"
-#include "kvm_riscv.h"
+#include "kvm/kvm_riscv.h"
 #include "tcg/tcg.h"
 
 /* RISC-V CPU definitions */
diff --git a/target/riscv/kvm.c b/target/riscv/kvm/kvm-cpu.c
similarity index 100%
rename from target/riscv/kvm.c
rename to target/riscv/kvm/kvm-cpu.c
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
similarity index 100%
rename from target/riscv/kvm_riscv.h
rename to target/riscv/kvm/kvm_riscv.h
diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
new file mode 100644
index 0000000000..7e92415091
--- /dev/null
+++ b/target/riscv/kvm/meson.build
@@ -0,0 +1 @@
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 3323b78b84..c53962215f 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -24,7 +24,6 @@ riscv_ss.add(files(
   'zce_helper.c',
   'vcrypto_helper.c'
 ))
-riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
 
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
@@ -39,6 +38,7 @@ riscv_system_ss.add(files(
 ))
 
 subdir('tcg')
+subdir('kvm')
 
 target_arch += {'riscv': riscv_ss}
 target_softmmu_arch += {'riscv': riscv_system_ss}
-- 
2.41.0


