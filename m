Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06985771374
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaH-0003jU-GW; Sat, 05 Aug 2023 23:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaF-0003ih-OY
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:35 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaE-0007af-5t
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:35 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-564af1b3a9fso1651820a12.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293053; x=1691897853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VLnmjiDjAi6Gl+LJx+pmU5KrGv5xMTSD4fN49XrjM0=;
 b=k86kupewmSW1Nd86OOjC3/oRzVdxXYuhjhYYhIkfjZdxm2OK0pIciX5x/6LFy5F/Cx
 eBzoQpzclceV7WYJjWje3diFdSqc7ZXxcAUrBR+gf78QqXJl5JxdDju+FjcwywVLqnER
 FPlU3KsZElM/WFzMX5rutTI35K3oJFrYo7MnLrOpGOgqJ00mCoto8MRqcFnhhGX1431X
 Amv0lxJ4+3oaBkzvXqwbCWby2fUNkLTUp2HW1KLdL2ORpdVTMqCTKBsMDz4x0g2gptT2
 zGPmCRrH+RdgpJlfCI5rtjDo2lhWzDyN1m/MvyM8Q2ogeXY/hVHazrzmM9ZpW7CAWQ6G
 y2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293053; x=1691897853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VLnmjiDjAi6Gl+LJx+pmU5KrGv5xMTSD4fN49XrjM0=;
 b=Oq1CGL3NtTUtmuqj09mtacG+WZH4Gf2gavSeoQgPa/vk99IsfW+6MUAe49ckGWx5tk
 vZ4/kNd0esBe3A1MrlaCBn72hf2YrqCUwx1I2RSDnTFtNZeNOvdiPtv9zuDD5/J7WkeB
 MakNGCxmenHfxMI/drrKakHv7lSwt88tr/xYeeC4jclc7wQvRtEzXGF8pVhOGmYQv3xi
 XjalJf1Q276UqFw7OJLR2BdaQELjDNnO9QR91jCBXaMxBXacsJn8z930UlBvyZsikXaR
 jUYC6AEkx4Q6aAqaaZwxCV9R0WYb5QW9cuRtVVyya8nNUKEkgNfSJJEhmfxgrIl5n5s3
 PgJA==
X-Gm-Message-State: AOJu0Yw4Bc1XEcBY50d51rHe5FMaYktqGOHgi/if7mmzvuN+qYnKSuLr
 fZVZZsDG9E7MgSeIGSYqDS8BeoMUfrlPyuN2wYw=
X-Google-Smtp-Source: AGHT+IGFTSDjSaDLm14v3AZ6e9UqP06M++PP4qENV3E6FEIQ1KEduobOtmSTjZniaqppzpZE4gQHfQ==
X-Received: by 2002:a17:90a:fad:b0:263:161c:9e9c with SMTP id
 42-20020a17090a0fad00b00263161c9e9cmr4614220pjz.12.1691293052938; 
 Sat, 05 Aug 2023 20:37:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 20/24] linux-user: Do not adjust image mapping for host page
 size
Date: Sat,  5 Aug 2023 20:37:11 -0700
Message-Id: <20230806033715.244648-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
index fa0c9ace8e..e853a4ab33 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1959,15 +1959,6 @@ struct exec
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
@@ -3240,8 +3231,8 @@ static void load_elf_image(const char *image_name, int image_fd,
             }
 
             vaddr = load_bias + eppnt->p_vaddr;
-            vaddr_po = TARGET_ELF_PAGEOFFSET(vaddr);
-            vaddr_ps = TARGET_ELF_PAGESTART(vaddr);
+            vaddr_po = vaddr & ~TARGET_PAGE_MASK;
+            vaddr_ps = vaddr & TARGET_PAGE_MASK;
 
             vaddr_ef = vaddr + eppnt->p_filesz;
             vaddr_em = vaddr + eppnt->p_memsz;
@@ -3251,7 +3242,7 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                vaddr_len = TARGET_ELF_PAGELENGTH(eppnt->p_filesz + vaddr_po);
+                vaddr_len = eppnt->p_filesz + vaddr_po;
                 error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
                                     MAP_PRIVATE | MAP_FIXED,
                                     image_fd, eppnt->p_offset - vaddr_po);
@@ -3267,7 +3258,7 @@ static void load_elf_image(const char *image_name, int image_fd,
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


