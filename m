Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E229F82BA5A
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 05:23:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rO93V-0006HL-O0; Thu, 11 Jan 2024 23:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93T-0006H3-Jp
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:22:03 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rO93R-0004o6-Uv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 23:22:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso42949505ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705033320; x=1705638120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoTLe2H0TJ7NQ0hAQEOvPsrHTLmDaY+CU6GGnYfjphc=;
 b=m0Q/AA+8xcNv16wEdplP5PEpfIujUXzcTZh2nJpIq8Kj6BeXaKkUVErAmi+zadTE/8
 4Bdb0BwJ1kpPbdhYE69xQ1lsM9nIaAZF3C92z4lDn1jWWcFaN6n+/1ew/0SHZ4RjGK9J
 VCn9vMCDthBCsspS6PXk7GQyFfWHRYMvkbiBZq+Ug0CqfKjvb3qPM9ZrRw3bM7qCaqFa
 htM6bDCZrS6KZNwxH/t32MVwiUS6frG7otlu5TMP/kYtFFXnkyitQZd0c1VEaX9Smk7Q
 HFUiLmt0fn3gR8TmXKCPCzvlyjQM8qXUNR3kxphMfES+k6hZ0PkiZZe3XBJV4kk2bWv9
 Ha8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705033320; x=1705638120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoTLe2H0TJ7NQ0hAQEOvPsrHTLmDaY+CU6GGnYfjphc=;
 b=A5qRe1rqXjLLLLGQ7gkKi5SM5AL3THzyz96uhWZECl3aQgULNKf5jTYfpwcgNNtuup
 fUVOa823m4Cw9yNVVQgtEIUfQlONTkNsmZp9G3UclWODoBuDmuPq73ejDDMWrQ1ZL9Fx
 E2colTlgr4+ts+shP7HPmGfwdnzEKkfhhmJL+qcEGZsvX6A/FMtBEzqA33YaLPMYmhPc
 9tF2pUqjOuXz94NKfppMUNkkmK/MyE0RQ4nOWdEl3G4XdIVRMIEmh86erJ42wfgOYvKE
 90mMKutUX19G6K2vTrhrMcQHUzjcGtIEuKNmveX9LO9Ow5ofKpoC3CKclcI5jtccEqwH
 7YZw==
X-Gm-Message-State: AOJu0YzE1VK4iFh7sT+ZBgFo+21FsrL/kfiRPfbhW9ddb59T8o9nIi+Z
 BP0dT9nq68dwE73a72yQiGTeKKjBKBU=
X-Google-Smtp-Source: AGHT+IF+sb9s7GmUc9uKOpjVVx2o6ONI1ytlSqtdY2xu/T88g4bYGqq/H/HLc34S+W4HFZIZp/Xobg==
X-Received: by 2002:a17:902:ecc8:b0:1d5:2ce:d819 with SMTP id
 a8-20020a170902ecc800b001d502ced819mr691786plh.61.1705033320137; 
 Thu, 11 Jan 2024 20:22:00 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net
 (c-73-63-239-93.hsd1.ca.comcast.net. [73.63.239.93])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a170902d4d100b001d4c98c7439sm2018576plg.276.2024.01.11.20.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 20:21:59 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/4] tests/tcg/xtensa: tidy test linker script
Date: Thu, 11 Jan 2024 20:21:27 -0800
Message-Id: <20240112042128.3569220-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
References: <20240112042128.3569220-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Drop MEMORY clause and related size definitions and output section
region specifications. Drop .rodata output section as the tests don't
use it. Add DATA_SEGMENT_ALIGN/DATA_SEGMENT_END around .data and .bss to
let the linker make an RW segment for data. Reserve 1M for stack instead
of almost 128M.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/linker.ld.S | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/tests/tcg/xtensa/linker.ld.S b/tests/tcg/xtensa/linker.ld.S
index ac89b0054ee4..0e21eee31ccc 100644
--- a/tests/tcg/xtensa/linker.ld.S
+++ b/tests/tcg/xtensa/linker.ld.S
@@ -10,9 +10,8 @@
 #define XCHAL_WINDOW_UF12_VECOFS  0x00000140
 #endif
 
-#define RAM_SIZE 0x08000000  /* 128M */
-#define ROM_SIZE 0x00001000  /* 4k */
 #define VECTORS_RESERVED_SIZE 0x1000
+#define STACK_SIZE 0x00100000
 
 #if XCHAL_HAVE_BE
 OUTPUT_FORMAT("elf32-xtensa-be")
@@ -21,18 +20,13 @@ OUTPUT_FORMAT("elf32-xtensa-le")
 #endif
 ENTRY(_start)
 
-MEMORY {
-    ram : ORIGIN = XCHAL_VECBASE_RESET_VADDR, LENGTH = RAM_SIZE
-    rom : ORIGIN = XCHAL_RESET_VECTOR_VADDR, LENGTH = ROM_SIZE
-}
-
 SECTIONS
 {
-    .init :
+    .init XCHAL_RESET_VECTOR_VADDR :
     {
         *(.init)
         *(.init.*)
-    } > rom
+    }
 
 #if XCHAL_HAVE_WINDOWED
     .vector.window XCHAL_WINDOW_VECTORS_VADDR :
@@ -119,23 +113,16 @@ SECTIONS
         *(.vector.kernel.*)
         *(.vector.user.*)
         *(.vector.double.*)
-    } > ram
+    }
 
     .text :
     {
         _ftext = .;
         *(.text .stub .text.* .gnu.linkonce.t.* .literal .literal.*)
         _etext = .;
-    } > ram
+    }
 
-    .rodata :
-    {
-        . = ALIGN(4);
-        _frodata = .;
-        *(.rodata .rodata.* .gnu.linkonce.r.*)
-        *(.rodata1)
-        _erodata = .;
-    } > ram
+    . = DATA_SEGMENT_ALIGN(0x1000, 0x1000);
 
     .data :
     {
@@ -146,7 +133,7 @@ SECTIONS
         _gp = ALIGN(16);
         *(.sdata .sdata.* .gnu.linkonce.s.*)
         _edata = .;
-    } > ram
+    }
 
     .bss :
     {
@@ -160,7 +147,8 @@ SECTIONS
         *(COMMON)
         _ebss = .;
         _end = .;
-    } > ram
-}
+    }
 
-PROVIDE(_fstack = (ORIGIN(ram) & 0xf0000000) + LENGTH(ram) - 16);
+    . = DATA_SEGMENT_END(.);
+    _fstack = ALIGN(. + STACK_SIZE, 16);
+}
-- 
2.39.2


