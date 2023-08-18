Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFBF781168
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX325-0008OR-3q; Fri, 18 Aug 2023 13:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX322-0008Ls-BT
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX320-00087V-7v
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdcb800594so9297315ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378783; x=1692983583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gjb3/VxZ1+V+7wtutprokQqvAFJJgSE2zXjUQaXpThk=;
 b=kuEh4+JpYpTD2nX3jTcmYmIBK4Ol079fEd+Rg8VYjlUXmu0EjcLNEADNKcQuiXW+OS
 Q4d5LE4HafACHHc+AjLcjRewUjw5/WZVrHvPBcwRWuWIwsazVJ9ZVpGjK48eZjQ8tQ0n
 ovx3a7bdRRaApix4Mrs6c3TcfbnWqa6m8LhLxzjvJlIU3XCCrLQEAzvZ9X1VS3lE1bpk
 oR0iBB1tbw8RmigtLebGjYPNG4LhcEiPsjv1HDmnArmia3bR3dsTJdTP8Po9xiBTU0Ji
 rZW9dpxjm8fFrmRJca1TBtTXz860EkWLTyuYZEg7OOTET8pQ6O1sKZZrnz08fA31lCxe
 bK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378783; x=1692983583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gjb3/VxZ1+V+7wtutprokQqvAFJJgSE2zXjUQaXpThk=;
 b=GK5eAdMR9A0LGSO/jsZBIsHhkrnvlN2BY5/CUzeua/zwkujHIHbyNhh2jwLLyAELna
 6X35QgyAKfl0G0T+tby3A5PergAur4jTKQtjW4WIwxhw7X/DihxfmXM0Lc1R4e8m5JuG
 5naYtXGANx/pJgYajOPKKZFx4Ppn6t8KB47LXKpdrRJ2t2h8J1aHmEeMeVFXxwGRYORP
 yJR+6Vhb6f8KgIkd9OdJ9h/TZ36GzI3HYfz6IrVT9u+AQsqVlisBC16vY31iXWtCAHkd
 a19fRsudGUFtAq24d7sqgExOpb5wJebMpGe6eOuY/bI0Uw2HPI8be1tCTavH2C3ocCKO
 hzCQ==
X-Gm-Message-State: AOJu0Yx9gQu7DsVbS6UJ27w2m1Pef9jmKlG1AzRbPmythMa7xBdG3fXs
 tVVnCYX5HzpkVayU7Ys9rfjNsWWRhRKKwD32J5E=
X-Google-Smtp-Source: AGHT+IF/zxx6NHtIOi7MP523B1m/DRNQQx3+431M8mAhjLFg9lzwjwxt4HQKraLPL72iaeXb4DeNxg==
X-Received: by 2002:a17:902:7005:b0:1bc:9c70:b955 with SMTP id
 y5-20020a170902700500b001bc9c70b955mr3086081plk.28.1692378783022; 
 Fri, 18 Aug 2023 10:13:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.13.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:13:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/33] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Fri, 18 Aug 2023 10:12:23 -0700
Message-Id: <20230818171227.141728-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

If set, match the host and guest page sizes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 3dd3310331..2334d7cc67 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -55,6 +55,7 @@
 #include "loader.h"
 #include "user-mmap.h"
 #include "accel/tcg/perf.h"
+#include "exec/page-vary.h"
 
 #ifdef CONFIG_SEMIHOSTING
 #include "semihosting/semihost.h"
@@ -683,6 +684,7 @@ int main(int argc, char **argv, char **envp)
     int i;
     int ret;
     int execfd;
+    int host_page_size;
     unsigned long max_reserved_va;
     bool preserve_argv0;
 
@@ -794,6 +796,16 @@ int main(int argc, char **argv, char **envp)
                                  opt_one_insn_per_tb, &error_abort);
         ac->init_machine(NULL);
     }
+
+    /*
+     * Finalize page size before creating CPUs.
+     * This will do nothing if !TARGET_PAGE_BITS_VARY.
+     * The most efficient setting is to match the host.
+     */
+    host_page_size = qemu_real_host_page_size();
+    set_preferred_target_page_bits(ctz32(host_page_size));
+    finalize_target_page_bits();
+
     cpu = cpu_create(cpu_type);
     env = cpu->env_ptr;
     cpu_reset(cpu);
@@ -807,8 +819,6 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        int host_page_size = qemu_real_host_page_size();
-
         if ((reserved_va + 1) % host_page_size) {
             char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
@@ -907,7 +917,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_real_host_page_size();
+        mmap_min_addr = host_page_size;
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


