Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52E272F1BB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FF8-0004M4-Tv; Tue, 13 Jun 2023 21:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEc-0003ji-IL
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:42 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEa-0004vx-VZ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:42 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-66654d019d4so96834b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705819; x=1689297819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzk2t25roGtJz5SilALeUUpd4fqOids17UWjqjed8ow=;
 b=NbznUwXi7+4Ng4PRIe+tkS7oRXEGGgoE0DCvH6+6oM5HgHNAHkP9ceuHtdOSNGpoVp
 COrqNJd4ZtdH2+is4Mwhfi12Zg4LZEHujAq4Rw74tjh9UY5s996Po0toh2A60usg+J22
 uhoRX9UICpB+5B7xmEmkOBjswWVts+SbwvZKJ3zN/124HRm/MeghLsJsoPbCT44wgUHf
 9GhQ8x+lSxoOH7gyqwNP58E+wshJnw/9FkZE/CHJsf1J1wrZR8pKWMBAQ0a/2JZiGLO/
 9D44C6otu+3LgKb6TMFcC+euoieXWfXE4wEC5JkxPGeTz0rJpkNpVsE4c/05Cy7NY9Lc
 ABiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705819; x=1689297819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzk2t25roGtJz5SilALeUUpd4fqOids17UWjqjed8ow=;
 b=JxqGaWpA9BkZ7fIr6WexR5QX2uK2moEXQR3VhoBXptuxcFb+VZcehEPhjj1q0OoT40
 MmFYTv54oBRL5Qou0GyobiGC6CQCDZ9J3jGYpwGkSMnnB2NRoQ8v6nzAWYCd/VwmOKhW
 ZcMHQUpt6ry45WwqeEuzesBvn/a4s4HwRgj+30Q1l9nTvu/bxeG334lGy4XtC6D6Q4I2
 dd8CbgiR51obJKkXwWVDjFy07BOaN0uS0Clyaw900i383Ci8rwib/EDYJbTRObUny5y0
 bIBIDTgsMdgzmRhu48UaMSya9ipcWFCeqUh0ZfcqG2bzNWArJlnBkHanIOxupmda9KS5
 86Pw==
X-Gm-Message-State: AC+VfDwsItfEIe4o3xlVXZn4MFImMPAvmJ9fAkKxW3SfFg7tqTryEiPD
 v9m4id0aNAd7h3+DBcw4057m+ODrAJnomw==
X-Google-Smtp-Source: ACHHUZ4GlYFAAWpUdAew6NWGKp4IxJvBjQX6uq3C4R+r42jj/CKO56jgWSdxKtJ/kF86N8heGeDlqA==
X-Received: by 2002:a05:6a20:7d9f:b0:10a:b812:bcc7 with SMTP id
 v31-20020a056a207d9f00b0010ab812bcc7mr268798pzj.17.1686705819550; 
 Tue, 13 Jun 2023 18:23:39 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 46/60] target/riscv: Introduce cur_insn_len into DisasContext
Date: Wed, 14 Jun 2023 11:20:03 +1000
Message-Id: <20230614012017.3100663-47-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
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

Use cur_insn_len to store the length of the current instruction to
prepare for PC-relative translation.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 6fbdb50c5d..ea63d20eef 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -61,6 +61,7 @@ typedef struct DisasContext {
     DisasContextBase base;
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
+    target_ulong cur_insn_len;
     target_ulong priv_ver;
     RISCVMXL misa_mxl_max;
     RISCVMXL xl;
@@ -1116,8 +1117,9 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
     };
 
     ctx->virt_inst_excp = false;
+    ctx->cur_insn_len = insn_len(opcode);
     /* Check for compressed insn */
-    if (insn_len(opcode) == 2) {
+    if (ctx->cur_insn_len == 2) {
         ctx->opcode = opcode;
         ctx->pc_succ_insn = ctx->base.pc_next + 2;
         /*
-- 
2.40.1


