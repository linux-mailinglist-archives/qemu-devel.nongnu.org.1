Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F628783D5C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 11:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYO3S-0008N9-1u; Tue, 22 Aug 2023 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYO3P-0008MP-7T
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:52:03 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYO3N-0004aU-2D
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 05:52:03 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef5809999so11294505e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 02:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697919; x=1693302719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=10kcRy9z1cKJEzX7FuFBXFhfePOgoiTUdtJrOcIYFcs=;
 b=mn1QR9C33jqIHvzU7XC3AO8rSywqi5U2/WCVD1YM4QcCopID1heZ4OhWFeC3crAIpQ
 L3vZAQ9e7wRzqtGNIH3M9C5EvT0vuhTNJkBR5T/afC3+M+/o+xLtigzyPsjRpIkmF2cV
 KPzPIvh5dtkZH7C4nwvwZ7bCXw3xPwuq/5gmkontOdd3fIGtMxur8rn16zKWLNrg266P
 GmKFBfWxpsmaOy3lLXkn+IfT/HeoWVj52gMS3e27WrYFb8+35z9Z/Cgrm5RY46CO54SB
 dXghuOSRFZocjmknuFDW4oPhOrDP9FBSKzZFBjxe+87SOA0wV0gL5IpOR5aaNPvSGxC1
 n8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697919; x=1693302719;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10kcRy9z1cKJEzX7FuFBXFhfePOgoiTUdtJrOcIYFcs=;
 b=GI+/XlLts1N4gTj0weYNR0H4ar5/nsiqD1a2aruhSu9gtZpSxCljAgTPVEcPBfxhSZ
 vdWJpYxuc0QGW43GcFQmuGDsw4GqH+LmdxmLQdpuriBtM5b78D5n8zSI5ZzEqK9lqhbW
 nVfML6gYRowCzq8+7iN9OB1yjSativcVWBX9uoWWphey49kUkd6j7WwVG+G4ud2MoQuC
 78AmBZpZAXP00ItrToNtaulYeb+Gza3n2UDlc1rtYQtRIrAtpFtYHKzeS5hXtvIato3B
 ihnIibh1lZ6ED3KMgp+X9KOt2AFl8MPWJDyROB8nPgjMNT3e1CGl7JCeADG0MLJutV+6
 ui7w==
X-Gm-Message-State: AOJu0Yx3Z/UiCffa82lJkl/0e6KZzrYNFJPbqfiwc8bCJG18n+ayV1JW
 QH4yr1+6k5iGcRn1HPIZyjofCCh+ZGzKHuSFB4J9sA==
X-Google-Smtp-Source: AGHT+IGzh92D+N67oXL54aq5UqAvwzPrWnH4+bdYDIN/PAaUXz0dqmPaHwyIp7H4T4u/3ry+OfZb/g==
X-Received: by 2002:adf:e7cd:0:b0:30e:19a8:4b0a with SMTP id
 e13-20020adfe7cd000000b0030e19a84b0amr6646848wrn.2.1692697919378; 
 Tue, 22 Aug 2023 02:51:59 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d6304000000b0031431fb40fasm15315882wru.89.2023.08.22.02.51.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 02:51:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/arm: Use deposit_z() in BCF opcode
Date: Tue, 22 Aug 2023 11:51:56 +0200
Message-ID: <20230822095156.39868-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When clearing a bitfield we don't need to lead the
source register. Use deposit_z_i32() with the BFC
opcode to save a load_reg() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index b71ac2d0d5..1a6938d1b3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -7255,7 +7255,7 @@ static bool trans_UBFX(DisasContext *s, arg_UBFX *a)
 static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
 {
     int msb = a->msb, lsb = a->lsb;
-    TCGv_i32 t_in, t_rd;
+    TCGv_i32 t_rd;
     int width;
 
     if (!ENABLE_ARCH_6T2) {
@@ -7268,15 +7268,14 @@ static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
     }
 
     width = msb + 1 - lsb;
+    t_rd = load_reg(s, a->rd);
     if (a->rn == 15) {
         /* BFC */
-        t_in = tcg_constant_i32(0);
+        tcg_gen_deposit_z_i32(t_rd, t_rd, lsb, width);
     } else {
         /* BFI */
-        t_in = load_reg(s, a->rn);
+        tcg_gen_deposit_i32(t_rd, t_rd, load_reg(s, a->rn), lsb, width);
     }
-    t_rd = load_reg(s, a->rd);
-    tcg_gen_deposit_i32(t_rd, t_rd, t_in, lsb, width);
     store_reg(s, a->rd, t_rd);
     return true;
 }
-- 
2.41.0


