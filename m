Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6B874D588
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:33:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq4b-0000GB-R8; Mon, 10 Jul 2023 08:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4N-0008TJ-EG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:47 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4K-0002yy-DU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:32:47 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-563439ea4a2so3109958eaf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992360; x=1691584360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9P8qx+1uFw5tUq4aTdGQKaVSrAL369V4RguW7Aqapy0=;
 b=BQNtSulm00nbg9BITnnHUTjpS0RBfbUNyvg66UlUL7DGJWTEqNO6J7DvL4QJub65Ep
 1Rl7CGCmR6ohMwHLy8FWdzqhncO//6Mf1g15G+kActjK+ZUsosAb9fFcS3VpB8rLjYDA
 sPKjDdfJDYCHZKGL/CwMvZncaD2ayIAeHDRMranWmx5PGoC9PCpXcSsPpl1Glv0/FbJq
 WZ4S6xOpiENffymP24E2yP6tBxuw43WmHreMIvZdVlhAfMpm6uQ9K4lwEfhucDvulNcB
 whfknO1isMxOmmkIlMJN2wV3vDsRevobToedqdEyFx8E/Os/4gUqDxdFgqqOtlSVLt/6
 zyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992360; x=1691584360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9P8qx+1uFw5tUq4aTdGQKaVSrAL369V4RguW7Aqapy0=;
 b=G4DU306++8TVO1mckq+rMqjQ4yV1ZoYUZ4lg+cAz5YenPTyf6bwJ/21lWVzE+W3RqJ
 0bIgCEL2GtSfbPf6pfRGhBsDH4ab5kPVffCTnUZppShrvjsh4gcvWiCOb+GKboI4bzDQ
 xnVVN7jDs8DZTjky2VTmuRXjEo0epdQPshuDrP+4/DJfjL4QcdPl4LKt7JpIv+Yqalzp
 eB0uRPTYoMBSSSFizqIenIDneArcgPUYHSrRhjo1siDW5wunOP3aWR3e/4xcV99Pw7se
 HRWNOgwycauB3BPXjT6FcsktXiDdTJUlJbEnj7zjerujiyI1qV/uvcsw63OENV4w7Zi3
 4PQg==
X-Gm-Message-State: ABy/qLbuFHOV/sDShM8q4NWphvY5wZxfFpBvh9WuRdrsUm1pqtxPvRCY
 NKHdg2gfEqlVm/nVb6t7DW9TVTTOAWcPHw==
X-Google-Smtp-Source: APBJJlFJO7xE77sE8oOYemZYdvjU/eMbXP8/0Xo4a/IZ3uNCCc7j5imYVVxYWk7bpY0cQlg/OoPsIg==
X-Received: by 2002:a05:6358:7f18:b0:135:5da6:d303 with SMTP id
 p24-20020a0563587f1800b001355da6d303mr3955858rwn.5.1688992360110; 
 Mon, 10 Jul 2023 05:32:40 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:32:39 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Christoph=20M=C3=BCllner?= <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/54] disas/riscv: Provide infrastructure for vendor extensions
Date: Mon, 10 Jul 2023 22:31:17 +1000
Message-Id: <20230710123205.2441106-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc2c.google.com
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

A previous patch provides a pointer to the RISCVCPUConfig data.
Let's use this to add the necessary code for vendor extensions.
This patch does not change the current behaviour, but clearly
defines how vendor extension support can be added to the disassembler.

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
Message-Id: <20230612111034.3955227-7-christoph.muellner@vrull.eu>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index b6789ab92a..dc3bfb0123 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4700,9 +4700,33 @@ disasm_inst(char *buf, size_t buflen, rv_isa isa, uint64_t pc, rv_inst inst,
     rv_decode dec = { 0 };
     dec.pc = pc;
     dec.inst = inst;
-    dec.opcode_data = rvi_opcode_data;
     dec.cfg = cfg;
-    decode_inst_opcode(&dec, isa);
+
+    static const struct {
+        bool (*guard_func)(const RISCVCPUConfig *);
+        const rv_opcode_data *opcode_data;
+        void (*decode_func)(rv_decode *, rv_isa);
+    } decoders[] = {
+        { always_true_p, rvi_opcode_data, decode_inst_opcode },
+    };
+
+    for (size_t i = 0; i < ARRAY_SIZE(decoders); i++) {
+        bool (*guard_func)(const RISCVCPUConfig *) = decoders[i].guard_func;
+        const rv_opcode_data *opcode_data = decoders[i].opcode_data;
+        void (*decode_func)(rv_decode *, rv_isa) = decoders[i].decode_func;
+
+        if (guard_func(cfg)) {
+            dec.opcode_data = opcode_data;
+            decode_func(&dec, isa);
+            if (dec.op != rv_op_illegal)
+                break;
+        }
+    }
+
+    if (dec.op == rv_op_illegal) {
+        dec.opcode_data = rvi_opcode_data;
+    }
+
     decode_inst_operands(&dec, isa);
     decode_inst_decompress(&dec, isa);
     decode_inst_lift_pseudo(&dec);
-- 
2.40.1


