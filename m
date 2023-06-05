Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6DB723123
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:21:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgF-00070y-I6; Mon, 05 Jun 2023 16:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfr-0006ta-P3
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfp-0005kc-Oy
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:31 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5343c3daff0so2824843a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996368; x=1688588368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+2aTZUDJhHk+1ynfemTk95bp++Vx2nuawcefQHRCuc=;
 b=Ko6AfTqUBr/Ap/UafM3WeBuRiB9s7Vq9k2/oHgRM4qYjPYgBL88n+VzPqbiwoGfkn3
 Ne3Se0Dj4k0ux2uh0Ji6BitHrniIsjk1ImsBzB9yi5hVGGMCDUWXEuZ2pZFvC+OuQID/
 944NLG4tarMgUz9Y+Nphsj9H6E4zjC1ZjIKqZIsAnhqw0mvIQ4vmO343PnWjKQQNOvMs
 CMu3+B1mc9AQZMld85elxAkknv7UPguSZ3ekIQ/1SfSfSZxoZ6rUoRrDeqZBrZX8+UwD
 UdmyfkNyoY8O5RmPHbT4PNN6Kv4F79e53qiG9SAfG7oPjFnEKJjjMp12CZ+xHjBdeEOM
 QZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996368; x=1688588368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1+2aTZUDJhHk+1ynfemTk95bp++Vx2nuawcefQHRCuc=;
 b=GeXLWZ1JFyAJ37hLVvQDNLVT0R0nBuM5CJP9cpVu+czNDVYWpbXxblapsYQCQ1NDCn
 VjDObBgNsYzPvqDo4zgxl0fvAqjiYUFfPO8aU7YTqWbgavrHG/W8hpuxlWs1enFLs6fd
 NE1wrqQNq8klZRb1aYU/eP5AL4sHt/iDMMbO7pZ83iQx7ac7AeRKD3gmiXcpTbh82Xtn
 7sfCFSI/d6jToWUk63XxwMhOehiclrOY31aeB6WjJaZExZe7LfbhW3/49hyHixzB+8nO
 /vseg2HdFvzYA4Pl+gIIjBRWLjIfQw1Ux5eirVo3kZ9mFyl+aUaLBCgZ0WEZSDcQe/Qq
 CPKg==
X-Gm-Message-State: AC+VfDzMk9FRnRaScmet05f6zTKgFGgW7Tj6N2+Ta8+cQGErlDf4n0BV
 2YNiauwQWC9UajzoOP+PcE+Jjg8CX8eaLAKN1lI=
X-Google-Smtp-Source: ACHHUZ5/xUSVSWH9I4p/RocbwgFnDMByZcocBodELMCf5/+rsD/L1Z0mP3gTke0F4+tlm9Jj+XQsTw==
X-Received: by 2002:a05:6a20:3d02:b0:10b:6b1f:acf1 with SMTP id
 y2-20020a056a203d0200b0010b6b1facf1mr136117pzi.29.1685996368079; 
 Mon, 05 Jun 2023 13:19:28 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 44/52] tcg: Fix PAGE/PROT confusion
Date: Mon,  5 Jun 2023 13:15:40 -0700
Message-Id: <20230605201548.1596865-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

The bug was hidden because they happen to have the same values.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/region.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tcg/region.c b/tcg/region.c
index bef4c4756f..f8410ba5db 100644
--- a/tcg/region.c
+++ b/tcg/region.c
@@ -505,6 +505,14 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
     return PROT_READ | PROT_WRITE;
 }
 #elif defined(_WIN32)
+/*
+ * Local source-level compatibility with Unix.
+ * Used by tcg_region_init below.
+ */
+#define PROT_READ   1
+#define PROT_WRITE  2
+#define PROT_EXEC   4
+
 static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
 {
     void *buf;
@@ -525,7 +533,7 @@ static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
     region.start_aligned = buf;
     region.total_size = size;
 
-    return PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+    return PROT_READ | PROT_WRITE | PROT_EXEC;
 }
 #else
 static int alloc_code_gen_buffer_anon(size_t size, int prot,
@@ -794,10 +802,10 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
      * buffer -- let that one use hugepages throughout.
      * Work with the page protections set up with the initial mapping.
      */
-    need_prot = PAGE_READ | PAGE_WRITE;
+    need_prot = PROT_READ | PROT_WRITE;
 #ifndef CONFIG_TCG_INTERPRETER
     if (tcg_splitwx_diff == 0) {
-        need_prot |= PAGE_EXEC;
+        need_prot |= PROT_EXEC;
     }
 #endif
     for (size_t i = 0, n = region.n; i < n; i++) {
@@ -807,9 +815,9 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
         if (have_prot != need_prot) {
             int rc;
 
-            if (need_prot == (PAGE_READ | PAGE_WRITE | PAGE_EXEC)) {
+            if (need_prot == (PROT_READ | PROT_WRITE | PROT_EXEC)) {
                 rc = qemu_mprotect_rwx(start, end - start);
-            } else if (need_prot == (PAGE_READ | PAGE_WRITE)) {
+            } else if (need_prot == (PROT_READ | PROT_WRITE)) {
                 rc = qemu_mprotect_rw(start, end - start);
             } else {
                 g_assert_not_reached();
-- 
2.34.1


