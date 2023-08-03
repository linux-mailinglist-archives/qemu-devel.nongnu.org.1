Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A99776DDB1
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWe-0000hB-Ar; Wed, 02 Aug 2023 21:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWc-0000fr-47
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:14 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWa-0000mE-JR
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:13 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686be28e1a8so312763b3a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027591; x=1691632391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=QjOBdNPw59KVzwvVESUSqAtAEJY+f2XN7nDsw0p00A1mdtaG5npTrnCNALq6hXtvL4
 3NM5QSgPkP/XOr4N44Glun5KrGgncc0/zXOYiYITpYCV/mUCcEiZbyxiUSoKMg9atB0t
 2EIyL94PfxhpFP4Q6SD86MPwFdlxVUQVacq3XI5Y+mZCpG45AmBv5BmZinMIuDQJaEDQ
 S+8CUh+QoXdwpS/AVxLZDwGRw8r/YB0fpn0Boorb9zOjl/mNuh6ygJ52rXSXsPy3s3QZ
 TRiXumLr+3ePBtgUj5szmQiN0D4AZqnEK6HnvmDSwe7xZC+a0fjwxD2vajF/LrDo1T8d
 KFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027591; x=1691632391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XZm1OFwkD4B8Sj8o40TKDrmNFRuwUs1Ie6LEvKqa7G4=;
 b=DED1s+xt7bJzYqEEQ+WndlmLTVNiINkqHR0u/Cg5HSZFN2wpG2uPzP7YiaETNbnWJs
 WYqH+sRZ1hp07qYzP2c3HDbP+kccMoE5hDQ9eliB9BALz1+pgh8lE260xZhPyY5VUjuB
 mIvH/3UxZKnk5H6owMCZTx3DLs9gXgcnG6VUW2sqLqhEbyjlj6gazQjlXPl+zFqzx8Sm
 Eq5g9L4MSfZKu2mLqadxB7M3eU2xmKhgUrN1kPc8pSPFg7Peb8cYpEv8exrMd+FXO+Kc
 qzsb5OuW+H8UL59D9jJ/TCa7fy5wAWr3ftdw4g32A0LHcPfzFXDn8T9JMTdoN/koyR7a
 XVHw==
X-Gm-Message-State: ABy/qLaZXM25Rgk7vNKf1bKhJRkmuZ9WHVLLj+1VkNRy9V+si6RlmS9b
 qdJi2ktpPmvPjv3JvBfFIY15oZ5Fo+qP9g87Kyk=
X-Google-Smtp-Source: APBJJlHmElRa3ZYqa7wPJ4o6ymeDF7/XyAFwZ57T1pvx6DFftVauRcBdR0plyaVfUEuL4k0WgkYMzg==
X-Received: by 2002:a05:6a20:1615:b0:137:53d1:3e2 with SMTP id
 l21-20020a056a20161500b0013753d103e2mr19745119pzj.41.1691027590892; 
 Wed, 02 Aug 2023 18:53:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 08/14] bsd-user: Remove last_brk
Date: Wed,  2 Aug 2023 18:52:56 -0700
Message-Id: <20230803015302.407219-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 bsd-user/qemu.h | 1 -
 bsd-user/mmap.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index edf9602f9b..8f2d6a3c78 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -232,7 +232,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
-extern unsigned long last_brk;
 extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index b62a69bd07..8e148a2ea3 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -214,8 +214,6 @@ static int mmap_frag(abi_ulong real_start,
 #endif
 abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 
-unsigned long last_brk;
-
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated a chunk of guest
  * address space.
-- 
2.34.1


