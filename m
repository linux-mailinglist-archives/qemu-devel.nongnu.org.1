Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8312E7981F9
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdn-00022J-6V; Fri, 08 Sep 2023 02:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdX-0001nj-Ti
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdV-00064D-Io
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:35 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c34c9cc9b9so13555565ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153192; x=1694757992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c267mtx4FDo5BCCDJhdU8KtpdHS7OWZ9xPSR5tVl8Q=;
 b=ruBju3HIY8oRewh4HUqX7iRJoY+N/2j8GG7QCXSYxFwwoQqgdLRmuDVzLT1nQFfTj0
 ANxjiehil2iUDswVDLNrvxiWjGBzP773pNoztzgtFtqIgyA1OUo0G2fCgZcJeXn1i3mU
 Rz7qYI8DN/V25Q77b9NTVlLH6ZZSqbvM9aKgsyK5cT/Hn/iFCztPVJyry3u37hzR23VT
 fmJDk/WUZKdsD9cA74nWBHgEE7qL09yPP1aC7Jvg82SszWv+mee2sjMh9p23yGGw1Yh+
 SCI3TYWJZjD+238jQzoSbuRnX+EvohZKd3YBFatUM/WU6BiMvXBR1DdX4STyWBXEmxVa
 ZzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153192; x=1694757992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c267mtx4FDo5BCCDJhdU8KtpdHS7OWZ9xPSR5tVl8Q=;
 b=xMGVA4r6XydqkxRSJ+GyTBwg62jxm+ho/t4mCPk54wzXiYiBrgYwtqe0znfDTTPfQ6
 18Eaulm0tL6X+x2i+ce8H3ypujMKQ2m+QDjmKqjcB/3+JrvJ5xLoWsP5ottSRsW//Anr
 XjKL7VdBP5dgfH5BKfTiWRAdrl2DksxpDyujD95Io5zNAaOYnnn9QK9z2BvIuo1Gxey/
 ewbR12X5U5T8a5BhAIuq/3xP+rNOD+S3tLXXR/wgZoH+ytLXzOvcxYzXujXevKUI0xFa
 duCEmj03TNZIhVe6mmKTqwi2VM2/6gGKNUlKJrl+mAo4LzTarqgkSoGYQXTmJUKevAzx
 iCvQ==
X-Gm-Message-State: AOJu0YwS5whdYlXot+j4NydHn392HPgR6isX1PP8ulm1cH7MlaztUloE
 BFcK8Dqz6oUYP2J8BPxBLoN0Lfy+mPWCJtY4
X-Google-Smtp-Source: AGHT+IHtGw4ewKpEN4yMUUR+IpE+DFsfVQ7cLEKcgDDDskwT9zDzZIs1GlnlHfqLbxqaZC+OjinHPQ==
X-Received: by 2002:a17:902:b490:b0:1c2:eac:b99 with SMTP id
 y16-20020a170902b49000b001c20eac0b99mr1672728plr.40.1694153191889; 
 Thu, 07 Sep 2023 23:06:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:30 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/65] target/riscv: Fix zfa fleq.d and fltq.d
Date: Fri,  8 Sep 2023 16:03:51 +1000
Message-ID: <20230908060431.1903919-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Commit a47842d ("riscv: Add support for the Zfa extension") implemented the zfa extension.
However, it has some typos for fleq.d and fltq.d. Both of them misused the fltq.s
helper function.

Fixes: a47842d ("riscv: Add support for the Zfa extension")
Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Message-ID: <20230728003906.768-1-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvzfa.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvzfa.c.inc b/target/riscv/insn_trans/trans_rvzfa.c.inc
index 2c715af3e5..0fdd2698f6 100644
--- a/target/riscv/insn_trans/trans_rvzfa.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfa.c.inc
@@ -470,7 +470,7 @@ bool trans_fleq_d(DisasContext *ctx, arg_fleq_d *a)
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
-    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_helper_fleq_d(dest, cpu_env, src1, src2);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
@@ -485,7 +485,7 @@ bool trans_fltq_d(DisasContext *ctx, arg_fltq_d *a)
     TCGv_i64 src1 = get_fpr_hs(ctx, a->rs1);
     TCGv_i64 src2 = get_fpr_hs(ctx, a->rs2);
 
-    gen_helper_fltq_s(dest, cpu_env, src1, src2);
+    gen_helper_fltq_d(dest, cpu_env, src1, src2);
     gen_set_gpr(ctx, a->rd, dest);
     return true;
 }
-- 
2.41.0


