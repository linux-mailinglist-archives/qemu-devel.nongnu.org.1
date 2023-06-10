Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0104772ABCD
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yht-0004zi-7D; Sat, 10 Jun 2023 09:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhk-0004vj-Iw; Sat, 10 Jun 2023 09:32:33 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhj-0007h0-44; Sat, 10 Jun 2023 09:32:32 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-559409cc490so1772938eaf.3; 
 Sat, 10 Jun 2023 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403949; x=1688995949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WM5AC4EI057sKwaj8PSP53Rp4AVjuqfQdLvCPSu5d0E=;
 b=mf2H4Eq4Pv3OBkhQND/sHZrhauyM5ySv4OEGz2doWmOnqI7Xp8eK7eh+ZEu/PJKJbr
 mUV20ishYnomdA8ZaSnvoDMU6FVijXp0FBHAYyZwOEoQfoPaXFtiWlvBJyFheUD5/BcY
 9s2QYdhIKr8JiCjeBhJq7Hr80RXyPqwZjY9MhDa4JuuKEWPxOODwkrfCCs81xJJSAL16
 ohCHejpCwL00grsVxquXS+ZjAo7PbZ10lkVgvUvl7MtDov2QCLHQ6GgTZqjlSnXqhBNi
 p/DaPe75QgE6/h4SKvmXo78LDZAv7dSyLrwRxOEY0zwQruC8fFvrFxtBQl+6/cL9oFa2
 4BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403949; x=1688995949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WM5AC4EI057sKwaj8PSP53Rp4AVjuqfQdLvCPSu5d0E=;
 b=F7hBXpynws1DAzqm+FcGqMvWAbu5m1TFneSB4mAx5jdpPcLzg8gIcM6+3g4FsNIY5E
 BrYRKQA4QEEkJuc7bPj4R3jcBGJtisYMdUUVpLRpATb6clRUMXBLU96/tZ4cts56sklH
 wr8maMEvdI6gOSUKBlL25PfTOkg/t5Tfgq2TV0cKBGWILEYQ7sH4ZLp2J4/D/SblWryt
 DPQk6hBV4kmibUAtoF/JWZZdCEOHyLGEqCvoNo0Lv+Ovh2o3J2P0q4poTE2CPc+MKnXM
 JcMbBDA4HGVC/+g60HRGhzmGGNQq/0ADMZ+LrjXJprpR09ucPKErZ5VTYExRrCPydXAv
 jrbw==
X-Gm-Message-State: AC+VfDy66gyBbAevfEmzOBVIszE4wb+FHA2rN2RlkPEQ7y7YVjKnovpI
 X9Pmph2+gWd1P+HJeqN90o2wyZy03Ws=
X-Google-Smtp-Source: ACHHUZ4VwzdQG1n814rqKaT9b+7JR8SJCyfmE6/fyBHaYoIMORgV5h902+yn5Q/t0DLmBy3zy1gfCA==
X-Received: by 2002:a05:6808:1b06:b0:39a:abd1:36f5 with SMTP id
 bx6-20020a0568081b0600b0039aabd136f5mr1191338oib.31.1686403948740; 
 Sat, 10 Jun 2023 06:32:28 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:28 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-stable@nongnu.org
Subject: [PULL 20/29] target/ppc: Fix lqarx to set cpu_reserve
Date: Sat, 10 Jun 2023 10:31:23 -0300
Message-Id: <20230610133132.290703-21-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc35.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

lqarx does not set cpu_reserve, which causes stqcx. to never succeed.

Cc: qemu-stable@nongnu.org
Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230605025445.161932-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 37fd431870..452439b729 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3765,6 +3765,7 @@ static void gen_lqarx(DisasContext *ctx)
     tcg_gen_qemu_ld_i128(t16, EA, ctx->mem_idx, DEF_MEMOP(MO_128 | MO_ALIGN));
     tcg_gen_extr_i128_i64(lo, hi, t16);
 
+    tcg_gen_mov_tl(cpu_reserve, EA);
     tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
     tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
 }
-- 
2.40.1


