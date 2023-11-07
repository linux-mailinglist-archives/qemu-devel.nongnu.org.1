Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780397E330F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Bt6-00019m-6f; Mon, 06 Nov 2023 21:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bt4-00010K-BM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:18 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Bt2-00031n-K5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:18 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso41396885ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324335; x=1699929135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erqd+l+fzQhSfauewn02ii3sJHEel69Pt/k03i9RRP0=;
 b=O0Z2986tqQ1UIF31CjscoWh4uKq0A2WJFWVD2QD7p3htUMkjTJkUX0d6zXMIjgHQkX
 wXR8yifvXW8llXmEBUnjISg+Lxaff4py/+JIcHIX1N8Jo70+DosC9+heCuODv/6yaMsV
 I535HK71TfdNzXOafubKMh3o1LemNJiKxmUb6WD3fg+k2qnFHLFaigjdQn1MUNUBxVxw
 Ogpoe1ojb8r4tuL5pCDABAdpOyocUpy5CT96mRitoEe8UnIKx+0a+wEtAPZ9RBHPvZcy
 GsntXn7AIyihgkoa3TGMoRv/vLKInVzlI+eNr4SdejRwaCH8OXDhCfvflXD3qWin+c31
 VhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324335; x=1699929135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erqd+l+fzQhSfauewn02ii3sJHEel69Pt/k03i9RRP0=;
 b=wtRJXRUHYqoxpjkjPMW+eCtW1UR66mRUFZyFAl33Cv1nQ0GnsZXOBq4+zpL5qXQhEQ
 2VD/J+gXVwfHFXz/TaiI7ZfFGRWGp6adbabNY+jj0+sQbN1XARuPyQd0evfvWpl1gRFt
 49oq9Z3qZkLQPZbUHyG26WaZjxGdOFl919TSXPGsaZB3NyvtZPbq/cSDvRf4HY4sIqov
 d9VB6KVP2UJVyzkCYZFddfqapfLOPeT36cbwE1WLvlDC24nz8TWHfx7kXuFN+jJJvQho
 C32cRQ3FEK4Nd1VJdHpwoGxb2kjezehJmylRID1nw2KFfphAdOgpdkRWpovIImg6mxch
 viHQ==
X-Gm-Message-State: AOJu0YwCifaq0OiLSjnGR5ecm0gJNe1CC0bvujGHLMpqj9dm2z2ULJ1p
 i5UlGvhVamM/Xm247O0RXoS75RmiCIZnqw==
X-Google-Smtp-Source: AGHT+IFO07yDGTuP4WTYMg6wrA4/5Y+MENn2CydVU1RK7g478LVpB3PqMNEzGFlsOFc9qIPreD+JEQ==
X-Received: by 2002:a17:903:44b:b0:1cc:419e:cb4b with SMTP id
 iw11-20020a170903044b00b001cc419ecb4bmr1568125plb.19.1699324335010; 
 Mon, 06 Nov 2023 18:32:15 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:14 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 40/49] disas/riscv: Add rv_codec_vror_vi for vror.vi
Date: Tue,  7 Nov 2023 12:29:36 +1000
Message-ID: <20231107022946.1055027-41-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
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

From: Max Chou <max.chou@sifive.com>

Add rv_codec_vror_vi for the vector crypto instruction - vror.vi.
The rotate amount of vror.vi is defined by combining seperated bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231026151828.754279-13-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h |  1 +
 disas/riscv.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index b242d73b25..19e5ed2ce6 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -152,6 +152,7 @@ typedef enum {
     rv_codec_v_i,
     rv_codec_vsetvli,
     rv_codec_vsetivli,
+    rv_codec_vror_vi,
     rv_codec_zcb_ext,
     rv_codec_zcb_mul,
     rv_codec_zcb_lb,
diff --git a/disas/riscv.c b/disas/riscv.c
index 8e89e1d115..ec33e447f5 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4011,6 +4011,12 @@ static uint32_t operand_vzimm10(rv_inst inst)
     return (inst << 34) >> 54;
 }
 
+static uint32_t operand_vzimm6(rv_inst inst)
+{
+    return ((inst << 37) >> 63) << 5 |
+        ((inst << 44) >> 59);
+}
+
 static uint32_t operand_bs(rv_inst inst)
 {
     return (inst << 32) >> 62;
@@ -4393,6 +4399,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = operand_vimm(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_vror_vi:
+        dec->rd = operand_rd(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_vzimm6(inst);
+        dec->vm = operand_vm(inst);
+        break;
     case rv_codec_vsetvli:
         dec->rd = operand_rd(inst);
         dec->rs1 = operand_rs1(inst);
@@ -4677,7 +4689,7 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
             append(buf, tmp, buflen);
             break;
         case 'u':
-            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b11111));
+            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b111111));
             append(buf, tmp, buflen);
             break;
         case 'j':
-- 
2.41.0


