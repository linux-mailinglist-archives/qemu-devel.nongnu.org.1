Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6929F774C74
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTwz-0007hX-Hn; Tue, 08 Aug 2023 17:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwx-0007gh-DY
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:07 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwv-0005wV-P5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:07 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-56cb1e602e7so3906175eaf.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528944; x=1692133744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wka4C0I9AHmla/9hz2xv6tr7JssuiUOCCkjNKLiy/aQ=;
 b=UWCJnMRV0G1bfnfg6KblGOImkm5brVsttuwhIiv+Zu4lUj1sOsucJL7ijO0ll53edg
 uOHb7E1D11cCKvlLy6M1DaHMg+sCE/6Z7u/SJHixxYKsyBRvIsSrQWF37YlfuFYbgm0A
 osrow6ctzBf5F1LeczUIjtPAbyfhSvaLQeAQdK1y4fVn7Ylg2yN3ia0SU0WpgWITYI24
 vjQGAOkL00c+jxghHA1OykNNFKuAH0blSrZer3iMENUI+ENekTTIbrzNlefUER4s8vjl
 /u4iTMZwkTYe+gCjsCyjWWGHPMaPM5AQH3GinWebkK5l9dT5Dm8fLDwBVwVEIGJoTb55
 A/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528944; x=1692133744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wka4C0I9AHmla/9hz2xv6tr7JssuiUOCCkjNKLiy/aQ=;
 b=j0yuZAJvWPwlPYP2vaKqHjOSaR3ZErZBq80X2mHXN1v9/0I0WHJTlprf1lGZUcoaiG
 3yyuRihFn8M84qcrzGQIhoxeRAv9uqIgTyf99ZeA0FffV9pd2nNCHGCN502MRfOHewWj
 PX6ttj0Ir8DdVhX65TpY4SPT/Nta+ue5lRatX5o5wty6TFpJO54qKnnsLcTzUlBrU0Lz
 TuAQk72q3WBufauuJtYX5VEPKKBms+ERokmYI3Aa8595tZOM8IxwgX7xSafVP6AYQa+0
 SrNFFTz0lnw+732eaq438qJVbHxoscqrUOIJBJHiya/pUZLfIQGE9R7owX543LT3tXSf
 2p9Q==
X-Gm-Message-State: AOJu0YzrpbmmfTs7Z7EP5rOPnsVHyxaS1Sh/9sQgT5XH/mMcwt15pkSo
 704DB/MU7pBE8l24wkfWOUHgAk6b52XYG54iZSw=
X-Google-Smtp-Source: AGHT+IFlauJDM5aW3WdIWZe2PcvD7fr4DHxV0/TzuwM5bWn42VmM8J7z/CQVIb91k2NK/bBhkrR0vA==
X-Received: by 2002:a05:6808:aab:b0:3a4:ccf:6a63 with SMTP id
 r11-20020a0568080aab00b003a40ccf6a63mr851274oij.55.1691528944376; 
 Tue, 08 Aug 2023 14:09:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/14] linux-user: Do not adjust image mapping for host page
 size
Date: Tue,  8 Aug 2023 14:08:49 -0700
Message-Id: <20230808210856.95568-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
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


