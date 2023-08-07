Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8D8772B2A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EZ-0007VZ-Fh; Mon, 07 Aug 2023 12:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EL-00075k-DQ
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:19 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EJ-0002hc-To
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc7b25c699so2821165ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426234; x=1692031034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+mZZ88pcdw893U+hesCVPS8DRB2GmOsmcmXPqFY2jE=;
 b=LAdWI4BvRcfFZcUbI/FkufRUEHGCXJICTh669vZNEvlcp8YaUs+QwEc0FtOHOT2p9i
 8qqrGQNRxPMUatTKC4w4JlAH1sLZ1UT8OtyVNrTxud8LV46HnSpTLdeBMrwS7XQKMjsu
 XUJVakuTSQvXWP29UlV0y1d3fnIhUXDU6sCfclDj+csfjECF751ptunnSF1gfsXm3HOF
 2huBl03YBef99FOLItStXg6ggqHuxJhFXuVWlIqP0uYNau6rT9wD6yQeEoc8OPBcq2XE
 b/K58hsmjfYMpLLU710lw9bA9C0lalcvJKy+h+x0jD1gTXBO/Gp3yljJ+kfMyxsnsWJ9
 lHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426234; x=1692031034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+mZZ88pcdw893U+hesCVPS8DRB2GmOsmcmXPqFY2jE=;
 b=epK4qxjItBk81ZkZ06ywzfA8tIPbyF34d6frawPL+5mk3mImApJOiHNjlKY0RVHeP4
 pYCt0JfcAdFXWTwmQkvU5H7hLsmGTaTbD+xoBWfh4GKyc7RmhrIl5C60lgZUFZUafuwT
 6i7cB/FdUypruYqJxatFo/dvoPIyeurOumSkf4ldKeE43vBS9nUFtBhiBsBBobYKgycG
 Gwp/oLMswUN4+qudy254LIGBpj6vvgRzCHHfosEZvCrgn8TvgQQUMLpyg4FNVsqQXYcL
 VN+mukBPm+X6CtnG87HmH3shnWoCVhvNcZ3IczQAXbE3weNyINWg4kEVtT8UkeiSXHP5
 3NPA==
X-Gm-Message-State: AOJu0YzOzRHsL0jegGwV3iYK0mcsQTEP7E3rKkAvZOJRR+BT4yO4Fcc4
 407kkEdBgfHGuLB1YMVKCpvw3rr6xpaRXuJAUVw=
X-Google-Smtp-Source: AGHT+IFh6yd55KkqSrGtvMByFKJoJRRGTq/arlwxnyzxlNDnh8t5UFyMsAJqcfFbska+fUiV+vFJtg==
X-Received: by 2002:a17:902:db0c:b0:1bc:7441:d81a with SMTP id
 m12-20020a170902db0c00b001bc7441d81amr1924036plx.6.1691426234670; 
 Mon, 07 Aug 2023 09:37:14 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 09/14] linux-user: Use zero_bss for PT_LOAD with
 no file contents too
Date: Mon,  7 Aug 2023 09:37:00 -0700
Message-Id: <20230807163705.9848-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
index 6c28cb70ef..c9e176a9f6 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3210,7 +3210,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     for (i = 0; i < ehdr->e_phnum; i++) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em, vaddr_len;
+            abi_ulong vaddr, vaddr_po, vaddr_ps, vaddr_ef, vaddr_em;
             int elf_prot = 0;
 
             if (eppnt->p_flags & PF_R) {
@@ -3235,30 +3235,17 @@ static void load_elf_image(const char *image_name, int image_fd,
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


