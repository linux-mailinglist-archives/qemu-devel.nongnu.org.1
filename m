Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACF87E330D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BtL-0001z4-IA; Mon, 06 Nov 2023 21:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtD-0001u0-3Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:27 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BtA-00032V-IH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:32:26 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so42015525ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324342; x=1699929142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mrZ5mxg7lpwxJSPkoOF7DsBsJR5EAPVhYW5v2dN1p8=;
 b=iRGIIKgyHjwTkDaF39PV7L8vST4LlNp9ITIeNPa5fKY4OnNxgKLajDmYBUaRGXPe9D
 JDmXRACHplrOI3VXfiIN3MoPDk7JR/1scWx2z6ZxVNzmiuI2ECyvQFf7UuxC2O3LRFpg
 zlF8nfQnpnwKzcbHmV70JvdZtvN5JlhCV1IEv5z1uq6ZRkSefXsLuJ/LPvByEt0HIx7D
 9MZ/6XUaUOkHOeszIREtjalteSr+6g9+VGd6LlON0g8xB4XqeYK4dGfuWwZQ2fLnslym
 0V+0y2hmSuifSD2VvqsbYEsqOO+0blsIhg4Ol7GR9XRUckp/SwbRWAbGQ0MLfPo6VLLl
 55zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324342; x=1699929142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mrZ5mxg7lpwxJSPkoOF7DsBsJR5EAPVhYW5v2dN1p8=;
 b=K7yduKlv9NFvwY7FdqaIQWBaIYE7PItnp50pBT9Iha/v+hStS07PAPTuzESjR27Eg3
 k9rb9b/wJ2xFi8qJR6CoTz4Eg8Q42VPBSadHdCF316dx6rBE8x8c/xJae7WYCTI2Qi+Y
 CE7aPGMSGhR3x04tULTf+LN+VmDZTIy+n2HXzWSbzSUqpSRG1O54CjOC3j5o0/vBR0st
 nhr1zve0PZ4LdAtqoef83uZHXjXtK4pfcASDdIVXCKq5C4azvLKimuBIQJ8hQctCHL5G
 5R3PS5Zb7GfF36Ywe3/HnorBu4Fz75xFEPOlJSVK3JA0UKRkw+KkGwJzFjfB5+YBAQEo
 qftg==
X-Gm-Message-State: AOJu0YylbfRSD9RvUzmBnh4DyHP0rFvLjWvKPuSZiEUiQrGG8eVtLEk2
 VhX7QpqeYzaidVN/qR8sGKPC912eQYy8zg==
X-Google-Smtp-Source: AGHT+IHNipqixmZVEp0QCedKclbFpgD1Y46R7PgE4gWqvH/sOxt6nbUAC75mGH+vgN9iLgFySiZG+g==
X-Received: by 2002:a17:902:d50f:b0:1cc:4e9f:d27 with SMTP id
 b15-20020a170902d50f00b001cc4e9f0d27mr23381818plg.1.1699324341853; 
 Mon, 06 Nov 2023 18:32:21 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:32:21 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 42/49] disas/riscv: Replace TABs with space
Date: Tue,  7 Nov 2023 12:29:38 +1000
Message-ID: <20231107022946.1055027-43-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

Replaces TABs with spaces, making sure to have a consistent coding style
of 4 space indentations.

Signed-off-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231026151828.754279-15-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7ea6ea050e..e9458e574b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -3136,12 +3136,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 89:
-		switch (((inst >> 12) & 0b111)) {
+                switch (((inst >> 12) & 0b111)) {
                 case 0: op = rv_op_fmvp_d_x; break;
                 }
                 break;
             case 91:
-		switch (((inst >> 12) & 0b111)) {
+                switch (((inst >> 12) & 0b111)) {
                 case 0: op = rv_op_fmvp_q_x; break;
                 }
                 break;
@@ -4579,7 +4579,7 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         break;
     case rv_codec_zcmt_jt:
         dec->imm = operand_tbl_index(inst);
-	break;
+        break;
     case rv_codec_fli:
         dec->rd = operand_rd(inst);
         dec->imm = operand_rs1(inst);
-- 
2.41.0


