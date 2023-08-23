Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8445F78615C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOi-0000JD-K1; Wed, 23 Aug 2023 16:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L8-A8
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuON-0005Ty-Uj
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:57 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so28090595ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822216; x=1693427016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lPTy0zFcuTzFVoJv9IKIJHnsjTn7YyrriC1uBaddXZM=;
 b=SxsqY1RVerrh9rkA6vKVTtHzbPKxg8v7UvjxExXpbJ8Pi9uEq2Z5eeycLBLmw0Uuw9
 Ei0gS273OWFr/WShVSayZHPQnhpVU/eFM11YbKLJp98MRni9bbcr3RrotbbvZbnOMreD
 WC11QlLxmDHBncXtwqpLKLFgYsm8rViMrwmFWXpAX/kXKpPBoSD0koOwj4WGtZIF6/gI
 fiGcVVfIY2neBFYh6k6SxWOp1B3Q+HHh/E2o0ySyvHFfwVwq+rtlQfMiBhktdz7z5pzx
 98p85sbXaTiEBNebWjnbO3C7bSB2I9+R2iItzP5KOCCirduaTJD+bzomP+f21Ub1n7rO
 zBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822216; x=1693427016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPTy0zFcuTzFVoJv9IKIJHnsjTn7YyrriC1uBaddXZM=;
 b=fkL0qdxOWtpUyiRs7IjbjxioZAzyVBPq9fEq2qJ1ups2/wFHU3S49Tb6bmGCfQLTNf
 uLxSMlkVmdFNZt8B6BRllmwBY+VRLOAPaxU0COMIvtTHzZwkO3k9e5E6ewjjsvDCq+lS
 5Za10z7RBB4WzdbeJjEq+Io0S+Bt23HCBJFTDyxZzP48KrcPk/sj6riL/mJTZvZWD8Dp
 NoxrYxFbRhggqfoPzdF+r3MRC4pmRAVbeO9N2RAs651ysARX9bLtVuUcGdscRyI0OX/C
 vulfIda0OjPL6z1mmtKXUw9mhq8V7+szuQMSQ4w0SAYxQ76tNl5ohb8Nohvj+v3lhVtE
 4hnA==
X-Gm-Message-State: AOJu0YwWTlBXy/KOfxkOnefdMjIa9Sg6HIHkoZ1y28sLhFNN8pyAn5gG
 ax8kD8bJAuOKOBBEDWTHFCInO+skn35b5lpbKQI=
X-Google-Smtp-Source: AGHT+IE8j0tR9XiVnvZa7fh0EiMKBK0I4J0rzC4O1ZETpRy8GXngv0J5OE6p0AN+l7UAgsuP6n3iLA==
X-Received: by 2002:a17:902:e881:b0:1b9:e091:8037 with SMTP id
 w1-20020a170902e88100b001b9e0918037mr16872898plg.30.1692822216499; 
 Wed, 23 Aug 2023 13:23:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 09/48] accel/tcg: Update run_on_cpu_data static assert
Date: Wed, 23 Aug 2023 13:22:47 -0700
Message-Id: <20230823202326.1353645-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

From: Anton Johansson via <qemu-devel@nongnu.org>

As we are now using vaddr for representing guest addresses, update the
static assert to check that vaddr fits in the run_on_cpu_data union.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230807155706.9580-10-anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index bd2cf4b0be..c643d66190 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -74,8 +74,9 @@
     } while (0)
 
 /* run_on_cpu_data.target_ptr should always be big enough for a
- * target_ulong even on 32 bit builds */
-QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
+ * vaddr even on 32 bit builds
+ */
+QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
 
 /* We currently can't handle more than 16 bits in the MMUIDX bitmask.
  */
-- 
2.34.1


