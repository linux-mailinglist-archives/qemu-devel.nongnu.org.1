Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867E9786187
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRf-0005bm-PF; Wed, 23 Aug 2023 16:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRc-0005KK-9h
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRa-0006D8-MI
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:12 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68a3b66f350so3715206b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822429; x=1693427229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BLjPy391bKC/2XwowKZEESNB74b0AUWTN8kpr/E3og=;
 b=GEqNdYIPov4obhdtBjuj7TIHZ2xgnPU/PqDwh9o2qYgN31mVp2naC2hQH+LSIkxAOA
 FHxgrhd7t6CFBKd6NslSzC2K7m1LRJuEzkGyZo9xahnUyoTZ56cGKmj5ialJriSfosoI
 jkHGZ0kPQsN1f8i3MCDavPVTZp9XlPYaeTwxFhZb8Kq6xDQxUnfcO3t9I+YE1ffh0Xhp
 V+6YnQGO0U7gaYIu9mUx8kNql5E/ZbauOdjwY8BIeXW9Eaw71E8Toad6RYdlRfbV3pkH
 V4bco4TWgiaXEplZLYXua+1FyJwOWcgzUJ9+3V5bXWdefejDt6VBpzEea3/kCXTeoJ77
 Dr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822429; x=1693427229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BLjPy391bKC/2XwowKZEESNB74b0AUWTN8kpr/E3og=;
 b=X5xOhM0zVO8YZ9+DNSHIio76Sny4QH9P3eydsT7sazDOqsj4upG1ln7B297suKrAj2
 JPirADhlAJvd2ewBBO6e7DJUfzigEUGc5BHJF/I7TyAhJp15nnHexOS/2WQjP8Gghc2X
 bTH+fOxDdDKG5O8iMfQ0EnqKt2XsKcRLpcxy+lB4OaiS03+M8uo4as5noVbuighnEtVm
 hIpQ8ulSlLP7o1TUMl/Tw/lWT1WW4wVf5OQFTypGYnrI7z9ULNlcRa7wy5pXGtVtd+/4
 TEIYMj1uilriHGmHFu0rJTGA2QJFgDHUZ8SxfAmlsfwQZt9gBvhfddLCHw7z44BRp2+Z
 bnbQ==
X-Gm-Message-State: AOJu0Yy1WlJ3XEDQ4b82iJBIcToA0HQBUutXVnBiPI8IGK6TzRRgdrAY
 JSnHDBMaYdAJb6ld5iv4Og+gyY1jufoSt/+U3eE=
X-Google-Smtp-Source: AGHT+IHFY+1CdFj94Nxxky9o3l5NpLZzZKxTp6RJuDcSWpJ03Bi0upDXxfM3Mrksc2pecvZn6dUTvg==
X-Received: by 2002:a05:6a00:124f:b0:68b:e3fc:b833 with SMTP id
 u15-20020a056a00124f00b0068be3fcb833mr2304674pfi.5.1692822429223; 
 Wed, 23 Aug 2023 13:27:09 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/48] tcg/tcg-op: Document wswap_i64() byte pattern
Date: Wed, 23 Aug 2023 13:23:23 -0700
Message-Id: <20230823202326.1353645-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Document wswap_i64(), added in commit 46be8425ff
("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-8-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 58572526b7..02a8cadcc0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1950,6 +1950,11 @@ void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_temp_free_i64(t1);
 }
 
+/*
+ * wswap_i64: Swap 32-bit words within a 64-bit value.
+ *
+ * Byte pattern: abcdefgh -> efghabcd
+ */
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     /* Swapping 2 32-bit elements is a rotate. */
-- 
2.34.1


