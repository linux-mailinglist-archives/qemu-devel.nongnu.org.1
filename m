Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14879A3D2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagt-0006nE-PO; Mon, 11 Sep 2023 02:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagq-0006QK-Hr
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:32 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagn-0005I7-Tg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:32 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68cbbff84f6so3530089b3a.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414787; x=1695019587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlgYYuBXPFCdLBsWmioJLqNQ2mwRjae6i2nTBUm3gh8=;
 b=BNZSIa5sbTAHNZLQyMNxF7cMnWjsw5cuH0Qmg9hZXMqyeCPKLJYyxo0qEn+6+a4wG+
 buocdF9R9QX1Qhx1yZmAtcFVNT8tepX1Vei1gWm6pOyn7DCiAA2FGobFbkwIWyCu3PHW
 ijfDH7G0I74pjOGKQFPqUYSqGpsNVKEB+EMNsKNJ/DYlkwk8YQytJx7yTFD06NaPfhuD
 TqGm0tjed1BuR6YMzn2nNI+O30rUOfvkDNzyZBwGQvjXqH/54SGtP0tCXCRIyMxeGj33
 H8nmdAbRPYPpwQJl2etHQy1+78UTAqjQzNTL/670aRTM1RKBAlxhilyN/iZlOwIcF6z3
 kWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414787; x=1695019587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlgYYuBXPFCdLBsWmioJLqNQ2mwRjae6i2nTBUm3gh8=;
 b=X4e7R9vuxMPVM3wkbwLY97Tp2hgNwFmVpAu7ibFDMd8605uCKc97j0QJed0nJiyOaA
 y1EmgNv7Nw2FhF45RMNWw6+jYKRhtczo2Yqv4wT9nGEczHAcd3alwYWX2G6Q5typcAPB
 atQwe3V1R5AtaVZw+rjUV5hc8bqV+jPvH/L6PUxTtkCEidbVdBE68/f5X6f/V+yfYSwZ
 bPzaQEaXeZ1ftFU7MjPrTtY1f4iQZxV5bMj5FrgkBeJ3MMBGuo7lhN4BZ1egV+H9HldI
 oDIuJRlWMXLlW+0RiNqIChwHTA3zAedE9LYpu0PUQNFnXmWYMJeF7KrDBIN1rGru9kmo
 pv5Q==
X-Gm-Message-State: AOJu0YwfJs8k0IEhNkfuyC+M+HLPGEL7tys9DG36xOiGNjdYxXCxVDE1
 epI9b5v9EGE+4ggE1/9BElX3MouSvWLAxQ==
X-Google-Smtp-Source: AGHT+IGxiw5U9K5wkqC0od1JVaTG5c6BbhNBMEbIor/k6p3Lq6UuIzt1kIkIziV2LtfJx98XafuoZQ==
X-Received: by 2002:a05:6a21:a58c:b0:153:4ea6:d12e with SMTP id
 gd12-20020a056a21a58c00b001534ea6d12emr12374831pzc.17.1694414786970; 
 Sun, 10 Sep 2023 23:46:26 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 44/45] target/riscv: Align the AIA model to v1.0 ratified
 spec
Date: Mon, 11 Sep 2023 16:43:19 +1000
Message-ID: <20230911064320.939791-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

From: Tommy Wu <tommy.wu@sifive.com>

According to the new spec, when vsiselect has a reserved value, attempts
from M-mode or HS-mode to access vsireg, or from VS-mode to access
sireg, should preferably raise an illegal instruction exception.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Message-ID: <20230816061647.600672-1-tommy.wu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 63c3b0d9fc..68eecc3c96 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1684,7 +1684,7 @@ static int rmw_iprio(target_ulong xlen,
 static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
                      target_ulong new_val, target_ulong wr_mask)
 {
-    bool virt;
+    bool virt, isel_reserved;
     uint8_t *iprio;
     int ret = -EINVAL;
     target_ulong priv, isel, vgein;
@@ -1694,6 +1694,7 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
 
     /* Decode register details from CSR number */
     virt = false;
+    isel_reserved = false;
     switch (csrno) {
     case CSR_MIREG:
         iprio = env->miprio;
@@ -1738,11 +1739,13 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
                                                   riscv_cpu_mxl_bits(env)),
                                     val, new_val, wr_mask);
         }
+    } else {
+        isel_reserved = true;
     }
 
 done:
     if (ret) {
-        return (env->virt_enabled && virt) ?
+        return (env->virt_enabled && virt && !isel_reserved) ?
                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
     }
     return RISCV_EXCP_NONE;
-- 
2.41.0


