Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4A8771365
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:38:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaJ-0003kX-Kr; Sat, 05 Aug 2023 23:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaH-0003jV-Bq
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:37 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaF-0007bH-QC
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:37 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26929bf95b6so889962a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293054; x=1691897854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwFHtt7Rthrgzaq+94z3/B+V/hUuIkoTCUpTmlGBJ3w=;
 b=b+Oj/fWOmU6XclRjmkD9QCPkfx6YoxidC4pen8HXCKgUDA3wBm7jGrl/l3PEmTHOxR
 VPm6stK1NMkT90cjPSzrR4CaxTHQYT6CCgYImtjDoLTdCQ+W0YcOFysVOXwZRP4ajrOt
 qNDvIYSLchcHOfxJ7BD7LOxAD8XzuzJuVjKH+dYUXFoZMI7k4Rh3GQJo6mdCZMXuFowF
 7eXoike4cHo9rL2mRqCaSyb6SNgJPuxq2XC44VvDPvit+2THJK4rwUhiq+NaPVjmmJ2D
 lRekUIlJgujn3fQsNJ8aaMWzbxN6SbDtQEe15ZuCKc+4UA5usnIoFmy3ftrLrFl7HBMX
 hEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293054; x=1691897854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwFHtt7Rthrgzaq+94z3/B+V/hUuIkoTCUpTmlGBJ3w=;
 b=LVyK4s04gTPa95via1Uzql+Ivj81ai3OTVeMYk407yTci9N6fIQoDsYI+JjTRnzw0E
 SKsFkyCnjAAZ13wkN+o3BMgcooD+NFt+Iv0vriCjrhYNkjIDM81DGb5sHfuHFKhSMxJT
 FBqY2saThnU4RSwDGkvp/AoCVFTc5UMQikdUAnz5iP1CBdYcQdbEjDpo6zi9pHTDJfhd
 lmhOzt40uEcaVK7eCNbrAcTFsCTEy0OuZjqRcfT4fDoQRAZCk+4Mp3P9GyftUo2oT+GO
 MHk7rWFvPolCJiPyRBj2fxX7nf3OFG/5U31oRQ9sukuL/DD/YxdRVZzp29hPDAj8Akda
 WpXQ==
X-Gm-Message-State: AOJu0YwXshqlc8m01LvF6dGXjbUpZITr3UVIOeJ3Zs9kaQrCtvdzV41N
 /QLLwL0Eg/GO+k3UMcr6Yb6JdjXpKN/LoD+gFDw=
X-Google-Smtp-Source: AGHT+IHgviyhY7yKlNqxRmE6WwaO940upDCOvY40mXX30Yu8EEf4aMClzfdU0xfZVUS9bSW1cX4Vmw==
X-Received: by 2002:a17:90a:3d0a:b0:263:129e:80ac with SMTP id
 h10-20020a17090a3d0a00b00263129e80acmr4602846pjc.38.1691293054615; 
 Sat, 05 Aug 2023 20:37:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 22/24] linux-user: Use zero_bss for PT_LOAD with no file
 contents too
Date: Sat,  5 Aug 2023 20:37:13 -0700
Message-Id: <20230806033715.244648-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

If p_filesz == 0, then vaddr_ef == vaddr.  We can reuse the
code in zero_bss rather than incompletely duplicating it in
load_elf_image.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 66ab617bd1..51591a1d94 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3209,7 +3209,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
+            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em;
             int elf_prot = 0;
 
             if (eppnt->p_flags & PF_R) {
@@ -3234,30 +3234,17 @@ static void load_elf_image(const char *image_name, int image_fd,
              * but no backing file segment.
              */
             if (eppnt->p_filesz != 0) {
-                vaddr_len = eppnt->p_filesz + vaddr_po;
-                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
-                                    MAP_PRIVATE | MAP_FIXED,
+                error = target_mmap(vaddr_ps, eppnt->p_filesz + vaddr_po,
+                                    elf_prot, MAP_PRIVATE | MAP_FIXED,
                                     image_fd, eppnt->p_offset - vaddr_po);
-
                 if (error == -1) {
                     goto exit_mmap;
                 }
+            }
 
-                /*
-                 * If the load segment requests extra zeros (e.g. bss), map it.
-                 */
-                if (eppnt->p_filesz < eppnt->p_memsz) {
-                    zero_bss(vaddr_ef, vaddr_em, elf_prot);
-                }
-            } else if (eppnt->p_memsz != 0) {
-                vaddr_len = eppnt->p_memsz + vaddr_po;
-                error = target_mmap(vaddr_ps, vaddr_len, elf_prot,
-                                    MAP_PRIVATE | MAP_FIXED | MAP_ANONYMOUS,
-                                    -1, 0);
-
-                if (error == -1) {
-                    goto exit_mmap;
-                }
+            /* If the load segment requests extra zeros (e.g. bss), map it. */
+            if (vaddr_ef < vaddr_em) {
+                zero_bss(vaddr_ef, vaddr_em, elf_prot);
             }
 
             /* Find the full program boundaries.  */
-- 
2.34.1


