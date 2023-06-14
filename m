Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 863F772F1A4
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FBo-0004YW-6O; Tue, 13 Jun 2023 21:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBn-0004YG-1m
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:47 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FBl-0004Sf-Fi
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:20:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-65055aa4ed7so4949065b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705644; x=1689297644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrU97t9GGjXwfTdo/EN7GKOkvJP4U8J5cJk2m1UGxxA=;
 b=JbR9Ico4dJCgBXLfS3tGcL0GB1EdFvJvS8Des/40UASNBxkTiNwGwsrbWm3FKOw0Sa
 cyfs7iCYZDqyDXBbbRgPUjeO99/xzzX4pUZX1Z6lPoMLBgPTKv58xf8BU66gpkfjZkp8
 /AXT4MI8QHmM/2iyAsH3/hQ5jV/i52Rgm/a8DD39FekFxTL4PqsKC9oltbCseh2jUh7E
 paBKXZ5Vknq+ktz2MawSFKLG0ZUiEX0PnQ1jtOW8Ka/yK3XpPOrHfZTeWkCfL8IKyMcq
 6BT8iEmsvUXktjCdpdt9GO20n3+ZRpqViT+z66Ru0ojl6dYjM+DQkNiJXEiegBuQaefR
 zN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705644; x=1689297644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lrU97t9GGjXwfTdo/EN7GKOkvJP4U8J5cJk2m1UGxxA=;
 b=YJ39MkjVYJVK52nRpTL93YvpNIYuQhgAj8/uLfIWPCVYKgf31q5pHPNVhHBaSK1jZZ
 PX5sAVPXkMZItFVtlkdQ63DgEXMXMXLGhuOxJEOv8WNItf0ehoWbiTBvr8/mLybMtcIK
 ZbWuE/BPbFkOkatfznK4XtfAkwWH1rwqEeNlxyVxbQJi6Bp8U7Eofm6xMcNV/XklbAA0
 7b3N5f0c28BpMDJVNbcCUHiVK26gKy63iEN7NBkmEuxlTrkLHjXHfqRC0MA/Ze75feK8
 Qx9CJUWHpIjJfSUR69t95aUHyA999Dyg7KoGh6ZTOZERmfpIhyhrveJhCKOeBhuvX0Xm
 5q2g==
X-Gm-Message-State: AC+VfDzRmkbXOimHZ5EsOrfpUkhhX52bU+RpMcYQJ8v3ybAKkU5Vppj+
 rmn0wEa8QFTYuVl7VdKN/NyY79eTvc990Q==
X-Google-Smtp-Source: ACHHUZ4Pwz+mAZSvP0zbSu9QSDRjoSYftiVNPjKw5Yup2CD8cHcm6v6T8EYhfjv9f1yyQeIKHfCsbQ==
X-Received: by 2002:a05:6a21:595:b0:114:6390:db06 with SMTP id
 lw21-20020a056a21059500b001146390db06mr494307pzb.32.1686705643894; 
 Tue, 13 Jun 2023 18:20:43 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:20:43 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 02/60] target/riscv: Move zc* out of the experimental properties
Date: Wed, 14 Jun 2023 11:19:19 +1000
Message-Id: <20230614012017.3100663-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Zc* extensions (version 1.0) are ratified.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230510030040.20528-1-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..99ed9cb80e 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1571,6 +1571,14 @@ static Property riscv_cpu_extensions[] = {
 
     DEFINE_PROP_BOOL("zmmul", RISCVCPU, cfg.ext_zmmul, false),
 
+    DEFINE_PROP_BOOL("zca", RISCVCPU, cfg.ext_zca, false),
+    DEFINE_PROP_BOOL("zcb", RISCVCPU, cfg.ext_zcb, false),
+    DEFINE_PROP_BOOL("zcd", RISCVCPU, cfg.ext_zcd, false),
+    DEFINE_PROP_BOOL("zce", RISCVCPU, cfg.ext_zce, false),
+    DEFINE_PROP_BOOL("zcf", RISCVCPU, cfg.ext_zcf, false),
+    DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
+    DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
+
     /* Vendor-specific custom extensions */
     DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
     DEFINE_PROP_BOOL("xtheadbb", RISCVCPU, cfg.ext_xtheadbb, false),
@@ -1588,14 +1596,6 @@ static Property riscv_cpu_extensions[] = {
     /* These are experimental so mark with 'x-' */
     DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
 
-    DEFINE_PROP_BOOL("x-zca", RISCVCPU, cfg.ext_zca, false),
-    DEFINE_PROP_BOOL("x-zcb", RISCVCPU, cfg.ext_zcb, false),
-    DEFINE_PROP_BOOL("x-zcd", RISCVCPU, cfg.ext_zcd, false),
-    DEFINE_PROP_BOOL("x-zce", RISCVCPU, cfg.ext_zce, false),
-    DEFINE_PROP_BOOL("x-zcf", RISCVCPU, cfg.ext_zcf, false),
-    DEFINE_PROP_BOOL("x-zcmp", RISCVCPU, cfg.ext_zcmp, false),
-    DEFINE_PROP_BOOL("x-zcmt", RISCVCPU, cfg.ext_zcmt, false),
-
     /* ePMP 0.9.3 */
     DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
     DEFINE_PROP_BOOL("x-smaia", RISCVCPU, cfg.ext_smaia, false),
-- 
2.40.1


