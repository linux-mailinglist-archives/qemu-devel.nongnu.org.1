Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D66BB82164C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3N-0003LC-3s; Mon, 01 Jan 2024 20:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3K-0003Kp-Ac
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:46 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU3I-00072D-TF
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:46 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d9af1f12d5so5211405b3a.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160724; x=1704765524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bGbmvk3+bB4juRZKIWkw0J9XlNF5J8UzTPZ/yNXv5VY=;
 b=XQJ9ASJb+HSGq8F+KtKQyb4Gi6vTlxQCOwxtwbaUkaU6VjmmdNF07qHoHN+fJ8znd2
 WzlDdwHkvIYGKaosDG2rxsAiFbp80Z4KYsh21VWaOBVEVsrHXlxlNFc4bX9JBXCYiSQ4
 j4vnguviUCHlqMlp0pjffckfgxXQ8ulHZVxr3TOAu5ZyJ5H+vbKby4suMfhwOiFDSFXM
 cdq6WgCksfV2bx1jgYuMr6w4oFI+r0Tx4mL1s/qdhCyVCq4GvRTSNNiuHHZEco2GrOSa
 c3rE3B9Py8NwyAZjf3MEhn/LpSoK8dOEkE4uEGxytVECyfAFnwPqfwYX1ITg2OeHUC8B
 ynZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160724; x=1704765524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGbmvk3+bB4juRZKIWkw0J9XlNF5J8UzTPZ/yNXv5VY=;
 b=isf4yx8eqlyX3zpYhSpNwvE8feed9llp9sfHMG/jShKlOQLLS9gbHKmRjkYu+Msq9d
 aP0vcyuoaQ3JBb9Y0UilLR0mW4OLyqYtjWeN8r8Xjk7oTESp2q9wmDnw1hAGdKvHcnVw
 0zuUnX6YjAw1c+uG6BVmpp2Nf8yfn2g4pnm/nWSRCvc/0QLVTqhIzv5LJeaFukORzNZi
 5maYXr/x/14TEMrmiAEeveLPmvMFTPHJGvDq8y/3awV0kYu9ylnZRAm1gVQvH96S13HF
 ac7Ln0n/yo+KC5DB5+ff2e9E4xBsrTI4bevvOHaPlFvdQVcugA3OeDcjcodBYNgAYatq
 n4LA==
X-Gm-Message-State: AOJu0YwFhvT2IgphgvuKVesmHEOrrU+WqAiypZoLa/3i+Wd9Dnc3/Y18
 RZCy66lPRB4Yd92QfvOKGxFAOS6S7n0V1ZPc3G4M1SuZDKg=
X-Google-Smtp-Source: AGHT+IEs6pHKaLYXaeVOlhAnctcsXIKewSB1Pe3TeNMUNLmFV0apX+RD893/3JkslgeN4tbZvgiY7Q==
X-Received: by 2002:a05:6a00:17a9:b0:6d9:b320:94c9 with SMTP id
 s41-20020a056a0017a900b006d9b32094c9mr17630407pfg.33.1704160723757; 
 Mon, 01 Jan 2024 17:58:43 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/33] linux-user: Remove qemu_host_page_size from main
Date: Tue,  2 Jan 2024 12:57:50 +1100
Message-Id: <20240102015808.132373-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Use qemu_real_host_page_size() instead.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 0cdaf30d34..5f217cc2a8 100644
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


