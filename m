Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175A72F203
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEO-0002wy-4P; Tue, 13 Jun 2023 21:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE7-00024P-C4
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FE5-0004r0-0G
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-653436fcc1bso5131610b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705784; x=1689297784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8ePHsOimh1BTytRA0tkdWAJjdRi4CQxnKJPW06N0do=;
 b=Kf+ztXM6P9d3x1sXLBC8BDuz2tCy6ax0Zicj1Us4q5Nlfh3o2UA7dn5PHIqyq59tEu
 KaIUaMb/UIunra58RounJV8HDxBEofP4MV0YNb8UBJsGTctaAiDt4lDIo8yfT3msWE9U
 EWm6/hn7Lss5pv2fmAKXjXfYc7XmCTxTis7WM/ruS0k/QdPvsPo+vuMEd+PvglwBcHeQ
 K37vcQ9UAqYaFQx/kBBQLVA8wyk6XX0PIVF79GYqH2neECkxLyuKsuhPf99yz5pE3yxN
 se2fajrIb3dsUAhEViSiJrL4RDNWJbr8CqFpcYbvtiEsT5UqQCF5XjHEmwvjFMZBf7Dl
 o5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705784; x=1689297784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8ePHsOimh1BTytRA0tkdWAJjdRi4CQxnKJPW06N0do=;
 b=JNNVN6XWE9zu35Uu47CmRvtX46PzE9arYvaurgcTFIjpSmY8Jebx8oCzQ7Zzo8ThVi
 wmFUkqASYUZHBB0DCwJFWSvySuk0cUa4DmpgsTFXqhbFOwFEw2IFOSzG27n7DuxBO+E3
 49XoGT5pRvIdNizvs7REzswFUJRp3prt8FkE+92DA9zl1rrG6TXRbfxPubLOzPXFEeSL
 E84QFasUXQ77ersjvIMIVLRHYvnRPmthh++vcpVsG1AqoRtI4SfC+cSE6CShONEoLL1C
 oJAwDTU7ejIx6xGglQESg66kYeV7ItIEv8QvPCAgHkJaq8FKKE30bDhd+/n8Lp3g6/LS
 jfZQ==
X-Gm-Message-State: AC+VfDxV+XUKMiB8VAfPofBByhlTeX6cNs9MhNpFspi2+ut0Lm7pQYon
 yfQS+bBkVww3GvAkdN8PbZKzZ7znpV57nw==
X-Google-Smtp-Source: ACHHUZ4CP7ndbYUwxNIlnOjwoa2u+xGBbK9iiE8mFLBr+TKMraCPir6ReLa2bfGqLM/7cuyvvt9F6w==
X-Received: by 2002:a05:6a00:1708:b0:63b:8778:99e4 with SMTP id
 h8-20020a056a00170800b0063b877899e4mr540940pfc.2.1686705784418; 
 Tue, 13 Jun 2023 18:23:04 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:03 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 38/60] target/riscv: Split RISCVCPUConfig declarations from
 cpu.h into cpu_cfg.h
Date: Wed, 14 Jun 2023 11:19:55 +1000
Message-Id: <20230614012017.3100663-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Split RISCVCPUConfig declarations to prepare for passing it to disas.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-Id: <20230523093539.203909-3-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h     | 114 +---------------------------------
 target/riscv/cpu_cfg.h | 136 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 113 deletions(-)
 create mode 100644 target/riscv/cpu_cfg.h

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 1f39edc687..e3e08d315f 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -27,6 +27,7 @@
 #include "qom/object.h"
 #include "qemu/int128.h"
 #include "cpu_bits.h"
+#include "cpu_cfg.h"
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
 
@@ -370,119 +371,6 @@ struct CPUArchState {
     uint64_t kvm_timer_frequency;
 };
 
-/*
- * map is a 16-bit bitmap: the most significant set bit in map is the maximum
- * satp mode that is supported. It may be chosen by the user and must respect
- * what qemu implements (valid_1_10_32/64) and what the hw is capable of
- * (supported bitmap below).
- *
- * init is a 16-bit bitmap used to make sure the user selected a correct
- * configuration as per the specification.
- *
- * supported is a 16-bit bitmap used to reflect the hw capabilities.
- */
-typedef struct {
-    uint16_t map, init, supported;
-} RISCVSATPMap;
-
-struct RISCVCPUConfig {
-    bool ext_zba;
-    bool ext_zbb;
-    bool ext_zbc;
-    bool ext_zbkb;
-    bool ext_zbkc;
-    bool ext_zbkx;
-    bool ext_zbs;
-    bool ext_zca;
-    bool ext_zcb;
-    bool ext_zcd;
-    bool ext_zce;
-    bool ext_zcf;
-    bool ext_zcmp;
-    bool ext_zcmt;
-    bool ext_zk;
-    bool ext_zkn;
-    bool ext_zknd;
-    bool ext_zkne;
-    bool ext_zknh;
-    bool ext_zkr;
-    bool ext_zks;
-    bool ext_zksed;
-    bool ext_zksh;
-    bool ext_zkt;
-    bool ext_ifencei;
-    bool ext_icsr;
-    bool ext_icbom;
-    bool ext_icboz;
-    bool ext_zicond;
-    bool ext_zihintpause;
-    bool ext_smstateen;
-    bool ext_sstc;
-    bool ext_svadu;
-    bool ext_svinval;
-    bool ext_svnapot;
-    bool ext_svpbmt;
-    bool ext_zdinx;
-    bool ext_zawrs;
-    bool ext_zfh;
-    bool ext_zfhmin;
-    bool ext_zfinx;
-    bool ext_zhinx;
-    bool ext_zhinxmin;
-    bool ext_zve32f;
-    bool ext_zve64f;
-    bool ext_zve64d;
-    bool ext_zmmul;
-    bool ext_zvfh;
-    bool ext_zvfhmin;
-    bool ext_smaia;
-    bool ext_ssaia;
-    bool ext_sscofpmf;
-    bool rvv_ta_all_1s;
-    bool rvv_ma_all_1s;
-
-    uint32_t mvendorid;
-    uint64_t marchid;
-    uint64_t mimpid;
-
-    /* Vendor-specific custom extensions */
-    bool ext_xtheadba;
-    bool ext_xtheadbb;
-    bool ext_xtheadbs;
-    bool ext_xtheadcmo;
-    bool ext_xtheadcondmov;
-    bool ext_xtheadfmemidx;
-    bool ext_xtheadfmv;
-    bool ext_xtheadmac;
-    bool ext_xtheadmemidx;
-    bool ext_xtheadmempair;
-    bool ext_xtheadsync;
-    bool ext_XVentanaCondOps;
-
-    uint8_t pmu_num;
-    char *priv_spec;
-    char *user_spec;
-    char *bext_spec;
-    char *vext_spec;
-    uint16_t vlen;
-    uint16_t elen;
-    uint16_t cbom_blocksize;
-    uint16_t cboz_blocksize;
-    bool mmu;
-    bool pmp;
-    bool epmp;
-    bool debug;
-    bool misa_w;
-
-    bool short_isa_string;
-
-#ifndef CONFIG_USER_ONLY
-    RISCVSATPMap satp_mode;
-#endif
-};
-
-typedef struct RISCVCPUConfig RISCVCPUConfig;
-
 /*
  * RISCVCPU:
  * @env: #CPURISCVState
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
new file mode 100644
index 0000000000..c4a627d335
--- /dev/null
+++ b/target/riscv/cpu_cfg.h
@@ -0,0 +1,136 @@
+/*
+ * QEMU RISC-V CPU CFG
+ *
+ * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
+ * Copyright (c) 2017-2018 SiFive, Inc.
+ * Copyright (c) 2021-2023 PLCT Lab
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_CPU_CFG_H
+#define RISCV_CPU_CFG_H
+
+/*
+ * map is a 16-bit bitmap: the most significant set bit in map is the maximum
+ * satp mode that is supported. It may be chosen by the user and must respect
+ * what qemu implements (valid_1_10_32/64) and what the hw is capable of
+ * (supported bitmap below).
+ *
+ * init is a 16-bit bitmap used to make sure the user selected a correct
+ * configuration as per the specification.
+ *
+ * supported is a 16-bit bitmap used to reflect the hw capabilities.
+ */
+typedef struct {
+    uint16_t map, init, supported;
+} RISCVSATPMap;
+
+struct RISCVCPUConfig {
+    bool ext_zba;
+    bool ext_zbb;
+    bool ext_zbc;
+    bool ext_zbkb;
+    bool ext_zbkc;
+    bool ext_zbkx;
+    bool ext_zbs;
+    bool ext_zca;
+    bool ext_zcb;
+    bool ext_zcd;
+    bool ext_zce;
+    bool ext_zcf;
+    bool ext_zcmp;
+    bool ext_zcmt;
+    bool ext_zk;
+    bool ext_zkn;
+    bool ext_zknd;
+    bool ext_zkne;
+    bool ext_zknh;
+    bool ext_zkr;
+    bool ext_zks;
+    bool ext_zksed;
+    bool ext_zksh;
+    bool ext_zkt;
+    bool ext_ifencei;
+    bool ext_icsr;
+    bool ext_icbom;
+    bool ext_icboz;
+    bool ext_zicond;
+    bool ext_zihintpause;
+    bool ext_smstateen;
+    bool ext_sstc;
+    bool ext_svadu;
+    bool ext_svinval;
+    bool ext_svnapot;
+    bool ext_svpbmt;
+    bool ext_zdinx;
+    bool ext_zawrs;
+    bool ext_zfh;
+    bool ext_zfhmin;
+    bool ext_zfinx;
+    bool ext_zhinx;
+    bool ext_zhinxmin;
+    bool ext_zve32f;
+    bool ext_zve64f;
+    bool ext_zve64d;
+    bool ext_zmmul;
+    bool ext_zvfh;
+    bool ext_zvfhmin;
+    bool ext_smaia;
+    bool ext_ssaia;
+    bool ext_sscofpmf;
+    bool rvv_ta_all_1s;
+    bool rvv_ma_all_1s;
+
+    uint32_t mvendorid;
+    uint64_t marchid;
+    uint64_t mimpid;
+
+    /* Vendor-specific custom extensions */
+    bool ext_xtheadba;
+    bool ext_xtheadbb;
+    bool ext_xtheadbs;
+    bool ext_xtheadcmo;
+    bool ext_xtheadcondmov;
+    bool ext_xtheadfmemidx;
+    bool ext_xtheadfmv;
+    bool ext_xtheadmac;
+    bool ext_xtheadmemidx;
+    bool ext_xtheadmempair;
+    bool ext_xtheadsync;
+    bool ext_XVentanaCondOps;
+
+    uint8_t pmu_num;
+    char *priv_spec;
+    char *user_spec;
+    char *bext_spec;
+    char *vext_spec;
+    uint16_t vlen;
+    uint16_t elen;
+    uint16_t cbom_blocksize;
+    uint16_t cboz_blocksize;
+    bool mmu;
+    bool pmp;
+    bool epmp;
+    bool debug;
+    bool misa_w;
+
+    bool short_isa_string;
+
+#ifndef CONFIG_USER_ONLY
+    RISCVSATPMap satp_mode;
+#endif
+};
+
+typedef struct RISCVCPUConfig RISCVCPUConfig;
+#endif
-- 
2.40.1


