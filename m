Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE972F1F1
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:31:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEs-0003le-4z; Tue, 13 Jun 2023 21:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEX-0003Wt-SZ
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FET-0004v1-Bf
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-665a16cdd97so2387639b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705812; x=1689297812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+2cr5EyNXnuafD0Gc+fnnrkciSJH26YXDV7jxG7V+Q=;
 b=njFGM+m6T5+iM1APT2KUP4W8svltyLKRljZ8gW80aOifFcQAxziRUZpC68nzEjDoJ5
 pVBrB54YV2uoC2rmL3HDfwOOrBl4J/QLXGqyy/gUYdRW1P5IWeec4AH+IeKIASojVlkO
 HnEsXMHailuYIwHXWICRDVc08Hs96fNu5gAP1L63hSif7RVtW80aXse5CsouA7d/HTSp
 MVZ+/FIuKzbNnsWCBFaJv9w+jR2ewmk5+JPTsCWAHbFyMh1Jux8el2xSYQ9nn0VBTtl5
 unW2leubd8mxhYp6VHGUa24WJhcSbV7pbGZH4GgVX++p3wKK8G38ssC2s6KBcnSz1Bwu
 +0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705812; x=1689297812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+2cr5EyNXnuafD0Gc+fnnrkciSJH26YXDV7jxG7V+Q=;
 b=OjvvfLtzTT8oZG2JsyCWSAzgoe8vezE6A7sTidK+ZkEM4/Hvg1kqBDR1OzGXA9f9BE
 8nWY+626tEyDivnWoZLWqj7u5HuYJodv08ta7JgdKfkCEL1MeyDDRYrj1Gv9RTd6uqDB
 pkS8ZmO+2dkmBARxlVRc9aMhhV6GkXdXOf5BGubWEzgCPBRwm9T7COpE7z1qtZttuzZy
 jb6RQ/2xTvr48ehwKsTOkHAAxVitGbZHPJ0ctjz+hoHW7VnvfSUEXbYeKwTFFN3laHik
 SimPRT6ibIrAzysQOjE4HEepgmYo4RmfHx4Geuh778FDmEhirDUVwLR394UWXlHruufd
 wZaA==
X-Gm-Message-State: AC+VfDzuAAptkSvzaMyZtwkAMznRrC2clMv73/U42Dj0I+69txQjGalS
 BFcvDXwUVO6TowHYdl/tsnCk3gchx9bf5g==
X-Google-Smtp-Source: ACHHUZ7d8tm1K5tMVryOf7KEf/vsAk6Bd6es9dFYb/sFn9Fkh8SYXjOXpg+kOdCTCEl9ewcox9ATGg==
X-Received: by 2002:a05:6a21:6da8:b0:10f:9bea:5a61 with SMTP id
 wl40-20020a056a216da800b0010f9bea5a61mr638209pzb.2.1686705811528; 
 Tue, 13 Jun 2023 18:23:31 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 44/60] disas/riscv.c: Remove redundant parentheses
Date: Wed, 14 Jun 2023 11:20:01 +1000
Message-Id: <20230614012017.3100663-45-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x433.google.com
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

Remove redundant parenthese and fix multi-line comments.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230523093539.203909-9-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 219 +++++++++++++++++++++++++-------------------------
 1 file changed, 110 insertions(+), 109 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bc433c4120..5005364aba 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -2390,9 +2390,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
     rv_opcode op = rv_op_illegal;
-    switch (((inst >> 0) & 0b11)) {
+    switch ((inst >> 0) & 0b11) {
     case 0:
-        switch (((inst >> 13) & 0b111)) {
+        switch ((inst >> 13) & 0b111) {
         case 0: op = rv_op_c_addi4spn; break;
         case 1:
             if (isa == rv128) {
@@ -2445,9 +2445,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         }
         break;
     case 1:
-        switch (((inst >> 13) & 0b111)) {
+        switch ((inst >> 13) & 0b111) {
         case 0:
-            switch (((inst >> 2) & 0b11111111111)) {
+            switch ((inst >> 2) & 0b11111111111) {
             case 0: op = rv_op_c_nop; break;
             default: op = rv_op_c_addi; break;
             }
@@ -2461,13 +2461,13 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 2: op = rv_op_c_li; break;
         case 3:
-            switch (((inst >> 7) & 0b11111)) {
+            switch ((inst >> 7) & 0b11111) {
             case 2: op = rv_op_c_addi16sp; break;
             default: op = rv_op_c_lui; break;
             }
             break;
         case 4:
-            switch (((inst >> 10) & 0b11)) {
+            switch ((inst >> 10) & 0b11) {
             case 0:
                 op = rv_op_c_srli;
                 break;
@@ -2504,7 +2504,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         }
         break;
     case 2:
-        switch (((inst >> 13) & 0b111)) {
+        switch ((inst >> 13) & 0b111) {
         case 0:
             op = rv_op_c_slli;
             break;
@@ -2524,17 +2524,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 4:
-            switch (((inst >> 12) & 0b1)) {
+            switch ((inst >> 12) & 0b1) {
             case 0:
-                switch (((inst >> 2) & 0b11111)) {
+                switch ((inst >> 2) & 0b11111) {
                 case 0: op = rv_op_c_jr; break;
                 default: op = rv_op_c_mv; break;
                 }
                 break;
             case 1:
-                switch (((inst >> 2) & 0b11111)) {
+                switch ((inst >> 2) & 0b11111) {
                 case 0:
-                    switch (((inst >> 7) & 0b11111)) {
+                    switch ((inst >> 7) & 0b11111) {
                     case 0: op = rv_op_c_ebreak; break;
                     default: op = rv_op_c_jalr; break;
                     }
@@ -2608,9 +2608,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
         }
         break;
     case 3:
-        switch (((inst >> 2) & 0b11111)) {
+        switch ((inst >> 2) & 0b11111) {
         case 0:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_lb; break;
             case 1: op = rv_op_lh; break;
             case 2: op = rv_op_lw; break;
@@ -2622,17 +2622,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 1:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0:
-                switch (((inst >> 20) & 0b111111111111)) {
+                switch ((inst >> 20) & 0b111111111111) {
                 case 40: op = rv_op_vl1re8_v; break;
                 case 552: op = rv_op_vl2re8_v; break;
                 case 1576: op = rv_op_vl4re8_v; break;
                 case 3624: op = rv_op_vl8re8_v; break;
                 }
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vle8_v; break;
                     case 11: op = rv_op_vlm_v; break;
                     case 16: op = rv_op_vle8ff_v; break;
@@ -2647,15 +2647,15 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_fld; break;
             case 4: op = rv_op_flq; break;
             case 5:
-                switch (((inst >> 20) & 0b111111111111)) {
+                switch ((inst >> 20) & 0b111111111111) {
                 case 40: op = rv_op_vl1re16_v; break;
                 case 552: op = rv_op_vl2re16_v; break;
                 case 1576: op = rv_op_vl4re16_v; break;
                 case 3624: op = rv_op_vl8re16_v; break;
                 }
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vle16_v; break;
                     case 16: op = rv_op_vle16ff_v; break;
                     }
@@ -2666,15 +2666,15 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 6:
-                switch (((inst >> 20) & 0b111111111111)) {
+                switch ((inst >> 20) & 0b111111111111) {
                 case 40: op = rv_op_vl1re32_v; break;
                 case 552: op = rv_op_vl2re32_v; break;
                 case 1576: op = rv_op_vl4re32_v; break;
                 case 3624: op = rv_op_vl8re32_v; break;
                 }
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vle32_v; break;
                     case 16: op = rv_op_vle32ff_v; break;
                     }
@@ -2685,15 +2685,15 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 7:
-                switch (((inst >> 20) & 0b111111111111)) {
+                switch ((inst >> 20) & 0b111111111111) {
                 case 40: op = rv_op_vl1re64_v; break;
                 case 552: op = rv_op_vl2re64_v; break;
                 case 1576: op = rv_op_vl4re64_v; break;
                 case 3624: op = rv_op_vl8re64_v; break;
                 }
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vle64_v; break;
                     case 16: op = rv_op_vle64ff_v; break;
                     }
@@ -2706,25 +2706,25 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 3:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_fence; break;
             case 1: op = rv_op_fence_i; break;
             case 2: op = rv_op_lq; break;
             }
             break;
         case 4:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addi; break;
             case 1:
-                switch (((inst >> 27) & 0b11111)) {
+                switch ((inst >> 27) & 0b11111) {
                 case 0b00000: op = rv_op_slli; break;
                 case 0b00001:
-                    switch (((inst >> 20) & 0b1111111)) {
+                    switch ((inst >> 20) & 0b1111111) {
                     case 0b0001111: op = rv_op_zip; break;
                     }
                     break;
                 case 0b00010:
-                    switch (((inst >> 20) & 0b1111111)) {
+                    switch ((inst >> 20) & 0b1111111) {
                     case 0b0000000: op = rv_op_sha256sum0; break;
                     case 0b0000001: op = rv_op_sha256sum1; break;
                     case 0b0000010: op = rv_op_sha256sig0; break;
@@ -2739,7 +2739,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 case 0b00101: op = rv_op_bseti; break;
                 case 0b00110:
-                    switch (((inst >> 20) & 0b1111111)) {
+                    switch ((inst >> 20) & 0b1111111) {
                     case 0b0000000: op = rv_op_aes64im; break;
                     default:
                         if (((inst >> 24) & 0b0111) == 0b001) {
@@ -2751,7 +2751,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 0b01001: op = rv_op_bclri; break;
                 case 0b01101: op = rv_op_binvi; break;
                 case 0b01100:
-                    switch (((inst >> 20) & 0b1111111)) {
+                    switch ((inst >> 20) & 0b1111111) {
                     case 0b0000000: op = rv_op_clz; break;
                     case 0b0000001: op = rv_op_ctz; break;
                     case 0b0000010: op = rv_op_cpop; break;
@@ -2766,10 +2766,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_sltiu; break;
             case 4: op = rv_op_xori; break;
             case 5:
-                switch (((inst >> 27) & 0b11111)) {
+                switch ((inst >> 27) & 0b11111) {
                 case 0b00000: op = rv_op_srli; break;
                 case 0b00001:
-                    switch (((inst >> 20) & 0b1111111)) {
+                    switch ((inst >> 20) & 0b1111111) {
                     case 0b0001111: op = rv_op_unzip; break;
                     }
                     break;
@@ -2792,10 +2792,10 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             break;
         case 5: op = rv_op_auipc; break;
         case 6:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addiw; break;
             case 1:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_slliw; break;
                 case 2: op = rv_op_slli_uw; break;
                 case 24:
@@ -2808,7 +2808,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 5:
-                switch (((inst >> 25) & 0b1111111)) {
+                switch ((inst >> 25) & 0b1111111) {
                 case 0: op = rv_op_srliw; break;
                 case 32: op = rv_op_sraiw; break;
                 case 48: op = rv_op_roriw; break;
@@ -2817,7 +2817,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 8:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_sb; break;
             case 1: op = rv_op_sh; break;
             case 2: op = rv_op_sw; break;
@@ -2826,17 +2826,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 9:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0:
-                switch (((inst >> 20) & 0b111111111111)) {
+                switch ((inst >> 20) & 0b111111111111) {
                 case 40: op = rv_op_vs1r_v; break;
                 case 552: op = rv_op_vs2r_v; break;
                 case 1576: op = rv_op_vs4r_v; break;
                 case 3624: op = rv_op_vs8r_v; break;
                 }
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vse8_v; break;
                     case 11: op = rv_op_vsm_v; break;
                     }
@@ -2850,9 +2850,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 3: op = rv_op_fsd; break;
             case 4: op = rv_op_fsq; break;
             case 5:
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vse16_v; break;
                     }
                     break;
@@ -2862,9 +2862,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 6:
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vse32_v; break;
                     }
                     break;
@@ -2874,9 +2874,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 7:
-                switch (((inst >> 26) & 0b111)) {
+                switch ((inst >> 26) & 0b111) {
                 case 0:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: op = rv_op_vse64_v; break;
                     }
                     break;
@@ -2897,17 +2897,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 11: op = rv_op_amoswap_d; break;
             case 12: op = rv_op_amoswap_q; break;
             case 18:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_lr_w; break;
                 }
                 break;
             case 19:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_lr_d; break;
                 }
                 break;
             case 20:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_lr_q; break;
                 }
                 break;
@@ -3039,35 +3039,35 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 16:
-            switch (((inst >> 25) & 0b11)) {
+            switch ((inst >> 25) & 0b11) {
             case 0: op = rv_op_fmadd_s; break;
             case 1: op = rv_op_fmadd_d; break;
             case 3: op = rv_op_fmadd_q; break;
             }
             break;
         case 17:
-            switch (((inst >> 25) & 0b11)) {
+            switch ((inst >> 25) & 0b11) {
             case 0: op = rv_op_fmsub_s; break;
             case 1: op = rv_op_fmsub_d; break;
             case 3: op = rv_op_fmsub_q; break;
             }
             break;
         case 18:
-            switch (((inst >> 25) & 0b11)) {
+            switch ((inst >> 25) & 0b11) {
             case 0: op = rv_op_fnmsub_s; break;
             case 1: op = rv_op_fnmsub_d; break;
             case 3: op = rv_op_fnmsub_q; break;
             }
             break;
         case 19:
-            switch (((inst >> 25) & 0b11)) {
+            switch ((inst >> 25) & 0b11) {
             case 0: op = rv_op_fnmadd_s; break;
             case 1: op = rv_op_fnmadd_d; break;
             case 3: op = rv_op_fnmadd_q; break;
             }
             break;
         case 20:
-            switch (((inst >> 25) & 0b1111111)) {
+            switch ((inst >> 25) & 0b1111111) {
             case 0: op = rv_op_fadd_s; break;
             case 1: op = rv_op_fadd_d; break;
             case 3: op = rv_op_fadd_q; break;
@@ -3081,100 +3081,100 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 13: op = rv_op_fdiv_d; break;
             case 15: op = rv_op_fdiv_q; break;
             case 16:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fsgnj_s; break;
                 case 1: op = rv_op_fsgnjn_s; break;
                 case 2: op = rv_op_fsgnjx_s; break;
                 }
                 break;
             case 17:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fsgnj_d; break;
                 case 1: op = rv_op_fsgnjn_d; break;
                 case 2: op = rv_op_fsgnjx_d; break;
                 }
                 break;
             case 19:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fsgnj_q; break;
                 case 1: op = rv_op_fsgnjn_q; break;
                 case 2: op = rv_op_fsgnjx_q; break;
                 }
                 break;
             case 20:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_s; break;
                 case 1: op = rv_op_fmax_s; break;
                 }
                 break;
             case 21:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_d; break;
                 case 1: op = rv_op_fmax_d; break;
                 }
                 break;
             case 23:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fmin_q; break;
                 case 1: op = rv_op_fmax_q; break;
                 }
                 break;
             case 32:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 1: op = rv_op_fcvt_s_d; break;
                 case 3: op = rv_op_fcvt_s_q; break;
                 }
                 break;
             case 33:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_d_s; break;
                 case 3: op = rv_op_fcvt_d_q; break;
                 }
                 break;
             case 35:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_q_s; break;
                 case 1: op = rv_op_fcvt_q_d; break;
                 }
                 break;
             case 44:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fsqrt_s; break;
                 }
                 break;
             case 45:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fsqrt_d; break;
                 }
                 break;
             case 47:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fsqrt_q; break;
                 }
                 break;
             case 80:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fle_s; break;
                 case 1: op = rv_op_flt_s; break;
                 case 2: op = rv_op_feq_s; break;
                 }
                 break;
             case 81:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fle_d; break;
                 case 1: op = rv_op_flt_d; break;
                 case 2: op = rv_op_feq_d; break;
                 }
                 break;
             case 83:
-                switch (((inst >> 12) & 0b111)) {
+                switch ((inst >> 12) & 0b111) {
                 case 0: op = rv_op_fle_q; break;
                 case 1: op = rv_op_flt_q; break;
                 case 2: op = rv_op_feq_q; break;
                 }
                 break;
             case 96:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_w_s; break;
                 case 1: op = rv_op_fcvt_wu_s; break;
                 case 2: op = rv_op_fcvt_l_s; break;
@@ -3182,7 +3182,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 97:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_w_d; break;
                 case 1: op = rv_op_fcvt_wu_d; break;
                 case 2: op = rv_op_fcvt_l_d; break;
@@ -3190,7 +3190,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 99:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_w_q; break;
                 case 1: op = rv_op_fcvt_wu_q; break;
                 case 2: op = rv_op_fcvt_l_q; break;
@@ -3198,7 +3198,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 104:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_s_w; break;
                 case 1: op = rv_op_fcvt_s_wu; break;
                 case 2: op = rv_op_fcvt_s_l; break;
@@ -3206,7 +3206,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 105:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_d_w; break;
                 case 1: op = rv_op_fcvt_d_wu; break;
                 case 2: op = rv_op_fcvt_d_l; break;
@@ -3214,7 +3214,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 107:
-                switch (((inst >> 20) & 0b11111)) {
+                switch ((inst >> 20) & 0b11111) {
                 case 0: op = rv_op_fcvt_q_w; break;
                 case 1: op = rv_op_fcvt_q_wu; break;
                 case 2: op = rv_op_fcvt_q_l; break;
@@ -3263,9 +3263,9 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 21:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vadd_vv; break;
                 case 2: op = rv_op_vsub_vv; break;
                 case 4: op = rv_op_vminu_vv; break;
@@ -3320,7 +3320,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 1:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vfadd_vv; break;
                 case 1: op = rv_op_vfredusum_vs; break;
                 case 2: op = rv_op_vfsub_vv; break;
@@ -3333,12 +3333,12 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 9: op = rv_op_vfsgnjn_vv; break;
                 case 10: op = rv_op_vfsgnjx_vv; break;
                 case 16:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 0: if ((inst >> 25) & 1) op = rv_op_vfmv_f_s; break;
                     }
                     break;
                 case 18:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 0: op = rv_op_vfcvt_xu_f_v; break;
                     case 1: op = rv_op_vfcvt_x_f_v; break;
                     case 2: op = rv_op_vfcvt_f_xu_v; break;
@@ -3363,7 +3363,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                     break;
                 case 19:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 0: op = rv_op_vfsqrt_v; break;
                     case 4: op = rv_op_vfrsqrt7_v; break;
                     case 5: op = rv_op_vfrec7_v; break;
@@ -3398,7 +3398,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 2:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vredsum_vs; break;
                 case 1: op = rv_op_vredand_vs; break;
                 case 2: op = rv_op_vredor_vs; break;
@@ -3412,14 +3412,14 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 10: op = rv_op_vasubu_vv; break;
                 case 11: op = rv_op_vasub_vv; break;
                 case 16:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 0: if ((inst >> 25) & 1) op = rv_op_vmv_x_s; break;
                     case 16: op = rv_op_vcpop_m; break;
                     case 17: op = rv_op_vfirst_m; break;
                     }
                     break;
                 case 18:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 2: op = rv_op_vzext_vf8; break;
                     case 3: op = rv_op_vsext_vf8; break;
                     case 4: op = rv_op_vzext_vf4; break;
@@ -3429,7 +3429,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     }
                     break;
                 case 20:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 1: op = rv_op_vmsbf_m;  break;
                     case 2: op = rv_op_vmsof_m; break;
                     case 3: op = rv_op_vmsif_m; break;
@@ -3479,7 +3479,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 3:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vadd_vi; break;
                 case 3: op = rv_op_vrsub_vi; break;
                 case 9: op = rv_op_vand_vi; break;
@@ -3510,7 +3510,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 33: op = rv_op_vsadd_vi; break;
                 case 37: op = rv_op_vsll_vi; break;
                 case 39:
-                    switch (((inst >> 15) & 0b11111)) {
+                    switch ((inst >> 15) & 0b11111) {
                     case 0: op = rv_op_vmv1r_v; break;
                     case 1: op = rv_op_vmv2r_v; break;
                     case 3: op = rv_op_vmv4r_v; break;
@@ -3528,7 +3528,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 4:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vadd_vx; break;
                 case 2: op = rv_op_vsub_vx; break;
                 case 3: op = rv_op_vrsub_vx; break;
@@ -3585,7 +3585,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 5:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_vfadd_vf; break;
                 case 2: op = rv_op_vfsub_vf; break;
                 case 4: op = rv_op_vfmin_vf; break;
@@ -3596,7 +3596,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 14: op = rv_op_vfslide1up_vf; break;
                 case 15: op = rv_op_vfslide1down_vf; break;
                 case 16:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: if ((inst >> 25) & 1) op = rv_op_vfmv_s_f; break;
                     }
                     break;
@@ -3636,7 +3636,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 }
                 break;
             case 6:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 8: op = rv_op_vaaddu_vx; break;
                 case 9: op = rv_op_vaadd_vx; break;
                 case 10: op = rv_op_vasubu_vx; break;
@@ -3644,7 +3644,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 case 14: op = rv_op_vslide1up_vx; break;
                 case 15: op = rv_op_vslide1down_vx; break;
                 case 16:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 0: if ((inst >> 25) & 1) op = rv_op_vmv_s_x; break;
                     }
                     break;
@@ -3689,15 +3689,15 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 22:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_addid; break;
             case 1:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_sllid; break;
                 }
                 break;
             case 5:
-                switch (((inst >> 26) & 0b111111)) {
+                switch ((inst >> 26) & 0b111111) {
                 case 0: op = rv_op_srlid; break;
                 case 16: op = rv_op_sraid; break;
                 }
@@ -3705,7 +3705,7 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 24:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_beq; break;
             case 1: op = rv_op_bne; break;
             case 4: op = rv_op_blt; break;
@@ -3715,33 +3715,33 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             break;
         case 25:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_jalr; break;
             }
             break;
         case 27: op = rv_op_jal; break;
         case 28:
-            switch (((inst >> 12) & 0b111)) {
+            switch ((inst >> 12) & 0b111) {
             case 0:
                 switch (((inst >> 20) & 0b111111100000) |
                         ((inst >> 7) & 0b000000011111)) {
                 case 0:
-                    switch (((inst >> 15) & 0b1111111111)) {
+                    switch ((inst >> 15) & 0b1111111111) {
                     case 0: op = rv_op_ecall; break;
                     case 32: op = rv_op_ebreak; break;
                     case 64: op = rv_op_uret; break;
                     }
                     break;
                 case 256:
-                    switch (((inst >> 20) & 0b11111)) {
+                    switch ((inst >> 20) & 0b11111) {
                     case 2:
-                        switch (((inst >> 15) & 0b11111)) {
+                        switch ((inst >> 15) & 0b11111) {
                         case 0: op = rv_op_sret; break;
                         }
                         break;
                     case 4: op = rv_op_sfence_vm; break;
                     case 5:
-                        switch (((inst >> 15) & 0b11111)) {
+                        switch ((inst >> 15) & 0b11111) {
                         case 0: op = rv_op_wfi; break;
                         }
                         break;
@@ -3749,17 +3749,17 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 case 288: op = rv_op_sfence_vma; break;
                 case 512:
-                    switch (((inst >> 15) & 0b1111111111)) {
+                    switch ((inst >> 15) & 0b1111111111) {
                     case 64: op = rv_op_hret; break;
                     }
                     break;
                 case 768:
-                    switch (((inst >> 15) & 0b1111111111)) {
+                    switch ((inst >> 15) & 0b1111111111) {
                     case 64: op = rv_op_mret; break;
                     }
                     break;
                 case 1952:
-                    switch (((inst >> 15) & 0b1111111111)) {
+                    switch ((inst >> 15) & 0b1111111111) {
                     case 576: op = rv_op_dret; break;
                     }
                     break;
@@ -4611,7 +4611,8 @@ static size_t inst_length(rv_inst inst)
 {
     /* NOTE: supports maximum instruction size of 64-bits */
 
-    /* instruction length coding
+    /*
+     * instruction length coding
      *
      *      aa - 16 bit aa != 11
      *   bbb11 - 32 bit bbb != 111
-- 
2.40.1


