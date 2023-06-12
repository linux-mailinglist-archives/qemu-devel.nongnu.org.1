Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8172C29F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:12:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fRk-0001fO-Dh; Mon, 12 Jun 2023 07:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRh-0001dc-7m
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:49 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1q8fRf-0002NG-3l
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:10:48 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-977d0288fd2so709441566b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1686568245; x=1689160245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDxAjzmph+UEa8qklNFlGCNprQng00uTGl0gUn8QEQk=;
 b=ScvN58W0FAvPfjC8T+gSduiIrbVi1oJSdFhvoIrHcORDh0zuHe6v9XYGKDzvKtLzbM
 NoCmj8UcKd/VIw2UU5C+Udr0Y1VcOZ2rhO2j8DKE5Dw7hetjDf0MOM+JrRj0WpXWQTfF
 aoUtl9hInrHBTlrkZcoFO8m2D70+L17I9b3S+V83DG2Fvovn9+kKMys4pogvIEu2UyIW
 ioy8xBb0HKoaukUfUBcx5prqv/Sbv+NDbhWA6qFYP6NxpYrSZ6eJGxHDCOe/PTcdExYl
 TBGJ+DjDgF0p5QKUfbD8ZYy36qbIbm9zvAVQvBfMJiJfzH4nEFV+rieg3ogoUCOzlIcl
 83dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686568245; x=1689160245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDxAjzmph+UEa8qklNFlGCNprQng00uTGl0gUn8QEQk=;
 b=Yh1rLfdUdeZPkoeGG6s0+J8WufdXXvoodCEQkiFr28rjQMqRZbR2ZrJn8DKbJgGxLy
 1DLbiBHgm4MwuRHEhUVkBw6lYP6MTNseaFSQo49p1zcsyo2nZg7qQX1R+aempaa/6Ygx
 eBqciDze9bGa2iGfmdO+I1MGW/VINUxqTKJ5R5lFV+yftwD8swMFrHzqLJPDXYAP1ivK
 clKlOIX1n6CGgothxjSBK57mdcsFpBWTA5kmdA8qAHY9tAvIIQvd2zjZLopznVpfgvgU
 ijlIvduRP/jSNe539D4fN2KeU75K8Pc3rx+fPgr4TZSCbGSY8ey7pU/NRNxflF3Mbx/B
 LDDw==
X-Gm-Message-State: AC+VfDz7PM/UHQD11FRojge2kDGkIoxYoEhHIqdreZbyxWXwKmMpYH/E
 xZfD35Uf2X2KxmRZPWwAvcyQ7Q==
X-Google-Smtp-Source: ACHHUZ7TMCf7pfFU0/KtsqlaKLhgTXdEmW85n4omotgy2sI3vbLs/HuLQP5BTc+RzB1SRu09JTw4Lg==
X-Received: by 2002:a17:907:a01:b0:978:8ecd:fa6c with SMTP id
 bb1-20020a1709070a0100b009788ecdfa6cmr9496329ejc.34.1686568245208; 
 Mon, 12 Jun 2023 04:10:45 -0700 (PDT)
Received: from beast.fritz.box (62-178-148-172.cable.dynamic.surfer.at.
 [62.178.148.172]) by smtp.gmail.com with ESMTPSA id
 w23-20020a1709064a1700b00978723f594bsm5000948eju.101.2023.06.12.04.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 04:10:44 -0700 (PDT)
From: Christoph Muellner <christoph.muellner@vrull.eu>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhiwei Liu <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2 5/8] disas/riscv: Encapsulate opcode_data into decode
Date: Mon, 12 Jun 2023 13:10:31 +0200
Message-Id: <20230612111034.3955227-6-christoph.muellner@vrull.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
References: <20230612111034.3955227-1-christoph.muellner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ej1-x635.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
---
 disas/riscv.c |  9 ++++++++-
 disas/riscv.h | 33 +++++++++++++++++----------------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index b6ced2a26a..b6789ab92a 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1068,7 +1068,7 @@ static const rv_comp_data rvcp_fsgnjx_q[] = {
 
 /* instruction metadata */
 
-const rv_opcode_data opcode_data[] = {
+const rv_opcode_data rvi_opcode_data[] = {
     { "illegal", rv_codec_illegal, rv_fmt_none, NULL, 0, 0, 0 },
     { "lui", rv_codec_u, rv_fmt_rd_imm, NULL, 0, 0, 0 },
     { "auipc", rv_codec_u, rv_fmt_rd_offset, NULL, 0, 0, 0 },
@@ -3889,6 +3889,7 @@ static uint32_t operand_tbl_index(rv_inst inst)
 
 static void decode_inst_operands(rv_decode *dec, rv_isa isa)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     rv_inst inst = dec->inst;
     dec->codec = opcode_data[dec->op].codec;
     switch (dec->codec) {
@@ -4371,6 +4372,7 @@ static void append(char *s1, const char *s2, size_t n)
 
 static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     char tmp[64];
     const char *fmt;
 
@@ -4612,6 +4614,7 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
 
 static void decode_inst_lift_pseudo(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     const rv_comp_data *comp_data = opcode_data[dec->op].pseudo;
     if (!comp_data) {
         return;
@@ -4630,6 +4633,7 @@ static void decode_inst_lift_pseudo(rv_decode *dec)
 
 static void decode_inst_decompress_rv32(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv32;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4644,6 +4648,7 @@ static void decode_inst_decompress_rv32(rv_decode *dec)
 
 static void decode_inst_decompress_rv64(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv64;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4658,6 +4663,7 @@ static void decode_inst_decompress_rv64(rv_decode *dec)
 
 static void decode_inst_decompress_rv128(rv_decode *dec)
 {
+    const rv_opcode_data *opcode_data = dec->opcode_data;
     int decomp_op = opcode_data[dec->op].decomp_rv128;
     if (decomp_op != rv_op_illegal) {
         if ((opcode_data[dec->op].decomp_data & rvcd_imm_nz)
@@ -4694,6 +4700,7 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
+    dec.opcode_data = rvi_opcode_data;
     dec.cfg = cfg;
     decode_inst_opcode(&dec, isa);
     decode_inst_operands(&dec, isa);
diff --git a/disas/riscv.h b/disas/riscv.h
index debbe69239..460196510c 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -163,10 +163,27 @@ typedef enum {
 
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
     RISCVCPUConfig *cfg;
     uint64_t  pc;
     uint64_t  inst;
+    const rv_opcode_data *opcode_data;
     int32_t   imm;
     uint16_t  op;
     uint8_t   codec;
@@ -186,11 +203,6 @@ typedef struct {
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
@@ -199,17 +211,6 @@ enum {
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


