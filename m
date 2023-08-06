Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C4F771376
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUaA-0003fx-Ap; Sat, 05 Aug 2023 23:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa8-0003f9-HG
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:28 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa7-0007YS-1R
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:28 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26837895fbbso2389965a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293045; x=1691897845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiKvQ5TIjJkHeXd+ZGncRxkavk8D0Yfna3UAt9/lKq8=;
 b=aTEXjqbqaO/SstStJeSHAiASAEmV8j9iYIROtfc8J8V+LtNdcknC2IQSKKHxskGL5P
 2tRstoO21Zg6x4M44gqNLpYTKFCYfHPzOVaPF6iYjdptqZ2YyjyraB3y9PvitnmMtDHU
 CFZwhF6XJQ/2ZT+ag/3zMBHLoHol7RQ/R9SsbVx5+z8ARjAToRcovs2qtLBNprRRzjCp
 U2OfRaJehYUFsTw3/kS/099BgUOYFzMV2NEZCegzBWca6bUfKiBA/668QSm0lHL5R6D7
 gIOZsWvqtEBwkI4Vu1XUFOpfeaKV40Q4CMarl8uQlDX87jfPCHzZC93hQs06kRF04IBQ
 RtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293045; x=1691897845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiKvQ5TIjJkHeXd+ZGncRxkavk8D0Yfna3UAt9/lKq8=;
 b=X4dTUYkdAvJYGEUinpB/50HA/qEuvKStSTW0FauO8jUQ21EZ4QOmby6LHmfc1dqx6y
 eCmNXixgZ9nSDhlD5Ue3qug5WeCa0S8mpvZ+8PpxA+PT57RR5Ay+4iFJMYMpmyDNZJz6
 NmX61zk0XvPfqVuTqNiirt/weaZbSV1+CABDrvq7Gc4XSL37+6zR1qEKplO38OUVfVGu
 kG/TZSMo1Bv85L4qqzkAumEA/OKhd2LKh1tlddOWhiYVR0gl5hgfu3eu6FliQjTXXfjV
 tXvU1Lz66G1iKsw2iwrvycETyz5jFLpzkNJIeHliGaNWqvcx8dP4PXKjxDCR6piyHYM9
 b5rA==
X-Gm-Message-State: AOJu0Yw8oCbNScG0cQ8gV+R4WwfYAXOdEY9sHBgH4pPLJoSsUcMRM1ZR
 Ydf7H3rsyEI3Fn37twXBJWrjXULcaz8v0Qpm7Ts=
X-Google-Smtp-Source: AGHT+IHo0RneqmtAYm2HnwZerkITZpkgYZVZK319yapEJRgAaqgU7HlxA6pRsDBJdA4n+ZuA7e2D9Q==
X-Received: by 2002:a17:90a:7ace:b0:269:142e:c2ed with SMTP id
 b14-20020a17090a7ace00b00269142ec2edmr5728112pjl.37.1691293045572; 
 Sat, 05 Aug 2023 20:37:25 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 11/24] linux-user: Remove last_brk
Date: Sat,  5 Aug 2023 20:37:02 -0700
Message-Id: <20230806033715.244648-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

This variable is unused.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h | 1 -
 linux-user/mmap.c      | 2 --
 2 files changed, 3 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 3fc986f92f..7265c2c116 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -26,7 +26,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 90b3ef2140..eb04fab8ab 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -314,8 +314,6 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
 #endif
 abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 
-unsigned long last_brk;
-
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated
  * a chunk of guest address space.
-- 
2.34.1


