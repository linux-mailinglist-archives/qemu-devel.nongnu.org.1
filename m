Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A7571731B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:23:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYn-0004Sc-CT; Tue, 30 May 2023 21:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYl-0004Ko-08; Tue, 30 May 2023 21:23:31 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYh-0005FR-Sw; Tue, 30 May 2023 21:23:30 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-19f62a4924eso2178482fac.1; 
 Tue, 30 May 2023 18:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496206; x=1688088206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+X3vydu0Uw+LBNi8pjP23nCfoQFIcfwkLB/u/UJRyw=;
 b=dhNu2CQPUdWLh2ZWARijZNE5Lw8cRKNwst1qapcRUeh6N4QTL58IkmoEPhaiQ0vzl9
 sBEOGwheSOxJrZ0xkYx+j5Zjt8AiWiKQkEzcAv+i+8KQAHMWueR7TajxTljjEvY/5O59
 TtOtNHct2MUt59UdKGB358RkElxR/Yyz+Pzp4+4WzWBw7I2+bH1vcvFqQsTRn60kWTxr
 OxbnLfPXmPxoBlHy7LOnw4n2Nu1rjvqHB71bQi6GWdcgB4WC5nTG2/wGJn0wkziHDbn5
 1ORIf7ruSqVPH1gcPrY40p9+wVfpW7w+TlZuNY9fGX7N0PTcaDOt3aPXmnYXmRXrmBIT
 UJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496206; x=1688088206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+X3vydu0Uw+LBNi8pjP23nCfoQFIcfwkLB/u/UJRyw=;
 b=b6HKlRGoDb3Gpd1ef13IbNFQbLM88OTG/kMPV0eeScSa6/ixr2FtoDBKEJxW+4z4Zm
 EWSsTWZlacVjqTpCechJIyPl903HAVQ1A+Ao1WSLA7qtrJ0YtoWqmouyp0MFsF6Olv4J
 52n5zXhOZXP6aAqOUOcMOFmUhANOuSvvdkds8TzRivTBMe1Id9162EZE7Tg6fBP6SbFp
 OXKm7/DmAqSYEbhHi72dYMywVYeaPzXtf7d+cs8TmR/4Y+0FuDRN6V1MYq7W1LXfDQw4
 09CqvWyfTlhyFUGkLAvYl8RHrv8vUlAwmZr5dZB1wtBYVVmDAtgMFn50u/bnioHoNZZ2
 AUKQ==
X-Gm-Message-State: AC+VfDy1KWE79xxxrmIneXuc3gpMtxGF6KlijIHVI1elRzQaAZUrO523
 5gLWsptfN6ZgIdh0sS+5o1Q6rA8BRqM=
X-Google-Smtp-Source: ACHHUZ5oIovGmsmgVsMImxnN3l1DmRMAJijNI8/BYNvraefGaZFCpz8RlwGyb8K2QYusw72MFjYtxQ==
X-Received: by 2002:a05:6808:4da:b0:38e:9203:44eb with SMTP id
 a26-20020a05680804da00b0038e920344ebmr2135541oie.28.1685496205903; 
 Tue, 30 May 2023 18:23:25 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 1/5] target/ppc: gdbstub init spr gdb_id for all CPUs
Date: Wed, 31 May 2023 11:23:09 +1000
Message-Id: <20230531012313.19891-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Make sure each CPU gets its state set up for gdb, not just the ones
before PowerPCCPUClass has had its gdb state set up.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/gdbstub.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 63c9abe4f1..ca39efdc35 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -327,6 +327,25 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
     unsigned int num_regs = 0;
     int i;
 
+    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
+        ppc_spr_t *spr = &env->spr_cb[i];
+
+        if (!spr->name) {
+            continue;
+        }
+
+        /*
+         * GDB identifies registers based on the order they are
+         * presented in the XML. These ids will not match QEMU's
+         * representation (which follows the PowerISA).
+         *
+         * Store the position of the current register description so
+         * we can make the correspondence later.
+         */
+        spr->gdb_id = num_regs;
+        num_regs++;
+    }
+
     if (pcc->gdb_spr_xml) {
         return;
     }
@@ -348,17 +367,6 @@ void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
 
         g_string_append_printf(xml, " bitsize=\"%d\"", TARGET_LONG_BITS);
         g_string_append(xml, " group=\"spr\"/>");
-
-        /*
-         * GDB identifies registers based on the order they are
-         * presented in the XML. These ids will not match QEMU's
-         * representation (which follows the PowerISA).
-         *
-         * Store the position of the current register description so
-         * we can make the correspondence later.
-         */
-        spr->gdb_id = num_regs;
-        num_regs++;
     }
 
     g_string_append(xml, "</feature>");
-- 
2.40.1


