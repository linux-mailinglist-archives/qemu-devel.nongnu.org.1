Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3F3770BBE
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rO-00053u-RA; Fri, 04 Aug 2023 18:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qv-0004ma-A4
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:57 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qs-0001vr-3X
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:55 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-26813cd7a8aso1718601a91.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186452; x=1691791252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwFHtt7Rthrgzaq+94z3/B+V/hUuIkoTCUpTmlGBJ3w=;
 b=D2myYZA0FnTgN3xdV/0JJ+PQg4BxOJIOoE/mCOhOFFK9OPnNQMczF2h28Eq6OE/6U4
 yCd4TvWIOd+k3GZgDgYAsWzGCbf1tQN2ZnRXp8TeD0IOaRFqc7Om1XN0ZJcvpPvz1w9q
 Do5XPGuPXwFBtuFQh9+PjOvKu0+8z1jsUYaVzKmKWLz4miOskdxmrjyT5bjRMzyqqWL6
 ZVBECEKIXw6yADfdltNVZuhJaWMEs8T2HCUbindSWg+FmoJy5kFs3mf1sKrRorfBq8Jn
 iLAxsUpaDNtFogoEJTJXPm/Hu4uRGGZwcRMMl8wyCd/brnM4VBMx1Wuw5ziHnrmNT/7/
 qj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186452; x=1691791252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BwFHtt7Rthrgzaq+94z3/B+V/hUuIkoTCUpTmlGBJ3w=;
 b=QqL1QkBoGPp8f3aVizmHdhDLKWzlCYsbAAIUtAsC0TeFEm1yQ5tkN8kBuQ0YnkkGb1
 LtkJIHk7vecFyz7nVOwdaOmgMf3nrDx3/V5YgpTtNJHg2BodUB3a2snABD1YzjEtr7KX
 F/CepLwiFCeqjJdz0eT2c2Dvq/b6foF+J7K4DoCxn/CPY2cC6CK7BDID01z+RvJNFOA1
 Qf4+xZr0Zgrbu2MLx5yzEF2FgApEbKUFPrhwNapJ6y6L36yWcLXRTF8bbpndVHechtck
 pjW5j7JdQ+UfOpVrZ65jgy3QQOG1aNPcxuCcsCdqRfeX+R18E8wqfxUe0YNEHOhzZpbs
 pV7Q==
X-Gm-Message-State: AOJu0YzQCRUpVKKm0CVerskBCmLJomDvtGmC3BTzdG69IEWiQornVIsb
 Kz3dPKPGhEsPg+fN6ADoB2St75mRfd0qivo6b0s=
X-Google-Smtp-Source: AGHT+IEfzcuocQZCE7FRpsLgwQMtfIWLXdusghmb9Gng0IZ+/oOQJdjhyApYuv/HZ2mgFT9+IXd2cw==
X-Received: by 2002:a17:90a:c7cd:b0:268:5c3b:6f37 with SMTP id
 gf13-20020a17090ac7cd00b002685c3b6f37mr2927327pjb.0.1691186452517; 
 Fri, 04 Aug 2023 15:00:52 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 22/24] linux-user: Use zero_bss for PT_LOAD with no file
 contents too
Date: Fri,  4 Aug 2023 15:00:30 -0700
Message-Id: <20230804220032.295411-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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


