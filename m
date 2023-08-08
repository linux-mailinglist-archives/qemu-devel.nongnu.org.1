Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86134774C87
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:11:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTwy-0007gw-0N; Tue, 08 Aug 2023 17:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwv-0007fq-KA
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTTwt-0005w6-Tj
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:09:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bb7b8390e8so39599115ad.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691528942; x=1692133742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gdGMnmtdSmtXaxIRFinY8s6zOHM1AhXo+8V5ig/K9Os=;
 b=UjDpVlIiYsF6ilISjjrc5o9WMy5YabFGkw6/jtCyrTgMj+Y8zgEmJQRo9IhYNigZjo
 cvPypdt49XcwHtrW47BfZm3DQpPpP+MCvdJL1bJSPXmx5mtHI3BVXgL0HMOx4dackIKR
 mjSuPV8F2vE8986LG5SdTuIWehi82/cIu8k0qRp8wDqaDj6sQWBlrMTK8oVhma9+5KOL
 974UXP/culj2J2EXY50eFV1ck6yMfzzwIKlBiJUDxgeYfULWVtxzu0XSMkIc0l0H64T/
 20532FQ919OK7RU/NdJCJiUJsnx5C7HA6Fylbvnanj6rMVqlOJpbHNK/H8hE9m7Kn8pk
 e5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691528942; x=1692133742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gdGMnmtdSmtXaxIRFinY8s6zOHM1AhXo+8V5ig/K9Os=;
 b=fET6X+09IOsxZl6YstMWGD5euhjXq6SlSwdrjhefSeOHcmjCdjsZ2ZnL5qayhbffSn
 T3Slzef1i1YvI5SON47DHSqFZo3mZYu2P7nFIPRAqnGyPfR4pFE0O2NV4DJXFY1+RtWU
 UVakTZx9SdXOGF1vPrvr6Q8qSEoglIZO+D7ctXJXMjrkCPTOCRcOlnNoDz2wLjGRT+UK
 5an1EFbrtuDGZveX0pQRUMcf4WcFAQbrks/+X0jHvUyWudaANLidShpHMB+Xq9zgqSN3
 hLIzeG83Gfa3qRSNGTlUMrfwOKrd2zajikEPeiSmNjM2ijXkRU4oNJo4YVsCoLtfz51T
 H84g==
X-Gm-Message-State: AOJu0YywWnAesmmxLnE9J0jwxSeP1tApjyRGTc6m5h83/PnGb9eyXqjj
 asJrQ+zUwK1X5Ge7CHy/E2HTC2k1wNJQlBchgV8=
X-Google-Smtp-Source: AGHT+IGmQP3QfIHoday8wkCzCxqJy4WD50UdpSNQu/l1B7uzM8Gnnw52YPumrj7sOkfS70pZ7W6blg==
X-Received: by 2002:a17:902:e885:b0:1b8:72b2:fd3b with SMTP id
 w5-20020a170902e88500b001b872b2fd3bmr888619plg.54.1691528942605; 
 Tue, 08 Aug 2023 14:09:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 k11-20020a170902694b00b001b3fb2f0296sm9437533plt.120.2023.08.08.14.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 05/14] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Date: Tue,  8 Aug 2023 14:08:47 -0700
Message-Id: <20230808210856.95568-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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


