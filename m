Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A05770BBA
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2rQ-00058p-Vh; Fri, 04 Aug 2023 18:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qp-0004jD-C4
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:52 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qn-0001uU-PV
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:51 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26928c430b2so612948a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186448; x=1691791248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDTWs7pBzjEM4yDIiLCCxRn3NjvKLf/PjlJHIm+hkqo=;
 b=mFbhnmTOb9ortZswDG+WagB9Agyol7SfS4pfZuQXSuaMrwSpR2swynWQcxlIQm0oaB
 aqip3iqhxos7VSf+GYw2dK1Q/osOCMWBEu0BwF9uMnd+ymwE/FShs28LAcH4pGWRwgXe
 59A7MTDJaDG+zW0f2kBLPxNlvxJBovi5nE6dHHqSs9w13oNn5OgF58mXQWZboFpznlZt
 K9wT2cFUGYCaehKBDUtHlFvxmRv2peCZHXrt/yKUoTBIgSCwdQbXYUqaOndl6Awz+/X1
 pZxuP/ic3TNwR90ckP7URy1YNRvQyg7UkzyOjreeTQclEd+PwK0i0x4XmJ32Eo1d9b4Z
 F/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186448; x=1691791248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDTWs7pBzjEM4yDIiLCCxRn3NjvKLf/PjlJHIm+hkqo=;
 b=kCTAlsoUg04saBi6CZV2pn2vDSdfznDQ++f2gE4zewRAltTMNE63PJwKhvT8cQHj0A
 H1DAuLyhIzdB8ltf8P2oVhmRpw6vGb2osy5tbzouLcTpzB+vEi3/parxGn70Rl9t8uRF
 SdluXVTix5CdbRXr8LH+YckDwEa/ygJOx+TjlNrvOnzAdEWGI+R3oNRkatF1ht5wcRjM
 B6vAcesKgCy8k7oyZTvjnH0QLHl1YHH3EM6Fz687c0rMIUoWw/XoFbuQkIoiSwm0mb0q
 c9nyuiNQf9YkI5SWS6dP0B57ksfo/ESLeNX1+J4xWocQekmOUJ2iZC2hwMUZptJWEq/h
 qVZQ==
X-Gm-Message-State: AOJu0YygKGC8bjY2LMyztKYmg7sQq/pp5Ae13CbaW8kk9BMs7Zrq5/6N
 FxUJZzHHGxHt3QvHpx0YgcWdyRO18c7N1OQ2b1o=
X-Google-Smtp-Source: AGHT+IH9GPZG4uLgHn43hLBSpt0pabwu+ogSSJoAj/GOPZjekO+DSSlYgIrz5qp1QfxOqmoL/8gurw==
X-Received: by 2002:a17:90a:c8:b0:25e:bac2:314c with SMTP id
 v8-20020a17090a00c800b0025ebac2314cmr2611176pjd.23.1691186448452; 
 Fri, 04 Aug 2023 15:00:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 17/24] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Date: Fri,  4 Aug 2023 15:00:25 -0700
Message-Id: <20230804220032.295411-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
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


