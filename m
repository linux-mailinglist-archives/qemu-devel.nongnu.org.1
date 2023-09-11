Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D9379A3DD
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagP-0002zW-H5; Mon, 11 Sep 2023 02:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafe-0002PN-Uz
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:19 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfafc-0004uc-Oy
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:45:18 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ab2a0391c0so3173026b6e.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414715; x=1695019515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c267mtx4FDo5BCCDJhdU8KtpdHS7OWZ9xPSR5tVl8Q=;
 b=eOky8bHGJ5CnCiRkiE6EEtX+excYiNDykYGfBYP+6N4oohvHs0lwTl7ghrrzjlQGAm
 hN4qPFNdfY85/Odp3BcKj23d1omFJvz1YMGRnHgQ1fdcrnT/EXab8y17hUku2c3Q6rdk
 Biyzdp6iViL8kU6lWH7mmRgvSJfGK8LGUl6m8BmJqe/+MSdx0SrAd4KvSKTuYnejGGXT
 NkKd4DNsCQj6uqkyll9z+gyMJ9v7gTZvhllUE0HNBD9jFY5LlWc6ja7N/DlfW5yHI4pN
 Fsy3qpm5Dn+49yAwVFbEk8MAfPSzg7QniHJ5mJgQEhSW3D9yADB4NX1jxCXWxtptZOB4
 7fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414715; x=1695019515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c267mtx4FDo5BCCDJhdU8KtpdHS7OWZ9xPSR5tVl8Q=;
 b=ev+XYhS4RniaMYJFwt13QVu1ZB/RaxG4JKIEKuadpOAfc/uUD90r3xQUAOX2miS4yH
 F8Eu0kJwKcDez08BTqYg77mKsDHUv0zlXkytekF8HTa4xa9/VD3cBRB6EKaoum9L13er
 gvdaAi6i5GmYduK/ZAK9FBAZSqHLwM8OW6/NvfH3uhu6jlKP64gi7SxgAeXY6p28wcR3
 DPGt/PacGO8a9GDaFeSFR3A0N4eg8CN1N0v+0v68+AgvhFR9+pDAhh+8/ZpOGil3kcye
 7Td8Yeq7kzT66FKc5TyxAZV9vWPu2uJ/UHl9RuJa4khYrOumEKEpvEaoYjSz9m0Smuar
 6TRg==
X-Gm-Message-State: AOJu0Yy4MYXWswnpf9pTiS7K/BR7UQQDIjfaJXaGS0YEpcusG/0WDOUK
 Us+IDiyummg1lWhim0mbpBSZhvs/oou9iQ==
X-Google-Smtp-Source: AGHT+IHBIiKhj5xpfiL30kMNpW6K3HslAibRXUxdrVttWUwg6iTDKGvCZgT08wUCKbtO3Ik/ErLV1w==
X-Received: by 2002:a05:6808:1152:b0:3a7:330d:93da with SMTP id
 u18-20020a056808115200b003a7330d93damr13804293oiu.19.1694414715414; 
 Sun, 10 Sep 2023 23:45:15 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:45:14 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 25/45] target/riscv: Fix zfa fleq.d and fltq.d
Date: Mon, 11 Sep 2023 16:43:00 +1000
Message-ID: <20230911064320.939791-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x234.google.com
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


