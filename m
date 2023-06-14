Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AEA72F1EA
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEG-0002dY-7N; Tue, 13 Jun 2023 21:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDk-0001ku-Ub
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:52 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FDi-0004on-Ge
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:22:47 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-3f9b4a656deso14821681cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705765; x=1689297765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aemvDyGc71mNfU6yn/5fWC1VlV9bSKyyBYWGZCE4Qyc=;
 b=QZMLl2EC1jOK2qGrk3gR1H+w3sLR/LRYSnb3xITLkoleM8firM2oTnhNG6Lay5wP9a
 ieSy35SMPYuMTTsBhtHfDgLOQkTJaRJW9eFgcmeLDEDA7D1/hSP8LgXEcLIBEGyj8+0h
 PWRdwpeehX/cPbyXz5uP77fOGLHA1Pm0wvIYy/Yd2kvWIDygQ9xWhaZyrw4lcfVN6RrW
 DbRfo6uGU0v9rbsllSn5x5Ne+2UcHUbDrJBco+A4UDe0gEtbSgOhdl3DXRZh/yFW5zsw
 2fjsxSqvbR38OFm9r9mYJqcs3NwsdQeuW5Oq3I29kBBCNyNS6ivMdmrU/4CC9Y5dUJZM
 FpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705765; x=1689297765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aemvDyGc71mNfU6yn/5fWC1VlV9bSKyyBYWGZCE4Qyc=;
 b=Cv5Q0AxaM933fOsm6FI9s1u3NJ43Tm1cp66mxgSazRBDtIywRC5VSdPbllZReqjoC0
 mQF8mpm+0EMkOy4WC4nFaISmzM6sBROiNoJbFW0NyTVsLqheNJIKtMN73nyXrLf7o90u
 403tRCu/UER36bLQKbObz661bP0pOjN9HigUtv7XaTVY61nXtYgf4tHvKhf9L/xoTGWG
 L/yfYmaFSDo/0+H95Sp2f+mXT9HBFHR+TUrzxKotbKEygynP9iqNCAs7yBLX9suHIM4r
 OEwbWcGbr4vGrUJ6QMP3uu9Q89z0m/Z21l186LSmZuWSNyeHu99onFRJY9/6sR2wkdLJ
 l6Xw==
X-Gm-Message-State: AC+VfDy8xRFNrdtJkgVs5ZXSr9ht7d3y6ZrRurq4wr2SbPvpgx+daumv
 O+N/005M1Pjb4B6wcAGGBr+JfW6QezXBcw==
X-Google-Smtp-Source: ACHHUZ6DiRyeX1GYntTchc5LSM0oF27NfB4u9G4IpaRJFxvuDwfYYiSYzYv0LhEuzxoQqG+MO485Aw==
X-Received: by 2002:a05:622a:113:b0:3f9:ab64:8bd1 with SMTP id
 u19-20020a05622a011300b003f9ab648bd1mr720081qtw.7.1686705765229; 
 Tue, 13 Jun 2023 18:22:45 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:22:44 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 33/60] target/riscv: Update cur_pmmask/base when xl changes
Date: Wed, 14 Jun 2023 11:19:50 +1000
Message-Id: <20230614012017.3100663-34-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x835.google.com
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

write_mstatus() can only change current xl when in debug mode.
And we need update cur_pmmask/base in this case.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Message-Id: <20230524015933.17349-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index cf7da4f87f..ad73691878 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1324,8 +1324,15 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
         mstatus = set_field(mstatus, MSTATUS64_SXL, xl);
     }
     env->mstatus = mstatus;
-    env->xl = cpu_recompute_xl(env);
 
+    /*
+     * Except in debug mode, UXL/SXL can only be modified by higher
+     * privilege mode. So xl will not be changed in normal mode.
+     */
+    if (env->debugger) {
+        env->xl = cpu_recompute_xl(env);
+        riscv_cpu_update_mask(env);
+    }
     return RISCV_EXCP_NONE;
 }
 
-- 
2.40.1


