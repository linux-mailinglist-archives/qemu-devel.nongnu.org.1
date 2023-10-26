Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A4E7D85DE
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2AZ-0008Hw-Bx; Thu, 26 Oct 2023 11:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AT-0007ZU-OQ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:21:05 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AS-0006Sj-1G
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:21:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso930921b3a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333662; x=1698938462; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVqN7eZWpG4AFfm2fo+v1EIqXB/E7QYSqh6BXCl+vPo=;
 b=j1+5ULj4ZoPTQOiK5wXXr970Uz8DQgrIpnvrdc5U68AbaZyaqbKYCHhpFzTPB4fAla
 gNNMtAPOFJEiX7twy9FWUmqcPZ4WLGqhua+WHMUlC4KVpuPM2U5m/RpPBgFWXbMTeiRx
 P0/WymqB5az43nMIkz9XwESYBAGylTxQ9GV1hXEqTNuvMfpoF6e1RpHWoZBINkMb4Hbu
 ccb7x6+9eycsvm7UClrGx0+FczcjYaQUC563RFNqMTOWlh99W62HQzIZnGPcqe1/A13N
 nfabLho9E+luqFPHh9f0fW/KuaJxhhvExK+f5jQuDH6AQvmVQhGBb7aJR1FZHwpVWKEA
 LnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333662; x=1698938462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OVqN7eZWpG4AFfm2fo+v1EIqXB/E7QYSqh6BXCl+vPo=;
 b=u8tNA/HgLr1XnerpSnK4Zinj8VibwnslpMV5Pkr/Rm8CQ2ppoiwvuzV7RKZshSzsZ/
 nr490bDPhnpZSXxoknotKIISArWPpAyreEqptqssSMfq4CDUcqVcU62GNE+i8qVibdp5
 u2oW1OUTxhPFKDPNoNJ1Qy0Mga+dz929Fc3R1Tnbhw2WXEcMRtZbXKH3HsnwhA1m8Vgt
 EoKljGFH1Obtec/sxMrUju8xIquVNC4JwsHMAAUdVHsYulTIyWONZrwAoMvEypNTZlBT
 9uuOiQAQxkkwWbkryfw1qwgGSkkwbBXuVUHJ/Y1c0BidDjzeYeWD0HrDSoCWgIJ+qtLA
 yXew==
X-Gm-Message-State: AOJu0YzZrl5yoRkaTa0QOg5oNo5RaWRArk7P+zTyAVw6pRJQQP5nvVI5
 oF4+zK5pfwLD97J08fl9HIOG1ZclPLIALUpno+Gt0fP0Sx2M1g+VuWLqJ8UNSr13h7Jogywt2L+
 XFRuQVi8TVtINBq5KnqozaaqXAhGhzzzMcktDgR0Bv6e+ZaAuUWyPyqePYF7hU4fMTxMrKPvrPV
 6S
X-Google-Smtp-Source: AGHT+IERltKT/hxnR/RR4mhvTtUMtwJHNLQ4QKVxIKn01sOrCNWDMN2smK+Q/YWA8F6NvyEX9EvaMw==
X-Received: by 2002:a17:90a:1a43:b0:27d:12e1:94e0 with SMTP id
 3-20020a17090a1a4300b0027d12e194e0mr12614883pjl.36.1698333662188; 
 Thu, 26 Oct 2023 08:21:02 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:21:01 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2 14/14] disas/riscv: Replace TABs with space
Date: Thu, 26 Oct 2023 23:18:21 +0800
Message-Id: <20231026151828.754279-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replaces TABs with spaces, making sure to have a consistent coding style
of 4 space indentations.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7ea6ea050e9..e9458e574b9 100644
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
2.34.1


