Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAE17380A9
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:10:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvio-00047T-BW; Wed, 21 Jun 2023 07:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBvih-00040N-Ph; Wed, 21 Jun 2023 07:09:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBvig-0000Qb-4I; Wed, 21 Jun 2023 07:09:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-66767d628e2so2165444b3a.2; 
 Wed, 21 Jun 2023 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687345788; x=1689937788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V3flM4LfZjqSEsYEJbnnNk50fkdmZyFjvr4+WMqMQYQ=;
 b=JUCiuTCFijO5pekNgDFFCeRvoct1H2m2e+BghW07RHdzzI9cNC0FxrbIMSZtL+U6fw
 YOX92W/LqLemoNZYumsK3sMAQc2Wm6uXktSsv1qfAqi6RwuiDHIHY4ewdkTUq6cSOXJY
 tSU6aDJz/wiH9ke86TWV4N+zEt8B79YPAbzjvQSgcC6wcvyMctHJ0xEcPIsUJlaomst0
 1qDard+LQA7qjmfMVnTgJFuu8p8d26E/7XUJWPSqvZ5g2E0/p7FxgQKqSpycSWaVbKZR
 KQ4hdEedlr9Te8J4Vcau4wkCKPYNfHqYv6OhUXCexqXiuxuVFez7BxBLZoz7Yz/MZyBT
 3zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687345788; x=1689937788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V3flM4LfZjqSEsYEJbnnNk50fkdmZyFjvr4+WMqMQYQ=;
 b=SiU3+MwrYGsvC5JU3Kpd1/aasCQ2NsvflKdfIH+jTAZBkzsegJ53cggD1H/u20vrHb
 /uQBUIQ1FxJnZt7c/PayEfC1NJrrFc105uFvuSgTE7m+1q8YosIBrRxFLBd7mJ/9TyPu
 ePZ9hvgax7gSwPAWx6xaR1/bDzoOsUHavV9RG9j4y8vly0OXUsqK8pksMu4d4LyNKoSf
 R2Id5gsbC8DHV8hBe1MEkLTDqxD7FiUyDa72jBMsHFoN5RP+txbqnuakoxYtm9Xd2xek
 GVU69T2jtFfB7Bw52rcOANne4zTAb7X91O97tL6B2/ekwVUatSW5bnDuhRkLOEXWoT92
 ypKw==
X-Gm-Message-State: AC+VfDwrRPzm3vQsRSnBoW8RxW5C4IsUEazuhWIB0TrrxElRbyCKag4D
 v0h6JrC/cM3/kaGWX+zJihq+ukYTY0g=
X-Google-Smtp-Source: ACHHUZ5BZYy5uujNmIt+IPC7BgiAa1wee1h4d9m1b29aRlUCA7q5OzxhXh4D6ajH9n2S+a+rNw19Qw==
X-Received: by 2002:a05:6a20:c18f:b0:11f:6d4c:f54f with SMTP id
 bg15-20020a056a20c18f00b0011f6d4cf54fmr8627703pzb.33.1687345787959; 
 Wed, 21 Jun 2023 04:09:47 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 m2-20020aa79002000000b0064d1d8fd24asm2725133pfo.60.2023.06.21.04.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 04:09:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH] target/ppc: Fix sc instruction handling of LEV field
Date: Wed, 21 Jun 2023 21:09:38 +1000
Message-Id: <20230621110938.239066-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

The top bits of the LEV field of the sc instruction are to be treated as
as a reserved field rather than a reserved value, meaning LEV is
effectively the bottom bit. LEV=0xF should be treated as LEV=1 and be
a hypercall, for example.

This changes the instruction execution to just set lev from the low bit
of the field. Processors which don't support the LEV field will continue
to ignore it.

ISA v3.1 defines LEV to be 2 bits, in order to add the 'sc 2' ultracall
instruction. TCG does not support Ultravisor, so don't worry about
that bit.

Suggested-by: "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This should probably go ahead of the ISA 3.1 LEV in SRR1 patch. I
don't think they need to be backported to stable though, have not
caused any real problems.

Thanks to Harsh for spotting it.

Thanks,
Nick

 target/ppc/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 15a00bd4fa..3c62f9188a 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4424,7 +4424,12 @@ static void gen_sc(DisasContext *ctx)
 {
     uint32_t lev;
 
-    lev = (ctx->opcode >> 5) & 0x7F;
+    /*
+     * LEV is a 7-bit field, but the top 6 bits are treated as a reserved
+     * field (i.e., ignored). ISA v3.1 changes that to 5 bits, but that is
+     * for Ultravisor which TCG does not support, so just ignore the top 6.
+     */
+    lev = (ctx->opcode >> 5) & 0x1;
     gen_exception_err(ctx, POWERPC_SYSCALL, lev);
 }
 
-- 
2.40.1


