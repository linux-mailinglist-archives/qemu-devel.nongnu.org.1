Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B166F74C732
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAl-0008TJ-Qg; Sun, 09 Jul 2023 14:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAd-0008QE-Iy
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:07 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAb-0000jI-RT
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:07 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82d9cso39246225e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927404; x=1691519404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wgRkP+eTRpLGmcULxLxPDzJcG5/xUKxzegn/jzfjvQ=;
 b=BYpwpxBmTs82k5/T6au5xZFWJuFUH7T3jVewYQgZ86kR3kuz/bFDLQAMt5yUC/f+Hv
 S6gnfqiqa/ODqL36pAqv41mNxCXMbDJzfBkBg2KATee+v4N482nEJimST0Bgu/tbMMmq
 5jUcgbataQfFN+2wa1aF6D/4OonEQI3EFGevVHdgiHppwnUQU2Axu+YqX3OHZ5fJNpzY
 octySGu36QuphRsoOhL1Z/2XrRlxzhUS8wCdIq/dr27D0lQS1itxjtlwoX0DFgXIaVSf
 Vfec7J62kPodI9rTDiwFQFY135v7U9NrNU2ORDj6fv1G3grrGfyV8e6vXnO8EXANuJsZ
 XJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927404; x=1691519404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wgRkP+eTRpLGmcULxLxPDzJcG5/xUKxzegn/jzfjvQ=;
 b=NWGB5GgizkzEyum3UFQlj/4pBCPfUNMUKrnIFQGZCQZG3WmTidDJPJAlaUgm0uZNfy
 XMOV7JbVU+6FOz2Zw3h4iPibWqCINcxnBKo9KL5Ld78ATlBrHVRecEgp7Y9tK5a3JOD5
 r5Kdlt7efI+0y80e6gi3XVgaFSwn75ERxsmmQqjfs6qEKQwwZkVhW8ee0ib9rfNIfPhM
 1PYdY+vQv+RmbhMHsJulRRQxLug8uAqiP14i94+BoHoqkCzlbKP7h9T/quXCM/Dh3ssw
 nYMnUk7/e3G8qT11kRiEF1TDAbhJkOgrwojpgMn93zSEi+dRNGsx2FlHzhY0uYNMsUwv
 U0tA==
X-Gm-Message-State: ABy/qLaR+4tjkz/nN+b3exrE1Po4Y4Fdq9Zu5n8G8+y/AePwj9gsNUBn
 a5nIVF+KIHoGubnxls1QcOLcuIhJAU6IfeZU6d75iA==
X-Google-Smtp-Source: APBJJlFdAporhpCqOS0lLvGM3l5qLzm/uLKdAbYhII9K14YP7cquzsaDrEfhCG7HOGYFQXCJuQe+Pw==
X-Received: by 2002:a7b:cc86:0:b0:3f9:c8b2:dfbd with SMTP id
 p6-20020a7bcc86000000b003f9c8b2dfbdmr7986664wma.19.1688927404614; 
 Sun, 09 Jul 2023 11:30:04 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 17/45] linux-user: Fix do_shmat type errors
Date: Sun,  9 Jul 2023 19:28:45 +0100
Message-Id: <20230709182934.309468-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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

The guest address, raddr, should be unsigned, aka abi_ulong.
The host addresses should be cast via *intptr_t not long.
Drop the inline and fix two other whitespace issues.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230626140250.69572-1-richard.henderson@linaro.org>
---
 linux-user/syscall.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 90777c5833..8b12774fba 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4529,14 +4529,14 @@ static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
 }
 #endif
 
-static inline abi_ulong do_shmat(CPUArchState *cpu_env,
-                                 int shmid, abi_ulong shmaddr, int shmflg)
+static abi_ulong do_shmat(CPUArchState *cpu_env, int shmid,
+                          abi_ulong shmaddr, int shmflg)
 {
     CPUState *cpu = env_cpu(cpu_env);
-    abi_long raddr;
+    abi_ulong raddr;
     void *host_raddr;
     struct shmid_ds shm_info;
-    int i,ret;
+    int i, ret;
     abi_ulong shmlba;
 
     /* shmat pointers are always untagged */
@@ -4592,9 +4592,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     if (host_raddr == (void *)-1) {
         mmap_unlock();
-        return get_errno((long)host_raddr);
+        return get_errno((intptr_t)host_raddr);
     }
-    raddr=h2g((unsigned long)host_raddr);
+    raddr = h2g((uintptr_t)host_raddr);
 
     page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
                    PAGE_VALID | PAGE_RESET | PAGE_READ |
@@ -4611,7 +4611,6 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     mmap_unlock();
     return raddr;
-
 }
 
 static inline abi_long do_shmdt(abi_ulong shmaddr)
-- 
2.34.1


