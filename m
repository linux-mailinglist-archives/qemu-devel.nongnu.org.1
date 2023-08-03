Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D247176DDA4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:54:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWd-0000gN-4j; Wed, 02 Aug 2023 21:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWa-0000fD-Tg
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:12 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWZ-0000lq-Cf
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:12 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a3373211a1so325196b6e.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027590; x=1691632390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4pOOuQWmq0xrR9pkY2S2VlYgAJ/fJTzo6NDmQNEUSw=;
 b=paj9PCtabNua4Z7mbz2qjg1N20UIQkHljBfsF+nI96n+IXbzIm3j6XzPQJWrQ6S26z
 BpIDq+4m5xcb1HEeppERSG/80azNbA5FYnRyD0ehdvFbSRu92IfGD9TrW4Iudgmyo0Ar
 v+x0TXl16I5aI2xlHIczWmg1argyVipdNXaxmXlgMl/sSH35Xlta7BDWLjeFAy/uBm9T
 dGxCK7xxFOzP/syw7zvXgQh4ZrWRLLnb1MGyIjZOzqnsc8CMCFFflTKmWwDVGu3ktjue
 jpeNiFwzSd8LkyDF0F/wasrHKY2KVEWJc0Co1mdg/dyrMCVl5T8WDIV1xwuzg5DLub6P
 9SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027590; x=1691632390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4pOOuQWmq0xrR9pkY2S2VlYgAJ/fJTzo6NDmQNEUSw=;
 b=WxDHWZZk8qnUDJHJvToCLR7rDunEZYdhs2wV6pTaqbV7B1EtlLFvBx6udriOiDlbwS
 4+W/QMLmpsrTSCy2XAo5RaAuqwM6dtjXnITLztF1CClts35/cNbW1YC4qNXA7KF4aVnS
 caOKSTNuDQPJiv3cXCIfiqdjL3j3zwGXZL/36TX9zqrP1OMp9z2WuPoyN74raA5z9GqE
 Hgja3q88WR7AoX6Mf0O6bVd6hUVg1yayBYKQTd/FHz3JkyS573I1YaXEYLvsIxDXhRf4
 vsVCvHTkC8PXS3KUEt70XnuohPgPafbI0uu6g/3pC49Rdxu2TbGLYTOezZAdtFWBYbBz
 Fx5g==
X-Gm-Message-State: ABy/qLapMyf89sO/nkgOW35Gj4Jbqf1l0GdLrvzs8dnxdlh7NjAmBJyB
 d+L75maXROYYbZmgHho0lOYBDtV7ZHjotIdN1pk=
X-Google-Smtp-Source: APBJJlHV6mgELKGF8gGAhcP6/j8kRc/yMEUOPeiwX1GTV0r4HjHyhmn1cjJkRuEljlt2cWAtB+1dNQ==
X-Received: by 2002:a05:6358:7212:b0:135:4003:7849 with SMTP id
 h18-20020a056358721200b0013540037849mr11639993rwa.4.1691027590186; 
 Wed, 02 Aug 2023 18:53:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 07/14] linux-user: Remove last_brk
Date: Wed,  2 Aug 2023 18:52:55 -0700
Message-Id: <20230803015302.407219-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

This variable is unused.

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


