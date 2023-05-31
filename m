Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BA7174B9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4M-0007eh-3X; Wed, 31 May 2023 00:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D43-0007LA-6r
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:59 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D41-0006Fv-Ic
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:58 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-399e9455e9fso1713572b6e.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505835; x=1688097835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OKWv0ieP0cnX8M0qN3oPVRtpmpKInPrk4mXKhVHHYcs=;
 b=lsR1PJ7kUzWlaca+7t7PUz/kuL0A0M5tNqnNvKizXW+bUEOYCsnUUyHkPKqHlnmQ1d
 h/vOg6Nv1ukWO1UUgXFmNOjCntJ84q+7/sL0mII8ND4JGOWZXTqcoFHtvA8dv4JsxS6s
 kdwvBkNBoBDzMZ3ZKKWVuTSJPiKfQ5tfHAPml4BCImR7f3Pkq+XGa6greEt1Y1SIkggc
 B3KG7uR85CJpOUb9v4FwHmCL0s1yGeO3DfwgwATwbeYvjbsssvSUPpNjIjr9b7F1RmDc
 jzNDuDyhN+zXsTSkPr8DxoEUtIawM2v8SVlneydvxmFSqFJv6DpzwNS8a7neQMja69qq
 H1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505835; x=1688097835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OKWv0ieP0cnX8M0qN3oPVRtpmpKInPrk4mXKhVHHYcs=;
 b=ICYUCi1EVcQ2VU2z2aumBCHT9aV5NVgLAsstbNtl+Dha+o6Ix/n7oOhi+nbnMKwwnZ
 Sc3fO0lOrDDNeWteUfXwoXnY7HjwZLnb3pUzbr+PBUqYoc/9xx8WtwNnf5d5i5EQ1V2M
 afxWS9RmIuo9m6RyZ3Nuui1NNAfdkwIftzDDr0T/y4+RNywZV9lFNKdj9z8NWo/c9f1C
 pPU6E4OnSfNMpYP237YzeZ/2nUiZsbfP7W+MsSRbaXMBR3pnvhXisjuO+rKOFqpWE1ul
 q5wNqybuFAGKnnctyxlQL574OFNbiGMa4/B5G53uU2pbDPrMRVWhiHeSLKFlMwLKpbkR
 ks6w==
X-Gm-Message-State: AC+VfDzk7R13YU5TjOOl+1gC+doejeBSkm7uX2hefyfcdgHWajUMV2JY
 RgPUcZ2sXwz2Ygw3CC9hIfrLdDDO8lsj/JcvJa0=
X-Google-Smtp-Source: ACHHUZ7yuPJpLyGEbNvLHfMbYzamZBc/3h0hYaydFYWFBwOKUZsl3ebr0KjfBOv+dw/wjBxCJVIk6w==
X-Received: by 2002:a05:6808:bc3:b0:396:d10:43a0 with SMTP id
 o3-20020a0568080bc300b003960d1043a0mr2990493oik.46.1685505835153; 
 Tue, 30 May 2023 21:03:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 31/48] exec-all: Widen TranslationBlock pc and cs_base to
 64-bits
Date: Tue, 30 May 2023 21:03:13 -0700
Message-Id: <20230531040330.8950-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
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

This makes TranslationBlock agnostic to the address size of the guest.
Use vaddr for pc, since that's always a virtual address.
Use uint64_t for cs_base, since usage varies between guests.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 accel/tcg/cpu-exec.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0d00541aca..a09d754624 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -516,7 +516,7 @@ struct TranslationBlock {
      * Unwind information is taken as offsets from the page, to be
      * deposited into the "current" PC.
      */
-    target_ulong pc;
+    vaddr pc;
 
     /*
      * Target-specific data associated with the TranslationBlock, e.g.:
@@ -525,7 +525,7 @@ struct TranslationBlock {
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots).
      */
-    target_ulong cs_base;
+    uint64_t cs_base;
 
     uint32_t flags; /* flags defining in which context the code was generated */
     uint32_t cflags;    /* compile flags */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 0e741960da..f1eae7b8e5 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -302,7 +302,7 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
 {
     if (qemu_log_in_addr_range(pc)) {
         qemu_log_mask(CPU_LOG_EXEC,
-                      "Trace %d: %p [" TARGET_FMT_lx
+                      "Trace %d: %p [%08" PRIx64
                       "/" TARGET_FMT_lx "/%08x/%08x] %s\n",
                       cpu->cpu_index, tb->tc.ptr, tb->cs_base, pc,
                       tb->flags, tb->cflags, lookup_symbol(pc));
-- 
2.34.1


