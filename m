Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E7674D5C3
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:37:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4c-0000UP-NO; Mon, 10 Jul 2023 08:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4T-0000Bc-Jr
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4R-0003Ew-Uq
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:53 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2657d405ad5so2637566a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992370; x=1691584370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0HJ38mvZWdcRPufdY/ppw8c6Oox15uKrnAieTUs0kI=;
 b=HIOfMsdfwp2r2PF70YuL+2KTpA5qVfusi7Iwb2R9/lz/4fK9pPccyEWx/AnDMM/gcz
 bP2mZrZmjmBm2Ppfxi3fDZvt8aaMI/ms637gFv5j3vP+OVMht0Mt9rLirJwEKmGzk9BT
 O8TyP9fb3yRNDh5Z4p8lghjojYOtHMHAqZ5QM6Eo55hoXz8QqoDZ+mxVHLBztuxfX0Np
 bCZx1pHoqKdYsaEIEy1QwfYPPagBrEp7e/AAVu328jToa2F1Bd+BjxrTkR1MGJ4sP6gj
 jnj0k0nFJXQN9kJWTrOkYWFz7j+ddn3L8vM5x9eR6LyptLwIPsSeBqrF5OQJ0OT8MvG0
 rzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992370; x=1691584370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0HJ38mvZWdcRPufdY/ppw8c6Oox15uKrnAieTUs0kI=;
 b=Jn7JcdpRHEPjeAq7vmk6UHQ1h7EVJW940ZguMPHOsi0OPhrOciBdAuUdI4sT6NgV2J
 jVBepntAbQ7vXpT6+po+UirzOnBXP4Lrt2NLqYjG/o3TuWaJOhRHN611JfZz9JlonKMk
 BufNwcHUYAgIVDk1zBTy2UPaXoa2Fts4CjM8x1rWRDfTDMbeAXI1fy8lfGNnGS4uzQak
 28/qYMxZhiowvi3/flQTFrFVA2siLZQlrVxk0ezhPWdl8LqtBf6M18Q23AeJ1UpT4Fr+
 uKhIrTN6rHb3JX6O+Ouaa1EQS+nu/v6haz71HAUjhv7ECMWie2cZg3gFHKLlx0x3AumW
 pMPg==
X-Gm-Message-State: ABy/qLa0bQ6yITw/rPKbOcWjBwv9F7xGPeg1AltdTJRLHoXwoyg8tVon
 Qy9xAFGoiUslYOmu+nhAgWEjD4WmKwKnHw==
X-Google-Smtp-Source: APBJJlH46s5knuzqOImOMSe1WyuA7JUuhH5+z4uGLD9+nhhQZNBi6IxLyortt2BaUZdeLgkstJrRGw==
X-Received: by 2002:a17:90a:c285:b0:263:41d2:4e2 with SMTP id
 f5-20020a17090ac28500b0026341d204e2mr13580959pjt.32.1688992370330; 
 Mon, 10 Jul 2023 05:32:50 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:49 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 09/54] target/riscv: Make MPV only work when MPP != PRV_M
Date: Mon, 10 Jul 2023 22:31:20 +1000
Message-Id: <20230710123205.2441106-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1033.google.com
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

Upon MRET or explicit memory access with MPRV=1, MPV should be ignored
when MPP=PRV_M.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230603134236.15719-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 3 ++-
 target/riscv/op_helper.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index a944f25694..8e3c73da52 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -47,7 +47,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
 
         if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
             mode = get_field(env->mstatus, MSTATUS_MPP);
-            virt = get_field(env->mstatus, MSTATUS_MPV);
+            virt = get_field(env->mstatus, MSTATUS_MPV) &&
+                   (mode != PRV_M);
             if (virt) {
                 status = env->vsstatus;
             }
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index f563dc3981..9cdb9cdd06 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -335,7 +335,8 @@ target_ulong helper_mret(CPURISCVState *env)
         riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
     }
 
-    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV);
+    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
+                             (prev_priv != PRV_M);
     mstatus = set_field(mstatus, MSTATUS_MIE,
                         get_field(mstatus, MSTATUS_MPIE));
     mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
-- 
2.40.1


