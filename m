Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE677161A0
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zGI-0002NC-Qh; Tue, 30 May 2023 09:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFc-0001zU-Bz
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:19:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q3zFW-0006rl-TC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:18:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c218so3889279a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1685452733; x=1688044733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4JG+UvG+41BIzc1S6ISddiKMWiG+0KNIMC/YVrL7n8=;
 b=XOiCGRpLEFRb29F1MR/0cBHKw3nO/uA8ovE4QuhGTr7uPkyzTiYK0QvabhL54Y8lr6
 UaSvxVatkbv6ptK8ojtNlBL2TSHq7zqGHQ6ZsSNCpa108htnQZtjICf71wNl5VsMLywc
 8ukJGnik61Ofe05u8xaYKN5ZSuzm1WAk8zdSNFgHq+9jw/gmO+7yHGb09YPacGG6oWl7
 BOPlt47/RPGsV6czIxvb6WbulZE9g75QafMGrYge9rxgqnEH0J9ZAV29pFX70MdhPBz0
 DtXlPSmELwiUi0QX3AAhbE5EpZ9P7J8nlSz7wcfwHUKiFodKWWZUdYfm07U1W0CxruMg
 kjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685452733; x=1688044733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4JG+UvG+41BIzc1S6ISddiKMWiG+0KNIMC/YVrL7n8=;
 b=iDyjU3HjZ7oILBlXAu0MJbZrbV7i5eJB/EuXKH91J+cDVfc6TkG0mp+jhFMBfIpWtw
 YHrciN9usYcSIDlkqWaJlOJTOpB+qZ1GSAxnKG9y0soFRdoT2auuaDPkNvEg5G5Ys9sC
 PPCZrSJVyab1zTPPX+zeSW3l7HlAPL4qY52lfU2YmoJ0uj9+25hOKGwhQQCdL50yb06u
 tyYa6JHhNV/QjVW8dJGox95w4q/p3CwvC1I6ZoLpD8wbGJHQHeE2U9+GWTB1WAxToPrR
 +JHdLVqCJRFmBu7Boo81iIVTYabTWkSZCv+t5EUkS7xA3v8xt6KO3vcbplNaG8ytOHWN
 rCSA==
X-Gm-Message-State: AC+VfDyl9fyoNqr3hR1pl/XxG2kZNP02klsAR0rKj7sLeNw5I+KuvjB6
 OCGTtXVE/XEwR2csvOFt5HZHfQ==
X-Google-Smtp-Source: ACHHUZ5gStfWYN0ozHhoy2El7RZ02mvJU6GIPrypyP2bwtrQt2064QhFyjJKf9mMEKkKSu5CIzajtw==
X-Received: by 2002:a17:907:3e05:b0:967:dff4:e0f9 with SMTP id
 hp5-20020a1709073e0500b00967dff4e0f9mr2675354ejc.71.1685452733526; 
 Tue, 30 May 2023 06:18:53 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 le8-20020a170907170800b0096f803afbe3sm7376156ejc.66.2023.05.30.06.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:18:53 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 5/9] disas/riscv: Encapsulate opcode_data into decode
Date: Tue, 30 May 2023 15:18:39 +0200
Message-Id: <20230530131843.1186637-6-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
References: <20230530131843.1186637-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Christoph Müllner <christoph.muellner@vrull.eu>

This patch adds a reference to a struct rv_opcode_data object
into struct rv_decode. This further allows to remove all references
to the global variable opcode_data (which is renamed to rvi_opcode_data).

This patch does not introduce any functional change, but prepares
the code for more struct rv_opcode_data objects in the future.

This patch is based on previous work from Liu Zhiwei:
  https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg03662.html

Co-developed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/riscv.c |  9 ++++++++-
 disas/riscv.h | 33 +++++++++++++++++----------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 4cf477bc02..086edee6a2 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1055,7 +1055,7 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
 
 /* instruction metadata */
 
-const rv_opcode_data opcode_data[] = {
+const rv_opcode_data rvi_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "lui", rv_codec_u, rv_fmt_rd_imm, NULL, 0, 0, 0 },
     { "auipc", rv_codec_u, rv_fmt_rd_offset, NULL, 0, 0, 0 },
@@ -3803,6 +3803,7 @@ static uint32_t operand_tbl_index(rv_inst inst)
 
 static void decode_inst_operands(rv_decode *dec, rv_isa isa)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     rv_inst inst = dec->inst;
     dec->codec = opcode_data[dec->op].codec;
     switch (dec->codec) {
@@ -4284,6 +4285,7 @@ static void append(char *s1, const char *s2, size_t n)
 
 static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     char tmp[64];
     const char *fmt;
 
@@ -4517,6 +4519,7 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
 
 static void decode_inst_lift_pseudo(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     const rv_comp_data *comp_data = opcode_data[dec->op].pseudo;
     if (!comp_data) {
         return;
@@ -4535,6 +4538,7 @@ static void decode_inst_lift_pseudo(rv_decode *dec)
 
 static void decode_inst_decompress_rv32(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv32;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4549,6 +4553,7 @@ static void decode_inst_decompress_rv32(rv_decode *dec)
 
 static void decode_inst_decompress_rv64(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv64;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4563,6 +4568,7 @@ static void decode_inst_decompress_rv64(rv_decode *dec)
 
 static void decode_inst_decompress_rv128(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv128;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4598,6 +4604,7 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst)
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
+    dec.opcode_data = rvi_opcode_data;
     decode_inst_opcode(&dec, isa);
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
diff --git a/disas/riscv.h b/disas/riscv.h
index de2623e3cc..188f03feeb 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -162,9 +162,26 @@ typedef enum {
 
 /* structures */
 
+typedef struct {
+    const int op;
+    const rvc_constraint *constraints;
+} rv_comp_data;
+
+typedef struct {
+    const char * const name;
+    const rv_codec codec;
+    const char * const format;
+    const rv_comp_data *pseudo;
+    const short decomp_rv32;
+    const short decomp_rv64;
+    const short decomp_rv128;
+    const short decomp_data;
+} rv_opcode_data;
+
 typedef struct {
     uint64_t  pc;
     uint64_t  inst;
+    const rv_opcode_data *opcode_data;
     int32_t   imm;
     uint16_t  op;
     uint8_t   codec;
@@ -184,11 +201,6 @@ typedef struct {
     uint8_t   rlist;
 } rv_decode;
 
-typedef struct {
-    const int op;
-    const rvc_constraint *constraints;
-} rv_comp_data;
-
 enum {
     rv_op_illegal = 0
 };
@@ -197,17 +209,6 @@ enum {
     rvcd_imm_nz = 0x1
 };
 
-typedef struct {
-    const char * const name;
-    const rv_codec codec;
-    const char * const format;
-    const rv_comp_data *pseudo;
-    const short decomp_rv32;
-    const short decomp_rv64;
-    const short decomp_rv128;
-    const short decomp_data;
-} rv_opcode_data;
-
 /* instruction formats */
 
 #define rv_fmt_none                   "O\t"
-- 
2.40.1


