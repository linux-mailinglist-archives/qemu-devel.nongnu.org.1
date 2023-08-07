Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CC772B33
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EY-0007QH-LM; Mon, 07 Aug 2023 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EK-00074K-CN
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:18 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EI-0002hG-D1
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b8b4748fe4so30496535ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426233; x=1692031033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TbCJ8DmT72t6xcy/KS1lARRJzdw3e4AQqay5Lza2sjc=;
 b=tca7KPmtrOwNCoWQHPjzXFDIPcIDJNknAvtwAU2lIB3GfE1NbcvJsoSh3xriaKk/bq
 WkOPfaj+Btt6yVRQySwCYdFTpFNPnwqyXuHjJEgyja9Lh6ZrNZ8PUutHUojn/FS+1ua8
 2JJbjHkvCmDeaWSIFNgUaOejCeI+VXCLuKQTfU+zyWtzKGaigXQWLLsh5OH7iGhXnlJX
 oH3erq0OvGlRiQYwJg6n/52Dc6j3p4eWR2G37YHIr20x3hmMo+RFc6M/cw8JzKEmipFF
 lZnG3TTm41NGPi3rJKU+gIPk2euHmooBl6FH/1q5fC89CSN4b/wsBiL1k8t7N1lEY9cM
 hyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426233; x=1692031033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TbCJ8DmT72t6xcy/KS1lARRJzdw3e4AQqay5Lza2sjc=;
 b=Aea611AQz03DzcRTYx+YNCQj7MSd9/myquuUGAkOMZgXEREaasZq1AODfUoF4xFndd
 VOSoKMDwqzBjbAXZ0jZoYJhLP+4Z27A2ORpF3htmvpoqwaeWYFTdP5Z2zreiyuus6V9K
 3OU7J0HFoXhQoT33Va+koKTB2XCrhjEapfGe8M3znfy/KWODTcbqxfYOTE7YPE7D06tU
 KPoC5ZZYNPMMLQxxAC56AUSZ8QOpL+Ifbe09SiKlY4TA6g+bfJKOkkOf13JmQ7KPI7IE
 +dZb9G76A6OA7jRuloZ0qp5/ZoGkXvqjwv5+MFYM8eHV+ORPOfd/zWCw/lgFnSDwNpoE
 knHA==
X-Gm-Message-State: AOJu0YwoQIkSjuRk7mhyHgP3xB96TgnMNI4dD59eoI49ZcZu+QTFz6Qk
 qcMU3YBh4nmGCUAjZiK+E5Z6bDRYlUXOrmWfQWs=
X-Google-Smtp-Source: AGHT+IFCgUqqKVKf1XohZvJW97eBv/a3DX22HfGcZx4r8zwPquGntRW9ZQcjqxr1T5HWSrmJOOK07g==
X-Received: by 2002:a17:902:cec1:b0:1bc:6a89:86ba with SMTP id
 d1-20020a170902cec100b001bc6a8986bamr4338259plg.16.1691426233129; 
 Mon, 07 Aug 2023 09:37:13 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 07/14] linux-user: Do not adjust image mapping for
 host page size
Date: Mon,  7 Aug 2023 09:36:58 -0700
Message-Id: <20230807163705.9848-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Remove TARGET_ELF_EXEC_PAGESIZE, and 3 other TARGET_ELF_PAGE* macros
based off of that.  Rely on target_mmap to handle guest vs host page
size mismatch.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3553a3eaef..964b21f997 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1960,15 +1960,6 @@ struct exec
 #define ZMAGIC 0413
 #define QMAGIC 0314
 
-/* Necessary parameters */
-#define TARGET_ELF_EXEC_PAGESIZE \
-        (((eppnt->p_align & ~qemu_host_page_mask) != 0) ? \
-         TARGET_PAGE_SIZE : MAX(qemu_host_page_size, TARGET_PAGE_SIZE))
-#define TARGET_ELF_PAGELENGTH(_v) ROUND_UP((_v), TARGET_ELF_EXEC_PAGESIZE)
-#define TARGET_ELF_PAGESTART(_v) ((_v) & \
-                                 ~(abi_ulong)(TARGET_ELF_EXEC_PAGESIZE-1))
-#define TARGET_ELF_PAGEOFFSET(_v) ((_v) & (TARGET_ELF_EXEC_PAGESIZE-1))
-
 #define DLINFO_ITEMS 16
 
 static inline void memcpy_fromfs(void * to, const void * from, unsigned long n)
@@ -3241,8 +3232,8 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
 
             vaddr = load_bias + eppnt->p_vaddr;
-            vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-            vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
+            vaddr_po = vaddr & ~TARGET_PAGE_MASK;
+            vaddr_ps = vaddr & TARGET_PAGE_MASK;
 
             vaddr_ef = vaddr + eppnt->p_filesz;
             vaddr_em = vaddr + eppnt->p_memsz;
@@ -3252,7 +3243,7 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
+                vaddr_len = eppnt->p_filesz + vaddr_po;
                 error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                     MAP_PRIVATE | MAP_FIXED,
                                     image_fd, eppnt->p_offset - vaddr_po);
@@ -3268,7 +3259,7 @@ static void load_elf_image(const char *image_name, int image_fd,
                     zero_bss(vaddr_ef, vaddr_em, elf_prot);
                 }
             } else if (eppnt->p_memsz != 0) {
-                vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_memsz + vaddr_po);
+                vaddr_len = eppnt->p_memsz + vaddr_po;
                 error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                     MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS,
                                     -1, 0);
-- 
2.34.1


