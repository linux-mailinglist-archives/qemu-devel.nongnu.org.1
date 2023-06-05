Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFAF723148
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:26:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd5-00021U-FA; Mon, 05 Jun 2023 16:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcn-0001wr-VU
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:23 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gck-00046c-Nl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:21 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6549df4321aso2693798b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996177; x=1688588177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+U9mZ3FA6jaY40YGmde+3aLN2iMAzeCKrJsFXalAAtk=;
 b=xGp9/qjmvB3DJS3BK5UocnC0PdvuJo647Iz7f4D6AOe0LDN5HD+dmAU70dJLJF4mb+
 L8mUyyOgZ7Bd4vVL5kyGpaSGEWcpZsQfkC287SRIRYB/CaceQ5R0F4m5MgIRWeI9kZMk
 rZ8IISg2b9xm7/7qB2h08KDYGhrzYcEY3MHbXLBlIChuW9aTtMd3qWHLdIXAq5Bdxeqq
 WHpJyBQLKGE2by8Q0NMvdzRkePPe7156JP0+emux38iQXXEqo+vodEwOGguPvZ2D+JPP
 ThGcSc46nUg26o5IMx2KDITXUUPd4Ve5H+PVQfop1Nso9Y3mQhxwWqltxcMbSXECbnog
 LIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996177; x=1688588177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U9mZ3FA6jaY40YGmde+3aLN2iMAzeCKrJsFXalAAtk=;
 b=VcAZ/5D6P3mcWoguT+i6eGEqyyuoJ+V1RnCv8YawORNxrtj7pwQN3S1jWgOGokg2A/
 BjxS55VvRo2UgteHtqahZnIaxmLhSOjLNuCjdIZ1hvmxbFeLaMTNmSNAeTbeerUQ1dbP
 Gur0wPUosT0RvBNH1e9zKbGNjfrIFLUvpMCiOrnsuxxe0RywFBe7z1sAao6FpcgtS9Tl
 u70FSTIGN9quAuZkgBKS8Dkddf+UVmT3FDGpvJ2+6CKRo61Lr/cD5lg+aj0Fr2HI72XA
 z4TnRLZSxTNmmPc9Ek8KKVvNpS1w8JbV6b8n1/9Y6MtoepuyaA+j6KCsNrmKWoQzU7R0
 zhqA==
X-Gm-Message-State: AC+VfDx3ujuJ/RtDKM4F9g8dV+sZTlpxVGeApSoH0dhQM4vtl3w/UAtR
 KHJ0dw1e3wwTS+zc8oP/RDZ85yuzJxf1F6pjpmU=
X-Google-Smtp-Source: ACHHUZ6xWT49j0EP+g7ASJtGFAujLy/mEnDGgF87CfiDBz5MYMqfYjHHUc5moRwppaRDvg/EtPzBRw==
X-Received: by 2002:a05:6a00:cd5:b0:63f:2f00:c6d with SMTP id
 b21-20020a056a000cd500b0063f2f000c6dmr1062711pfv.2.1685996177319; 
 Mon, 05 Jun 2023 13:16:17 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/52] exec-all: Widen TranslationBlock pc and cs_base to
 64-bits
Date: Mon,  5 Jun 2023 13:15:28 -0700
Message-Id: <20230605201548.1596865-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
index ec0902c532..dec17b1e62 100644
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
index 60ca9e229e..1cf4f1fa22 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -297,7 +297,7 @@ static void log_cpu_exec(target_ulong pc, CPUState *cpu,
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


