Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BE678646A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykR-0000Vb-VB; Wed, 23 Aug 2023 21:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykO-0000I6-9U
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykM-0000SW-2C
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68a3cae6d94so3798192b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838968; x=1693443768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w5ksMQj35m+yCeIWGrGNigy7JAnPo0mf1QEQxYD2q74=;
 b=PmAiyfwTTuuPEHsHlhJjJr+qiHa326xnhaPXsS3HQTMhUH8lUdR0NyydPQU8te2Qjf
 oTwA625MsUmE3qgD7XcZmOaOdV2iOs6Aze0zSVKvd9HyryxCRwS92Cqu8BB6m85G6ohl
 XCR1XwOji6M0621KQ1KYxPGeuiMzMXjpt17ZUbUxlGIQr1IzscCWGlEheLpLUkLchFe4
 cb8zTjh8+gtCzOF70XuFcj27ChqIGsk9gCpvb/rxGf/Qsh5RqR9jXtFZs/l62FNCT5PI
 KwarTSHnNEgfGuTJFQ0m3kQBHjFgg8G0bFoNhEdUgYGEwFdy0u0rMocMz6p6dliQLfUz
 sb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838968; x=1693443768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5ksMQj35m+yCeIWGrGNigy7JAnPo0mf1QEQxYD2q74=;
 b=S5JVVX0h6gNwfXBquXpon2GgPWLaBJWDCrvtJxcE/dGL4t0G1aSSer77rCmcrApNpo
 dKjgEXQ2QQ1fKh3ATQsWq0cINaarNDTdH+wQeJzw9bfRyb2MJOV/s+Vk12XdZgc3QM/b
 LcO0j1yUUUkEQhx/cEkjIx4C28jVzV1yCxxER6uq5l+9Iz2IoGE7LIpTPg3Trmjvqv/o
 biQhcIy/KqcLcCDgWfZMwVIUDnQaUs7O9z/evKeb1mKRSutjSwmL3AMf3iQjdbdALCY+
 d1XEwIyFwQHc8+FVvzjET9m2To5mAkwh0XW2n04olgiMrgWPZMUyNJbA4IwZ/GdEbToe
 hRiA==
X-Gm-Message-State: AOJu0Yz8FdpXxQ/G+iF3gn0dec0t9Z+XVyP0oQ9WHy2AGHjzwZmtAm9a
 DGjDwGu/Q8rS7ifb/viLWrGYDumVTNcNzw4ANUk=
X-Google-Smtp-Source: AGHT+IEegzGDh0ESub1IYR6x1hGeYE2UTqJ/X5zKLhr276gcOmoQxJyxhByknB1DLzdKYF17SEE2NQ==
X-Received: by 2002:a05:6a20:8e29:b0:144:c131:dbe2 with SMTP id
 y41-20020a056a208e2900b00144c131dbe2mr17605700pzj.5.1692838968635; 
 Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] linux-user: Fix shmdt
Date: Wed, 23 Aug 2023 18:02:36 -0700
Message-Id: <20230824010237.1379735-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

If the shm region is not mapped at shmaddr, EINVAL.
Do not unmap the region until the syscall succeeds.
Use mmap_reserve_or_unmap to preserve reserved_va semantics.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f45b2d307c..44116c014b 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1102,14 +1102,25 @@ abi_long target_shmdt(abi_ulong shmaddr)
     /* shmdt pointers are always untagged */
 
     WITH_MMAP_LOCK_GUARD() {
-        for (int i = 0; i < N_SHM_REGIONS; ++i) {
+        int i;
+
+        for (i = 0; i < N_SHM_REGIONS; ++i) {
             if (shm_regions[i].in_use && shm_regions[i].start == shmaddr) {
-                shm_regions[i].in_use = false;
-                page_set_flags(shmaddr, shmaddr + shm_regions[i].size - 1, 0);
                 break;
             }
         }
+        if (i == N_SHM_REGIONS) {
+            return -TARGET_EINVAL;
+        }
+
         rv = get_errno(shmdt(g2h_untagged(shmaddr)));
+        if (rv == 0) {
+            abi_ulong size = shm_regions[i].size;
+
+            shm_regions[i].in_use = false;
+            page_set_flags(shmaddr, shmaddr + size - 1, 0);
+            mmap_reserve_or_unmap(shmaddr, size);
+        }
     }
     return rv;
 }
-- 
2.34.1


