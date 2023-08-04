Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AF76F728
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsw-0002iE-T1; Thu, 03 Aug 2023 21:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsn-0002dF-62
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0005Bq-FC
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:36 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686efa1804eso1152687b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113532; x=1691718332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRkEwFCl346jg7Z07dyeTmyC7RNqDmLWj3eYDwe5avk=;
 b=uzAWbFQxcONuMkzKWaiuUmH/7ekp96n/cDLcA4CSHQ9wLFOuAxMYRMzMnle9lGHItt
 4HPUEBZnmAWkp2/YWxBhFC43xvQxSBN0d8WAp0B7nOtVfrT+Z3q6gAeepEuergoVaPiu
 HGBym0ebEqK3SzJebQsgQdSAa9n0EfG5QpwfFDjyaP4jjQ+xmq1MfIn9TyiP15YTSQ7p
 rl+dedNVu7ZI4PFQLC2Vt7G8qZ+PbwvIWyW5mxRv2koHObtPlVI9xGid3GmMSBN0idqj
 hJYJruO1mPSdVp/jDz3QpIgnZ2w18KOlENSKmQdx0M0lcWQO0Mmiku4oP5Cub9Y+W2Pe
 1OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113532; x=1691718332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRkEwFCl346jg7Z07dyeTmyC7RNqDmLWj3eYDwe5avk=;
 b=gDnNvTS2m6LdN5GDbSIhLe0EHeXM6loi3bY/2HLys+rqCto+7MVfTeev5/DIQBdv/w
 w0ukThwA6uwvec9+OZY2HhRDxV0G7/bxwr7kdvkpi7hHMYXqE3rXiKlVDmoZnxVVHLrL
 FZCm0dt0xYr3qn63n2yI42rlrA3/+hOfuCUgJfQN1rLlOT6oeL5Wn9u0f9ADXeilmkMC
 mfYlXdEaA6p5HzW7LkCZP0261CebXoGU4v7jmY7taMpau/xb5HQSqjfmcvFdC6T5vBKR
 5UjKJTplKVkbQGnJvbwbLNnkwrch8I0evFfwg5NeiQgxPLKR3sjgb7G2KQ9u6Zqdtjsf
 RocQ==
X-Gm-Message-State: AOJu0YzbK2tt1ZPPFKYXEbnm8n2dqgLq9DCvlMkqYJd7pDEB6b+dMWFo
 hfulX18LOjshP3SHP1BzHgU49TMoy3o6fL3fQrA=
X-Google-Smtp-Source: AGHT+IEfzLehh2AWWHaLGDoZ9VqabpUVF0Exlfq2pDDMY8H+iU4/1eDjznNNQguKMtUdEeZD7mUixg==
X-Received: by 2002:a05:6a21:7906:b0:135:2f12:7662 with SMTP id
 bg6-20020a056a21790600b001352f127662mr291638pzc.33.1691113532696; 
 Thu, 03 Aug 2023 18:45:32 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 17/17] linux-user: Use zero_bss for PT_LOAD with no file
 contents too
Date: Thu,  3 Aug 2023 18:45:17 -0700
Message-Id: <20230804014517.6361-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If p_filesz == 0, then vaddr_ef == vaddr.  We can reuse the
code in zero_bss rather than incompletely duplicating it in
load_elf_image.

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


