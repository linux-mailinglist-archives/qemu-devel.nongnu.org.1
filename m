Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E078116A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:15:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX31f-0008Cp-9C; Fri, 18 Aug 2023 13:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31d-0008C2-3c
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:41 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31a-00080g-Uu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:12:40 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso8772685ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378758; x=1692983558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0oPq687I8gk8ySwy0mlXFIb93Ar57v3iR3Wlm9NlHFI=;
 b=vmc2IQJLODukeOhaYvmTN11MG4mOWAmMCBhQ0KRG2VM7N3NCamAF+7tP2uAl3FLb54
 hri7BHSsknudn1omdjnVvqEFr8effzfEdlK6mOWCx0we8yog8XRFu/owqSo4yC06+gJB
 1w73kJOlxDbveucvskmTCuRbDLwP0n6k94cJil9192hTqQ8btAThu4QHto0XkUYw7UvY
 3xv5JwLrR9TQW45XKDlYOW9cfmLvX/+O0B/6empgghzUlcY2abMCAHReQvE2zftrpsQ6
 csElQYUo8wad4RFLw1pBDjy7IZTL4p3MmDjYRflX38uKo9BcATWuj6WVmuz70r5bdx01
 3aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378758; x=1692983558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0oPq687I8gk8ySwy0mlXFIb93Ar57v3iR3Wlm9NlHFI=;
 b=LxjRWYhqlhWEZ3YllZ09d09sV0AYUlABNa7tKO9XwS5/ySv273wvr3P4T4lerWMssW
 7qG3eHrX7sBzRSDtcDRdRvzL5/OKgRiS9iaGuSkGpTx1ntY9P0DpARIEsf3kye402ZCK
 YVcU1LReIsyV1wmz9VItwQc0z3NZwF9j6F18rF0150NeRMnsPWu9SyfNDTzhBGxHKR0g
 +QD5SAlGHCcz/HqQKbg1h23VRyxyCOFv4yaL/Pfmsx3rhjPD2Ac0qCLfwM2KPLg/94ol
 6RQa3apuuxFWNQA05J0h1GuzKPecbG2KozQsLENmldqCtED4gKrRyKL20IFcHFa8QCg0
 lB1w==
X-Gm-Message-State: AOJu0Ywo0VIq+0vz/Y+arW/ExkECaRarOmvzPW/n9Q2UVYBTw7tV36OQ
 nuAlgYRcsb+gpUDLPcTmSvMn51t0xKvU1UvG9sk=
X-Google-Smtp-Source: AGHT+IF+Eh0Wt5jXA22SxkmTbqc1UWASK+NgmdOUSoGI90aQ9Nfm3cWsvxVls5a8UpoICvdlNKPPYg==
X-Received: by 2002:a17:902:be06:b0:1bf:1320:9743 with SMTP id
 r6-20020a170902be0600b001bf13209743mr2827746pls.45.1692378757674; 
 Fri, 18 Aug 2023 10:12:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/33] linux-user/nios2: Remove qemu_host_page_size from
 init_guest_commpage
Date: Fri, 18 Aug 2023 10:12:00 -0700
Message-Id: <20230818171227.141728-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Use qemu_real_host_page_size.
If !reserved_va, use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1da77f4f71..b3b9232955 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1375,10 +1375,14 @@ static bool init_guest_commpage(void)
                  0x3a, 0x68, 0x3b, 0x00,  /* trap 0 */
     };
 
-    void *want = g2h_untagged(LO_COMMPAGE & -qemu_host_page_size);
-    void *addr = mmap(want, qemu_host_page_size, PROT_READ | PROT_WRITE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    int host_page_size = qemu_real_host_page_size();
+    void *want, *addr;
 
+    want = g2h_untagged(LO_COMMPAGE & -host_page_size);
+    addr = mmap(want, host_page_size, PROT_READ | PROT_WRITE,
+                MAP_ANONYMOUS | MAP_PRIVATE |
+                (reserved_va ? MAP_FIXED : MAP_FIXED_NOREPLACE),
+                -1, 0);
     if (addr == MAP_FAILED) {
         perror("Allocating guest commpage");
         exit(EXIT_FAILURE);
@@ -1387,9 +1391,9 @@ static bool init_guest_commpage(void)
         return false;
     }
 
-    memcpy(addr, kuser_page, sizeof(kuser_page));
+    memcpy(g2h_untagged(LO_COMMPAGE), kuser_page, sizeof(kuser_page));
 
-    if (mprotect(addr, qemu_host_page_size, PROT_READ)) {
+    if (mprotect(addr, host_page_size, PROT_READ)) {
         perror("Protecting guest commpage");
         exit(EXIT_FAILURE);
     }
-- 
2.34.1


