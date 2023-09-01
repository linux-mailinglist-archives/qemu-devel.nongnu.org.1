Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F3678F70D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtp8-0006Y5-6c; Thu, 31 Aug 2023 22:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp6-0006X6-Fd
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtp4-0001QL-9i
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:23:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-56963f2e48eso1134650a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535025; x=1694139825; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMSfIZM5KDQOW8rzGrPmwonqS4UNbZW6sqmCOtQy3AM=;
 b=ewC4cww5K2LjJSWEuc2hv5DOMcp3VBNVXgrbIc4na5J650IR9g0Y2IlR/MeYRzUbXJ
 j7vqOJ3a+vHQtj9ynnPnKsKuaavu302aAg+IMaUW9SHGaBsDwiwMI9+zVr6HkbNou/V0
 LqWSEvfIO5PVm+siFPNK7prUxvfrmEAfhsNEFS1ER2eNVN5ma9C7syCZRgTF+T4/YhnW
 Xne86JvU4APCYSIrkU1qR0G4tfEiasuaBST87dE7pk2oogKzCQ5xM+IiYbPHxH8A+w7w
 JAJKQBxp7yrv3UjlmETyBXnfxe6dT5iw8Am+BovOXCwOpzurkNf0vkR1QMriOtEeMLCQ
 Lo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535025; x=1694139825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMSfIZM5KDQOW8rzGrPmwonqS4UNbZW6sqmCOtQy3AM=;
 b=CGEHfzYYyaZiZjRQV+HWfThz8gKK9hlcMX1eVSq6GyhoKZpkkpqBclLwM2JLzI++iw
 VQQOkgXmPOgO9vWsUdOLsTjaJUohqqVOR+1y36x8rxusujHWo24ELOn8mqOI6njUtJsh
 jw0+i49z6hbXOR81lqHu8qt+K2TIkye7lcw+TzGWE0QZhxP2EAxq1IZ8MMWPfe6KaJ55
 tFAEfvPWSKzhU9bt+AVGOuHe1UDfUXupSQsMEOKu7BIGYLEe2Vhgls23cLpvceqB6Oht
 eZWGO9ARxCd/nqlvm/msVUpCaTnLjogkxo0DdweBOWhKyKU/zN/WBL4+H9AEcKfNBohh
 c/kQ==
X-Gm-Message-State: AOJu0YwJPpf1Q5tmnMOGkw8PkNmUKUxhzNjg6ArXIIOc+G3ha/w/+9FH
 RmCkChFpcWGGH8K3tf1XyAH7vW6gw7yoEwu2+d8=
X-Google-Smtp-Source: AGHT+IH0N69Ag1dwmMoj4SyP8SvuFPxoeqTtUQhQnl9WEsCK1HEZ3Cs2KVyobtfYFf5NYVHnCZClXw==
X-Received: by 2002:a05:6a21:99a5:b0:14e:6c19:60f6 with SMTP id
 ve37-20020a056a2199a500b0014e6c1960f6mr1616975pzb.50.1693535024880; 
 Thu, 31 Aug 2023 19:23:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 15/33] linux-user: Remove qemu_host_page_size from main
Date: Thu, 31 Aug 2023 19:23:13 -0700
Message-Id: <20230901022331.115247-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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


