Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120857174EA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D47-0007NZ-Eb; Wed, 31 May 2023 00:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D44-0007Lv-Cu
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:00 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D41-0006Hf-RF
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:00 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-75b0f2ce4b7so334366285a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505837; x=1688097837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g9Z7ehG7+swOH6zB5dODu6bYg//xIYbQwbOdJN6xAFw=;
 b=nEz0OSDvPXLzVXOgg7OFOgSwfgRwNJHW9XIFd34CZWk2KMXDYjiZojRPMLAeOtBIGD
 3/LqyuTW8PZ8ob1EfydMITubWgnt4LWRwoZBB5mcNW7ZOcPiWXADFLGRubmGLOYhwzuc
 ShYoPb7XnjX96H4pkTDNF6oB55NLMdHmQnzwQ8YzCGPAh/UuwboK3M5EeBMkcO7Ndnhi
 a/cZTA/McaEPShcBdEODsNEmBqp9gBY/MXylEx5pjaDPEgtuzUYNwR2bWEabmUyNXt6C
 ziEFhjzfzxk9UvomXmVKd3UZNvLy8d8/dmijZLoSzWPIOFTeWZr7UkSql4XuexT3cPYq
 /smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505837; x=1688097837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9Z7ehG7+swOH6zB5dODu6bYg//xIYbQwbOdJN6xAFw=;
 b=TZyHnMadLj5Wlfs2YxjhHH8fQWaISp0rH+qZlwf33weOpJNQsZfX09t4tUO8qjFOOK
 GJPZRiQ0CMm6R2UP72QoQ0OCzRPYC9UWN0OxqQy79o2i7eFN6CExGCoDd+Fzs0FmahCS
 CeaeEOSXDCK1pT7hS2oOInC0cu5bVCJ+kMYpCIwFqcufx1YF9gVFgoR/UJW6c7jRO7NO
 PsWoLE2B22eA9Q9azH8eQ89bsaATWGUAwSgsyBfcjgo7qhn1TzXId+nrbOLOBJZSOvlw
 0NFYD21MmS82z8vUdRa410F6JAGCBdmF7erAX+4z2bg6wEcRJQLItKagOHtbnFekM6fo
 BWqQ==
X-Gm-Message-State: AC+VfDy1fdWjSpPHq/QomdPJmaAVCw9WvHOIVdS3TeUk8FRN1642UIqO
 l03FcXWPPnQMzvvOXK5CY6bLM5yS8tQ+7ME3+x4=
X-Google-Smtp-Source: ACHHUZ51kpX3rnYsazrs9mPEDVOVVa/54j51viSnSc3vA1xJ1nA+IW768O1G19Du67xmDcLpQHxNEw==
X-Received: by 2002:a37:489:0:b0:75b:23a0:d9ce with SMTP id
 131-20020a370489000000b0075b23a0d9cemr4333924qke.36.1685505836842; 
 Tue, 30 May 2023 21:03:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 33/48] include/exec: Remove CODE_GEN_AVG_BLOCK_SIZE
Date: Tue, 30 May 2023 21:03:15 -0700
Message-Id: <20230531040330.8950-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
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

The last use was removed with 2ac01d6dafab.

Fixes: 2ac01d6dafab ("translate-all: use a binary search tree to track TBs in TBContext")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f01c7d57e8..698943d58f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -467,16 +467,6 @@ int probe_access_full(CPUArchState *env, target_ulong addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 #endif
 
-/* Estimated block size for TB allocation.  */
-/* ??? The following is based on a 2015 survey of x86_64 host output.
-   Better would seem to be some sort of dynamically sized TB array,
-   adapting to the block sizes actually being produced.  */
-#if defined(CONFIG_SOFTMMU)
-#define CODE_GEN_AVG_BLOCK_SIZE 400
-#else
-#define CODE_GEN_AVG_BLOCK_SIZE 150
-#endif
-
 /* Hide the qatomic_read to make code a little easier on the eyes */
 static inline uint32_t tb_cflags(const TranslationBlock *tb)
 {
-- 
2.34.1


