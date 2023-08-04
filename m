Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 861C8770B9E
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2qx-0004mH-8Z; Fri, 04 Aug 2023 18:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qn-0004ds-Mk
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qk-0001sR-PZ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:49 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-563df158ecaso1723346a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186443; x=1691791243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiKvQ5TIjJkHeXd+ZGncRxkavk8D0Yfna3UAt9/lKq8=;
 b=Kqt7l9yVrB9IbiyiVJSJhiiKf1YS8Vqf0Cxlb+3DKWlbatKEkQIhzpRLfJNRMnX3xw
 Wp2Gp36hiLlv3F63Xw0o0owm/tKVF9Ruhkb44jJUs0oE2bN3Y7O9Y5+UTicIuymtM49E
 qeUIf4NnU2Fvo+l0cR85Y7rgdlhyTrBqTOzeKagBrwFzJluDMKOfHTB1auBvdJWnaO9j
 TNEe4id3DTNIi3czbVJURpVj29JVOQzp92oDuf/09saRiR/kc0T2Bt/cfjmoF0lbsvEf
 erPqWI/nKVqBXhrrSktg79upI4kzkSa4F83LxRynjD+0dHHXYxWCUgPJZUb1b/pjAqgO
 tj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186443; x=1691791243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiKvQ5TIjJkHeXd+ZGncRxkavk8D0Yfna3UAt9/lKq8=;
 b=XljmoQ4ZXbcLwUcwt3ZSJ7BKhLI75kK7MFatN9Xyo4yXliYVTcnq946xntmKa0te86
 fa9/dPmTf34ozezbPp1Tnz4b7G36zVXm9KFItrcO07U9OPEEi7qI0Gz598ZrEnBvTQAU
 ac0KUFvt4f4KEElKLxUa1uRfEHje755eWs8gr1tX2hMf9HpU8VIvORfCiWoyN7TivDHH
 7UXYdgteeeUm9m4W2gmDu/rE7kBB3x53ihP67Y8/oWKA5Bnmv0BOj3NdsNuGXldOE/vT
 nu4324ZOrkCZfspF9WGTwInVoBVRwiFqg9JUV2BIJDBe5iOE1uEgBfcDjktfxAoxWhcT
 dj8A==
X-Gm-Message-State: AOJu0YzzUonZKz0yDjivchtJZpdT51qZ7O2iXYoQi3oQ0CSixVg2TasM
 g+clUyUaiQ+JUFuS3ywaU++HuFrLqchgFMmxLg4=
X-Google-Smtp-Source: AGHT+IGEI7gZLxcYvxUdm3ij0fXgfeT2TT59jv29QHOhqZX/t3VbsnacsDIboNaSfnXH8m0UkZrj7w==
X-Received: by 2002:a17:90a:2c2:b0:262:f0e6:9e09 with SMTP id
 d2-20020a17090a02c200b00262f0e69e09mr2774921pjd.14.1691186443435; 
 Fri, 04 Aug 2023 15:00:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v9 11/24] linux-user: Remove last_brk
Date: Fri,  4 Aug 2023 15:00:19 -0700
Message-Id: <20230804220032.295411-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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


