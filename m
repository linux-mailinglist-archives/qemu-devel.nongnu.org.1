Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E4870DBB5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 13:46:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1QS1-0003qc-Mm; Tue, 23 May 2023 07:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRt-0003qG-Mb
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:05 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tommy.wu@sifive.com>)
 id 1q1QRr-0001nC-4Z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 07:45:05 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6af8b25fc72so379545a34.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1684842301; x=1687434301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8tC9xHsp7YitbY3D29NZKggJ0khrtm4YaHoMYnX/PA=;
 b=aSb3zFNJwj/dZX83KePPa3UvuFmSozUeSTD9tWtMpX5vSAdiciGhzdAKznV9saAJHp
 Z9rtwzVHv7pgZC8pNidFqvEAWd7dtjwpMSyQEvaEm2aXQ9Uh3Bsrb6ersZC21RJbt3xt
 Kmk41fA5jMvzviD7vuSF/moLqgDVMaQ6i0dQtheYNLkFC9oV0nfSFzahTbr+jcCiI9eS
 ni5hzgO4oc76l/deznyG1o25h5cGDAWq651RigLYfFqDfGppCgd4Wlf32Y+GK6r4sfec
 GHLEnGGzjKRkynlE0vhdZqmpBvtySpkvoDrvBlHGDcl8/AM1vK+4Xar7LoDt8EIYZC0c
 t00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684842301; x=1687434301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8tC9xHsp7YitbY3D29NZKggJ0khrtm4YaHoMYnX/PA=;
 b=S52gT3H6taVoQiJHdfLBnHfwejWymswA42yWx2F164RORriu2mCzOsS3JQoAGIf62/
 HpBmzqXEbBeJatUvFIl5YipWweC4L5LgpMHdd5UAHQ6Ql9IymBX2ix6pzbXQKEywYTAI
 cAAlIxdFeJw+UzIV5/3Pm+iie1zBtfMB2P0t6KZ7H7/cGlZEHAvyavYZIT0ca5Chy55h
 bNPd7aIYoxruWPPpfNHyWOiMz0pNnbSk1p8/GK8ur3OHX92Yb2mk1ym/LCIPcNkzVpnt
 WntTScwi8BdyusW7kpxcJBeec7oaeZ77j98HRAqFrLQ6VQl2fbq4LYHg4aLmt/4hU2/h
 DdWQ==
X-Gm-Message-State: AC+VfDwJi1GeJdsw2R7xJAThTicUmBcy5ZIa00HrnIMtMOAshmzfS9eF
 v+fTVosLRVMtN/t8spedNaVLqhl9QtQKPCCAXi/SpcKAPajhEsMZ+eDR6JVAhENTygXGjk7Dm3r
 6zLCvATNa7z6I6DiK3nuTDComnZiGPH2xSTM73Orl5KttGJhsHpgAra2uI4eDzNm4wvsG96ADWn
 T2
X-Google-Smtp-Source: ACHHUZ6826BhCXA4vNOE8Xuwwg9Gh5yj0TlzvOpDCK1599c30smyt2l1mHK59CfjkxWYtA8qm66rtw==
X-Received: by 2002:a05:6808:b0b:b0:398:1849:ea55 with SMTP id
 s11-20020a0568080b0b00b003981849ea55mr2182645oij.50.1684842300743; 
 Tue, 23 May 2023 04:45:00 -0700 (PDT)
Received: from sw05.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id
 e3-20020acab503000000b003924c15cf58sm3799772oif.20.2023.05.23.04.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 04:45:00 -0700 (PDT)
From: Tommy Wu <tommy.wu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: frank.chang@sifive.com, alistair.francis@wdc.com, apatel@ventanamicro.com,
 palmer@rivosinc.com, dbarboza@ventanamicro.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 Tommy Wu <tommy.wu@sifive.com>
Subject: [PATCH 1/2] target/riscv: Add a function to refresh the dynamic CSRs
 xml.
Date: Tue, 23 May 2023 04:44:53 -0700
Message-Id: <20230523114454.717708-2-tommy.wu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230523114454.717708-1-tommy.wu@sifive.com>
References: <20230523114454.717708-1-tommy.wu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=tommy.wu@sifive.com; helo=mail-ot1-x329.google.com
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

When we change the cpu extension state after the cpu is
realized, we cannot print the value of some CSRs in the remote
gdb debugger. The root cause is that the dynamic CSR xml is
generated when the cpu is realized.

This patch add a function to refresh the dynamic CSR xml after
the cpu is realized.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/cpu.h     |  2 ++
 target/riscv/gdbstub.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..dc8e592275 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -494,6 +494,7 @@ struct ArchCPU {
     CPUNegativeOffsetState neg;
     CPURISCVState env;
 
+    int dyn_csr_base_reg;
     char *dyn_csr_xml;
     char *dyn_vreg_xml;
 
@@ -781,6 +782,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
 void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
 
 void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
+void riscv_refresh_dynamic_csr_xml(CPUState *cs);
 
 uint8_t satp_mode_max_from_map(uint32_t map);
 const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index 524bede865..9e97ee2c35 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -230,6 +230,8 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, int base_reg)
         bitsize = 64;
     }
 
+    cpu->dyn_csr_base_reg = base_reg;
+
     g_string_printf(s, "<?xml version=\"1.0\"?>");
     g_string_append_printf(s, "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">");
     g_string_append_printf(s, "<feature name=\"org.gnu.gdb.riscv.csr\">");
@@ -349,3 +351,13 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
                                  "riscv-csr.xml", 0);
     }
 }
+
+void riscv_refresh_dynamic_csr_xml(CPUState *cs)
+{
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    if (!cpu->dyn_csr_xml) {
+        g_assert_not_reached();
+    }
+    g_free(cpu->dyn_csr_xml);
+    riscv_gen_dynamic_csr_xml(cs, cpu->dyn_csr_base_reg);
+}
-- 
2.38.1


