Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187776DDB0
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWi-0000iv-Mx; Wed, 02 Aug 2023 21:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWg-0000i6-6K
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:18 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWd-0000oN-LM
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:17 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so1083315b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027594; x=1691632394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChEUXUgAPSYhXU4GN1bgmHxBnAzewX2kPCgTDo1jgOA=;
 b=buVzk17/UzMaI0kKJj0C9HpUwQbWclgya3adJJYiPRubCo2UM0hIZzLQd5f8aDJ7GR
 CCQCGEyNyEVYJrIK2mhlm/Op0Or1nah3m5Lw0Ica3kfORuqXEgr2Zap9SfLOefBIKCE7
 bpgycsabfJMzwJm0iEg4gYMlTz4LNbTRkczu7alcPrg2iyXd4W5VEmbySEOTjfx0W6E3
 iCvkgYpmY37W5ellBLXQAC2UmuhMgLY/ZkdR5NjSkjfMpAkzV4DFdvkcA5CdT9J6fNaH
 hYZyj6xqloIljZSGDkgG+sXSU56lWsYl7RxcmQZaRSV87sahqnOzGQTscK25KerH/7jX
 eV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027594; x=1691632394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ChEUXUgAPSYhXU4GN1bgmHxBnAzewX2kPCgTDo1jgOA=;
 b=V/hT223VrcixJqq9Y5Z+GCTgjUdMgbKyDxFjbNONhUnA8P3KKwe1Pg/bjPdvTicKEf
 smWOxePKMBeY+VyGe8zwe19GTHCdPH0rpAe24XQ/dqXgcn03/JYf61ys80Zan9XeT6RH
 LBaZtONISS348wiBuqirZOvNxvTeltoNwZ+sliTb+XLO87wzn7NfGVOisViJDvyE/+ZO
 abQV+Uu39IS3ETiBQ8JL5VzlQzNxk3FTHdgRrx6JNXlU1USiQ2N9F7nQ+XH2LBvUHQ0l
 RC9QGIrJiwGkU4btWTvvUasSLcCk3eLn3Ya6ApKcSL2qNx+vGggPj0LbhRLEyMZQl/yd
 TGZw==
X-Gm-Message-State: ABy/qLZhnxJ1M+F2KYVnoINjUDpUlDu2d7iPA95NGITPqZgeHhKZbbf8
 9s/613lNB5PUMiUbyE7agHTGZ2NGQs8GWok3aT8=
X-Google-Smtp-Source: APBJJlG1VS8EKLn8UdhaaIHjomgWPKMK2/uOHBeZ7LmPDijgsPnnZdLh09wdtAJ1PrZIylyKHPQDuA==
X-Received: by 2002:a05:6a20:72a5:b0:132:d09f:1716 with SMTP id
 o37-20020a056a2072a500b00132d09f1716mr18620596pzk.2.1691027594197; 
 Wed, 02 Aug 2023 18:53:14 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 12/14] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Date: Wed,  2 Aug 2023 18:53:00 -0700
Message-Id: <20230803015302.407219-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
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

Follow the lead of the linux kernel in fs/binfmt_elf.c,
in which an ET_DYN executable which uses an interpreter
(usually a PIE executable) is loaded away from where the
interpreter itself will be loaded.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 2aee2298ec..fef9a0bc8f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3021,7 +3021,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     struct elfhdr *ehdr = (struct elfhdr *)bprm_buf;
     struct elf_phdr *phdr;
     abi_ulong load_addr, load_bias, loaddr, hiaddr, error;
-    int i, retval, prot_exec;
+    int i, retval, prot_exec, load_map_flags;
     Error *err = NULL;
 
     /* First of all, some simple consistency checks */
@@ -3106,6 +3106,19 @@ static void load_elf_image(const char *image_name, int image_fd,
         }
     }
 
+    load_addr = loaddr;
+
+    /*
+     * For ET_EXEC, load_addr is required.  Use MAP_FIXED_NOREPLACE instead
+     * of MAP_FIXED on the off-chance that the guest address overlaps a
+     * host address.  There should be no other conflict this early in the
+     * loading process.
+     */
+    if (ehdr->e_type == ET_EXEC) {
+        load_map_flags = MAP_FIXED_NOREPLACE;
+    } else {
+        load_map_flags = 0;
+    }
     if (pinterp_name != NULL) {
         /*
          * This is the main executable.
@@ -3135,11 +3148,34 @@ static void load_elf_image(const char *image_name, int image_fd,
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
+            load_addr = loaddr + elf_et_dyn_base;
+
+            /*
+             * TODO: Better support for mmap alignment is desirable.
+             * Without reserved_va we would prefer any host conflict be
+             * resolved by choosing a different address, therefore we
+             * don't want to use MAP_FIXED.  But without that we cannot
+             * cannot guarantee alignment, only suggest it.
+             */
+            align = pow2ceil(info->alignment);
+            if (align) {
+                load_addr &= -align;
+            }
+            if (reserved_va) {
+                load_map_flags = MAP_FIXED_NOREPLACE;
+            }
         }
     }
 
@@ -3157,10 +3193,9 @@ static void load_elf_image(const char *image_name, int image_fd,
      * In both cases, we will overwrite pages in this range with mappings
      * from the executable.
      */
-    load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
+    load_addr = target_mmap(load_addr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
                             MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
-                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
-                            -1, 0);
+                            load_map_flags, -1, 0);
     if (load_addr == -1) {
         goto exit_mmap;
     }
-- 
2.34.1


