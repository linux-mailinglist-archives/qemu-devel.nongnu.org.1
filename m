Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E84F78F71C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpc-0007UL-U1; Thu, 31 Aug 2023 22:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007Av-M0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpI-0001T0-UL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:11 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1091528a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535036; x=1694139836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOXbHO/eFtWrlIqiHiO0rtMkzoeNCBbWRU+OxOKa9Pg=;
 b=inRF/wIbPYAhx3xn9OImu7t1+i4IYcVQ43dyWzrinH31pSeVLJd5H9fvfumvird95H
 5YBI7SHn2S15x5+YUTVoXn3P2mhqvQNCF9/Ivc49M4D8/vUFpNLez3KW9TU+Q4BBQ6G6
 EkNV5WLIjOmvKzQl/fnYSTHWE5d9AiQffE4avgMtpcomxgnSNDF+hVcH0MjZZudvvUaQ
 mvyJwPPti9iUz3M4QVIuJW9SmGaPca8g6+1o/qH1XtJ1A6NoEzp4wR0HW920rEjtaz03
 +AGxsX6Pi3zb0/sqduv3h5QU7Z18/p1413zPpjVtTe8VgkE5N6jOp2wURUwcvcYbC+r4
 AyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535036; x=1694139836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOXbHO/eFtWrlIqiHiO0rtMkzoeNCBbWRU+OxOKa9Pg=;
 b=OKRGsTob/Sed0utydteh4inQWCU8YpM0sz57g+kTOahmZbxLNh4Ff2oVxdW7Lnt2gF
 HtfvHU/ZCc9GXtWGqT5HhwpoopIEW2dS+SpDUtVzuIzPjMh679KcKyK81r4LxNTaZCX5
 e8VDV91/Q7Qg9jxz/tbHVUvXpM0cqmYS76R2XD9Eql/WFraPRTEDJUnLSC0/oM/h02KW
 RuSBOAnyiOAscMomEavxMCjo+CkCSou9C4IODx9zSuo59ut7iEupJAiCwar321syfvqG
 Kt2XB5uvQNPZgDxWPhJG2rYUkHYlt/XvQePOxRy8mdzIZXJzcittwORYV6i0vD3vU5Xz
 ipGw==
X-Gm-Message-State: AOJu0Yza50rgPOmP5rIXpgV9YxKDQSrdj/PAqfY3aVPJXuNvrUQU7qV0
 BaiH8XHnXAMNzPY4FTKBHWb5t9xnSL5dWtv/6Eo=
X-Google-Smtp-Source: AGHT+IGW0tEr0XXwgScXxUmoGvRLHJs3LT2FZTt5h9MKGvJ4GvUCyaeLLtSbooONE6p0Z8D/ylV5hw==
X-Received: by 2002:a05:6a20:a122:b0:14c:6438:eece with SMTP id
 q34-20020a056a20a12200b0014c6438eecemr1581864pzk.62.1693535036197; 
 Thu, 31 Aug 2023 19:23:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 29/33] linux-user: Allow TARGET_PAGE_BITS_VARY
Date: Thu, 31 Aug 2023 19:23:27 -0700
Message-Id: <20230901022331.115247-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


