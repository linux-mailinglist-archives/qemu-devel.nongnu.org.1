Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C188B83095F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7bD-00054X-EA; Wed, 17 Jan 2024 10:13:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b9-00051l-56; Wed, 17 Jan 2024 10:12:59 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b7-0005bJ-I9; Wed, 17 Jan 2024 10:12:58 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9344f30caso7493850b3a.1; 
 Wed, 17 Jan 2024 07:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504375; x=1706109175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DvRV9ky6hbAA/ymel8Wc/91GC+rDD7ysLtsRxWyxYHo=;
 b=ZbWmwV/7yxyP8Wz6/1O3hnyilu5BxUBkIFHW52r1psFfqBOyYN6i+XgWdhtuqETT49
 iCrUsQM5eQqkZj7Z90booK+zkQNWCLk2vSloyeSzDWnCxEaX1I9uqGrxabAeCNZ3eZwG
 5zE/vaZ0TeleyrGWkZNpTuSFp3nUpgpdA6uZaCiRPFgK7rU76j/Py/P3dcek3vOyvDx7
 r6s9RBtPHzViuJGC4EwKsw+GgDZzfKRJYOtf5CB9nAUlNJQzwHpF9NAiG7EynIZBxcRQ
 Yl+o/ll7mVzVuIlwCKBblsgEgbzXAJcLF+/mrxFEd+KIk5CXwOfsaCr42qb27U43vzi5
 u+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504375; x=1706109175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvRV9ky6hbAA/ymel8Wc/91GC+rDD7ysLtsRxWyxYHo=;
 b=V2wGghLgl0ILdqYHZaAwnv90tibApIupx62BPCIoRaI6sLIkKzoRYji1ZSmtLdERVa
 3IzwE7PHt84K41tzDL2ix9/vPbVuU3SqylpxcqfxfcJUCvc6NuxsxNkXlO2mIsCdB9MI
 lIaoF86Xs5/+Y9tjLXOKRnTxUc6GcUFwNHbW1fhUuL2HPJT/7sANE11Y1C5urJ/mCqTj
 opkugmokpRtyoAAKieOKCkSQEi4336xGttbOB+6UgEc2nOF0MMqZFhx+k31a9725i/IZ
 q7F14A8V8YeW5i2tCBvaRRDkLVLkAadWni0MH44DzyqEd91G5oaiyk4PcmUVIF4yXrRh
 pODA==
X-Gm-Message-State: AOJu0YwWs4MgbNonRhyiZS76lK/Hu4qjmspmOZlxMKQ1AGAXaHK+zNzN
 2K649QSUr02V4kYYeIgOEW1v7gNZn00=
X-Google-Smtp-Source: AGHT+IGnCKzRanpJSU+yxGchalwyozqhXZikCdSiFHmATyLSjiNCN9NJhtEHTMzBMBAllvraxSG3Bg==
X-Received: by 2002:a05:6a00:189c:b0:6d9:af1f:dd44 with SMTP id
 x28-20020a056a00189c00b006d9af1fdd44mr1405427pfh.9.1705504375515; 
 Wed, 17 Jan 2024 07:12:55 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.12.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:12:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/ppc: 4xx don't flush TLB for a newly written
 software TLB entry
Date: Thu, 18 Jan 2024 01:12:35 +1000
Message-ID: <20240117151238.93323-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240117151238.93323-1-npiggin@gmail.com>
References: <20240117151238.93323-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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

BookE software TLB is implemented by flushing old translations from the
relevant TCG TLB whenever software TLB entries change. This means a new
software TLB entry should not have any corresponding cached TCG TLB
translations, so there is nothing to flush. The exception is multiple
software TLBs that cover the same address and address space, but that
is a programming error and results in undefined behaviour, and flushing
does not give an obviously better outcome in that case either.

Remove the unnecessary flush of a newly written software TLB entry.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 949ae87f4f..68632bf54e 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -808,13 +808,6 @@ void helper_4xx_tlbwe_hi(CPUPPCState *env, target_ulong entry,
                   tlb->prot & PAGE_WRITE ? 'w' : '-',
                   tlb->prot & PAGE_EXEC ? 'x' : '-',
                   tlb->prot & PAGE_VALID ? 'v' : '-', (int)tlb->PID);
-    /* Invalidate new TLB (if valid) */
-    if (tlb->prot & PAGE_VALID) {
-        qemu_log_mask(CPU_LOG_MMU, "%s: invalidate TLB %d start "
-                      TARGET_FMT_lx " end " TARGET_FMT_lx "\n", __func__,
-                      (int)entry, tlb->EPN, tlb->EPN + tlb->size);
-        ppcemb_tlb_flush(cs, tlb);
-    }
 }
 
 void helper_4xx_tlbwe_lo(CPUPPCState *env, target_ulong entry,
-- 
2.42.0


