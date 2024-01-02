Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF41821643
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:02:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU37-0003Gz-MI; Mon, 01 Jan 2024 20:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU34-0003GZ-Ds
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:30 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU32-00070B-Uv
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:30 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so6727821a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160708; x=1704765508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZDwDZzgZPSCJA7Iemq6JqoeDjmqj1wl0Di9VaTuvxi8=;
 b=k+BMJAhji4QtB6AlWIpbaNLh3A+Z1M+I4MDVRDlhV0r4IQGCdQFX4MBXTdUCN99il6
 BDLKdN/PZrizXIYQQ6HQng2grRIjJ50ngsXg8xRsGZomChe+O9Kd++vAoj2sM5pDxY2Z
 azbC8D3gyqwlQC0SG23u9MInKDxS/a74V8qDOK4alY0zXduV/E5pKBXmMMtuZFrNjQY1
 VWywLsaOPZIQCDXH/DRuuxTGQctUakDX2BAVeoBpqWzGs8cqptQTboilrk7ME4dUeluV
 BvkXrZbpbegJi1B9EveU+DKLVLvn04qHsAefMQkiThfFqUxum5gBiFrWgsnzgGPeISoU
 Mrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160708; x=1704765508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDwDZzgZPSCJA7Iemq6JqoeDjmqj1wl0Di9VaTuvxi8=;
 b=vMPOWj1LF204snVDetuRNIboGB6fZTSTYpGnDh0tsc8x8a/FI0gSa6iHY3mdT8ymp5
 N+TgwRU+GZ1GY7DcZQMjpQnH7HldyHPNJ9GdIO05CB0jBN4d7RJ6knd8S0BIjnhaC9EC
 1TomD2ekqbmMqdqivb/79f1Stp8BLyEH4E4A9FMx8WcZXNwMEfsswlQNAi87kz1/EAxx
 ewIxM7mrybO0VCaHaDjPX8NV9MUymxgckjpHIayGzMTvmXTtffrYmsFuJfwL5w7eN4G1
 ZhBixHSERbBDgLli4lV6ulW1b58lrs7h1JbprOv9YcFtjI4p7fv3cDUw2Zt4/2hK5sLx
 N4jw==
X-Gm-Message-State: AOJu0YxkYBpwpsWrnnSUO3W0D9L38I6tKDZyH0Kn37dgPrjxqlDX7opj
 kyrNPPQzCrvkRLNZAeGx+KgLAL4lMWUjMgGSXblPEUTP4Hc=
X-Google-Smtp-Source: AGHT+IE+o+9kMFWMMIBfJAl3GjjWpR2UEpfrPW9oTQPzc47uIEhx8bpL4Z5joWOworC2H1zkZs7PHg==
X-Received: by 2002:a05:6a21:1a9:b0:195:d8d9:a193 with SMTP id
 le41-20020a056a2101a900b00195d8d9a193mr14856787pzb.77.1704160707759; 
 Mon, 01 Jan 2024 17:58:27 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 07/33] linux-user/arm: Remove qemu_host_page_size from
 init_guest_commpage
Date: Tue,  2 Jan 2024 12:57:42 +1100
Message-Id: <20240102015808.132373-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Use qemu_real_host_page_size.
If the commpage is not within reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4fcc490ce6..2e2b1b0784 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -459,6 +459,7 @@ enum {
 static bool init_guest_commpage(void)
 {
     ARMCPU *cpu = ARM_CPU(thread_cpu);
+    int host_page_size = qemu_real_host_page_size();
     abi_ptr commpage;
     void *want;
     void *addr;
@@ -471,10 +472,12 @@ static bool init_guest_commpage(void)
         return true;
     }
 
-    commpage = HI_COMMPAGE & -qemu_host_page_size;
+    commpage = HI_COMMPAGE & -host_page_size;
     want = g2h_untagged(commpage);
-    addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (commpage < reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
 
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
@@ -487,12 +490,12 @@ static bool init_guest_commpage(void)
     /* Set kernel helper versions; rest of page is 0.  */
     __put_user(5, (uint32_t *)g2h_untagged(0xffff0ffcu));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
 
-    page_set_flags(commpage, commpage | ~qemu_host_page_mask,
+    page_set_flags(commpage, commpage | (host_page_size - 1),
                    PAGE_READ | PAGE_EXEC | PAGE_VALID);
     return true;
 }
-- 
2.34.1


