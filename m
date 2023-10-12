Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC77C63CD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqn4S-00053v-6M; Thu, 12 Oct 2023 00:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4O-0004m4-6j
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:08 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qqn4L-0002d7-Tm
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:13:07 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-58916df84c8so397531a12.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697083984; x=1697688784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNBioE/2/3aMkxFMV3hajyAwKQgqD9Y29+KZLHG+4dA=;
 b=Y9ceBPzivIFUbT78qMExgOQdFZf7HfQcLKYSf+3hhNqUUFJXnk9c+hn8ZxhyHcUQqv
 J0PbzbCMqooBqdVQFxxWxmLhKSp2JpCEKCQtVjbcYw78HsaG0knssn/Fpaam0Q1d65wg
 yeqasLTjo/9AVibFQA5H/xrRlIjfnCLQ2tvCGSmJNJS/CBaMVCajOsf3ku4O/2U9hPLp
 +BalKZ0UvAXKMCRviOtuV04btqlf4lWi9+e0APHAH2HP++seoVannGDefpCxTzp0I+Jq
 LQAoNgL4wWTcRDF6J7OwNnCfdbA2e2sbAopurHF/sIqQ+CGbq+A30dXYsKRfq/i0poFK
 l0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697083984; x=1697688784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNBioE/2/3aMkxFMV3hajyAwKQgqD9Y29+KZLHG+4dA=;
 b=RcDdkjUOMWSKn6TFL67dC+yV/cENPtwF7TvdnHrXwhblgGVyAw5SwoU9ieT8JIbuWd
 PgVI3cokkCk/l9lLLxnJTGA8VjAMoBYUGTtLMfhnL2qfxaNp8BWeArtEvF3ovkVwJ+Ki
 cpldm4B0SMugCs1Ue4t4usCxqcdO8Rtas0H3Q3LU21pSB9jOmOZg3ElPY/yr5KJJSuRc
 3GIQPvFyMtqV5OiXunaFc5YGq99jm7+m3r3Jxss+qSaq3xq/2xXZrCS/CxZvSe29Vw84
 yEMdpaOpnSMiIMx3UcBbFd+qDvnDGWIP3WCrzUruW2WNQG7+hHKq3fco4HGKQcQ7v4Id
 +WwA==
X-Gm-Message-State: AOJu0YzDt/x6cOI6nj5NzZynI0bSp2iYggtEZ/51Jx71xsLvNVMUU4Ii
 X+cJazgcvM67/GhTp3tAIAr0FIz/S+Yk9g==
X-Google-Smtp-Source: AGHT+IGpvLwC3aDvK0d6wZGzfNS1LfcOAD/34S+JebRSqx+49EC+iyNOqKKe8Aylcw0ldyZM2oO0wA==
X-Received: by 2002:a05:6a20:9185:b0:163:9f1d:b464 with SMTP id
 v5-20020a056a20918500b001639f1db464mr23636523pzd.5.1697083983995; 
 Wed, 11 Oct 2023 21:13:03 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 ja20-20020a170902efd400b001c1f4edfb9csm726348plb.173.2023.10.11.21.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 21:13:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 34/54] target/riscv: move KVM only files to kvm subdir
Date: Thu, 12 Oct 2023 14:10:31 +1000
Message-ID: <20231012041051.2572507-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012041051.2572507-1-alistair.francis@wdc.com>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

Move the files to a 'kvm' dir to promote more code separation between
accelerators and making our lives easier supporting build options such
as --disable-tcg.

Rename kvm.c to kvm-cpu.c to keep it in line with its TCG counterpart.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20230925175709.35696-13-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/{ => kvm}/kvm_riscv.h    | 0
 hw/intc/riscv_aplic.c                 | 2 +-
 hw/riscv/virt.c                       | 2 +-
 target/riscv/cpu.c                    | 2 +-
 target/riscv/{kvm.c => kvm/kvm-cpu.c} | 0
 target/riscv/kvm/meson.build          | 1 +
 target/riscv/meson.build              | 2 +-
 7 files changed, 5 insertions(+), 4 deletions(-)
 rename target/riscv/{ => kvm}/kvm_riscv.h (100%)
 rename target/riscv/{kvm.c => kvm/kvm-cpu.c} (100%)
 create mode 100644 target/riscv/kvm/meson.build

diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
similarity index 100%
rename from target/riscv/kvm_riscv.h
rename to target/riscv/kvm/kvm_riscv.h
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
index 5edc1d98d2..9de578c756 100644
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
index 648b9f7af7..d8753240bf 100644
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
diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
new file mode 100644
index 0000000000..7e92415091
--- /dev/null
+++ b/target/riscv/kvm/meson.build
@@ -0,0 +1 @@
+riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index b30ebf5795..a5e0734e7f 100644
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
 target_system_arch += {'riscv': riscv_system_ss}
-- 
2.41.0


