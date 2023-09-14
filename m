Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D74EB7A0BED
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:46:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqOZ-0000jt-5G; Thu, 14 Sep 2023 13:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOT-0000eo-TR
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:45 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgqOR-0006zu-7F
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:44:44 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fbd5cd0ceso1010345b3a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694713482; x=1695318282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa7/YS9CoqDQehByb25wHU0vdLROTPpiwafKH90tB9I=;
 b=kmMCnoq5aucO6SfslxSP2dVjrPoq5jPfshQJtjSpx/q3UYnx6GMqKlSQSRqyP97zEh
 XayUnuh9sQs7gXI54nkZJfHOgG7ibYFUwdGqQordUhN2uMrK8pPCTuGhIVn7T6vuc14W
 qcW0Kk/E5do5uP5g2IcraEccqsq1xQXetzWzAvLJrwN7oyIr5ANSa0hiGGCqhyITJA9X
 Muaay8fR892yGziG2/sNwDJc/jSMIhcgLU2n81ONqLJ2a9C0TUMeK4TpjUxfOvOoWtBZ
 jMJg5hv91jFK89yAbGoe6B1v5EqPT1v1F8w2fliDdrvIgEIr0SCI1cf7BwogvEZY3Zkc
 kSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694713482; x=1695318282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sa7/YS9CoqDQehByb25wHU0vdLROTPpiwafKH90tB9I=;
 b=IXX0TwJAjqeeUIQZ5qRRbzdZZRn8PBuSqCGK5jDDVokBzeiIdVfw/kqrFvTAG7ByOA
 0ido7mERxReZuVmxbEXjbrBW4COrhodH6orct+PGeAmk34AdngcnyD+7yzM/5DQ6meSf
 +7fe4Upk3PxgQ0jzz6hxBsmXFmwg1B6E6ScUqLhS/RY3omsc01G3ZhliVALsnL0TIb8i
 IKfkwkIWqCQqYaooIdMUruU76BGnWkwFy++JTU46AAFPj+OsSOR5f2tGkwhm8ZCme6Qf
 B7h2bQIpvdeo6+qqJi2ycjRrysdDqwwBr5ZaupCRKL9csU+dpzGmdiv8KMsy1ilI6OYs
 a+Tw==
X-Gm-Message-State: AOJu0YyWfgsc+lfqTxWaI5zyEik5PF4RmPJtltlK1xTHwyiGEd6IxS5d
 q9sF7LAZMz7MIIYEyt8/Bi7lFgAJkYwDQe0UX4w=
X-Google-Smtp-Source: AGHT+IG94+fKOKuWBscpNIqXfaX3HtAgXM5tW3T7TwtTKJdlRYE6Tf2id+BxThzJP+Y1EBF74QbCJQ==
X-Received: by 2002:a05:6a21:3d85:b0:131:a21:9f96 with SMTP id
 bj5-20020a056a213d8500b001310a219f96mr5571738pzc.6.1694713481744; 
 Thu, 14 Sep 2023 10:44:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 w17-20020aa78591000000b0068c5bd3c3b4sm1588933pfn.206.2023.09.14.10.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 10:44:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 4/6] accel/tcg: Improve setting of can_do_io at start of TB
Date: Thu, 14 Sep 2023 10:44:34 -0700
Message-Id: <20230914174436.1597356-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914174436.1597356-1-richard.henderson@linaro.org>
References: <20230914174436.1597356-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Initialize can_do_io to true if this the TB has CF_LAST_IO
and will consist of a single instruction.  This avoids a
set to 0 followed immediately by a set to 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 850d82e26f..dd507cd471 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -87,12 +87,12 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
         /*
-         * cpu->can_do_io is cleared automatically here at the beginning of
+         * cpu->can_do_io is set automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
          * -icount, plus it would be very easy to forget doing it in the
          * translator.
          */
-        set_can_do_io(db, false);
+        set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
     }
 
     return icount_start_insn;
-- 
2.34.1


