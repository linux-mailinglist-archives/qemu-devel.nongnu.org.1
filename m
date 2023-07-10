Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6A374D583
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4V-00008v-Vm; Mon, 10 Jul 2023 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4M-0008NC-AO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:46 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4H-0002tH-B6
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:46 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-666fb8b1bc8so3909666b3a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992357; x=1691584357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/UdlzAzrJ3l5zsTGZxLuLsDRASFQg2Kqo/9Qgy3UBAg=;
 b=ctWruDa+6xt3aQ2ziG4ULYZKB5d81/Qdo+0ZwruCDo49wP14sMxC6q0kSTA8SkXjmH
 zr8cjpdL+ffOcTbso+e8BSpd3grAHmqIhRglUPKPMA0fLM0Sv3e28BxlPjzoIYUb1w8f
 2BQVbaLbxcWuoBoTw1fknAwMBvRa4RYM3Ve8i51Vn32mo3UucFmi2HsLLjlpVSrS0xUX
 Hiee24n63xj22weN3O5JpBtpGHOrYf/nKK6/5cQ1ElpXZDFaKPNiHG0V9ZJPkV04+GGn
 kZPb5bj264iXH+7dScTIkpNQoD10692vuZCrOoLpe+u8jCcAHPz/xF/tqYEhE2PqJaHF
 vRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992357; x=1691584357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UdlzAzrJ3l5zsTGZxLuLsDRASFQg2Kqo/9Qgy3UBAg=;
 b=NdK7lcElRGJ2PfU4CFcjdQmESr4Tec4i3Bo9zB3t0fowZecWeSRPxRba/0yZxtumrm
 c7/vkdk0fTcFF+tD2lGOA8CiKp4OZ/nF8OZzB1EYGCAmFhjpESO3wGhzF/D90ewjpSfa
 hA2JZnfB5G/cNQKgDxn+U1As3VlCYPOz0xJW7Mtei7ARBGkzJt05fzal2d0aIC9v77yg
 owaaB//0ey26xj56+Igo0rn7hqjgZJDtAzhhyjtGf52Hf4IuroPpzi6AS2Of9MnxwKbF
 /7uR7dHw7mK0aXjuXM2dcc0Ds9Zs/HisSVmfWlptw/zCZkQPTEDzc24m3Ofoa6VyaxA1
 WStA==
X-Gm-Message-State: ABy/qLb8t8OgovvcechLbnTqavj4ngY67UqUuey1jP/F3T5b1ciN+ziR
 /RDSlYCE7QYYhtkGkWTnm20Y3dKXRno3sg==
X-Google-Smtp-Source: APBJJlFReT/PtaRb2mENYukOsxls5FgiKM7yTSKFLTPZSBEa+WcySXdc2xpFApP2U8Bayj3KX4eUWw==
X-Received: by 2002:a05:6a20:3259:b0:12e:4d86:c017 with SMTP id
 hm25-20020a056a20325900b0012e4d86c017mr13284795pzc.10.1688992356822; 
 Mon, 10 Jul 2023 05:32:36 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:36 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 05/54] disas/riscv: Encapsulate opcode_data into decode
Date: Mon, 10 Jul 2023 22:31:16 +1000
Message-Id: <20230710123205.2441106-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42d.google.com
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
Message-Id: <20230612111034.3955227-6-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h | 33 +++++++++++++++++----------------
 disas/riscv.c |  9 ++++++++-
 2 files changed, 25 insertions(+), 17 deletions(-)

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
-- 
2.40.1


