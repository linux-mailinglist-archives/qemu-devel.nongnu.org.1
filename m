Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5D778BB9F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalri-0003fF-Si; Mon, 28 Aug 2023 19:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrd-0003ej-5Q
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:45 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalra-0006fy-9C
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:44 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34ca22e3b3dso13246045ab.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266100; x=1693870900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L31NhYGodpWvvaDs32s2seCPLO3ZQUAuBDXt6+3D/x4=;
 b=XLpK0xRYh5zayN88esiPy8ZhM3a0dNpYfSYEm4CQ3T3cS2xE+QW1XMw0Ooefh7ZWbP
 FjGblko855yig1U6I/xBFdwTu5O7uYhV1sROFdK0HS0YvSnAFr/OC6P6s5V1xL12+HlX
 EOrDnqkstOraYWz2Xjw6ACKmZXT3oS72cQc4lMT3T36v8RF9k173HSohcLnDF/NtZwcO
 TgxOgcaSLSuyDKHc3IWLPntmB46Bi4c/Wzp4qbMmvtvLWhaHDYzAxCuQ5U8rtMfrUISA
 r+9oYyJpnOdJE4MlGgdgOW25RcLbF0NI6eAE0UvPAXxX3nUPd8IZO7voGQPb+LTnhfuG
 vp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266100; x=1693870900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L31NhYGodpWvvaDs32s2seCPLO3ZQUAuBDXt6+3D/x4=;
 b=f4i2KyteYOKpYtxKkzMURaIXDrv311XNta0P+JxYD1JorYlQjssBU3S/6oX03wjF8l
 M6lU/y8BqxAhLdnOdvcSyPjQPQh73LTGCVAK4z/MHKb30dea6Upg4QMNPTjbr8JDO7c+
 qEy+i/ynwmpwD0eZmCbsk7pAUm0hGtcVA+ei5pTxUGwWIPyD7TJJGUHemIAFi/VBr4Jg
 RNkQi2Y4EQrj3hlSF83tgrx0qHfNIazoOOSuDhul1gINQBoE3bc3FSP/+eeW4XINhTWN
 W2NfCr0XQGlsmTmbnxOVIT+zrCfrRSMuXjRoRkitCHwcOAWi2n4StVQIapSWdIZCyzBb
 REJg==
X-Gm-Message-State: AOJu0YwNqqk5AJ7nTwinZRTfmCLwKcz8gWf5qxDhIFJgOc8DoV3nWLf/
 rRwD8Pa6J4cq5tXGdhbUtgD3OBIofIFVmtva+/Y=
X-Google-Smtp-Source: AGHT+IEKxxDmX5QscihMYZcQvgwwuw8ZgoVylbolAk9jZJ8cua56WKQhlZ/4mYI9LJSLGksTMVgVmw==
X-Received: by 2002:a05:6e02:1084:b0:345:6ce1:d259 with SMTP id
 r4-20020a056e02108400b003456ce1d259mr16261620ilj.28.1693266099953; 
 Mon, 28 Aug 2023 16:41:39 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:39 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/36] bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
Date: Mon, 28 Aug 2023 17:37:46 -0600
Message-ID: <20230828233821.43074-2-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::136;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x136.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

The start_mmap value is write-only.
Remove the field and the defines that populated it.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230818175736.144194-2-richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/arm/target_arch_elf.h    | 1 -
 bsd-user/elfload.c                | 1 -
 bsd-user/i386/target_arch_elf.h   | 1 -
 bsd-user/qemu.h                   | 1 -
 bsd-user/x86_64/target_arch_elf.h | 1 -
 5 files changed, 5 deletions(-)

diff --git a/bsd-user/arm/target_arch_elf.h b/bsd-user/arm/target_arch_elf.h
index 935bce347fc..b1c0fd2b320 100644
--- a/bsd-user/arm/target_arch_elf.h
+++ b/bsd-user/arm/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ET_DYN_LOAD_ADDR    0x500000
 
 #define elf_check_arch(x) ((x) == EM_ARM)
diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
index 1f650bdde85..38a3439d2cd 100644
--- a/bsd-user/elfload.c
+++ b/bsd-user/elfload.c
@@ -738,7 +738,6 @@ int load_elf_binary(struct bsd_binprm *bprm, struct target_pt_regs *regs,
     /* OK, This is the point of no return */
     info->end_data = 0;
     info->end_code = 0;
-    info->start_mmap = (abi_ulong)ELF_START_MMAP;
     info->mmap = 0;
     elf_entry = (abi_ulong) elf_ex.e_entry;
 
diff --git a/bsd-user/i386/target_arch_elf.h b/bsd-user/i386/target_arch_elf.h
index cbcd1f08e2f..4ac27b02e72 100644
--- a/bsd-user/i386/target_arch_elf.h
+++ b/bsd-user/i386/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x80000000
 #define ELF_ET_DYN_LOAD_ADDR    0x01001000
 #define elf_check_arch(x) (((x) == EM_386) || ((x) == EM_486))
 
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 8f2d6a3c78b..178114b4234 100644
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
index b2447118883..e51c2faf084 100644
--- a/bsd-user/x86_64/target_arch_elf.h
+++ b/bsd-user/x86_64/target_arch_elf.h
@@ -20,7 +20,6 @@
 #ifndef TARGET_ARCH_ELF_H
 #define TARGET_ARCH_ELF_H
 
-#define ELF_START_MMAP 0x2aaaaab000ULL
 #define ELF_ET_DYN_LOAD_ADDR    0x01021000
 #define elf_check_arch(x) (((x) == ELF_ARCH))
 
-- 
2.41.0


