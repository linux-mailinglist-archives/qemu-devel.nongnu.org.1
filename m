Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C776F72C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjst-0002ga-VS; Thu, 03 Aug 2023 21:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsk-0002d3-NS
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsg-0005Aj-6v
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:31 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso1190679b3a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113528; x=1691718328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHlFA2vEENUlTkxsWGE73YfmKuW2ikvOlFn8aOT1vJk=;
 b=nCZYn1C3NhI2n5o28vX8ZWHhYzmqp00AbepRBHDyp3W52uqlaPIn982+3Ejaiqx+aK
 S1m5bWXDZPvZqYjfNckLCZrOjSwE7gpAkVrUg8eCrg1AC2qcKnD9FfZaTWq+h7M8BVHQ
 GU3fZ/0CNnprDeU3OglKGJP5E278xqh6aGKEkj8iNETcSZyWKNx2RQD0nLcVKl3Fd4mf
 vFTv/3bHiwzq+ufxKEQeWjUr7KCH+59Ahgm0EPkrGi8XrBDrK6e+weS5fjoXpWlkpHer
 Q71653k35/ZZZnFFvtrjPaLVmwEp5LWSrje0jYtlmK6583KcVped5WSfpsoqYhbL2aPZ
 0m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113528; x=1691718328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SHlFA2vEENUlTkxsWGE73YfmKuW2ikvOlFn8aOT1vJk=;
 b=khzWLTiRqyRpNZWoGcDRIkLl1azeeClMoHkn4+gvGV0G71p7kLfhGtB9Za1QL4ndCv
 lycoR7l2woiDCOZqNsRyJ4KqVDfpPk1lk9jh9m1BcPkrPARsPwWt7b8/my23h6IFjVrX
 Z3jh9RQud6aJhyVd6mjrRSNycigDuEyVlTyCGLwTs15QTxcOLn80u9lN1V1T5CG8roY5
 jepf0RKvR1sxMD1UTOkBMPu+9h2RlaXmsHsjGQVpo39VW6O20TL7+RWYkJAdByQrn01j
 dwX6XOYhdBIBNYJtpIH6B5C19Ar1ZXZloF2b1UugQppVedsR8pdPisMluUMe//JdtrIp
 5RiQ==
X-Gm-Message-State: AOJu0Yx3yTN9UYsSwKoaQA+hBQIhkYSBcSrwBGiz67UuZL/pu8UX39ZM
 7c1+z3KdvYAAv3z+XiebPou3iD92sSWCsLuG+HY=
X-Google-Smtp-Source: AGHT+IEZ4WcnZO9HSrC5gkM/FPVMUScoHTMZwn4u6O7F8bIIkv5EF3ZB0wecBzR/mRO9TpogXOcnQw==
X-Received: by 2002:a05:6a00:2da7:b0:687:596e:fa72 with SMTP id
 fb39-20020a056a002da700b00687596efa72mr402303pfb.5.1691113528068; 
 Thu, 03 Aug 2023 18:45:28 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 12/17] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Date: Thu,  3 Aug 2023 18:45:12 -0700
Message-Id: <20230804014517.6361-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Follow the lead of the linux kernel in fs/binfmt_elf.c,
in which an ET_DYN executable which uses an interpreter
(usually a PIE executable) is loaded away from where the
interpreter itself will be loaded.

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


