Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7C270DED9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:12:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1STi-0008ST-9k; Tue, 23 May 2023 09:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSX-00057f-03
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:54 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSV-00038b-DD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:52 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d3e5e5980so4971099b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850030; x=1687442030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eu9NQtb2FUQWFu9rVl+RtTj4i7Vm9wmVlC22z1EyvKw=;
 b=E/wbr1Urw+1b0wYhdpsyx/a7B28ufV68QreggBfw9CTKCvrSGbaTy9GadpwxTiziAT
 tuwFgFh7Bi+BGQyiJp97KBmZ8hjglsbedBljdmH+NLmEvF0Rdz+a9Ld6oJNjHVgW62uL
 BibcwdonmPwiJnFztqvPeomjJym1LbFEcy74BXyFVHUuhva2QdW1KaDNV9Do0Y+zx80m
 ROMywTwWYEPtwxX1iqaTne6z8ILx0Gx/2zZmRUf/Dhk4yzSa8Z0yw3WYg9kY40G1HvzJ
 vVTyJxWcJlHLvJGk9xkPlsSIjRN5rvYfgesibMBDB9vZKYbpn8XeoX+eL4nA+vNkHLzh
 Abrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850030; x=1687442030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eu9NQtb2FUQWFu9rVl+RtTj4i7Vm9wmVlC22z1EyvKw=;
 b=c0naECXXRQVZeNRP1PmiskGW4hdWPixO+YKkSitZFzsfjWVst3roVuLExxqQaS7xIa
 UT87mtc6zZM3bf2aWNvrjS2axBVMONWmQyHND6JoGQJhn1t2hT/XF4i7Ir143OgImhLT
 cQYTctTJoErAQX6YcwX5ajamd+Zj2uBqfGe4jXkb/Jw2S6m9E5578vqMvMpxEZ0WLI1N
 uI670kUbMQkmnyBs/XroIO1AlUVhDsISUYIm+8JYpCzKE0qdrVoFatUahYhuw3Tx0/je
 3H7jZyBI0Ole/pjSGqyMqiqS12+BjVrhLXdgGNRxAbBOvrSr90LXUl19MASvUvo+vk96
 UEfA==
X-Gm-Message-State: AC+VfDy4fAEqYdc19vYDgq0PrdKPc1V32NzkdRPaJPfbBUWOBAwjVAgA
 h8Kzfh3ORqDOSljzChp5GZ0DauTfiujANA+OKSM=
X-Google-Smtp-Source: ACHHUZ4e7SizPq5LUd34k/B8B6T8qQ7M+zvXFA/kg2LpiN63Nf0Uu+c5/+5d4W8sDodHgeNL9F5PYA==
X-Received: by 2002:a05:6a00:2d04:b0:64f:4812:8c7e with SMTP id
 fa4-20020a056a002d0400b0064f48128c7emr1527332pfb.19.1684850030153; 
 Tue, 23 May 2023 06:53:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/52] exec-all: Widen TranslationBlock pc and cs_base to
 64-bits
Date: Tue, 23 May 2023 06:53:02 -0700
Message-Id: <20230523135322.678948-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 accel/tcg/cpu-exec.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8c8526d9f8..58ac1a91c2 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -519,7 +519,7 @@ struct TranslationBlock {
      * Unwind information is taken as offsets from the page, to be
      * deposited into the "current" PC.
      */
-    target_ulong pc;
+    vaddr pc;
 
     /*
      * Target-specific data associated with the TranslationBlock, e.g.:
@@ -528,7 +528,7 @@ struct TranslationBlock {
      * s390x: instruction data for EXECUTE,
      * sparc: the next pc of the instruction queue (for delay slots).
      */
-    target_ulong cs_base;
+    uint64_t cs_base;
 
     uint32_t flags; /* flags defining in which context the code was generated */
     uint32_t cflags;    /* compile flags */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index bc0e1c3299..9fe07c31fb 100644
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


