Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72815A27DCA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Feb 2025 22:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQsB-0001cM-GS; Tue, 04 Feb 2025 16:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQs0-0001Zq-O1
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:14 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tfQrw-0008Uo-Sr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:54:12 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso382510a91.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738706047; x=1739310847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ig5mIixAd1D8GX2WLlPtXqEvEbM1IN99JeDTCSsEl4=;
 b=qsry4gnWfqYiX7RZHqyT63FEMi3JJxvf5B1a4njYRXdPSPF5O+z00uCBfLN6NmGwdH
 ji+JF4Gwz6wK7/ErVsojXBpsz0UvcvkOJyUTb8eDJRJHcY3HKrkjPoS4k0tQcxfIES+D
 9YXjoCeeoeBq9JlGhvjlhmFNQ9vdPtUDsiK3jVRZk/5fXcLMSnVyPNL5UbDo/1Da2iOt
 6Te8T7/hQky+ymNelmwJ6urJx9MpSQz7cWuAwMDpDBIaNCqbnUQ8a6uI2/YlX8EF4AJs
 K9H+tkGYI+BIMIMBGqcrmCrMeescTZb706uKRL+R8Gfjysp2tdlwPahQthzeTqbyOcfh
 dZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738706047; x=1739310847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ig5mIixAd1D8GX2WLlPtXqEvEbM1IN99JeDTCSsEl4=;
 b=nkCXIrl49GXqzvCfBb7G9B9KwDbz5KZWF/PmB/7I2gVLUecdA98+w8+X7+WAWI3O4/
 KPADL3KQmrSedP42ghN2jGNqdP4l2EZnbzeASS1WIy8f9gqfumzKJkwGioO0rlswfaZV
 y06DlXwDEptj4nzPgh45oMFq2tfws1S45QQ8hrsjlJHLjARZsYeeWWpbpKz9aY67kqgb
 KqJAn1aa7CcxN7bJcFW3DGwfs9Yqep85Di6FG2wlB0v2V9gHywpi8SCEX67vSX12qOv8
 U5BWzLXLxZRbHXGoSGYiBmoo2GKdFnrW5033JfLkPH27rqStX9+vY2htBSjqYhLriwvx
 Vhbg==
X-Gm-Message-State: AOJu0Ywu0t6pndTscjAQZwXPpeT9ewXHq178oJZNVjVMiU7c5ge1Uxfj
 /Nsgq8n6UV1e/QJFs6Jlitxau9vyIsBPW0QJ8Ys0aZhKirg66mE1UAYHcUXDzcM5YX0fSnA3BFy
 e
X-Gm-Gg: ASbGncujV7FHy3alSSji5lSnUUZc8VWWc/D0KzC/B39wKGIL42eW1fEoBAaMZjjxCLW
 tfn5oExsmfJODoQbGackKS12gau1sn7aZgDbJA7OIW16fwPms/3nZYjqqGbDmlGFMKwyxQ5lxe7
 HBNugpsxMGA1ESCOAmIwIvSTIwiVvIzhAZua2FQigcD8yNDHGUF8CCH4Np949ZrnkWsjQm39gpH
 bXXikfu3q4ngKjSXF4sn9DknX5xT2oPJd59bzUZWsQCJgLb7ftcBkmTRKGxaMVuhyoj96Myp6fm
 y4vm/qlrwG/JnWHYhocCycI2q3BYjRLJg1UyAR3iS9rh0zk=
X-Google-Smtp-Source: AGHT+IEHH9MVTIlbQou/s3m5gpcrf6X/cYxjVC8p6Ck9tlobnoYnsBY7mgbfRs1LHhMJtHXkrYtD0A==
X-Received: by 2002:a17:90b:1954:b0:2f6:e47c:1750 with SMTP id
 98e67ed59e1d1-2f9dff6c294mr879906a91.13.1738706047126; 
 Tue, 04 Feb 2025 13:54:07 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9e1d60b57sm33888a91.9.2025.02.04.13.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 13:54:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 philmd@linaro.org, thuth@redhat.com
Subject: [PATCH v3 08/12] configure: Define TARGET_LONG_BITS in
 configs/targets/*.mak
Date: Tue,  4 Feb 2025 13:53:55 -0800
Message-ID: <20250204215359.1238808-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204215359.1238808-1-richard.henderson@linaro.org>
References: <20250204215359.1238808-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Define TARGET_LONG_BITS in each target's configure fragment.
Do this without removing the define in target/*/cpu-param.h
so that errors are caught like so:

In file included from .../src/include/exec/cpu-defs.h:26,
                 from ../src/target/hppa/cpu.h:24,
                 from ../src/linux-user/qemu.h:4,
                 from ../src/linux-user/hppa/cpu_loop.c:21:
../src/target/hppa/cpu-param.h:11: error: "TARGET_LONG_BITS" redefined [-Werror]
   11 | #define TARGET_LONG_BITS              64
      |
In file included from .../src/include/qemu/osdep.h:36,
                 from ../src/linux-user/hppa/cpu_loop.c:20:
./hppa-linux-user-config-target.h:32: note: this is the location of the previous definition
   32 | #define TARGET_LONG_BITS 32
      |
cc1: all warnings being treated as errors

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/aarch64-bsd-user.mak        | 1 +
 configs/targets/aarch64-linux-user.mak      | 1 +
 configs/targets/aarch64-softmmu.mak         | 1 +
 configs/targets/aarch64_be-linux-user.mak   | 1 +
 configs/targets/alpha-linux-user.mak        | 1 +
 configs/targets/alpha-softmmu.mak           | 1 +
 configs/targets/arm-bsd-user.mak            | 1 +
 configs/targets/arm-linux-user.mak          | 1 +
 configs/targets/arm-softmmu.mak             | 1 +
 configs/targets/armeb-linux-user.mak        | 1 +
 configs/targets/avr-softmmu.mak             | 1 +
 configs/targets/hexagon-linux-user.mak      | 1 +
 configs/targets/hppa-linux-user.mak         | 2 ++
 configs/targets/hppa-softmmu.mak            | 1 +
 configs/targets/i386-bsd-user.mak           | 1 +
 configs/targets/i386-linux-user.mak         | 1 +
 configs/targets/i386-softmmu.mak            | 1 +
 configs/targets/loongarch64-linux-user.mak  | 1 +
 configs/targets/loongarch64-softmmu.mak     | 1 +
 configs/targets/m68k-linux-user.mak         | 1 +
 configs/targets/m68k-softmmu.mak            | 1 +
 configs/targets/microblaze-linux-user.mak   | 1 +
 configs/targets/microblaze-softmmu.mak      | 3 +++
 configs/targets/microblazeel-linux-user.mak | 1 +
 configs/targets/microblazeel-softmmu.mak    | 3 +++
 configs/targets/mips-linux-user.mak         | 1 +
 configs/targets/mips-softmmu.mak            | 1 +
 configs/targets/mips64-linux-user.mak       | 1 +
 configs/targets/mips64-softmmu.mak          | 1 +
 configs/targets/mips64el-linux-user.mak     | 1 +
 configs/targets/mips64el-softmmu.mak        | 1 +
 configs/targets/mipsel-linux-user.mak       | 1 +
 configs/targets/mipsel-softmmu.mak          | 1 +
 configs/targets/mipsn32-linux-user.mak      | 1 +
 configs/targets/mipsn32el-linux-user.mak    | 1 +
 configs/targets/or1k-linux-user.mak         | 1 +
 configs/targets/or1k-softmmu.mak            | 1 +
 configs/targets/ppc-linux-user.mak          | 1 +
 configs/targets/ppc-softmmu.mak             | 1 +
 configs/targets/ppc64-linux-user.mak        | 1 +
 configs/targets/ppc64-softmmu.mak           | 1 +
 configs/targets/ppc64le-linux-user.mak      | 1 +
 configs/targets/riscv32-linux-user.mak      | 1 +
 configs/targets/riscv32-softmmu.mak         | 1 +
 configs/targets/riscv64-bsd-user.mak        | 1 +
 configs/targets/riscv64-linux-user.mak      | 1 +
 configs/targets/riscv64-softmmu.mak         | 1 +
 configs/targets/rx-softmmu.mak              | 1 +
 configs/targets/s390x-linux-user.mak        | 1 +
 configs/targets/s390x-softmmu.mak           | 1 +
 configs/targets/sh4-linux-user.mak          | 1 +
 configs/targets/sh4-softmmu.mak             | 1 +
 configs/targets/sh4eb-linux-user.mak        | 1 +
 configs/targets/sh4eb-softmmu.mak           | 1 +
 configs/targets/sparc-linux-user.mak        | 1 +
 configs/targets/sparc-softmmu.mak           | 1 +
 configs/targets/sparc32plus-linux-user.mak  | 1 +
 configs/targets/sparc64-linux-user.mak      | 1 +
 configs/targets/sparc64-softmmu.mak         | 1 +
 configs/targets/tricore-softmmu.mak         | 1 +
 configs/targets/x86_64-bsd-user.mak         | 1 +
 configs/targets/x86_64-linux-user.mak       | 1 +
 configs/targets/x86_64-softmmu.mak          | 1 +
 configs/targets/xtensa-linux-user.mak       | 1 +
 configs/targets/xtensa-softmmu.mak          | 1 +
 configs/targets/xtensaeb-linux-user.mak     | 1 +
 configs/targets/xtensaeb-softmmu.mak        | 1 +
 67 files changed, 72 insertions(+)

diff --git a/configs/targets/aarch64-bsd-user.mak b/configs/targets/aarch64-bsd-user.mak
index 8aaa5d8c80..f99c73377a 100644
--- a/configs/targets/aarch64-bsd-user.mak
+++ b/configs/targets/aarch64-bsd-user.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=aarch64
 TARGET_BASE_ARCH=arm
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/aarch64-pauth.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64-linux-user.mak b/configs/targets/aarch64-linux-user.mak
index 4c6570f56a..b779ac3b4a 100644
--- a/configs/targets/aarch64-linux-user.mak
+++ b/configs/targets/aarch64-linux-user.mak
@@ -6,3 +6,4 @@ CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=common,64,renameat,rlimit,memfd_secret
 TARGET_SYSTBL=syscall_64.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch64-softmmu.mak
index 84cb32dc2f..82cb72cb83 100644
--- a/configs/targets/aarch64-softmmu.mak
+++ b/configs/targets/aarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/aarch64-core.xml gdb-xml/aarch64-fpu.xml gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml gdb-xml/aarch64-pauth.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/aarch64_be-linux-user.mak b/configs/targets/aarch64_be-linux-user.mak
index dcef597a80..ef9be02290 100644
--- a/configs/targets/aarch64_be-linux-user.mak
+++ b/configs/targets/aarch64_be-linux-user.mak
@@ -7,3 +7,4 @@ CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=common,64,renameat,rlimit,memfd_secret
 TARGET_SYSTBL=syscall_64.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index f7d3fb4afa..ef8e365b09 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index 9dbe160740..89f3517aca 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=alpha
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/arm-bsd-user.mak b/configs/targets/arm-bsd-user.mak
index cb143e6426..472a4f9fb1 100644
--- a/configs/targets/arm-bsd-user.mak
+++ b/configs/targets/arm-bsd-user.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=arm
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/arm-linux-user.mak b/configs/targets/arm-linux-user.mak
index 7f5d65794c..bf35ded7fe 100644
--- a/configs/targets/arm-linux-user.mak
+++ b/configs/targets/arm-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/arm-softmmu.mak b/configs/targets/arm-softmmu.mak
index bf390b7a8d..afc64f5927 100644
--- a/configs/targets/arm-softmmu.mak
+++ b/configs/targets/arm-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml gdb-xml/arm-vfp-sysregs.xml gdb-xml/arm-neon.xml gdb-xml/arm-m-profile.xml gdb-xml/arm-m-profile-mve.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/armeb-linux-user.mak b/configs/targets/armeb-linux-user.mak
index 943d0d87bf..35fa4d91b3 100644
--- a/configs/targets/armeb-linux-user.mak
+++ b/configs/targets/armeb-linux-user.mak
@@ -6,3 +6,4 @@ TARGET_XML_FILES= gdb-xml/arm-core.xml gdb-xml/arm-vfp.xml gdb-xml/arm-vfp3.xml
 TARGET_HAS_BFLT=y
 CONFIG_SEMIHOSTING=y
 CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/avr-softmmu.mak b/configs/targets/avr-softmmu.mak
index e3f921c019..b6157fc465 100644
--- a/configs/targets/avr-softmmu.mak
+++ b/configs/targets/avr-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=avr
 TARGET_XML_FILES= gdb-xml/avr-cpu.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/hexagon-linux-user.mak b/configs/targets/hexagon-linux-user.mak
index b912045bd3..aec1a04d1b 100644
--- a/configs/targets/hexagon-linux-user.mak
+++ b/configs/targets/hexagon-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=hexagon
 TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,32,hexagon,time32,stat64,rlimit,renameat
+TARGET_LONG_BITS=32
diff --git a/configs/targets/hppa-linux-user.mak b/configs/targets/hppa-linux-user.mak
index 8e0a80492f..59190f6335 100644
--- a/configs/targets/hppa-linux-user.mak
+++ b/configs/targets/hppa-linux-user.mak
@@ -3,3 +3,5 @@ TARGET_ABI32=y
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+# Compromise to ease maintenance vs system mode
+TARGET_LONG_BITS=64
diff --git a/configs/targets/hppa-softmmu.mak b/configs/targets/hppa-softmmu.mak
index a41662aa99..63ca74ed5e 100644
--- a/configs/targets/hppa-softmmu.mak
+++ b/configs/targets/hppa-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=hppa
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/i386-bsd-user.mak b/configs/targets/i386-bsd-user.mak
index 0283bb62a0..70e098da49 100644
--- a/configs/targets/i386-bsd-user.mak
+++ b/configs/targets/i386-bsd-user.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=i386
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-linux-user.mak b/configs/targets/i386-linux-user.mak
index b72a156473..ea68a266fc 100644
--- a/configs/targets/i386-linux-user.mak
+++ b/configs/targets/i386-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=i386
 TARGET_SYSTBL_ABI=i386
 TARGET_SYSTBL=syscall_32.tbl
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml gdb-xml/i386-32bit-linux.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-softmmu.mak
index 2eb0e86250..5dd8921756 100644
--- a/configs/targets/i386-softmmu.mak
+++ b/configs/targets/i386-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-32bit.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index dfded79dfa..249a26a798 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=loongarch
 TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
+TARGET_LONG_BITS=64
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index ce19ab6a16..351341132f 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/m68k-linux-user.mak b/configs/targets/m68k-linux-user.mak
index 579b5d299c..2d9bae2270 100644
--- a/configs/targets/m68k-linux-user.mak
+++ b/configs/targets/m68k-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
 TARGET_HAS_BFLT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/m68k-softmmu.mak b/configs/targets/m68k-softmmu.mak
index bbcd0bada6..bacc52e96a 100644
--- a/configs/targets/m68k-softmmu.mak
+++ b/configs/targets/m68k-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=m68k
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/cf-core.xml gdb-xml/cf-fp.xml gdb-xml/m68k-core.xml gdb-xml/m68k-fp.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblaze-linux-user.mak b/configs/targets/microblaze-linux-user.mak
index 0a2322c249..3772779769 100644
--- a/configs/targets/microblaze-linux-user.mak
+++ b/configs/targets/microblaze-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblaze-softmmu.mak b/configs/targets/microblaze-softmmu.mak
index eea266d4f3..99a33ed44a 100644
--- a/configs/targets/microblaze-softmmu.mak
+++ b/configs/targets/microblaze-softmmu.mak
@@ -4,3 +4,6 @@ TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+# System mode can address up to 64 bits via lea/sea instructions.
+# TODO: These bypass the mmu, so we could emulate these differently.
+TARGET_LONG_BITS=64
diff --git a/configs/targets/microblazeel-linux-user.mak b/configs/targets/microblazeel-linux-user.mak
index 270743156a..a51a05488d 100644
--- a/configs/targets/microblazeel-linux-user.mak
+++ b/configs/targets/microblazeel-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
index 77b968acad..52cdeae1a2 100644
--- a/configs/targets/microblazeel-softmmu.mak
+++ b/configs/targets/microblazeel-softmmu.mak
@@ -3,3 +3,6 @@ TARGET_SUPPORTS_MTTCG=y
 # needed by boot.c
 TARGET_NEED_FDT=y
 TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
+# System mode can address up to 64 bits via lea/sea instructions.
+# TODO: These bypass the mmu, so we could emulate these differently.
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mips-linux-user.mak b/configs/targets/mips-linux-user.mak
index b4569a9893..69bdc459b6 100644
--- a/configs/targets/mips-linux-user.mak
+++ b/configs/targets/mips-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/mips-softmmu.mak b/configs/targets/mips-softmmu.mak
index d34b4083fc..b62a088249 100644
--- a/configs/targets/mips-softmmu.mak
+++ b/configs/targets/mips-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/mips64-linux-user.mak b/configs/targets/mips64-linux-user.mak
index d2ff509a11..04e82b3ab1 100644
--- a/configs/targets/mips64-linux-user.mak
+++ b/configs/targets/mips64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mips64-softmmu.mak b/configs/targets/mips64-softmmu.mak
index 12d9483bf0..7202655fca 100644
--- a/configs/targets/mips64-softmmu.mak
+++ b/configs/targets/mips64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mips64el-linux-user.mak b/configs/targets/mips64el-linux-user.mak
index f9efeec8ea..27f4169426 100644
--- a/configs/targets/mips64el-linux-user.mak
+++ b/configs/targets/mips64el-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_ABI_MIPSN64=y
 TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n64
 TARGET_SYSTBL=syscall_n64.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips64el-softmmu.mak
index 3864daa736..3ebeadb29e 100644
--- a/configs/targets/mips64el-softmmu.mak
+++ b/configs/targets/mips64el-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=mips64
 TARGET_BASE_ARCH=mips
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mipsel-linux-user.mak b/configs/targets/mipsel-linux-user.mak
index e8d7241d31..8b7e86ab28 100644
--- a/configs/targets/mipsel-linux-user.mak
+++ b/configs/targets/mipsel-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=mips
 TARGET_ABI_MIPSO32=y
 TARGET_SYSTBL_ABI=o32
 TARGET_SYSTBL=syscall_o32.tbl
+TARGET_LONG_BITS=32
diff --git a/configs/targets/mipsel-softmmu.mak b/configs/targets/mipsel-softmmu.mak
index 0829659fc2..620ec68178 100644
--- a/configs/targets/mipsel-softmmu.mak
+++ b/configs/targets/mipsel-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=mips
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/mipsn32-linux-user.mak b/configs/targets/mipsn32-linux-user.mak
index 206095da64..39ae214633 100644
--- a/configs/targets/mipsn32-linux-user.mak
+++ b/configs/targets/mipsn32-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/mipsn32el-linux-user.mak b/configs/targets/mipsn32el-linux-user.mak
index ca2a3ed753..d9b61d6990 100644
--- a/configs/targets/mipsn32el-linux-user.mak
+++ b/configs/targets/mipsn32el-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_ABI32=y
 TARGET_BASE_ARCH=mips
 TARGET_SYSTBL_ABI=n32
 TARGET_SYSTBL=syscall_n32.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/or1k-linux-user.mak b/configs/targets/or1k-linux-user.mak
index eecb1e2241..810567a98f 100644
--- a/configs/targets/or1k-linux-user.mak
+++ b/configs/targets/or1k-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=openrisc
 TARGET_BIG_ENDIAN=y
 TARGET_SYSTBL_ABI=common,32,or1k,time32,stat64,rlimit,renameat
 TARGET_SYSTBL=syscall.tbl
+TARGET_LONG_BITS=32
diff --git a/configs/targets/or1k-softmmu.mak b/configs/targets/or1k-softmmu.mak
index 0341cb2a6b..adfddb1a8a 100644
--- a/configs/targets/or1k-softmmu.mak
+++ b/configs/targets/or1k-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_BIG_ENDIAN=y
 # needed by boot.c and all boards
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc-linux-user.mak b/configs/targets/ppc-linux-user.mak
index cc0439a528..970d04a5ba 100644
--- a/configs/targets/ppc-linux-user.mak
+++ b/configs/targets/ppc-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,nospu,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmmu.mak
index 53120dab41..9bfa7df6c3 100644
--- a/configs/targets/ppc-softmmu.mak
+++ b/configs/targets/ppc-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=ppc
 TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml
+TARGET_LONG_BITS=32
diff --git a/configs/targets/ppc64-linux-user.mak b/configs/targets/ppc64-linux-user.mak
index 4d81969f4a..461f1c67d1 100644
--- a/configs/targets/ppc64-linux-user.mak
+++ b/configs/targets/ppc64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_SYSTBL_ABI=common,nospu,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-softmmu.mak
index 40881d9396..7cee0e97f4 100644
--- a/configs/targets/ppc64-softmmu.mak
+++ b/configs/targets/ppc64-softmmu.mak
@@ -6,3 +6,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/ppc64le-linux-user.mak b/configs/targets/ppc64le-linux-user.mak
index 426d5a28d6..cf9d8a400d 100644
--- a/configs/targets/ppc64le-linux-user.mak
+++ b/configs/targets/ppc64le-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_ABI_DIR=ppc
 TARGET_SYSTBL_ABI=common,nospu,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_XML_FILES= gdb-xml/power64-core.xml gdb-xml/power-fpu.xml gdb-xml/power-altivec.xml gdb-xml/power-spe.xml gdb-xml/power-vsx.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/riscv32-linux-user.mak b/configs/targets/riscv32-linux-user.mak
index 0dbaf5210a..a0ef03c0c3 100644
--- a/configs/targets/riscv32-linux-user.mak
+++ b/configs/targets/riscv32-linux-user.mak
@@ -7,3 +7,4 @@ CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=32
 TARGET_SYSTBL_ABI=common,32,riscv,memfd_secret
 TARGET_SYSTBL=syscall.tbl
+TARGET_LONG_BITS=32
diff --git a/configs/targets/riscv32-softmmu.mak b/configs/targets/riscv32-softmmu.mak
index 338182d5b8..c828066ce6 100644
--- a/configs/targets/riscv32-softmmu.mak
+++ b/configs/targets/riscv32-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_XML_FILES= gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
index 191c2c483f..c6348a7962 100644
--- a/configs/targets/riscv64-bsd-user.mak
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=riscv64
 TARGET_BASE_ARCH=riscv
 TARGET_ABI_DIR=riscv
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/riscv64-linux-user.mak b/configs/targets/riscv64-linux-user.mak
index 477cd4523e..aac7568305 100644
--- a/configs/targets/riscv64-linux-user.mak
+++ b/configs/targets/riscv64-linux-user.mak
@@ -7,3 +7,4 @@ CONFIG_ARM_COMPATIBLE_SEMIHOSTING=y
 TARGET_SYSTBL_ABI=64
 TARGET_SYSTBL_ABI=common,64,riscv,rlimit,memfd_secret
 TARGET_SYSTBL=syscall.tbl
+TARGET_LONG_BITS=64
diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv64-softmmu.mak
index 6c5de72e03..09f613d24a 100644
--- a/configs/targets/riscv64-softmmu.mak
+++ b/configs/targets/riscv64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml gdb-xml/riscv-32bit-cpu.xml gdb-xml/riscv-32bit-virtual.xml
 # needed by boot.c
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/rx-softmmu.mak b/configs/targets/rx-softmmu.mak
index 706bbe6062..1c250a6450 100644
--- a/configs/targets/rx-softmmu.mak
+++ b/configs/targets/rx-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=rx
 TARGET_XML_FILES= gdb-xml/rx-core.xml
 # all boards require libfdt
 TARGET_NEED_FDT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x-linux-user.mak
index 24c04c8589..68c2f28872 100644
--- a/configs/targets/s390x-linux-user.mak
+++ b/configs/targets/s390x-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index b22218aacc..5242ebe7c2 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/sh4-linux-user.mak b/configs/targets/sh4-linux-user.mak
index 9908887566..d58c5471b7 100644
--- a/configs/targets/sh4-linux-user.mak
+++ b/configs/targets/sh4-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=sh4
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sh4-softmmu.mak b/configs/targets/sh4-softmmu.mak
index f9d62d91e4..787d349b50 100644
--- a/configs/targets/sh4-softmmu.mak
+++ b/configs/targets/sh4-softmmu.mak
@@ -1 +1,2 @@
 TARGET_ARCH=sh4
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sh4eb-linux-user.mak b/configs/targets/sh4eb-linux-user.mak
index 9db6b3609c..99007f0f2d 100644
--- a/configs/targets/sh4eb-linux-user.mak
+++ b/configs/targets/sh4eb-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sh4eb-softmmu.mak b/configs/targets/sh4eb-softmmu.mak
index 226b1fc698..cdea2c61c5 100644
--- a/configs/targets/sh4eb-softmmu.mak
+++ b/configs/targets/sh4eb-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sh4
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index abcfb8fc62..4ff4b7287d 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index a5d9200382..78c2e25bd1 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 6cc8fa516b..7a16934fd1 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 52f05ec000..64ea04e3e2 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index 36ca64ec41..f7bab97a00 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=64
diff --git a/configs/targets/tricore-softmmu.mak b/configs/targets/tricore-softmmu.mak
index 96b10af853..781ce49a62 100644
--- a/configs/targets/tricore-softmmu.mak
+++ b/configs/targets/tricore-softmmu.mak
@@ -1 +1,2 @@
 TARGET_ARCH=tricore
+TARGET_LONG_BITS=32
diff --git a/configs/targets/x86_64-bsd-user.mak b/configs/targets/x86_64-bsd-user.mak
index 799cd4acd4..d62d656f2c 100644
--- a/configs/targets/x86_64-bsd-user.mak
+++ b/configs/targets/x86_64-bsd-user.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=x86_64
 TARGET_BASE_ARCH=i386
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-linux-user.mak b/configs/targets/x86_64-linux-user.mak
index 86042814d3..b093ab5a16 100644
--- a/configs/targets/x86_64-linux-user.mak
+++ b/configs/targets/x86_64-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_BASE_ARCH=i386
 TARGET_SYSTBL_ABI=common,64
 TARGET_SYSTBL=syscall_64.tbl
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml gdb-xml/i386-64bit-linux.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-softmmu.mak
index 920e9a4200..1ceefde131 100644
--- a/configs/targets/x86_64-softmmu.mak
+++ b/configs/targets/x86_64-softmmu.mak
@@ -4,3 +4,4 @@ TARGET_SUPPORTS_MTTCG=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_KVM_HAVE_RESET_PARKED_VCPU=y
 TARGET_XML_FILES= gdb-xml/i386-64bit.xml
+TARGET_LONG_BITS=64
diff --git a/configs/targets/xtensa-linux-user.mak b/configs/targets/xtensa-linux-user.mak
index 420b30a68d..cbec6e368a 100644
--- a/configs/targets/xtensa-linux-user.mak
+++ b/configs/targets/xtensa-linux-user.mak
@@ -2,3 +2,4 @@ TARGET_ARCH=xtensa
 TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_HAS_BFLT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensa-softmmu.mak b/configs/targets/xtensa-softmmu.mak
index f075557bfa..65845df4ff 100644
--- a/configs/targets/xtensa-softmmu.mak
+++ b/configs/targets/xtensa-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=xtensa
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensaeb-linux-user.mak b/configs/targets/xtensaeb-linux-user.mak
index bce2d1d65d..f455b1c780 100644
--- a/configs/targets/xtensaeb-linux-user.mak
+++ b/configs/targets/xtensaeb-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_HAS_BFLT=y
+TARGET_LONG_BITS=32
diff --git a/configs/targets/xtensaeb-softmmu.mak b/configs/targets/xtensaeb-softmmu.mak
index b02e11b820..f1f789d697 100644
--- a/configs/targets/xtensaeb-softmmu.mak
+++ b/configs/targets/xtensaeb-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=xtensa
 TARGET_BIG_ENDIAN=y
 TARGET_SUPPORTS_MTTCG=y
+TARGET_LONG_BITS=32
-- 
2.43.0


