Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7972F1BC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEV-0003Jv-GD; Tue, 13 Jun 2023 21:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE8-0002EN-Nz
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE6-0004rG-96
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6664e4d8fb4so105760b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705788; x=1689297788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iI4GIrDnuTGZUajNrH1JtZ0RZSx6pw3CyFK2KBQbGO0=;
 b=c00j+69OYXjpxUGmGluEMxRVDMYagLCjJPsHWuOz84PneKfoKAHkYEoROwObJoSNbk
 KIr5+LKhgf78qST5g5r5BumdqFJDmM1by8pRLCTej4hSc3c48TOXze5X9JQhi3I56Z19
 ZqUqcdleo3sd4gwAlyltST2BItcH4TsZ/i5LPZ84DxuGotaOCWcxjXa4EtOiY6FNH/dF
 abhKAxMio/Miym6VAa2YcHucqE5PEv71goLV2qubhk5R9FjZG8a8mivsdDSJQ8qYgem8
 mpqR+EQmdt3qHdXvzRUk/y088Gw0BEIB5dtRXOCiH0Y9Odk193gozU9HiU98m5hpZY6r
 boIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705788; x=1689297788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iI4GIrDnuTGZUajNrH1JtZ0RZSx6pw3CyFK2KBQbGO0=;
 b=j0x9OeGTymWaEmgMoslMswoj5C8Vu/DiS/NqDZA8YoAaN5aOoLAD3NuUs8UyGdLMrU
 e4UC1kg9hEqAZrDl++A0DWPqLOpXpnuILmjzaaN95hbYjTkO9m4LiiYREarC9ZSWEgOl
 chUIfYmfq+YITxtPNifXjK8wTCYCVfWDECXnC25mCK1vKTaLM/Wql5I+h4bmr+znPc+z
 KcIMhuC8jo8EcGV5MwYNM23QvD92gtjAlbDvOgwiOCiSekUYREXqBD7cE/hb7qQcDZPd
 VavKoM+QAjR5NOirpOgiM4F2lnq60YGB504txF6XTE31oMh5FR9tKnjq/ZbycgJ+Vx/6
 myhA==
X-Gm-Message-State: AC+VfDywyPErYrQ7UAVdt7d8p9mPwmwI1ybMSZu5I+5iH3N4om88sMho
 L9IutJ4Y61t1NscteOje1koWq2eBjTBRaQ==
X-Google-Smtp-Source: ACHHUZ7KsUrH3oQuyI6h1XG4r0rbDdHj6uxYoCO5JvQI40lYM99isUZTiRFkGbJUruUoNDcu//RM9g==
X-Received: by 2002:a05:6a00:23d6:b0:663:18c:a176 with SMTP id
 g22-20020a056a0023d600b00663018ca176mr365733pfc.32.1686705788333; 
 Tue, 13 Jun 2023 18:23:08 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:07 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 39/60] target/riscv: Pass RISCVCPUConfig as target_info to
 disassemble_info
Date: Wed, 14 Jun 2023 11:19:56 +1000
Message-Id: <20230614012017.3100663-40-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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

Pass RISCVCPUConfig as disassemble_info.target_info to support disas
of conflict instructions related to specific extensions.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-4-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c      | 10 +++++++---
 target/riscv/cpu.c |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d597161d46..f2dd5fd531 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "disas/dis-asm.h"
-
+#include "target/riscv/cpu_cfg.h"
 
 /* types */
 
@@ -969,6 +969,7 @@ typedef enum {
 /* structures */
 
 typedef struct {
+    RISCVCPUConfig *cfg;
     uint64_t  pc;
     uint64_t  inst;
     int32_t   imm;
@@ -4861,11 +4862,13 @@ static void decode_inst_decompress(rv_decode *dec, rv_isa isa)
 /* disassemble instruction */
 
 static void
-disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst)
+disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
+            RISCVCPUConfig *cfg)
 {
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
+    dec.cfg = cfg;
     decode_inst_opcode(&dec, isa);
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
@@ -4920,7 +4923,8 @@ print_insn_riscv(bfd_vma memaddr, struct disassemble_info *info, rv_isa isa)
         break;
     }
 
-    disasm_inst(buf, sizeof(buf), isa, memaddr, inst);
+    disasm_inst(buf, sizeof(buf), isa, memaddr, inst,
+                (RISCVCPUConfig *)info->target_info);
     (*info->fprintf_func)(info->stream, "%s", buf);
 
     return len;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d23b4c4d16..938c7bd87b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -849,6 +849,7 @@ static void riscv_cpu_reset_hold(Object *obj)
 static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 {
     RISCVCPU *cpu = RISCV_CPU(s);
+    info->target_info = &cpu->cfg;
 
     switch (riscv_cpu_mxl(&cpu->env)) {
     case MXL_RV32:
-- 
2.40.1


