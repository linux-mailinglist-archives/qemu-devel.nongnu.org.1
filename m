Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E758F721C48
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 04:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60Mz-0008Gm-VH; Sun, 04 Jun 2023 22:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60Mx-0008GK-Ue; Sun, 04 Jun 2023 22:54:55 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60Mw-0002Zi-IB; Sun, 04 Jun 2023 22:54:55 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-3f6bb5e8ed2so40148561cf.0; 
 Sun, 04 Jun 2023 19:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685933692; x=1688525692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AeZXOyQylFlG6KYz/839KfYIGXXWTOf2hQB/qcExI2Q=;
 b=SqNZslX7s/5PkuwUXsssvxxKbmxiwkIJykhBIpTf8Fyh66En3gN+wRUUWqYrplH2yQ
 o+is9gpx3aZaowKZ6p7QSG1OcB1KEh7I7hyw+lD0Nkk5BpbqbMd4phUGy3nnFEidkCbB
 r/IHGOu+vM4VMeb0n81o3XsuQlkz/rNtTc5EatH52PiXwcCKLxj1oMWcEisISJv+3jSY
 4WWjYFOHQC4qhFWSokq0UDdzMM/QEy3sdnFS2syJOWd/MzG+E7vdm9yDjkeJ+bDXPb76
 xoOez9yHGV/FkdzK6tXtKRFkRL+wU/8COjXj0qsdj+v4TWwsxFMkYwbT8mFpgkbuj9RS
 97zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685933692; x=1688525692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AeZXOyQylFlG6KYz/839KfYIGXXWTOf2hQB/qcExI2Q=;
 b=k5BxSLk5l5m/8L5EwyjI4GkD1eDeVX0ZeM8YJtDbgYZDffHHhHifNr0BMXJFRj5YHX
 8gPERpNwOATU04egQLoNWcQMmt0iY+GzVCjef3kd0azgGwUnaQdphUl1xdljOC90ARd1
 /oWAy9hcTNJycBVaeFBaW8FseYHupMrYAPrg5y9UCeSlgBooi4OIBwl3zYabyImGWJ+B
 YHv6qYkDBVflvO+bAq4b14LOqJuIBJfpTtnkifPg1Air3zIHyn0jO8gi3+/zNWk5sjPV
 oUgI8U3dpdTZqvBbM3R5h1XI0NfCyskVyJshc9BMRGu5z5UuUoIA2B5qOUIIvKtSBGJu
 Spow==
X-Gm-Message-State: AC+VfDyIGdMIdjVfY5MZwLa6OQ3hA6mYLXiY3BFI2dp0phfF87YnfE+D
 NqpY6NRVO10PtrFQ1Fk3kNA=
X-Google-Smtp-Source: ACHHUZ4Veg1sZlI/8RPBJQ6+pMYGQUxbtw/OtzKelPXA9xuuxys/d7XtLBjAea9QpFUOCRetQqg9uA==
X-Received: by 2002:ad4:5dee:0:b0:626:f3d:9e46 with SMTP id
 jn14-20020ad45dee000000b006260f3d9e46mr7090010qvb.18.1685933692562; 
 Sun, 04 Jun 2023 19:54:52 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902c74500b001ae59169f05sm5316778plq.182.2023.06.04.19.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 19:54:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 1/4] target/ppc: Fix lqarx to set cpu_reserve
Date: Mon,  5 Jun 2023 12:54:42 +1000
Message-Id: <20230605025445.161932-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=npiggin@gmail.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

lqarx does not set cpu_reserve, which causes stqcx. to never succeed.

Cc: qemu-stable@nongnu.org
Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2:
- Fix bugs vs memory access fault [Richard]

 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3650d2985d..7a5bf1d820 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3881,6 +3881,7 @@ static void gen_lqarx(DisasContext *ctx)
     tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
     tcg_gen_extr_i128_i64(lo, hi, t16);
 
+    tcg_gen_mov_tl(cpu_reserve, EA);
     tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
     tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
 }
-- 
2.40.1


