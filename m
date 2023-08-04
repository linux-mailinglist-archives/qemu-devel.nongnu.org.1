Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF2770BBC
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rO-00053s-66; Fri, 04 Aug 2023 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qs-0004lP-05
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:54 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qq-0001vR-DF
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bbd2761f1bso22050105ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186451; x=1691791251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VLnmjiDjAi6Gl+LJx+pmU5KrGv5xMTSD4fN49XrjM0=;
 b=iM8rStISP/kbHq5bgwFjLPgHYhwXqvoj/tKh+lukRLdQVI4NobFYK1dooL1XW8H2GH
 F8IQ/cI9cxS256vFZcEvOPnSjol36O7pcvTrUUwyozUHzcusLaTjTipXNIBPzN6w71xz
 yNE+TRyHHkk5Xh95pJ+vezSGxlME/JiiopdZruJLxDIq3jzUo0tQlsjWzs3XcvLXe8wM
 u0rayxXCCZBiIQDKpjTsbaqHkf1Z8BPtVqbDqmbLRFEI8ZqNv0ypAdEr3xmh+fFHh6cU
 G7zRn2l6HRy8bS4QDGVPjyt8qIK6aZhwmN5X8+taQ+4a80yVQJbxyiAoXaySbjI/Shpg
 DmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186451; x=1691791251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VLnmjiDjAi6Gl+LJx+pmU5KrGv5xMTSD4fN49XrjM0=;
 b=iEX3R1zl+K0IvNnjQj/b9uhBEY2dIlBrPK3aaRYI2ofP3Gc+W93Z5VuDgyDuU95+Ul
 ZnwodqHgon8QT4XijBw4SyxrBoui6PiPQc0U2CeVcD4/H3m4Ni3/7xIPVSdHH0CrCd3m
 nby07O41jlIyJDuc91/weO+b2h8rpyBBbv+2TwhP0sWdUNtdFj/26IghatJvDPdpTfK2
 3u6H+TDPXBcUmYm6+nJStEODQ4Cnxmabt2DohbNWFQQKAMtE1RSkobfgbROOjjNOhAH3
 MerfG0oVp4Fz8Tk6cpdrdvQJqi8XqSw+gYGis4pnLwh0HDKeptki5EAQcRthz7a+ngJy
 Z0Qg==
X-Gm-Message-State: AOJu0Yzs4GLuLSL40VYHX9a0Kv3jT7nO29o8bWiC9+AgCW99r/NtcUiv
 qqAZOLlfL6ynLsDnsNFygZ7mCzIxGwWrOgW3oXM=
X-Google-Smtp-Source: AGHT+IEdKeW9CxGO6oXuvsVm4vXphXd05qaAt+vnDgNcw6eUdOkaGKxKGXxzBRcRvrfZOCexu7IChA==
X-Received: by 2002:a17:902:ec8c:b0:1bb:edd5:4644 with SMTP id
 x12-20020a170902ec8c00b001bbedd54644mr3450857plg.68.1691186450989; 
 Fri, 04 Aug 2023 15:00:50 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 20/24] linux-user: Do not adjust image mapping for host
 page size
Date: Fri,  4 Aug 2023 15:00:28 -0700
Message-Id: <20230804220032.295411-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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


