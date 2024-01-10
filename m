Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648A08295D2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUUP-00066U-3z; Wed, 10 Jan 2024 04:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSt-0003Mr-Mn
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:40 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUSr-0005eV-Sm
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:01:35 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so3002779a12.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 01:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877291; x=1705482091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikOT+QqWMH+ik9Ol/QXFf7Pbp082xw1hX5CbWL8PK2o=;
 b=NLIVqscYAgY1/N5NeTW4/lzQKHISLmINhKLsAbDk2ZZJEz88uiHgcu2Z6VOhRPoNA1
 0ZM5RpGOE5ZaWxRQpoaRzaXYLYQakrnbO+Wfaia3fLT6Mpup7ymvK+l1zwi3GsZVQfjU
 wJ437GkbYy4NHADyFXK0vrLzk+H+MbJhV9sngBm43e6xEIL4zYzGWN395IjO7sOeZ/cH
 zbjEr1utNv90y2BewHfHr4lzdJ0lc+xewc3wj0xcs0svPLavvTTjh0ZQ8VTphT/ym2nQ
 7TgQ26j0p0yGUd3xScv1VKX3dcoz00RkkGLUeGqCfaxg11tn2Gu0pC4mTYsjTpypyqhx
 tJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877291; x=1705482091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ikOT+QqWMH+ik9Ol/QXFf7Pbp082xw1hX5CbWL8PK2o=;
 b=cbt+QOsBIKJn4pdt3O0++UjOwyB5ZyVi80EWMfrTClkpFaGkSk4rEqaxpfGLLHhRid
 8IhN9CTyVqiQveacYj0GaeTO1uEFYFA8koBmUP4ahbWuL5vuPq5/kcv98JsXRQb2K2F8
 MM09OaeiGlprQB3uZMU7/7WDr8SnyLuw1brTXU291dB4Hy3uO7IlWWtQ/IdscryU6DV1
 md5/5lUU2KVPXhy93JbezesFNvOR9rUgM/vGvG5i8KutD6QnMVxhladczT1bLb7i5cMU
 KPrAhA6HX20HlOR8UzipVDH8ggB+G/Wyf/oK853/0QfDBHi9l5bOfCVc4VAYw1RArBMa
 Szgg==
X-Gm-Message-State: AOJu0YziLMgO2IRYKPBH9DltKCrCIZLRUOfLXGCmi9XjXbYQLOaEN+42
 azhjr5L09imSSBm/iXAhf+lBmiaIyEecKqe/
X-Google-Smtp-Source: AGHT+IG14dooQm6ixy6vbRMuNt6YHUxBGG0p+cNo2X6t31CXtjNDcw42xNMcZl/OoGeXc/u3gvjY4w==
X-Received: by 2002:a05:6a20:a110:b0:19a:26c0:cfec with SMTP id
 q16-20020a056a20a11000b0019a26c0cfecmr460579pzk.28.1704877291595; 
 Wed, 10 Jan 2024 01:01:31 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.01.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 01:01:31 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Bin Meng <bmeng@tinylab.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 60/65] docs/system/riscv: sifive_u: Update S-mode U-Boot image
 build instructions
Date: Wed, 10 Jan 2024 18:57:28 +1000
Message-ID: <20240110085733.1607526-61-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bin Meng <bmeng@tinylab.org>

Currently, the documentation outlines the process for building the
S-mode U-Boot image using `make menuconfig` and manual actions within
the menuconfig UI. However, this approach is fragile due to Kconfig
options potentially changing across different releases. For example,
CONFIG_OF_PRIOR_STAGE has been replaced by CONFIG_BOARD since v2022.01
release, and CONFIG_TEXT_BASE has been moved to the 'General setup'
menu from the 'Boot options' menu in v2024.01 release.

This update aims to make the S-mode U-Boot image build instructions
future-proof. It leverages the 'config' script provided in the U-Boot
source tree to edit the .config file, followed by a `make olddefconfig`.

Validated with U-Boot v2024.01 release.

Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240104071523.273702-1-bmeng@tinylab.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 docs/system/riscv/sifive_u.rst | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/docs/system/riscv/sifive_u.rst b/docs/system/riscv/sifive_u.rst
index 7b166567f9..8f55ae8e31 100644
--- a/docs/system/riscv/sifive_u.rst
+++ b/docs/system/riscv/sifive_u.rst
@@ -210,7 +210,7 @@ command line options with ``qemu-system-riscv32``.
 Running U-Boot
 --------------
 
-U-Boot mainline v2021.07 release is tested at the time of writing. To build a
+U-Boot mainline v2024.01 release is tested at the time of writing. To build a
 U-Boot mainline bootloader that can be booted by the ``sifive_u`` machine, use
 the sifive_unleashed_defconfig with similar commands as described above for
 Linux:
@@ -325,15 +325,10 @@ configuration of U-Boot:
 
   $ export CROSS_COMPILE=riscv64-linux-
   $ make sifive_unleashed_defconfig
-  $ make menuconfig
-
-then manually select the following configuration:
-
-  * Device Tree Control ---> Provider of DTB for DT Control ---> Prior Stage bootloader DTB
-
-and unselect the following configuration:
-
-  * Library routines ---> Allow access to binman information in the device tree
+  $ ./scripts/config --enable OF_BOARD
+  $ ./scripts/config --disable BINMAN_FDT
+  $ ./scripts/config --disable SPL
+  $ make olddefconfig
 
 This changes U-Boot to use the QEMU generated device tree blob, and bypass
 running the U-Boot SPL stage.
@@ -352,17 +347,13 @@ It's possible to create a 32-bit U-Boot S-mode image as well.
 
   $ export CROSS_COMPILE=riscv64-linux-
   $ make sifive_unleashed_defconfig
-  $ make menuconfig
-
-then manually update the following configuration in U-Boot:
-
-  * Device Tree Control ---> Provider of DTB for DT Control ---> Prior Stage bootloader DTB
-  * RISC-V architecture ---> Base ISA ---> RV32I
-  * Boot options ---> Boot images ---> Text Base ---> 0x80400000
-
-and unselect the following configuration:
-
-  * Library routines ---> Allow access to binman information in the device tree
+  $ ./scripts/config --disable ARCH_RV64I
+  $ ./scripts/config --enable ARCH_RV32I
+  $ ./scripts/config --set-val TEXT_BASE 0x80400000
+  $ ./scripts/config --enable OF_BOARD
+  $ ./scripts/config --disable BINMAN_FDT
+  $ ./scripts/config --disable SPL
+  $ make olddefconfig
 
 Use the same command line options to boot the 32-bit U-Boot S-mode image:
 
-- 
2.43.0


