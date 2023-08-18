Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A727F781278
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3jE-00010Y-Be; Fri, 18 Aug 2023 13:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jC-0000zM-9o
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:42 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3jA-00049Z-3W
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:57:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68872ca740bso988398b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692381458; x=1692986258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=249sRNpBkee3vxDmEKQSDMH45KuQ5/RjIJ294wQlUMs=;
 b=HqLOi77xM81ARqzXiwXGuWtrQx2tnaNbti6NKcZfOWbdS4txF9jEveQt7txGl2VX/q
 +aCNs+crFfjySHSmIEGbxkqRcQGaTivb6e7uPU9AqIdePiKqzoQcuqMI5G73UdiQ+3mF
 UtM1DacsrPo5U+pxY1xcQykHMVSxoIjdTibTjPvyh0oh/pMkUYLdcGwDAqoutITBBkQR
 jsoAS+Ct2PXPnV3Ziqyi1/lyNPVQJBgsw7JcEHS4mtcv9FHerzshRNxY+w2OUiqilITd
 sCt15/E518iDcD4gWG+9oLaqTaTS/W0WJT1ZSQH9vF0YFBvi0Ie9pKgts+rPeGzZtCAy
 Y/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692381458; x=1692986258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=249sRNpBkee3vxDmEKQSDMH45KuQ5/RjIJ294wQlUMs=;
 b=CbYPV814UgYWb+B8joJmdE1zgj2OzVCsVIZbs5ttGWhccOoXR7VMPswgBjwQ32T7bF
 CSq+E6v2yIlzcz6FZuDVrSnw0GU25ullwlYaWBlhLaBt7fOyDav3mE44vJSV6ql7wsJ0
 Wb+Iar2cyndBDCakVmaunx3IqwnpV2vccXYuRUo11YvYFu4gNyoBghNGFJ5JNQEdxKkx
 Ji2Pukuix5q0Uk4Hd82bp31juOGbDXXbpBGAYFUfDb9wdPJnFKbyWU8sn1n64FDbderg
 OCOsyZhPyGafuzFidg1ntdrCbbrIefX+g68lps4QnWn4j1bwINmvOpsHBefxghYMqC5N
 H5tw==
X-Gm-Message-State: AOJu0YzlzDldodzS+v7xoFKkAXME7GsHa/P4aF+0dlqwknP04Ka8QUW1
 jGPksFS+d24guMJ3J1VcWOXta2btw3mT3+oslEs=
X-Google-Smtp-Source: AGHT+IFdYwBP8oamQXEFdqX7XXabjsTR10RqTvmf/p4TZEIfzRRpNuyrGHDWwpDcZR1xKS0sMGMHbg==
X-Received: by 2002:a05:6a20:12ca:b0:140:6d68:ce07 with SMTP id
 v10-20020a056a2012ca00b001406d68ce07mr4784928pzg.52.1692381458589; 
 Fri, 18 Aug 2023 10:57:38 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a638c4b000000b005637030d00csm1838212pgn.30.2023.08.18.10.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:57:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: [PATCH 1/3] bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
Date: Fri, 18 Aug 2023 10:57:34 -0700
Message-Id: <20230818175736.144194-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818175736.144194-1-richard.henderson@linaro.org>
References: <20230818175736.144194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The start_mmap value is write-only.
Remove the field and the defines that populated it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/arm/target_arch_elf.h    | 1 -
 bsd-user/i386/target_arch_elf.h   | 1 -
 bsd-user/qemu.h                   | 1 -
 bsd-user/x86_64/target_arch_elf.h | 1 -
 bsd-user/elfload.c                | 1 -
 5 files changed, 5 deletions(-)

diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.h
index 935bce347f..b1c0fd2b32 100644
--- a/bsd-user/arm/target_arch_elf.h
+++ b/bsd-user/arm/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ET_DYN_LOAD_ADDR    0x500000
 
 #define elf_check_arch(x) ((x) == EM_ARM)
diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_arch_elf.h
index cbcd1f08e2..4ac27b02e7 100644
--- a/bsd-user/i386/target_arch_elf.h
+++ b/bsd-user/i386/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ET_DYN_LOAD_ADDR    0x01001000
 #define elf_check_arch(x) (((x) == EM_386) || ((x) == EM_486))
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 8f2d6a3c78..178114b423 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -52,7 +52,6 @@ struct image_info {
     abi_ulong end_data;
     abi_ulong start_brk;
     abi_ulong brk;
-    abi_ulong start_mmap;
     abi_ulong mmap;
     abi_ulong rss;
     abi_ulong start_stack;
diff --git a/bsd-user/x86_64/target_arch_elf.h b/bsd-user/x86_64/target_arch_elf.h
index b244711888..e51c2faf08 100644
--- a/bsd-user/x86_64/target_arch_elf.h
+++ b/bsd-user/x86_64/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x2aaaaab000ULL
 #define ELF_ET_DYN_LOAD_ADDR    0x01021000
 #define elf_check_arch(x) (((x) == ELF_ARCH))
 
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 1f650bdde8..38a3439d2c 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     /* OK, This is the point of no return */
     info->end_data = 0;
     info->end_code = 0;
-    info->start_mmap = (abi_ulong)ELF_START_MMAP;
     info->mmap = 0;
     elf_entry = (abi_ulong) elf_ex.e_entry;
 
-- 
2.34.1


