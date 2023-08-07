Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76E772B3E
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3EW-0007Ed-BD; Mon, 07 Aug 2023 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EI-00072v-AO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:14 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EG-0002gn-LB
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bbf8cb61aeso29993225ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426231; x=1692031031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdGMnmtdSmtXaxIRFinY8s6zOHM1AhXo+8V5ig/K9Os=;
 b=UVG7G/CadsGT6SZkxRHBTw6gJdpmAysIbdAt3gNz/0BM7H7fy6AINFopvYVHOKHfvn
 gHI/0FEGAc8OFnfnhKvsPeF9384P9CO7hJwGD6BGgvI0HTn2TQbjQ+BFb8V/elY7SXCX
 Yz3bLiIG7WB2izulCWNKH0e6a66hJiu7vuBYMa5JRWt5Tea2AOMhI8srMylWsaSFIDFx
 tocacSySoD3IDZkHXnqkZp1xfZhmWZiUwsFB/m/OkFHCfhahJc7TgrWckMOFBuFDn8ia
 NzPpbz4XWY9TSeO1k3nkeR85UurTDqQE/RQe4HzQ5ot3DPjgW5htsoUZyXAKvvWuU50H
 hXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426231; x=1692031031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdGMnmtdSmtXaxIRFinY8s6zOHM1AhXo+8V5ig/K9Os=;
 b=Nw4y3mWhxmYeFouhRUo/OdkZwkpUEzoPfXInq683Ng6TvXwETNtrKJMO2UC2r24hBN
 NAy7pBWgldB68ifu56VEL3wPwS5CgMmoE7keJJATppH4H9Y76RHWtpCCDUTT3pSGoEMz
 ulmAAnns1p1KTMJF3K+QDwTECsfL+iXU5VWnL5rXmUI40A03WPQhcV0OtKb7+OoWMUK4
 BQUUaV4rLvlkv7KgtXlsOhdmKhE+5JAz+BdInQGoXgAGP/iRvznlzfWL34OCEGx1C49P
 VXTOt6T/Typ7dQpcIEcWVCkL6T3GUHyUo/QUGGa2G8Zs5hRsKou4lYYD3K1VhdmW5jw1
 U4iQ==
X-Gm-Message-State: AOJu0Yy8P9VOZJSFmmO6XRhiFeIJmIi1mBHCZJ5padhPC2elNlwuBgo5
 Aw1s3k+b3drXJL94QD5a+kZdXMgoMvQ29fUxK8U=
X-Google-Smtp-Source: AGHT+IEbrIrtGerOtTRQcA7XkSXQ/ZVkxc+QI7dbnyRzzpi1cLMt0qQlc61L6pizBS8ifbKEn04lcw==
X-Received: by 2002:a17:902:ba95:b0:1b7:f546:44d7 with SMTP id
 k21-20020a170902ba9500b001b7f54644d7mr7401608pls.17.1691426231284; 
 Mon, 07 Aug 2023 09:37:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH for-8.1 v10 05/14] linux-user: Use elf_et_dyn_base for ET_DYN
 with interpreter
Date: Mon,  7 Aug 2023 09:36:56 -0700
Message-Id: <20230807163705.9848-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807163705.9848-1-richard.henderson@linaro.org>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Follow the lead of the linux kernel in fs/binfmt_elf.c,
in which an ET_DYN executable which uses an interpreter
(usually a PIE executable) is loaded away from where the
interpreter itself will be loaded.

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1b4bb2d5af..d1b278d799 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3107,6 +3107,8 @@ static void load_elf_image(const char *image_name, int image_fd,
         }
     }
 
+    load_addr = loaddr;
+
     if (pinterp_name != NULL) {
         /*
          * This is the main executable.
@@ -3136,11 +3138,32 @@ static void load_elf_image(const char *image_name, int image_fd,
              */
             probe_guest_base(image_name, loaddr, hiaddr);
         } else {
+            abi_ulong align;
+
             /*
              * The binary is dynamic, but we still need to
              * select guest_base.  In this case we pass a size.
              */
             probe_guest_base(image_name, 0, hiaddr - loaddr);
+
+            /*
+             * Avoid collision with the loader by providing a different
+             * default load address.
+             */
+            load_addr += elf_et_dyn_base;
+
+            /*
+             * TODO: Better support for mmap alignment is desirable.
+             * Since we do not have complete control over the guest
+             * address space, we prefer the kernel to choose some address
+             * rather than force the use of LOAD_ADDR via MAP_FIXED.
+             * But without MAP_FIXED we cannot guarantee alignment,
+             * only suggest it.
+             */
+            align = pow2ceil(info->alignment);
+            if (align) {
+                load_addr &= -align;
+            }
         }
     }
 
@@ -3155,13 +3178,13 @@ static void load_elf_image(const char *image_name, int image_fd,
      *
      * Otherwise this is ET_DYN, and we are searching for a location
      * that can hold the memory space required.  If the image is
-     * pre-linked, LOADDR will be non-zero, and the kernel should
+     * pre-linked, LOAD_ADDR will be non-zero, and the kernel should
      * honor that address if it happens to be free.
      *
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
+    load_addr = target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
                             (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
                             -1, 0);
-- 
2.34.1


