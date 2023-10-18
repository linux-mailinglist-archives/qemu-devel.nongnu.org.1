Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6CB7CEC22
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 01:34:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtG0u-0003sI-6w; Wed, 18 Oct 2023 19:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0r-0003bl-Tg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:41 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtG0p-0000He-Am
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 19:31:41 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-581d4f9a2c5so1295454eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697671898; x=1698276698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2k8XNRKudZqb8EBVa8P0hTDCeDuuDeqPExqYOmBXPTU=;
 b=T1HjE9s/vAwmlJdg3j4bvMnWFNEUhgxCi83qF0fciFrq4iMeXPdQnGgBWsnkUqzIUt
 jxzXImOc3/JpaXpX8ZAGv0QW8Ac6bjHPGpEFT5mqT3OqJM7z1vfHRZxEQywvdwTe0g9d
 dujdI0CtwAVUFd5vXX6HzyhwB1ba28Uxgj/UHKnYUQDE0MUy9NZHTQy/mSY6nSDcHNVj
 0AgZtUL3OhC8i0U/Q81acJEpFtT9MJtzxVbAuVWXP942R8Z0vdC3dIK6E2JOn09ebdYB
 HbuPS7gIaOIbO532FJgyIjgLhwVp3O7q0MjQ5g21tSQxwuFqMcuqg7LZ1Feh8HsaiTpf
 f0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697671898; x=1698276698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2k8XNRKudZqb8EBVa8P0hTDCeDuuDeqPExqYOmBXPTU=;
 b=ILyzx6GKlD1WKv+mb02rNAt2xUJv9AsZmmkeeY2tUii4tTaTaOHbEn7JE0tGTY1oG1
 WLo9sagVBWrolgRsYQiih77ekYdgL5+SJ4alxLITkPSXCtIvDXxhgVjzYc29WSeh55Sd
 QDz95IGkrwZQ0Q6DrNc8phq6HwlpiFzjV0STpRCBEPkE+t2aWQP6KZowyT4OWQqKetLF
 freXX8v2+4BXNapuf/izlQlWHqRpW/tz3moDGgwSYReSdBoTtXTe/+z77C9OeTSLjnT8
 S/zjL/ovEgWAXFTXShMdnU1Ns0ZjK4/gJcOYE5wGPiyUJhGyMq/Muwmh7XOGkg2WLexN
 9a+g==
X-Gm-Message-State: AOJu0YxtocmN/BK8fUcyUnb0nZ4cLucBJKwr205Bt2yaklzAPhWCUDS5
 t9kky90tL303aAZpedhnvJPBb8OABAVVZVdJkZo=
X-Google-Smtp-Source: AGHT+IGLxyNfa7bjHam+oXF8Ve3NLM22VXgqmCzlIsW3AZQLw7HVdDcZs/xPYByQa6UKsKBrMSBBKQ==
X-Received: by 2002:a05:6358:fd02:b0:143:70a1:afcd with SMTP id
 ui2-20020a056358fd0200b0014370a1afcdmr453415rwb.1.1697671897987; 
 Wed, 18 Oct 2023 16:31:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 g9-20020aa796a9000000b006be5af77f06sm3881690pfk.2.2023.10.18.16.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 16:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mikulas Patocka <mpatocka@redhat.com>, qemu-stable@nongnu.org,
 Yoshinori Sato <ysato@users.sourcefoege.jp>
Subject: [PULL 03/14] linux-user/sh4: Fix crashes on signal delivery
Date: Wed, 18 Oct 2023 16:31:23 -0700
Message-Id: <20231018233134.1594292-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018233134.1594292-1-richard.henderson@linaro.org>
References: <20231018233134.1594292-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

From: Mikulas Patocka <mpatocka@redhat.com>

sh4 uses gUSA (general UserSpace Atomicity) to provide atomicity on CPUs
that don't have atomic instructions. A gUSA region that adds 1 to an
atomic variable stored in @R2 looks like this:

  4004b6:       03 c7           mova    4004c4 <gusa+0x10>,r0
  4004b8:       f3 61           mov     r15,r1
  4004ba:       09 00           nop
  4004bc:       fa ef           mov     #-6,r15
  4004be:       22 63           mov.l   @r2,r3
  4004c0:       01 73           add     #1,r3
  4004c2:       32 22           mov.l   r3,@r2
  4004c4:       13 6f           mov     r1,r15

R0 contains a pointer to the end of the gUSA region
R1 contains the saved stack pointer
R15 contains negative length of the gUSA region

When this region is interrupted by a signal, the kernel detects if
R15 >= -128U. If yes, the kernel rolls back PC to the beginning of the
region and restores SP by copying R1 to R15.

The problem happens if we are interrupted by a signal at address 4004c4.
R15 still holds the value -6, but the atomic value was already written by
an instruction at address 4004c2. In this situation we can't undo the
gUSA. The function unwind_gusa does nothing, the signal handler attempts
to push a signal frame to the address -6 and crashes.

This patch fixes it, so that if we are interrupted at the last instruction
in a gUSA region, we copy R1 to R15 to restore the correct stack pointer
and avoid crashing.

There's another bug: if we are interrupted in a delay slot, we save the
address of the instruction in the delay slot. We must save the address of
the previous instruction.

Cc: qemu-stable@nongnu.org
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourcefoege.jp>
Message-Id: <b16389f7-6c62-70b7-59b3-87533c0bcc@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sh4/signal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index c4ba962708..c16c2c2d57 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -104,6 +104,14 @@ static void unwind_gusa(CPUSH4State *regs)
 
         /* Reset the SP to the saved version in R1.  */
         regs->gregs[15] = regs->gregs[1];
+    } else if (regs->gregs[15] >= -128u && regs->pc == regs->gregs[0]) {
+        /* If we are on the last instruction of a gUSA region, we must reset
+           the SP, otherwise we would be pushing the signal context to
+           invalid memory.  */
+        regs->gregs[15] = regs->gregs[1];
+    } else if (regs->flags & TB_FLAG_DELAY_SLOT) {
+        /* If we are in a delay slot, push the previous instruction.  */
+        regs->pc -= 2;
     }
 }
 
-- 
2.34.1


