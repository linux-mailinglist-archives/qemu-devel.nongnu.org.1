Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F0D83095C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7bK-00059w-Uy; Wed, 17 Jan 2024 10:13:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bG-00058u-NU; Wed, 17 Jan 2024 10:13:06 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7bE-0005c1-V1; Wed, 17 Jan 2024 10:13:06 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d99980b2e0so9160002b3a.2; 
 Wed, 17 Jan 2024 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504383; x=1706109183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT4TueAjAxWUcZKjazuJQy9Cz24ojP+pQigBw8d5N74=;
 b=IZl5ZyKtW5uYp76qTp4B44qZ4bBFioRYG5MNf0xNjPCBcdD/MYaf+qyQFl6tZPEbN2
 +aartTNvMxsqinrdKnqyZOWmwwBIbJ46x2QrM/rbdowkWW1xDH3LUFkoP1djfJ23p5jg
 uTAjGViyVkP1Sm/tCmMANc9Y4UbmaRNBLjr0m7OlDK/QJF4V4OSNfGy8BKy69DUS5imV
 pfZhbRygCvKINMkS2Y67OtyP9OybeO8/CH/WXEmpHRrBlzotwywzS0Wr115WPYVnY29F
 yn2uPRMRSqJ838mfPS6Kysg3T9sSduW+4qxl3afmXHZhRfxvGBC8Lrspqzi1WsE3RSNn
 x0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504383; x=1706109183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WT4TueAjAxWUcZKjazuJQy9Cz24ojP+pQigBw8d5N74=;
 b=WDn4KZP5SangeC7XxuBkdAtt+iQZ1Wq4O2s9ystRfAzf8sPr0ZSZIB7vAoDFCpOC3V
 V+E3d2fJ83yIAhKg5MzTz7WYGDLaiMqbMM4Qrfebl/DP2eXICRMN+J85VjBugn/i1yuP
 M81BDPY9gH2ULtw9IjX8DvOLPbgcAIMHLkAyyAyVlkzHtdsVNTVkasQGv//+/OpoijfH
 IOuBZHhHApAFrg/W8T0Urndg09W9/IuANFq2a15fGx30rmkMJ1huVXExJaEa5tr0nEmf
 RIbpbROeLQeBSWo5ESLA/ouVgOUF3DwhxESShXMnf17vTDBAb6MI5YVEyHbSavP4Kl+I
 k5Gg==
X-Gm-Message-State: AOJu0YzOf7BZibfvN9s99+WIBsVwBRW2LFImCfmKptngrzN3JlW64LFv
 ipi+usN5DaVB3v+/HISiZKw7XrCK1rI=
X-Google-Smtp-Source: AGHT+IEfZbLzBIcG9HciiXKFNYeXXFWKHMP0zwJ0NxJoPLkub4ojF21LlDyrI3ncoHRfXUAMZofkmA==
X-Received: by 2002:a05:6a20:394e:b0:19a:2f04:ed89 with SMTP id
 r14-20020a056a20394e00b0019a2f04ed89mr8556670pzg.40.1705504383039; 
 Wed, 17 Jan 2024 07:13:03 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:13:02 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 5/6] target/ppc: 440 optimise tlbwe TLB flushing
Date: Thu, 18 Jan 2024 01:12:37 +1000
Message-ID: <20240117151238.93323-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Have 440 tlbwe flush only the range corresponding to the addresses
covered by the software TLB entry being modified rather than the
entire TLB. This matches what 4xx does.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 923779d052..ba965f1779 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -864,7 +864,7 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
 
     /* Invalidate previous TLB (if it's valid) */
     if (tlb->prot & PAGE_VALID) {
-        tlb_flush(env_cpu(env));
+        ppcemb_tlb_flush(env_cpu(env), tlb);
     }
 
     switch (word) {
-- 
2.42.0


