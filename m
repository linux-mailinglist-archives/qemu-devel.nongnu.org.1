Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A45781161
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31p-0008Go-Aq; Fri, 18 Aug 2023 13:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31n-0008GH-Cv
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:51 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31l-000835-9e
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bddac1b7bfso8300365ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378768; x=1692983568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LMSfIZM5KDQOW8rzGrPmwonqS4UNbZW6sqmCOtQy3AM=;
 b=bbenPueQefXEXb0zHbO023NAAyRmFlmrOWeqTTddXHSnZeEXMXEIBx3rg5UFaDLuJm
 BNQ0UAtI6aUD5Qf1gxD3eoVIidcyND5HBh3a2uqSPrBYxdv2KzWz+z3uPm9D7YfQ0hLU
 mZxAAcmuXrKoid3gIUX5j+Yxjz7mJxDVQpThyez0c1lA6v0QsQEyFPWy6e72PMrOPZ81
 /UXOpTw/s4A42ffsJAlDw2Gt8HVid4prqiKBsU9yCZQWmLGQIx3iTtQ5NkRqdmE6qqkD
 qh5Wvc57uJ3tlx31zc8DOVKV2vXQG5P91HcNgin9hAG4cHkPRkp1l7mEEfZSCn+/JAXK
 2osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378768; x=1692983568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMSfIZM5KDQOW8rzGrPmwonqS4UNbZW6sqmCOtQy3AM=;
 b=cWH46Q8RI/nC6vlXuQpp8LUm/g0jFy2Yd1EOFZjn3IxHl3cTenM/MNNMzTqEPXGITN
 sbMG3MkN6TuQ3TKXp14E0YTodWdbbZDhcnB/PirQ7jSmQZWPenlSeF3QAljHSuHEvvNw
 Bxe5i0I7QyEn8+4G6xJqvpxMyRW+p1rY6992UJMOFL9Njab+1djH9xGMlx1M5tYQ46oV
 MuZJ+qwFQlt7jc/+eYPJJaoBR86GHEtXYvb1+tHvQdXSNjDTHWQtM8ooomHD/O4/vPix
 474yIlZh0sSlw3g3+lU4j8T+2idIftVdQwhoiVrH3nXaIgC9YL71yIt6IzaEbhCP3ufl
 Gq1w==
X-Gm-Message-State: AOJu0YwPMwC5Jof/BgPGapTLO7eRfpNiHMCF/fen4wHnzA25bEgohym3
 yFEQ86TZH30gyAJpPj3ROvsC9wfRSSQSJJuqFwk=
X-Google-Smtp-Source: AGHT+IHIOK2CHdN8SunLb/yc31WxzheyLJVAdhJ2sjYVsRr5wMtOi4hJYtFyfrzaUdtunRnVnS958w==
X-Received: by 2002:a17:903:1246:b0:1be:f37f:a8d5 with SMTP id
 u6-20020a170903124600b001bef37fa8d5mr9210346plh.10.1692378767835; 
 Fri, 18 Aug 2023 10:12:47 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/33] linux-user: Remove qemu_host_page_size from main
Date: Fri, 18 Aug 2023 10:12:09 -0700
Message-Id: <20230818171227.141728-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 96be354897..c1058abc3c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -783,7 +783,7 @@ int main(int argc, char **argv, char **envp)
     }
     cpu_type = parse_cpu_option(cpu_model);
 
-    /* init tcg before creating CPUs and to get qemu_host_page_size */
+    /* init tcg before creating CPUs */
     {
         AccelState *accel = current_accel();
         AccelClass *ac = ACCEL_GET_CLASS(accel);
@@ -806,8 +806,10 @@ int main(int argc, char **argv, char **envp)
      */
     max_reserved_va = MAX_RESERVED_VA(cpu);
     if (reserved_va != 0) {
-        if ((reserved_va + 1) % qemu_host_page_size) {
-            char *s = size_to_str(qemu_host_page_size);
+        int host_page_size = qemu_real_host_page_size();
+
+        if ((reserved_va + 1) % host_page_size) {
+            char *s = size_to_str(host_page_size);
             fprintf(stderr, "Reserved virtual address not aligned mod %s\n", s);
             g_free(s);
             exit(EXIT_FAILURE);
@@ -904,7 +906,7 @@ int main(int argc, char **argv, char **envp)
      * If we're in a chroot with no /proc, fall back to 1 page.
      */
     if (mmap_min_addr == 0) {
-        mmap_min_addr = qemu_host_page_size;
+        mmap_min_addr = qemu_real_host_page_size();
         qemu_log_mask(CPU_LOG_PAGE,
                       "host mmap_min_addr=0x%lx (fallback)\n",
                       mmap_min_addr);
-- 
2.34.1


