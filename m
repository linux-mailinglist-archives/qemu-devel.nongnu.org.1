Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D62E754900
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfiy-0004WR-Q9; Sat, 15 Jul 2023 09:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiM-00044R-6h
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:38 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiK-0001Gh-7b
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so25771915e9.1
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429213; x=1692021213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr74WqM5fLrf+RSkbW96g9irEI/4kt9CeJO9GueF4Ho=;
 b=ytlbjaV9E9M79C03Q8T2CryOSi0CnEjt6brGkPXctqR7npFgD/ETR5dkvURNFI9G7E
 0BWGsGJEAPPGzAQnMCYZ4Y1avwTQnks0xP8h3oME8LAH1WYEaSjO/gEpVnyYlUQsew4k
 j3b7gjmgjoDt/VyufSO5HiFlJetww1cGAI50rbiR/BCTzXB81IzJZ7fYxDfDcqT4URBc
 s56jY2c0+IGXOlwnDsFXIboj+0cU8SHO8YsK8fhefUQan5Eaenl5xKF93T5/c1KZTBv9
 qM3yRYGSOFS+gUf83zL7KUTpbGLR3V9dqDBGnbUTMt3KSPeDxW27JNxVRkN+tfIK4rfG
 GvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429213; x=1692021213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr74WqM5fLrf+RSkbW96g9irEI/4kt9CeJO9GueF4Ho=;
 b=hvnAMUw0r4zS1UCBbqH4rGPChB9kkjoNrSm/v3+KStTChzZRrQDrquDpuEjnK73sTV
 vwGsRRSY15dTuzj1EinwfXlGu3YAqZBDB2Va0YvBExOqQw7WHagcWE4j7SjVsH8TFV+U
 +Z6/vZdLIYjd54KUNcE/UjCk/6xWV2tLy3R18SYKbDNJpFkO/LDi8yh9zDCBXvsxdUXZ
 cnhf+IYRe6eYapo07qanM5wNO8C4gvOylzPADkRLe39k4zi4tWuwZo4CWB7+pwLgX1Df
 8749pMwtmnaOlQLD2U8syTFkoPf6F6i24LPGbKUOr0CHN2iGAqJy9LJrxybnQyBfT4cP
 P3ow==
X-Gm-Message-State: ABy/qLblOn/9jjiCSVj87SUDfNqfOTOIozmud6QHb3x8WFGbD0QDrYgt
 t7n+HEvX8+Kvexu6iBAMsxNFVs/NO4fQ83I/oYciBg==
X-Google-Smtp-Source: APBJJlG5FOsOZSzkS2B+ejEe8Db5eUc4muDJUwGi20lpFVsVfVbL+fn5OmzQGdx7M305FbPUgg7+Gw==
X-Received: by 2002:a05:6000:c4:b0:314:e929:bcb9 with SMTP id
 q4-20020a05600000c400b00314e929bcb9mr6528191wrx.57.1689429213604; 
 Sat, 15 Jul 2023 06:53:33 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 17/47] linux-user: Fix do_shmat type errors
Date: Sat, 15 Jul 2023 14:52:47 +0100
Message-Id: <20230715135317.7219-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
index c15d9ad743..b78eb686d8 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4539,14 +4539,14 @@ static inline abi_ulong target_shmlba(CPUArchState *cpu_env)
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
@@ -4602,9 +4602,9 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     if (host_raddr == (void *)-1) {
         mmap_unlock();
-        return get_errno((long)host_raddr);
+        return get_errno((intptr_t)host_raddr);
     }
-    raddr=h2g((unsigned long)host_raddr);
+    raddr = h2g((uintptr_t)host_raddr);
 
     page_set_flags(raddr, raddr + shm_info.shm_segsz - 1,
                    PAGE_VALID | PAGE_RESET | PAGE_READ |
@@ -4621,7 +4621,6 @@ static inline abi_ulong do_shmat(CPUArchState *cpu_env,
 
     mmap_unlock();
     return raddr;
-
 }
 
 static inline abi_long do_shmdt(abi_ulong shmaddr)
-- 
2.34.1


