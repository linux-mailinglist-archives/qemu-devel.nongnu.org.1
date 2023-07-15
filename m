Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55121754902
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKflh-0001Fb-22; Sat, 15 Jul 2023 09:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfla-000188-0U
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKflX-0003Tk-S1
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:56:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3159da54e95so2757167f8f.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429414; x=1692021414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpPPTc1J6EP9QJbzcPqiBEK5MSOQgGdVVPldReJi1XE=;
 b=rajLt5A5MmhNh/+wdqsWpQwhP5NTf9/u5UUI/uim6z5O4eJUd2bfqb3tffHQT5F96u
 sB65n24brOrqcm3y5xRd1ud4rqLcZ0piF4bKtNnxX9JJF0bPd791D4lHtwKObrkbVdJw
 qoZgBwHu7rThPa7lhhyVjbt9y7cAtKpLWCPA4nAlu14RA7iEis4qHm5dSmmFHrk8fvTa
 qbk2uPgI/y2HELfXMOwO0xmb1ko8kP+e08IB15jvKJqWcTeJVKkYhRV0s8FpN8e/2E95
 44+F5e6ofOxqS5FLZlZ2gJtngcCCGrNzaQxRyiKTjIF0GRtug/iZLAxT0A9IAd38cuGS
 2UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429414; x=1692021414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpPPTc1J6EP9QJbzcPqiBEK5MSOQgGdVVPldReJi1XE=;
 b=T3OheNS7Il8EtSJK47GvGKZlAERyKEGu7e9s5+kfyYxaS3gURRiongv9YejER/XwMu
 pEKi9ogY1nfBzFJqiKkeE7eJB7sygvD1ZM842tKy+E8MLtrqCXsdopbwg9RE4FakAQDg
 w/yMyWQ7GbRQtZ0t0xlIp08ebb14ZftZPRGdiNfTqV2BvGK2fWhFsu6GHq9+OGceABRd
 vBZyiTCpcD5oSHH3MAkFw128dHehpWYwxGSA/UQNvyY3xSs9siIrq3t2rbN+pcJsBP8u
 yLqw/kLaZ9gPEcZVLbMbdgPAgrtedkmOFSiJWd+wvwoh8vH+TU0nCeZJsb4rwdj3cD9A
 ODTA==
X-Gm-Message-State: ABy/qLZwBzHGZOKRnlhddjGmK0eY4yhM47U77rAguxlyB69cB5OuCC5H
 DnqQEaSpvPpKmcnF+b2CtrAX6HsHIdx8PpkoJkOlbg==
X-Google-Smtp-Source: APBJJlFfw+CQXEgYtcp1dpabmpOfcc0+kHHfXe6uTB/1SmBE4E9NChQ5jZb6WKte+33QdswCiDzSHA==
X-Received: by 2002:adf:d852:0:b0:314:13e2:2f78 with SMTP id
 k18-20020adfd852000000b0031413e22f78mr6444223wrl.44.1689429414638; 
 Sat, 15 Jul 2023 06:56:54 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 r8-20020a056000014800b0030fa3567541sm13866651wrx.48.2023.07.15.06.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:56:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>, Anton Johansson <anjo@rev.ng>
Subject: [PULL 45/47] linux-user/arm: Do not allocate a commpage at all for
 M-profile CPUs
Date: Sat, 15 Jul 2023 14:53:15 +0100
Message-Id: <20230715135317.7219-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
executable") executing bare-metal (linked with rdimon.specs)
cortex-M code fails as:

  $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
  qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= GUEST_ADDR_MAX' failed.
  Aborted (core dumped)

Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
commpage") already took care of not allocating a commpage for
M-profile CPUs, however it had to be reverted as commit 6cda41daa2.

Re-introduce the M-profile fix from commit 4f5c67f8df.

Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1755
Reported-by: Christophe Lyon <christophe.lyon@linaro.org>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230711153408.68389-1-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index d3d1352c4e..a26200d9f3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -424,10 +424,23 @@ enum {
 
 static bool init_guest_commpage(void)
 {
-    abi_ptr commpage = HI_COMMPAGE & -qemu_host_page_size;
-    void *want = g2h_untagged(commpage);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+    abi_ptr commpage;
+    void *want;
+    void *addr;
+
+    /*
+     * M-profile allocates maximum of 2GB address space, so can never
+     * allocate the commpage.  Skip it.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
+        return true;
+    }
+
+    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    want = g2h_untagged(commpage);
+    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
-- 
2.34.1


