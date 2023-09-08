Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0907981DF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUej-0000kJ-Qh; Fri, 08 Sep 2023 02:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUei-0000cF-2M
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:48 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUef-00081u-JZ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:47 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-565334377d0so1426091a12.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153264; x=1694758064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5JLWmPdFOmmnVJajydlQuEvlPHJIdopD5Tg6fXJfks=;
 b=GE6Jd1GgGDOe+3d6YpA2aLT5vJ4lYdO7t6rCsO5OsnFyvkdC6T0MhewkimTlhVEQNj
 tNv0dZO7/Udrt3mPTRaK5X7quS4IwZpZSNHqk/uvkXSizYhdc/AHea6Kdvd61GQUWhPs
 Eq1z9bkAKfeXySHpnZ2qZMkN7tyGfoxzXUYRxdFjH4loxuVX6uGBAACk6SV0xVYxSX/M
 iA/Y5wMhN8QPRD7Cxn+9OwUrMorYc/9I7z4gGeb0PSwXbWMKpSjlt7/HKpOeEtj81bnZ
 8G3ksyLT0WSLnMcs0OcfOyBB34q29j0M/e8rba9s8u5cUGt6DOuaSqg145T3vzaLAGbc
 vBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153264; x=1694758064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5JLWmPdFOmmnVJajydlQuEvlPHJIdopD5Tg6fXJfks=;
 b=bz787jr2ZlOp310jgLFEosN93snjMu+BoX/84jjr4aUQQz0eQ2Ktf7a0+gb7RRh6nh
 ka9Pq8p+xecxUf+sknGI1npBWW+KmgPuJiOp0Ydh5kx0slDPv0izGnusllx2G3cpMjvY
 itAsxaTV5QqiAtayHcf+XA9t+ZtqXnXBDIa3GgqLE/I6cbn9Q4vX+N6T2/5tw7L2YTM9
 U2qFdxza5lYihvPnDxml3it5Z+H/ncjdV0EBjIZuui2QHXPzY4dHApJrrVKpyN/5Wl4W
 sgIVhfJGHja3YsocyedwLhi0YfQ8vAVZRDFk7NQnZvxHIgFHSiz0TqSLIA6660WeC93+
 l2Ng==
X-Gm-Message-State: AOJu0Yy6SVQGUSwsZJITY2mfWRWrYbBq9YKfahofekJKUHgBiLp3wFkc
 0qsZwY7M615pIZJopIRiSxjjS+J2H7Sf/vrb
X-Google-Smtp-Source: AGHT+IGRijk7AxuqhJNptjrx84tSuCq7e4vJcX+YUpXeQNk66EqLJfsaZWa/DPY4ydZhI8N9l4V6Cw==
X-Received: by 2002:a05:6a20:7d84:b0:132:ff57:7fab with SMTP id
 v4-20020a056a207d8400b00132ff577fabmr2404840pzj.2.1694153263827; 
 Thu, 07 Sep 2023 23:07:43 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/65] target/riscv: Align the AIA model to v1.0 ratified spec
Date: Fri,  8 Sep 2023 16:04:10 +1000
Message-ID: <20230908060431.1903919-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
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
index b8e0d0cb4c..4a0f6a89be 100644
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


