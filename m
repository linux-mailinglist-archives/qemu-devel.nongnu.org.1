Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19784771373
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaG-0003iS-4G; Sat, 05 Aug 2023 23:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaD-0003gg-85
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:33 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUaB-0007Zq-Ki
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:33 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2680eee423aso1672764a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293050; x=1691897850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDTWs7pBzjEM4yDIiLCCxRn3NjvKLf/PjlJHIm+hkqo=;
 b=efVtzpR1l/tn9lMq2lyqAy5nYGl8zods7/8Z8/Z+GtAMM96FLCvR2qZ5gwmniUr8L0
 IoA9WzzZkrVlqeDeLg36DU/86aI3/hatHyIX5fwydciy0ifkSqg8Y2ZfbqX0a4VzyD8R
 l4s2qvgrvAij9XwDjo5vT+yLARk0GI+FYRXknL5nW6bNCbi1LXGPKCGcCCKqu62XqtQk
 tcibedTwoejHta5tQvNrmFIUaRlQnJISrC9rF9UGDEEf08FQMx688mdlaVoQ+LEtRUdG
 cH5mI6k6QCEJZ7KK/LKnj6pDS1iCLMXpKmwqXbxnJRZyl6pssKLSHoXMdlmQT3apOO19
 IS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293050; x=1691897850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDTWs7pBzjEM4yDIiLCCxRn3NjvKLf/PjlJHIm+hkqo=;
 b=Cxh8wE8t7X+H9gbtC1jbFgXJEhujHq4/WWDE2YiLRuCrvKU7872Bsg8ERX3CTrMzMD
 thZxLExm5Kp7mpvPKZGLN6MbuI9Bw7GqbBnkcU130vGQF+Ct+Q8GjU4ZWGdP+RPPo5X8
 dTjL/GGPl/QtbRwE0aVDzj33Smyvgu4TcZD3pXgorKQavi4HzlWxCdg1Cb3yspD0bMPr
 oBtUTXvj207Bn6zTt0PAq+Ciu0Z6aFrDBvaxkOOmlEIhpghcMqO+Dwgpu+WwVpKkbHPo
 CbxNH3AHGgcfE+wfI/yCg9mX39tB6HYJRrZUrTvx1uIZsZG1EBPGezspWtXzVFRWLUx9
 VEXw==
X-Gm-Message-State: AOJu0Ywjx834d3nlxKedh63kOntjeF754HffCa4oE9UwiTOOrLRCo/mr
 ljR4Vpw0kvRsM3G5tbWt9UQjgSmLG/gy/pauEtQ=
X-Google-Smtp-Source: AGHT+IHKkZsxXZY1gBLnYcgfvcNhkEen9jCJ40k6oM9fi1VXS3a8+O8kOvMEsTcSJeOGtSHyXDapoA==
X-Received: by 2002:a17:90a:d30b:b0:268:553f:1938 with SMTP id
 p11-20020a17090ad30b00b00268553f1938mr4372119pju.4.1691293050478; 
 Sat, 05 Aug 2023 20:37:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 17/24] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Date: Sat,  5 Aug 2023 20:37:08 -0700
Message-Id: <20230806033715.244648-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
index 0c64aad8a5..a3aa08a13e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3106,6 +3106,8 @@ static void load_elf_image(const char *image_name, int image_fd,
         }
     }
 
+    load_addr = loaddr;
+
     if (pinterp_name != NULL) {
         /*
          * This is the main executable.
@@ -3135,11 +3137,32 @@ static void load_elf_image(const char *image_name, int image_fd,
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
 
@@ -3154,13 +3177,13 @@ static void load_elf_image(const char *image_name, int image_fd,
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


