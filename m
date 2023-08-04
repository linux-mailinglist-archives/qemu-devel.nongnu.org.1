Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F31376F726
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsu-0002gc-C9; Thu, 03 Aug 2023 21:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsg-0002cu-E3
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:38 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsc-00059e-4K
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:28 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so1418022b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113524; x=1691718324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4pOOuQWmq0xrR9pkY2S2VlYgAJ/fJTzo6NDmQNEUSw=;
 b=xSyIUOh+RoJWrDmmPodBqLoqx556ANRBFz+nXQdmCxz/lT1UWXv3vVAGdVe7/EFDx1
 wiAlw+hs9gYZOmmRAO8TsPQnapiPF0CRlQ7qEuitVZa3EaPvQyW+7qRKxqnzqDAuWI8m
 ErH3r4RybOmwCI5fFPnDGPQ2H82c4exx8GcaO573w8MxNuxuCCgJywAibAPdU9n95Q04
 9n+oc9SSv9aRh5IHiZLX+C39sYOFcf4Jmh8pyr8q2x5MUhvZmx9+cShNaMOCrTyoxa/H
 3E3aq/1BkPHnt7l/QmJ0fpVygReT/cPhrwbf3kAjNCZDoR2vdqReIfiv+fTMXhSJqMtj
 styA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113524; x=1691718324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4pOOuQWmq0xrR9pkY2S2VlYgAJ/fJTzo6NDmQNEUSw=;
 b=leVwbRIMJ+JL7Njdmuf+ULX/fl71KivrRp2yfbQpphN71t7qVj52sI/bo2DbhtmOA7
 1v7PjjVtY/09f5Ymyhg22iL4B0JrMpyqj9L789SUa9HdfLkOPAeUKppo8i70lCadneoh
 OluRvtMvKB/bAahAXkU5qQL+7bVK4KVy+0ySTLenzM0F4zt5ImeOGKoWEi4mkmVZy2np
 5sAzzpjg9UEIx1AcUxBKHjnfnDbmscLlDBcODwGGxjBBYV+sKMr0V9Jf4RyAmNcGSJoa
 0svgp4g3QcWowwrdHlYF+xvIiW8Jbs6B5vBX9s1POhPRGxKrpJ6HmcipEyCOwLtkxzLp
 sqEA==
X-Gm-Message-State: AOJu0Yy3LDiUS7JzSjhh0+W8CGpcdpvfNljNtr0ejvP1NFYji+kqDCCK
 gCoIlQ6vr9ajL62NoPi7URromx6XmYMQggoAXUQ=
X-Google-Smtp-Source: AGHT+IHUfTmHwCl45it4nhu+bBTkE4fiRHaZbz791RbF/65mxB3LM4EDXzGpT/7SEmgJR63t/tcafA==
X-Received: by 2002:a05:6a00:23d6:b0:67a:b045:e290 with SMTP id
 g22-20020a056a0023d600b0067ab045e290mr554874pfc.4.1691113524043; 
 Thu, 03 Aug 2023 18:45:24 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH v8 07/17] linux-user: Remove last_brk
Date: Thu,  3 Aug 2023 18:45:07 -0700
Message-Id: <20230804014517.6361-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804014517.6361-1-richard.henderson@linaro.org>
References: <20230804014517.6361-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


